Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF719347BD9
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770380438; cv=none; b=YWcWKaKAkOjGaZtYi/5cSXBweoquURUJPBNrMr0sXdJEPwcRFxQWvujbeXkpCdrjjq11RszMhJfBhAfgKeWs3a2EtJV/pucaAWVxL0u9FjKT7qn0Ic3F8kOCh5NOwVNhtmXtP6iFrPYzixO+XqS4HP75Opn9CJmdqEA4UGtQce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770380438; c=relaxed/simple;
	bh=w5NGJ74MU5R3R7DpzqJ2S6IYEkng2ht1IhcPzlGqqV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjFQLTb5qaoVre8/K3mmLOKDzK2S1c9uCOv4ixqwssANT3AUbmIwzjT1yvsRuh4V8C1v301FyHJ8oaTvvLM7+toPGUYdyUlcuE8Rf/aFRM4AADTMzMHlPRlW6wuvzCbTGuplnG4pPyPizMUIVXnFwNrzkgo4yl5BUo8bLLQhLYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5WIf1X0; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5WIf1X0"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-354a2a7d90fso1118720a91.2
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 04:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770380437; x=1770985237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5ZW0Lp2uS+rJ6cqos6DM9CIgCyO+gQDhoGFyA1Jyks=;
        b=O5WIf1X0Ig3XVBnQ5Av81M/eCfJx6Qlv1CxrCElqE35Rrq8ymRP+cN2mhMoTENgBZu
         8w2S/orTAw0hhyF2IdunTItg8o7tDAOpseX9qyUA6AJX7rF3eEK3SRDXfov2P0JSK8aM
         zVPcC01GOiE8QvKeNdFyqtWPDeZQjZ1Z/PvZArZzv2Bqq7tld84AGfOSvf8G4+5blobO
         dz81H2WE3MoEGfji+QXFfyGaNSiaFOJR+MBvBGguUUYtgkNEc7TYGssUKWOwK8mTRFLn
         wiFo9GRSKsThnPPtE8lJY7WEKh97ExpEiAKN9oMExuTi2DaD91T724NK8nP5QxlYTKTu
         H1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770380437; x=1770985237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n5ZW0Lp2uS+rJ6cqos6DM9CIgCyO+gQDhoGFyA1Jyks=;
        b=BmU0nsYk82ka+3g/iE7d1J0sI1BHLrgIR9d+20BFsX9RgUa3zcAN9dL/wMrL7EPCHn
         cfO5xhMZZcWj7rfK1hBib5mgd+Ch+YEFNPtFgmBT9mOQ5fKt2MPyxIBI6iil5BX9O5Lu
         ae/IboOKF0nc90e48hC0me/0RbvQxZtOWfrVguyPLm9norVIRBqXdSiTjPFXIK+L9+iq
         ljQI/RY+5Vr71fNuFx3cxV7wwYfS9yHPKs7q1ZVcFMtrCRkQ8EgJLIk9BGfC66lpRfie
         bDFSQZ7UH/uMRQyayEq+JtMDU/HQo0ONkqDn3KtPclnv+HFo8DGrD3aLiOIw+mnaVXKY
         YgsA==
X-Forwarded-Encrypted: i=1; AJvYcCWpPKpv0nQPW470+TIM7RUNSk2aJmxqZ2bZB/CpfItFqA+hRb41xMxJF07JkJ7Hx+HhH60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0PJEn8YPQcRYy7Eqqc+aM+ZxkwE3Chw9A0E6bglxiHM7iUB90
	MaF5C9Oj3NdTX8NGOabwdHInC11ZuVGO6kbQU03smnQjvBYmcAn5egQc
X-Gm-Gg: AZuq6aKYOPFTgl394BtQtiwuAvg+6fpguObYaEKsN2vZbMK7yvvQ9/pVsd0d6pIyzFo
	FST76IKEJpiG8AGmMao9UR0pqBktiDmuninC4ELKxGMHMB98JyapSuDSZFHZ5cjhe1vobiqy88c
	tvLIkLCZGWcPt2+eQhRvsX4jpGtL49+p0AxdUrXgAKCIw9Z5mNnfNERVPYGrKi5v/ozXH/YESdy
	T2guLRHr6ewx3Sp/Mzp5cMnEthdEOhxniXE8+LJLvPduoU24UtSURw2+dbuXY8ooh5h+StwnpiS
	Q6n9qLoMrhpnjd0/Xaeb4qzmLrJPtaH/5y+Uphf8G8yYs6O+Y710U8mRdqa8/756/wZ/DWQCFlh
	lPZGra7ZPdPPwYJjYfhObK2sXDwPuCahFbWCGpVKolcPJtBrH4VGQXKg0Xz5KnMsm6gUlARMAUV
	Su7uZKY9JA
X-Received: by 2002:a17:90b:254a:b0:341:8601:d77a with SMTP id 98e67ed59e1d1-354b3e4c67amr1926559a91.29.1770380437161;
        Fri, 06 Feb 2026 04:20:37 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b301d93bsm1528222a91.1.2026.02.06.04.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 04:20:36 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	bjorn@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH bpf-next v3 1/3] bpf, riscv: introduce emit_store_stack_imm64() for trampoline
Date: Fri,  6 Feb 2026 20:20:00 +0800
Message-ID: <20260206122002.1494125-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206122002.1494125-1-dongml2@chinatelecom.cn>
References: <20260206122002.1494125-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a helper to store 64-bit immediate on the trampoline stack with
a help of a register.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Tested-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Björn Töpel <bjorn@kernel.org>
---
 arch/riscv/net/bpf_jit_comp64.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 37888abee70c..e4f45e2e7e2f 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -926,6 +926,14 @@ static void restore_stack_args(int nr_stack_args, int args_off, int stk_arg_off,
 	}
 }
 
+static void emit_store_stack_imm64(u8 reg, int stack_off, u64 imm64,
+				   struct rv_jit_context *ctx)
+{
+	/* Load imm64 into reg and store it at [FP + stack_off]. */
+	emit_imm(reg, (s64)imm64, ctx);
+	emit_sd(RV_REG_FP, stack_off, reg, ctx);
+}
+
 static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_off,
 			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
 {
@@ -933,12 +941,10 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
 	struct bpf_prog *p = l->link.prog;
 	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 
-	if (l->cookie) {
-		emit_imm(RV_REG_T1, l->cookie, ctx);
-		emit_sd(RV_REG_FP, -run_ctx_off + cookie_off, RV_REG_T1, ctx);
-	} else {
+	if (l->cookie)
+		emit_store_stack_imm64(RV_REG_T1, -run_ctx_off + cookie_off, l->cookie, ctx);
+	else
 		emit_sd(RV_REG_FP, -run_ctx_off + cookie_off, RV_REG_ZERO, ctx);
-	}
 
 	/* arg1: prog */
 	emit_imm(RV_REG_A0, (const s64)p, ctx);
@@ -1123,13 +1129,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	emit_sd(RV_REG_FP, -sreg_off, RV_REG_S1, ctx);
 
 	/* store ip address of the traced function */
-	if (flags & BPF_TRAMP_F_IP_ARG) {
-		emit_imm(RV_REG_T1, (const s64)func_addr, ctx);
-		emit_sd(RV_REG_FP, -ip_off, RV_REG_T1, ctx);
-	}
+	if (flags & BPF_TRAMP_F_IP_ARG)
+		emit_store_stack_imm64(RV_REG_T1, -ip_off, (u64)func_addr, ctx);
 
-	emit_li(RV_REG_T1, nr_arg_slots, ctx);
-	emit_sd(RV_REG_FP, -nregs_off, RV_REG_T1, ctx);
+	emit_store_stack_imm64(RV_REG_T1, -nregs_off, nr_arg_slots, ctx);
 
 	store_args(nr_arg_slots, args_off, ctx);
 
-- 
2.53.0

