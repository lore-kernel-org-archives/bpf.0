Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E293FF1B7
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492730; cv=none; b=dmZ48fYRAnqix4qAVYjlHnG+tHYw9fMXR1oa1yo72IDBayeRfBisQu3Oby79K7v57FmeM8beEVrl/sRrVCyt7x7p+tK8T9wRf9f2ZnNgAVDYj/p3JOCi1Y25IVUcuwfymBGgb9yORZ6UQupGD76AnPmca0vB8yLiv1yLf0Aed5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492730; c=relaxed/simple;
	bh=I0iV0OGwdQqpZTsd2iMX3d2K3JGGyPqRJT8cKkMEFvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sYcB805/FM9YV+w7PplpmyeK57qJUxhlCxzHuZTaA6wXa3avyAwjkQTem9kLVqTcdsUOiEo1FLF+EQYhgca5IcRM5RdXWUrnWTsU+aIgGlekxmPY4b8XbJFyNqK2aHVgCWNDWtN4T8bwn+PYdCuBmjNvURB3wDO5qnfAw1p2j2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=WI8d4PXK; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="WI8d4PXK"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-91591f19c30so191804085a.1
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782492728; x=1783097528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUkJL98wPtVRt0Al3u2IlJCXBNc/ZJ9Hpflou6qG0VE=;
        b=WI8d4PXK7PmLiXfyOa9NAGfO+Cpr/8NhHQOIpMxiFY4nHsp3B7wqDYiU4SB8+mbhz7
         u9nZWMUzFwHYn0Yx7AiX14ltXK7PXkZu8TpcObzsMdUH5VTqDc/ehJ+LBkQBvyZMdEL+
         YZb4CJ4QKA+hnsf9tic6c8E7dxI4eGly5bHVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782492728; x=1783097528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DUkJL98wPtVRt0Al3u2IlJCXBNc/ZJ9Hpflou6qG0VE=;
        b=GL45gxJEvgDb3VlCwdaO+1torGgw8gzHvayve4YdDAVb/8S+Z2ul+vt1sqGwKOjtjL
         x0t006vK8i5QDs2JQg75tT9xegAdGn2hFORi/V04SkN3Y9XNI/v8pga8OhFYWLN+srtn
         TwQ3diexv4Q/fg1YrtLOxdbfDLi6YNFh36VkDhjPHseLIBeMbDr+KYbcNrAEE5+/F3fN
         PFFzbAkhlwB80Wt1G7xwgQBADGi2Y8lYhkZn9fzNSbMzdv57jKEVSQgQcbqeH4aCQyGP
         xxvuH5vOJCbGHpHpCWldSMIaIUpY7cMfj/nkdhag7UaCZ68tc4WpXIdA7Pk5BGagMSQz
         F4mQ==
X-Forwarded-Encrypted: i=1; AFNElJ+387mi02fq5yN9i2u7vLDcIN5vJIuhlD0FHL24Jm65OCNPlbTj8BUYg/8+spIk9f8i+KA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5nHsp7d3oF6jBBFqLumyVde/LMUr2FOYlC4VjMIpSJIrF5Dol
	0V5Mt85USwtuSwQh6ezGoPys6eXByc28qms6s5PFNgvNyrD7eRBNF6/UqjdLhJrEIw==
X-Gm-Gg: AfdE7clS2nbe09noM1eXl40+z1WEqnnFJdxbfbwhgaswUJEJ1uIAFi/6tfusY+dtk4y
	4V9G7YTYPlGoTtHOhnrCutgEcC+iS/vSawS94HCpnRzBPuvB3GnzlliaftwZ+6Eeeja9edN7N1I
	UBJ5xUrvxrS7A0kZfZ33eJJM/irZXCKTmpKj3Us06XEycJfQcSMdg3ChYQFOH36H9bPSUbKAmOE
	pINZSj+zgWqosXwsNmJfiWYrbxudOAlyoFfo06TO3hnVT8Cb3vL+TtMj6c0VMX1EQ+9C7JbhNnS
	8D/LMinUy7bUQbWTvSJ7JtUtIqgtTeh0YiMNJ8Gs1dT+P+ckMYs5cpvYKXKQUozBeSpMmsaWhiK
	aWSqYzuGcp8sMisvQpl1rUYYN0hfqMBYG7EhhAiRCM0U2s1/nGaR5CQnjgVsXRwuwAZQMEj7+aV
	zOZCH0qA==
X-Received: by 2002:a05:620a:44d4:b0:925:eb05:d194 with SMTP id af79cd13be357-9293d4b2daamr1161768385a.57.1782492727391;
        Fri, 26 Jun 2026 09:52:07 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926004abe29sm1216957385a.33.2026.06.26.09.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:52:06 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	toke@toke.dk,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	kuniyu@google.com,
	sdf.kernel@gmail.com,
	skhawaja@google.com,
	liuhangbin@gmail.com,
	krikku@gmail.com,
	mkarsten@uwaterloo.ca,
	victor@mojatatu.com,
	ast@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains
Date: Fri, 26 Jun 2026 12:51:55 -0400
Message-Id: <20260626165156.169012-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626165156.169012-1-jhs@mojatatu.com>
References: <20260626165156.169012-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a TC filter attached to a qdisc filter chain returns
TC_ACT_REDIRECT (ex: via an eBPF program calling bpf_redirect() or an
act_bpf action), the redirect was silently lost i.e no qdisc classify
function handled TC_ACT_REDIRECT, so the packet fell through the
switch and was enqueued normally instead of being redirected.

This has been broken since bpf_redirect() was introduced for TC in
commit 27b29f63058d ("bpf: add bpf_redirect() helper"). We got lucky
for a long time because bpf_net_context was a per-CPU variable that
was always available.
commit 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
turned bpf_net_context into a task_struct member that is only set up by
explicit callers. Without a caller setting it up, bpf_redirect() itself
crashes with a NULL pointer dereference in bpf_net_ctx_get_ri().

The NULL deref is fixed separately by extending the bpf_net_context
lifetime to cover qdisc enqueue. However, even with bpf_net_context
available, TC_ACT_REDIRECT from qdisc filter chains cannot be honored
without adding skb_do_redirect() calls to every qdisc classify
function, which would require changes across net/sched/.

Instead, add a tcf_classify_qdisc() inline helper in pkt_cls.h, as a
wrapper around tcf_classify() for use by qdisc classify functions and
tcf_qevent_handle(). When the classify verdict is TC_ACT_REDIRECT,
the wrapper converts it to TC_ACT_SHOT, dropping the packet rather
than letting it continue silently.  Dropping is preferred over
letting the packet through because the user immediately sees packet
loss and, with the help of the rate-limited warning in the log
("use eBPF with clsact or mirred redirect instead"), can quickly
identify and fix the misconfiguration. Silently passing the packet
through would hide the problem and leave the user wondering why their
redirect is not working.

The clsact fast path, tc_run() continues to call tcf_classify() directly
and is unaffected: TC_ACT_REDIRECT is returned as-is and handled by
sch_handle_egress/ingress() calling skb_do_redirect() as before.

Remove the TC_ACT_REDIRECT case from tcf_qevent_handle() since
tcf_classify_qdisc() now converts it to TC_ACT_SHOT, and the existing
SHOT case handles it.

Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/pkt_cls.h    | 13 +++++++++++++
 net/sched/cls_api.c      |  6 +-----
 net/sched/sch_cake.c     |  2 +-
 net/sched/sch_drr.c      |  2 +-
 net/sched/sch_dualpi2.c  |  2 +-
 net/sched/sch_ets.c      |  2 +-
 net/sched/sch_fq_codel.c |  2 +-
 net/sched/sch_fq_pie.c   |  2 +-
 net/sched/sch_hfsc.c     |  2 +-
 net/sched/sch_htb.c      |  2 +-
 net/sched/sch_multiq.c   |  2 +-
 net/sched/sch_prio.c     |  2 +-
 net/sched/sch_qfq.c      |  2 +-
 net/sched/sch_sfb.c      |  2 +-
 net/sched/sch_sfq.c      |  2 +-
 15 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 3bd08d7f39c1..3a542a72e9a5 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -159,6 +159,19 @@ static inline int tcf_classify(struct sk_buff *skb,
 
 #endif
 
+static inline int tcf_classify_qdisc(struct sk_buff *skb,
+				     const struct tcf_proto *tp,
+				     struct tcf_result *res, bool compat_mode)
+{
+	int ret = tcf_classify(skb, NULL, tp, res, compat_mode);
+
+	if (unlikely(ret == TC_ACT_REDIRECT)) {
+		pr_warn_once("TC_ACT_REDIRECT from qdisc filter chains is not supported; use eBPF with clsact or mirred redirect instead\n");
+		ret = TC_ACT_SHOT;
+	}
+	return ret;
+}
+
 static inline unsigned long
 __cls_set_class(unsigned long *clp, unsigned long cl)
 {
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 3e67600a4a1a..3ca56d060e28 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -4033,7 +4033,7 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent *qe, struct Qdisc *sch, stru
 
 	fl = rcu_dereference_bh(qe->filter_chain);
 
-	switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
+	switch (tcf_classify_qdisc(skb, fl, &cl_res, false)) {
 	case TC_ACT_SHOT:
 		qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
@@ -4045,10 +4045,6 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent *qe, struct Qdisc *sch, stru
 		__qdisc_drop(skb, to_free);
 		*ret = __NET_XMIT_STOLEN;
 		return NULL;
-	case TC_ACT_REDIRECT:
-		skb_do_redirect(skb);
-		*ret = __NET_XMIT_STOLEN;
-		return NULL;
 	case TC_ACT_CONSUMED:
 		*ret = __NET_XMIT_STOLEN;
 		return NULL;
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index a3c185505afc..94eb47ac54ee 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1730,7 +1730,7 @@ static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
 		goto hash;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	result = tcf_classify(skb, NULL, filter, &res, false);
+	result = tcf_classify_qdisc(skb, filter, &res, false);
 
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 020657f959b5..91b1ef824afa 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -312,7 +312,7 @@ static struct drr_class *drr_classify(struct sk_buff *skb, struct Qdisc *sch,
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	fl = rcu_dereference_bh(q->filter_list);
-	result = tcf_classify(skb, NULL, fl, &res, false);
+	result = tcf_classify_qdisc(skb, fl, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 5434df6ca8ef..98364f74211e 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -364,7 +364,7 @@ static int dualpi2_skb_classify(struct dualpi2_sched_data *q,
 		return NET_XMIT_SUCCESS;
 	}
 
-	result = tcf_classify(skb, NULL, fl, &res, false);
+	result = tcf_classify_qdisc(skb, fl, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index cb8cf437ce87..25fcf4079fec 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -391,7 +391,7 @@ static struct ets_class *ets_classify(struct sk_buff *skb, struct Qdisc *sch,
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	if (TC_H_MAJ(skb->priority) != sch->handle) {
 		fl = rcu_dereference_bh(q->filter_list);
-		err = tcf_classify(skb, NULL, fl, &res, false);
+		err = tcf_classify_qdisc(skb, fl, &res, false);
 #ifdef CONFIG_NET_CLS_ACT
 		switch (err) {
 		case TC_ACT_STOLEN:
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index cafd1f943d99..6cce86ba383c 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -91,7 +91,7 @@ static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
 		return fq_codel_hash(q, skb) + 1;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	result = tcf_classify(skb, NULL, filter, &res, false);
+	result = tcf_classify_qdisc(skb, filter, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 72f48fa4010b..069e1facd413 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -96,7 +96,7 @@ static unsigned int fq_pie_classify(struct sk_buff *skb, struct Qdisc *sch,
 		return fq_pie_hash(q, skb) + 1;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	result = tcf_classify(skb, NULL, filter, &res, false);
+	result = tcf_classify_qdisc(skb, filter, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 7e537295b8b6..e87f5021a199 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1143,7 +1143,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	head = &q->root;
 	tcf = rcu_dereference_bh(q->root.filter_list);
-	while (tcf && (result = tcf_classify(skb, NULL, tcf, &res, false)) >= 0) {
+	while (tcf && (result = tcf_classify_qdisc(skb, tcf, &res, false)) >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_QUEUED:
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 908b9ba9ba2e..fdac0dc8f35a 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -243,7 +243,7 @@ static struct htb_class *htb_classify(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	while (tcf && (result = tcf_classify(skb, NULL, tcf, &res, false)) >= 0) {
+	while (tcf && (result = tcf_classify_qdisc(skb, tcf, &res, false)) >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_QUEUED:
diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index 4e465d11e3d7..004f0d275caf 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -36,7 +36,7 @@ multiq_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	int err;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	err = tcf_classify(skb, NULL, fl, &res, false);
+	err = tcf_classify_qdisc(skb, fl, &res, false);
 #ifdef CONFIG_NET_CLS_ACT
 	switch (err) {
 	case TC_ACT_STOLEN:
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index e4dd56a89072..79437c587e7e 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -39,7 +39,7 @@ prio_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	if (TC_H_MAJ(skb->priority) != sch->handle) {
 		fl = rcu_dereference_bh(q->filter_list);
-		err = tcf_classify(skb, NULL, fl, &res, false);
+		err = tcf_classify_qdisc(skb, fl, &res, false);
 #ifdef CONFIG_NET_CLS_ACT
 		switch (err) {
 		case TC_ACT_STOLEN:
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index cb56787e1d25..6f3b7273cb16 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -709,7 +709,7 @@ static struct qfq_class *qfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	fl = rcu_dereference_bh(q->filter_list);
-	result = tcf_classify(skb, NULL, fl, &res, false);
+	result = tcf_classify_qdisc(skb, fl, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index b1d465094276..ed39869199c0 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -260,7 +260,7 @@ static bool sfb_classify(struct sk_buff *skb, struct tcf_proto *fl,
 	struct tcf_result res;
 	int result;
 
-	result = tcf_classify(skb, NULL, fl, &res, false);
+	result = tcf_classify_qdisc(skb, fl, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 758b88f21865..77675f9a4c46 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -171,7 +171,7 @@ static unsigned int sfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 		return sfq_hash(q, skb) + 1;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	result = tcf_classify(skb, NULL, fl, &res, false);
+	result = tcf_classify_qdisc(skb, fl, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
-- 
2.54.0

