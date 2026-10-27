Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118514;
	b=weCD+fDhv9rk87LGRGoIY9KQMfOd8j00q+Q7QXiRSsKLjdNfFAVW7pexU78DMQYB9ewI
	 r8/1qEinAWf8ygSLpmG37IWj9ZswvmqhxtQmoyqawn51x3oimlTb2SBd5QqNOZ3zxwtV6
	 rlOR76nTNgKiO7Pky1F/heJyruP2OYVnFMwWqaOmx4YJ8sWqvNYuULGIfLqh2TJdZsyTw
	 W9wz5B0T0D0BjIwg2uSrcd+VBYQFCvUfhm8B/468lmhtfnXk0yVYwiMBuTRorI3MNGiOc
	 XKTVzVDzeWze4xA7MVVDOPlUPTmB+sCn0jYIi3FBGychDbXOW1MrILlF2++0TO+KxdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mr4NbpVnZieh+axeFmkOjYFlz83oPwChhcywo0pnqpA=;
	b=vY/aCCwJssca9oADzCkcc2uKZ6pdgO5/6CR2qrtDWVsVXtXQA9qPdA1yTVDDRSSVFzgX
	 wwk6WXPyGFjt3HW1SlpGXgRqYCcBbVx5Lbj73/3tQzCPfCf4vILSiIvs7aEptUREBG/HW
	 QraiODuzV93abMUv/yTj0bqeetZ5ZlGY1se9e+qVu50lTtl+eD7dk0Ql52UbU3IcXRrZW
	 EUfO6owTIM7KCWGVrNwnsCt0wEEe7nhXdJ5wbGmigbLLeYyo37/19g4An26hCLs49wwUu
	 ppeMjgcbef2jGDP7EpFa0iTBunzQPanVnXFdL52FQ7x5P+P1mBR9PIdq3Y4sitGviSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=mXZZPIOp;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D3606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB5D3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=mXZZPIOp
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so63612b3a.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793118513; x=1793723313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mr4NbpVnZieh+axeFmkOjYFlz83oPwChhcywo0pnqpA=;
        b=mXZZPIOpTECuRGBvSY8Klxo6OUYetoGiGU0mEeEi/3j6Qfu7ysWdI6Ku6KmOMs0q/r
         nzR/6ZZF/CfZG+HyT4VwEO+t1VLpCC4hKCdzaA7NGhJZHvgx/aDELCXho93FA27tUPd7
         XDyXKmziy9ukM6xB+pql/7y3U/gCfcUnXhbUkxG0qeE3WjuM4KUbDKSaNJPJx2z18Fg/
         zhAbE4f8FknX1XXx4RL/DtgujlCaFjneBUOXKgpS2/8mH1MsU/iRtHBpmQecviP+68Db
         3x2XLXGSa5ZyJd14DkC5Dm1b6P5rmFj+312vRPdK7h3p0NY+B61LLQSmptgono9ZIRc6
         QmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118513; x=1793723313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mr4NbpVnZieh+axeFmkOjYFlz83oPwChhcywo0pnqpA=;
        b=FQt4HBhCxzR/vq9WWIGXmXb4yqv5UDkbJ9YGlbK0aDkvaBcLEPgx5XFlT4aheO3F7L
         W5PORIj7dQf/GlBnRFUBaf5lJJVGpE/ySwUqZXdClrmgI4JQZvjALoq8n4KGBsLUBq8F
         bDqeay0wF2ENWvZDn+HXujk9K+BRqfXINAWsfe2Slu6HQzOlSWajHN1iH16mtGPVrRFi
         ZF+gx3dUxGrqSlOocx4mXP7yrdK5YRjtFSHIB6FCOyDE0ukQF/LXwPyFMcJ4pOnKR1W+
         zGdD1I0ZSjAFCtWJi2TPBp8QsqTBrcD72I6q9L5ru7OST82mGHYC2e5/Byz6EbtRVKYB
         XX0A==
X-Gm-Message-State: AFq9FYIxFhSGrDQtl/HJYxdRVF43MNk5Dhk6BiKIWO5ny3Us/VAwKclI
	S0uwIls9UOpcYk/DILaPnufzY6QQy2196pQcEt51Wy0HgyaSNiA9buAhGO1fLxa8qPpzk7kjc+1
	n8laCp0Q=
X-Gm-Gg: AYBFou3N3UluYAhOKkHSRUMLpUdAWYwJmQAzIEyReqKII0qYF1aPnRyYPLjKUpuLVRB
	UxoC6ucjdI2rG3n/Zwd4winX0m+VWX8kmmg0n+9N5jKKTvQ7bLmiHA/yISXtrPhRh4IQOBnnfiS
	YvvhDUe0AR76nYT9YU7kg/VEyff3T0qAW/vgvz8kzjEBkNJYvDcCcV6z5RpFIVjv2E1mE6O6ZAx
	hMTGIy2p8aVCKKD4RsudWkCL0v5P+Rh+lQWKr0kmROnnBp5YF1aAjNjKPCGK2Kib7HZul/zPJz7
	LuEyAvjbtETBiw4Rsu4AXYsw6yzgmyVfUIa0YG/UPEYiNWoyU0C01LuEggYw6Y3D4rrLPgP0z1h
	UuOEFp3KQAYR/31Y3j9o8wQR2BmrEy1IeXaEUx9WTIXdiQ6tYISkEHIGl12DmwgXBDvZDTf4bWt
	FzGfcuy2ubAvCyPAkcf1yuQrXQUBPnV+GMYS9gPBgV1vNxfiWbKN3QDTyWcJzdiUKDjlAGN9ePE
	215cVJr1A0G7TvzJA+YGpOF8dsIuxLbh2oobpzpEIiU85gKSpILRhYDMYsbLQ9/nFxsqluYF0I3
	x4HNr5eCbcdq+ZQ8Bw==
X-Received: by 2002:a05:6a00:bd84:b0:89e:f2d2:1eab with SMTP id d2e1a72fcca58-8a36705e339mr7044560b3a.42.1793118512998;
        Tue, 27 Oct 2026 09:28:32 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662c913sm257286b3a.31.2026.10.27.09.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:28:32 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 1/7] bpf: Add internal IRQ save and restore instructions
Date: Tue, 27 Oct 2026 16:28:14 +0000
Message-ID: <20261027162820.10887-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027162820.10887-1-emil@etsalapatis.com>
References: <20261027162820.10887-1-emil@etsalapatis.com>
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

Introduce a kernel-private BPF_ST | BPF_IRQ instruction with save and
restore operations. Encode the flags-pointer register in dst_reg and the
operation in imm, leaving src_reg and off reserved as zero.

Add a JIT capability hook whose default implementation declines support,
plus disassembler output for both operations. Architecture backends opt
in separately, and the verifier starts emitting the instructions in a
later patch.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/filter.h | 13 +++++++++++++
 kernel/bpf/core.c      |  5 +++++
 kernel/bpf/disasm.c    |  8 ++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index e0218e677a1d..bf67dfa19c17 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -90,6 +90,10 @@ struct ctl_table_header;
  */
 #define BPF_NOSPEC	0xc0
 
+#define BPF_IRQ		0xe0
+#define BPF_IRQ_SAVE	0
+#define BPF_IRQ_RESTORE	1
+
 /* As per nm, we expose JITed images as text (code) section for
  * kallsyms. That way, tools like perf can find it to match
  * addresses.
@@ -598,6 +602,14 @@ static inline int bpf_atomic_load_reg(const struct bpf_insn *insn)
 		.off   = 0,					\
 		.imm   = 0 })
 
+#define BPF_IRQ_INSN(OP, FLAGS_REG)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_ST | BPF_IRQ,			\
+		.dst_reg = FLAGS_REG,				\
+		.src_reg = 0,					\
+		.off   = 0,					\
+		.imm   = OP })
+
 /* Internal classic blocks for direct assignment */
 
 #define __BPF_STMT(CODE, K)					\
@@ -1277,6 +1289,7 @@ bool bpf_jit_needs_zext(void);
 bool bpf_jit_inlines_helper_call(s32 imm);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
+bool bpf_jit_supports_irq_save_restore(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_callx(void);
 bool bpf_jit_supports_kfunc_ret_reg_pair(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3030beb531d9..0ab9a210e1e8 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3383,6 +3383,11 @@ bool __weak bpf_jit_supports_percpu_insn(void)
 	return false;
 }
 
+bool __weak bpf_jit_supports_irq_save_restore(void)
+{
+	return false;
+}
+
 bool __weak bpf_jit_supports_kfunc_call(void)
 {
 	return false;
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 889fc074496f..125e2c5754e9 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -9,6 +9,9 @@
 
 /* Only defined by the non-UAPI linux/filter.h, which this file cannot use. */
 #define BPF_PROBE_ATOMIC 0xe0
+#define BPF_IRQ 0xe0
+#define BPF_IRQ_SAVE 0
+#define BPF_IRQ_RESTORE 1
 
 #define __BPF_FUNC_STR_FN(x) [BPF_FUNC_ ## x] = __stringify(bpf_ ## x)
 static const char * const func_id_str[] = {
@@ -294,6 +297,11 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->off, insn->imm);
 		} else if (BPF_MODE(insn->code) == 0xc0 /* BPF_NOSPEC, no UAPI */) {
 			verbose(cbs->private_data, "(%02x) nospec", insn->code);
+		} else if (insn->code == (BPF_ST | BPF_IRQ) &&
+			   (insn->imm == BPF_IRQ_SAVE || insn->imm == BPF_IRQ_RESTORE)) {
+			verbose(cbs->private_data, "(%02x) bpf_local_irq_%s(r%d)",
+				insn->code, insn->imm == BPF_IRQ_SAVE ? "save" : "restore",
+				insn->dst_reg);
 		} else {
 			verbose(cbs->private_data, "BUG_st_%02x", insn->code);
 		}
-- 
2.52.0

