Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327643D6CB9
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673371; cv=none; b=l2qMrtXnt0U1r9uRPQEXgx80zNWMP/ytbyQ0/AemDh+deiTF0PnmeFFbDn7L2BgR7zs6ZeH54RSxKOAUeb0pKw1IRbxAG7ZET0fE4xOug2cBO+WGLRgdCD2WoA2WFNxfMblINp+Cm+df4ex0VoRoHLV6NbeOc9qt3VxyUt7ymGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673371; c=relaxed/simple;
	bh=FoODtHK87ZLIsLT91VS2/t2ELTaMVveQekR6M37Rqe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2hm+IOvuM2yybq9jTsKWhKvzJkBmpjG2xU08HMf6HqZlsKDeBG3aVWsCMNSMmLw7bS+RKJucJGhRqhVcgoAGFCoNd8aLExqQyCZ/Dc6JiQiJsrxdZp8ryJX03CJrt7Hhu0KfXH4a4xXuXC0B7YYY1BOjj8r16DEzG0Ur/M0kjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSKXLrPy; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSKXLrPy"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so41424b3a.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 11:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775673369; x=1776278169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wzDfLfgSZvbjTVt4w0u1g9djtPuy1licBUfHTLjI5M=;
        b=BSKXLrPy31xj0ggNBDzR0btuBXq5De423O67MYBxm4mKugB07CFwwhRpmJfcGdFMiV
         NesuKIXP2m+BjHQmfGNiyr1HZvLLGJiOMO7gybhzBwFZv2AhdDAjb9VfdvzcFymMO0wQ
         yJGGF/oQfxI2fmNfT8p3pGvRX+njp/FX4J3pU8dVZ3BJZSgteTRL/84yRzzf4WobPeIq
         hrxzlFj/wSWYBw7yASxqOHGFu+5SGhsWGEFPB2biuDvIzKfGAG3RUnQ1bSbQDRDSPdF6
         0JQo599SczugsGyDI8+ZpAZIqkIaH02RyxticS3SszsfqUWeJl0DzuLNkYktzcOZHh1R
         Vhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775673369; x=1776278169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0wzDfLfgSZvbjTVt4w0u1g9djtPuy1licBUfHTLjI5M=;
        b=KYeisFi9d62b1z0DTi9YVieidi2NqMH6wQ2rtcEbKRuk0nBZ/YK0qUNyaITbMTEE44
         FHsnSo+X8Mo/+SuBRPEnYPwhjm0fFSxmHPY51Q3ApDuIvi4REc0/zQuWJcwSZn8qgGww
         ZW82y3KZO+7lwQhPPbhWvK+//7/JuYTqXJfSLof/J/7Q2QwFUipXP4Jvj/UPcS82m4lh
         bvZizMvX+LGVYC2YQiAUdNZU92P2h4ZiBjDwk1jYpDLR1bzs/ZX7m1I48iIfh8doBn+l
         wpVfC1nZWj9Mg4yKfyxB4lAEbX6MZShHKy9FQSuPbEWniXLeVJPmYL+6EQWq8+vPUwWP
         BKYA==
X-Gm-Message-State: AOJu0Ywq6QouJ/TgUBZQYn6CLSmj/7Gz2VW3w598w13QTlWnYUyp1qnb
	ckDl21Nipe5KAOE8hz05uYRCSWZs0aTvrW8QUDkqp1pbDZayk5yrrrQJXqyr5HrjZCg=
X-Gm-Gg: AeBDietXy7zC06kerZszf25RaQonlDjuvXLr9c+7+DkSYqrh9+/1+uTtuya9NckRxx2
	aKrw9ZrhqjJXuoT2ky8czf7JOhPDxdQSo02BptCSz2uRSApcjoqFO+tzcAE6Qa/xpQ195752O9+
	4f++/aX8FWYx9VOK0IFrQRMD9gftboIXo/p30p4eokIgiCffdRwTiCnLphZuYpPkMjRrgmbRbaS
	xEtfS0bjN+mcqPjwd7BmBwhgBpRqdDCy15LSop2SsXbj/Nr/QOr3rp0KUGlYhXkyPy0stDCtCug
	HQ9UMs1hVWeQXAWqqEkB1QlrWh2iJuq6ZGkRvzYYeRFx4Nxj4X3O3h6m/I3ppP7SqEdme/v7Qyl
	cVNeaUtyZ5lESv7fQm8Qi6T3VJuWFgOftbAyOSdDVrE/UHMRJxV63xSUX6PJ4HIex0RqAADeVGh
	Aq5DktzfKOTl0TC6J5GaeUMQ06UEoWfz+xJyZYJ9P8HfbyxUzxRZyDzmqRVWKNIqEeZSPe
X-Received: by 2002:a05:6a00:1304:b0:829:8942:2ca4 with SMTP id d2e1a72fcca58-82dd89aae52mr482081b3a.19.1775673369332;
        Wed, 08 Apr 2026 11:36:09 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1a96::2a6:4e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b21c92sm23113251b3a.11.2026.04.08.11.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:36:09 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: bpf@vger.kernel.org,
	leon.hwang@linux.dev,
	memxor@gmail.com,
	jolsa@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next v4 1/2] bpf: Reject sleepable kprobe_multi programs at attach time
Date: Thu,  9 Apr 2026 00:05:48 +0530
Message-ID: <20260408183549.92990-2-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408183549.92990-1-varunrmallya@gmail.com>
References: <20260408183549.92990-1-varunrmallya@gmail.com>
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

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Acked-by: Jiri Olsa <jolsa@kernel.org>
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

