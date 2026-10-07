Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD973A9DBE
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368992; cv=none; b=HHobxswm5eD8He13cIz3X6r/Z/Da0NBsSgcxset/wCEZ9wVUzE/2FIwMwmw3eZjGi1uOC6hd6df3+qEFF1haIvONbh6U6LUDyuah38wJDGeCc5lenVVR1f7RyxXLcOUurcVl2dwWxpN/c6RhQrB31DtB9E4xveVBpC9X/4MaXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368992; c=relaxed/simple;
	bh=neued7hVGQZboVS6jmZpuFSDSoWa/CrPBsmEOYGDrNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O67l+sttdQy9sgpz0AnwMHfA4Zxnfnc4qT/mrvYD35pAkKMH1wnbPpWnjsXPWQCYy9yT43jRslJ4qMegaA1JFwAKKc86cAcq8SeyedUIj9Aa3OHuTnN7D5esLxzf+1n/+Hx0gSNWDKzWAVbf+wtRpL84MA98wmsvayX/Q3v8uFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ef3sh3Ni; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ef3sh3Ni"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53512cd2f85so15636601cf.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 03:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791368977; x=1791973777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HTg/6ap05HWEwAQHXLyQUkjfaFSm3e8eFBoXBKOFB+0=;
        b=ef3sh3Ni4S/w6wnaKw7r/wfEkZEa+7cGFLuGfAb1ivq6kUskP45K19H2wXE5ikgGCo
         Z0chysAtMD1A8utuzRK+vZ0up/NBSKYNQB6NwNNgm2iv7eViO6W/lXAJZCOvmqLtlwLf
         uS5H1Kp1QuesWwqiVi0R7NOlH5i7dOVluQq+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791368977; x=1791973777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HTg/6ap05HWEwAQHXLyQUkjfaFSm3e8eFBoXBKOFB+0=;
        b=oBD7IY1kc1ISopAJdSWtb4wnKvvwhn/A8CQBMMhzGQ/OMbyLeiNB73pg6SrzhNV+5v
         hPcGzcR00PKYEcNzLh1e/fxTI42RxW11fF9MLxCc9OgyRIY6e4nH9WX7NsiG/yCAnL/U
         pneuic4r6eHP1gLfZ0lmiXko9x31DP2HsaRFKaC5KJLQOO7FIEKYrpP0XTfsWzz3r5XX
         orXC6RodA2q9ePrmKSBzH8Wjg7V5mPwLw5iLZLhgnIZ4C+OCTL4ocwU0qp4eb7Bk1zCa
         mgqHoU16eNqRQxBiUiafoR7Lngw+KUQbgpa9MAhisdyX1UTK1IKJJsHdKMk8YMBP7DHm
         n53A==
X-Forwarded-Encrypted: i=1; AKwUvBysvI98PtCMJS3HIvVYODcDYVy76w26UTjJojnGhuUacJhrEvBKTCuvPL4EpPX0yY6nq2M=@vger.kernel.org
X-Gm-Message-State: AFuF++k8VD2CDTlCybX1ew8jK3Vgnh2NtSbCArjrLpFQJ1DcBKj3ktzb
	IsTfOSUvU4RteLjnylwgodGAAXRE4Mfz+in+JlnStjxep/LnIyaUiU+M5V3kI0BxIQ==
X-Gm-Gg: AYBFou0D12fxgM0y89mZ23oAE+dlHLHUlLki345L9fEJ7b2I45dGqGdH+5IOp4iNwSa
	AnB5Q2trgjmvo4efY9kun3rWPywnViUBOf3KYbkghM2PL6tGsJrmlj2uajJOZGayz5m90If7fs0
	EMkOqxIA8KhljjWj3SPX2b2M+ipoCyprwXv9siDr92P06QvnyLnYTok+MDZeDrFfRaUE6QusuJk
	fJIffpErfVb9yDhh4ZAdzQ4X6c+ynOOEyI9ZX72TxIu7C3McafTnYbth0ccMIUK632oVPUyzTF3
	eKF/20xs8Xg7pLB1s1mDaZOv3HPyEIYnLKEz4wDysdZnU2FcE9gtOE0GPYQkA1xUzZOpZICuB28
	wT46WEgJ736gcZPs0KIvb3uwBLsJbEJXRyTbT04Ey901CKynQjCO2Pfv/gkdtYMLkAWyvI+VcD5
	XxQvxwAZFpAaStv86htbESJhXQkVmvPv+Ptff97yU1nphtWniCG+QjBUwnno7oq5PXMRC4fAipE
	iPPw/Da/47sbBKu3kaoF90fy+9Ld+1a9sFyT0ocr4euNJHD7+noEB+H5Cgw
X-Received: by 2002:a05:622a:248d:b0:533:3868:1f6d with SMTP id d75a77b69052e-535755d4eadmr23916371cf.59.1791368977119;
        Wed, 07 Oct 2026 03:29:37 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5357209e26csm16986311cf.8.2026.10.07.03.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 03:29:36 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net-next 1/2] net/sched: act_gate: reject oversized dumps instead of wrapping them
Date: Wed,  7 Oct 2026 06:29:30 -0400
Message-Id: <QDISC-H19Z.v2.20261007062551-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-H19Z.v2.20261007062551@mojatatu.com>
References: <QDISC-H19Z.v2.20261007062551@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a followup of commit cfa165cbfbed ("net/sched: act_gate: budget
the per-entry list in get_fill_size") as reported by Sashiko.

The issue:
An action dump is carried inside nested netlink attributes whose lengths
are u16. A gate action with enough schedule entries produces a dump
larger than U16_MAX, and the plain nla_nest_end() closes by writing a
wrapped length: the reply is structurally corrupt. On a CONFIG_DEBUG_NET
kernel nla_nest_end() also warns for each wrapped close, which an
unprivileged RTM_GETACTION or RTM_GETTFILTER can reach once the action
or filter exists.

The oversized dump also reaches the filter notification path through
tcf_fill_node(), which reports the failure as -EMSGSIZE.
tfilter_notify_prep() treats that as socket-buffer exhaustion and
retries with an ever larger alloc_skb(); a dump that does not fit a u16
nest cannot be built at any skb size, so the loop only spins until the
allocation itself fails.

The Fix:
Close every wrap-capable nest an action dump travels in with
nla_nest_end_safe(), which reports -EMSGSIZE before writing a wrapped
length: TCA_GATE_ENTRY_LIST, TCA_ACT_OPTIONS, the per-action nest and
TCA_ACT_TAB; the shared action and police containers in
tcf_exts_dump()/tcf_exts_terse_dump(); and the caller-owned TCA_OPTIONS
of every action-capable classifier (flower, matchall, basic, bpf,
cgroup, flow, fw, route4, u32). The output is byte identical for every
message that serializes. Bound the tfilter_notify_prep() retry once the
skb is already larger than any valid message, while a regular dump that
only needs a bigger skb still retries.

Context note:
A notification that cannot be serialised must not veto the state change
the caller asked for. tfilter_del_notify() builds the delete
notification before calling ->delete() and propagated the prep
failure, so a filter whose dump cannot be represented in a u16 nest
could be created but never removed by "tc filter del ... handle H" - and
only when a notification was actually needed (rtnl_notify_needed(): an
RTNLGRP_TC listener or NLM_F_ECHO), which made it intermittent. Drop
the unbuildable notification instead: on -EMSGSIZE the delete proceeds
and the extack notes the dropped event. The same serialisation failure
on the action-add side - tcf_action_add() returns -EINVAL although
tcf_action_init() has already inserted the action into the idr, so the
action is created and reported as a failure - is not changed here:
returning success after a notify build failure there needs an
idr/refcount audit (tca_put_bound_many(), ACT_P_CREATED) that overlaps
the tcf_action_add_failed_notify_leaves_action follow-up. Preserve the
-EMSGSIZE tcf_action_dump() produces (goto errout, like
rtnl_fill_prop_list()) instead of overwriting it with -EINVAL.

why net-next?
This is hardening rather than a regression fix: the enclosing action and
filter-path nests have wrapped since the actions and classifiers allowed
large entry lists - TCA_ACT_TAB is core act_api and the filter-side
container predates the act_gate sizing change. A plain nla_nest_end()
has always written the wrapped length at U16_MAX; this stops the
corruption at the abstraction boundary instead of imposing a new policy
limit on accepted gate schedules. A separate patch caps the entry list
itself.

Conditions to recreate the bug:
CONFIG_NET_CLS_ACT=y; CONFIG_NET_ACT_GATE=y;
CONFIG_NET_CLS_MATCHALL=y and/or CONFIG_NET_CLS_BASIC=y. Create a
matchall or basic filter on an ingress/clsact qdisc whose action list
holds two gate actions of 1024 minimal TCA_GATE_ONE_ENTRY elements
each (TCA_ACT_MAX_PRIO admits up to 32 actions); the aggregate
TCA_ACT_TAB nest is ~74.3 KiB > 65532 and wraps, then RTM_GETTFILTER
it (or trigger the notify with NLM_F_ECHO).
For a single action the outermost TCA_ACT_TAB wraps from 1815 entries
(1821 for the innermost TCA_GATE_ENTRY_LIST); on the filter path the
outermost wrap-capable nest is the classifier's TCA_OPTIONS. Installing
needs CAP_NET_ADMIN in a user namespace; the RTM_GETTFILTER trigger needs
no capability once it exists. The two-action shape survives the
series' per-action 1024-entry cap (2/2): the enclosing nests overflow
from aggregate action size, which no per-action cap can bound.

Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.4143642-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/QDISC-H19Z.v1.20261001053234@mojatatu.com/
Link: https://lore.kernel.org/netdev/179111893181.434549.13449660670267048994@kernel.org/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_api.c      | 10 +++++++---
 net/sched/act_gate.c     |  3 ++-
 net/sched/cls_api.c      | 40 ++++++++++++++++++++++++++++++----------
 net/sched/cls_basic.c    |  3 ++-
 net/sched/cls_bpf.c      |  3 ++-
 net/sched/cls_cgroup.c   |  3 ++-
 net/sched/cls_flow.c     |  3 ++-
 net/sched/cls_flower.c   |  6 ++++--
 net/sched/cls_fw.c       |  3 ++-
 net/sched/cls_matchall.c |  3 ++-
 net/sched/cls_route.c    |  3 ++-
 net/sched/cls_u32.c      |  3 ++-
 12 files changed, 59 insertions(+), 24 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 6e48b4bc2d75..747d91ae6446 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -558,7 +558,8 @@ tcf_action_dump_1(struct sk_buff *skb, struct tc_action *a, int bind, int ref)
 		goto nla_put_failure;
 	err = tcf_action_dump_old(skb, a, bind, ref);
 	if (err > 0) {
-		nla_nest_end(skb, nest);
+		if (nla_nest_end_safe(skb, nest) < 0)
+			goto nla_put_failure;
 		return err;
 	}
 
@@ -1279,7 +1280,9 @@ int tcf_action_dump(struct sk_buff *skb, struct tc_action *actions[],
 			tcf_action_dump_1(skb, a, bind, ref);
 		if (err < 0)
 			goto errout;
-		nla_nest_end(skb, nest);
+		err = nla_nest_end_safe(skb, nest);
+		if (err < 0)
+			goto errout;
 	}
 
 	return 0;
@@ -1693,7 +1696,8 @@ static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],
 	if (tcf_action_dump(skb, actions, bind, ref, false) < 0)
 		goto out_nlmsg_trim;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto out_nlmsg_trim;
 
 	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
 
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 6d6d45e03c07..14801c604bd9 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -654,7 +654,8 @@ static int tcf_gate_dump(struct sk_buff *skb, struct tc_action *a,
 			goto nla_put_failure;
 	}
 
-	nla_nest_end(skb, entry_list);
+	if (nla_nest_end_safe(skb, entry_list) < 0)
+		goto nla_put_failure;
 
 	tcf_tm_dump(&t, &gact->tcf_tm);
 	if (nla_put_64bit(skb, TCA_GATE_TM, sizeof(t), &t, TCA_GATE_PAD))
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a9f54988561f..3f0ce567fa2d 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2149,11 +2149,20 @@ static struct sk_buff *tfilter_notify_prep(struct net *net,
 			    rtnl_held, extack);
 	if (ret <= 0) {
 		kfree_skb(skb);
-		if (ret == -EMSGSIZE) {
-			size += NLMSG_GOODSIZE;
-			goto retry;
-		}
-		return ERR_PTR(-EINVAL);
+		if (ret != -EMSGSIZE)
+			return ERR_PTR(-EINVAL);
+		/* A filter dump is carried inside a nest whose u16 nla_len
+		 * caps it, so a dump that still does not serialize once the
+		 * skb is larger than any valid message can never be built,
+		 * however big the skb gets. Filling reports that structural
+		 * overflow and genuine capacity exhaustion the same way, so
+		 * stop at the bound instead of looping until alloc_skb()
+		 * fails on an order too large for the page allocator.
+		 */
+		if (size > U16_MAX + NLMSG_GOODSIZE)
+			return ERR_PTR(-EMSGSIZE);
+		size += NLMSG_GOODSIZE;
+		goto retry;
 	}
 	return skb;
 }
@@ -2200,8 +2209,16 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
 	skb = tfilter_notify_prep(net, oskb, n, tp, block, q, parent, fh,
 				  RTM_DELTFILTER, portid, rtnl_held, extack);
 	if (IS_ERR(skb)) {
-		NL_SET_ERR_MSG(extack, "Failed to build del event notification");
-		return PTR_ERR(skb);
+		if (PTR_ERR(skb) != -EMSGSIZE) {
+			NL_SET_ERR_MSG(extack, "Failed to build del event notification");
+			return PTR_ERR(skb);
+		}
+		/* The filter's dump cannot be represented in a u16 nest, so no
+		 * notification can ever be built for it. Drop the notification
+		 * rather than refusing to delete the filter.
+		 */
+		NL_SET_ERR_MSG(extack, "Filter deleted; del event notification could not be built");
+		return tp->ops->delete(tp, fh, last, rtnl_held, extack);
 	}
 
 	err = tp->ops->delete(tp, fh, last, rtnl_held, extack);
@@ -3529,7 +3546,8 @@ int tcf_exts_dump(struct sk_buff *skb, struct tcf_exts *exts)
 			if (tcf_action_dump(skb, exts->actions, 0, 0, false)
 			    < 0)
 				goto nla_put_failure;
-			nla_nest_end(skb, nest);
+			if (nla_nest_end_safe(skb, nest) < 0)
+				goto nla_put_failure;
 		} else if (exts->police) {
 			struct tc_action *act = tcf_exts_first_act(exts);
 			nest = nla_nest_start_noflag(skb, exts->police);
@@ -3537,7 +3555,8 @@ int tcf_exts_dump(struct sk_buff *skb, struct tcf_exts *exts)
 				goto nla_put_failure;
 			if (tcf_action_dump_old(skb, act, 0, 0) < 0)
 				goto nla_put_failure;
-			nla_nest_end(skb, nest);
+			if (nla_nest_end_safe(skb, nest) < 0)
+				goto nla_put_failure;
 		}
 	}
 	return 0;
@@ -3565,7 +3584,8 @@ int tcf_exts_terse_dump(struct sk_buff *skb, struct tcf_exts *exts)
 
 	if (tcf_action_dump(skb, exts->actions, 0, 0, true) < 0)
 		goto nla_put_failure;
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 	return 0;
 
 nla_put_failure:
diff --git a/net/sched/cls_basic.c b/net/sched/cls_basic.c
index e2a94ba9fba7..ba859110faae 100644
--- a/net/sched/cls_basic.c
+++ b/net/sched/cls_basic.c
@@ -305,7 +305,8 @@ static int basic_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	    tcf_em_tree_dump(skb, &f->ematches, TCA_BASIC_EMATCHES) < 0)
 		goto nla_put_failure;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (tcf_exts_dump_stats(skb, &f->exts) < 0)
 		goto nla_put_failure;
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 188cf0f949dd..232796d3a51f 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -631,7 +631,8 @@ static int cls_bpf_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	    nla_put_u32(skb, TCA_BPF_FLAGS_GEN, prog->gen_flags))
 		goto nla_put_failure;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (tcf_exts_dump_stats(skb, &prog->exts) < 0)
 		goto nla_put_failure;
diff --git a/net/sched/cls_cgroup.c b/net/sched/cls_cgroup.c
index 210fd9fd26d8..28701d3916b8 100644
--- a/net/sched/cls_cgroup.c
+++ b/net/sched/cls_cgroup.c
@@ -185,7 +185,8 @@ static int cls_cgroup_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	    tcf_em_tree_dump(skb, &head->ematches, TCA_CGROUP_EMATCHES) < 0)
 		goto nla_put_failure;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (tcf_exts_dump_stats(skb, &head->exts) < 0)
 		goto nla_put_failure;
diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index a9ac3acf6eda..2ef449706638 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -681,7 +681,8 @@ static int flow_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	    tcf_em_tree_dump(skb, &f->ematches, TCA_FLOW_EMATCHES) < 0)
 		goto nla_put_failure;
 #endif
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (tcf_exts_dump_stats(skb, &f->exts) < 0)
 		goto nla_put_failure;
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 0c4beff18d68..299b1493d74b 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -3759,7 +3759,8 @@ static int fl_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	if (tcf_exts_dump(skb, &f->exts))
 		goto nla_put_failure;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (tcf_exts_dump_stats(skb, &f->exts) < 0)
 		goto nla_put_failure;
@@ -3804,7 +3805,8 @@ static int fl_terse_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	if (tcf_exts_terse_dump(skb, &f->exts))
 		goto nla_put_failure;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	return skb->len;
 
diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index a462b262719c..0f731595f839 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -414,7 +414,8 @@ static int fw_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	if (tcf_exts_dump(skb, &f->exts) < 0)
 		goto nla_put_failure;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (tcf_exts_dump_stats(skb, &f->exts) < 0)
 		goto nla_put_failure;
diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index c14899b935bf..6ece63b82775 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -366,7 +366,8 @@ static int mall_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	if (tcf_exts_dump(skb, &head->exts))
 		goto nla_put_failure;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (tcf_exts_dump_stats(skb, &head->exts) < 0)
 		goto nla_put_failure;
diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index 0f211f030fd9..d5b009a7c89b 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -657,7 +657,8 @@ static int route4_dump(struct net *net, struct tcf_proto *tp, void *fh,
 	if (tcf_exts_dump(skb, &f->exts) < 0)
 		goto nla_put_failure;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (tcf_exts_dump_stats(skb, &f->exts) < 0)
 		goto nla_put_failure;
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 76ce2d124079..91f4e6458785 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1482,7 +1482,8 @@ static int u32_dump(struct net *net, struct tcf_proto *tp, void *fh,
 #endif
 	}
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto nla_put_failure;
 
 	if (TC_U32_KEY(n->handle))
 		if (tcf_exts_dump_stats(skb, &n->exts) < 0)
-- 
2.43.0

