Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577594;
	b=MeTh+oCuyUox3ku/TbHRuEc0q35wi9ttSNbFxKvo69pic8TE8af7MhjRbs3P8HF29f8h
	 sXrMYl53wfJcPy3K0SD9bvbd+Siwn5wWZw108MIs4z27z3FuSxIjxA47SJZktBvLBmUA9
	 UdOHdZEg72f3JGziwoHOVI0c/Sr8nffk6ntcKPwHrDbpwG79BZWvvu+ydnLTUxdCw3GBE
	 oIn26uTGZGPZ8DdhcZm27i/0nQVaBwF6Q3+m5MOdZMBduVnmqOB/2kxdnFOey8rTVcyV9
	 q3K05Q0OVl6euwZZObdgBMC1wVO0uOtNyIk7GNob5gxX35nSvZc3hUDqmss9ihU18CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U1G0yC/SdYduVVv5E1KnWR/IYhrT04ix7SQxTfBl5E4=;
	b=iFTS9JPNgX0ADC3XDt+GnnC5+wFV4KeBYdmh+oqq8vsH3Hnl2oKqUt4jDJ4Mv29r0/yu
	 U+DRvz/Jj2BDfrvUasCd4tGS1UvIalWPEQY+2WXKFXHh7M0MD1JyEeibm+T9LKNmHqaXD
	 6h4gwbdWjnrEh7VoOHaSGcsOA0hFto2I9p7WHuYH8kIWIkmTKAlcBTJck7O7Nsf+XiGkw
	 325/Rqll51Y/e4a2M90LqvdtH/1wEZb8X9SwgTI+fS/dd8ZzLBQkDF2ZXvDPcfRRYR1FG
	 9LByZuc1vFi089v4l1Ts0R6CTN6sENWXQe9TkRHx+ADguDTdmTmWk8+DGP5qCgq7j5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=phouk90T;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22295606A33C
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22295606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=phouk90T
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdb628232d2so2879796a12.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577593; x=1796182393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U1G0yC/SdYduVVv5E1KnWR/IYhrT04ix7SQxTfBl5E4=;
        b=phouk90TMCcFpFeji1eMFiVaoMvq6ZJEJKx1f5+SLOGCm+KwWfa91/24mb0XcSrOHz
         vbckwfPLx/AkEc4Yf8erHpjlo6xaiCff4JAGOPe/MemT2gZK+oj21iPdgVcH7lvgOEvh
         ocI1Xtklmfv85Qy+8RxDp6j2OdQiaENC0hTRbwdkgKroTDbPs64wTSmJayVy9mgg2H/+
         CQPnmyjUkytj1QGFWkbKL22O36vCSYE/OrtZaqmzh6M2H0D1B+CqG6+LutvLYhVImf6H
         rdZEj4gH081iMjQnGBECmBcjmnKAXXr1kzP8zS4pBKW0DFjIv4ck5qao01fYBTqvr7LW
         pGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577593; x=1796182393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U1G0yC/SdYduVVv5E1KnWR/IYhrT04ix7SQxTfBl5E4=;
        b=uH8q18Q7bj0qKnqeqUJl4YaUViIQE3TbzyMer1e8oudShng8nvc3Fr2TVsVrVfrJNI
         tWCEmtABWTc4uDO6+aANzN8Evs0AuH6cjHwuxs/in8Ca6MofY+x0vAbV1uIjsbw0EquK
         Qm2FI/+yrPzQ7aVLf9MWLW0XxBt1RKNy0AlkEGHSCHgqjMh8YkhIuES9YqIewdj+icSI
         ThyXMfxLoLYtDQ36gPZCYzJljoQqr4MISCCwAdG3O5KDzbUlMjMCaxLcvN7LSn+7LL0n
         TKde9Jh6z9d0ZfT10fN+pQnsWr+JKAJ5lAdgOxiRQcph0QIybpC6L9CJ7KTBeVdrSA9u
         YYcA==
X-Gm-Message-State: APuU4Z8LFMYRi67UBBUCG65MHogShddsidI8Yezz2q0PXhs2XYebdRiI
	GxFRMqc1ldeiJbZEBG8ODFs1F5s5su5T4RFfUPQDAQqaAN4VBKGQrWprT5zNrGJ7
X-Gm-Gg: AZFdTZeqaVyxWk0m2uyvOtngsXwJeuKDyW4DxsiviXrlsUlt4IwWAFcxY32qcZF8/HC
	ksyLYhWobWgUDj21UmKYDq7qdM3RG/6xFXt+18a1+SJgYo50Gb/d4E8W8KzWD2WFFmUaq+/kqo+
	cGGVEy42UQVX6fVSF8Yagw8w0LrWlT+sPaMiuvQqsW1BeVdFS3gjy0wfh15D51kwsV6t9stEz82
	KTxM5+BN/tuOzXZZW4IVUZ3yCPX6kfceJEwAllAPISy+yJmVJcOjbNl5Hrq7haSOYI3R5PshMPt
	Z2SrZ9XOs0xT8EJEyYuRAAMPtgyb+ROK2uZPzT53JOld5Obg1JcSTvXIWw43UODzyjG5jVrPa6h
	bvuBcioOo3QFXx8NroC+bDOYoS17tObFxt+b1hcfG5miZEdq46pPl5YK1N7E+M47YSmfMmzyPrH
	bLOgYDNWZvAaoJVqSfoB6byfC0rkisIDUWYFHdr+qtLws1L+8BxrBotoo+dLzU6p8RxJJZZEVxY
	ld0oRXYAtMgJeJF/GD3IRvt+MyaeNws/WzUPrrraR3E5e5SXdcT7xp51bxbOsxVcRiIqhe3zuNy
	FfPCInYut5SWgdR+daBXwPF8OlwLgJmku7tsg2Se9z/EZ8CfQdox3v/cr9DdEmzaoRB3N+oYZLa
	gj6Owvzj7jHF/3y9MU/mAmeRN7sUgYv1K31a1nrR8O9KUgw8+Lpc5ozZz1hgz372O4FzU0mkoEQ
	==
X-Received: by 2002:a05:6a20:9f86:b0:3e5:972d:bf1c with SMTP id adf61e73a8af0-4014ca448d0mr17378186637.11.1795577593323;
        Tue, 24 Nov 2026 19:33:13 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077babfsm8205709b3a.5.2026.11.24.19.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:33:13 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 36/47] bpf, x86: Fix the range of BPF code that has a frame pointer
Date: Wed, 25 Nov 2026 03:29:27 +0000
Message-ID: <20261125032938.670542-37-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The ORC unwinder trusts rbp between ksym.fp_start and ksym.fp_end. The
JIT sets fp_end to an offset in the code of the exit insn, and fp_start
counts the CFI preamble, which is in front of the symbol. The main
program of a program with subprogs and trampolines of struct_ops get
neither. The range ends at the epilogue, compilers put blocks behind it.
So stack traces with BPF code in them are not reliable, and livepatch
waits for tasks that sleep there.

Behind the prologue of a program only the return has no frame. Record
its offset in fp_ret and take all the rest. Count from the start of the
symbol, copy the offsets from func[0], and from a struct bpf_tramp_image
that struct_ops passes for the time of the call.

Fixes: ca45c84afb8c ("bpf: Add bpf_has_frame_pointer()")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c    | 11 +++++------
 include/linux/bpf.h            |  5 +++--
 kernel/bpf/bpf_struct_ops.c    | 12 +++++++++---
 kernel/bpf/core.c              |  2 +-
 kernel/bpf/fixups.c            |  3 +++
 net/bpf/bpf_dummy_struct_ops.c |  2 +-
 6 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 0624290633cc..a45668e971a4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2600,7 +2600,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
 		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
 
-	bpf_prog->aux->ksym.fp_start = prog - temp;
+	bpf_prog->aux->ksym.fp_start = prog - temp - cfi_get_offset();
+	bpf_prog->aux->ksym.fp_end = U32_MAX;
 
 	/* Exception callback will clobber callee regs for its own use, and
 	 * restore the original callee regs from main prog's stack frame.
@@ -3828,7 +3829,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 					pop_r12(&prog);
 			}
 			EMIT1(0xC9);         /* leave */
-			bpf_prog->aux->ksym.fp_end = prog - temp;
+			bpf_prog->aux->ksym.fp_ret = proglen + (prog - temp) - cfi_get_offset();
 
 			emit_return(&prog, image + addrs[i - 1] + (prog - temp));
 			break;
@@ -4480,8 +4481,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	}
 	EMIT1(0x55);		 /* push rbp */
 	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
-	if (im)
-		im->ksym.fp_start = prog - (u8 *)rw_image;
+	im->ksym.fp_start = prog - (u8 *)rw_image;
 
 	/* sub rsp, stack_size */
 	emit_sub_rsp(&prog, stack_size);
@@ -4622,8 +4622,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
 
 	EMIT1(0xC9); /* leave */
-	if (im)
-		im->ksym.fp_end = prog - (u8 *)rw_image;
+	im->ksym.fp_end = prog - (u8 *)rw_image;
 
 	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
 		/* skip our return address and return to parent */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5d4b0e5d56dc..3a5a0380304d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1426,6 +1426,7 @@ struct bpf_ksym {
 	bool			 prog;
 	u32			 fp_start;
 	u32			 fp_end;
+	u32			 fp_ret; /* a return in between, it has no frame */
 };
 
 enum bpf_tramp_prog_type {
@@ -1470,7 +1471,7 @@ static inline void bpf_tramp_image_add_skip(struct bpf_tramp_image *im, struct b
 {
 	struct bpf_tramp_skip *skip;
 
-	/* struct_ops trampolines and arch_bpf_trampoline_size() have no image */
+	/* struct_ops trampolines and arch_bpf_trampoline_size() have none */
 	if (!im || !im->skips)
 		return;
 	skip = &im->skips[im->nr_skips++];
@@ -2400,7 +2401,7 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_nodes *tnodes,
 				      const struct btf_func_model *model,
 				      void *stub_func,
 				      void **image, u32 *image_off,
-				      bool allow_alloc);
+				      bool allow_alloc, struct bpf_ksym *ksym);
 void bpf_struct_ops_image_free(void *image);
 static inline bool bpf_try_module_get(const void *data, struct module *owner)
 {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 71235df99cc9..5461e0ebab2b 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -640,9 +640,10 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_nodes *tnodes,
 				      const struct btf_func_model *model,
 				      void *stub_func,
 				      void **_image, u32 *_image_off,
-				      bool allow_alloc)
+				      bool allow_alloc, struct bpf_ksym *ksym)
 {
 	u32 image_off = *_image_off, flags = BPF_TRAMP_F_INDIRECT;
+	struct bpf_tramp_image im = {};
 	void *image = *_image;
 	int size;
 
@@ -667,7 +668,7 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_nodes *tnodes,
 		image_off = 0;
 	}
 
-	size = arch_prepare_bpf_trampoline(NULL, image + image_off,
+	size = arch_prepare_bpf_trampoline(&im, image + image_off,
 					   image + image_off + size,
 					   model, flags, tnodes, stub_func);
 	if (size <= 0) {
@@ -676,6 +677,10 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_nodes *tnodes,
 		return size ? : -EFAULT;
 	}
 
+	if (ksym) {
+		ksym->fp_start = im.ksym.fp_start;
+		ksym->fp_end = im.ksym.fp_end;
+	}
 	*_image = image;
 	*_image_off = image_off + size;
 	return 0;
@@ -879,7 +884,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 						&st_ops->func_models[i],
 						*(void **)(st_ops->cfi_stubs + moff),
 						&image, &image_off,
-						st_map->image_pages_cnt < MAX_TRAMP_IMAGE_PAGES);
+						st_map->image_pages_cnt < MAX_TRAMP_IMAGE_PAGES,
+						ksym);
 		if (err)
 			goto reset_unlock;
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 50d175fcef69..b34d9bdaf67e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -785,7 +785,7 @@ bool bpf_has_frame_pointer(unsigned long ip)
 
 	offset = ip - ksym->start;
 
-	return offset >= ksym->fp_start && offset < ksym->fp_end;
+	return offset >= ksym->fp_start && offset < ksym->fp_end && offset != ksym->fp_ret;
 }
 
 const struct exception_table_entry *search_bpf_extables(unsigned long addr)
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 59dcd91ed551..9d5f2774bf8f 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1572,6 +1572,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	prog->jited_len = func[0]->jited_len;
 	prog->aux->extable = func[0]->aux->extable;
 	prog->aux->num_exentries = func[0]->aux->num_exentries;
+	prog->aux->ksym.fp_start = func[0]->aux->ksym.fp_start;
+	prog->aux->ksym.fp_end = func[0]->aux->ksym.fp_end;
+	prog->aux->ksym.fp_ret = func[0]->aux->ksym.fp_ret;
 	prog->aux->func = func;
 	prog->aux->func_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
 	prog->aux->real_func_cnt = env->subprog_cnt;
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 191a6b3ee254..c724a6bc7b80 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -179,7 +179,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 						&st_ops->func_models[op_idx],
 						&dummy_ops_test_ret_function,
 						&image, &image_off,
-						true);
+						true, NULL);
 	if (err < 0)
 		goto out;
 
-- 
2.55.0

