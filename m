Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DDF257827
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110870; cv=none; b=CaZPniYIcTZTk1RdGlBH3mT+GcFdFbqOCfS9juc73TlShTLkfLaSWWeyHXlj7MTPrRyzD2Y71K4LM8cLHVyes2yc7ybx6rmVCTZs4HV96z5jdqxWUatUAwgRigd9yzryUPxvpigASGVgUkGFmFMgxkbiQ4UYY4NXlmaXEuQWSBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110870; c=relaxed/simple;
	bh=KAyye0S/j0Cj2j7YQI8ACm6RlaORGm1yCDYWqO2MoG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyGgsOpWZZkqwzsqKMSKShU4s5uGh/C4EpHaCZMEnxRtWVRciMTQGuGZfstpeRNM+XLArC2ZCgPl83atQffrJVqiHg22fzvUBHTWnK4LisCrYUF5UvbwY6yL2SQcO0a+9DtiRBwXg953x9014hLdgkZ27LSDf8zvqmgEkP5tHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7G0YH/s; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7G0YH/s"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6798d4ab549so2448988d50.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792110868; x=1792715668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u1tD54QZ8gXmMt0UvyLjGMVeM4XPBHYfkYhcWssb2jg=;
        b=D7G0YH/sp7RwuuswRi4YL1ePBzhIxM9Ci3/gwzLHjp2PUUMuilpGLUDtSuV2JDS4YM
         TSSCp569I7KkEY0pFlXcZNGfozMqBAfAcJZk3HHT3qpIBQq6gewnw7u6WBwPCDD7JSFV
         4lzWp5rx/7ekkj+E3qW/Iwln+1mjBuHfuh3HByGkU8Q3Sj9cHXgobRMo4xB8sxter11B
         agOuQ+l+iwCuZqX2UUSO+tfBoIxq0aoabuBD7n0iA73qYfTlkZ49+A88ZbVNk6On6kZA
         VlSAxtCTFKI7IuxSCOTqgICmj+27HLjffBQCM9Yv671K8Ybm3Yun8cVjtP1Tq2/sfu1j
         mOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792110868; x=1792715668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u1tD54QZ8gXmMt0UvyLjGMVeM4XPBHYfkYhcWssb2jg=;
        b=zXLXmmO2w4BHMm0djW4nDGirv2aqH2dIGXveCh4PaSkb0YvEHdTKCsEFbWLFZGvPVn
         ogvxFWd8vdDJ8+f35s8JRlgxHml+1CW+CehpcvlFFg7lYnU1PZrUJUMMalfJN2jNQhnT
         mPc+7gzDCvuGvpLLU/RLiuw2/Q5/mDuZT1Az7xCwt6eChf9lEDXd7y5KaHlu99IrR7oM
         c3ooBBnCceLteSphPCbmBBiKgQsqWcwFiE8zVONwf1Ky3ejZhY6en0wH2Z+QmTCfk8NU
         W5a56fbTCuu1vX8yEXP5XgTdtFPQGvLcdGxbQlKege4jizxqSGMB48H4OUBOD7AxwakI
         VVDQ==
X-Gm-Message-State: AFq9FYIx/QGhRROiyaxKdyB2CXdmiLA/XPvpGRucarA1gbHX12wDcmMz
	s/xt8qcNg1t9U8STPnetOTejyPs6tJND5tm2dmSzMLzNAFTmieuEv61RTCEneQTI1q8=
X-Gm-Gg: AYBFou3jix1Kk6s6+CmIwxZ63GE9GgIyW6PXWgApJtTefQwBLBvmPU1CDxnS8qEY14n
	oX6+6Zdrl6AhfwlbS3oGr3dr+MO8uCweuq3AtDX0R2NEUxL2I/OVAqIKgrsZI7+DohSwi+zniiy
	dI9UVUB55MSpVon1q8NH9dTr08pEMEw0XNstHh7rwPA3wQB6ThtwZqQ2iNLR39UgAydgY8KR7mN
	GsFbg8WrF/SVuVXfXFpB9+NajsQqKEgp4QjCaF91/yXMkXK5/gcgfkA6f2Ngic8Gs8SQZbsPynG
	XQzv9gesgsAmgMEiQUYiSyz3tp2JOAnsQrYQGHSFnlAGR5PzXx6xwiSzG+tD++FtqGq/f8dNq5J
	ly6id8VsbXRduQMl9IWXdYk8ZOA2adFO4itI+rR4huSE2/zoFQHmUYgK+O7MlZmYtl750DZv7eZ
	PX0Qppony9WaThpGoOv4xfXczh3GlP8gt954fFG71t8blHI8zy8VE=
X-Received: by 2002:a05:690c:6d84:b0:8b0:d8f1:79c4 with SMTP id 00721157ae682-8b0d8f180b1mr15763367b3.55.1792110867985;
        Thu, 15 Oct 2026 17:34:27 -0700 (PDT)
Received: from corey ([2600:1702:5081:b900::49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e58892cfsm2982937b3.10.2026.10.15.17.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 17:34:26 -0700 (PDT)
From: Igor Malovitsa <igor.malovitsa@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org,
	Igor Malovitsa <igor.malovitsa@gmail.com>
Subject: [PATCH bpf 2/2] bpf: Fix user ringbuf empty check on 32-bit position wrap
Date: Fri, 16 Oct 2026 00:33:18 +0000
Message-ID: <20261016003318.529860-3-igor.malovitsa@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016003318.529860-1-igor.malovitsa@gmail.com>
References: <20261016003318.529860-1-igor.malovitsa@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__bpf_user_ringbuf_peek() copies the unsigned long producer_pos and
consumer_pos into u64 locals and tests cons_pos >= prod_pos for an
empty ring. On 32-bit, once producer_pos wraps past 2^32 and
consumer_pos has not, every drain sees an empty ring and the user-space
producer gets -ENOSPC from then on. The fit check total_len >
prod_pos - cons_pos is wrong in the same state.

Keep the positions in unsigned long and test emptiness through their
difference, as the kernel-producer side does since commit 6ff5b56a50c5
("bpf: Fix pending_pos walk on 32-bit ring position wrap"). On 64-bit
nothing changes: unsigned long is u64, and the signed test differs from
cons_pos >= prod_pos only for positions 2^63 bytes apart.

Fixes: 205715673844 ("bpf: Add bpf_user_ringbuf_drain() helper")
Assisted-by: LLM
Signed-off-by: Igor Malovitsa <igor.malovitsa@gmail.com>
---
 kernel/bpf/ringbuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 6b86c4db5108..b79cc433d2c6 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -750,7 +750,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
 {
 	int err;
 	u32 hdr_len, sample_len, total_len, flags, *hdr;
-	u64 cons_pos, prod_pos;
+	unsigned long cons_pos, prod_pos;
 
 	/* Synchronizes with smp_store_release() in user-space producer. */
 	prod_pos = smp_load_acquire(&rb->producer_pos);
@@ -759,7 +759,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
 
 	/* Synchronizes with smp_store_release() in __bpf_user_ringbuf_sample_release() */
 	cons_pos = smp_load_acquire(&rb->consumer_pos);
-	if (cons_pos >= prod_pos)
+	if ((long)(prod_pos - cons_pos) <= 0)
 		return -ENODATA;
 
 	hdr = (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb->mask));
-- 
2.53.0

