Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7027A4307B0
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236440; cv=none; b=Jrm+OzPMf9WNfCp8AwdzcLVt1eFHktjlHe2IlcFd+6SSVQg2m7UWxi4Vdz2d1YCfqYq9kP3JmbkFJw3DwvDyCr5wglNxxxi7kMqIkPXP5zae6O5qHivod9Ij9dIsnRtHhElKXJcV7ZymaPJDr7+WV9+emwiRKbX7adewUnFMmII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236440; c=relaxed/simple;
	bh=23/IK+v0ZJraodc3cIyE8mZofrn5jdm+WcweK5PGXMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=babzggYP82SDSIIspPoKad+eKq62MzTsNsGvN/Uk+Ror/GFKKPY/8ECW2tGAaLy+7CrFBz1Fs2nQ53sS4LgXS98LeJn6667Vv4EsHJhlkV5uU3G95Bp3Z8olbbhidEu9UvJqlxGmoZLOEPcAkIu041a0xdNX+RPcBLyHWr3pcRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQVSJXSM; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQVSJXSM"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48351e5bb47so551146f8f.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790236436; x=1790841236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SivqUH7MJczvTZ962EBibSuSrTPZX1+IyKmPjA05+80=;
        b=qQVSJXSMdGMnra/3l9DpuvMtLMppV/SKIpIMAZmzh/18ob3mT96XFeK4EM78uJjy1X
         HMZ7mgE84O0pWlj37uyIf1Xxwep4dpuNtw37bMw4H6fNvf5VNwTzMt3SaLeuUmyvB9mF
         8/BVJiRuACtANwLEXwOoCkz3APFNttv82yOdqJTz2uBMmW5jjsIinrN0C8EDaTTBgnsx
         pw7LIO/bJjwWfFHWtJEv87Q4mCCWQUznhyBAK08A8cWVq5Qp2oTMp2bQBVU7A5cSXuK6
         K8WWgOUDDFvcwZWkT1mqyDsv2Qg0fOrX2efZHm+vKj+bIXwRM3kGgsI6OXOmoUQvpz1k
         vVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790236436; x=1790841236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SivqUH7MJczvTZ962EBibSuSrTPZX1+IyKmPjA05+80=;
        b=j1nhZYz2tYfdTsMP0nvuo1EBoWDUxT2oTRzezEt8B/B38tJaWszv7yTZXSA32v4fKl
         7MFTi1nLqVUhx3YemNc5uv931vESCJ6oJRKyaSgQUO/GzniQGnBoMe6JN6iN7RnxsLil
         4CpsQJQ6cs9X8noS8yJ0gK1twtqrtCmYRP3p23p3yY7g4F4dd+4hUlh/P5UPal/boJBG
         4Sc5MOURtoprqDghBQ5N1Y1TEaKP1d9W063cdI8McaLnS6Nkan/bWW8x5s5gYj97v3FG
         tSndn1cYhGhgzjL5/NDEDkR9TM98tXvh1EAxnKRP+6kZ/pl+rf+DLQpmllxSHpjaB6nZ
         4gtA==
X-Gm-Message-State: AFuF++mZxvir7jQ6VngM29GqEJuoj7W7BtsnEk5bz+zdx4kXjrRS7OPd
	kV6J5vr6ew3SDRg0OJmWGStZcc0FSOk9bvlZJKrZz+GsbvNHCuPYTUgl0LkXF7lr
X-Gm-Gg: AYBFou3V9NP8QxaaUUfYEy8UkoeAF8u8KWMsP5qJHsw5X7MJmDqok4VwP0iR0Pwr1kH
	0jZpOdn88807dTG3VX2ErmXE2Lw204Q1FWDBvKQ0pBVUux+goNaKA3Wnxw/ml3Qx0fVX1L726s7
	kHBlgJX/sfbwCQHo8+fKqtztm2gppKC+I1V9bTe1v/Hjh8bWeewnejs50CC0tDN1+qwKlufTb+t
	ZQhNqGCCLqehpkrPWn4fF4WyE8/ZDeJWtulNPLq8/h1Rpp1KT/+2KI6o2I1lEfoXgJ6/AV7csPx
	Hao2Y9kcEwBxs9l0C7waZ/4agDBU3zvyTyTYXkuLKtoXD7UcMG2QeNWFjqxudYFlIBoDY3HMjUV
	X/owhje32TnbVzdduTHqXNAYY8CGGcCzqRYrrRViRclbXhvRnHurQtwYjDjpVP9Vzi7/JQKEwnk
	SQIKOpgCit1kgAkKT4OueOirnRqQUKbfE4o3xhj8baacaXSv/KZGy3tcxbUJVf0Ugr4D4IKlIdH
	t7ehqkjHJxkSZrVVmlDtNPKVjUK3eZ58WY/beTXLNAKeHzR2UUvExRsg8BptxSOOD8456cmUxSn
	HtKnSFg8rx0rcmurERYR6hJmpx0hOpuQfcgjfA==
X-Received: by 2002:a05:600c:37c9:b0:49f:c2ef:cfb9 with SMTP id 5b1f17b1804b1-49fe66c897cmr22525535e9.4.1790236436011;
        Thu, 24 Sep 2026 00:53:56 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe41b8446sm29266655e9.1.2026.09.24.00.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:53:55 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/2] bpf: Check fastcall stack contract once for all stack accesses
Date: Thu, 24 Sep 2026 09:53:49 +0200
Message-ID: <20260924075352.2343553-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924075352.2343553-1-memxor@gmail.com>
References: <20260924075352.2343553-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5526; i=memxor@gmail.com; h=from:subject; bh=23/IK+v0ZJraodc3cIyE8mZofrn5jdm+WcweK5PGXMw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvLtXMsJd3CNRs0Q9aI83w8Jv914n8brU2HzT3ZnmzM8 Nton6PdUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIm8TGNk+DjPu8RMslWdd33G AwnOJ+orCx2fScnnJCyvsg6drLpvAsP/CKtNBWdnuxikKPiw1t00l2Odu7Q64YNT4E69gBOl189 wAgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

When the verifier inlines a bpf_fastcall helper or kfunc, it removes the
spill/fill pairs that clang emitted around the call and lowers the
subprogram's stack depth so that their slots are no longer part of the
frame. This is only safe if nothing else accesses those slots or any slot
below them. check_fastcall_stack_contract() enforces this: an access to
that region from outside a fastcall pattern disables the rewrite for the
subprogram. It is called from the four stack load and store paths, and
two kinds of access escape it.

Stack buffers passed to helpers and kfuncs are validated by
check_stack_range_initialized(), which does not call it. If such a buffer
is the only other access to the region, the rewrite is still applied, the
JIT reserves a frame that does not contain the buffer, and the helper
reads or writes live kernel stack below the program's frame. For example,
without CAP_PERFMON:

	*(u64 *)(r10 - 8) = r1;
	call bpf_get_smp_processor_id;
	r1 = *(u64 *)(r10 - 8);
	r2 = 0;
	r3 = r10;
	r3 += -64;
	r4 = 8;
	call bpf_skb_load_bytes;

is accepted with a stack depth of 0 instead of 64.

Some buffers got the check indirectly. For constant-sized outputs in raw
mode, mark_raw_stack() marks the buffer initialized through ordinary
byte stores, which call the check. Commit 5da4a9f26fca ("bpf: Preserve
stack initialization for generic output buffers") limited raw mode to
programs that may read uninitialized stack, so outputs of programs
without CAP_PERFMON lost the check, as in the example above. Buffers
that never used raw mode have lacked the check since fastcall support
was added: helper inputs such as a map key whose only store is a fastcall
spill, variable-sized outputs, and buffers at a variable stack offset.

check_stack_read_fixed_off() applies the check to the current frame,
even when the pointer targets a caller's stack. A callee can therefore
read a caller's fastcall spill slot without disabling the caller's
rewrite:

	caller:
	r1 = 1;
	*(u64 *)(r10 - 8) = r1;
	call bpf_get_smp_processor_id;
	r1 = *(u64 *)(r10 - 8);
	r1 = r10;
	r1 += -8;
	call callee;

	callee:
	r0 = *(u64 *)(r1 + 0);

The caller's spill and fill are removed and its stack depth drops to 0,
but the verifier still tracks the slot as holding the spilled constant.
The callee's load then reads kernel stack outside the caller's frame,
while the verifier assumes r0 is 1.

Every stack access first goes through check_stack_access_within_bounds():
loads and stores from check_mem_access(), helper and kfunc buffers from
check_stack_range_initialized(), and the dynptr, iterator and irq flag
slots that kfuncs initialize, whose handlers use check_mem_access(). It
resolves the frame that owns the slots and the lowest offset the access
can touch, and it is the only place where a frame's stack depth grows.
Check the contract there, once for every access, and drop the calls from
the stack read and write paths. Zero-sized buffers touch no stack and
leave the rewrite enabled.

Fixes: 5b5f51bff1b6 ("bpf: no_caller_saved_registers attribute for helper calls")
Fixes: 5da4a9f26fca ("bpf: Preserve stack initialization for generic output buffers")
Link: https://lore.kernel.org/bpf/85f9995a43edb70c76615280e103dc5325742e88330f36c97962ee35f17e3e32@mail.kernel.org
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fec5a1ae6a4d..fe19d24d8773 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3711,7 +3711,6 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
-	check_fastcall_stack_contract(env, state, insn_idx, off);
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE && env->bpf_capable) {
 		bool reg_value_fits;
@@ -3832,7 +3831,6 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 			return err;
 	}
 
-	check_fastcall_stack_contract(env, state, insn_idx, min_off);
 	/* Variable offset writes destroy any spilled pointers in range. */
 	for (i = min_off; i < max_off; i++) {
 		u8 new_type, *stype;
@@ -4017,7 +4015,6 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	reg = &reg_state->stack[spi].spilled_ptr;
 
 	mark_stack_slot_scratched(env, spi);
-	check_fastcall_stack_contract(env, state, env->insn_idx, off);
 
 	/*
 	 * Refine the in-progress load record's origin to the source stack slot.
@@ -4204,7 +4201,6 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env, struct bpf_reg
 				  dst_regno);
 	if (err)
 		return err;
-	check_fastcall_stack_contract(env, ptr_state, env->insn_idx, min_off);
 	return 0;
 }
 
@@ -6609,6 +6605,15 @@ static int check_stack_access_within_bounds(
 		return err;
 	}
 
+	/*
+	 * Every stack access passes through here, including buffers passed to
+	 * helpers and kfuncs and accesses into a caller's frame, so check the
+	 * fastcall contract of the frame that owns the slots once for all of
+	 * them. Zero-sized accesses touch no stack and keep the rewrite enabled.
+	 */
+	if (access_size)
+		check_fastcall_stack_contract(env, state, env->insn_idx, min_off);
+
 	/* Note that there is no stack access with offset zero, so the needed stack
 	 * size is -min_off, not -min_off+1.
 	 */
-- 
2.53.0

