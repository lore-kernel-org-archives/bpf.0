Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F33E388873
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355331; cv=none; b=G29fg/lVEoQ645SzO46ruhAzC697SZww6PRuAu5E7BrVULCCxCTx5Xn+Qt9HXgf7Gx7xjnayAwrMIVTGAOX4rbnnHs05K5l7ozm4sAlxYQlKpowimfJLvXFYajkrsOpUJRMew0KSs9Zs2LrnWD2lQIOKPMC+vYzF9ea+NMDt+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355331; c=relaxed/simple;
	bh=BHiWPs3dMVDO1/w9Zo0s0JrYrPXUPN+8EP1a8bI2MYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cflxTbj/LPSdUUXaUQcWNMla5/ghn6mEVXKJ8vlj4pGufOnwhzwkUdx7HqaUywU+4Yfh55gahqbfnSY7HX3CL1fMmQcmU3Q4tkiWDXh99KGC0V+U0Cvh2aGiChpbFmRL+zhSkrBtvoEYY4Lk6/f/fgulaQPtROSR6v9rugJ3t/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyK3il9V; arc=none smtp.client-ip=74.125.228.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyK3il9V"
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-6a3e9930062so1054504a12.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 16:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355328; x=1787960128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r8Le9b6XC7q34/4BT45MWQwO0c9itp2XX10gheB//Qw=;
        b=TyK3il9VmEG0S4it7GT5SrPySvcCUn1ZjUv6s8s7DijW2nMLdG9owS0pOc/nvRRMJu
         dJ2PAnMrCkDwMlZYK3W0YIQ2bH2yvdLijpob3WmYBy1dFfQTEGYBNjXg8mIjFp3h7ykD
         npfqebk7SwMSfrzmYlupiVO+7TOjlu1ixiTycVyDGo3sdtuOLIbsu1VIIKJ+SXhNS4sJ
         i4pYkZx9OWzKMkCQcX5M+vI0RLtJXD8tc5PFp5ND4nQ4+Rgb5iIduOSBIrVu8keQOxYZ
         UStvBL2834RQN1KY9wKmCeASUYsQXKxTqP/tWwCqK5YwNx3v1MGnqEW0q9MWWr7hzRPG
         ezvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355328; x=1787960128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r8Le9b6XC7q34/4BT45MWQwO0c9itp2XX10gheB//Qw=;
        b=gJp3fqcZDxrPdYEOsX8JfwJ6AF9qtIJ2kb43ddeH78l+pgf3PNx/amqe8JHUgTCbAK
         AKKSVkFMpMPUi1NvZqboIKBLpOnsC6iz6MiHIA+I+8k6ErqFp1dqHxjuo+SKV4ITBOS5
         7mc1m9eukxvP53tYdcNYTAV7YOX+foSpSHHGPVNLwqOPY4I9JjhDjEwU7EF7L+cPY9bo
         E8O+ODDOvAu59eH3yGy0ZkiHfvyi+Cwe1T7jzcH6ddOyo62go4U3xZpySsAaJHxkQg7Z
         JdENdjhZPqxZpMD6oq2XlhB+Id8CNjSVh3GfOL8JVmwhVaI2fDuJbXeoLKztcYxSH2WE
         rd+w==
X-Gm-Message-State: AFuF++mXqR3DtCT3F+QHai/0Vh60Y/rVdUSskl7IoEkn3qNqdPB4gWdq
	g8YCzkGgIdq/60s1ncSxX7CqLfshGzZzwMx0Wku+hQqrwQ0ObHk5qh8raQLUqFTH
X-Gm-Gg: AR+sD11R46dofgtybxIv5Qr8E6jrF4D9BppiAsP9nUe1lIb8IZkra/DilBx7egivUGL
	qHxsiXDNvWrDZRJXVXZC6oOcwZHBAA9eggslqTCq/YppnTUQxM8hp1ScNZwFPOne5kuem5tOTVL
	n8argbttHzDVC1kuCURKau1mniP+BTzvMEJ6p5lhM/Gg/t8im/G/wTrdY9R2LCWX9Z/iO4eSH6C
	EflzYoKfRw2O5+AhLhbqGcRW4rovey0Iz/1BLwTzK3h4rnbsR0OTz2ANKSNGZAc1hssHiDNAV6i
	VoLmwRguhbfJ03/ZlKxRkMqpdh0sVdpYtCPumZubmLyQVoeQtW0pxWJcYqOavvy21Dj1MnEF6Dn
	mcDcZGowjR0R6AnAaQGORcOhJH7F5Ez4c8XR6CROR+X/8NdTdEKo5Y3OjGt+4kmBIJROAuZHRag
	33HpZAa1bp+Prygd6Oe5y+OAr7RyfViMPp9iY4TQH6Z0pQpXiem/9QZ0j4U5FCOX3dF3y56M9It
	SR2sXCf0eBPBXdEWcEvwC6U0Ol32dGyGLRqnlalv59ElVg/mMMBTzQ3R+oWL8rGM1db/LqPCl0y
	5/Yaqb4ZOIfs1EJWUMeCek091oQ=
X-Received: by 2002:a05:6402:4613:b0:698:9e5e:5df8 with SMTP id 4fb4d7f45d1cf-6a42f1aca88mr9375830a12.7.1787355328323;
        Fri, 21 Aug 2026 16:35:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff170601sm8608682a12.25.2026.08.21.16.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:35:27 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 07/14] bpf, loongarch: Fix stack arguments for indirect trampolines
Date: Sat, 22 Aug 2026 01:35:01 +0200
Message-ID: <20260821233516.3426127-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821233516.3426127-1-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2626; i=memxor@gmail.com; h=from:subject; bh=BHiWPs3dMVDO1/w9Zo0s0JrYrPXUPN+8EP1a8bI2MYY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavjQe9btaJ/BxSYD/gXv/y+tHrSqmPnXwTvV8q6bTSDX ef/5xehHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjIk4uMDI8dQiMXPJlYn+F/ W0uaZ9MbA9VNr2INdc1OLAncoKbrkcrwP89B4LiF5L0N5x+bytU5CyUGFk8M5cjQzpDcEr1qibk WCwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

LoongArch passes arguments beyond a0-a7 at the caller stack pointer. The
trampoline store_args() helper always reads those arguments at FP + 16,
which is correct for an fentry trampoline: its prologue leaves FP 16 bytes
below the stack pointer at trampoline entry after accounting for the saved
parent and traced-function frames.

A struct_ops indirect trampoline is entered through a function pointer and
only saves its own RA and FP before setting FP to the entry stack pointer.
Its stack arguments therefore start at FP, not FP + 16. As a result, every
stack-passed struct_ops argument is currently read two slots late.

Select the source offset based on whether the trampoline is indirect. This
also prepares the stack-passed arena argument path to consume the actual
pointer slot.

Fixes: c9ebe2016de9 ("LoongArch: BPF: Support up to 12 function arguments for trampoline")
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 29c281bef28e..d193293a0fd2 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1662,17 +1662,18 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
 	return ret;
 }
 
-static void store_args(struct jit_ctx *ctx, int nr_arg_slots, int args_off)
+static void store_args(struct jit_ctx *ctx, int nr_arg_slots, int args_off, bool is_struct_ops)
 {
+	int stack_args_off = is_struct_ops ? 0 : 16;
 	int i;
 
 	for (i = 0; i < nr_arg_slots; i++) {
 		if (i < LOONGARCH_MAX_REG_ARGS)
 			emit_insn(ctx, std, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
 		else {
-			/* Skip slots for T0 and FP of traced function */
+			/* Skip the saved T0 and FP slots for a traced function. */
 			emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
-				  16 + (i - LOONGARCH_MAX_REG_ARGS) * 8);
+				  stack_args_off + (i - LOONGARCH_MAX_REG_ARGS) * 8);
 			emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -args_off);
 		}
 		args_off -= 8;
@@ -1995,7 +1996,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	func_meta = nr_arg_slots;
 	emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -func_meta_off, func_meta);
 
-	store_args(ctx, nr_arg_slots, args_off);
+	store_args(ctx, nr_arg_slots, args_off, is_struct_ops);
 
 	if (bpf_fsession_cnt(tnodes)) {
 		/* clear all session cookies' value */
-- 
2.53.0

