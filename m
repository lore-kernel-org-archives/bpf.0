Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5894756BA
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152933; cv=none; b=iCoUQAtfslOu8TbtM4yCt5JwvLk2El4mJ1r/7rUiJoSJ2Oc48yC/LdbOEb8Z/KSBzICTjNidI7QPrWiqzDFudAE+0Eb+1RvFRjUbZNH/JKdvPTQ+aEJrraVgTbmmgiPI9V30gJ5eyEiRvomVssCeYSsAFdxvvb26t5fWA/83chc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152933; c=relaxed/simple;
	bh=ZL4+B/f/nrGl7dnkASZuaD7LCS7UrehzB5t9/kPcfNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVVrYFyiSVznZDbB+bgqFYVvxtsEd1dcwLwjrLY8n3IEcjiHv1OOXJNuOoOsqxGBo+kJtAyI95gKOM/O5w2xt16R133s5P9ycoOyK0N10503cmDJ6Bl6ibCsJQPwfU3pa1n1mMwalOgiDA+kceSF7bMexpmBHhwT56lkA0GiN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TodN7Psx; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TodN7Psx"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bd65693so3499005e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 01:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790152925; x=1790757725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fs12F2CT2aKl6YdDLuX2AslDXoenGZJtejLzZu6ZPx8=;
        b=TodN7PsxmM42JMPFvDx9NjNr1lo8nI985LxsA/8UCp/pgpCLL45eI9o4W47YwoSl0I
         /2gKLu0t4X1HQpOhcL1lDRdLVcbba27PyHNJST8UjV8ZeRzw1EDDixQ1kWa/HV1szeR8
         Wbkbscbmv1CQnshCnHg1XrVOioZFbHPHIYJsVjE/po6cqx9HLyhG/+emPSMGohK4kVlo
         jUJI4+TosG50r1hf/M0E7LTUXWisCmWvt76dQMO0E7txfahdQn/KsmUkN4ndAt8ysuJD
         ssUPU5xrJPSIr0tkVIf8aFyLMBnEu7Wbk+vjccehhrQJelflobo6usgo9wIyG52sWQpf
         1+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790152925; x=1790757725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fs12F2CT2aKl6YdDLuX2AslDXoenGZJtejLzZu6ZPx8=;
        b=jaSTgNX2P0RWtileJH4xbKfzvgQ4P3Vin4KvkKlc6ENM0hP/BqyHY0aadAHUy26PO3
         FwxSjNDWPCRgvO04MVfZBjk0sdzQxrUVBWDV56Y39D7dQJTCo9OpsdJO1gEslglfr249
         jZqVW6ECNDzDRgS0XWq5QbveDRUlu286XKIjzk57TG5HDu5/prhWu4mnY4RTSbQgY33b
         XcAtKYU9EgLWU05kKmP6yxmTfIOrLdj0PAOAjMi7rRNdE001Vd5gR5tNMmP11ZXVzUEk
         Nx6kEeGwFLUJ4tr+Ex9HYu5cKV8lx+X+Rk9BaAmaEwNEvZwwTxrVBz+CFAoG6pYbIqmG
         2TWA==
X-Gm-Message-State: AFuF++l2GGVQjb9z55dZyIx9gFNxHacsQyD5N+fO1AZxqpjrxTguyWSG
	mO56JYM/0MNJvvQbVm1oeMUQ9o1Aa28GKVujJzyUtEb282BYxLfrKgXehZSHpj3h
X-Gm-Gg: AYBFou3pqDVtQ3QNgkGylxa39O9B6SWo7iQsl5bi5+u7HGJbj2aTsh1WWOAB7YT98Ze
	Hbez0DjHuXGnPzLQCEA8J5/7VDv5MUJReygGiM56vkV2YNfJexHygFXt6REK9IYKQHUhDn3Hx8v
	6UmwPG3lvJaS558QcpsDgJuoeX+BPQNzDo/vbBj5yvwsEnv0Ev8mebY8VNU3XcNqisq4gyEyxMH
	+MmB270lvLJ2OdY0vIqcrH19o6A39caXnx1deUJo2YZE9KjF90U9hgAskaOxiPjL8WVqYy0R2IU
	BvoOPTuBZV+P2HyH9ozSGKW5aocNRmugoyfbPTCgnw4IOfQkTKkzAiQYMW6SDUEfYKopifgEdF7
	mvbGgutWfQXEVWAG7atEtRWYlxC92u80rhvJfr21bhtM7YN1TCui4zd5YVRu8ewFDwQnIHKe+Ma
	Ii9JGASvcG7h+J0+L1o82k2SzsUYl3ymmRgvaOy3Ni4kXiwsXQIth9pAvZg29iibEOxWDAl5X6/
	PA3x8376IxtYNpzIiX1OCld8MeElcX95U2EYWDvTUwpiBon59l4OfLy2+uU4Vi3md/Ayulxkjmz
	Y6E1cB87EJzbS8zQyDQJUNT2AIUA5d5Vqyhq6kKjr03VzoY+
X-Received: by 2002:a05:600c:c490:b0:49e:6ac4:b76e with SMTP id 5b1f17b1804b1-49fdf14f3c3mr21495365e9.30.1790152924654;
        Wed, 23 Sep 2026 01:42:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde17dab9sm72717265e9.2.2026.09.23.01.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 01:42:04 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/3] bpf: Check fastcall contract for helper and kfunc stack buffers
Date: Wed, 23 Sep 2026 10:41:56 +0200
Message-ID: <20260923084201.2437625-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923084201.2437625-1-memxor@gmail.com>
References: <20260923084201.2437625-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3563; i=memxor@gmail.com; h=from:subject; bh=ZL4+B/f/nrGl7dnkASZuaD7LCS7UrehzB5t9/kPcfNU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvzhJ1/lONPtE0XuGuU8MxweUra54O553P4ZBacqli// dtzVV2fjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzk8wKGf4p/St1n7lG205sn aSR0/mbazQ+mX9Zq/c2w0Oj4WyB64AEjQ3/y1ycNKrVLnnz8GKu26sDuGy1HJG5cyZHNSdwa+j7 cmwkA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

When the verifier inlines a bpf_fastcall helper or kfunc, it removes the
spill/fill pairs that clang emitted around the call and lowers the
subprogram's stack depth so that their slots are no longer part of the
frame. This is only safe if nothing else accesses those slots or any slot
below them. check_fastcall_stack_contract() enforces this: an access to
that region from outside a fastcall pattern disables the rewrite for the
subprogram.

Stack loads and stores call this check, but stack buffers passed to
helpers and kfuncs are validated by check_stack_range_initialized(),
which does not. If such a buffer is the only other access to the region,
the rewrite is still applied, the JIT reserves a frame that does not
contain the buffer, and the helper reads or writes live kernel stack
below the program's frame. For example, without CAP_PERFMON:

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

Call check_fastcall_stack_contract() from check_stack_range_initialized()
for every nonempty access, before the raw-mode return. Use the frame that
owns the buffer, so that a callee passing a pointer into its caller's
stack disables the caller's rewrite. Zero-sized accesses touch no stack
and leave the rewrite enabled. Variable-offset stack reads now get the
check through check_stack_range_initialized(), so drop the separate call
in check_stack_read_var_off().

Fixes: 5b5f51bff1b6 ("bpf: no_caller_saved_registers attribute for helper calls")
Fixes: 5da4a9f26fca ("bpf: Preserve stack initialization for generic output buffers")
Link: https://lore.kernel.org/bpf/85f9995a43edb70c76615280e103dc5325742e88330f36c97962ee35f17e3e32@mail.kernel.org
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7c9e2d8965d..1d9defa231d1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4138,7 +4138,6 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env, struct bpf_reg
 				  dst_regno);
 	if (err)
 		return err;
-	check_fastcall_stack_contract(env, ptr_state, env->insn_idx, min_off);
 	return 0;
 }
 
@@ -7041,6 +7040,13 @@ static int check_stack_range_initialized(
 		max_off = reg_smax(reg) + off;
 	}
 
+	/*
+	 * Helpers and kfuncs can access stack slots without going through the
+	 * regular stack read/write paths, including when raw mode is disabled.
+	 */
+	if (access_size)
+		check_fastcall_stack_contract(env, state, env->insn_idx, min_off);
+
 	/* Unprivileged outputs retain each byte's initialization state. */
 	if (raw_mode) {
 		meta->arg_raw_mem.size[arg_slot] = access_size;
-- 
2.53.0

