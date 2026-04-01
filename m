Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0E139DBCB
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051379; cv=none; b=SizFAOTiCYNp0m9uzbQ05Y7d8oi2AwXiVWC4tgWcZ7pIlKRSzxm7mLn7kSHRgn2Pzq75bSSj9SdsyRtK0zRiNsRd29lmdTTac44dHSdA4jyY8eEDh298PqkStsnBt06+v6tKGXO5TMG5qGm4MCRBtqdCIo9fgzCQZaASYln9Fyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051379; c=relaxed/simple;
	bh=hgeoXRZ5cSNPAxt3Egkd+p+yTdwDhoSYzz++GWpOuak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c22sk64oMKwq+OYsU+gH6TTzzFxHVtm/TM/1Ka4MXVQ8LefNgeLq2MVXY5IrICaNv2DOhwfSQyHLSZr6O0eQ+6SJ9znwDRye7c9pW5RwrJt/o0wbuhBDFYKA+tCHqMOv8E06+9+LXYDRjGxeVysfjkT3zGKUMxxkAdA8mhkeegY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiCAwXSW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiCAwXSW"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso24680335ad.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 06:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775051378; x=1775656178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUEKhgyUH+EnaEpKP6HMgut1APyt2IvzBtqO/UudEAg=;
        b=ZiCAwXSWzm8uZjGm4DcVhn1D718hghhJvMWaYWSnGOtiTHKMeVSRqb31f+njMiRYFT
         27GxXzKLYc9IivVBowY9QwXd4MV0Kx9zHB0vH/DyPU6ACbgFx2f8dEVYehBOMxLLkKwT
         VPSeCepbVd/0P6LQ7j8RCvAS+B8n2Z8s+gii32wkD9FBkILJX3rnAG5B66ngBICx5Cp6
         z/yRJ+LVPSeaSnoIDld/NZXBp90XF3v41fpz1ITw7LQbTeY2VSF1VSa/hOJ7j6HI9QVv
         AKariArmV27z7rCPd9TNBJGRytPOZAXzzdPFiGK+HqNta4hAyEGzOm5Ixv4trZbHfd9j
         OT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775051378; x=1775656178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WUEKhgyUH+EnaEpKP6HMgut1APyt2IvzBtqO/UudEAg=;
        b=m6t8UDQkV3hHcpcil6E2Mrx5LMBif7z9ybiget4AUGCtjlCdeONJpnEKJvYC+gEw3r
         Rfnp9pGtPB5ORR/kyg0OiBHYKc++Tgy7LYSSej8pCNO9eGZB1hHh08AH+YSS+r5uahB3
         f0fURgYjzX93DhBMcEVteyZDJqtpl1DVIT2HL1qgAareetTAHM7jtztc3Qaufv55OkQZ
         F9Z9oxQp85hr46fdukM5bsIJONc/KoIO0oPCHNHO+C5Qy8FZeWr7n/Sd546xkGdbLQBS
         PLtE2DDhDbpG7tFX1sn9uH7TxDUX4tW2TeB4DqsHgXzgnvC8ln88nEGhgiaMKOa9Bv59
         bIVg==
X-Forwarded-Encrypted: i=1; AJvYcCWQwtsab7KU76b3Rf5gMtD+omc0K1V7edw2WDAxYaGDWdntQkx5zBXr/wJiGvu59xWmVC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymeOvVPyADVCBgNTFwDnBEPw6R83Qh9fC+WU5E5HnlD/Y7IWSj
	h3eAk4tVo7ElbcDd0qstpoJWC7PG+lAxObp2spRxDgyTp+SrDe8h/uCG
X-Gm-Gg: ATEYQzzm3rhqUARQpW5nV5kHYXBWojFkZRPyzkLegR5vR1OlNRMX8gjcXWUsH7GJUfI
	VTlHaydEnQCKLH8ealfO1cLx6nLz2fOfjyRHWLmvvkWF9JDwWZ3e2n8l011Hjjs38GfhTbvltkr
	PqGyXEFxLLzImH9L7Ywg2NbpjEfW1H/DmwDl29jnWFsdI+aM07UszyQaY2rZOZtbs4MZUhI6hl3
	PCI/euGXPSzXLcyBGT+5fDVfoMb1KgSuzdXXPLQtgtZNXWzgCYlvgV70h8PUiguxqOkIwR4ghC+
	tueUQFjaosbhvHerM3nU0YPuT3b4Qv22BAIEHfrpon0v37fdtJ5NCQBvtJh/sHH7G33Em1IOvkI
	B8VZzSlA2Cil15VGlyHUI691T3XzPAqf9FN1+JAtTARQn6Ai8pFclBxTbsD5AMyc0xieaMer+we
	DXBJU9eIODBGhOsMFT1691PWcKC2Vny0F5E9GFPw90YH45jAKGYwA343fHbagqgZqkIjPW90Z0+
	TTd8w==
X-Received: by 2002:a17:902:f54f:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2b269977a8cmr33888775ad.0.1775051377662;
        Wed, 01 Apr 2026 06:49:37 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:a82::10c:35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b267ec1615sm36300935ad.57.2026.04.01.06.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 06:49:37 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: varunrmallya@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	memxor@gmail.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH bpf] bpf: Reject sleepable kprobe_multi programs at attach time
Date: Wed,  1 Apr 2026 19:19:21 +0530
Message-ID: <20260401134921.362148-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ac0hLyMuPHiZfnVc@computer>
References: <ac0hLyMuPHiZfnVc@computer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kprobe.multi programs run in atomic/RCU context and cannot sleep.
However, bpf_kprobe_multi_link_attach() did not validate whether the
program being attached had the sleepable flag set, allowing sleepable
helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
context.

This causes a "sleeping function called from invalid context" splat:

  BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
  preempt_count: 1, expected: 0
  RCU nest depth: 2, expected: 0

Fix this by rejecting sleepable programs early in
bpf_kprobe_multi_link_attach(), before any further processing.

Fixes: 0dcac272540613d41c05e89679e4ddb978b612f1 ("bpf: Add multi kprobe link")
Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 kernel/trace/bpf_trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0b040a417442..af7079aa0f36 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2752,6 +2752,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (!is_kprobe_multi(prog))
 		return -EINVAL;
 
+	/* kprobe_multi is not allowed to be sleepable. */
+	if (prog->sleepable)
+		return -EINVAL;
+
 	/* Writing to context is not allowed for kprobes. */
 	if (prog->aux->kprobe_write_ctx)
 		return -EINVAL;
-- 
2.53.0

