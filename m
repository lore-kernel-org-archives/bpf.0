Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033F45C10
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116095; cv=none; b=N5X8GBgmk2pbKQajugfsRipVb7wutWwQhqYREuSLB7RI5VBVt+/cC7OtW2oZ6KhFgmfnRRQlZW/LGFB/TgMOmBJGVKXG72vs2zaxynicXvFKo4UDBvs9sNWKVJCKYqtIcB57RkhdW3adpC/xJjuYzkn3w/0bp6dsx9kPJCSXMtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116095; c=relaxed/simple;
	bh=XxDDKTw6DrdcHh31cllepsDFHSGbkRSF/Te9UGY5Neo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R+ilvgdxeTloOhJHw1FwzE3pgIJWOB8/16R+i2UsocxulEF9dQf6ILBiotAq5DRvs287CpHvWpp2VfyjWst4YHZLlJV/4/Kt6kYARf9kxQp75gVxxQCXGQJP8bKcNlcwexENf6C/hslnGnseoBzFeWlWWedkiouiroWOvpwkRfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=P/JfMNXA; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="P/JfMNXA"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44665605f3so255829066b.2
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711116091; x=1711720891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTNYGDXqQf9N+R8OuMfHGHGXbe5tIsgR29cu10ft4Vk=;
        b=P/JfMNXA6kifXFdShExQWyaDan0nLtYo8ElYvaXn5qsAZFd7NtAnzhBdEKbfAm4VLc
         TWsQRo9peSB44lZDUvS+7NJ/2/dFLK432O6qa+Zsl7CLQhEpGFwPjvCxL7muwqqkmSr8
         C/peMIgJuKYidKbng55Sg3rATHxTbJUdGNxSPR7piJ52qS0cKAzra6ASq6GelvfCVIIK
         9kqQr7LiS6QRgYkOyJoxtL++lcohFoE2rLFuqYTV6W4JSwhbPF/vZ5Hq0eNNEMu3JxQL
         mAfWhwnQIuggZCx7xM1QVLoT939/HSgwBCgcL0EOEKZsaY4xHFoAHFkBx/8YaZvre+IA
         NW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116091; x=1711720891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTNYGDXqQf9N+R8OuMfHGHGXbe5tIsgR29cu10ft4Vk=;
        b=GO9eMTc1Dp7ZYqoWoLbyj9c8TbKz9B0Lkc3nn+yrH0hR3fBE1o9RrwxHATk6EF6lgZ
         EH4oNz2KrK45KzR3jnQZyW9MVSuZxF7f23XwJUfhNc6PUvysvUbcEjm32qWvJNJDM2qi
         xnu6nuIzARnGbyxqRIK77zCZeEveVNoSNSU0RFItuXdZoUbxA2g3qUu69T8i1v5Tqs1s
         a8J+TJaGBmjCaQiQ4QWU+Js8tuuYaDaWhLdIKMA5eqGtq5EYuD6nLPkrOwuDCCOHsfVN
         mrctpOvpb0aJj7tmXAFJ1v8tf4AdOtMLyZrzfE0TLDo0VfUFTTwEncvFM+H8IFQNDNbK
         Uqbg==
X-Forwarded-Encrypted: i=1; AJvYcCVCuc1xhKZ1Wk0Vm9kRNQ8MGX5jGQYy5szMDg00WCnHygroUebOGftZs24VxAS9rkq7wdiui7gz3iKvTTWnxVdWiRoi
X-Gm-Message-State: AOJu0Ywx40qBEaku+AJoWpa/peDlumakVmsQBBYNt1G3VCafmGvQkPfI
	GAZl9zZ9jRdrbGW3Lmmw1JRs+jzz2PWXzueaxncQdF05bcwv654E2XNUUCi6oP0=
X-Google-Smtp-Source: AGHT+IEF7uk2VFP+Zsa02Dz4Jp22kEjXLZwwjbmjq7ejr4w5kkgDKpVRD3USIbeiIpMUhgStfWFLEg==
X-Received: by 2002:a17:907:970c:b0:a47:38ba:d249 with SMTP id jg12-20020a170907970c00b00a4738bad249mr690170ejc.5.1711116091546;
        Fri, 22 Mar 2024 07:01:31 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709063e8600b00a45ffe583acsm1038929ejj.187.2024.03.22.07.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:01:30 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Rumen Telbizov <rumen.telbizov@menlosecurity.com>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v1 bpf-next 1/2] bpf: add support for passing mark with bpf_fib_lookup
Date: Fri, 22 Mar 2024 14:02:43 +0000
Message-Id: <20240322140244.50971-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322140244.50971-1-aspsk@isovalent.com>
References: <20240322140244.50971-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the bpf_fib_lookup() helper by making it to utilize mark if
the BPF_FIB_LOOKUP_MARK flag is set. In order to pass the mark the
four bytes of struct bpf_fib_lookup are used, shared with the
output-only smac/dmac fields.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/uapi/linux/bpf.h       | 20 ++++++++++++++++++--
 net/core/filter.c              | 12 +++++++++---
 tools/include/uapi/linux/bpf.h | 20 ++++++++++++++++++--
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9585f5345353..96d57e483133 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3394,6 +3394,10 @@ union bpf_attr {
  *			for the nexthop. If the src addr cannot be derived,
  *			**BPF_FIB_LKUP_RET_NO_SRC_ADDR** is returned. In this
  *			case, *params*->dmac and *params*->smac are not set either.
+ *		**BPF_FIB_LOOKUP_MARK**
+ *			Use the mark present in *params*->mark for the fib lookup.
+ *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
+ *			as it only has meaning for full lookups.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7120,6 +7124,7 @@ enum {
 	BPF_FIB_LOOKUP_SKIP_NEIGH = (1U << 2),
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
+	BPF_FIB_LOOKUP_MARK    = (1U << 5),
 };
 
 enum {
@@ -7197,8 +7202,19 @@ struct bpf_fib_lookup {
 		__u32	tbid;
 	};
 
-	__u8	smac[6];     /* ETH_ALEN */
-	__u8	dmac[6];     /* ETH_ALEN */
+	union {
+		/* input */
+		struct {
+			__u32	mark;   /* policy routing */
+			/* 2 4-byte holes for input */
+		};
+
+		/* output: source and dest mac */
+		struct {
+			__u8	smac[6];	/* ETH_ALEN */
+			__u8	dmac[6];	/* ETH_ALEN */
+		};
+	};
 };
 
 struct bpf_redir_neigh {
diff --git a/net/core/filter.c b/net/core/filter.c
index 0c66e4a3fc5b..1205dd777dc2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5884,7 +5884,10 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 
 		err = fib_table_lookup(tb, &fl4, &res, FIB_LOOKUP_NOREF);
 	} else {
-		fl4.flowi4_mark = 0;
+		if (flags & BPF_FIB_LOOKUP_MARK)
+			fl4.flowi4_mark = params->mark;
+		else
+			fl4.flowi4_mark = 0;
 		fl4.flowi4_secid = 0;
 		fl4.flowi4_tun_key.tun_id = 0;
 		fl4.flowi4_uid = sock_net_uid(net, NULL);
@@ -6027,7 +6030,10 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		err = ipv6_stub->fib6_table_lookup(net, tb, oif, &fl6, &res,
 						   strict);
 	} else {
-		fl6.flowi6_mark = 0;
+		if (flags & BPF_FIB_LOOKUP_MARK)
+			fl6.flowi6_mark = params->mark;
+		else
+			fl6.flowi6_mark = 0;
 		fl6.flowi6_secid = 0;
 		fl6.flowi6_tun_key.tun_id = 0;
 		fl6.flowi6_uid = sock_net_uid(net, NULL);
@@ -6105,7 +6111,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 
 #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT | \
 			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
-			     BPF_FIB_LOOKUP_SRC)
+			     BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_MARK)
 
 BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index bf80b614c4db..4c9b5bfbd9c6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3393,6 +3393,10 @@ union bpf_attr {
  *			for the nexthop. If the src addr cannot be derived,
  *			**BPF_FIB_LKUP_RET_NO_SRC_ADDR** is returned. In this
  *			case, *params*->dmac and *params*->smac are not set either.
+ *		**BPF_FIB_LOOKUP_MARK**
+ *			Use the mark present in *params*->mark for the fib lookup.
+ *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
+ *			as it only has meaning for full lookups.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7119,6 +7123,7 @@ enum {
 	BPF_FIB_LOOKUP_SKIP_NEIGH = (1U << 2),
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
+	BPF_FIB_LOOKUP_MARK    = (1U << 5),
 };
 
 enum {
@@ -7196,8 +7201,19 @@ struct bpf_fib_lookup {
 		__u32	tbid;
 	};
 
-	__u8	smac[6];     /* ETH_ALEN */
-	__u8	dmac[6];     /* ETH_ALEN */
+	union {
+		/* input */
+		struct {
+			__u32	mark;   /* policy routing */
+			/* 2 4-byte holes for input */
+		};
+
+		/* output: source and dest mac */
+		struct {
+			__u8	smac[6];	/* ETH_ALEN */
+			__u8	dmac[6];	/* ETH_ALEN */
+		};
+	};
 };
 
 struct bpf_redir_neigh {
-- 
2.34.1

