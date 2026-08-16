Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E9396B9A
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786911221; cv=none; b=NN/9BerbjlyJ5bdTOR/9OkZgF2Jemqj7FSxLDzKEkpjeM4Gsm7kQejPy4ScSZ+NxcGXbYE9dtn66QPBRMiSs4WKw0KhwkiOHQH+fJ1/0xTchh+IACucuRjcTOSxVT5FdDnSuWWN1HFafKwhOPzL0Foba6lXMoRfzPJO4jzpf+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786911221; c=relaxed/simple;
	bh=6kbPP/wNNkUhAnEP6msAqaZ9uIueGmh1NkNIT9sBEx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FOA+K/TZmY/u98XXUfUK2GLITniz3InzOTxqz3x32zkJfTPnFibVG345mo6gB2HcXsJlGk4mZGPfcRSmJsGEOLpyZ48Oi3hrebNMmchpgSHSRXwNJ7QfJCqd1IHvMDNxJCrFs/S3BrqxuBzOQ0LDKJBEVBjKoZ1e0cOEsk6wcG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Dico/wvk; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Dico/wvk"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso2113931a12.2
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 13:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786911217; x=1787516017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=re1+T1/X0DTAQfhOrLgLDHTONhPy5wlpgc3FvQdDyLE=;
        b=Dico/wvk42jdPHrl2CrPRvVc2mZQaJx5KerubH1LKiomPeqT9dnjlAtV4vBXCyZPwn
         p4BjfqYGHCLX7OIQK0aWglIbk/IIH6B5zGupfpTeTPcFpUxnweGg0vxaO+Tg+fYBxK9l
         J9EJC3OvbcTam91bWEGMo282Gvytb0sP+B2lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786911217; x=1787516017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=re1+T1/X0DTAQfhOrLgLDHTONhPy5wlpgc3FvQdDyLE=;
        b=K43CO8Pt4hY1nvubzpf0FTmMRBrxJComFHzrjUoYOE/JviXEQtDQb35qPGlYPUxEjV
         ADWTy654tH9sDl1I5zpUeWm191J9koGlGBLqfjWGIMCvgxxu/sUTTNKEQlhfo8AA5oOf
         yujGtfvuOcu2kSzgMeivSTn934Dqg088w0fv264yct4p1MPQMuxJNoMLfPd+plRMISGx
         k4E1fvyl2z3+uHTUbxfK2lDfb4rDw4yoycFFrep4JlfRmud/Ppsj+bpidda+hBl5U5zu
         hU10grka18PvLJYWgxFe1f0RlB1Qx6c/SeqcxLgwhau16H73nGEzLlwJbk3x/Csjdw+M
         5KIA==
X-Forwarded-Encrypted: i=1; AHgh+RptBMwK7bqPXULlH9giyqV4EfE3lpogDbisfpb70bU/qkZsBsSWnnnmF03TDNlWkFo0RiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3dVmK2z/oAyul2Tn0/15m1grUnem02MmN2MdfzJ794cH3URxm
	zElGH2hPPk47ydV8JEKGUFv9KQ9N4VYv/7bBWebsGNjEHZImntLlC92je3WIvWzyXw==
X-Gm-Gg: AR+sD109ZZpf+aCZq+gyjlGlFVpMFooHjSUn7vgWb08In9yWH0yn7xtTYKjowMoGpgh
	zd7XPkGxdc3aArWSevoVzTydf1VzgdKuSBfYovKTJft6n5YZxX/9rS+9g8cFIHpCmPKM4Jnb8wb
	f0RfdStFk3qM5MyAVjztBB4oG/CyBbhWT4zRHtryQorZvwUMVjccU1MBcOGeJBp5z5HR6jJsAQO
	QB900bj5r616gfEk0qQ8fCowFSDGKjYnzCHfKaC9g9k5r7xorycZ6M8PojJc7//epMjkHuCOUjw
	xFEN6v/jjMuM5MpwMsLVHyUpGYfTLds2Rh3+bA0RYkYt0oNGY9CAckkR1uxxE6fYTQxskM4q1zR
	wHcteYk4LYSBzEcmBf3TDfS5lNW9c2DF3DTr/NGvg10XFcwU9S4hyGo97kd8Bf7I+7KxhIoXRky
	cxEaULczkgk88Yl+UuvdNshrWGYIXjzXY/ppvuvSo+tQo=
X-Received: by 2002:a05:6a20:12d2:b0:3c3:a024:1360 with SMTP id adf61e73a8af0-3cc71de3b8dmr22521188637.28.1786911217337;
        Sun, 16 Aug 2026 13:13:37 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c6f95sm44454646c88.6.2026.08.16.13.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 13:13:35 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	martin.lau@linux.dev,
	ast@kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	horms@kernel.org,
	vega@nebusec.ai,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v2] net/sched: add get_fill_size callbacks for actions missing them
Date: Sun, 16 Aug 2026 17:13:27 -0300
Message-ID: <20260816201327.2435335-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several tc actions - act_police, act_bpf, act_pedit, act_ife, act_sample,
act_ct, act_ctinfo and act_tunnel_key among them - provide no
get_fill_size() callback, so tcf_action_fill_size() falls back to
tcf_action_shared_attrs_size() which does not account for the
action-specific netlink attributes emitted inside TCA_ACT_OPTIONS by
their dump functions.

When an RTM_NEWACTION request with NLM_F_ECHO (or an RTNLGRP_TC
listener) creates several actions, tcf_add_notify_msg() allocates the
echo skb from this underestimated size. When this happens, the act_api
code fails to add all of the fields to the netlink message and, thus,
fails to send it. Issue is that, when that happens, this failure doesn't
stop the action instances from being added. So any user watching these
events will be under the false impression that no actions were created at
all.

For example, act_pedit overruns with 32 actions of four munge keys each,
act_police with 32 policers once the optional rate/peakrate/result/avrate
attributes are present.

To fix this, add the missing get_fill_size callbacks returning the
worst-case size of each action's dump attributes, following the pattern
used by act_gact/act_skbedit/act_vlan. Also widen the TCA_GACT_TM
accounting in tcf_action_shared_attrs_size() to nla_total_size_64bit(),
since actions dump their tcf_t with nla_put_64bit(), which may be
preceded by an NLA_PAD attribute.

Note: We only provided fixes for the actions we reproduced this bug with
as of today. We can send a separate hardening patch for the remaining
actions to net-next later. The other pre-existing issues, pointed out by
Clashiko [1], will be fixed in upcoming patches.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810164357.1653956-1-victor%40mojatatu.com

Fixes: 4e76e75d6aba ("net sched actions: calculate add/delete event message size")
Reported-by: Vega <vega@nebusec.ai>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
v1 -> v2:
- Use tcf_lock when accessing shared bpf action fields
- Improve commit message clarifying what the bug actually affects - Jakub
- Make it explicit that the list of actions missing get_fill_size() is
  not exhaustive
---
 net/sched/act_api.c        |  5 ++-
 net/sched/act_bpf.c        | 26 +++++++++++++++
 net/sched/act_ct.c         | 46 ++++++++++++++++++++++++++
 net/sched/act_ctinfo.c     | 11 +++++++
 net/sched/act_ife.c        | 23 +++++++++++++
 net/sched/act_pedit.c      | 24 ++++++++++++++
 net/sched/act_police.c     | 12 +++++++
 net/sched/act_sample.c     |  9 ++++++
 net/sched/act_tunnel_key.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 235 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 600b7804befd..b4415d358c91 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -452,7 +452,10 @@ static size_t tcf_action_shared_attrs_size(const struct tc_action *act)
 		/* TCA_STATS_QUEUE */
 		+ nla_total_size_64bit(sizeof(struct gnet_stats_queue))
 		+ nla_total_size(0) /* TCA_ACT_OPTIONS nested */
-		+ nla_total_size(sizeof(struct tcf_t)); /* TCA_GACT_TM */
+		/* TCA_GACT_TM; actions dump their tcf_t with nla_put_64bit(),
+		 * which may emit an extra NLA_PAD attribute.
+		 */
+		+ nla_total_size_64bit(sizeof(struct tcf_t));
 }
 
 static size_t tcf_action_full_attrs_size(size_t sz)
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 09d46e195e33..06d8f78b7368 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -389,6 +389,31 @@ static void tcf_bpf_cleanup(struct tc_action *act)
 	tcf_bpf_cfg_cleanup(&tmp);
 }
 
+static size_t tcf_bpf_get_fill_size(const struct tc_action *act)
+{
+	struct tcf_bpf *prog = to_bpf(act);
+	size_t size = nla_total_size(sizeof(struct tc_act_bpf));
+
+	/* bpf_ops and bpf_num_ops are published as separate stores under
+	 * tcf_lock, so take it here as tcf_bpf_dump() does.
+	 */
+	spin_lock_bh(&prog->tcf_lock);
+	if (tcf_bpf_is_ebpf(prog)) {
+		/* TCA_ACT_BPF_NAME */
+		size += nla_total_size(ACT_BPF_NAME_LEN + 1);
+		size += nla_total_size(sizeof(u32)); /* TCA_ACT_BPF_ID */
+		size += nla_total_size(BPF_TAG_SIZE); /* TCA_ACT_BPF_TAG */
+	} else {
+		size += nla_total_size(sizeof(u16)); /* TCA_ACT_BPF_OPS_LEN */
+		/* TCA_ACT_BPF_OPS */
+		size += nla_total_size(prog->bpf_num_ops *
+				       sizeof(struct sock_filter));
+	}
+	spin_unlock_bh(&prog->tcf_lock);
+
+	return size;
+}
+
 static struct tc_action_ops act_bpf_ops __read_mostly = {
 	.kind		=	"bpf",
 	.id		=	TCA_ID_BPF,
@@ -397,6 +422,7 @@ static struct tc_action_ops act_bpf_ops __read_mostly = {
 	.dump		=	tcf_bpf_dump,
 	.cleanup	=	tcf_bpf_cleanup,
 	.init		=	tcf_bpf_init,
+	.get_fill_size	=	tcf_bpf_get_fill_size,
 	.size		=	sizeof(struct tcf_bpf),
 };
 MODULE_ALIAS_NET_ACT("bpf");
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index e250969c84ac..370085ab6ea4 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1657,6 +1657,51 @@ static int tcf_ct_offload_act_setup(struct tc_action *act, void *entry_data,
 	return 0;
 }
 
+static size_t tcf_ct_get_fill_size(const struct tc_action *act)
+{
+	const struct tcf_ct_params *p;
+	size_t size;
+
+	size = nla_total_size(sizeof(struct tc_ct)) /* TCA_CT_PARMS */
+		+ nla_total_size(sizeof(u16)); /* TCA_CT_ACTION */
+
+	rcu_read_lock();
+	p = rcu_dereference(to_ct(act)->params);
+
+	if (p->ct_action & TCA_CT_ACT_CLEAR)
+		goto out;
+
+	/* TCA_CT_MARK, TCA_CT_MARK_MASK */
+	if (IS_ENABLED(CONFIG_NF_CONNTRACK_MARK))
+		size += nla_total_size(sizeof(p->mark))
+			+ nla_total_size(sizeof(p->mark_mask));
+
+	/* TCA_CT_LABELS, TCA_CT_LABELS_MASK */
+	if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS))
+		size += nla_total_size(sizeof(p->labels))
+			+ nla_total_size(sizeof(p->labels_mask));
+
+	if (IS_ENABLED(CONFIG_NF_CONNTRACK_ZONES))
+		size += nla_total_size(sizeof(p->zone)); /* TCA_CT_ZONE */
+
+	if (p->ct_action & TCA_CT_ACT_NAT)
+		/* TCA_CT_NAT_IPV6_{MIN,MAX}, the larger of the two address
+		 * variants, plus TCA_CT_NAT_PORT_{MIN,MAX}.
+		 */
+		size += 2 * nla_total_size(sizeof(struct in6_addr))
+			+ 2 * nla_total_size(sizeof(__be16));
+
+	/* TCA_CT_HELPER_{NAME,FAMILY,PROTO} */
+	if (p->helper)
+		size += nla_total_size(NF_CT_HELPER_NAME_LEN)
+			+ nla_total_size(sizeof(u8))
+			+ nla_total_size(sizeof(u8));
+out:
+	rcu_read_unlock();
+
+	return size;
+}
+
 static struct tc_action_ops act_ct_ops = {
 	.kind		=	"ct",
 	.id		=	TCA_ID_CT,
@@ -1666,6 +1711,7 @@ static struct tc_action_ops act_ct_ops = {
 	.init		=	tcf_ct_init,
 	.cleanup	=	tcf_ct_cleanup,
 	.stats_update	=	tcf_stats_update,
+	.get_fill_size	=	tcf_ct_get_fill_size,
 	.offload_act_setup =	tcf_ct_offload_act_setup,
 	.size		=	sizeof(struct tcf_ct),
 };
diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
index 1886ffd2ca95..fced4b1094af 100644
--- a/net/sched/act_ctinfo.c
+++ b/net/sched/act_ctinfo.c
@@ -356,6 +356,16 @@ static void tcf_ctinfo_cleanup(struct tc_action *a)
 		kfree_rcu(cp, rcu);
 }
 
+static size_t tcf_ctinfo_get_fill_size(const struct tc_action *act)
+{
+	return nla_total_size(sizeof(struct tc_ctinfo)) /* TCA_CTINFO_ACT */
+		+ nla_total_size(sizeof(u16)) /* TCA_CTINFO_ZONE */
+		/* TCA_CTINFO_PARMS_{DSCP_MASK,DSCP_STATEMASK,CPMARK_MASK} */
+		+ 3 * nla_total_size(sizeof(u32))
+		/* TCA_CTINFO_STATS_{DSCP_SET,DSCP_ERROR,CPMARK_SET} */
+		+ 3 * nla_total_size_64bit(sizeof(u64));
+}
+
 static struct tc_action_ops act_ctinfo_ops = {
 	.kind	= "ctinfo",
 	.id	= TCA_ID_CTINFO,
@@ -364,6 +374,7 @@ static struct tc_action_ops act_ctinfo_ops = {
 	.dump	= tcf_ctinfo_dump,
 	.init	= tcf_ctinfo_init,
 	.cleanup= tcf_ctinfo_cleanup,
+	.get_fill_size = tcf_ctinfo_get_fill_size,
 	.size	= sizeof(struct tcf_ctinfo),
 };
 MODULE_ALIAS_NET_ACT("ctinfo");
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 065228026c58..ff2b16e35b9b 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -878,6 +878,28 @@ TC_INDIRECT_SCOPE int tcf_ife_act(struct sk_buff *skb,
 	return tcf_ife_decode(skb, a, res);
 }
 
+static size_t tcf_ife_get_fill_size(const struct tc_action *act)
+{
+	struct tcf_ife_info *ife = to_ife(act);
+	const struct tcf_ife_params *p;
+	struct tcf_meta_info *e;
+	size_t size = nla_total_size(sizeof(struct tc_ife)) /* TCA_IFE_PARMS */
+		+ nla_total_size(ETH_ALEN) /* TCA_IFE_DMAC */
+		+ nla_total_size(ETH_ALEN) /* TCA_IFE_SMAC */
+		+ nla_total_size(2) /* TCA_IFE_TYPE */
+		+ nla_total_size(0); /* TCA_IFE_METALST */
+
+	rcu_read_lock();
+	p = rcu_dereference(ife->params);
+	if (p) {
+		list_for_each_entry_rcu(e, &p->metalist, metalist)
+			size += nla_total_size(sizeof(u32));
+	}
+	rcu_read_unlock();
+
+	return size;
+}
+
 static struct tc_action_ops act_ife_ops = {
 	.kind = "ife",
 	.id = TCA_ID_IFE,
@@ -886,6 +908,7 @@ static struct tc_action_ops act_ife_ops = {
 	.dump = tcf_ife_dump,
 	.cleanup = tcf_ife_cleanup,
 	.init = tcf_ife_init,
+	.get_fill_size = tcf_ife_get_fill_size,
 	.size =	sizeof(struct tcf_ife_info),
 };
 MODULE_ALIAS_NET_ACT("ife");
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index d4d47a9921f4..99d7e36510bd 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -626,6 +626,29 @@ static int tcf_pedit_offload_act_setup(struct tc_action *act, void *entry_data,
 	return 0;
 }
 
+static size_t tcf_pedit_get_fill_size(const struct tc_action *act)
+{
+	const struct tcf_pedit_parms *parms;
+	size_t size;
+
+	rcu_read_lock();
+	parms = rcu_dereference(to_pedit(act)->parms);
+	size = nla_total_size(struct_size_t(struct tc_pedit, keys,
+					    parms->tcfp_nkeys));
+	if (parms->tcfp_keys_ex) {
+		/* TCA_PEDIT_KEYS_EX, holding one TCA_PEDIT_KEY_EX nest with a
+		 * HTYPE and a CMD attribute per key.
+		 */
+		size += nla_total_size(0)
+			+ parms->tcfp_nkeys * (nla_total_size(0)
+					       + nla_total_size(sizeof(u16))
+					       + nla_total_size(sizeof(u16)));
+	}
+	rcu_read_unlock();
+
+	return size;
+}
+
 static struct tc_action_ops act_pedit_ops = {
 	.kind		=	"pedit",
 	.id		=	TCA_ID_PEDIT,
@@ -635,6 +658,7 @@ static struct tc_action_ops act_pedit_ops = {
 	.dump		=	tcf_pedit_dump,
 	.cleanup	=	tcf_pedit_cleanup,
 	.init		=	tcf_pedit_init,
+	.get_fill_size	=	tcf_pedit_get_fill_size,
 	.offload_act_setup =	tcf_pedit_offload_act_setup,
 	.size		=	sizeof(struct tcf_pedit),
 };
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index ce08f6840ef7..3f8147f37549 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -490,6 +490,17 @@ static int tcf_police_offload_act_setup(struct tc_action *act, void *entry_data,
 	return 0;
 }
 
+static size_t tcf_police_get_fill_size(const struct tc_action *act)
+{
+	return nla_total_size(sizeof(struct tc_police)) /* TCA_POLICE_TBF */
+		+ nla_total_size_64bit(sizeof(u64)) /* TCA_POLICE_RATE64 */
+		+ nla_total_size_64bit(sizeof(u64)) /* TCA_POLICE_PEAKRATE64 */
+		+ nla_total_size_64bit(sizeof(u64)) /* TCA_POLICE_PKTRATE64 */
+		+ nla_total_size_64bit(sizeof(u64)) /* TCA_POLICE_PKTBURST64 */
+		+ nla_total_size(sizeof(u32)) /* TCA_POLICE_RESULT */
+		+ nla_total_size(sizeof(u32)); /* TCA_POLICE_AVRATE */
+}
+
 MODULE_AUTHOR("Alexey Kuznetsov");
 MODULE_DESCRIPTION("Policing actions");
 MODULE_LICENSE("GPL");
@@ -503,6 +514,7 @@ static struct tc_action_ops act_police_ops = {
 	.dump		=	tcf_police_dump,
 	.init		=	tcf_police_init,
 	.cleanup	=	tcf_police_cleanup,
+	.get_fill_size	=	tcf_police_get_fill_size,
 	.offload_act_setup =	tcf_police_offload_act_setup,
 	.size		=	sizeof(struct tcf_police),
 };
diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index 2ceb4d141b71..44319a159b55 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -315,6 +315,14 @@ static int tcf_sample_offload_act_setup(struct tc_action *act, void *entry_data,
 	return 0;
 }
 
+static size_t tcf_sample_get_fill_size(const struct tc_action *act)
+{
+	return nla_total_size(sizeof(struct tc_sample)) /* TCA_SAMPLE_PARMS */
+		+ nla_total_size(sizeof(u32)) /* TCA_SAMPLE_RATE */
+		+ nla_total_size(sizeof(u32)) /* TCA_SAMPLE_TRUNC_SIZE */
+		+ nla_total_size(sizeof(u32)); /* TCA_SAMPLE_PSAMPLE_GROUP */
+}
+
 static struct tc_action_ops act_sample_ops = {
 	.kind	  = "sample",
 	.id	  = TCA_ID_SAMPLE,
@@ -324,6 +332,7 @@ static struct tc_action_ops act_sample_ops = {
 	.dump	  = tcf_sample_dump,
 	.init	  = tcf_sample_init,
 	.cleanup  = tcf_sample_cleanup,
+	.get_fill_size = tcf_sample_get_fill_size,
 	.get_psample_group = tcf_sample_get_group,
 	.offload_act_setup    = tcf_sample_offload_act_setup,
 	.size	  = sizeof(struct tcf_sample),
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index b14807761d82..ff401ace4f3d 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -835,6 +835,85 @@ static int tcf_tunnel_key_offload_act_setup(struct tc_action *act,
 	return 0;
 }
 
+static size_t
+tunnel_key_geneve_opts_fill_size(const struct ip_tunnel_info *info)
+{
+	const u8 *src = ip_tunnel_info_opts(info);
+	int len = info->options_len;
+	size_t size = 0;
+
+	while (len > 0) {
+		const struct geneve_opt *opt = (const struct geneve_opt *)src;
+
+		/* TCA_TUNNEL_KEY_ENC_OPT_GENEVE_{CLASS,TYPE,DATA} */
+		size += nla_total_size(2)
+			+ nla_total_size(1)
+			+ nla_total_size(opt->length * 4);
+
+		len -= sizeof(struct geneve_opt) + opt->length * 4;
+		src += sizeof(struct geneve_opt) + opt->length * 4;
+	}
+
+	return size;
+}
+
+static size_t tunnel_key_opts_fill_size(const struct ip_tunnel_info *info)
+{
+	size_t size;
+
+	if (!info->options_len)
+		return 0;
+
+	/* TCA_TUNNEL_KEY_ENC_OPTS and the per-protocol nest inside it */
+	size = nla_total_size(0) + nla_total_size(0);
+
+	if (test_bit(IP_TUNNEL_GENEVE_OPT_BIT, info->key.tun_flags)) {
+		size += tunnel_key_geneve_opts_fill_size(info);
+	} else if (test_bit(IP_TUNNEL_VXLAN_OPT_BIT, info->key.tun_flags)) {
+		/* TCA_TUNNEL_KEY_ENC_OPT_VXLAN_GBP */
+		size += nla_total_size(sizeof(u32));
+	} else if (test_bit(IP_TUNNEL_ERSPAN_OPT_BIT, info->key.tun_flags)) {
+		/* TCA_TUNNEL_KEY_ENC_OPT_ERSPAN_{VER,INDEX,DIR,HWID} */
+		size += nla_total_size(sizeof(u8))
+			+ nla_total_size(sizeof(__be32))
+			+ nla_total_size(sizeof(u8))
+			+ nla_total_size(sizeof(u8));
+	}
+
+	return size;
+}
+
+static size_t tunnel_key_get_fill_size(const struct tc_action *act)
+{
+	struct tcf_tunnel_key *t = to_tunnel_key(act);
+	const struct tcf_tunnel_key_params *params;
+	/* TCA_TUNNEL_KEY_PARMS */
+	size_t size = nla_total_size(sizeof(struct tc_tunnel_key));
+
+	rcu_read_lock();
+	params = rcu_dereference(t->params);
+	if (params->tcft_action == TCA_TUNNEL_KEY_ACT_SET) {
+		const struct ip_tunnel_info *info =
+			&params->tcft_enc_metadata->u.tun_info;
+
+		/* In dump order: TCA_TUNNEL_KEY_ENC_KEY_ID, the IPv6 address
+		 * pair (larger than the IPv4 one), ..._ENC_DST_PORT,
+		 * ..._NO_CSUM, ..._NO_FRAG, the options and ..._ENC_{TOS,TTL}.
+		 */
+		size += nla_total_size(sizeof(__be32))
+			+ 2 * nla_total_size(sizeof(struct in6_addr))
+			+ nla_total_size(sizeof(__be16))
+			+ nla_total_size(sizeof(u8))
+			+ nla_total_size(0)
+			+ tunnel_key_opts_fill_size(info)
+			+ nla_total_size(sizeof(u8))
+			+ nla_total_size(sizeof(u8));
+	}
+	rcu_read_unlock();
+
+	return size;
+}
+
 static struct tc_action_ops act_tunnel_key_ops = {
 	.kind		=	"tunnel_key",
 	.id		=	TCA_ID_TUNNEL_KEY,
@@ -843,6 +922,7 @@ static struct tc_action_ops act_tunnel_key_ops = {
 	.dump		=	tunnel_key_dump,
 	.init		=	tunnel_key_init,
 	.cleanup	=	tunnel_key_release,
+	.get_fill_size	=	tunnel_key_get_fill_size,
 	.offload_act_setup =	tcf_tunnel_key_offload_act_setup,
 	.size		=	sizeof(struct tcf_tunnel_key),
 };
-- 
2.55.0

