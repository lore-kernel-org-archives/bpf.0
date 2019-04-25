Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD5C43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 21:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3E6206BF
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 21:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqv1h9xY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbfDYVh2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:37:28 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:56019 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731255AbfDYVh1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 17:37:27 -0400
Received: by mail-pg1-f202.google.com with SMTP id a8so538788pgq.22
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 14:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UAjPdvqWg5Vcpy6WjhUujOLut6fOmfM18+jDIqTl8yU=;
        b=eqv1h9xYKqx2Mt2qm6D6gIVR9ld1O0wDmWr4VM1uIynlztZbuPt+8YaPYkp8m5887e
         nMexZyQLyNgPgCkalsCjTwDdccazQsozzRA/Doc8jgsaIqQmbU41gWwb02MaE95QfEWN
         T5iuXbOFMn0eQ6Z0xcRcjP2DSZx3v7Ag+gfoOuLGHM2bZ4Bp1f6m6GX785ak3/NYWQt+
         qLDqM20oqfeVmyoKyJprc12P59YMCh8jMRekTCneLPmeWpe/smw6u6XUJX2Vg7KeZD/+
         UFtyULlkotN7FcKvv+xVRXdHwF5pRFfIwfQtg7lwdtTqrdv7AUhQYVNEQBdZOUzAZC0z
         V0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UAjPdvqWg5Vcpy6WjhUujOLut6fOmfM18+jDIqTl8yU=;
        b=m+/yPCaiA/K2Kd4vDeLHguK61hua6ASZaIeC2wm1Y9rjqhHcReZRXibG5tMh4Ooir/
         MlUWSoQt/PfxdDMY75y9/VjQq/nS60S/hnA1A3HQO7fSadx7Jvjj7L5cf7//x8zylwaL
         wBOpPOJZwYMlBSa1pVIkg5u/eN+zRZOejmZjD494D/43ILqOfowBJXK+7dnPp5jbGzpR
         F3efHbHGNCdU0t1R4X4OmXSc23ezUyAG0566C3fpX6KkmgVQyhojthe4Nc3oPiH0k4n5
         FtPVHgJyGMPxog3+xvz7jv7hpRlL0is7bpRSU/HbsJ3vVqBiFHbVNkvs8wwgDJDV/lhw
         2NhA==
X-Gm-Message-State: APjAAAVfO6etgew4xXmE7RV20D9L94nVPXhZEnEmX9MIYlhNjaKra2gX
        +3lhErS6Q4gFzBpgSxdTXz2N75o=
X-Google-Smtp-Source: APXvYqxP6GJBeiLkNqCfAvmX5JUUDmol9S8qtksSnCsECoAI8fFcavhIa9IwVvU7cWcY1u4FKTH2nBg=
X-Received: by 2002:a63:f26:: with SMTP id e38mr40563801pgl.290.1556228247069;
 Thu, 25 Apr 2019 14:37:27 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:37:23 -0700
Message-Id: <20190425213724.25056-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next v5 1/2] bpf: support BPF_PROG_QUERY for
 BPF_FLOW_DISSECTOR attach_type
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

target_fd is target namespace. If there is a flow dissector BPF program
attached to that namespace, its (single) id is returned.

v5:
* drop net ref right after rcu unlock (Daniel Borkmann)

v4:
* add missing put_net (Jann Horn)

v3:
* add missing inline to skb_flow_dissector_prog_query static def
  (kbuild test robot <lkp@intel.com>)

v2:
* don't sleep in rcu critical section (Jakub Kicinski)
* check input prog_cnt (exit early)

Cc: Jann Horn <jannh@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/skbuff.h    |  8 ++++++++
 kernel/bpf/syscall.c      |  2 ++
 net/core/flow_dissector.c | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 998256c2820b..6d58fa8a65fd 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1258,11 +1258,19 @@ void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
 			     unsigned int key_count);
 
 #ifdef CONFIG_NET
+int skb_flow_dissector_prog_query(const union bpf_attr *attr,
+				  union bpf_attr __user *uattr);
 int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
 				       struct bpf_prog *prog);
 
 int skb_flow_dissector_bpf_prog_detach(const union bpf_attr *attr);
 #else
+static inline int skb_flow_dissector_prog_query(const union bpf_attr *attr,
+						union bpf_attr __user *uattr)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
 						     struct bpf_prog *prog)
 {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 92c9b8a32b50..b0de49598341 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2009,6 +2009,8 @@ static int bpf_prog_query(const union bpf_attr *attr,
 		break;
 	case BPF_LIRC_MODE2:
 		return lirc_prog_query(attr, uattr);
+	case BPF_FLOW_DISSECTOR:
+		return skb_flow_dissector_prog_query(attr, uattr);
 	default:
 		return -EINVAL;
 	}
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index fac712cee9d5..9ca784c592ac 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -65,6 +65,45 @@ void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
 }
 EXPORT_SYMBOL(skb_flow_dissector_init);
 
+int skb_flow_dissector_prog_query(const union bpf_attr *attr,
+				  union bpf_attr __user *uattr)
+{
+	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
+	u32 prog_id, prog_cnt = 0, flags = 0;
+	struct bpf_prog *attached;
+	struct net *net;
+
+	if (attr->query.query_flags)
+		return -EINVAL;
+
+	net = get_net_ns_by_fd(attr->query.target_fd);
+	if (IS_ERR(net))
+		return PTR_ERR(net);
+
+	rcu_read_lock();
+	attached = rcu_dereference(net->flow_dissector_prog);
+	if (attached) {
+		prog_cnt = 1;
+		prog_id = attached->aux->id;
+	}
+	rcu_read_unlock();
+
+	put_net(net);
+
+	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)))
+		return -EFAULT;
+	if (copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt)))
+		return -EFAULT;
+
+	if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
+		return 0;
+
+	if (copy_to_user(prog_ids, &prog_id, sizeof(u32)))
+		return -EFAULT;
+
+	return 0;
+}
+
 int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
 				       struct bpf_prog *prog)
 {
-- 
2.21.0.593.g511ec345e18-goog

