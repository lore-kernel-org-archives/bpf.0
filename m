Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039F4CDA37
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542944; cv=none; b=Sr+yHvFZ+tV39IFu208eZfYAsulcHemOv+0xibhDnNbzRZ6baODefl/EwJQ64HogoJI1ZwgUDQiqQ7Pf8jXcABoCqgE5WXfz/28m7mujPARPE87pxVnza3VijO27hS0Q9dEq2LN0Ltiw7fJcLD2E6AV1CnMkH7NZz7SEl6vBMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542944; c=relaxed/simple;
	bh=vY8KUjL4luaHxWHl7gMKMelFlUkdWSPUYoKj4hlALM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3avsaakRK39UMWI+vuY8pOqeUtcmHT2KVUjMNCEbD/uaVoR5xvOjbQqlV4DY/s3/SR7hmFwMWS/lb/g4hgUvIUKQ1429dbqBH6jkZ+wblnvniIRJf6zNPpyoXByY1+xxOoIQeG2yaHrG2owKi8V8zRR7ubvU3mdk6m1Azk4HU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILn4SDcQ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILn4SDcQ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ab450c0873so386520a91.3
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542931; x=1792147731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hnvb6IoXLtboBhPj/eQLUwWel52Sh44jyIkRV0mHrrg=;
        b=ILn4SDcQgmoolejRH0pXoqSq7ij1iqT7LTFt+GdapI0mi1fL8tRXJr3itskPwY35vQ
         asVtSBSj9aNl4+bRJgvLv+I5MMQC/rkPIKxTE6NcPsLpOpBzuae9iWn9y10pt9cG52yC
         xUURl8WlzomoIsTMs8ehVIYnG6W/x0Y/5JJiPf96BvY1mR9xXp4DFrXF6Q8H68mJreVx
         CN2HSrpQR66QCpyyZi9UlRpeppwresq+aawwwMYJqJ413jL204fJ/0fp/bxikRhtnyKG
         TPeFW0ZdBrjSyy6QfGXIBMqfqJtk58JGkPVcK+A35VMTSPtSZGcVpDbIO6WCp7qWdyTf
         j0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542931; x=1792147731;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnvb6IoXLtboBhPj/eQLUwWel52Sh44jyIkRV0mHrrg=;
        b=HApbUsAQTiAWOlI21G0p538NbvleQCOjUolcTrtd2woNuM2eWzmy/RZqRplLktoVIc
         uMoy2r98be0UCj3kXaF66KP62wCoTPibkRCyb9RIHf4G7FN85sPYF4VOK049onIIPD58
         1RBmu3xcArnbxrcNzYoxN2yA80BvRAFDkDBnfF7xym0aQM22xnpdlLXcHPQb8k7stYec
         IwGkTDMImrNkb6iOFptd7YVTmzwcqcBRBHeqo5asbocRHyVaWZVloJ7XTrjv8I9PkFLd
         2i7Hsbq9IBf7SFxPO9757bZluN0qDBA1MBZe8G4JQJtT3YerWeqEE3WdVqnPKNakmUFP
         2Q0w==
X-Gm-Message-State: AFq9FYKj92+f2UPnykfgl6pxI7cGO//K2SRfJ/gs7V2x/dV0tkKf9+AL
	dOfafBl6SXdtmFKlL6mB2Dh786CgSzgl9U8slasLxliEAMHKXpGzPFNbTrg/Cnbh
X-Gm-Gg: AYBFou23jk4iA12tXVKjb66gqB6KBIu28/hYiCZvSmB7KkDZ6ya07X/ihas7y/XArZW
	4hWJECvflFST0/EcNrACZR/GH3dXesypryH7uI2pjRhZeEIF35vT43ujV8nh0ZOvEycn8+TinWB
	vS+NMf4inVrxkXRqYeIt3KXIxAFzZ+MVse+IU7n/imOSjrz6idsdLYRQEznmuE45wmPFnwySKke
	Nn73+m9WL3hGRW9HP5gJtxtTH13clF0M6P5onPFEu49EcItSbH7reaA0FU5a73hUIs1gUqHsGEz
	sSsn50BIyNSV2bBChgy1xCqw/qkFnxiBvjg/TRcuWhml64UTzbohoVMfesWyOB77SDuHIgUDCU2
	ekYBInlNmG7Twp2FXIycET6jtQ3cf9HkqG7Dx1pFrpttYS2UOsTiKW+9d+Z7bRUIShpc9Ja28ok
	irkFGhC7EUWYifaPXLJtbg3fdPvBA4uhfyIqvIXoShQnp7RveGBOGIIX6O9DKeTMMAurO+ejfDZ
	0HJah/feWpDbVw=
X-Received: by 2002:a17:90b:37cb:b0:3ab:2c2b:1034 with SMTP id 98e67ed59e1d1-3ab39fdb5d0mr1455842a91.0.1791542930793;
        Fri, 09 Oct 2026 03:48:50 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:50 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 42/51] selftests/bpf: tests for stack pointer spills/fills through atomics
Date: Fri,  9 Oct 2026 03:48:00 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-42-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Check stack write tracking for atomic operations:
- Restored by 64-bit load-acquire, xchg, fetch_add and cmpxchg.
- Spilled by store-release and restored by a plain load.
- Restored from a caller's stack slot by xchg in a callee.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c      | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 43f616ea90a9..ae4c5062cfa6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -2696,6 +2696,127 @@ __naked void atomic_rmw(void)
 	: __clobber_all);
 }
 
+#ifdef CAN_USE_LOAD_ACQ_STORE_REL
+
+/*
+ * An 8-byte load-acquire from a spill slot restores the spilled register.
+ * The store through the restored pointer is a definite write to fp-8.
+ */
+SEC("socket")
+__log_level(2)
+__success
+__msg("r2 = load_acquire((u64 *)(r10 -16)){{.*}}use: fp0-16")
+__msg("*(u64 *)(r2 +0) = 42{{.*}}def: fp0-8 may_def: fp0-8")
+__naked void load_acquire_fills_spilled_ptr(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r10 - 16) = r1;"		/* fp-16 = &fp-8 */
+	".8byte %[load_acquire_insn];"		/* r2 = load_acquire(fp-16) */
+	"*(u64 *)(r2 + 0) = 42;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(load_acquire_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_10, -16))
+	: __clobber_all);
+}
+
+/* An 8-byte store-release spills the register, same as a plain store. */
+SEC("socket")
+__log_level(2)
+__success
+__msg("store_release((u64 *)(r10 -16), r1){{.*}}def: fp0-16")
+__msg("*(u64 *)(r2 +0) = 42{{.*}}def: fp0-8 may_def: fp0-8")
+__naked void store_release_spills_ptr(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	".8byte %[store_release_insn];"		/* store_release(fp-16, r1): fp-16 = &fp-8 */
+	"r2 = *(u64 *)(r10 - 16);"
+	"*(u64 *)(r2 + 0) = 42;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(store_release_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_STORE_REL, BPF_REG_10, BPF_REG_1, -16))
+	: __clobber_all);
+}
+
+#endif /* CAN_USE_LOAD_ACQ_STORE_REL */
+
+/* Stack fills through xchg, fetch_add and cmpxchg instructions. */
+SEC("socket")
+__log_level(2)
+__success
+__msg("r2 = atomic64_xchg((u64 *)(r10 -16), r2){{.*}}use: fp0-16{{.*}}may_def: fp0-16")
+__msg("*(u64 *)(r2 +0) = 42{{.*}}def: fp0-8 may_def: fp0-8")
+__msg("r3 = atomic64_fetch_add((u64 *)(r10 -16), r3){{.*}}use: fp0-16{{.*}}may_def: fp0-16")
+__msg("*(u64 *)(r3 +0) = 42{{.*}}def: fp0-8 may_def: fp0-8")
+__msg("r0 = atomic64_cmpxchg((u64 *)(r10 -16), r0, r4){{.*}}use: fp0-16{{.*}}may_def: fp0-16")
+__msg("*(u64 *)(r0 +0) = 42{{.*}}def: fp0-8 may_def: fp0-8")
+__naked void atomic_rmw_fills_spilled_ptr(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r10 - 16) = r1;"		/* fp-16 = &fp-8 */
+	"r2 = 0;"
+	".8byte %[atomic_xchg];"		/* r2 = xchg(fp-16, r2) */
+	"*(u64 *)(r2 + 0) = 42;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"r3 = 0;"
+	".8byte %[atomic_fetch_add];"		/* r3 = fetch_add(fp-16, r3) */
+	"*(u64 *)(r3 + 0) = 42;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"r0 = 0;"
+	"r4 = 0;"
+	".8byte %[atomic_cmpxchg];"		/* r0 = cmpxchg(fp-16, r0, r4) */
+	"*(u64 *)(r0 + 0) = 42;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(atomic_xchg, BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_10, BPF_REG_2, -16)),
+	  __imm_insn(atomic_fetch_add, BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_3, -16)),
+	  __imm_insn(atomic_cmpxchg, BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_10, BPF_REG_4, -16))
+	: __clobber_all);
+}
+
+/* xchg returning caller's &fp-8. */
+SEC("socket")
+__log_level(2)
+__success
+__msg("r2 = atomic64_xchg((u64 *)(r1 +0), r2){{.*}}use: fp0-16{{.*}}may_def: fp0-16")
+__msg("*(u64 *)(r2 +0) = 42{{.*}}; may_def: fp0-8")
+__naked void atomic_rmw_fills_parent_spilled_ptr(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r10 - 16) = r1;"		/* fp-16 = &fp-8 */
+	"r1 = r10;"
+	"r1 += -16;"
+	"call atomic_rmw_fills_parent_spilled_ptr_callee;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked void atomic_rmw_fills_parent_spilled_ptr_callee(void)
+{
+	asm volatile (
+	"r2 = 0;"
+	".8byte %[atomic_xchg];"		/* r2 = xchg(r1, r2) == caller's &fp-8 */
+	"*(u64 *)(r2 + 0) = 42;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(atomic_xchg, BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_2, 0))
+	: __clobber_all);
+}
+
 SEC("socket")
 __success
 __naked void imprecise_fill_loses_cross_frame(void)

-- 
2.53.0
