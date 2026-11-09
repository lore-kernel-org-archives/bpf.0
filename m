Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.60.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228386;
	b=L+CxN1hPktGisRW4V2Dc+bh4UE60Mq+/Z8hon1MM+u3DMnm7uhgyqebQDZEdNvOcXSsc
	 NLLsSxXh59OhOZ6I437HI13qBomRhaz07S/weD96ghVOc6MZ4gNn0rb4XJKp/oxrAWZH7
	 TCE4TKIsiHmxv85Fsga3ODnriL6q5kBCI9OUE+sQbUCnGhu93OUk7LORVPqn1R2N4Jnnn
	 f56yAS9pcaphzRr/C3Ktjf9nRJDLEiwqEs53d903lJEMw314eOk9rm89JMUoDvVcz2r28
	 Zrt+vGsiDLVQpENw2uWZt72IrUgiXk7kfuoDaAB4XvtANHWYvlNqNNbei3uIQsD93JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228386;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kh7rPhttLM/9UhZnWWZ9GH6qoA/1ey+mAVM6n12p29w=;
	b=Lx7TJFeyyPShuvkEliklU7c/5WfHgtlOSm2tQe/2q4FlGGlAQ1UNI9U0G0mnb5tzq8mr
	 RyxbaZFICkyPjdKN1IJaH0xGMm3PnCzgIdOOW95XxvjHx188a45kd0UBOe5bS8B+QTbgA
	 DPeRvSKqdBp0JUjYTvqGqThV1CiKIxlpFGHnsMr9QYDu0wrUJc9v/6g1h20bGyyDs6zph
	 tQV4DHwJ08IHLOaq7liNg2oo9L0I6dpsGAuDxdqO3yETIGcDyKEjOWvvFikoBPNv7hnqe
	 XVH3OS9N6FS0HfvoFHhUlBinTNBQecRI8wEc4mjS5TN7MaBmZewiK3fUsnG9kG40pSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corp.free.fr;
	spf=pass smtp.mailfrom=corp.free.fr;
	dkim=pass header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=GnJgdnUJ;
	arc=none smtp.remote-ip=212.27.60.169
Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6096606A325;
	Mon,  9 Nov 2026 12:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6096606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=GnJgdnUJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1794228384; bh=7ZPGTPVH0/RD8EODqPSC8V+GK04omyIfEDmcx5TbHo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GnJgdnUJ8FO7KxFUxm8vPAsdZCo5VNQAWW/jvWGNrYrUgrkNL9HskYrD6pUff5JIc
	 /2qZDWwqMh5BitC7DPcAVYr1WjnjGDDqbwoKxwvfibcw3cH6TtpQqTNRSrNo52HEHK
	 X/4vmdaDM1zi6dR/R85IB+ZcDzfr+WR7E0VmhtwEwBXNKQX75w4uuCezbopLe90pCC
	 IYLXvqdM86WZUmvQst53V4pnuzbPbALX7PZyyBYJq8jEBomP4Wg5RFYQRCALeN0d4s
	 wc5fpozXzfcviS3vDesAOoNILglbSrgcydfopLn51z/RwhTyJetTkZf4Uqq0cIt3p2
	 EtDmcxyfbsbSw==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id E6FA944C0610;
	Mon,  9 Nov 2026 13:46:23 +0100 (CET)
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
Subject: [PATCH net-next v3 2/4] net/sched: honor TCA_ACT_FLAGS_NO_PERCPU_STATS in bpf, ife and skbmod
Date: Mon,  9 Nov 2026 13:46:13 +0100
Message-ID: <20261109124618.933149-3-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109124618.933149-1-acassen@corp.free.fr>
References: <20261109124618.933149-1-acassen@corp.free.fr>
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

bpf, ife and skbmod are the last actions that ignore
TCA_ACT_FLAGS_NO_PERCPU_STATS. Commit 40bd094d65fc ("flow_offload: fill
flags to action structure") makes them store and dump the flag. They
still allocate per CPU stats, about 8 KB per action on a 128 CPU host.
Yet tc reports no_percpu on them.

Honor the flag here too. These actions run only in software. With
no_percpu every packet takes tcfa_lock to update the stats. Only the
users who set the flag pay this cost.

Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
---
 net/sched/act_bpf.c    |  8 ++++----
 net/sched/act_ife.c    | 24 ++++++++++++------------
 net/sched/act_skbmod.c |  8 ++++----
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 06d8f78b7368..3aea3ff5785f 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -42,7 +42,7 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
 	int action, filter_res;
 
 	tcf_lastuse_update(&prog->tcf_tm);
-	bstats_update(this_cpu_ptr(prog->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&prog->common, skb);
 
 	filter = rcu_dereference_bh(prog->filter);
 	if (at_ingress) {
@@ -76,7 +76,7 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
 		break;
 	case TC_ACT_SHOT:
 		action = filter_res;
-		qstats_cpu_drop_inc(prog->common.cpu_qstats);
+		tcf_action_inc_drop_qstats(&prog->common);
 		break;
 	case TC_ACT_UNSPEC:
 		action = prog->tcf_action;
@@ -305,8 +305,8 @@ static int tcf_bpf_init(struct net *net, struct nlattr *nla,
 	index = parm->index;
 	ret = tcf_idr_check_alloc(tn, &index, act, bind);
 	if (!ret) {
-		ret = tcf_idr_create(tn, index, est, act,
-				     &act_bpf_ops, bind, true, flags);
+		ret = tcf_idr_create_from_flags(tn, index, est, act,
+						&act_bpf_ops, bind, flags);
 		if (ret < 0) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 3946a9589bb8..a931f0d353d2 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -551,8 +551,8 @@ static int tcf_ife_init(struct net *net, struct nlattr *nla,
 	}
 
 	if (!exists) {
-		ret = tcf_idr_create(tn, index, est, a, &act_ife_ops,
-				     bind, true, flags);
+		ret = tcf_idr_create_from_flags(tn, index, est, a,
+						&act_ife_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			kfree(p);
@@ -720,7 +720,7 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 
 	p = rcu_dereference_bh(ife->params);
 
-	bstats_update(this_cpu_ptr(ife->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&ife->common, skb);
 	tcf_lastuse_update(&ife->tcf_tm);
 
 	if (skb_at_tc_ingress(skb))
@@ -728,7 +728,7 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 
 	tlv_data = ife_decode(skb, &metalen);
 	if (unlikely(!tlv_data)) {
-		qstats_cpu_drop_inc(ife->common.cpu_qstats);
+		tcf_action_inc_drop_qstats(&ife->common);
 		return TC_ACT_SHOT;
 	}
 
@@ -742,7 +742,7 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 		curr_data = ife_tlv_meta_decode(tlv_data, ifehdr_end, &mtype,
 						&dlen, NULL);
 		if (!curr_data) {
-			qstats_cpu_drop_inc(ife->common.cpu_qstats);
+			tcf_action_inc_drop_qstats(&ife->common);
 			return TC_ACT_SHOT;
 		}
 
@@ -751,7 +751,7 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 			/* abuse overlimits to count metadata we cannot
 			 * decode: no ops for it, or the decoder rejected it
 			 */
-			qstats_cpu_overlimit_inc(ife->common.cpu_qstats);
+			tcf_action_inc_overlimit_qstats(&ife->common);
 
 			if (ret == -ENOENT)
 				pr_info_ratelimited("Unknown metaid %d dlen %d\n",
@@ -763,7 +763,7 @@ static int tcf_ife_decode(struct sk_buff *skb, const struct tc_action *a,
 	}
 
 	if (WARN_ON(tlv_data != ifehdr_end)) {
-		qstats_cpu_drop_inc(ife->common.cpu_qstats);
+		tcf_action_inc_drop_qstats(&ife->common);
 		return TC_ACT_SHOT;
 	}
 
@@ -819,21 +819,21 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
 			exceed_mtu = true;
 	}
 
-	bstats_update(this_cpu_ptr(ife->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&ife->common, skb);
 	tcf_lastuse_update(&ife->tcf_tm);
 
 	if (!metalen) {		/* no metadata to send */
 		/* abuse overlimits to count when we allow packet
 		 * with no metadata
 		 */
-		qstats_cpu_overlimit_inc(ife->common.cpu_qstats);
+		tcf_action_inc_overlimit_qstats(&ife->common);
 		return action;
 	}
 	/* could be stupid policy setup or mtu config
 	 * so lets be conservative.. */
 	if ((action == TC_ACT_SHOT) || exceed_mtu) {
 drop:
-		qstats_cpu_drop_inc(ife->common.cpu_qstats);
+		tcf_action_inc_drop_qstats(&ife->common);
 		return TC_ACT_SHOT;
 	}
 
@@ -898,9 +898,9 @@ TC_INDIRECT_SCOPE int tcf_ife_act(struct sk_buff *skb,
 	int ret;
 
 	if (unlikely(!tcf_ife_is_eth_skb(skb))) {
-		bstats_update(this_cpu_ptr(ife->common.cpu_bstats), skb);
+		tcf_action_update_bstats(&ife->common, skb);
 		tcf_lastuse_update(&ife->tcf_tm);
-		qstats_cpu_drop_inc(ife->common.cpu_qstats);
+		tcf_action_inc_drop_qstats(&ife->common);
 		return TC_ACT_SHOT;
 	}
 
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index 09e9dcf58253..72dedb9b19a6 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -32,7 +32,7 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
 	u64 flags;
 
 	tcf_lastuse_update(&d->tcf_tm);
-	bstats_update(this_cpu_ptr(d->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&d->common, skb);
 
 	p = rcu_dereference_bh(d->skbmod_p);
 	if (unlikely(p->action == TC_ACT_SHOT))
@@ -91,7 +91,7 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
 	return p->action;
 
 drop:
-	qstats_cpu_overlimit_inc(d->common.cpu_qstats);
+	tcf_action_inc_overlimit_qstats(&d->common);
 	return TC_ACT_SHOT;
 }
 
@@ -171,8 +171,8 @@ static int tcf_skbmod_init(struct net *net, struct nlattr *nla,
 	}
 
 	if (!exists) {
-		ret = tcf_idr_create(tn, index, est, a,
-				     &act_skbmod_ops, bind, true, flags);
+		ret = tcf_idr_create_from_flags(tn, index, est, a,
+						&act_skbmod_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
 			return ret;
-- 
2.43.0

