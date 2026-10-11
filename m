Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA4A36F909
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 06:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699717; cv=none; b=YuvA603+V4mBGAJoC/Yrj8E43rdObUmxGwAeuPXAuwrfpgNh3Pp6MI3gW5lmUqNmtTOxLH5HtJE07q4GEgRijQPZIq4OZ9/UT/+OtXh/VED8c8GpxaEIQp6hqlikCWh/yGsEFIpcYxwBTWFrbjIct0nzAFje1P92Ahb28eJJXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699717; c=relaxed/simple;
	bh=WoMKbK/shvv7dtB9ERHXZ7guafdnMz10qKnwMijY9w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emdS2cQIsKYPe/V6wWHe/XUk3Geefv5gkOw/ChI6lmN+FGEGkqo+0hUMET3Z42onwQvzAAkUe5im6seuLVXQlBbtC6zql40acY9DsPwNMUuVZtZrYQMlmhIaWcqBM7YEMWJ2O0F536C83r+KkmcHIJUKsqICuQgjSN7MfW99gMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqFWIS5y; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqFWIS5y"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd5e4e755cfso309806a12.2
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 23:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791699715; x=1792304515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9D8gIqXwpYYUxEnfLEa/uqumetlZw8cgYsoRE/cLh5k=;
        b=cqFWIS5yitteZpX6oaQzVP+Vf3xH/e0MmUfpelTxWe05woO/XT/UzJS6emUoD45lOi
         e30Bm/VPC4kx54JfAFjQorrq5qvDI2Ujgp8RNWwUN0SvzX+5GIKj6nH4WmDPnGU0WHhu
         yx69Adh96Nx1GyJIJ1UL9JZlRLzp62rUj+jKyqrixMNTdJvQWL/hzQt71YV3GPDQmtnR
         wr4tfENmGIoCosHLlk3o1JP00loXWIjySu3nc2dftS4Gx8W77fYVYWERjgtuy/GxC+qT
         TvOGb61k2Kk5zg4OgRIHV5ztbxHz7DJ1Ur68oC2puP5DFY4f5REe5CCCK3537mwww02R
         tSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791699715; x=1792304515;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9D8gIqXwpYYUxEnfLEa/uqumetlZw8cgYsoRE/cLh5k=;
        b=CbhCBztcVUVuQMrdVYm3O1g7qRjIlWYPKnlGG7feyu2+tzhO0MEFgRHIuhZ+f2SEii
         NSt0gX9cUWbn2wngpGYmC9vxRhhkdbzljdzGSnY3DcjhcCwJNj4aCbAIdqS12XVjlGTk
         NEME78S8D1sCGdYw4dMmx9P/9f3VSU4xKCQnJfFbuchZWjMpf8fy1AyIPNu/QW0VVkKf
         L7zxRRo9FtDtUOH8bpAwUKttlBzYStFMQ5Bq/Ps+Ile0HpLdJfzHLinSBIaapDp/j92F
         bj9ySKKNHcKH0vvG4lM4+rGd3+2GpbUwmlvgbU3jSHEwIC+7MPfMeYkFxWwoqEqjlVLE
         NVnw==
X-Gm-Message-State: AFq9FYJOEPUscao8FXNQrSvXs5k/J14Xko+Z7QDK7lp/RvaxQSQ+QoDF
	VU1v0lyXyPFmjmBkntpXPQNSEbA65YiyyTlKT1bYLiy4qhvoMXE0cRUttuYJkw==
X-Gm-Gg: AYBFou1HVSO+CO3ksZXmbEmtn6D5H59AS/Z9n3tnolzvHH55ItU8w8zU9XWrIj20p7G
	e5BPUTMCEXPXyyrMOCb3pLzETaWxAApQS9K42fvnMqwbngiZDGvzJOQxdzXvkz4UZWY7zay5C8B
	wR7Lp3cs+VzXJrCyLl7H75JR21Oh537px0yZlTaF/yBOzM5DIErsmJAjY1oX1AorTNWsE1FGZub
	mE/fdi+qrpLcZCV96D1haq+Z55HqwfeMUTAnk3B3FwMhC9WLGZxLUe1Yhoh1/8bhemD3SwRR3Eq
	JtbK64u0a/QmNpbQsc4TSOLGTZp+UXhDTh6m5ocOIUH5fQbEVf3LHk+mUczoDGB5KaMy63L3osh
	vCaZxlhkVCJETg/ymYWrRxYc9U3YrRxJvpZgwpwvW/T/ieiVFoODPzvfB/W3S8qCJdeuJdJ4Ncy
	ycswLkHOb3OIHUyyngW4aXBqIjooxBYvTHkMTPnqM5B6RFcoJHZ9T/IZsne1fxPZFCAvN+o8H3A
	QLB7XW4aCXGLXBsba0OdTdA4A==
X-Received: by 2002:a05:6a20:431e:b0:3de:3f4d:f2ed with SMTP id adf61e73a8af0-3e16bfcea5bmr5655595637.36.1791699715622;
        Sat, 10 Oct 2026 23:21:55 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c31071absm2854341b3a.15.2026.10.10.23.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:21:55 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 3/9] bpf: avoid duplicate declaration for BPF_SCEV_REGS_NUM
Date: Sat, 10 Oct 2026 23:21:37 -0700
Message-ID: <20261010-scev-minimal-v3-followups-v1-3-6000e95ef993@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
References: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The "bpf: Use SCEV to widen bounded loops" commit introduced a
second (identical and unnecessary) definition for the
BPF_SCEV_REGS_NUM macro.

Fixes: 088a5477a9bd ("bpf: Avoid widening registers that hinder exact stack-slot tracking")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 54cb6d3d0653..791398e14962 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -708,9 +708,6 @@ struct bpf_loop_exit {
 	int to; /* instruction outside the loop */
 };
 
-/* SCEV/widening register space: r0..r10 plus every stack slot of a frame. */
-#define BPF_SCEV_REGS_NUM (MAX_BPF_REG + MAX_BPF_STACK_SLOTS)
-
 struct bpf_loop {
 	struct bpf_backedge backedges[MAX_BACKEDGES];
 	/* edges exiting from this loop, includes edges from nested loops */

-- 
2.53.0
