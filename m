Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577611;
	b=e611b64gyqJdJXVmhB49JLB7QACUyWYo6pouXOnZuWhE37kxBIICMqQ3tup4HhTTIyoT
	 j6Yce6EVGjWx935LtFsmVsfeNnjh4qaRrcSkXccG360ZmsTf7NPfmqiTLfPodi+sDa4M5
	 SQhJzMBZHwzK5ZsPQsdmaW6fDK2pgm4yDItJIonW6cc7cN/cupYaRt5R6grJMKy2Ji4HX
	 7nuRGTp5EXzeNmBU3ksD6EU0ao+Nca1bU1sSILvbLeq8GjhC2xhsJP3Ryy/o9LJli/CfV
	 ce71BfIIIL0AtJq4XKvZJbzFateyEyrIIfCjC4plK7qzQYaSP/ZA8R0CigRUPdZDk+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MXi4VHUP+5SrX/Vd03Qer05Ni6osXUWxomJyle5l39I=;
	b=z468y0xpCR0YyKwex+m2OnI+S6F9s/eowd5GXmnYtFJIlTKkeFXWRGR0htrRpgPo8F7U
	 5LnasAop34BYPft6s6ObzXhU1zqon96PSlG3W/K5xqq9Gd+JJq/9SgP1fBeAvGGdPXxf9
	 Hgs6zNiAj/FDp3jyK78curoxJRM+2QpkJPxvYatbSWlQ67g3yLKTgHifW3cv/jT3zhexN
	 lVvWPe49aSSfGHzj2iERnf11dTofdc+TSYmpHk8QU/xy6JTfp8PayYpZwXL9BwXq5dUSQ
	 RyFNRM7n3lXi1XMMkkBUZBUkOu7yb6xg5hPqyxIFNhaK8v0kwl8K7+DDyeLa6u0FFoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t9Jy2ICY;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85345606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85345606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t9Jy2ICY
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b41e627cadso3257072a91.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577611; x=1796182411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXi4VHUP+5SrX/Vd03Qer05Ni6osXUWxomJyle5l39I=;
        b=t9Jy2ICYJ9jtTB0yV2GzJ0Idl2JD5uqmVPapE2h2AHbvlsRp7KtctFAGN07ZbmXmGG
         gkzAb//2pq5mg8rzWCCqgONIM6qxqCJXn6uAq7/cwoqjsVrugUVSl0d908b6J01J3W6i
         ebWtsTGLdeU+RBPlnKbKK/3effXvVWSlp6b+cLe9ieF0+q441JlMYL1lT0ir4itR4qVq
         LbTt7mR+MGmL+h0rqvAmwWh3H7buU7jofovSSQdEIPQNDchScjec3PoZ3Gkbd383THzJ
         j3p9YkhP72ow6PCcR2uUAbL9uYtwGPGNp2gl8dVH4IXvrxc2mGgr9I1GrIIJ4ZFlSq7L
         ncmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577611; x=1796182411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MXi4VHUP+5SrX/Vd03Qer05Ni6osXUWxomJyle5l39I=;
        b=xuugXc3Q0o9CiB3HZhP1X6QMx41Y1l6SGv/ZoKcZyIX6RrUZGyYqd67VwP+q8a26v4
         KMzvHQuQIS2cNYoLUR8KEF6P5JtH+dxKMlMfOQJLOToPVGq5An2QhVVKdnE5V2+XL/1V
         0Blp05KBf1WX6Y36yZt4OgE01yfD/J275uDD34r9lPeVvYasLCmxK+eIDpjf9yo8bfI8
         iokQ2eNLrtL8f7mgJC03e3i5CPm1ZjFXNWPw7DEr+X2+ViDkcydToBeN8E457S/97lWS
         oPQQXkFTyVeBtxJ6uO8f53X4eO6ssq1H+XL9Cgwr01baCUJ3lq8Nw/8gU/JZYqQWxFNp
         NIaA==
X-Gm-Message-State: APuU4Z8j/gY5iQNTglNPPno01SWENjim5Gsd7NYNFh2snUHifBrrwh/v
	A2Eu510jmmBLs3+7aVO7SldVcOk2f1edxtPRxMaWPVQLeD1YfcIW0EiqWD+x/0az
X-Gm-Gg: AZFdTZdCbimwcEJI+kTMDkKWsOfHrXaZmiII+potswkVMWJGlp8yiKnnpRykADnzHqg
	mYJ9gYI011x0WhlD2Tfk67E4Sz1ItleYu0KWr478LmjJept+xqZ7SDRjQmlIFU1vQSo9eQX5+rt
	UvrwytWs7sceLo3KZ8d/dO0EWPTya4EiSzU1gRREAs/rUs7d9jBeeAb03oOBZVK1TiKyuCYPJm1
	9dfxXyXSslymLU8Ylbz/N03AtyXCWPn1LxF/A5UtERMUs/NE7GhKVFF3UrgyG9wMrWalSd57YiZ
	z77zYyCigu0qNal4QUu5qZ5gaCLGUzcCsPu+/RV1oaLYNiTSKCbOjAea+W62+qgxzdg0Z4bCoYv
	dEr/xYU3hcRWjf4cjn2V7XqfNlZKnUJluYtn0jW9fgE3vccuxjCBe7xlFJmpsUQZSCJ707zzmjl
	8CQ64qZOEf2Ggti+B4xF8udFeHPSQXATcZlxG4rSWzVQf63BaUZhxZN4Lp+e0T/5cQcdth6T3Dg
	Ak7aGOIg2FKvkC7zbnL+Dd1VyOfYt3EVUV5RCB8zYlCAzFXDy8Xuejwi9Rz25wCjAylvYNpaRfK
	/Un4X+g0rpsWOG+ODjZMHBSBHDIVAd/pV/lIsCy5Ah+28WrKpid9sb2ZEzAnaIoja0vmm9mhdqQ
	I3ITnYUWrACZH7v3Ce434gDc6IKt4WQQy96+vQEJaMw/V5xyC5Zc7Wd0DWx2n2ZQLJvoyGBL6LZ
	8=
X-Received: by 2002:a17:90b:4a48:b0:3ac:97bc:4c7b with SMTP id 98e67ed59e1d1-3b41c8fe3bbmr16659254a91.14.1795577610625;
        Tue, 24 Nov 2026 19:33:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b8733e6sm9464744a91.3.2026.11.24.19.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:33:30 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 39/47] bpf: Fail loads from a network header that was not set
Date: Wed, 25 Nov 2026 03:29:30 +0000
Message-ID: <20261125032938.670542-40-alexei.starovoitov@gmail.com>
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

skb->network_header is 0 until something sets it. Loads at SKF_NET_OFF
and bpf_skb_load_bytes_relative() start at skb->head then, and read
headroom that nobody has written. qrtr and AF_XDP in copy mode make such
skbs.

Fail the load, like for the MAC header. A network header at skb->head
counts as set when skb->data or the MAC header is there too. CAN and
6LoWPAN make such skbs.

Fixes: 2e07fa9cd3ba ("[SK_BUFF]: Use offsets for skb->{mac,network,transport}_header on 64bit architectures")
Fixes: 0f5d82f187e1 ("net/filter: Permit reading NET in load_bytes_relative when MAC not set")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/filter.h | 9 +++++++++
 kernel/bpf/core.c      | 2 ++
 net/core/filter.c      | 5 ++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 5cf3582823f5..84d770aea722 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1055,6 +1055,15 @@ static inline void bpf_restore_data_end(
 	cb->data_end = saved_data_end;
 }
 
+/*
+ * If nothing has set the header, it points to headroom that was not written.
+ * The packet starts at skb->head when skb->data or the MAC header is there.
+ */
+static inline bool bpf_skb_has_network_header(const struct sk_buff *skb)
+{
+	return skb->network_header || !skb->mac_header || !skb_headroom(skb);
+}
+
 static inline u8 *bpf_skb_cb(const struct sk_buff *skb)
 {
 	/* eBPF programs may read/write skb->cb[] area to transfer meta
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b34d9bdaf67e..6742f5be8658 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -83,6 +83,8 @@ void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb, int k, uns
 	u8 *ptr = NULL;
 
 	if (k >= SKF_NET_OFF) {
+		if (unlikely(!bpf_skb_has_network_header(skb)))
+			return NULL;
 		ptr = skb_network_header(skb) + k - SKF_NET_OFF;
 	} else if (k >= SKF_LL_OFF) {
 		if (unlikely(!skb_mac_header_was_set(skb)))
diff --git a/net/core/filter.c b/net/core/filter.c
index b4057a6cdd7c..2415cd90ab5d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -232,7 +232,8 @@ static int bpf_skb_load_helper_convert_offset(const struct sk_buff *skb, int off
 		return offset;
 
 	if (offset >= SKF_NET_OFF)
-		return offset - SKF_NET_OFF + skb_network_offset(skb);
+		return bpf_skb_has_network_header(skb) ?
+		       offset - SKF_NET_OFF + skb_network_offset(skb) : INT_MIN;
 
 	if (offset >= SKF_LL_OFF && skb_mac_header_was_set(skb))
 		return offset - SKF_LL_OFF + skb_mac_offset(skb);
@@ -1862,6 +1863,8 @@ BPF_CALL_5(bpf_skb_load_bytes_relative, const struct sk_buff *, skb,
 		start = skb_mac_header(skb);
 		break;
 	case BPF_HDR_START_NET:
+		if (unlikely(!bpf_skb_has_network_header(skb)))
+			goto err_clear;
 		start = skb_network_header(skb);
 		break;
 	default:
-- 
2.55.0

