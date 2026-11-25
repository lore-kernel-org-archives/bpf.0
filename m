Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577477;
	b=a0ITByyt0yrRr4sPwEYS8UzFsnsH3rPk3eVtyVBHKIr4dfLIH00TD2cBa2/pb8ByV906
	 G7VYItiBxHO1NvZEFAyZJj7fx0qRMfMIeGBxzLbQ2riEEz06a5LVN77jH5l4AQtOuVKaU
	 XR15qiCBTsiRJIOoMqoDdvYQieve50LDtS9QEtGN9PszFjRgKLTvSymAsOHIRu2luE83X
	 6KS2+Zbz5NL0uTQacMS4qgjAwpe/DujZhZ3EbuxNICJ2Wbw183K86m14wa8KXPpvGWGLX
	 TLqkTqSSmwhpwyr27vVCJLAeVFSnnvUA78l//hw+7Sz8DWghSB8qflW0kVys+lwthAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tC0OHWMabOapP/Hxe6bLnXiDrUjRNGNbGVGsACZJshs=;
	b=t0AnqMN5V/A84ssJ+x6PpQ4F3C2/uCGUBErKK3Q/Fgi26vzI0/gZQIcITUyvKWaIlHYw
	 U+myxSj58Q1cPEdd5AqY3vuDNQgxGSlj8YC/KRTL6TMMgAF1Wn03Qgek9bB6Hnfg9IkBy
	 Cfecie9kVnfNMEnvDFQtVMtryUKZ8KZK1ZCuEwzHJGY2aYBmfnLCh/y8hbGVdrOodaObl
	 XD6IHNdA3phMvHxFhx9rKK44//arC2SWVZ89dmAt8WALjpzXFwMYaafEbqHDwHLRXKnI/
	 sX68ENeKq8//u0EImPA038VyPrWs3yxsGWC0/RAkQKsbrhs4rdqnbhpG7VWkPn1TiUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="XH/OeNRN";
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8177B606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8177B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XH/OeNRN
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f02f04a426so42649685ad.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577477; x=1796182277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tC0OHWMabOapP/Hxe6bLnXiDrUjRNGNbGVGsACZJshs=;
        b=XH/OeNRN3MrDKhwqp77A6ws6zPvbooTbd4gQwsZgYZZ7Ej9ubL80fmFQB5rjnOd6w5
         pX+tXFDt0OnRof+EKVKUOZI/x/TdYDtL8mQRuAKt/K9fFWoTyB7PbGC7TusWKOEnynEM
         Lkej60IiWeKKKY8EmZTG2ytJnW3Qy2qTSP3B6V+N7M/fHzhIvOBWWJZE/sVWG/Xib6bK
         Hjac7yti5+KPEWc9gNSD2jdSZa4uhjAapz3swTZNDU1lgy7/jSLDzw4O0tF3XwkGBEwa
         nvhgGpI7uFMP9aIsCDJKSz8GFterHsmLG1sJ0o1SV4xZKPjamJU/mUKdt+a2WVpYkRYV
         FFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577477; x=1796182277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tC0OHWMabOapP/Hxe6bLnXiDrUjRNGNbGVGsACZJshs=;
        b=j7OdPcbpv06FQy6Rgw1FxnlQdFRi/AK64gsDtdi8tKwfWTHktlcibcdgY2/4LT6D52
         6p5qN/OWCkJLbpBtTAN/Id/ZR6o6UMX4/n6wZ4rFnbdJIX9lpapYL5xwoyW9nWYb46jn
         +XC73CjGKhrfd+r3sZaqJJgP2OivSaRDL7flGGraY/ZmFcNRhMw/jXcwkSdRDLYCAmX3
         RVsJM+qiP5k1C+cKnG8ZoejSqTVBr8l4LCf/JPgKqSHyQ+l5urk2VEftyq4ZW/QcI1/t
         LVsZTQRhW29EpLBdGGAmsavXJ1k3KMNBEECVyqm2YnNFF6lfosWkCl4cEiGe9hajV0V4
         d4qA==
X-Gm-Message-State: APuU4Z9Dq3PzY4J2THAJ1nyN4mE9GqnTrn0EK01EYIch62i6BfL2ilF+
	O7vdD7zKcCTUqzYYSc4J8t79k6gdUwppwrUNyD9ZZf0ruAkAM/QBFP+oG92Y0BY/
X-Gm-Gg: AZFdTZfzbm0l7q239J7JeO47dgL6ZtOgx4h7IrCNh6rz9r13xojtlus87IqW2G8pf5V
	UO7X1H4zQmPqvIsGsXF94OAFxVabB9aFy0NHiRp8zvYi7yUnyFslsaq8udcEz4sGxoD1bJgm5y0
	YgYoy4UWUDSl8oW/ZzDp4FnDBQYasoAY66e5KFSItcOJwmg5gYROOrAU8G+LzE9clY7OHZ9E3re
	+50k5UGVe1OHLWMddVUJNl8IhmeAwIAH0APq8kt8umIDf9kbO2EThHFUyKwbtGfusPGT2Z6Rnbq
	a0wi2NS0L2L8JxE6M7bL8KXtuJR0IFQb1U9LlmZVAWc68Rgb4QlHOioZzwAFVhhXrhC4OqaqJRF
	X14jTQwbSQWlSi465w1c9S2DbUIWbTt02GwxEDMlyuv1soieCM7TX0qFGMQ8evFLkJ2ncOPdczt
	gI50VIpXI1hVTIUCQevDALglztydVOl8Q8Q6CBeDbI6BoujjxAYWFQiJnsDdZd9MKWl1dg+8luC
	RT59XhlWA2rpBRsN3iXX2gnI4d+M9BXItRc2H8n7ZSWfXKtEk/BsQ8Uhi64AjlGT117npF3eToW
	xkho4XeOridLjd9wLrnH1/lM+wXlcjkvbWgursheVZ+m+HhHQMtUmljYknecBK8rpC5F9FtG14o
	G44rPWMjWG6FWqTehM0UGVIZ58ukJU/BI2Yg1tHih9+uTW5chSah36aUp3g3KB7h3shj3akKWhc
	e4mgJ5qRPWgBN4QU5WTYsV
X-Received: by 2002:a17:902:ea01:b0:2e9:8ef0:cf6c with SMTP id d9443c01a7336-2f03f1ed55dmr159230105ad.26.1795577476771;
        Tue, 24 Nov 2026 19:31:16 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84294sm76205115ad.9.2026.11.24.19.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:31:16 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 16/47] bpf: Fix NULL dereference in XDP redirect from async callbacks
Date: Wed, 25 Nov 2026 03:29:07 +0000
Message-ID: <20261125032938.670542-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

bpf_redirect() and bpf_redirect_map() do not take the context, so the
timer callback of an XDP program can call them. There is no
current->bpf_net_context then:

  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
  RIP: 0010:bpf_xdp_redirect+0x5b/0x170

Return XDP_ABORTED, like the tc helpers return TC_ACT_SHOT. It is one
more test and branch on a value that is loaded anyway.

Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/filter.h | 5 +++--
 net/core/filter.c      | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4f0cd67caccb..5a664d706ee9 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1948,13 +1948,14 @@ static __always_inline long __bpf_xdp_redirect_map(struct bpf_map *map, u64 inde
 						   u64 flags, const u64 flag_mask,
 						   void *lookup_elem(struct bpf_map *map, u32 key))
 {
-	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	const u64 action_mask = XDP_ABORTED | XDP_DROP | XDP_PASS | XDP_TX;
+	struct bpf_redirect_info *ri;
 
 	/* Lower bits of the flags are used as return code on lookup failure */
-	if (unlikely(flags & ~(action_mask | flag_mask)))
+	if (unlikely(!bpf_net_ctx_get() || flags & ~(action_mask | flag_mask)))
 		return XDP_ABORTED;
 
+	ri = bpf_net_ctx_get_ri();
 	ri->tgt_value = lookup_elem(map, index);
 	if (unlikely(!ri->tgt_value) && !(flags & BPF_F_BROADCAST)) {
 		/* If the lookup fails we want to clear out the state in the
diff --git a/net/core/filter.c b/net/core/filter.c
index 49eb26d016a1..b9dbdd276b02 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4889,11 +4889,12 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 
 BPF_CALL_2(bpf_xdp_redirect, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
+	struct bpf_redirect_info *ri;
 
-	if (unlikely(flags))
+	if (unlikely(!bpf_net_ctx_get() || flags))
 		return XDP_ABORTED;
 
+	ri = bpf_net_ctx_get_ri();
 	/* NB! Map type UNSPEC and map_id == INT_MAX (never generated
 	 * by map_idr) is used for ifindex based XDP redirect.
 	 */
-- 
2.55.0

