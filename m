Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BF367C53
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448146; cv=none; b=Ya4I9SRJt6+Yj7DS2386uRCmWt0mTNvO0hHWpNQ8gPwRKAwPergy4atl5wC1AT7XHYHrg8sO47gRYDF7fyodEOd0Ct4EKtgdstcoz9a93vs/TAx+FI/jhe0cZX4xefTO+Rv8Ps1Fy/lt8ToKTbjQN6D/cHyV2DsiDE/maaev2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448146; c=relaxed/simple;
	bh=Z1OLtf6E5PMf/9kBkrbl2MYiXuIUdmgv/xvrpj2tdUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MIrrO0eksPegr8iQ7XU38Zg5hQ9qAl0RaR32Tor7z32Eet1fxUYrcTZhhoVX9KkHJ/Ik6beoS5xjG7WPBcNmZ5cRB67qYOYOQg/bClx81rEgAvUc56SkIQNz8U0qkOX4+Wt33hGcg5w39O155fmWZBapMQSNbSeJFsQ0Uz5gwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=IFufQG6y; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="IFufQG6y"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-341d381d056so659608f8f.0
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 03:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711448141; x=1712052941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDmXYhaNeAX6UOxwM63OVSsZVxNn+rHfTehIiUnUGCo=;
        b=IFufQG6yKf7r6pXrInqZlI8Nbr0dOh1fv7tC9n3TYxl2IfFB11mmTala4Xuag1udUL
         tcb61NHineQ7JNCG2wt2Y9hh90wE5cp4RJwjT9xwHo8BwFgPJmtK+9iXlWjGNHvFOnCs
         q83RZguYdSh9m1Hg3R6hQxz7JuV2EZs/iQKsBCbKZizCF7vdqPaGronanZ4BluJU8QEc
         gqzh6ha6PoHd2SgAS+TuVdcHkVHFTbKHguwt75+xCmBedwqEoE8GrP9SSL6LAQLCiHG4
         Fi61/X1PAa7W638BVW7socAKQL7GzOoBfPotCQRzV8XfOZPG2zfQX0xv4R0vOFUft2ey
         ICOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711448141; x=1712052941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDmXYhaNeAX6UOxwM63OVSsZVxNn+rHfTehIiUnUGCo=;
        b=PwXGTFT0ron6XoZBEzRBsyDecETwM1pdgjLxlaMOb25RcvEHtIgkCDW4SAhYmpSGUa
         ZmBCFYrRBqgHN8vrtYlUMap8d9W16OM+ObA3BNqRcadoq89Jrj2MoIH7FQtjdx1JDIv+
         u3KzJCK7GdVXYHIMUYp9Cxn82oi17PMGcHEKl8QsJhisn36jUitdw/xSACmdLOgW6bHv
         eVtPT1KUYSwhgSpwHT9fPFIA2WqOQhOyvAbkbNIkIECM9VtXCAkGBNxdLvGe+t8boAWo
         LM25OYcEXLoe9gccz+BbEVmI58TQo5xx4yBiGyTOY7FnGVBWAuhRHrbseJV+72IGCGxd
         /JWA==
X-Forwarded-Encrypted: i=1; AJvYcCVQPS4fZ4RUhkVKSo8a6Ga5OxJcLkNWR4nFjWhWs41D01ETlHLE4RiGmzBZzdqs2k7QtVPrt8jx2dQqN9lGFV9zCvgZ
X-Gm-Message-State: AOJu0Yx4qz3J0y4BQuV9u9qBwT8x4ob0gi7IQJ38cl4JkIPAPDsJptWY
	3oayS1rljm3wlWS4iMaFxCBFhJA4GTGGLxV/DQiEbZSK+4XNeSWM9t+AoBW8l40=
X-Google-Smtp-Source: AGHT+IFUlgvk84qtsV5V1cnnTCRyaV8l8W6P6+ueM8nZYoIoHbegrkiuZ5CT2oje2EiqQwBnVHbbxQ==
X-Received: by 2002:adf:eed1:0:b0:341:a63a:d253 with SMTP id a17-20020adfeed1000000b00341a63ad253mr5659647wrp.53.1711448140767;
        Tue, 26 Mar 2024 03:15:40 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id co20-20020a0560000a1400b00341d4722a9asm1891743wrb.21.2024.03.26.03.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:15:39 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 1/3] bpf: add support for passing mark with bpf_fib_lookup
Date: Tue, 26 Mar 2024 10:17:40 +0000
Message-Id: <20240326101742.17421-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326101742.17421-1-aspsk@isovalent.com>
References: <20240326101742.17421-1-aspsk@isovalent.com>
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
Reviewed-by: David Ahern <dsahern@kernel.org>
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
index 9585f5345353..96d57e483133 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
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
-- 
2.34.1

