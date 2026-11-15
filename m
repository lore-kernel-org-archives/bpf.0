Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.60.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794773913;
	b=jKuBk2wCosUVHQ3o7/lLXR5oQtHmD+Pc96DMxbN0Yw9pX4MSnB12EMgzURgWWW1+J0R2
	 cytFksNB4Jvvmjnv3Q9aqdJQUI+x0ZoHPnOYpIx6sTTPRx6LZN6MU/Dr9sD93PNPv9Zm9
	 0ZGu0g35EG3YdTbpZEWXUTAAKIDQWmHz+iNxY76kXjn+awtxByeQdcc5EnL1vq9xuRbVu
	 utKfhD50KkMOjr0bON3kz6BecN9WmkstVb4hD6MzgfgFd0fAsk5CyfGyszGl5hZPGa8sU
	 OG68ONSOeX0wKAMAlWq0Vp1b8xbQ9ZoqyR1bfHnbBPBMPzg64UOeNqJ7uRLbUPho1oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794773913;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vQ2tyOwbK5WQv38IZHVy8Yk++UAAsc+yKEdQ/NRLmIA=;
	b=QvCzZzA4KJ2Fcb2QJk0DBUAso8Fawv1aCMGAm/MPg2EJn6yGsqusBMbVT/vS3NNf+D6g
	 unAix17i66JO4KLdn49RNv/iufPht7cUksH+NzqecUxLe4jfMFWjDSX3gWsmOqce97oKj
	 bBm8/8cLA2pk70lKWXie6YkskVL4b7tZOOrjRoKNv/UynSKB08eTIfc5EFNRmOxApzZWS
	 +1rXvYpgU/hajRhHbyRGmj6S84sLV0+1q1r1kPnfimEGcORbvps2SXCTMXBAkdfKw5njU
	 Cp+RctdiRF+UI4IOpFAfKle+PosTE3YG5cUGBNeY1RhFU3NfnO2Gp4wseiu7hoIOszw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corp.free.fr;
	spf=pass smtp.mailfrom=corp.free.fr;
	dkim=pass header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=cAhkMDCO;
	arc=none smtp.remote-ip=212.27.60.169
Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09296606A330;
	Sun, 15 Nov 2026 20:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09296606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=cAhkMDCO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1794773910; bh=+hwUiVsKl2lue8TzryyWtpRpuO0ZynO28DmPbDjyACU=;
	h=From:To:Cc:Subject:Date:From;
	b=cAhkMDCOJI4wkfxWTKv8sDOyJA2RjgKaf/TEeQHQlIEAYPDSh8LuOGedkrfMDPWg+
	 SUlnKTr49tbkNb8QSbuQc2Mlxc2DZJPjViwdsKIrz653fYOzvOAnk89u9bYTWXubpv
	 itZr0c/mTVxE++4TjjO7EPteTgJts7bDfKrUozX4QiYMD83GpSweBEHBQmhBhpSkr+
	 z/xsIZI1cz3mt+mdNkGeE8NZKZS6K7NVaESEf3mZh+PxuKzin/msL2REaQ/xKjzoU/
	 rhFZfvt0xiVUbP4TWMEDC6n1s6Jq/vGaqoSqtg2UWSDRAjw0LDPtY3D3RL61NPnd+f
	 YBZfjtH87LBQg==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id DD30844C0479;
	Sun, 15 Nov 2026 21:18:29 +0100 (CET)
From: Alexandre Cassen <acassen@corp.free.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next] net/sched: act_api: fold tcf_idr_create_from_flags() into tcf_idr_create()
Date: Sun, 15 Nov 2026 21:18:22 +0100
Message-ID: <20261115201824.3680803-1-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
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

All actions but act_simple pick their per CPU stats from the action
flags through tcf_idr_create_from_flags(). Merge it into
tcf_idr_create(), which now allocates per CPU stats unless
TCA_ACT_FLAGS_NO_PERCPU_STATS is set.

act_simple prints the packet count of its plain stats. It now passes
TCA_ACT_FLAGS_NO_PERCPU_STATS. Its only visible change is the no_percpu
flag that tc actions ls now shows:

  $ tc actions add action simple sdata incongru
  $ tc actions ls action simple
  total acts 1

          action order 0: Simple <incongru>
           index 1 ref 1 bind 0
          no_percpu       not_in_hw

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
---
 include/net/act_api.h      |  6 +-----
 net/sched/act_api.c        | 15 ++-------------
 net/sched/act_bpf.c        |  4 ++--
 net/sched/act_connmark.c   |  4 ++--
 net/sched/act_csum.c       |  4 ++--
 net/sched/act_ct.c         |  4 ++--
 net/sched/act_ctinfo.c     |  4 ++--
 net/sched/act_gact.c       |  4 ++--
 net/sched/act_gate.c       |  4 ++--
 net/sched/act_ife.c        |  4 ++--
 net/sched/act_mirred.c     |  4 ++--
 net/sched/act_mpls.c       |  4 ++--
 net/sched/act_nat.c        |  4 ++--
 net/sched/act_pedit.c      |  4 ++--
 net/sched/act_police.c     |  4 ++--
 net/sched/act_sample.c     |  4 ++--
 net/sched/act_simple.c     |  5 +++--
 net/sched/act_skbedit.c    |  5 ++---
 net/sched/act_skbmod.c     |  4 ++--
 net/sched/act_tunnel_key.c |  5 ++---
 net/sched/act_vlan.c       |  4 ++--
 21 files changed, 42 insertions(+), 58 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index fd03f6319e88..8591486cb877 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -194,11 +194,7 @@ int tcf_generic_walker(struct tc_action_net *tn, struct sk_buff *skb,
 int tcf_idr_search(struct tc_action_net *tn, struct tc_action **a, u32 index);
 int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
 		   struct tc_action **a, const struct tc_action_ops *ops,
-		   int bind, bool cpustats, u32 flags);
-int tcf_idr_create_from_flags(struct tc_action_net *tn, u32 index,
-			      struct nlattr *est, struct tc_action **a,
-			      const struct tc_action_ops *ops, int bind,
-			      u32 flags);
+		   int bind, u32 flags);
 void tcf_idr_insert_many(struct tc_action *actions[], int init_res[]);
 void tcf_idr_cleanup(struct tc_action_net *tn, u32 index);
 int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 13317d1abde1..7628f64faba4 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -799,7 +799,7 @@ static int tcf_idr_delete_index(struct tcf_idrinfo *idrinfo, u32 index)
 
 int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
 		   struct tc_action **a, const struct tc_action_ops *ops,
-		   int bind, bool cpustats, u32 flags)
+		   int bind, u32 flags)
 {
 	struct tc_action *p = kzalloc(ops->size, GFP_KERNEL);
 	struct tcf_idrinfo *idrinfo = tn->idrinfo;
@@ -811,7 +811,7 @@ int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
 	if (bind)
 		atomic_set(&p->tcfa_bindcnt, 1);
 
-	if (cpustats) {
+	if (!(flags & TCA_ACT_FLAGS_NO_PERCPU_STATS)) {
 		p->cpu_bstats = netdev_alloc_pcpu_stats(struct gnet_stats_basic_sync);
 		if (!p->cpu_bstats)
 			goto err1;
@@ -855,17 +855,6 @@ int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
 }
 EXPORT_SYMBOL(tcf_idr_create);
 
-int tcf_idr_create_from_flags(struct tc_action_net *tn, u32 index,
-			      struct nlattr *est, struct tc_action **a,
-			      const struct tc_action_ops *ops, int bind,
-			      u32 flags)
-{
-	/* Set cpustats according to actions flags. */
-	return tcf_idr_create(tn, index, est, a, ops, bind,
-			      !(flags & TCA_ACT_FLAGS_NO_PERCPU_STATS), flags);
-}
-EXPORT_SYMBOL(tcf_idr_create_from_flags);
-
 /* Cleanup idr index that was allocated but not initialized. */
 
 void tcf_idr_cleanup(struct tc_action_net *tn, u32 index)
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 3aea3ff5785f..f651098deabf 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -305,8 +305,8 @@ static int tcf_bpf_init(struct net *net, struct nlattr *nla,
 	index = parm->index;
 	ret = tcf_idr_check_alloc(tn, &index, act, bind);
 	if (!ret) {
-		ret = tcf_idr_create_from_flags(tn, index, est, act,
-						&act_bpf_ops, bind, flags);
+		ret = tcf_idr_create(tn, index, est, act,
+				     &act_bpf_ops, bind, flags);
 		if (ret < 0) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index 0b6ac6be60d2..2844eca7cd26 100644
--- a/net/sched/act_connmark.c
+++ b/net/sched/act_connmark.c
@@ -129,8 +129,8 @@ static int tcf_connmark_init(struct net *net, struct nlattr *nla,
 	index = parm->index;
 	ret = tcf_idr_check_alloc(tn, &index, a, bind);
 	if (!ret) {
-		ret = tcf_idr_create_from_flags(tn, index, est, a,
-						&act_connmark_ops, bind, flags);
+		ret = tcf_idr_create(tn, index, est, a,
+				     &act_connmark_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			err = ret;
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 5fff52a8ca90..72f5e4f3d82c 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -69,8 +69,8 @@ static int tcf_csum_init(struct net *net, struct nlattr *nla,
 	index = parm->index;
 	err = tcf_idr_check_alloc(tn, &index, a, bind);
 	if (!err) {
-		ret = tcf_idr_create_from_flags(tn, index, est, a,
-						&act_csum_ops, bind, flags);
+		ret = tcf_idr_create(tn, index, est, a,
+				     &act_csum_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 7602733d7f6b..342c6a8d4964 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1427,8 +1427,8 @@ static int tcf_ct_init(struct net *net, struct nlattr *nla,
 		return err;
 
 	if (!err) {
-		err = tcf_idr_create_from_flags(tn, index, est, a,
-						&act_ct_ops, bind, flags);
+		err = tcf_idr_create(tn, index, est, a,
+				     &act_ct_ops, bind, flags);
 		if (err) {
 			tcf_idr_cleanup(tn, index);
 			return err;
diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
index fced4b1094af..876cf8f7e3c3 100644
--- a/net/sched/act_ctinfo.c
+++ b/net/sched/act_ctinfo.c
@@ -212,8 +212,8 @@ static int tcf_ctinfo_init(struct net *net, struct nlattr *nla,
 	index = actparm->index;
 	err = tcf_idr_check_alloc(tn, &index, a, bind);
 	if (!err) {
-		ret = tcf_idr_create_from_flags(tn, index, est, a,
-						&act_ctinfo_ops, bind, flags);
+		ret = tcf_idr_create(tn, index, est, a,
+				     &act_ctinfo_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index ec9a65dfc442..bcd9b87ac347 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -104,8 +104,8 @@ static int tcf_gact_init(struct net *net, struct nlattr *nla,
 
 	err = tcf_idr_check_alloc(tn, &index, a, bind);
 	if (!err) {
-		ret = tcf_idr_create_from_flags(tn, index, est, a,
-						&act_gact_ops, bind, flags);
+		ret = tcf_idr_create(tn, index, est, a,
+				     &act_gact_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 711cf2443540..6d64c1d43a23 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -411,8 +411,8 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
 		return ACT_P_BOUND;
 
 	if (!err) {
-		ret = tcf_idr_create_from_flags(tn, index, est, a,
-						&act_gate_ops, bind, flags);
+		ret = tcf_idr_create(tn, index, est, a,
+				     &act_gate_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index ad77eb303ae7..01f7eef261e1 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -549,8 +549,8 @@ static int tcf_ife_init(struct net *net, struct nlattr *nla,
 	}
 
 	if (!exists) {
-		ret = tcf_idr_create_from_flags(tn, index, est, a,
-						&act_ife_ops, bind, flags);
+		ret = tcf_idr_create(tn, index, est, a,
+				     &act_ife_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			kfree(p);
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 1c98e4d81ebe..657dbc86c31e 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -171,8 +171,8 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 					   "Must specify device or block");
 			return -EINVAL;
 		}
-		ret = tcf_idr_create_from_flags(tn, index, est, a,
-						&act_mirred_ops, bind, flags);
+		ret = tcf_idr_create(tn, index, est, a,
+				     &act_mirred_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index a870386386d9..58957f6fd3d8 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -196,8 +196,8 @@ static int tcf_mpls_init(struct net *net, struct nlattr *nla,
 		return ACT_P_BOUND;
 
 	if (!exists) {
-		ret = tcf_idr_create_from_flags(tn, index, est, a,
-						&act_mpls_ops, bind, flags);
+		ret = tcf_idr_create(tn, index, est, a,
+				     &act_mpls_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index a201979ac7cf..f9e8e9e26cd1 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -60,8 +60,8 @@ static int tcf_nat_init(struct net *net, struct nlattr *nla, struct nlattr *est,
 	index = parm->index;
 	err = tcf_idr_check_alloc(tn, &index, a, bind);
 	if (!err) {
-		ret = tcf_idr_create_from_flags(tn, index, est, a, &act_nat_ops,
-						bind, flags);
+		ret = tcf_idr_create(tn, index, est, a, &act_nat_ops,
+				     bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 99d7e36510bd..a4eef302cc00 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -196,8 +196,8 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 	index = parm->index;
 	err = tcf_idr_check_alloc(tn, &index, a, bind);
 	if (!err) {
-		ret = tcf_idr_create_from_flags(tn, index, est, a,
-						&act_pedit_ops, bind, flags);
+		ret = tcf_idr_create(tn, index, est, a,
+				     &act_pedit_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index 0b0c09e3dfd9..e36cd8e0c08a 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -80,8 +80,8 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
 		return ACT_P_BOUND;
 
 	if (!exists) {
-		ret = tcf_idr_create_from_flags(tn, index, NULL, a,
-						&act_police_ops, bind, flags);
+		ret = tcf_idr_create(tn, index, NULL, a,
+				     &act_police_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index 3029e93c4dea..2acdfa939a81 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -69,8 +69,8 @@ static int tcf_sample_init(struct net *net, struct nlattr *nla,
 		return ACT_P_BOUND;
 
 	if (!exists) {
-		ret = tcf_idr_create_from_flags(tn, index, est, a,
-						&act_sample_ops, bind, flags);
+		ret = tcf_idr_create(tn, index, est, a,
+				     &act_sample_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
index 80e5084b4dbd..5bded0695482 100644
--- a/net/sched/act_simple.c
+++ b/net/sched/act_simple.c
@@ -134,8 +134,9 @@ static int tcf_simp_init(struct net *net, struct nlattr *nla,
 	}
 
 	if (!exists) {
-		ret = tcf_idr_create(tn, index, est, a,
-				     &act_simp_ops, bind, false, flags);
+		/* tcf_simp_act() prints the packet count of tcf_bstats */
+		ret = tcf_idr_create(tn, index, est, a, &act_simp_ops, bind,
+				     flags | TCA_ACT_FLAGS_NO_PERCPU_STATS);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 1f958b7d2a60..52e999b14284 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -221,9 +221,8 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 	}
 
 	if (!exists) {
-		ret = tcf_idr_create_from_flags(tn, index, est, a,
-						&act_skbedit_ops, bind,
-						act_flags);
+		ret = tcf_idr_create(tn, index, est, a,
+				     &act_skbedit_ops, bind, act_flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index 72dedb9b19a6..bde17f9626a1 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -171,8 +171,8 @@ static int tcf_skbmod_init(struct net *net, struct nlattr *nla,
 	}
 
 	if (!exists) {
-		ret = tcf_idr_create_from_flags(tn, index, est, a,
-						&act_skbmod_ops, bind, flags);
+		ret = tcf_idr_create(tn, index, est, a,
+				     &act_skbmod_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 28d9cc080101..357be7b3f9e2 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -507,9 +507,8 @@ static int tunnel_key_init(struct net *net, struct nlattr *nla,
 	}
 
 	if (!exists) {
-		ret = tcf_idr_create_from_flags(tn, index, est, a,
-						&act_tunnel_key_ops, bind,
-						act_flags);
+		ret = tcf_idr_create(tn, index, est, a,
+				     &act_tunnel_key_ops, bind, act_flags);
 		if (ret) {
 			NL_SET_ERR_MSG(extack, "Cannot create TC IDR");
 			goto release_tun_meta;
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index e666004bb919..4f784626802f 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -214,8 +214,8 @@ static int tcf_vlan_init(struct net *net, struct nlattr *nla,
 	action = parm->v_action;
 
 	if (!exists) {
-		ret = tcf_idr_create_from_flags(tn, index, est, a,
-						&act_vlan_ops, bind, flags);
+		ret = tcf_idr_create(tn, index, est, a,
+				     &act_vlan_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
-- 
2.43.0

