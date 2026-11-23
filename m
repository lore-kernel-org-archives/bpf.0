Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446978;
	b=vncs8xrhfcHsJ5Bp+Pv69BrweH7WyChsYjxTnbIHUrcVMpXqpZ0OZDekGDEqIEWmiuQn
	 Fhs9eB0/cJKw+tp0UWP2srFZh6bSzieZgoX+iMCeQJ9tUdDtxVScbAMQ07jn0nr2AKjBZ
	 jwEmphvV6T1c65ioRHmhpKOOR8vnPs568LjbbcecgUD6gnf2+Dd5M17Y6pvp79JWufina
	 qMtxQfxuwqcme0z9TEHy/Yjvoa0nwHHQ7JazR1MwPxrZJ6NLhxCu4CVH9XSFwkkC6cZ03
	 A9h1N2g4mUk/kxFdYwI83oWzFUTT0AcvMnRe+d9KCrC4taQeA7axHywklJLjtcKyMXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=XDe4g1bU/aN3g6zvr+43wMrHIdQQ+2URWWfbfV1wal0=;
	b=P05QsxyTNL6WOWU629gCUOYnA8J27UD4wasjcMJSY9D8tFCkhPBvzqm3+U5QZPKN/nAG
	 hAz/K+lVov3UTVnQgrhr9ARZO4z9oHOGJdfi5quxXw+Zv4UIo6NCZD5T1W3VpBmi6y41N
	 RHh3OVZRmLu/CBgWN1xfU83H0T8g1bbEZXlGKVToe/VXPKiT9qV9OMt64NODw+s+rfoQ3
	 ov7FPI7sKg0P4c6W/0mNfxmXcmFkL335bH6T3af5+GjtKtF29gxeXu7xf0X5xUg5kwUpO
	 8oh1lV3EE1ztk/rlYNrR4YMbfy/T+H6LA9XdGJFsjLZBYMi04o5k7z1Y1HOWlCBr6Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PUHFh1Je;
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28250606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28250606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PUHFh1Je
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4ad4072943dso1118190fac.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 07:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446977; x=1796051777; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XDe4g1bU/aN3g6zvr+43wMrHIdQQ+2URWWfbfV1wal0=;
        b=PUHFh1Je7fHz2d0ZR1yweZHYCu3+ER1ChjZxXOIEh6clT62DfecXWofhrZsr53G6Z9
         5oEA8N7FiIF1O6XHBKQPUXNM9u3kzo5Pj3qX4uLnO4vAC8DLsYVKQcqU+c+B6BojCrnT
         0n/FUqMfKpstpQWQ89DCGAXZUuDjiZ5KfvswNsDg/ixeN7Stxec6PPMUF/RvxbRCtuGD
         AzBJU0uQmFgus9KqKkAnraKj4vhczd7qELF7gdEc+kdd4Q3iYXjpxLopG4MQ5ClhAeYz
         TlcJZUsK4FG7pTx8QzGUGydOl3jmLZceYIKq2i//sRtaecaEaTjl3dLp7tajTHK8GYC6
         oPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446977; x=1796051777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDe4g1bU/aN3g6zvr+43wMrHIdQQ+2URWWfbfV1wal0=;
        b=ZNI/8QS1x/y67pkRbnOtg9LnXakClmuEF9UFcqv5CRX2eTNe1h8SCgA0dfO1NML9dP
         B9vLunXfVf1B0/o6b/QPzUwjeO+/6NxGzrL5aZr5qSO6rLRIj85oHh+Ril/KAnkvmr5c
         9visaJ+YraawJcd7HWWFZMQdKoEQUxOM2JiZPQE6T8e1ce12Km63q40O9/l4MskOeVBN
         sjnwbPddihFlyaoJYftCaV0hC/wuXARoQrp1DDoAilHEZH1EZ9dzBVNDW9+OsqI7d4Xg
         RKIsHleqh/888pGyd1YSk6r+KvzUP2WyzKUHX9art6NDwq7SOO0t15y5weeUF9knPrb5
         g3XA==
X-Gm-Message-State: APuU4Z/0V94c4Wa6CqOprCnmnTfMu9ZFvqypixSVl9JzdakTDLSRG2nx
	QgZkGJ61KglNHm4oJ4aEx0+78ZvnzsJRSzXJ87hDxKmwIuPK8xetxugR
X-Gm-Gg: AZFdTZeDZUNXtUgLJpHNa4EpvPSszXiVngDoQapPypRYQ6qh+nLORSGewY3N4seFviG
	3yrtiWcOhndVxN1eNS5MR+OnfVENTkzMDT4g5kzJMRqwiK1jWSR4BOSp6/I6p2/hW6/ZEW/YZjx
	I816yOh/MMuEnLOklz7TPvzB1chHG4jPb8jDqqIgHmtVGjfDe2PWMKlJxFDFmHNUi8B1xgRG86D
	Mf0Px/A5+Mh/wZHI/2ZpBdQ7J4gaEG9zTkRuig96rXs6suzSFo8C/5bof89cQVN3HPEn8Lr2M7d
	BhgsCPRsz2P6/S1rajUwkA0WToZ2oqTyDc1ac1pjJmMGuC7imvmk738dr7Gx0RoHAMh85KhmtCP
	KsCK+lIFuYHUz7KE79T0h42osA54AFw8JRjrBc6oDyFuB+uIeG3BPCCoY2Jsy6+F9yLUTF5hfR3
	gOa20c5ob+05q3N1pLNN5YXIyF3iiOudaRCw4CWE4dx8nboPd1TNswj+ErNtSizUmD4Z0h30zv8
	yLEMgF8GrAdRosSAjRQ6nup+GOdanp9IsweMnCcoWnREwhUS2wVsliFy024yALYXD/XCpykxZ9y
	hiilGhKqAnVus4YqGCI=
X-Received: by 2002:a05:6808:244e:b0:53c:5052:ea07 with SMTP id 5614622812f47-57a06a105b2mr12053949b6e.5.1795446977019;
        Mon, 23 Nov 2026 07:16:17 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a35e5ab03sm9201149b6e.16.2026.11.23.07.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:16:16 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 23 Nov 2026 07:15:48 -0800
Subject: [PATCH bpf-next v2 08/13] bpf: Refuse the sk storage map iterator
 for BPF_F_INLINE_VALUE maps
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-sls_f1-v2-8-76474de9b052@meta.com>
References: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
In-Reply-To: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795446955; l=801;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=ewBUDz3y7x7l9bM4md7m861Y9DjbtbnnNDsNb1N0uzE=;
 b=iqbAXF5mHkCxs+Mlnrh34BBtlcUt84hnZZ6o0gdXqF2tbhAMv+kbvVnhx/X1FpoGsynFwZTj0
 bYYCqWrkq7jCsa+BiTdDjg1uEVLKDLTneAF2hDfBXdTts3mnP8Qzesn
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Inline values are not linked to the map, so the iterator would miss
them.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 net/core/bpf_sk_storage.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 409213755feb..d0eaf4de8090 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -938,6 +938,12 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 	if (map->map_type != BPF_MAP_TYPE_SK_STORAGE)
 		goto put_map;
 
+	/* The iterator walks the selems of the map: it cannot see inline values */
+	if (map->map_flags & BPF_F_INLINE_VALUE) {
+		err = -EOPNOTSUPP;
+		goto put_map;
+	}
+
 	aux->map = map;
 	err = bpf_iter_map_check_prog(prog, aux);
 	if (err)

-- 
2.53.1-Meta

