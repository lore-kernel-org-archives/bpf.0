Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EB442A178
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242191; cv=none; b=HkGWfzM8EXueZJ14Wo7HgmxtO743ZEqrifsIxAeFaKG+pcyDP//vt0B70pBdbvHE4v1c+cU68Zdf+KhBGsSmgzobpXoct98E/eyX72HuS7LoUKUS56pUrwDWQyyABUmuBMng0IU3zoYr/IVVZ5fHgMMGDJkMluifEaIuGbYCBYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242191; c=relaxed/simple;
	bh=wZ9Z6KyaUHwoAi4Ql7ayOvfc8TL9rrRcF1blgjU2xJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkddyXLoVDbZ2bG+OgFYJgfDr0T43DAy7wGNiuAhEPGmjAmLmooOMgKFUAPK1xL/EcSAIbzqeZAYxAa2d7LeeV7OPYHV+0R1UzzWChqkBKx3uncEWSVSGj2F0PWAGnaABRmhu3Usj592VBxCY3CZNbvO9Dc150LBqb/bo1WkCdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY8/9pvt; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY8/9pvt"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49fe8bf90c9so846755e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790242187; x=1790846987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QhxObcpprhTchCMdpWdXUUMI2Kk8s59Gxags6MSYgNo=;
        b=OY8/9pvt+iVwBAcSkBn3d90HpWktvQOUsJ/ycPxM75kdOonyjJL7zApxEwkWZZpd67
         3NH+uvJEM3WK/Nvc6zM6JNC7+KICY/NRCgAfLdMTPQd7r5yZBuB6Sq01x02vEmYyL4Ek
         5IUoywwrkFU7G+GWFXKq3QMgEaAUMxoyQo8GpGrdFLJHXrn8Z5BcoBLYgGXsrPsKYlqm
         XoJewU1Ml7p3ZRt0QrMbV35HxdDXbrgoddmoDW+7i4IskrzFE9lSBAqMYf7UKzA3k71r
         ullCfjvXj8xLjNN6j3MwVkmoo7Ca84NLrdetjt3ds6qI8bkn9nzRSVkuWxw7O8A+4M/X
         VUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242187; x=1790846987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QhxObcpprhTchCMdpWdXUUMI2Kk8s59Gxags6MSYgNo=;
        b=TMREv7HwxVkeWo0mMryQHYqKuPBmlop6jo1FWzZWGiVZKi4YTRISXgW2CWHDLEiEYB
         HpnF0i3o6o6SCsLVz3KNv/IjyJ6i17f7eHQNihI5y86cE7gJgLc2AKotrbvFCyUmWWv2
         w7oXon4pbTkPOlfjl80puvOfd5sutAfjRSEnEyN+XsjYZshUfcPOBitV1ypvH4Fhov3d
         KL9IUEu473IN3SDqPQJjeohFmB4w4pGmtDV46/SzhBPlDRfxOABJ7CnFG6MZ3i3zmMYr
         E6fh5ssLD91o+/Mdgsir5uzNjIm+0DsMham8vpoi9B5L2ewlEowcZTSGwJJclxRqa+TT
         pIWQ==
X-Gm-Message-State: AFuF++maTiIDIkC9fzb/2bCxx3fJuxGweAE4BpINZxVNTpLQkYuw8sxR
	nnLy/haaJ1J/kUGazheIvzV5tgydpBe3MJoheYIf/l5nHR2HStpGuEhxmm6FplEZ
X-Gm-Gg: AYBFou3Ioqv4kWL/MTyTe4ZQofr2JYsReUc5P3dE5jdu0Xpt1rdFV0M1s6ckdW/Gqkz
	YP7/QnmeCOqdI5eBQ9i00UdOPNdyjA4fMTZ0564YB7lXV8Q9Z0BXKY2y0OtnEeKL4nHyl3zMxe5
	Nj1RtEa6MijBiqHoU9Papx2p3eO95/NXXr+KjC7zXXKgFzmyncAk6wWO+9IfA31m7rd/ajZM9wb
	75v8Xcrj2+7ebGF83Ct2g31f12PN4KAwf3csJo3z/uRxC5QZft8YStpMvjsAaOPj5rkKJvYn+HG
	KiSuFNBJurWVDB/H0taMHvtm0F6M5d4x1oS9xBplzDFq7kIkEVkjI76wbL0EGn/DUv8Y5nrVYc8
	7OB6AB5aObf8GwYxsy3o+X4nuOU7SIZ9DcYrh7W3QBf9+0HautzcjJPCn8OGVmapF1vknVxqUL8
	RKadb/FVg55nGo7Qz55hZUBwCRBU5VWXjX8HeH8hj0gHMIyrtT+4sFswPR06KQ+sJrzWKA980TY
	9YRQiQIOVK3V+9wQyhZU+cE+zEXzQJIKmV5YcEOoTnuWGMF7vHrKH2UJH9wzg/VqRzGJoAqEBgt
	8LTKerNE0GcRuBPYVp1jG1K5JRC6EYsRpj0dXA==
X-Received: by 2002:a05:600c:3515:b0:49e:7a10:1b71 with SMTP id 5b1f17b1804b1-49fe66d089dmr30283235e9.11.1790242186599;
        Thu, 24 Sep 2026 02:29:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd2bacsm50319185e9.13.2026.09.24.02.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:29:46 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/7] selftests/bpf: Test verifier stack-read diagnostic attribution
Date: Thu, 24 Sep 2026 11:29:31 +0200
Message-ID: <20260924092941.3174809-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924092941.3174809-1-memxor@gmail.com>
References: <20260924092941.3174809-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5270; i=memxor@gmail.com; h=from:subject; bh=wZ9Z6KyaUHwoAi4Ql7ayOvfc8TL9rrRcF1blgjU2xJ0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvL2+yfWwQ7nhz9f5hPct90m3A+HeOkK3980t52bZHJ1 b/pp3G4o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABN5rsnwP8714ukjfklzrKYt mlSfOcNZWi7ERHf3uTmT59cW5+pM62D4K/RBRfr1+bwP+UofMtvvdS45Uy4u9mr9vklV5l1KP/I PswEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Verifier diagnostics distinguish uninitialized stack bytes from opaque
dynptr, iterator, and IRQ-flag state, and identify variable-offset
stack accesses without changing the existing verbose messages.

Add output assertions to the existing uninitialized-stack, dynptr, and
iterator rejection cases. The uninitialized-stack assertion uses the
CAP_PERFMON-less read inside the allocated stack, because a read below
the allocated stack is rejected by the bounds check before the slot
classification runs. Add a direct IRQ-flag read and a variable-offset
atomic stack access to cover the other classifications. Retain an
assertion for the legacy helper-worded verbose message in the atomic
test.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c |  3 +++
 tools/testing/selftests/bpf/progs/irq.c       | 13 +++++++++
 .../selftests/bpf/progs/iters_state_safety.c  |  3 +++
 .../selftests/bpf/progs/verifier_spill_fill.c |  2 ++
 .../selftests/bpf/progs/verifier_xadd.c       | 27 +++++++++++++++++++
 5 files changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 1cd61d72c166..9418dfe4d7b7 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -560,6 +560,9 @@ int global(void *ctx)
 /* A direct read should fail */
 SEC("?raw_tp")
 __failure __msg("invalid read from stack")
+__msg("Verification failed: Memory Safety: Direct read of dynptr stack state")
+__msg("verifier-managed dynptr state")
+__msg("Use dynptr helpers or kfuncs")
 int invalid_read1(void *ctx)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/selftests/bpf/progs/irq.c
index 53df6d248e26..50727fa9b11d 100644
--- a/tools/testing/selftests/bpf/progs/irq.c
+++ b/tools/testing/selftests/bpf/progs/irq.c
@@ -14,6 +14,19 @@ extern int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void *unsafe_ptr
 struct bpf_res_spin_lock lockA __hidden SEC(".data.A");
 struct bpf_res_spin_lock lockB __hidden SEC(".data.B");
 
+SEC("?tc")
+__failure __msg("invalid read from stack")
+__msg("Verification failed: Memory Safety: Direct read of IRQ flag stack state")
+__msg("verifier-managed IRQ flag state")
+__msg("Pass the saved IRQ flag to the matching restore kfunc")
+int irq_flag_direct_read(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	return flags;
+}
+
 SEC("?tc")
 __failure __msg("R1 type=map_value expected=fp")
 int irq_save_bad_arg(struct __sk_buff *ctx)
diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/tools/testing/selftests/bpf/progs/iters_state_safety.c
index 646026430e9b..4723ae578e53 100644
--- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
+++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
@@ -332,6 +332,9 @@ int next_after_destroy_fail(void *ctx)
 
 SEC("?raw_tp")
 __failure __msg("invalid read from stack")
+__msg("Verification failed: Memory Safety: Direct read of iterator stack state")
+__msg("verifier-managed iterator state")
+__msg("Use iterator kfuncs")
 int __naked read_from_iter_slot_fail(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 39a1766dae3f..e1a698db0364 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1277,6 +1277,8 @@ __description("stack_noperfmon: reject read of invalid slots")
 __success
 __caps_unpriv(CAP_BPF)
 __failure_unpriv __msg_unpriv("invalid read from stack off -8+1 size 8")
+__msg_unpriv("Verification failed: Memory Safety: Uninitialized stack read")
+__msg_unpriv("Initialize every byte in the stack range before reading it")
 __naked void stack_noperfmon_reject_invalid_read(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_xadd.c b/tools/testing/selftests/bpf/progs/verifier_xadd.c
index 05a0a55adb45..7bde3da2f36e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_xadd.c
+++ b/tools/testing/selftests/bpf/progs/verifier_xadd.c
@@ -121,4 +121,31 @@ l0_%=:	r0 = 42;					\
 "	::: __clobber_all);
 }
 
+SEC("tc")
+__description("xadd with variable stack offset")
+__failure
+__msg("variable offset stack pointer cannot be passed into helper function")
+__msg("Verification failed: Memory Safety: Variable-offset stack access")
+__msg("The instruction would access the stack")
+__msg("Use a fixed stack offset for the instruction")
+__naked void xadd_variable_stack_offset(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64 *)(r10 - 16) = r1;			\
+	*(u64 *)(r10 - 8) = r1;				\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 8;					\
+	r1 = r10;					\
+	r1 += -16;					\
+	r1 += r0;					\
+	r2 = 1;						\
+	lock *(u64 *)(r1 + 0) += r2;			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

