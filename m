Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015803955DC
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785596199; cv=pass; b=EAvLcC/vt80wsUevCoSg4ssMwjpVQpWtKe+6oGZ7LT1DVif9J+GUFptHtlJbgKjpWR7QJ4HYD/aoG+X9IzYi8cEHJHtFPFEB+WQ7UXt0FTEQaAxRcHtCUnJfF7tR6cQ2mcaPp70rHjDqdprHsnujhaYcz5u0lrvY+FscFxTXIhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785596199; c=relaxed/simple;
	bh=0AiQGqxS76V11GK1ycH4BPiMmcZ9zuarlnkEnBuWHT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBXfmbQd+0SZB2HRc13uDl5m6hedCapFP16dBNaXzIHzCjSFVnuw3YRCktUCPjnrKZKFD+xq35Ae/wS9w1G2YKstFc1q0dm9EGt67aJrf5H41vl3qPAn75aDoczpkyyV0fkUKZuf71ZBURXKL94w0/1NlBiUjeXZNFTn1qHrMzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FovzJmqx; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FovzJmqx"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cace91f112so21529835ad.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 07:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785596196; cv=none;
        d=google.com; s=arc-20260327;
        b=bOa3u0Fz2ya41pcXRPdxfkDTQTboiiUiDTDGOLWRC5W2nz90FHtqQh5+HbU+7B0PyX
         ZPWEtSgBcHjRrlrA3FBG8I9f1v0HfMGpEOrSIuZesN3ABST5CjShCP98HVjwlcL7pN+0
         h2K9hj11Pp1qu4mfguooGskH8j/ifMSZOGaU/eoIIm96IMfWwc7XeJuxiTnAYFFshccG
         bPJBiLfx6Ggt2Eoyd2ytotxBry48KpG/3qvwmAj7OPDoX7Evw4YYdbFJJfO9PQMILH+X
         fVzzsd+77E1Q+/1NGJY4kmjJLG7Ml7kY5P7NL66pBTQH6kl9hqJYKiOfeQSqU4AuViVj
         C4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fvv22HV4om9e1w+fOP4BjTCJBhtaebp9IoveSSnwuu8=;
        fh=H7rpld51u3juyHkiS6Vt5/67Qa2EJsB7FY7MkiGhQJ8=;
        b=nTFwLuCbzR4057XLVNsf/s54fmojDLK3Dzii5t9XZJYyl5/Y7QeJYmXxd+hzu7jJuv
         CVDIyvPX4OIpoT+ceq9V3asms7JL9nVBVy2a/6+JPMdNvmIMHkAFFUz4GvY5N/7Lxsm0
         Ho9RBFULTyE8MO7F8rLApcASfvbVXeztLWoW0Ynh4W/A3KqYwYhrNrtldKdRLMlpDJ9Q
         bGpQQViKePMnWUfprf0z+uPVPKe4rb+7DU7scoUUIcAnqXvh1Z3EG2QMw2bqx+3UGNnh
         ky5s8CR7cjWK6UpxxeqGjxCXiEM/7Ve1HzNcLAfH1RXc37InlsOcRfaicNcGewBVKTut
         GIYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785596196; x=1786200996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fvv22HV4om9e1w+fOP4BjTCJBhtaebp9IoveSSnwuu8=;
        b=FovzJmqxi4aEk/bpbkI/E7ybiylsS8PuqCyNAe/0ZzikFzHqPyUWZM80R49plM+ksM
         eEEzdSlK0Xi7mnkghe3PgubTznQNbIUkOQs244BT3gZ1UA/RgSmvY8mwY+9r60Fl+twS
         9ggaChCx9n7hqrKznbfh6juas4l115QL3hzgKyprJY5teacBasp14JXoplOSOl3wnWqF
         jWaUrZtkvnaWbHLf5nw3GHw3y7HeKUZw7DXMab22Ye77pwf/wHEYcLek+5TanwfAymP4
         7Y8QrQHy3/Om14Yt56NcCIMfPbYawYwuslKzfnShGVVoZNfyHGmdCpUyg6jSlS56x/Ko
         5NJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785596196; x=1786200996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fvv22HV4om9e1w+fOP4BjTCJBhtaebp9IoveSSnwuu8=;
        b=Lr8QacdMEa2qtpD4yHCIcM6dIdB3kErOjbAelik6jf7P36KlQxrW1z1678pbadDi7P
         kQUwXCtZdMNe/GZU07p/NNh6cYuNJ3drvt04KSoFt4iI29Jy3KJjWuM2yW4QQvRa8Tht
         yQzNXWwVaPu2KccUFuKZo3Ee0YcjtAqsdPyFYrrV6d9TsX9NBEm5b/gbvjUdBdBqbtv5
         F2XoeumyeMcv3h/BRiOdBX6apIpSdo4jQhZ9KrLRc0VimBKZqXDCemtt1iu+YZVu/8Dv
         IiVf37usoGp6NUgpm5bsZOeceBtDwro02D/eWTfZXe7FF5D7uprkPdbGge9CNboUm1De
         tkSA==
X-Gm-Message-State: AOJu0Yx9RIJrVv2vdA1Z+7H7V15bGdkwWII+A6SO8Pjk89EtlbDb3F5m
	uQ1enPGdo/P+1YeJu7IUk4jwTzdTzZiYNw5XGlw3+fG17/ZJLVpZjUxJhEWKYiOzauVAfdRlCjp
	qq/B50ZLb4kxVJs18bh1/aGZDAVuSsgY=
X-Gm-Gg: AR+sD10G+TAPYwwqSHMD6zjjqmeWX28eBfSBlQwTFzXhmvTNOgO71eFR56KdSmfrh2B
	i3ZUbwKizekV2ytJ71ZGdyh3REj3Nd+Vi1jTZMhPnNyLpEC4WojXt/1xC2zEzWrkTPOOok745xg
	NoBVl6BBW9vuSdWiP/mYueP5yymG6NqI864NWh9835FvNISuKtkjgWYegut6EQWyGb4YWxS+LMO
	TJoPuVPvAGvlHYPsBut8UegUQePuRMeAyRclGRp0Ab0/0On7W9u25VeJFRaG6MBcUYblr71zFtp
	Eq+p2o1zW9qp9uo083JO+GpP79rEeTAUou3vw9KZLLhjInWxrrlQi+4Pag==
X-Received: by 2002:a17:903:3810:b0:2ca:ed41:d331 with SMTP id
 d9443c01a7336-2d05247391cmr37120425ad.45.1785596195918; Sat, 01 Aug 2026
 07:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com> <20260731-static-zext-v2-5-da4aa161e8c5@gmail.com>
In-Reply-To: <20260731-static-zext-v2-5-da4aa161e8c5@gmail.com>
From: Min-gyu Kim <gimm78064@gmail.com>
Date: Sat, 1 Aug 2026 23:56:24 +0900
X-Gm-Features: AUfX_my61re-oqdLibdmw9vOIjH0OZ2fZcm1skbbaXHhzNjw0qAGKFQZmLyfBHQ
Message-ID: <CAGKGUvk1gRbwXgO8eB_5G=PYGiTNMa8=c=f8Yie-ZwABZny=Zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: verify zext_dst
 annotations for various instructions
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, iii@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Thank you for preparing the v2 patch series. I tested the static
upper/lower-half register-liveness fix on both the Linux v6.18.38 kernel
where I originally reproduced the unprivileged LPE and the current bpf-next
tree.

Tested code

The posted v2 series does not apply directly to v6.18.38 because the releva=
nt
liveness and instruction-fixup code is still located in
kernel/bpf/verifier.c. I made a functional backport of the security-relevan=
t
parts of the v2 approach to:

  e46dc0adfe39724bcf52cea47b8f9c9aed86a394
  (Linux v6.18.38)

The backport tracks the low and high 32-bit halves of each BPF register
separately, accounts for operand width when computing register liveness, an=
d
sets zext_dst when an instruction defines a 32-bit subregister whose upper
half is live afterwards:

  insn_aux[i].zext_dst =3D def32 >=3D 0 && (mask_hi(state[i].out) & BIT(def=
32));

For this functional backport, I retained the existing subreg_def-based logi=
c
as a conservative fallback. I did not include the disassembler cleanup, the
removal of subreg_def, or the new selftests from the full series. Only
kernel/bpf/verifier.c was modified.

I separately tested the complete v2 series without modifying the kernel
source. I fetched the exact PR head from the kernel-patches/bpf repository:

  repository: https://github.com/kernel-patches/bpf.git
  ref:        refs/pull/13063/head
  commit:     0e158243442b674793c44fad5b3436f22dc9d6d8

The official bpf-next master was
682b1c17f847b3cccbd9fb8427e8f6435bc18622 when I fetched the tree. The PR
head contains a CI-only metadata commit on that base, followed by the five
v2 commits ending in 0e158243442b. The tested source tree was clean.

Common test conditions

Both kernels were tested as s390x guests using new Debian trixie images. Th=
e
reported kernel versions were:

  Linux syzkaller 6.18.38-dirty #3 SMP s390x GNU/Linux
  Linux syzkaller 7.2.0-rc4-00687-g0e158243442b #2 SMP PREEMPT s390x

The exploit ran as uid 1000 with every capability set, including the
bounding set, cleared:

  CapInh: 0000000000000000
  CapPrm: 0000000000000000
  CapEff: 0000000000000000
  CapBnd: 0000000000000000
  CapAmb: 0000000000000000

The relevant runtime conditions were:

  kernel.unprivileged_bpf_disabled =3D 0
  net.core.bpf_jit_enable =3D 1
  CONFIG_BPF_JIT_ALWAYS_ON=3Dy

The BPF program was accepted, attached as a socket filter, and JIT-executed
in every valid run. The result was therefore not caused by verifier
rejection or interpreter fallback.

Exploit result

Before applying the fix, the v6.18.38 exploit read map->ops, derived the
kernel mapping offset, obtained arbitrary kernel read and write access,
located the current task and its credentials, and produced a root shell.

With the functional backport applied to v6.18.38, I ran the same unmodified
exploit ten times. Every run stopped before obtaining the array-map base,
task_struct, or cred pointer:

  [+] kaslr_slide=3D0xfffffffffeb906c0
  mutex wait-list self pointer mismatch

This value was not a disclosed kernel address. The zero extension caused th=
e
first read to remain at the beginning of the valid map value and return the
attacker-supplied delta instead:

  delta_ops =3D 32 - 304
            =3D -272
            =3D 0xfffffffffffffef0

  0xfffffffffffffef0 - 0x0146f830 =3D 0xfffffffffeb906c0

The complete v2 series on bpf-next produced the same fixed behavior. The
important difference was that the current kernel layout had changed:

  struct bpf_array.value:  296
  struct bpf_map.ops:       32
  array_map_ops link addr:  0x15c5e60

I therefore adjusted only BPF_ARRAY_VALUE_OFFSET and ARRAY_MAP_OPS_LINK in =
a
copy of the exploit. No BPF instructions or control flow were changed. If
the verifier/JIT mismatch had remained, the resulting offset would have
targeted map->ops in the current layout. Instead, every repetition returned
the known input value from the valid map value:

  delta_ops =3D 32 - 296
            =3D -264
            =3D 0xfffffffffffffef8

  0xfffffffffffffef8 - 0x15c5e60 =3D 0xfffffffffea3a098

A root-only check of /proc/kallsyms showed that the actual runtime
array_map_ops address was 0x000003ffff325e60. That address was not returned
by the exploit.

Thus, on both v6.18.38 with the functional backport and the complete v2
bpf-next tree, the required zero extension changed the attempted map->ops
OOB read into an in-bounds map-value read. The kernel address disclosure,
arbitrary read/write primitives, credential write, and privilege-escalation
stages were not reached. The exploit process remained uid 1000.

The kernel taint value remained zero after the tests. I found no BTF error,
BUG, WARNING, Oops, user process fault, kernel panic, timeout, or signal
termination in the valid runs.

Conclusion

The v6.18.38 functional backport and the complete v2 series both prevent th=
e
s390x verifier/JIT mismatch used by my exploit. The current-tree test also
confirms that the result is not an artifact of obsolete v6.18.38 structure
offsets, because its first attempted OOB read was adjusted to target the
current map->ops field precisely.

For this exact v2 series, please feel free to add:

  Tested-by: Min-gyu Kim <gimm78064@gmail.com>

For reference, the exact diff between unmodified v6.18.38 at
e46dc0adfe39724bcf52cea47b8f9c9aed86a394 and the functional backport tested
above is included after my signature. Its SHA-256 is:

  0962c511dfdc0a8bb21ce9f2fa4bb9be8f72c14ce022aa434cab892e52b58ef9

It is provided to make the stable-kernel test reproducible and is not
intended to supersede the complete v2 series for bpf-next.

Thank you for your time.

Thanks,
Min-gyu Kim

---
 kernel/bpf/verifier.c | 148 ++++++++++++++++++++++++++++++++++++----------=
----
 1 file changed, 106 insertions(+), 42 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3dcf591acd50..f243b41c771c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3771,15 +3771,15 @@ static int insn_def_regno(const struct bpf_insn *in=
sn)
  }
 }

-/* Return TRUE if INSN has defined any 32-bit value explicitly. */
-static bool insn_has_def32(struct bpf_insn *insn)
+/* Return the 32-bit subregister defined by INSN, or -1. */
+static int insn_def32(struct bpf_insn *insn)
 {
  int dst_reg =3D insn_def_regno(insn);

- if (dst_reg =3D=3D -1)
- return false;
+ if (dst_reg < 0 || is_reg64(insn, dst_reg, NULL, DST_OP))
+ return -1;

- return !is_reg64(insn, dst_reg, NULL, DST_OP);
+ return dst_reg;
 }

 static void mark_insn_zext(struct bpf_verifier_env *env,
@@ -17805,6 +17805,8 @@ static bool
verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 }

 struct call_summary {
+ const struct btf *btf;
+ const struct btf_type *func_proto;
  u8 num_params;
  bool is_void;
  bool fastcall;
@@ -17825,6 +17827,8 @@ static bool get_call_summary(struct
bpf_verifier_env *env, struct bpf_insn *call
  if (get_helper_proto(env, call->imm, &fn) < 0)
  /* error would be reported later */
  return false;
+ cs->btf =3D NULL;
+ cs->func_proto =3D NULL;
  cs->fastcall =3D fn->allow_fastcall &&
         (verifier_inlines_helper_call(env, call->imm) ||
  bpf_jit_inlines_helper_call(call->imm));
@@ -17845,6 +17849,8 @@ static bool get_call_summary(struct
bpf_verifier_env *env, struct bpf_insn *call
  if (err < 0)
  /* error would be reported later */
  return false;
+ cs->btf =3D meta.btf;
+ cs->func_proto =3D meta.func_proto;
  cs->num_params =3D btf_type_vlen(meta.func_proto);
  cs->fastcall =3D meta.kfunc_flags & KF_FASTCALL;
  cs->is_void =3D btf_type_is_void(btf_type_by_id(meta.btf,
meta.func_proto->type));
@@ -21044,7 +21050,7 @@ static void adjust_insn_aux_data(struct
bpf_verifier_env *env,
  * (cnt =3D=3D 1) is taken or not. There is no guarantee INSN at OFF is th=
e
  * original insn at old prog.
  */
- data[off].zext_dst =3D insn_has_def32(insn + off + cnt - 1);
+ data[off].zext_dst =3D insn_def32(insn + off + cnt - 1) >=3D 0;

  if (cnt =3D=3D 1)
  return;
@@ -21056,7 +21062,7 @@ static void adjust_insn_aux_data(struct
bpf_verifier_env *env,
  for (i =3D off; i < off + cnt - 1; i++) {
  /* Expand insni[off]'s seen count to the patched range. */
  data[i].seen =3D old_seen;
- data[i].zext_dst =3D insn_has_def32(insn + i);
+ data[i].zext_dst =3D insn_def32(insn + i) >=3D 0;
  }
 }

@@ -24423,29 +24429,70 @@ static int process_fd_array(struct
bpf_verifier_env *env, union bpf_attr *attr,

 /* Each field is a register bitmask */
 struct insn_live_regs {
- u16 use; /* registers read by instruction */
- u16 def; /* registers written by instruction */
- u16 in; /* registers that may be alive before instruction */
- u16 out; /* registers that may be alive after instruction */
+ u32 use; /* register halves read by instruction */
+ u32 def; /* register halves written by instruction */
+ u32 in; /* register halves that may be alive before instruction */
+ u32 out; /* register halves that may be alive after instruction */
 };

 /* Bitmask with 1s for all caller saved registers */
 #define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)

+static inline u32 reg32_mask(u32 n) { return BIT(n); }
+static inline u32 reg64_mask(u32 n) { return BIT(n) | BIT(n + 16); }
+static inline u32 mask_widen(u32 m) { return m | (m << 16); }
+static inline u16 mask_lo(u32 m) { return (u16)m; }
+static inline u16 mask_hi(u32 m) { return (u16)(m >> 16); }
+
+/* Infer use mask based on number and sizes of the function parameters. */
+static u32 call_use_mask(struct bpf_verifier_env *env, struct bpf_insn *in=
sn)
+{
+ u32 i, use, size, reg_params_num;
+ struct call_summary cs;
+ const struct btf_param *p;
+ const struct btf_type *t;
+
+ if (!get_call_summary(env, insn, &cs))
+ /* BPF-to-BPF calls conservatively use all 64 bits of each arg. */
+ return mask_widen(ALL_CALLER_SAVED_REGS & ~BIT(BPF_REG_0));
+
+ if (cs.func_proto) {
+ use =3D 0;
+ p =3D btf_params(cs.func_proto);
+ reg_params_num =3D min(btf_type_vlen(cs.func_proto),
+      MAX_BPF_FUNC_REG_ARGS);
+ for (i =3D 0; i < reg_params_num; i++) {
+ t =3D btf_type_by_id(cs.btf, p[i].type);
+ if (IS_ERR(btf_resolve_size(cs.btf, t, &size)))
+ goto fallback;
+ use |=3D size <=3D sizeof(u32) ? reg32_mask(i + 1) :
+        reg64_mask(i + 1);
+ }
+ return use;
+ }
+
+fallback:
+ /* By default assume that calls use all 64 bits of each parameter. */
+ return mask_widen(GENMASK(min_t(u8, cs.num_params,
+ MAX_BPF_FUNC_REG_ARGS), 1));
+}
+
 /* Compute info->{use,def} fields for the instruction */
 static void compute_insn_live_regs(struct bpf_verifier_env *env,
     struct bpf_insn *insn,
     struct insn_live_regs *info)
 {
- struct call_summary cs;
- u8 class =3D BPF_CLASS(insn->code);
- u8 code =3D BPF_OP(insn->code);
- u8 mode =3D BPF_MODE(insn->code);
- u16 src =3D BIT(insn->src_reg);
- u16 dst =3D BIT(insn->dst_reg);
- u16 r0  =3D BIT(0);
- u16 def =3D 0;
- u16 use =3D 0xffff;
+ const u8 class =3D BPF_CLASS(insn->code);
+ const u8 code =3D BPF_OP(insn->code);
+ const u8 mode =3D BPF_MODE(insn->code);
+ const u8 size =3D BPF_SIZE(insn->code);
+ const u32 src =3D reg64_mask(insn->src_reg);
+ const u32 dst =3D reg64_mask(insn->dst_reg);
+ const u32 src32 =3D mask_lo(src);
+ const u32 dst32 =3D mask_lo(dst);
+ const u32 r0 =3D reg64_mask(0);
+ u32 def =3D 0;
+ u32 use =3D U32_MAX;

  switch (class) {
  case BPF_LD:
@@ -24456,8 +24503,8 @@ static void compute_insn_live_regs(struct
bpf_verifier_env *env,
  use =3D 0;
  }
  break;
- case BPF_LD | BPF_ABS:
- case BPF_LD | BPF_IND:
+ case BPF_ABS:
+ case BPF_IND:
  /* stick with defaults */
  break;
  }
@@ -24465,7 +24512,12 @@ static void compute_insn_live_regs(struct
bpf_verifier_env *env,
  case BPF_LDX:
  switch (mode) {
  case BPF_MEM:
+ /* A narrow load still redefines the whole register. */
+ def =3D dst;
+ use =3D src;
+ break;
  case BPF_MEMSX:
+ /* Sign extension defines all 64 bits; src is a pointer. */
  def =3D dst;
  use =3D src;
  break;
@@ -24483,12 +24535,15 @@ static void compute_insn_live_regs(struct
bpf_verifier_env *env,
  switch (mode) {
  case BPF_MEM:
  def =3D 0;
- use =3D dst | src;
+ use =3D dst | (size =3D=3D BPF_DW ? src : src32);
  break;
- case BPF_ATOMIC:
+ case BPF_ATOMIC: {
+ u32 srcv =3D size =3D=3D BPF_DW ? src : src32;
+ u32 r0v =3D size =3D=3D BPF_DW ? r0 : mask_lo(r0);
+
  switch (insn->imm) {
  case BPF_CMPXCHG:
- use =3D r0 | dst | src;
+ use =3D r0v | dst | srcv;
  def =3D r0;
  break;
  case BPF_LOAD_ACQ:
@@ -24497,10 +24552,10 @@ static void compute_insn_live_regs(struct
bpf_verifier_env *env,
  break;
  case BPF_STORE_REL:
  def =3D 0;
- use =3D dst | src;
+ use =3D dst | srcv;
  break;
  default:
- use =3D dst | src;
+ use =3D dst | srcv;
  if (insn->imm & BPF_FETCH)
  def =3D src;
  else
@@ -24508,6 +24563,7 @@ static void compute_insn_live_regs(struct
bpf_verifier_env *env,
  }
  break;
  }
+ }
  break;
  case BPF_ALU:
  case BPF_ALU64:
@@ -24521,14 +24577,15 @@ static void compute_insn_live_regs(struct
bpf_verifier_env *env,
  if (BPF_SRC(insn->code) =3D=3D BPF_K)
  use =3D 0;
  else
- use =3D src;
+ use =3D class =3D=3D BPF_ALU64 ? src : src32;
  break;
  default:
  def =3D dst;
  if (BPF_SRC(insn->code) =3D=3D BPF_K)
- use =3D dst;
+ use =3D class =3D=3D BPF_ALU64 ? dst : dst32;
  else
- use =3D dst | src;
+ use =3D class =3D=3D BPF_ALU64 ? (dst | src) :
+        (dst32 | src32);
  }
  break;
  case BPF_JMP:
@@ -24550,17 +24607,14 @@ static void compute_insn_live_regs(struct
bpf_verifier_env *env,
  use =3D r0;
  break;
  case BPF_CALL:
- def =3D ALL_CALLER_SAVED_REGS;
- use =3D def & ~BIT(BPF_REG_0);
- if (get_call_summary(env, insn, &cs))
- use =3D GENMASK(cs.num_params, 1);
+ def =3D mask_widen(ALL_CALLER_SAVED_REGS);
+ use =3D call_use_mask(env, insn);
  break;
  default:
  def =3D 0;
- if (BPF_SRC(insn->code) =3D=3D BPF_K)
- use =3D dst;
- else
- use =3D dst | src;
+ use =3D class =3D=3D BPF_JMP ? dst : dst32;
+ if (BPF_SRC(insn->code) =3D=3D BPF_X)
+ use |=3D class =3D=3D BPF_JMP ? src : src32;
  }
  break;
  }
@@ -24621,8 +24675,8 @@ static int compute_live_registers(struct
bpf_verifier_env *env)
  struct insn_live_regs *live =3D &state[insn_idx];
  int succ_num;
  u32 succ[2];
- u16 new_out =3D 0;
- u16 new_in =3D 0;
+ u32 new_out =3D 0;
+ u32 new_in =3D 0;

  succ_num =3D bpf_insn_successors(env->prog, insn_idx, succ);
  for (int s =3D 0; s < succ_num; ++s)
@@ -24636,8 +24690,18 @@ static int compute_live_registers(struct
bpf_verifier_env *env)
  }
  }

- for (i =3D 0; i < insn_cnt; ++i)
- insn_aux[i].live_regs_before =3D state[i].in;
+ for (i =3D 0; i < insn_cnt; ++i) {
+ int def32 =3D insn_def32(&insns[i]);
+ u32 in =3D state[i].in;
+
+ insn_aux[i].live_regs_before =3D mask_lo(in) | mask_hi(in);
+ /*
+ * Architectures where ALU32 does not clear the physical high half
+ * need an explicit zext whenever that high half is live afterwards.
+ */
+ insn_aux[i].zext_dst =3D def32 >=3D 0 &&
+       (mask_hi(state[i].out) & BIT(def32));
+ }

  if (env->log.level & BPF_LOG_LEVEL2) {
  verbose(env, "Live regs before insn:\n");

2026=EB=85=84 8=EC=9B=94 1=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 10:10, E=
duard Zingerman <eddyz87@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Includes the following test cases:
> - a test showing that zero extension flags do not propagate through
>   state pruning in the unpatched kernel.
> - a 32-bit subregister consumed by MOV32 and ALU32 operations
>   (never zext'ed);
> - a 64-bit MOV (never zext'ed);
> - a narrow (32-bit) BPF_LDX load whose result is read as 64-bit;
> - 32-bit atomic fetch_add and cmpxchg whose result is read as 64-bit;
> - a CFG case where a 32-bit definition's upper half is used only on one
>   of two branches;
> - no zext for dead registers;
> - LD_ABS defines only lower 32 bits, hence needs zext when the result
>   is used as 64-bits;
> - Helper and subprogram parameters are considered to use full 64 bits;
> - kfunc parameters are read according to their BTF type width.
> - a 32-bit subregister consumed by JMP32 (X/K) operations;
> - a 32-bit subregister consumed by JMP (X/K) operations;
> - a 64-bit register consumed by both JMP and JMP32 operations
>   (never zext'ed).
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/verifier.c |   2 +
>  tools/testing/selftests/bpf/progs/verifier_zext.c | 315 ++++++++++++++++=
++++++
>  2 files changed, 317 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index be97f6887f0e..fba562c81969 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -124,6 +124,7 @@
>  #include "verifier_jit_inline.skel.h"
>  #include "irq.skel.h"
>  #include "verifier_ctx_ptr_param.skel.h"
> +#include "verifier_zext.skel.h"
>
>  #define MAX_ENTRIES 11
>
> @@ -277,6 +278,7 @@ void test_irq(void)                       { RUN(irq);=
 }
>  void test_verifier_mtu(void)                 { RUN(verifier_mtu); }
>  void test_verifier_jit_inline(void)               { RUN(verifier_jit_inl=
ine); }
>  void test_verifier_ctx_ptr_param(void)       { RUN(verifier_ctx_ptr_para=
m); }
> +void test_verifier_zext(void)                 { RUN_TESTS(verifier_zext)=
; }
>
>  static int init_test_val_map(struct bpf_object *obj, char *map_name)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/verifier_zext.c b/tools/te=
sting/selftests/bpf/progs/verifier_zext.c
> new file mode 100644
> index 000000000000..2233cddde1e1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_zext.c
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "../../../include/linux/filter.h"
> +#include "bpf_misc.h"
> +
> +SEC("socket")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__flag(BPF_F_TEST_RND_HI32)
> +__success __retval(0)
> +__naked void zext_lost_across_checkpoint(void)
> +{
> +       asm volatile ("                                                  =
               \
> +       call %[bpf_ktime_get_ns];                                        =
               \
> +       r8 =3D r0;                                                       =
                 \
> +       r6 =3D 0xdeadbeefcafebabe ll;     /* inject some value for r6's u=
pper half */     \
> +       if r8 !=3D 0 goto 1f;             /* fall-through cached first, b=
ranch pruned */  \
> +       r6 =3D 32;                        /* full 64-bit def */          =
                 \
> +       goto 2f;                                                         =
               \
> +1:     w6 =3D 32;                        /* 32-bit def, zext mark lost *=
/                \
> +2:     r0 =3D r6;                        /* buggy verifier believed uppe=
r 32 bits are 0 */ \
> +                                       /* and thus did not zero extended=
 w6 =3D 32. */   \
> +       r0 >>=3D 32;                                                     =
                 \
> +       exit;                                                            =
               \
> +"      :
> +       : __imm(bpf_ktime_get_ns)
> +       : __clobber_all);
> +}
> +
> +/* 32-bit ALU result read as 64-bit -> zext */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("w1 =3D w0{{ +}}; zext")
> +__naked void zext_alu32_hi_used(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       w1 =3D w0;                                        \
> +       r0 =3D r1;                                        \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +/* 32-bit ALU result read only as 32-bit -> no zext */
> +SEC("socket")
> +__success __log_level(2)
> +__not_msg("; zext")
> +__naked void no_zext_alu32_hi_unused(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       w1 =3D w0;                /* MOV */               \
> +       w2 =3D w1;                                        \
> +       w2 +=3D w1;               /* ALU32, BPF_X */      \
> +       w2 +=3D 1;                /* ALU32, BPF_K */      \
> +       w2 =3D w2;                /* keep w2 alive for previous instructi=
on */ \
> +       r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +/* 64-bit definition is never zero extended */
> +SEC("socket")
> +__success __log_level(2)
> +__not_msg("r1 =3D r0{{.*}}; zext")
> +__naked void no_zext_mov64(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       r1 =3D r0;                                        \
> +       r0 =3D r1;                                        \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +/* Narrow load result read as 64-bit -> zext */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("r1 =3D *(u32 *)(r10 -8){{ +}}; zext")
> +__naked void zext_narrow_load_hi_used(void)
> +{
> +       asm volatile ("                                 \
> +       r0 =3D 0;                                         \
> +       *(u64 *)(r10 - 8) =3D r0;                         \
> +       r1 =3D *(u32 *)(r10 - 8);                         \
> +       r0 =3D r1;                                        \
> +       exit;                                           \
> +"      ::: __clobber_all);
> +}
> +
> +/* 32-bit atomic fetch result read as 64-bit -> zext */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("r1 =3D atomic_fetch_add((u32 *)(r10 -8), r1){{ +}}; zext")
> +__naked void zext_atomic_fetch32_hi_used(void)
> +{
> +       asm volatile ("                                 \
> +       r1 =3D 0;                                         \
> +       *(u64 *)(r10 - 8) =3D r1;                         \
> +       w1 =3D 1;                                         \
> +       .8byte %[fetch_add32];                          \
> +       r0 =3D r1;                                        \
> +       exit;                                           \
> +"      :
> +       : __imm_insn(fetch_add32,
> +                    BPF_ATOMIC_OP(BPF_W, BPF_ADD | BPF_FETCH, BPF_REG_10=
, BPF_REG_1, -8))
> +       : __clobber_all);
> +}
> +
> +/* 32-bit atomic cmpxchg result (r0) read as 64-bit -> zext */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("r0 =3D atomic_cmpxchg((u32 *)(r10 -8), r0, r1){{ +}}; zext")
> +__naked void zext_cmpxchg32_hi_used(void)
> +{
> +       asm volatile ("                                 \
> +       r1 =3D 0;                                         \
> +       *(u64 *)(r10 - 8) =3D r1;                         \
> +       w0 =3D 0;                                         \
> +       w1 =3D 1;                                         \
> +       .8byte %[cmpxchg32];                            \
> +       r2 =3D r0;                                        \
> +       r0 =3D r2;                                        \
> +       exit;                                           \
> +"      :
> +       : __imm_insn(cmpxchg32,
> +                    BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10, BPF_RE=
G_1, -8))
> +       : __clobber_all);
> +}
> +
> +/* 32-bit def before a branch, upper half used on one branch -> zext */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("w6 =3D 32{{ +}}; zext")
> +__naked void zext_cfg_hi_used_one_branch(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       w6 =3D 32;                                        \
> +       if r0 =3D=3D 0 goto 1f;                             \
> +       r0 =3D r6;                                        \
> +       exit;                                           \
> +1:     r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +/* r1's upper half is dead, so 'w1 =3D 1' must NOT be marked for zero ex=
tension. */
> +SEC("socket")
> +__success __log_level(2)
> +__not_msg("w1 =3D 1{{.*}}; zext")
> +__naked void no_zext_other_reg_hi_used(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       r6 =3D r0;                                        \
> +       r6 <<=3D 32;                                      \
> +       w1 =3D 1;                                         \
> +       r0 =3D r6;                                        \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +/* LD_ABS defines r0; when r0 is read as 64-bit it must be zero extended=
 */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("r0 =3D *(u8 *)skb[0]{{.*}}; zext")
> +__naked void zext_ld_abs_hi_used(void)
> +{
> +       asm volatile ("                                 \
> +       r6 =3D r1;                                        \
> +       r0 =3D *(u8 *)skb[0];                             \
> +       r7 =3D r0;                                        \
> +       r0 =3D r7;                                        \
> +       exit;                                           \
> +"      ::: __clobber_all);
> +}
> +
> +/* Helper parameters are read as 64-bit (call_use_mask() fallback) */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("w2 =3D 1{{ +}}; zext")
> +__naked void helper_param_read_as_64bit(void)
> +{
> +       asm volatile ("                                 \
> +       r1 =3D r10;                                       \
> +       r1 +=3D -8;                                       \
> +       w2 =3D 1;                                         \
> +       call %[bpf_trace_printk];                       \
> +       r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_trace_printk)
> +       : __clobber_all);
> +}
> +
> +static __used __naked int subprog_reads_arg_as_64bit(void)
> +{
> +       asm volatile ("                                 \
> +       r0 =3D r1;                                        \
> +       exit;                                           \
> +"      ::: __clobber_all);
> +}
> +
> +/* subprogram parameters are conservatively read as 64-bit */
> +SEC("socket")
> +__success __log_level(2)
> +__msg("w1 =3D w0{{ +}}; zext")
> +__naked void subprog_param_read_as_64bit(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       w1 =3D w0;                                        \
> +       call subprog_reads_arg_as_64bit;                \
> +       r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +extern long bpf_kfunc_call_test4(signed char a, short b, int c, long d) =
__ksym;
> +
> +/* Force kfunc extern BTF generation. */
> +int __kfunc_btf_root(void)
> +{
> +       return bpf_kfunc_call_test4(0, 0, 0, 0);
> +}
> +
> +/* kfunc parameters are read according to their BTF type width */
> +SEC("tc")
> +__success __log_level(2)
> +__not_msg("w3 =3D 1{{.*}}; zext")                /* int c  -> read as 32=
-bit */
> +__msg("w4 =3D 1{{ +}}; zext")            /* long d -> read as 64-bit */
> +__naked void kfunc_param_read_per_btf(void)
> +{
> +       asm volatile ("                                 \
> +       w1 =3D 1;                                         \
> +       w2 =3D 1;                                         \
> +       w3 =3D 1;                                         \
> +       w4 =3D 1;                                         \
> +       call bpf_kfunc_call_test4;                      \
> +       r0 =3D 0;                                         \
> +       exit;                                           \
> +"      ::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__success __log_level(2)
> +__not_msg("; zext")
> +__naked void alu32_and_32bit_conditional(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       w1 =3D w0;                                        \
> +       if w1 > 42 goto 1f;             /* BPF_K */     \
> +       w2 =3D 28;                                        \
> +       if w2 > w1 goto 1f;             /* BPF_X */     \
> +       r0 =3D 0;                                         \
> +1:     exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +SEC("socket")
> +__success __log_level(2)
> +__msg("w1 =3D w0{{ +}}; zext")
> +__naked void alu32_and_64bit_conditional(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       w1 =3D w0;                                        \
> +       if r1 > 42 goto 1f;             /* BPF_K */     \
> +       r2 =3D 28;                                        \
> +       if r2 > r1 goto 1f;             /* BPF_X */     \
> +       r0 =3D 0;                                         \
> +1:     exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +SEC("socket")
> +__success __log_level(2)
> +__not_msg("; zext")
> +__naked void alu64_and_conditionals(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       r1 =3D r0;                                        \
> +       if w1 > 42 goto 1f;             /* BPF_K */     \
> +       if r1 > 42 goto 1f;             /* BPF_K */     \
> +       r2 =3D 28;                                        \
> +       if w2 > w1 goto 1f;             /* BPF_X */     \
> +       if r2 > r1 goto 1f;             /* BPF_X */     \
> +       r0 =3D 0;                                         \
> +1:     exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
>
> --
> 2.55.0
