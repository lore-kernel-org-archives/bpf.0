Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205813A244
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770251939; cv=none; b=u19+Kt+jUKLdyLO2q3zuhvrMTBmnk/Ct7XmTxf8Z7YP77wixHWMCiQlvtXzs9LSch2FA5p1iOHly0Y4a6tsr3eVjePjdWdGLaUZiHYG3TK9wM9drtovdQBLcittfvDlaHw8WZPdLXJwkh4ualeorEXMOHHTYd/SYyHVGyufGcD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770251939; c=relaxed/simple;
	bh=K5Ggqj6brOrpLyiYIKKgcE5SjwhVsQL2fqGgWUT88Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0NtF83pD16OsWDyePuOe4Zg30M/arFtnDAhJVPQi96zocMRvh/zWotVkHNP3NLj5Zzihwb3k3OnQl3SnkYi0UoiGBQYGLToaexkm3CjUBoklfDvGh9ZPPPZqZ0qMI59oqSYSElkrfetRRH/hZyQ2kBpyXDi7BPEGRMmwDZBv+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzJD6Pot; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzJD6Pot"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4359a302794so294268f8f.1
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 16:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770251937; x=1770856737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqylYFpXisLAY/foFTC+RT1cIbLo7HP1HpeWW7OVMEQ=;
        b=mzJD6PotLn0Olwcs+1THHjwUXU3x6MG9yFhNxsCFrf66TDlNTQLHy/EcmkVbYP9veQ
         lgnoSrAaa4qTZEBjO4YALSvAxyORLqsxCgsgR3FoWtRD3Nt/Z1/truBPcxY0FlAL6Rzh
         r41jThEZS1H9lvsFSCAqwh3DZ8iDLgj/AouEBMZeBYZvzl78my2TMEO6BYcmsaxiGDw9
         isYuP6x4Gh/gagCWE+glUG8WS59GdSd6ezySKi+U/8PwvTHYj1w2U+J8GnjRMD1yI/DU
         zggU37CG317b7DB0Le5prQDO9mzOhf+MnyTlHMBBagpkbc6Q3yUMTRx9TiI1geROAg/C
         7ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770251937; x=1770856737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dqylYFpXisLAY/foFTC+RT1cIbLo7HP1HpeWW7OVMEQ=;
        b=butdwZgv2BsiQIeLeGamYahowk0v8pnDuEDWwFp5INS20KTYAfI7mzNJ9QOpwvVE7o
         iBSb9JpxlR1i9DkOWDKy+lFG3p/KSL3ef1yPwu9mnFuw1qXwLC4UCNdu6nIoCAeurin6
         ffkNXsJJbtEYgHxgFljRfD8AbrUis6rqcxEZThXDhEJfuhFe5PtORKVQ4haAKHNQxOOh
         lbzJIivyhIjc7+faRYohma0nGxR4x1hhhEuQNJOshlO9bLuIbZj02yQfSCWxCaNC24X4
         QUJpuCZI3sEuA5yYf8WGkBBQ3OJBz8O9ACHsjGFWakFOxZ9GRQ3EIiU4ChJyBEQntrDe
         64mQ==
X-Gm-Message-State: AOJu0YzQE7S8SJ2Cid3c/aduIIlA5zTjJAAPwNbbAPBOSDX1MBsBp0/S
	wt/8g3Rx+y78I/3VhzuuZPiuLeLTeaHCvWvpcCiOi5dPLlVgomh/5sc2CAi+b+oF8I8=
X-Gm-Gg: AZuq6aKnJZ+982zr6+VrTzoyMIHzaBpCzq8Vzssk6TLYaeyJYMp40xFE34CqFXZCF8Z
	uiF4epTSezorHxWL9EYawqCoxyHGYiSsLJZfbhw/ij6bIj2iCDe6qfVFeS+YIm0xp7JcbPzt9va
	BDvtHY367qIqDrBRgBYXDxtZ8FLKM+74Hzr4quaGgtYZ53abkNijjTcovhRxWnrRVNfD3AUvHdn
	ZajHPa0vg39OttWVkd5ziYEdKalxOUIKwqA/mENQ3Lsv3lIZFfx2sUzmE/6+BhpX4b6ltQN0Rey
	HNDiI6bDB+OfeNHuq5ops9JHPwWMHA8lfmnmeBuCJUFd32xt602xEruKuXCElSwEs/LvAKqavy8
	ZzFa3UTwFXIkuq0a3S0gdlsFcvzDqjM4vVc3PN81IsLYkGY+TtFc1hX/dSHMGCLfzv2AMD9RV6m
	j+yByvuwZQQna29rpFbamDvgYvCmHVN8VJ
X-Received: by 2002:a05:6000:250c:b0:432:5c34:fb32 with SMTP id ffacd0b85a97d-43617e40896mr7326851f8f.23.1770251937372;
        Wed, 04 Feb 2026 16:38:57 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4d::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e25d02sm9785766f8f.3.2026.02.04.16.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 16:38:56 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] bpf: Reset prog callback in bpf_async_cancel_and_free()
Date: Wed,  4 Feb 2026 16:38:53 -0800
Message-ID: <20260205003853.527571-3-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205003853.527571-1-memxor@gmail.com>
References: <20260205003853.527571-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; h=from:subject; bh=K5Ggqj6brOrpLyiYIKKgcE5SjwhVsQL2fqGgWUT88Po=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpg+Z77F2VPj7dCo81a254U8riEdMvAxNdNSbGhPfC fcMTvkeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaYPmewAKCRBM4MiGSL8RyrJ6D/ 4kIhqgMrIBpBC690IabCfnuqqpKW6S5sgWIkjUVbKU9qbCU7wx2hoBfKnsSuALQNIFg5KjE3fjqPk8 uMZN29um54UvWVrN9uFFLIXs/s/HJ2sBSESvbyXLSamYiiuUdWnMGSK80wuZlFt8VIVfL7p2gXpYUg TJwwKsm9DyZDu+B28Ji9lPEvVFe1Hi/Wk351BvBnbhA3krbs2jc2+LG4CFVKhaog7ASx+Zdbef5IOv T12ms16gPsQ72Um4SMwb4zRCJ5IorjfjS9n/hwy8e8HdOfMW7yli0v8yvDCA/mzAf3rO4kfxKQ7+HI sHD28MqX1SzlSfD9T8hBsKqJnYP3mFpMgt4bf//G5uF0mKLNw8m/sUpEKobr8RVmBNCBu3HaOuAb4o dbUhjSQvpYWhChbbNBTcj9x00aX6A2I2rQUzp3wCJ0xo5W2GB03cic+9TwKQ8DQhz1z5fF/5nCnFVw jH4EoxHarQvtG/kZ2k765vNdzFTdLyHR6q4O9lPhL5pNhHIIlVQRhqyqnWaE1av7nEleNTb43b5XTk 9qwR2C2hebL8ddClcbRFENCvaqkaquxugVXJNlB0Z1siET3CEMzInBaGwxWGr8BcpI+sWafxUmoFSO wsZ+N7ZDXFKgyorPhwZsP43/Wa0EWjmtOnnMjJiAdJNo/+PQvlOIdgCOKk0w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Replace prog and callback in bpf_async_cb after removing visibility of
bpf_async_cb in bpf_async_cancel_and_free() to increase the chances the
scheduled async callbacks short-circuit execution and exit early, and
not starting a RCU tasks trace section. This improves the overall time
spent in running the wq selftest.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b7aec34540c2..a4f039cee88b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1664,6 +1664,7 @@ static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
 	if (!cb)
 		return;
 
+	bpf_async_update_prog_callback(cb, NULL, NULL);
 	/*
 	 * No refcount_inc_not_zero(&cb->refcnt) here. Dropping the last
 	 * refcnt. Either synchronously or asynchronously in irq_work.
-- 
2.47.3

