Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ABF1A285
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773794500; cv=none; b=oOMCvluI79AMalrH24Beq7xehvLVjSHdJRSWx5rk8r/1ApPj70PT7qsvByr26wmmJ+oojBlOe4XXQuh2sySHtjxVjC4ikEW31i2d8SKNkxhjqO1BDlHPWfwutXEbGSURkrjC5ZA/RCJaj0LMnHCAj3CD55Gg4W50NVazu52/h60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773794500; c=relaxed/simple;
	bh=w8Tq6Bc94AEMzOJYfUQvY+6Pun3Kffb3whTQ47bh5zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sgSLstvPhrudkd7MI2zpROviIHwIJFE/nh6t6T3eDL4WPohxuPalQm5tgy7SoZkEXCvtfLH83EcR7l/I/dLbybW4DT6EIQLpPCLeGIPPhSB68tHB8UfxwtDy19Zwou7fUUiabib59Zsin8mSHKMXkAlzicu15cI989ohLDu2AHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoTXArsU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoTXArsU"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48538c5956bso3467175e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 17:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773794497; x=1774399297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iLDvbIYEy8LBmAkZqY7L30i1fR9uuX/8ehy3u8kgra8=;
        b=DoTXArsU0td6fLixmfLF9J5EA3Ks06p0UYJAKnwjeXD2QPa0BRQEQJGyQ0fbUug6Cr
         y+M4ViUyOoHmYTnLPBaQv6FQ9BRLPoGgmfUiRLvRzykZpeQxtd45lsCjhaZjIfF8I9ql
         s7piKfel+IDLWhwLjwcIPy+61Zm7ntIJ8SM1eCnjYTJpwaec2Jaf2C9GOGGuSVs4F9BO
         744fjNLDHQwDNTAOddidG+Ljo/6Xlz1aDZH6WbSHbAm7wnesZrozYC5Ri2ACfjGzft8D
         x6NOo0unsLGLLv7l4hXkXK+n+/Ch6G2i8Z1FrJMjsOZI0yN3F3IE24pmR01D+IWmBIsd
         ok4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773794497; x=1774399297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLDvbIYEy8LBmAkZqY7L30i1fR9uuX/8ehy3u8kgra8=;
        b=I+Dp91Zt2EaCcOf6e9hWd7S5t9EW6kq8HhNsy8P41s1IIQZeSFw4HtorK54vVAJfsP
         C5quckw9+hVimEz9t7Ek3GDEkLTHdAzK59spH+enjhXc7DjpRiDdSddNFHjQ6aYay6qB
         hTeID925UJ0pnGjrCamRMJaZGalWCo36oWXUfdxaT+8m/+Jq4FGYvaC67PvU5z6YOM+v
         zqXB5vzcciVGbI/e8Y9qOC4XqElBNmdqIHm3owMEfUzXTmJyCvLdQXN0D1P6SydwF9Et
         YyjBGTAw0doWeZb7aCoR4TGWW0xhVkyyHxQOYn9SKLh0y1C1S6s89f8H7zLKm8z04Gvx
         /0uw==
X-Gm-Message-State: AOJu0Yx04KS9j1NwslF/3PyGDRXI3BtGgfg+zS77MFK4GRFyUiSzceM1
	+eQGzgWvalv0Ki7iHlzxHSosATc6fheWQuoaHPMMi8fYBGIzcniZ0dut09QOjGQ=
X-Gm-Gg: ATEYQzywGMDO3+APzwGTwLp6vRJSVQd6DkX5RQnrWqyLfs03odL+cMfrBg59sRIUr2M
	WC3IFQbAIawVZEvcDV2g+WEzqZe6LR+383aNCOGQI2BieLMIojzOMNc6L5GdUgwWQ5Xo1lIOVuv
	Ym1FvP1HGTBNmtQLr97thrcLDdC0Z+vdHY86SF4twMeuFiHO/NsEDU4ITh8PtQdobBjMQPoIlFJ
	rg5gawL/vcthzraZk/vTDQdR50X0uH+/0Jru2Tgc98c5wYh6P20Lm/uHNbKTU8mqpsQYy3jncd9
	A6DcHNGMYSSomB+HstAnUaqs3aa4gxsVje4xakVs2AHgchjaKRgCSy6OU+f/HWR+j2pxxRPPjjE
	aH5J8FGsnhx0rAWvzY2rFNaaeRXOQlg5EXur4Sm+YuTbV9p1I9/f6/2TYs0+9NacupM/6uMctP/
	WKUoOYmgRWXfxkqGMuHcce18b9
X-Received: by 2002:a05:600c:a0d:b0:485:3e00:944a with SMTP id 5b1f17b1804b1-486f40c1975mr26795405e9.9.1773794496883;
        Tue, 17 Mar 2026 17:41:36 -0700 (PDT)
Received: from jacks ([197.38.212.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4b9beb0sm10465035e9.8.2026.03.17.17.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 17:41:36 -0700 (PDT)
From: Ibrahim Zein <zeroxjacks@gmail.com>
X-Google-Original-From: Ibrahim Zein <ZeroXJacks@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	gregkh@linuxfoundation.org,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	haoluo@google.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	martin.lau@linux.dev,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	menglong8.dong@gmail.com,
	Ibrahim Zein <zeroxjacks@gmail.com>
Subject: [PATCH bpf-next v3] bpf: verifier: fix integer wrap in regs_refine_cond_op() BPF_JNE case
Date: Tue, 17 Mar 2026 20:41:18 -0400
Message-ID: <20260318004118.1780755-1-ZeroXJacks@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ibrahim Zein <zeroxjacks@gmail.com>

In regs_refine_cond_op(), the BPF_JNE case narrows register bounds
without guarding against wrap-around at type boundaries. When
umin_value equals U64_MAX, incrementing it wraps to 0, producing
an inconsistent bounds state (umin=0, umax=U64_MAX-1).

This can be triggered by constructing a register state where:
  r1 = unknown_byte | 0xFFFFFFFFFFFFFFFE
  -> var_off = (value=U64_MAX-1, mask=1)
  -> constrain with JGE U64_MAX -> umin=umax=U64_MAX, tnum non-const
  -> compare with BPF_JNE const=U64_MAX -> wrap occurs

The comment above these checks incorrectly claims this boundary
condition is impossible. However, is_reg_const() uses tnum_is_const()
which requires mask == 0, so a register can have umin == umax while
tnum is non-const (mask != 0). Remove the misleading comment and add
explicit boundary guards to prevent wrap-around in all
{u,s}{min,max}{32,64} variants.

Fixes: d028f87517d6 ("bpf: make the verifier tracks the "not equal" for regs")
Reported-by: Ibrahim Zein <zeroxjacks@gmail.com>
Signed-off-by: Ibrahim Zein <zeroxjacks@gmail.com>
---
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17046,31 +17046,30 @@
 		 */
 		val = reg_const_value(reg2, is_jmp32);
 		if (is_jmp32) {
-			/* u32_min_value is not equal to 0xffffffff at this point,
-			 * because otherwise u32_max_value is 0xffffffff as well,
-			 * in such a case both reg1 and reg2 would be constants,
-			 * jump would be predicted and reg_set_min_max() won't
-			 * be called.
-			 *
-			 * Same reasoning works for all {u,s}{min,max}{32,64} cases
-			 * below.
-			 */
-			if (reg1->u32_min_value == (u32)val)
+			if (reg1->u32_min_value == (u32)val &&
+			    reg1->u32_min_value != U32_MAX)
 				reg1->u32_min_value++;
-			if (reg1->u32_max_value == (u32)val)
+			if (reg1->u32_max_value == (u32)val &&
+			    reg1->u32_max_value != 0)
 				reg1->u32_max_value--;
-			if (reg1->s32_min_value == (s32)val)
+			if (reg1->s32_min_value == (s32)val &&
+			    reg1->s32_min_value != S32_MAX)
 				reg1->s32_min_value++;
-			if (reg1->s32_max_value == (s32)val)
+			if (reg1->s32_max_value == (s32)val &&
+			    reg1->s32_max_value != S32_MIN)
 				reg1->s32_max_value--;
 		} else {
-			if (reg1->umin_value == (u64)val)
+			if (reg1->umin_value == (u64)val &&
+			    reg1->umin_value != U64_MAX)
 				reg1->umin_value++;
-			if (reg1->umax_value == (u64)val)
+			if (reg1->umax_value == (u64)val &&
+			    reg1->umax_value != 0)
 				reg1->umax_value--;
-			if (reg1->smin_value == (s64)val)
+			if (reg1->smin_value == (s64)val &&
+			    reg1->smin_value != S64_MAX)
 				reg1->smin_value++;
-			if (reg1->smax_value == (s64)val)
+			if (reg1->smax_value == (s64)val &&
+			    reg1->smax_value != S64_MIN)
 				reg1->smax_value--;
 		}
 		break;
