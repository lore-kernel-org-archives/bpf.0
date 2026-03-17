Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5588A18DF80
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773791122; cv=none; b=JCcqrMFvI/pTVYTFi9XbNw0rJo1XcBHgRB3gO/Yr4qPsJlsMJvp4LJRmxh1/CxxxtCvXCANgzY0TIUiU//RKm/Ro/Gy/TWHVLSMN2XKhTon+Fo8JvTlopWptKSWIlodh2u9uKMcSKjbbRHLm0PQPD38ZEGna+rnNr/jt5vqBxV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773791122; c=relaxed/simple;
	bh=M2oILnMFRnCTXhv2of1N86xCWOBlK3ZFjdGz940AjQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7G80miV7FYQ9kHNFCUldbGRrC6tXt8EgYJk0VIeSu+l1eQdZgCP4UCvGx9DDGTkDm5nonfWzmBVDJEcRQ4+9Och7IWbtUIeNI1D+sjA+ceco85VqpQ+m6X7YNLOolkv1HGOmtrcUKxE0rw3sR7sj/vsnMDVOYCbpkmWF50vKJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyZ1FH1c; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyZ1FH1c"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so74299805e9.1
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773791119; x=1774395919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jq7vMllbLituEwsxAiSeLrzSpUIncWET2crS5mchow=;
        b=GyZ1FH1cOyN3hJ+oACh3p5RQYqKyH5/H0AsURGaZJDiKqF753iYM/duS4GajjsIgfV
         sCbGLxXi/IRgg0TtN0yi+uCVzZfLqSjdcdIgfk185WGfJmV4tlwOIFFIAESOwjqOMOVU
         GNdxWbDJTgT5oxqzvywDz+fUIrg+jMrfGSfuwmf0sTfcuDFZ6R3Q4euLN91pXYzw1odA
         NO1HdqOgrb4BQrFsKFbD6/nrSiSWJ9gOAzv9Df/aXFyDht4Mq3/zNoudupyKujSwS6cg
         OcOx/06wagHOj2dTgJexygy+LlXVPeHdZ67FK2Ya/h34AvjIGN9bj5b9K6pfvYWNOysy
         gclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773791119; x=1774395919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jq7vMllbLituEwsxAiSeLrzSpUIncWET2crS5mchow=;
        b=rW13ldxZg5UYeDfGJWg+gByHfkCz8BbdnEk+LxZzodTgmZN67//2ZsmE6JSZSkyc+x
         aSHhPIIRzOsxKWGA+hHiBdHZ+rVptnRe/WhH0IB8hfVgdrxVzh6pYX0K+u8RuglIA3GL
         2H0loqv7sPKoj/tzqh5sTaZ8z5CKAKyb1B+PWohT1q//UBtknEiQqAygEcrDcKNXtMh6
         n64OS3e0pN685De0wGE/O5yA/cl5xjLs4J4rhEU5wHFbpGpT9miAiXyiB4I17p1fGg7r
         7I+u0C5jslX32chRj0MHNp+xkDiQ9sLOu/fs2kr1FOO++LsljUt/c1VhyAw1spmEFVdz
         IH8A==
X-Gm-Message-State: AOJu0Yy02GsKwXWXZorrvWcsTGTJFJ3iyv3XIcjyc92URaVZzv0pYXTe
	kaWh1AUjmErFpYP1z+0ckaJ7vINOp8Hn8IwZJmceqZdbRIW3UuGfah82bT/G4RA=
X-Gm-Gg: ATEYQzzYmblNJTJcOWI/OYsl9AN8kRWSYr5lzbry41QF5KAqnKkAj7yGjUPPIE3XoCW
	pZAL1jzo2kK0T2a2EviK3as2BTqJkL/1va1IH3+qzNCiDrUAzNEcHIQMuDHBLOrqO9XyjBYlhgu
	C4y+GNiqcrJHNQ8NvgEMTqwtv1loKrzA0dfL5fZFUFm81//QiDmiNAriB5en8JzsubJYNb5opJc
	aIbLbQNIUx7TGvZem5kz+n+YQKHBoiJi7ih+lyNx1apRZoTcSurGISpzez1hAzUs2F5Ld8fJa4S
	sOd9Bx6hP2a76kb5zi1zctiHAfkbvQFPfwZZfFNH1y6DE5f6ZrH9mFmaosoOZFytcss95Ot1wAF
	SKovdwVgvU82HuAO3Q+ugUoMDRTYIHoxDAfNAajdzHcjNg2c4ydkMKQ+YGMEGeeXNtE8dGL6tIV
	QLVrdCLZ1zOrgO3idxm62SRj5C
X-Received: by 2002:a05:600c:8b09:b0:485:3a27:a960 with SMTP id 5b1f17b1804b1-486f420c141mr25216475e9.0.1773791119353;
        Tue, 17 Mar 2026 16:45:19 -0700 (PDT)
Received: from jacks ([197.38.212.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8fb0dsm177814555e9.3.2026.03.17.16.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:45:19 -0700 (PDT)
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
	Ibrahim Zein <ZeroXJacks@gmail.com>
Subject: [PATCH bpf-next v3] bpf: verifier: fix integer wrap in regs_refine_cond_op() BPF_JNE case
Date: Tue, 17 Mar 2026 19:45:07 -0400
Message-ID: <20260317234507.1753803-1-ZeroXJacks@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Reported-by: Ibrahim Zein <ZeroXJacks@gmail.com>
Signed-off-by: Ibrahim Zein <ZeroXJacks@gmail.com>
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
