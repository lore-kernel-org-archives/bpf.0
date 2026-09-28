Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F054ACC60
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595630; cv=none; b=pwgSVnPJcNTJfhSvPvkWUbosNfwFv4MzKoR9U0D9BUojMWpiRgHSOlbSS600t4IphdO3mZMT3UKrc7BImlF89+xo02D7wrIn8cDi0+bAEnN/AGVYRbngqQvZhh0rD4i3171g96goYPNCK0H1NFsiQism9FnobFD1wDjm+SvS+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595630; c=relaxed/simple;
	bh=8/rChUYW7Td3PNJ8B7WVwcADIcz0IkfReOlFchPIltM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDzdmDBmzSBdJjdop9Dmuv5MAd7J3UtSV0CwBF1dZURXPmH8fpzB8EMXqIeJ7l81WHx8WPpUHNF5Vs38JzybZ2+BolnrCQD/ow6a/eQks2bwmdl8A8F2fyjywAeMVI3MyYEypJWFXw6W7SosOJDpoN7zE0lLqsrQ2KETzHXeWKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FMBwOXCh; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FMBwOXCh"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2afb4e9977so299291066b.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 04:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595626; x=1791200426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ie1AChGJyiZtE3erAbVg6bKiBAxNc2l4sps1XmU03pM=;
        b=FMBwOXChUeipRu36MhNmY6Gth5Ky/guugms1/lnbM2QfNh4wCr7bWc2iybaPDrqWfe
         D7r2auqn7IQODEixCR9rYeGi6i7VkXLqYi+TcnXYDCKP0sPExcE6tZqxEoZVAgcbGZmT
         TRoCtx6xb3SVSeW9xmCjpNyfze3/Vz3TKZGERApjkGxxgLVzQJhFUd/2hLr9WppC+hfb
         JoJNlA4PaHjmxU8B7opth8DviezunGKJzavhoBVtK0h5GRDRmfQF8P6UKvQAxARs8Sc4
         cdjDhnhuXr6f5BXlY4lhSObcTkRTv1YDA+kAo6ZYCYEVCYwRZ+yc3NpS1pX0gpzCyMf1
         dLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595626; x=1791200426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ie1AChGJyiZtE3erAbVg6bKiBAxNc2l4sps1XmU03pM=;
        b=pLLeV9l6tLxpGmdi6e2l+YrH/IulCxm8BDDbRf1z1vZOLmexzw8afSlXq48V2B5Q0e
         LPx4FMYIdaOh3hfpFPJ4iFLCNzC7BkFbMHbJ0XeHiXQO481gBn2H//DREbZQsM5LU00M
         iulLPvWaSayxR7JgtyCnMBzg1ifrb2QWJ97d2KsiUfXy8mWwGrO1Ds7FVgPxPK8Ipz0C
         YVWMnqcgxz/eDX1N49rai3VfQW7MuantzTr78sAu5y5u86v2rr4hKZUKZFcauuGJ850q
         n8hXv0eAoUIhwRHdi6BSDwq5vFym/qHb8rrPuzRS7GF4nfL5urm/zv1z/ZO391LM5Wlb
         pikQ==
X-Gm-Message-State: AFuF++lIq7Brr0Lzc0XepszXb4vqPbTbOMk1ZqAQmlUsIOuP4vCWif/+
	NKTLc0BGkk8A2N9NNkarMUG+4eV9Yo2CGVcVhF0qWl2TcZfgz8AJ1g0xOyUGCJVJIu0=
X-Gm-Gg: AYBFou1fzyzKtCC4YoQdnCDHkxeEUgqElNLfkFsu8XvfmndUivNoBGMARkeRVmI91bI
	gzZh/8GbLfMq8YceqfBqV7usq6BHwWKr+IcqFj7AlmOAcRBmk/wwzdWxRaHa4ie1EcT9xPyDvL2
	1S9UDN76j+DNdMcaq5UTql8GzjNTSE4lkYSTbIaFood3LOkkq846Y2K457oOMNfIpMzmG4/xbON
	jzC4x9QCX1tD4wX79FYOy8NHxOCPWmVLpfJzdEcVYMAqfsBxt2Tz0e1r8ol2JYuAkyP2jKwIaZ6
	hvaQvn6PxKbM/JpVedv5Zxn1tn2pcWwVP4YWt8ggNYVkOvtmMoP98XCXjGa5QoGQgOf88/Ts3MX
	Bvvq/EyerlgM5tr1DQlpWyezTKLJVe5ecipOWwVuCtJaHIulx2QEVD9wLEMGBvTZ9RT9HqGaAfU
	4/Atq0Wn034sflf19Vd8pCmzSglGbFFfV2NEBfiSvD2Xe0YScJq+BlVe1Oa4FwOLKkav1pZsxDj
	3hOn1zsA76bBZKfrRdVBMyvn5bnSF5Tn+xp/AOUyfUTZMNlWDvBC5xvczJ58O9JxmBXPJ3/X7kz
	xls959IwO/92
X-Received: by 2002:a17:907:e8d:b0:c29:f5d8:9c7c with SMTP id a640c23a62f3a-c2ac22cb147mr1026776566b.43.1790595626450;
        Mon, 28 Sep 2026 04:40:26 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-491b-1300-c0dd-2af4-566b-b23f.aa.ipv6.supernova.orange.pl. [2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dcf626b3esm180471466b.27.2026.09.28.04.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:26 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 28 Sep 2026 13:40:19 +0200
Subject: [PATCH net-next 02/15] bpf: Add bpf_skb_fclone_orig() kfunc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-2-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: b4 0.16.0

TCP write-queue skbs are allocated from the fclone cache, the packet
transmitted on the wire is a fast clone. A prog can only associate
metadata with an skb by keying on its address. On retransmission TCP
reuses the write-queue original, a different address with no packet
hook, so the retransmit carries no metadata. A prog can use this kfunc
to retrieve the address of the write-queue original and populate the
metadata stash for it, so the metadata shows up on skb retransmits.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 33c1ee3b966b..fdfc1016030a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12469,6 +12469,30 @@ __bpf_kfunc bool bpf_skb_is_traced(struct sk_buff *skb)
 	return skb->traced;
 }
 
+/**
+ * bpf_skb_fclone_orig() - Return the fast-clone original of an skb
+ * @skb_: socket buffer allocated from the fclone cache
+ *
+ * TCP write-queue skbs are allocated from the fclone cache, the packet
+ * transmitted on the wire is a fast clone. A prog can only associate
+ * metadata with an skb by keying on its address. On retransmission TCP
+ * reuses the write-queue original, a different address with no packet
+ * hook, so the retransmit carries no metadata. A prog can use this kfunc
+ * to retrieve the address of the write-queue original and populate the
+ * metadata stash for it, so the metadata shows up on skb retransmits.
+ *
+ * Return:
+ * * orig skb address  - skb is a fast clone
+ * * %NULL             - skb is not a fast clone
+ */
+__bpf_kfunc struct sk_buff *bpf_skb_fclone_orig(struct sk_buff *skb)
+{
+	if (skb->fclone == SKB_FCLONE_CLONE)
+		return &container_of(skb, struct sk_buff_fclones, skb2)->skb1;
+
+	return NULL;
+}
+
 #endif /* CONFIG_SKB_GATED_TRACEPOINTS */
 
 /**
@@ -12856,6 +12880,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb_tracepoints)
 BTF_ID_FLAGS(func, bpf_trace_skb)
 BTF_ID_FLAGS(func, bpf_skb_is_traced)
+BTF_ID_FLAGS(func, bpf_skb_fclone_orig, KF_RET_NULL)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb_tracepoints)
 #endif
 

-- 
2.43.0

