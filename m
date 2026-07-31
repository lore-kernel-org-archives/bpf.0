Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5860B222580
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514184; cv=none; b=C8tv1aAdfCPdNkaS8/3mOEmz+YoQTyGZgMweV8dyi3oKDPZVLVIPUi7yQtGr5mb947Vtn4JR9AwggjCqxH/RHtyMo+w8t5pbAb0rFSTSr36qbnqLvgY0/24xjJzKuzbZ0uVf0UrivZJp654gos4tgjasL3TVDOyWi4lXWjIZm6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514184; c=relaxed/simple;
	bh=QuOHVUXZaNXIhrShG9cSusa/YKkv8CbCwuwOv5iBRuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sctIf8CumZKk7LcD/32Pvnj/YWNrY356u9ZliiiPB+ldNBEb/xOn8zK1MHDt6hRN7vAPquxN0DxDyoVpbii4/NwvV5N12t0rqapG1guKXmArYq3dP7J1RrfPZDMdHjSJ1Kn/2DWI1/Zb8ograXaqnEaYJ/LNntVTUSocq5P+wPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDHBUdqc; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDHBUdqc"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664f5750b02so128849d50.2
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 09:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785514182; x=1786118982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HryNKTJ9ZUnf2M5m7KIoAdHK6I+SlFQkEvsnZ8zee2c=;
        b=ZDHBUdqcaewPYvSBd0UMifrj6G3KYHUk6PLUHzsnlk7ZGpd5sxf3EO6AiLicGplg+W
         mZ+5VHw5lXtbc27XK4pnfTfzfZa0YXrCwmSpvPYQUUujppCeqo22lFjj7UFbo7dBcOCI
         iJn+PmbdKQdCfwKy87sVqf8ihIfiud++niItWW3i8EOAIb1zSBokzXOhqzlPHkDe3RKo
         KTivB7ksGRgqo1eMmijmAmb2sHqXV7C8Tez3GpiHbb4/PaI/o/0q6tnWXGDG/UzSfCBb
         yr5lVoD+E6YD8thA9ebrKEQsVfK799fYoEtQA3OOevnh85Qtr4x1UX6Z+uoTK+eoXmSk
         YqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514182; x=1786118982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HryNKTJ9ZUnf2M5m7KIoAdHK6I+SlFQkEvsnZ8zee2c=;
        b=lsqZmRIUnB/kj9zqM8v7nCUP98k4Pc0FrQtxRQj8+v4I49j22tA6r2hPGI9zFNCcrs
         zioj0re4MmUz4/wmxcZstUISC5NNbz+oug84yOa/3sGubcbbMGukXUPsCH67P/oR9hzw
         pdTgogymWuyARONtL6dgHotI7n7Xi71ZUpMh1TBQM+vLZHUt21PIE9wF6weMwpKPVEGL
         mv0taMfiA60U+V2dJaRrGqSdubd7VzooROrEcl+cIgiepBx5ygMUKbrdqa74zKS+m4vj
         IlMHsnTZELBOFBHiPpcQVCHsjpGK1OJ+Av1LiREaRVICUweMDaE9uZsRorh+a2evWWKv
         mwtA==
X-Forwarded-Encrypted: i=1; AHgh+RpugMxZOrSbL/FrRCycR7jI5NfWVk1Ku5AFKCN2bLBxjdQ2Pg7QCVsYMWQ+K8pSGVQC/SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ifcNxZXNFCYmn27CvaPblHsn7MiEoqA+h2DiOcvEihPAipq0
	MPAf7RvFSn1PRtsLRZqqXesU0j3MRDcl2pO65rHzfrREO4p1EzXrecoS
X-Gm-Gg: AR+sD13k2TTapAR4BnFsZQQTCyuAARmD43NgAEWrSftU9bPfOMrTiNJLHPRbG/dI1ZY
	s6DNLBM8MKGhs+cl0INfOpDcw9ZAcKjxlyi18o+EvymHex2lXWZ2p4kSbyz8eA+m0Vg8+AxYcHs
	peZ2eKrbxnoE1DcxZiRZIhPGpTLITdQHA9hcfKzLlVHS4SuIGvVS9IoOhjFBN5J1k6HIjoa+YRl
	8f7yx4V0ssEUDuSZ/mk+HVKOiSBRgBgHj5S1ndKzl1YRSVMOaOgWCgsUIRae1r78PLmj98hRoaa
	r910yxm5jLHhp46rVWTW9OQGpL2UzMAWdgKw42bwwnHXyzMrEhs7hpxr5ZK6jTuyFa7MH/mdCU0
	g4Ts/6IYg6vHHZsqG1hIj8tVn8ihkm9ss4FkaZfXlLyBcaAvtsr3WXO811A5m3+Lla0C6QfWJ18
	g/6izbu0wDMUuhVtPtOiSMFrkiQ2H3vp6Dno4pInegZrJESlXBy/KWkGAbU/99J/Bdi+A2gFlQu
	6fABpOkWbiAh2iLXH1mU7cmVerAr1DqI+Yj9itawHxfAEp9lzMrLvP06YlGwIpAZbE=
X-Received: by 2002:a05:690c:d8b:b0:7f0:9099:daed with SMTP id 00721157ae682-81fd4831691mr5715347b3.0.1785514182186;
        Fri, 31 Jul 2026 09:09:42 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf610a0sm9179887b3.14.2026.07.31.09.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:09:41 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH bpf v3] bpf: Fix netns reference imbalance in conntrack kfuncs
Date: Sat,  1 Aug 2026 00:09:21 +0800
Message-ID: <20260731160921.3245840-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The opts argument of the BPF conntrack kfuncs can point to a shared
map value.  __bpf_nf_ct_lookup() and __bpf_nf_ct_alloc_entry() read
opts->netns_id separately when acquiring and releasing the network
namespace reference.

The reference imbalance can occur as follows:

  CPU 0                                  CPU 1
  read opts->netns_id (-1)
  skip get_net_ns_by_id()
                                         write opts->netns_id (id)
  read opts->netns_id (id)
  put_net(net) /* no matching get */

The reverse transition leaks the reference.  Repeating the unmatched put
can destroy a live namespace and crash later users.

The kernel reported:

  Oops: general protection fault, probably for non-canonical address
  KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
  RIP: 0010:bpf_prog_test_run_xdp+0x52c/0x1700
  Call Trace:
   __sys_bpf+0x1662/0x50c0
   __x64_sys_bpf+0x73/0xb0
   do_syscall_64+0xf9/0x540
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  Kernel panic - not syncing: Fatal exception

Snapshot every input field of opts with READ_ONCE() before validating or
using it.  The netns_id snapshot keeps the namespace get/put pair
balanced, while the other snapshots keep the remaining options from
changing partway through an invocation.  The individual reads can still
observe an inconsistent combination during a concurrent update, but each
selected field value remains stable for that invocation.

Fixes: aed8ee7feb44 ("net: netfilter: Deduplicate code in bpf_{xdp,skb}_ct_lookup")
Fixes: d7e79c97c00c ("net: netfilter: Add kfuncs to allocate and insert CT")
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v3:
- Inline the one-use reserved-byte READ_ONCE() checks instead of
  copying them into a local array.
- Reorder the new local declarations in reverse-xmas-tree order.

Link: https://lore.kernel.org/bpf/20260730082958.2065194-1-nicoyip.dev@gmail.com/ [v2]

Changes in v2:
- Snapshot l4proto, ct_zone_id, ct_zone_dir, and the reserved bytes in
  addition to netns_id, as requested in review.
- Rebase onto bpf/master.

Link: https://lore.kernel.org/bpf/20260729163141.213611-1-nicoyip.dev@gmail.com/ [v1]

Please queue this fix for stable kernels.

 net/netfilter/nf_conntrack_bpf.c | 72 +++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 24 deletions(-)

diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index f98d1d4b42c3..c2df7c948281 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -122,42 +122,54 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_sock_tuple *bpf_tuple,
 	struct nf_conntrack_tuple otuple, rtuple;
 	struct nf_conntrack_zone ct_zone;
 	struct nf_conn *ct;
+	u8 ct_zone_dir = 0;
+	u16 ct_zone_id;
+	s32 netns_id;
+	u8 l4proto;
 	int err;
 
 	if (!(opts_len == NF_BPF_CT_OPTS_SZ || opts_len == 12))
 		return ERR_PTR(-EINVAL);
+
+	netns_id = READ_ONCE(opts->netns_id);
+	l4proto = READ_ONCE(opts->l4proto);
+	ct_zone_id = READ_ONCE(opts->ct_zone_id);
 	if (opts_len == NF_BPF_CT_OPTS_SZ) {
-		if (opts->reserved[0] || opts->reserved[1] || opts->reserved[2])
+		ct_zone_dir = READ_ONCE(opts->ct_zone_dir);
+		if (READ_ONCE(opts->reserved[0]) ||
+		    READ_ONCE(opts->reserved[1]) ||
+		    READ_ONCE(opts->reserved[2]))
 			return ERR_PTR(-EINVAL);
 	} else {
-		if (opts->ct_zone_id)
+		if (ct_zone_id)
 			return ERR_PTR(-EINVAL);
 	}
 
-	if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS))
+	if (unlikely(netns_id < BPF_F_CURRENT_NETNS))
 		return ERR_PTR(-EINVAL);
 
-	err = bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, opts->l4proto,
+	err = bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, l4proto,
 				    IP_CT_DIR_ORIGINAL, &otuple);
 	if (err < 0)
 		return ERR_PTR(err);
 
-	err = bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, opts->l4proto,
+	err = bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, l4proto,
 				    IP_CT_DIR_REPLY, &rtuple);
 	if (err < 0)
 		return ERR_PTR(err);
 
-	if (opts->netns_id >= 0) {
-		net = get_net_ns_by_id(net, opts->netns_id);
+	if (netns_id >= 0) {
+		net = get_net_ns_by_id(net, netns_id);
 		if (unlikely(!net))
 			return ERR_PTR(-ENONET);
 	}
 
 	if (opts_len == NF_BPF_CT_OPTS_SZ) {
-		if (opts->ct_zone_dir == 0)
-			opts->ct_zone_dir = NF_CT_DEFAULT_ZONE_DIR;
-		nf_ct_zone_init(&ct_zone,
-				opts->ct_zone_id, opts->ct_zone_dir, 0);
+		if (ct_zone_dir == 0) {
+			ct_zone_dir = NF_CT_DEFAULT_ZONE_DIR;
+			opts->ct_zone_dir = ct_zone_dir;
+		}
+		nf_ct_zone_init(&ct_zone, ct_zone_id, ct_zone_dir, 0);
 	} else {
 		ct_zone = nf_ct_zone_dflt;
 	}
@@ -171,7 +183,7 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_sock_tuple *bpf_tuple,
 	__nf_ct_set_timeout(ct, timeout * HZ);
 
 out:
-	if (opts->netns_id >= 0)
+	if (netns_id >= 0)
 		put_net(net);
 
 	return ct;
@@ -186,46 +198,58 @@ static struct nf_conn *__bpf_nf_ct_lookup(struct net *net,
 	struct nf_conntrack_tuple tuple;
 	struct nf_conntrack_zone ct_zone;
 	struct nf_conn *ct;
+	u8 ct_zone_dir = 0;
+	u16 ct_zone_id;
+	s32 netns_id;
+	u8 l4proto;
 	int err;
 
 	if (!opts || !bpf_tuple)
 		return ERR_PTR(-EINVAL);
 	if (!(opts_len == NF_BPF_CT_OPTS_SZ || opts_len == 12))
 		return ERR_PTR(-EINVAL);
+
+	netns_id = READ_ONCE(opts->netns_id);
+	l4proto = READ_ONCE(opts->l4proto);
+	ct_zone_id = READ_ONCE(opts->ct_zone_id);
 	if (opts_len == NF_BPF_CT_OPTS_SZ) {
-		if (opts->reserved[0] || opts->reserved[1] || opts->reserved[2])
+		ct_zone_dir = READ_ONCE(opts->ct_zone_dir);
+		if (READ_ONCE(opts->reserved[0]) ||
+		    READ_ONCE(opts->reserved[1]) ||
+		    READ_ONCE(opts->reserved[2]))
 			return ERR_PTR(-EINVAL);
 	} else {
-		if (opts->ct_zone_id)
+		if (ct_zone_id)
 			return ERR_PTR(-EINVAL);
 	}
-	if (unlikely(opts->l4proto != IPPROTO_TCP && opts->l4proto != IPPROTO_UDP))
+	if (unlikely(l4proto != IPPROTO_TCP && l4proto != IPPROTO_UDP))
 		return ERR_PTR(-EPROTO);
-	if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS))
+	if (unlikely(netns_id < BPF_F_CURRENT_NETNS))
 		return ERR_PTR(-EINVAL);
 
-	err = bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, opts->l4proto,
+	err = bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, l4proto,
 				    IP_CT_DIR_ORIGINAL, &tuple);
 	if (err < 0)
 		return ERR_PTR(err);
 
-	if (opts->netns_id >= 0) {
-		net = get_net_ns_by_id(net, opts->netns_id);
+	if (netns_id >= 0) {
+		net = get_net_ns_by_id(net, netns_id);
 		if (unlikely(!net))
 			return ERR_PTR(-ENONET);
 	}
 
 	if (opts_len == NF_BPF_CT_OPTS_SZ) {
-		if (opts->ct_zone_dir == 0)
-			opts->ct_zone_dir = NF_CT_DEFAULT_ZONE_DIR;
-		nf_ct_zone_init(&ct_zone,
-				opts->ct_zone_id, opts->ct_zone_dir, 0);
+		if (ct_zone_dir == 0) {
+			ct_zone_dir = NF_CT_DEFAULT_ZONE_DIR;
+			opts->ct_zone_dir = ct_zone_dir;
+		}
+		nf_ct_zone_init(&ct_zone, ct_zone_id, ct_zone_dir, 0);
 	} else {
 		ct_zone = nf_ct_zone_dflt;
 	}
 
 	hash = nf_conntrack_find_get(net, &ct_zone, &tuple);
-	if (opts->netns_id >= 0)
+	if (netns_id >= 0)
 		put_net(net);
 	if (!hash)
 		return ERR_PTR(-ENOENT);
-- 
2.43.0

