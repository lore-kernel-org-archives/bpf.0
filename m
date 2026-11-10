Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283060;
	b=YmfdjPxjN+ItNOoR56e/hCk/IY0D87EbPG20fzaDVAgRMAGkbUoFDN9UqkO4L7cS+JmW
	 MALgPHc1MCcKGnj7/pqc68Bn00GkAzXTnVz75zTutbR78dlfg+MBckaag+K8r+RTvkL4u
	 VgAFrWf7iwxzo27JEgMNimfoxpZrNK26D4vMaKAMff65HfkFG4LNksXHrLZRgrXjkZ+WD
	 p5UfgCjEyR9c7QfLuDDWlnbwM0YvIzl57Yzdyd/tc7iKSgzFJg0xrdtmiXErDaQv/jyGY
	 t/unaGziM9suGEUIU4MvGCwVg43ljnvshYu1dj3hatqy663LQ2ff0zXFXcgSLs8brpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IMIS7KfMcbwFH4EjhakKpSZPpu7Y+oEkSnNYuobCRt4=;
	b=G/xxm5NOTqD8kOyZlbldVLnnDVO/bh/CaEtEujjDy6rmEA13P5MfreT3ZbeyoWZtQVe1
	 kr5uql/Hp0w45tOlmylmdzv06KPVvjiqkQFQuJ8yoO/o00P/mpYMGKZ9sPeSApKu97+PR
	 Vp/UWFL0rcTfI6i+F0PyCWSClTYog+zrmYiI1++KWxRQRKdIJfCd/bXeK/R8WefTtZ8NP
	 DNwQUmLy8GRXRjpfA6sJGUxh/S8lVRVKlOzon5hJZFr10VuYnGVvgL1itxmdBNGoLRg35
	 s6eL9xfujqcGb7uWG57YQzLcqRNClXzUMtdYD5+0LiPjVOIMAbBH8y81W6uLYDFezOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=ABwiHJF8;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E338860A2605
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 03:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E338860A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=ABwiHJF8
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso2327334a12.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 19:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794283058; x=1794887858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IMIS7KfMcbwFH4EjhakKpSZPpu7Y+oEkSnNYuobCRt4=;
        b=ABwiHJF8uRoIuX+DLpvMiqGhGqYaOhFABFxorxDzxkd6GIYPkHWXYOQ6ue2pWUuMm7
         PDulVSH6Ie4VNDUnAV+H/U0lhiJTP4IUp+SSFxwXvXTvRpfnk48hhYvBDP0G/yr11/UI
         9jw4ILmTvgoTC7Z1aC9K+b/J8rGTfpb4cZanllVLj4J8zsAYyvUUdIsKCezz4yee3yKD
         QMMHnppoAlrXJWQziV2HFCn8ayWrrrNvefvaGYXOTJUoUqs5XrZyhA0jm0qgrl2O1csR
         qJTbO96GXHjU2z/WKmGdzyxBI8xW1VVv8nLaGpg65yqKqRQWtIF9ZRe5CrgcV8mEJ957
         Z9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283058; x=1794887858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IMIS7KfMcbwFH4EjhakKpSZPpu7Y+oEkSnNYuobCRt4=;
        b=xR7F1s+usB/Csx2WACUSuAurRZsK1FLdkFxtsumB+uuKJ1Mw8b/dKBlZckpkB+vV5H
         qPFxj+tGOzXMVheFOETeYRC0JDd7CiSHf7memcbuewvLcjeWvySzNo3QKBR8ZGoTmImM
         9V7TMbzRu8psquukDhlXx9Fc8rQ1e/sTl4fIyKnFYbUwd0NQm090Z7LBkE9PVCqfW0xt
         SW2WZ1uowqoIjILolfmlcOlOcxRo0lX80Zkro9nbKzp0pCh79U/hZklpPHQn84HfYbgC
         kadWDi1PRpvUnbQ8YhsLNpaq3VF1xe3p6tIcGRK9Fkp1y3c7wuu1gqYuXrcBXGsNhN8K
         LQig==
X-Gm-Message-State: APuU4Z9ntOadXvuRIk0hQgrj5v6wrIbMGKVDdD5q6wULOwA7iE/XHtWb
	hV1o8S/6oahNQlZXZSyzK5WY9HE3QJiv7Cr2b6ofpkAe5EurEviac1Bm30RIYW9MF8V8F5veQg5
	WA/htykI=
X-Gm-Gg: AYBFou0FCjkrDA+sUAVIWk4tlpWXZjuN/ImFAu5B4HyLfPB5L1qgnsrNVfxk3/rAHrb
	hKCNIjKzz4bM8ecITsgQP1BezSfAcQy/Cksts9HyqoZvHxg0Z0jntO1+G9/aG20+Bk99mhGWA02
	4Wtmpfw232tPP/FUmMWewd+ns/BFwT1j0MaXl8ob55m5FYCi8+Z84z7ybMOQisieHrT0fMYHQCQ
	v8gby4Y5+8J/tJIyxdjGnGZgt3L3zaL+INUDrRGm6pku8uCWw8D0flHbUgMtLCDD+fgPdObnP8y
	nuiQmPjb0fINogtBZ1GqlDM7rAlH/rkEl/X5BQeHjH3Ypx23ry+jWOkdGJMJ9adk8J0x6fXNqFS
	M5dO8zARmxuvroZ84GWLwVmC4v/MDiy8D0UeMHQRZvWF/YsRZbGv6q78x4V8U2KbcWh089n67SM
	8tIun8dferjtRDj1GhzP2871rqyZ6Au+bw4ajmbcfQNHHsn+laAMOKGeZZJCGsmnjakrUoFwjHw
	1jdXp1L8omAIIaQLGHa8ps06wxGjmTUAfqK0hvJf9sqskNw7/qPjWaVsOHS4EDlBTSk4rIjQtN1
	xArzvsYfT69YIwMI0i8SNyjGUFDyPjZUcdHaOZ0lKG3JTSq16LLLecysSTowmGE=
X-Received: by 2002:a05:6402:4007:b0:6b5:8695:f839 with SMTP id 4fb4d7f45d1cf-6b756b0bf4cmr1096174a12.45.1794283058320;
        Mon, 09 Nov 2026 19:57:38 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 19:57:36 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Chris J Arges <carges@cloudflare.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	llvm@lists.linux.dev,
	kernel-team@cloudflare.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH bpf-next 05/15] xdp: add a kfunc to store the RX checksum status
Date: Tue, 10 Nov 2026 03:57:03 +0000
Message-ID: <f17f2567802dde23ad1cf81b572e0834c6531fe7.1794281983.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
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

Add bpf_xdp_skb_ext_store_rx_csum(). It stores the RX checksum status in
the skb core extension area. A later patch sets the stored status on the
skb built from the xdp_frame. The program can read the status from the
NIC with bpf_xdp_metadata_rx_checksum() from Lorenzo's RX checksum kfunc
series [1].

The kfunc accepts XDP_CHECKSUM_NONE with csum_level 0, and
XDP_CHECKSUM_UNNECESSARY with csum_level up to SKB_MAX_CSUM_LEVEL:

- Storing XDP_CHECKSUM_UNNECESSARY asserts that the checksums are
  correct, as in [2]. A program must store it only after it has verified
  the checksums.
- Storing XDP_CHECKSUM_NONE invalidates the checksum status, as
  requested in [3][4].
- After a decap, storing a lower csum_level updates the status, as
  requested in [5].
- CHECKSUM_COMPLETE is not passed to the stack for now, as suggested in
  [5].

Link: https://lore.kernel.org/all/20260715-bpf-xdp-meta-rxcksum-v5-1-623d5c0d0ab7@kernel.org/ [1]
Link: https://lore.kernel.org/all/20260630191510.81402-2-deliran@verdict.gg/ [2]
Link: https://lore.kernel.org/all/20260227153231.78d16b69@kernel.org/ [3]
Link: https://lore.kernel.org/all/amEojEGsIGkUjIWn@devvm7509.cco0.facebook.com/ [4]
Link: https://lore.kernel.org/all/20260721183256.6f49d6e1@kernel.org/ [5]
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
enum xdp_checksum has the same names and values as in [1], so this
patch does not depend on that series. The series merged later drops its
copy.

Stanislav was not sure that any NIC reports a level of 2 or more [4]. A
separate maximum for XDP would give the same skb field two limits, so
the kfunc uses SKB_MAX_CSUM_LEVEL.
---
 include/net/xdp.h |  6 +++++
 net/core/xdp.c    | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 23c976e92898..d8b77d80bfbe 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -701,6 +701,12 @@ enum xdp_rss_hash_type {
 	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
 };
 
+enum xdp_checksum {
+	XDP_CHECKSUM_NONE		= BIT(CHECKSUM_NONE),
+	XDP_CHECKSUM_UNNECESSARY	= BIT(CHECKSUM_UNNECESSARY),
+	XDP_CHECKSUM_COMPLETE		= BIT(CHECKSUM_COMPLETE),
+};
+
 struct xdp_metadata_ops {
 	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
 	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 2c1d5ec3311b..eea04e7b7204 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -1004,9 +1004,15 @@ struct xdp_skb_ext_vlan {
 	u16 tci;
 };
 
+struct xdp_skb_ext_csum {
+	u8 ip_summed; /* CHECKSUM_* */
+	u8 level;
+};
+
 static const u8 xdp_skb_ext_type_len[] = {
 	[XDP_SKB_EXT_HASH] = XDP_SKB_EXT_CHUNKSIZEOF(struct xdp_skb_ext_hash),
 	[XDP_SKB_EXT_VLAN] = XDP_SKB_EXT_CHUNKSIZEOF(struct xdp_skb_ext_vlan),
+	[XDP_SKB_EXT_CSUM] = XDP_SKB_EXT_CHUNKSIZEOF(struct xdp_skb_ext_csum),
 };
 
 /* Limit the header and all entries to 64 bytes, so that a new entry
@@ -1120,6 +1126,56 @@ __bpf_kfunc int bpf_xdp_skb_ext_store_rx_vlan(struct xdp_md *ctx,
 	return 0;
 }
 
+/**
+ * bpf_xdp_skb_ext_store_rx_csum - Store the RX checksum status of this packet.
+ * @ctx: XDP context pointer.
+ * @ip_summed: ``XDP_CHECKSUM_NONE`` or ``XDP_CHECKSUM_UNNECESSARY``.
+ * @csum_level: Number of consecutive verified checksums minus one, up to
+ *              ``SKB_MAX_CSUM_LEVEL``. Must be 0 with ``XDP_CHECKSUM_NONE``.
+ *
+ * Store ``XDP_CHECKSUM_UNNECESSARY`` only after the program has verified
+ * the checksums.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EINVAL`` : @ip_summed is not supported, or @csum_level is not valid
+ *   for it
+ * * ``-ENOSPC`` : not enough headroom for the entry
+ * * ``-EOPNOTSUPP`` : AF_XDP zero-copy buffer
+ */
+__bpf_kfunc int bpf_xdp_skb_ext_store_rx_csum(struct xdp_md *ctx,
+					      enum xdp_checksum ip_summed,
+					      u8 csum_level)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct xdp_skb_ext_csum *entry;
+	u8 val;
+
+	switch (ip_summed) {
+	case XDP_CHECKSUM_NONE:
+		if (csum_level)
+			return -EINVAL;
+		val = CHECKSUM_NONE;
+		break;
+	case XDP_CHECKSUM_UNNECESSARY:
+		if (csum_level > SKB_MAX_CSUM_LEVEL)
+			return -EINVAL;
+		val = CHECKSUM_UNNECESSARY;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	entry = xdp_skb_ext_add(xdp, XDP_SKB_EXT_CSUM);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
+	entry->ip_summed = val;
+	entry->level = csum_level;
+
+	return 0;
+}
+
 /**
  * bpf_xdp_skb_ext_del - Delete a stored entry of this packet.
  * @ctx: XDP context pointer.
@@ -1149,6 +1205,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(xdp_skb_ext_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_hash)
 BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_vlan)
+BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_csum)
 BTF_ID_FLAGS(func, bpf_xdp_skb_ext_del)
 BTF_KFUNCS_END(xdp_skb_ext_kfunc_ids)
 
-- 
2.56.0

