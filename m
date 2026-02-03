Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9E62777FC
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770097980; cv=none; b=kACoqw1Ru5YOHOjCoKtvBCIbmHdBxwYMqIEC7uITSXyKpQnhODl6QDrSsrX0HfuNLu/78DlJlU3OWUQfVo6zXIqDiDecWWETWirsLPQ/hpCvoNINSo8stXjvEIw8++WIsEiQW1Fvhu2FWben2JkQVbLL6qTUkA559a015S9pCiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770097980; c=relaxed/simple;
	bh=070F55rMJkahswIvT4jf6jx3vQtTz2wLV+jQ3NAeigI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t30dbRCCaVkw52r+O01k5+E6zIxOQfRKKOTxOjpYDqhJwJvwnTt7ucqmhCBcCQA06db0VfcNFj4UQJWbSDLRJhV1gVhTMEYg4J5LQk12Bg/OoLNPckVUBjJELXrTcNrNuf0aNLDsy+rC7CCnWU7ZRsMWDUR/oPEOI3o/mpCX2XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbDqcrEq; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbDqcrEq"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-5014b7de222so54808051cf.0
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 21:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770097978; x=1770702778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzVkfCKgUCL7plixo/BQ6/TFm6BL7pd9AJ8r1pM28SI=;
        b=IbDqcrEq+9tiqyfkS40tPk90jEukTVjGONCcb/6W1iwcBDlkHoZkpxzT08KzMsqjUA
         Qla1cOx/U5BI9YgsAsLur2zUYvcgEfXaRdugWzrDa/F4DPa3g4lbmTpEYZvTfVsxXLHv
         3LxXwy6B0jQ0EgXgZogYYMKh2gsEBmDPStRUzYm8IYeOF+iRQ1MXzbQJ0K20ik9fQfFX
         jiq7WFWWkySrixU9ycDjsk6eEbEBsmDGggdAIC0MzW7hzm2u/6h99C4qfeIi0lpTfl14
         KlfNO2GSE06mm6vcDDx/nxm2qrsH+gch8I4H1BAkxpcHfy7z7MuGwMD95LrfB9qqWkpK
         DmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770097978; x=1770702778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PzVkfCKgUCL7plixo/BQ6/TFm6BL7pd9AJ8r1pM28SI=;
        b=MOTM1wuRIPPJ6reGK9Jnqe3yDIieLsksF2rnD2Yl5Ijzp2A8w9BhAdynFLZhYFF76x
         pTMwkk1B1GH4yo7sHtzFekYaA3F4FnQ2rDSWYqFjhV4Dshn+TA01VZ31izlvzi57feLK
         EoLKi63lhsmLv/ckYXlKIy9q3E2UeEbm4A1vaAXbtn5rYhspI0riuF4kTkJs+m0BJgrY
         baL7us1/UJNeWmyHBp5KXIp+g6DugPUeVmGqeyTkp3NsNoVhQURHXHAVfllvFn75z7Gx
         9qa+QollKhrP8YYmSoQssT8YWxunHRvVtFO1ZFb/CaC46udsb/SKoAP4vtgYuj6Oph92
         riFg==
X-Forwarded-Encrypted: i=1; AJvYcCVzdGxeaVyDa7IHUE4win1fJ+tJUr2gW0XRGN9HjhdV8Ces3CpscrSNZybT8trtfe19r8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO73Q7bwR4wFaPlDaEXqBv0Zez3QsMFV6LNGgFtI1vj7cTxaE3
	DexHkOZFITENke8PxseeG5ikqtLDnTyBK07FcB76u1MjSlLjbKmU84Hr
X-Gm-Gg: AZuq6aJmSq1XlFE46uTq91w75WXXwvLGzKnvySknLiCMyTtSDZ77tgEN6eXcGumI5lo
	WvKTF6juIK8d8x9GcZpF6groAlqEjYDpONw/ONhmCGkCAtW+elalc0do6O5jIhj1Wum5Dyd1h8z
	LjJ9uDFkvlU4Xp+yFglF8Td2ISj4ptq8ATFKhQXqPwgGKkb3FVf4nnX7EWu6/EqdoO0ucHuZ3x+
	JruaBruPM5uyh6NFFTIn9g03G7Juq7hcUitLAaPq8PHs6ysri/YYzIjRd1dtwyd0lqXllNDzUrj
	ZkeFj0zkxKJUSqiAlmAFXB8fNTMfCOeK63Rgcwz3fjl2UayW1VdN49V7tjqAtQxwHly7/i8Il2K
	QaaahKZYdrX0kmBpnw/NnkzUW0D3WS3bNnUwTIO4Kj353ak58Bq8g3Aivcb61R724jmzx7FSpE9
	/wB9HFrOM=
X-Received: by 2002:ac8:5a0d:0:b0:4f4:e15d:f220 with SMTP id d75a77b69052e-505d2183d83mr151199911cf.25.1770097978028;
        Mon, 02 Feb 2026 21:52:58 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d376e65bsm129844996d6.55.2026.02.02.21.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 21:52:57 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
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
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/3] bpf, riscv: introduce emit_store_stack_imm64() for trampoline
Date: Tue,  3 Feb 2026 13:52:29 +0800
Message-ID: <20260203055231.1088479-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203055231.1088479-1-dongml2@chinatelecom.cn>
References: <20260203055231.1088479-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a helper to store 64-bit immediate on the trampoline stack with
a help of a register.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
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
2.52.0

