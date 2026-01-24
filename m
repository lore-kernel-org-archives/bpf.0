Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCEE25EFBC
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 03:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225547; cv=none; b=Ea7xzpo+FXFYh+k4lzTgoo14BEq4uWU05jC6Z3d2t14W/9HJAbg2KVxrZBdIGk9Lp10FWU1K9b980UUTxJwzKM0T/IUqYFk6jodu9YCy+cAxkcU1bY49VJPLrdP+mBd5CPgIj4ilhUFr5B+pYPmPrE6aOn4/Hm5T3WSQILFYJQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225547; c=relaxed/simple;
	bh=6fOLPr5pZFj/RQ+K6yXNXzxNF1aapP52tKW6Swnvtbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HatZUG3/RJOqfiNB7J0Apsm7xwcZ8TihZ8dQI4BgRcejo/DB7c/WG96/6JnyRAGr+odUGqjjBR7qQgehjyGfhgCmEj8+qTywhHAzzdQwY1XhjKmGGHCUZvw5guXLIyqrVVZzgWzzpogcBLM1gPH0BY3hGHOmnvfG1tSONzZ/s60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4sTzHWN; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4sTzHWN"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a76f90872cso15233235ad.3
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 19:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225545; x=1769830345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3QmrLYBEBYXBAfPFlkqBudM2njHTQyGi8eiKfdRBPI=;
        b=P4sTzHWN3PRDg0w0+2vgfYEanXxQwsSwI5djxfUsdXnEx0gwJbjRlFOtAwFoANjWvK
         Z4wTCb4T3A41r4t3Q/PphmNDFBZXslJYpsK/Zw05O4Iivq0nCc5uakFvpAxIkte1fxKs
         P3lUPaxtSnNdktQq3NszGF2T1Q+sbKK+dYFlF5JGprZiXPkgCxDhSRm5J7QhA/6aqNl7
         Ld64zW3potEWsHmLCthRwQODsAf034rD4vEep19b0dMcJVK27aNJgwi6t0NQMiBzR0HU
         W5B+rfBmICh61KvG/ywI6yewLwNWJ63J8hLgbtb4XUFMNcfbMGW0Q9z1wK7MShf/MHKj
         ro/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225545; x=1769830345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3QmrLYBEBYXBAfPFlkqBudM2njHTQyGi8eiKfdRBPI=;
        b=fR1A7qqpb/H+vxQWRTNHPNk7PmNl2NHSnL2EiqytPeRKbErLXiG52iKRdNlSYEDwSc
         x7R0LIRMXW8sBkXZsKP8gKPwqZhQJi2gF4Kfa/2tMS7Ug4PIHnIJ/Lq42aUNSJBsTBIl
         ThthkGNxlKqOplsSC3gZoaDG6taooRAC+z50ILSD8uc9CtC92G+Xueq4nQjWngEW7Tjo
         LdY9hdG4LasWTQAt3ZZRNTaHqxDKHKv5d18n02Lt/HR5fHNaFyqs0rt5g66Jw3FiAOFc
         g9s1Mm+/sKoSGUb9RHdMSWruXBdysDCTCC4UGd/x5gIec6Ms2HEMTybHqFBGiafXhZcL
         KmRw==
X-Forwarded-Encrypted: i=1; AJvYcCW7BausCO6890IianQtaU+rLgWpdwU3BVh/5vFE0+MT4d6nSuEZ6PU8I67pjPsQl+a8c44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoySMeueneoQ2HG6+yqFzP9CP1i37PFpfUB+y3iCmyWQhsevn1
	Y0EjF1GpjnBcKB54U0AuByYppDnpVA0utk94X1/r/HkdfSNRWp3edErU
X-Gm-Gg: AZuq6aJNGhw+ngjjRr38nxOJnGyoa3PGp/Y5COgOtCbvyRqT0YLbiOHBrwVYiZw17pb
	1EJ+WuPJv+LU80qsvoOJZV5gRGej7lIqvnNGOm7YiSVyHMpYKxMjcqyyjl2nSlBhm0XqAYfQPkP
	JtdZlF0SH9QGGy1G5aCBGAWuYWN106wazDHHoaZFxsftsJk6YiYSKjI7/xPyvo6QOFiM+/TZx+f
	Xf6wBBbJkPp+ClmuZR3rKJk5mV2waq4iN2klatqTZqlJB8LI4ngTTforgFBU8jPi/TTSHWrcw1E
	EZ2OTtcGEt7jsTOr5lJAMJGNYJ0N3WMJeMKMt7+Lcbv/1uknu0UO2AeOaGzVTqLOz8z4zVBBfdh
	KGesyAe35SyI9bjOmKXTYwjds6qpDjsVIM8ZXBzSIZTbqLsAkvTox3rY71rt9yQRq/Wqpe4QPfn
	U40yEiJvC3
X-Received: by 2002:a17:903:2443:b0:2a7:f369:4de8 with SMTP id d9443c01a7336-2a7fe73eb13mr49369805ad.42.1769225545358;
        Fri, 23 Jan 2026 19:32:25 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:32:25 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v12 06/13] bpf,x86: introduce emit_store_stack_imm64() for trampoline
Date: Sat, 24 Jan 2026 11:31:12 +0800
Message-ID: <20260124033119.28682-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124033119.28682-1-dongml2@chinatelecom.cn>
References: <20260124033119.28682-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the helper emit_store_stack_imm64(), which is used to store a
imm64 to the stack with the help of a register.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v10:
- add the "reg" to the function arguments of emit_store_stack_imm64()
- use the positive offset in emit_store_stack_imm64()
- remove some unnecessary comment, as we already have proper comment in
  emit_store_stack_imm64()

v9:
- rename emit_st_r0_imm64() to emit_store_stack_imm64()
---
 arch/x86/net/bpf_jit_comp.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e3b1c4b1d550..2f31331955b5 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1300,6 +1300,16 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
 	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
 }
 
+static void emit_store_stack_imm64(u8 **pprog, int reg, int stack_off, u64 imm64)
+{
+	/*
+	 * mov reg, imm64
+	 * mov QWORD PTR [rbp + stack_off], reg
+	 */
+	emit_mov_imm64(pprog, reg, imm64 >> 32, (u32) imm64);
+	emit_stx(pprog, BPF_DW, BPF_REG_FP, reg, stack_off);
+}
+
 static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
@@ -3348,20 +3358,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
 
-	/* Store number of argument registers of the traced function:
-	 *   mov rax, nr_regs
-	 *   mov QWORD PTR [rbp - nregs_off], rax
-	 */
-	emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
-	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
+	/* Store number of argument registers of the traced function */
+	emit_store_stack_imm64(&prog, BPF_REG_0, -nregs_off, nr_regs);
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
-		/* Store IP address of the traced function:
-		 * movabsq rax, func_addr
-		 * mov QWORD PTR [rbp - ip_off], rax
-		 */
-		emit_mov_imm64(&prog, BPF_REG_0, (long) func_addr >> 32, (u32) (long) func_addr);
-		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
+		/* Store IP address of the traced function */
+		emit_store_stack_imm64(&prog, BPF_REG_0, -ip_off, (long)func_addr);
 	}
 
 	save_args(m, &prog, regs_off, false, flags);
-- 
2.52.0

