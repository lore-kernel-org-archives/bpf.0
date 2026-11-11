Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.54.127.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381535;
	b=pJ56mCmgYDuQZwvuFj6oRSZAMwPjmGPZn78Cyxp8/Br8a+H2osAo0c/ZCZifzJYXmEll
	 ALycqaaFnauMc4kMlqc13yoHTP5kjC1Ru+txLTjQ+biIGm6uo71qxRwZTAt6ekP1u44xX
	 QMc/I/KwthCftDTupn04jQ1LzyuezHh1Q84zC4JppNjVppDeg2yQtGuQA+m0QLP+XmMDR
	 K4itfeIZ4TSTrZyPGFyuXg/Rj1faRwh+diIccT9bgItR73nW5BxBrw/vvLk1PiuZs90Rw
	 l5ugeUkKWNUCbBpbZpu+0JBscptKX7tDVNcnOVM1jdtfYHpcNAGE8bzlpLVRUYnwjfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381535;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Envelope-From;
	bh=Kp1Yd4wm29HgwNoJ2gvAcoanCwg0f6KJOD8xxuJfVZY=;
	b=fZYo/a62RReUxUNCSuIbLY/WO1KiZFrNH+eWQKn5iq7tdYf+IDeATA86DAiY41MpnCzw
	 wJayflI7L99V04OJtDprJlyuyvo5tP/N3tZloWwgjnW9rokeFQzs6mFOBEp9vMqFj4ioa
	 qB4B4llARQaNC8crxbO0IZNC7mTbBFIY8JuKFCcXg8SVuNngNj8XwAluLmVcX3dbnRpSj
	 olcPphI2WR0P0h6G2Vntc/CwnZKSvZml4ZS/XLC/q7i5YbOSbySz5qz1Dyv/YTPTkGf88
	 rW1rwsOJ345qtu3eI3E0aU0sLuRtPPQXQQmdxuxkWzoqPdlCEeERnXQWlbgZ0DPO5Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=U8XAHHOc;
	arc=none smtp.remote-ip=198.54.127.133
Received: from out-2z4y-a133.jellyfish.systems (out-2z4y-a133.jellyfish.systems [198.54.127.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4304606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 07:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4304606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=U8XAHHOc
Received: from fedora (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jPZcq6tTzz6tkN;
	Wed, 11 Nov 2026 07:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1794381520;
	bh=Kp1Yd4wm29HgwNoJ2gvAcoanCwg0f6KJOD8xxuJfVZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U8XAHHOc01gSCV0clQRyXPtQmKBW0w98NKBFPeeARkdUNbxp+VDRRDyEUwqSofrEe
	 KCSpiqlBxTdqXSzcPZ7tTuvFm0xVnY/I+35Sx0QmMW1aIwGEAHw4xbttfIIeCgJmnW
	 KC2s+VNusadAM9AggKi1NDKcbUThJ6pgEqw9oMxbFkZMDDWStJrB5OFrojwg0fS71l
	 0HNTDQ3qHdDta4QCYco6qkQRlWyYuTUg1k9df9jxSgsRDyMfsV6HMpw8X8qNP0mbGE
	 K/loljwPlGSeHfR7sEDL3FyiHcZs7feDDBWADRCwjs9nt152Aej/8W9b9qRDjdiztP
	 5Ebv9ravdj5AA==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	yatsenko@meta.com
Subject: [PATCH bpf v2 1/2] bpf: Report lost RHASH batch traversal keys as EAGAIN
Date: Wed, 11 Nov 2026 16:18:23 +0900
Message-ID: <701a92691a4757132218729f99862cfd3b0e6e63.1794379108.git.hi@tychen.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794379108.git.hi@tychen.cc>
References: <cover.1794379108.git.hi@tychen.cc>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

If a key is deleted after a batch copies it, rhashtable_next_key()
returns ERR_PTR(-ENOENT). The batch code treats the missing next cursor
as end-of-iteration and returns -ENOENT with a partial batch, so callers
can silently stop before reading keys that are still present.

Translate a lost traversal key to -EAGAIN, as for a missing input cursor,
and preserve other iterator errors. Still copy the collected entries and
update the count, including for lookup-and-delete batches.

Fixes: 818e00848227 ("bpf: Implement iteration ops for resizable hashtab")
Link: https://github.com/kernel-patches/bpf/pull/14700#issuecomment-6641291019
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 kernel/bpf/hashtab.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 6e2115477cb9..346a2afb4ad3 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3556,14 +3556,15 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
 
 	rcu_read_unlock();
 
-	if (total == 0) {
+	if (IS_ERR(elem)) {
+		ret = PTR_ERR(elem);
+		if (ret == -ENOENT)
+			ret = -EAGAIN;
+	} else if (!has_next_cursor) {
 		ret = -ENOENT;
-		goto free;
 	}
-
-	/* No more elements after this batch. */
-	if (!has_next_cursor)
-		ret = -ENOENT;
+	if (!total)
+		goto free;
 
 	if (copy_to_user(ukeys, keys, (size_t)total * key_size) ||
 	    copy_to_user(uvalues, values, (size_t)total * value_size) ||
-- 
2.56.0

