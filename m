Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4AC312825
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 02:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787280643; cv=none; b=kjAgrWV6+DcpztB6r7o8C74CuBIpSYXOYCBEOCP0t9SMoKVrRRhcP1flZ2YFCkvmcE1a/aGeS17wtqcXUKlQaRg1rctKJeyj0lii77wyXjvJ3aIZHEvz8Api0ZEJzni0qQp/cSModU1katAKUV8RnSMV7QCT3tDWhaKqU96tkYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787280643; c=relaxed/simple;
	bh=BYrml0pMXKQLTy35R2yD094JYC3Ix+mC4M+c8TqmOhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHCsuJXeHcrdAphSUXm7xvshv5aJ0kJjdrXsdu3TDK0LQPYDW7eNXzKPq5BqOHK3APq5ATj3+pk5m2+Kdcn6psC635mjhj9CIXHulTBONo34YoCnh+EAv6fmHfQ/RWDtAPMNbbtQZYAjwlo2ojdFCJLbK3DV6DNlk5hrZSjtqm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbxuDefy; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbxuDefy"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66c70f05859so824736d50.1
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 19:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787280641; x=1787885441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bLHl1jCdXwSsUFajCWQ0rWHHmvya92XtyYS+pQ7tQVA=;
        b=nbxuDefy2rZdc4Im0sTdTOTjO0Kap96dfCNctQWBkgXx4iICCfhPorUOFmSXU/of+V
         +y2yYP6q87WzHWsOw0KMZ6a1FKYGN5U9rhd5FkXzTOu1Q9cyq2vTrtmV3y+TAavROpgK
         2TJW3/XjobtkV6wiO04c8veiHVxltoG26cKXhITPzPoncmMMjD3EH6NM1ajowz/9Me02
         p57mfdnJkXSK8hGb/XFrVzzSeoLjh7Q0vNJe6aez+eYuGwa1GDFV93RP/nIoNutVhqpG
         faOXmTSvPktpHfJqKdVFbMUBOuqkQNx4BENmjnr+caxTCKyRaPcrJsaTa7Mq8dKACoWp
         v2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787280641; x=1787885441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bLHl1jCdXwSsUFajCWQ0rWHHmvya92XtyYS+pQ7tQVA=;
        b=ski/+v30M8SclZSKrERLI8RFrTU05ZZIQdPuCTmwzwdi9dZJPja6MUwuSucoyDUqDo
         Elnd2w1BKJYVqCKxvRxF5hUB8BmpLX+dvOipJuXQ5dgVTnMRQpfQ3uGfLQY+hUx0fD97
         AGwrCLJyVDf09LipVUTh3wQzcnSmM0QRUHh+LlOcbeGQoPTUv77hjZPrSBTFHjlTxfSV
         1AXIWEGvTSKjsCqI1dKk+uVq2iM6PHEqWGJOKJvbiZd2K3hPqFunuTon2nmO02sde+u5
         IT5Mcv9MAi3BoAv6F/5AnPScVAx23CXlRVEgjs5bdWXJCYRpLJs3VOkwsoHB+wuUs0ph
         hr/A==
X-Forwarded-Encrypted: i=1; AHgh+RoStEApLbt+wwwyK1y/hEucxrbZKe/wLnfF+4FW7qviFb/yk1icMCh/yhC96THL3h+vSFY=@vger.kernel.org
X-Gm-Message-State: AFuF++kgjs3Cj1TyaRN+P90aapV4A4vVQqY45m37IGvX5jnguNKr6yWX
	Fzbpqk1VM9flbfT/U8zT83c8I+0thVCRYtGZ0IkfsEZUP4gcVDaFg9gL
X-Gm-Gg: AR+sD12SiZ5CSxAuu6CdRC941TAhUvJbXslMGchsiZhw2JGnwn52D/gwQYqn+msvm3c
	TaCQSIsGk/RZ99iu1/2WXNVMprN7LBYMFx9GZ1cMLbRqcuU7eL72sOyhQyOH86y3loSTrnzDBD0
	XWpTZyIxmcC5Ik+NlVOLs6bBn1wVkzFu8wtpAw+MI1S/iIAlm4JjHFifqLCQkgtSXQORY785HwX
	RDvzn+l4g75rr/GAwP00MStQwxj+fJKtu8/MuyuufJvgcmSTw1kjeFcf43RzsN965kdLlHY6IUI
	2Agh76hVzYyDKN4/U8KXg3B1hhfLG19z6l7fAWwil18svVi+CgVbIe8wkjCXmiC8u5xTUL1oygK
	pHX/FL+aT5oZhBNGe72nFtmNEqfj4zlmbQz+MDbrWDe+bKtgRjuND2PjivmPLRCaC1YCXY+bbAU
	/FLfEO7PCSdPH8g89OwJIVqr2l5lAaz7qjP/o0QFeP8cI6eibO6OAIu6rP1Q==
X-Received: by 2002:a05:690e:191e:b0:66c:d803:b45 with SMTP id 956f58d0204a3-66ce4ade1a5mr1490926d50.25.1787280641489;
        Thu, 20 Aug 2026 19:50:41 -0700 (PDT)
Received: from Turin ([187.15.143.241])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66ccb144956sm3682195d50.13.2026.08.20.19.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 19:50:41 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	johan.almbladh@anyfinetworks.com,
	paulburton@kernel.org,
	tsbogend@alpha.franken.de
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC bpf-next 1/2] bpf, mips: Factor narrow loads out of emit_ldx()
Date: Thu, 20 Aug 2026 22:46:39 -0400
Message-ID: <20260821024640.1601299-2-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821024640.1601299-1-main.kalliope@gmail.com>
References: <20260821024640.1601299-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor the byte, half-word, and word load selection out of emit_ldx()
in both MIPS JIT backends. The existing unsigned LDX paths remain the
only callers and retain the same native instructions, upper-half
handling, and clobber accounting. The double-word paths remain
unchanged.

This gives narrow loads one width dispatcher that can be extended
without duplicating the BPF size switch. No functional change
intended.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/mips/net/bpf_jit_comp32.c | 28 ++++++++++++++++++++--------
 arch/mips/net/bpf_jit_comp64.c | 18 ++++++++++++++++--
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index b3f6b92ac34ed..48a3c834453f2 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -707,24 +707,36 @@ static void emit_trunc_r64(struct jit_context *ctx, const u8 dst[], u32 width)
 	}
 }
 
-/* Load operation: dst = *(size*)(src + off) */
-static void emit_ldx(struct jit_context *ctx,
-		     const u8 dst[], u8 src, s16 off, u8 size)
+/* Narrow load operation: dst = *(size *)(src + off) */
+static void emit_ldx_narrow(struct jit_context *ctx,
+			    u8 dst, u8 src, s16 off, u8 size)
 {
 	switch (size) {
 	/* Load a byte */
 	case BPF_B:
-		emit(ctx, lbu, lo(dst), off, src);
-		emit(ctx, move, hi(dst), MIPS_R_ZERO);
+		emit(ctx, lbu, dst, off, src);
 		break;
 	/* Load a half word */
 	case BPF_H:
-		emit(ctx, lhu, lo(dst), off, src);
-		emit(ctx, move, hi(dst), MIPS_R_ZERO);
+		emit(ctx, lhu, dst, off, src);
 		break;
 	/* Load a word */
 	case BPF_W:
-		emit(ctx, lw, lo(dst), off, src);
+		emit(ctx, lw, dst, off, src);
+		break;
+	}
+}
+
+/* Load operation: dst = *(size *)(src + off) */
+static void emit_ldx(struct jit_context *ctx,
+		     const u8 dst[], u8 src, s16 off, u8 size)
+{
+	switch (size) {
+	/* Load a byte, half word or word */
+	case BPF_B:
+	case BPF_H:
+	case BPF_W:
+		emit_ldx_narrow(ctx, lo(dst), src, off, size);
 		emit(ctx, move, hi(dst), MIPS_R_ZERO);
 		break;
 	/* Load a double word */
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index ee99f46828c86..22fb58f970223 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -398,8 +398,9 @@ static void emit_trunc_r64(struct jit_context *ctx, u8 dst, u32 width)
 	clobber_reg(ctx, dst);
 }
 
-/* Load operation: dst = *(size*)(src + off) */
-static void emit_ldx(struct jit_context *ctx, u8 dst, u8 src, s16 off, u8 size)
+/* Narrow load operation: dst = *(size *)(src + off) */
+static void emit_ldx_narrow(struct jit_context *ctx,
+			    u8 dst, u8 src, s16 off, u8 size)
 {
 	switch (size) {
 	/* Load a byte */
@@ -414,6 +415,19 @@ static void emit_ldx(struct jit_context *ctx, u8 dst, u8 src, s16 off, u8 size)
 	case BPF_W:
 		emit(ctx, lwu, dst, off, src);
 		break;
+	}
+}
+
+/* Load operation: dst = *(size *)(src + off) */
+static void emit_ldx(struct jit_context *ctx, u8 dst, u8 src, s16 off, u8 size)
+{
+	switch (size) {
+	/* Load a byte, half word or word */
+	case BPF_B:
+	case BPF_H:
+	case BPF_W:
+		emit_ldx_narrow(ctx, dst, src, off, size);
+		break;
 	/* Load a double word */
 	case BPF_DW:
 		emit(ctx, ld, dst, off, src);
