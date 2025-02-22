import MIL.Common
import Mathlib.Data.Real.Basic

namespace C02S04

section
variable (a b c d : ℝ)

#check (min_le_left a b : min a b ≤ a)
#check (min_le_right a b : min a b ≤ b)
#check (le_min : c ≤ a → c ≤ b → c ≤ min a b)

example : min a b = min b a := by
  apply le_antisymm
  · show min a b ≤ min b a
    apply le_min
    · apply min_le_right
    apply min_le_left
  · show min b a ≤ min a b
    apply le_min
    · apply min_le_right
    apply min_le_left

example : min a b = min b a := by
  have h : ∀ x y : ℝ, min x y ≤ min y x := by
    intro x y
    apply le_min
    apply min_le_right
    apply min_le_left
  apply le_antisymm
  apply h
  apply h

example : min a b = min b a := by
  apply le_antisymm
  repeat
    apply le_min
    apply min_le_right
    apply min_le_left

example : max a b = max b a := by
  apply le_antisymm
  . show a ⊔ b ≤ b ⊔ a
    apply max_le
    . show a ≤ b ⊔ a
      apply le_max_right
    . show b ≤ b ⊔ a
      apply le_max_left
  . show b ⊔ a ≤ a ⊔ b
    apply max_le
    . show b ≤ a ⊔ b
      apply le_max_right
    . show a ≤ a ⊔ b
      apply le_max_left


example : min (min a b) c = min a (min b c) := by
  apply le_antisymm
  . show a ⊓ b ⊓ c ≤ a ⊓ (b ⊓ c)
    apply le_min
    . show a ⊓ b ⊓ c ≤ a
      calc a ⊓ b ⊓ c ≤ a ⊓ b := by apply min_le_left
           _         ≤ a     := by apply min_le_left
    . show a ⊓ b ⊓ c ≤ b ⊓ c
      apply le_min
      . show a ⊓ b ⊓ c ≤ b
        calc a ⊓ b ⊓ c ≤ a ⊓ b := by apply min_le_left
           _         ≤ b       := by apply min_le_right
      . show a ⊓ b ⊓ c ≤ c
        apply min_le_right
  . show a ⊓ (b ⊓ c) ≤ a ⊓ b ⊓ c
    apply le_min
    . show a ⊓ (b ⊓ c) ≤ a ⊓ b
      apply le_min
      . show a ⊓ (b ⊓ c) ≤ a
        apply min_le_left
      . show a ⊓ (b ⊓ c) ≤ b
        calc a ⊓ (b ⊓ c) ≤ b ⊓ c := by apply min_le_right
             _           ≤ b     := by apply min_le_left
    . show a ⊓ (b ⊓ c) ≤ c
      calc a ⊓ (b ⊓ c) ≤ b ⊓ c := by apply min_le_right
           _           ≤ c     := by apply min_le_right

theorem aux : a ⊓ b + c ≤ (a + c) ⊓ (b + c) := by
  apply le_min
  . show a ⊓ b + c ≤ a + c
    apply add_le_add_right; apply min_le_left
  . show a ⊓ b + c ≤ b + c
    apply add_le_add_right; apply min_le_right

example : min a b + c = min (a + c) (b + c) := by
  apply le_antisymm
  . show a ⊓ b + c ≤ (a + c) ⊓ (b + c)
    apply aux
  . show (a + c) ⊓ (b + c) ≤ a ⊓ b + c
    have h₁ := aux (a + c) (b + c) (-c)
    rw [← neg_add_cancel_right ((a + c) ⊓ (b + c)) c]
    show (a + c) ⊓ (b + c) + (-c) + c ≤ a ⊓ b + c
    apply add_le_add_right
    repeat (rw [add_assoc, add_neg_cancel, add_zero] at h₁)
    exact h₁

#check (abs_add : ∀ a b : ℝ, |a + b| ≤ |a| + |b|)

#check add_sub_cancel_right

example (h : a ≤ c + b) : a - b ≤ c := by
  apply?

example (h : a ≤ b) : a - c ≤ b - c := by apply?

#check (sub_le_sub_right : a ≤ b → (c : ℝ) → a - c ≤ b - c)

#check sub_add_cancel
#check sub_le_sub

example : |a| - |b| ≤ |a - b| := by
  calc |a| - |b| = |a - b + b| - |b| := by rw [sub_add_cancel]
      _         ≤ |a - b| + |b| - |b| := by apply sub_le_sub_right; apply abs_add


end

section
variable (w x y z : ℕ)

example (h₀ : x ∣ y) (h₁ : y ∣ z) : x ∣ z :=
  dvd_trans h₀ h₁

example : x ∣ y * x * z := by
  apply dvd_mul_of_dvd_left
  apply dvd_mul_left

example : x ∣ x ^ 2 := by
  apply dvd_mul_left

example (h : x ∣ w) : x ∣ y * (x * z) + x ^ 2 + w ^ 2 := by
  sorry
end

section
variable (m n : ℕ)

#check (Nat.gcd_zero_right n : Nat.gcd n 0 = n)
#check (Nat.gcd_zero_left n : Nat.gcd 0 n = n)
#check (Nat.lcm_zero_right n : Nat.lcm n 0 = 0)
#check (Nat.lcm_zero_left n : Nat.lcm 0 n = 0)

example : Nat.gcd m n = Nat.gcd n m := by
  sorry
end
