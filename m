Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7BF219EB
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507392; cv=none; b=qkd5lWcs/vb3i+STdyUeDu6GSkdAvTtDspJWuR60sXInKDgHbCGKKxTO47LJY5RUH5XtPm40tWZnTShAIQXOITpSXd/m7HxGU08/cAvVWF1tvEEW/Wxm/pjon6RDOuaqmITOoxe86DX5BVrk0cnXgt4yUVFXsIykPPRv6e2AWaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507392; c=relaxed/simple;
	bh=XRz3AlU6oVEd8HMO++44JyJGc/0emaMyjhRiKYyrviI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C1qQHrLUITyyUXcXglEkQ/qcxp9ddptnsgQdRpaxsXCd1QUspLf3zwDEXUxoCy1ZpjiVXwnfL/ALsxBqufpInL6i5gvM1RIY/4m45ZF1w2DNCfgJpzM80uoT6CozwZcKb3vzWs10L21nHLLRzOStLK8rDpnLei9bLeAuNt4dBq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fya/B/QV; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fya/B/QV"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d44f565284so1441276e0c.2
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 19:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711507388; x=1712112188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aUuqBWxm1DXoNwLeuHhjeB9S8AJvwQwyUNaPw504ps=;
        b=Fya/B/QVljqeUXDPcS9zuU3GPIDAk5B1cDwmaz5XERoOmfRlYxBXQyFWKzAuMSJmyW
         CrXkxBx/OsFaZ4kI/sPDZUPzTsMBd/oqngwl7mmaB/8whfM5M1+qV2T5HEgw4Quxt4pn
         Ab/ooZVagtbXiMa5kcqcZDZiApGMvSUWDQRgcVZCG9M9jgN3lSObacBoIDfOyzUq7tas
         W51N9F3IM6Wm8iZFNzyNdY0Ep3fe4pBLDHRHMdd8mcn3omDLU08Te5P6PdiosKb9/s6X
         WnyUJTppdOq775zfN66dGBWxwLWrBI1ORbnSqr7VgxKrpuiU5fy+c/zx0t54W+bs2o24
         iPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711507388; x=1712112188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aUuqBWxm1DXoNwLeuHhjeB9S8AJvwQwyUNaPw504ps=;
        b=o9MAbtREjkYzjMg0y72cQRM6yg+LIHqEexpKQm4McsoTgAKAnMa0JG8RvdT9BP/CyL
         LrTl8LdWgvt5HjSmxh4yFKV87MvucW/zEh5/VP/HRY4WrJkNwXwfkitb/psPYZUF80h2
         JTcuq3W8zwZOjVAv3nfjzDeamgzo1XUrihu4okvrDV+WvQhFoxDYdrFUYkOeoo/ZJKYs
         obrcvY2KryJZZL786JO2tsFdw6lxBma8yz+qxvVYe5zeKrFBMmBibseMDziT9xk9VyU3
         qflLJzo6hefH96rqbLGLrltwNykqm2ej0ERRfWCNl7sg/m+dA+hzB81MwCpW4DPg/b6f
         rqJA==
X-Gm-Message-State: AOJu0YyUzXFBZ2ZKjxt3tePAFS3ENkL582dEOBndidXvn/a4IRfN03nQ
	iL7bSbBLkBHd7yvwOGBQ5DybF0AEb5OjnqwmcVri5emBg20XuAQ+GMG2cIdp54ceCw==
X-Google-Smtp-Source: AGHT+IELZw4Wf750SDmZT4/XHE6rCumq3H89lPWPECgQS0GMSblXausVrIvPSfxBgqTo6tTNqch78w==
X-Received: by 2002:a05:6122:45a4:b0:4d1:4e40:bd6f with SMTP id de36-20020a05612245a400b004d14e40bd6fmr3189572vkb.10.1711507388284;
        Tue, 26 Mar 2024 19:43:08 -0700 (PDT)
Received: from andrei-framework.verizon.net ([2600:4041:599b:1100:fb35:c49f:ff96:dfb0])
        by smtp.gmail.com with ESMTPSA id e2-20020a0cf742000000b006967565c827sm4742324qvo.141.2024.03.26.19.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 19:43:07 -0700 (PDT)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>,
	syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com,
	syzbot+aafd0513053a1cbf52ef@syzkaller.appspotmail.com
Subject: [PATCH V2 bpf 2/2] bpf: Protect against int overflow for stack access size
Date: Tue, 26 Mar 2024 22:42:45 -0400
Message-Id: <20240327024245.318299-3-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240327024245.318299-1-andreimatei1@gmail.com>
References: <20240327024245.318299-1-andreimatei1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch re-introduces protection against the size of access to stack
memory being negative; the access size can appear negative as a result
of overflowing its signed int representation. This should not actually
happen, as there are other protections along the way, but we should
protect against it anyway. One code path was missing such protections
(fixed in the previous patch in the series), causing out-of-bounds array
accesses in check_stack_range_initialized(). This patch causes the
verification of a program with such a non-sensical access size to fail.

This check used to exist in a more indirect way, but was inadvertendly
removed in a833a17aeac7.

Fixes: a833a17aeac7 ("bpf: Fix verification of indirect var-off stack access")
Reported-by: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
Reported-by: syzbot+aafd0513053a1cbf52ef@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/CAADnVQLORV5PT0iTAhRER+iLBTkByCYNBYyvBSgjN1T31K+gOw@mail.gmail.com/
Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0bfc0050db28..353985b2b6a2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6701,6 +6701,11 @@ static int check_stack_access_within_bounds(
 	err = check_stack_slot_within_bounds(env, min_off, state, type);
 	if (!err && max_off > 0)
 		err = -EINVAL; /* out of stack access into non-negative offsets */
+	if (!err && access_size < 0)
+		/* access_size should not be negative (or overflow an int); others checks
+		 * along the way should have prevented such an access.
+		 */
+		err = -EFAULT; /* invalid negative access size; integer overflow? */
 
 	if (err) {
 		if (tnum_is_const(reg->var_off)) {
-- 
2.40.1

