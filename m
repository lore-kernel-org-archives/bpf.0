Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221EB3A6F00
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278679; cv=none; b=H1qqU25DsO9OSItcIB/W4y8tBl2YsgReH08YMTVdiyt4ecApSO4oushIU1Dka3TxLAI1hOtaAlz2wGHWmhnuYYyjqSV8nK53jRrnQWxRmap+uVmuYvHZY+7XZaEyqGmGGU6uVaym5fKtgnOt3/ftTragH5MJkXPJ/tYJ+od61U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278679; c=relaxed/simple;
	bh=Klmfe1o8Ro3UfBYSMZmOTK+bSnWC9XzzEWPp3qAltrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChDQcXyeJm96TudyaLEVfiSJyO8d64eSkSKar2nb6oEXlCV7BapPmcC+1joVLQRNy60Ihw1j2+X7DFfGnEz+p45Mkcq8UuQ6kBlch7DYr1BqBfUoBGqpRQSQjFwobiA+OqOjYJhvU5uEAQw7t7pnybY99CUuXqWmTcst7OqNsHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PClvasxV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PClvasxV"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso4452115ad.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278677; x=1792883477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V2MWE2d8wxCeltTK5J7Eb19qoLth6D5RRjop52C0W/E=;
        b=PClvasxVpjoLGbDnorJyr5X5yJeXFwgbm7mMc4SfQHQ5XH8HsJJ1GH17wE5sJWwb0o
         KcnRYGtTl5C10OTCDymPhu7PuPjpZE+xCCvtXowdMMm3XophisNHUXXdS9IZoj9ql5ul
         JJYBfniytBl3q6j/5vlnR6EFInDC7bHvuKhZWmXj5YcXJabweSzDawfzNuPVVA01mdoI
         qKBOw+iyuVq8F5qRteEHoB7+M23MGNPiZ6WqEskNe5E4n5r0GbG9qz3MW4WFU6NqB5Mo
         e4590PbsTVrRWyk/NLFZRuW8//bgEEhkY32kahGYW6aol4UZzRMlENGpSD13ZZhpO5RV
         L6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278677; x=1792883477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V2MWE2d8wxCeltTK5J7Eb19qoLth6D5RRjop52C0W/E=;
        b=JQCC7FCl/KsGmfoywoY/M4s/ZH+g1shHSWnq0g2dsAHkJXFH7XDjqhYYFdxQbzpOpA
         TNwYKF92/o68lZKXRyj9ZRU6Lhivl37lnZ9fSTyk0ISwZ29LMZ8fJKHmF30BjcBCGIFf
         Ct7qLhIWln4uqqGKwrUZznD363Y/thuHzxwGMbEKmzUhsKspX4KHithxjVhl496E+cGC
         OFhiCQwpIUHe6Xn5O5l1kDplmvhdCG+zfl3BUPvuR1Hj6euRJdIiNcI3NpXdfrHDt/2w
         lB0LgbGFauoVhEOenzhb1Hy6W6gNeWcXtS7pYdfyTLh4j/bduStoL8DcsZuXvZLDS4wI
         zy/Q==
X-Gm-Message-State: AFq9FYKS2ZolqTTTL2P67A3TcJ80J/c3tiwxBMOAhP3KN86MKWI2hNG5
	e8JAyJwvgidF8rva/dIn2VJNh/t/Li7lAtPGRkoRU9S+eJrMdc9Gw9O4eY1c6w==
X-Gm-Gg: AYBFou31R4Xcup/bDsaibMGQsreQUpqVe3+hJL/F8sxjrrJM5UXxb/neliKvoMSc6sO
	DnMOv34rCoBA1pjmb727jgvoPUj1dmOE9GTH3qpsM3Gobd7p5oXFCrnmh16JUOz9tn5sMNPP7BN
	UDx24hc63IwAJdAhqdjCT1nJbmM2o/Q958BGIlLH9nckk+joWb80vlowyMwOmB0CqrxTqCUCbjT
	dU3J3lQVShB3HXCcJ6H8jumD51q3klZMnDgDRFq88h+6kN3EhBSF9qB+l8KBMTnZzlPj6K+71K1
	IqV7LDHoaxRKGfzmcgIeNT6jWfjhxhMIovlmHeSbmGc9+sBFBl5rqofDYwgZdROktt8vkfaBSwH
	Ni1OCO2l/eCAd27O8vUqm2F+20x+FxbJkmLxrXRnslDlXx7W1FpghbjQYVrMynPIbLJtLiUaC/5
	AUrBVKs39msTbiXREeepCVioK2ck/+EffG55y0WIrHkXmh+VQVQnnXMTKy6BOJ0dQZ3tHWvICfh
	hzqfuhTmz/UuekUnOIKcUgYL8OhcWK27nDWTI9xGjwHQ//5rKkA8PfHP5u3D3L43X6PVb1ertq1
	cgVqYm/sZOFKS7zZ+/MPfZwsU3LRfRzX1YoO4nI4z6A=
X-Received: by 2002:a17:90a:d44d:b0:39e:4c80:f67b with SMTP id 98e67ed59e1d1-3acef13e596mr3105502a91.26.1792278677440;
        Sat, 17 Oct 2026 16:11:17 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947dfa00sm14606794a91.17.2026.10.17.16.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:11:17 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 14/16] bpf: Use memmove() to store bytes in an skb
Date: Sat, 17 Oct 2026 23:09:48 +0000
Message-ID: <20261017230950.802052-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

Through bpf_dynptr_write() and bpf_dynptr_copy() the source of
bpf_skb_store_bytes() can be a slice of the same skb which overlaps the
destination. memcpy() then reads bytes which it has overwritten already. On
x86 with FSRM it repeats the first bytes of the source instead of copying
it. Local, ringbuf and skb metadata dynptrs are written with memmove() for
that reason.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 0abedbb04ab7..7fbee7570d0c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1749,7 +1749,8 @@ BPF_CALL_5(bpf_skb_store_bytes, struct sk_buff *, skb, u32, offset,
 	if (flags & BPF_F_RECOMPUTE_CSUM)
 		__skb_postpull_rcsum(skb, ptr, len, offset);
 
-	memcpy(ptr, from, len);
+	/* through a dynptr the source may be an overlapping slice of the skb */
+	memmove(ptr, from, len);
 
 	if (flags & BPF_F_RECOMPUTE_CSUM)
 		__skb_postpush_rcsum(skb, ptr, len, offset);
-- 
2.55.0

