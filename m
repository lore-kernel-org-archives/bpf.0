Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D50223328
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706973; cv=none; b=M05b5j1d8l8H9djAJTHdsYWKg3aDs54ANR09nlGSShSHwgqV/E99mIHscJOHxrxvoS8ckvIgtxFVdTNjhzbKvSqpKwKchnqnp0ZO/lLPokKB08K8enFOzZ9fJm52m/yuShDO4eQyrTVPfQm8h2EwKFIMHIWUS27AkHO/sX+BpnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706973; c=relaxed/simple;
	bh=MH9pMA5tBj76KKVaDsd/HxMdOB1/Yo5Uc23GxTClXWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=taFlLRZ/m90mIjhXhMA7YWXkCJ+1PQliwzFeySKQL1w1FJrdEZbXsXCOG+LoTrOij3bStlkAeUt7GRa4HVbdYBFu7vSZnBq1WMTCwf39KBfapbDGU1OOXskZyH6EqXIrEp+n+2NvWVasmflB5ChBiiijZo2U2rwqHwZcmDPAOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxLCV63f; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxLCV63f"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b1710405so6211865e9.2
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783706969; x=1784311769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=62LK1B4AP8fb0CoLCmSu1gxf8mNW3/RpPJK1TqUpKKA=;
        b=VxLCV63fpV6UX0Q6cfat1bbXyGFv3bg2nqkDfwWeg9/1cM1osXnrCCjqbbegCsEst1
         hzBj4jOzio1cFVtF428czlUV3MWrlzU/fWPF7qHuIL1Y5sgTfvPsfoDPkNVPiuohiOZp
         7vX111WWY53wMoKLVYZWDwHy6rOZcEtX13HIg94Sfw6mqt6KjFpajc4lO9G1gU/l+/8r
         Gp+4U8vsSiK0AdFtqo82U68Nw5r5hUrUKGssTCSREXUeWGoqnsxo2aTmCx/XkzcHYStB
         YtrHNymR+SGdsJThRaNvFVJ33ndAan5JCbssyaUpm+1oQIkmJuMwx3bSjuiGrtRSq9o7
         620w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783706969; x=1784311769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=62LK1B4AP8fb0CoLCmSu1gxf8mNW3/RpPJK1TqUpKKA=;
        b=TdJaxbotKjlvjnPNrKq38mTEO4pcFb3Yvb7Y6KfrZxo7GMw4PMQK4Bo/sfQI1Ox9Rd
         W8p8EaV52hM2CQAwc4DJSlBFZ+/DmspNM79IQnkiZwpozhljSMOB6AbeJTEUjf2j4Eaf
         Y6IxdMIIQ++9EhHwQ+mE8/W2PkggXv8cycdwUyMdSUZOV6hO7SZufyV8M9AEFHKsLv/q
         EiuNGsjj5Qm/+XJ4ZnTAz1tGRmPJbunyTm16SPK8irGfSFTbQQI1qjwOlqLvvHvPrd89
         yrFpSml3zLleisw22YAuOgXwCwZhk6mb8uBC7UeEXqCwttVHBEOHJkik53BSkeApI7JD
         sCAg==
X-Gm-Message-State: AOJu0YzZpGuSBWVVwEPLdmR/BkksUJ3t35Gb6TbE5MwZHh01NP8accdZ
	/jRJjOg1+pxfqtUiyJ8g5RBPMncDEM9HT4mHATiL3gD5TVBlQJ8Tb5ulgQih9n1UcpA=
X-Gm-Gg: AfdE7cmSJCWPU6RI1kNbVhipGSm91X0oZRmcPVj/e+402oPE055G1JSyuVu+r3fatAj
	7swhMKXt+6iHkKC+8HglMxuFLutkA8ARCJoqzhokiIKtIvC30WdtATFyFUP4Vbt7HdbhMCclSbi
	CtO7os8hf11wqNWDVC/fb+Hahxd50i21RCXvRniecyoAy9+2f7unW1QyNbx2WTw2MG0UMa3vJAx
	msoMNKdytoOC6MjtB3FVkRtDgBcEARqqKp6ec28xJo/tK31oxVNJsoJgmCDtrcfP/Ok7rBbtbqH
	H+t1wW5tFix9LN5v2VNfZ+x2mpDYG0XOUTU3LYXe/oUb4ljNmrNNDWT1WziaUdCtK2uI1kwmLll
	sU686A+6pXCD0C6yYazuC8RI42X5xGel+d1wOfNOEJg6BwhX4P8X8T1ywsg+jrz3+n9xZbi7UA7
	Tudb+ag5NHaOhcRZNDQMseJlX4bq1w/Femey/YXxoKmjjQ6ANn6NZ6arH1Jg==
X-Received: by 2002:a05:600c:1c0b:b0:492:4c2e:9613 with SMTP id 5b1f17b1804b1-493e6864191mr133210795e9.18.1783706969079;
        Fri, 10 Jul 2026 11:09:29 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-493eb670a41sm148593095e9.0.2026.07.10.11.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:09:28 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: Mahe Tardy <mahe.tardy@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jordan Rife <jordan@jrife.io>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Fix unused nskb warning in bpf_icmp_send
Date: Fri, 10 Jul 2026 18:09:15 +0000
Message-Id: <20260710180915.7105-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declare nskb inside the IPv4 and IPv6 case blocks so it is only present
when the corresponding code is built. The case braces are intentional to
scope the local declarations under the switch labels.

Fixes: f3603df9aebb ("bpf: Add bpf_icmp_send kfunc")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607110140.JeJZ6GIa-lkp@intel.com/
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/filter.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index e4697036c67b..056deb9b3fc3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12575,7 +12575,6 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 __bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
 {
 	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
-	struct sk_buff *nskb;
 	struct sock *sk;

 	sk = skb_to_full_sk(skb);
@@ -12589,6 +12588,8 @@ __bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
 	switch (skb->protocol) {
 #if IS_ENABLED(CONFIG_INET)
 	case htons(ETH_P_IP): {
+		struct sk_buff *nskb;
+
 		if (type != ICMP_DEST_UNREACH)
 			return -EOPNOTSUPP;
 		if (code < 0 || code > NR_ICMP_UNREACH ||
@@ -12606,7 +12607,9 @@ __bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
 	}
 #endif
 #if IS_ENABLED(CONFIG_IPV6)
-	case htons(ETH_P_IPV6):
+	case htons(ETH_P_IPV6): {
+		struct sk_buff *nskb;
+
 		if (type != ICMPV6_DEST_UNREACH)
 			return -EOPNOTSUPP;
 		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
@@ -12620,6 +12623,7 @@ __bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
 		icmpv6_send(nskb, type, code, 0);
 		consume_skb(nskb);
 		break;
+	}
 #endif
 	default:
 		return -EPROTONOSUPPORT;
--
2.34.1

