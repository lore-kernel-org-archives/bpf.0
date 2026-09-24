Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865DC43CEC7
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267208; cv=none; b=cC/aFaQzwon8MuXxr0egBpbU3vgHsBDXeUAo92joH164yyCkgX+E4xiddRzAfab4g3+6igDOLnm8FIc6C6m36/yc2jIgW9Kov2ywCiXRriO+/0SbqAQZDvCjl12WlP5xCRn+v50Tlv0FxJAY6jAQ9gWqNT3Q+r4cEeQfRGXIAKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267208; c=relaxed/simple;
	bh=KILn4aSsrU8YEJ2Rf/yoidggV+FOG7tEApjS2G03ae8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZsTIUIbEHOppWBdFljeLTVDZTHb83+KaOMsZqfhKxpDM2NCdnGgekZfSa4akU/qoub6r14YrIGeNZyjbjbsD1mRoQgK5MHW/6ZRPur2p99I7deVGddccLNWjdn+x6C00KN+J5IWYtFcS3BtFq4e/rfpoNggttvXPC1yZtNcOx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kf2yFulS; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf2yFulS"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49cfcf2548aso182385e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267204; x=1790872004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i9WAbMxakQQweqHqWLY6W+9nDinPsU7tYwAzpctRq8A=;
        b=kf2yFulSp/ejhx5qprJ5jO1Zq8Jnwhh0cKJD2kdhR2w9NMpjDKY3wlLp4OqQ6M/7RY
         nXOWnDvMQjDPoQYvbsLrkyXYBON7sShBiY295FUetwCK/7b5nOXlNaPEBcU2B1PEMQCW
         YBVkVMLsi38+9JSibeTfUE6z5fwn+X/O/vSImuh0FhnA0QZlFuEkui/pJ0L+Js10mnca
         LtkYJ+tcqYj+cqli0E5nhri1laiHOMf9mV8aTye/cxPlNPZhdlBQVCcfKHZ39rpOhs94
         W5oMewgCNX+0MfhR0pcaKYoSJOHBM86F9lHyGWr9fYwyyFmjFw5DgCP28bLuKKFJq6uy
         CgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267204; x=1790872004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i9WAbMxakQQweqHqWLY6W+9nDinPsU7tYwAzpctRq8A=;
        b=Pvt368rHD9BsLO4Wz/jV2NUa9G3MCVmlL3qZHpwO0Jiwi4vFH72TJ8xEWQj1mTuROY
         +Ge0yReOqkc417cjyT/RqQNf2VYGcEKfUJTKj/ZxbGInlSa4UC0KfCBgoP106xMbdP+R
         keVNP/l9eP5PAhBYY4DoXZ/GFnLuTZYsm1Z8X9CFNgnautNo3dKy8Yox7BUOnfHW0dIm
         LqY8lDteCAQiFgLu/R+sFmKonO+Rxae0dU9D06P5r/AmIg+oh2AxlWcCilQ0IxCYKh7X
         VQ/RdcchO+REm48ifYzTsH/dEaFGD4o30tVg2QlN/ZUe6MXyHyiefRnAKY/EI1TOveig
         9PGQ==
X-Gm-Message-State: AFuF++lfAfgk1yXSHk1CmwEwZQIJuaMJX+ruXDMVwOye/sKBzvanhN47
	vbosXxAqXJptT7MBBRlX5Ny63Wlm+webi00i3QLFP+echbv1hCXmWaeDFEHDlD+x
X-Gm-Gg: AYBFou0ASVcPR5Kpyx+VRUBkSgoQvft9kCheALsOUC1zAz2O+0YkYBc9NtzYAWd5eFI
	exI5bV4vG4eMtLSoB+X6P9nppzZNj5qazBwpExQuT8CTmdFltBf9y5gN2oi0wKDuAj1tp1JqusW
	0Exk8Eqju0Djylvvi+6QlFcyuqqR8/tKD1zl6sehYJN3hIUQ3YAvH8HMpUCY5SEGZfEtEJg9qFY
	te7BkMMYJ7R2kCdXFiUNIDPeN93aNQ8hoeT129Qu2inSbo4uWlkHerwZTiMEOnxiihm3whcaERB
	WRsmPMDSUM2YQs6tGqBDoG+AVxiceGutQQxMcw5QhuxueXQ0qoNodmSDHOKAiXAi6i4MdUxzWhI
	X77VHcQGhAvTkFHCbiAgPmdgMSnPkjXQjQrLRRuxFuJ2QOngRd3ruWq+rDDu9Yv3bZj/LT6/Yp4
	qqNpY2hre7lUAy3k73lrbeuU0wJOa/kW638xbmZdY2n9ISClYMVoHUOk5CHAP8BQUjnK+6Q2Q3q
	YS/Qe3T48AEZtLE4g2NhxeB9iGshAUZuYrbemZ9ZWNvwD36CwY5bjoTsXvTFS5FiHOCIRv2ZxSp
	m/4q6pWozUoec/Ws8Ot9tWjcRC0Q8I3kGNrPTFSjss5koEQZ
X-Received: by 2002:a05:600c:4744:b0:49c:e1cd:536 with SMTP id 5b1f17b1804b1-49fe7b6371bmr45192295e9.12.1790267204430;
        Thu, 24 Sep 2026 09:26:44 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dff204sm114267415e9.14.2026.09.24.09.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:26:44 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/5] bpf: Skip zero-length stream writes
Date: Thu, 24 Sep 2026 18:26:33 +0200
Message-ID: <20260924162641.1922423-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924162641.1922423-1-memxor@gmail.com>
References: <20260924162641.1922423-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973; i=memxor@gmail.com; h=from:subject; bh=KILn4aSsrU8YEJ2Rf/yoidggV+FOG7tEApjS2G03ae8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWur7+4Hk9piY2eJdQvwz8iO41mx9OLfL08b90rfP9L5U z2Tn/FkRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZysZaR4dbbVK0DMzsvr5Lt 5pldIL57knZJzeLurhkOOZFSnevyZjD8T9968Wag0H2P4Bln0nMvG59coC7UOLH0NWNO3smN0qF TuQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A stream write whose formatted output is empty still allocates a stream
element and links it into the stream log. Capacity accounting only counts
payload bytes, so such elements never count against the stream limit, and a
program that keeps producing empty output allocates elements without bound
until a reader drains them.

Return success without allocating anything when there is nothing to write,
for both bpf_stream_vprintk() and staged writes. Every element in a stream
log then carries at least one byte, which later changes rely on when they
derive read readiness from published byte counts.

Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/stream.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 2b80a0599865..9829d1ebce70 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -75,8 +75,13 @@ static void bpf_stream_release_capacity(struct bpf_stream *stream, int len)
 
 static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int len)
 {
-	int ret = bpf_stream_consume_capacity(stream, len);
+	int ret;
+
+	/* Nothing to publish; do not allocate an element for it. */
+	if (!len)
+		return 0;
 
+	ret = bpf_stream_consume_capacity(stream, len);
 	if (ret)
 		return ret;
 
@@ -333,8 +338,8 @@ int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *fmt, ...)
 	va_start(args, fmt);
 	len = vscnprintf(buf->buf, ARRAY_SIZE(buf->buf), fmt, args);
 	va_end(args);
-	/* Exclude NULL byte during push. */
-	ret = __bpf_stream_push_str(&ss->log, buf->buf, len);
+	/* Exclude NULL byte during push; skip empty output entirely. */
+	ret = len ? __bpf_stream_push_str(&ss->log, buf->buf, len) : 0;
 	if (!ret)
 		ss->len += len;
 	bpf_put_buffers();
-- 
2.53.0

