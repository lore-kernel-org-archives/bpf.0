Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E486C10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 21:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D240820835
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 21:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vI82nSIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbfDXVbo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:31:44 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:47409 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730761AbfDXVbo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 17:31:44 -0400
Received: by mail-oi1-f202.google.com with SMTP id j5so8182516oif.14
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 14:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uMtp7LKm5ZrgglhLvgXAGqa2KgxyCfqfcKKjsIpeGmg=;
        b=vI82nSIXuRNuhn2igYNrN9XN3hw2wZyexMs1EdZHEbFsJiqDXrXU8VDBQlGF/Ps7ny
         HxiEZM7t5SPeRIpHo1UxjKLLt3ae/JKrmrkO5Ohs/hSSXX8CUtHIwTxoBHzBPUgowbfT
         JjjPiEheNPb0g57g/7wHzig7bBxuvui5xiZj/yq41iACGvDTZV+Okg7alQ9J7p9TFMfm
         ZnQ7QUSS5dFzQKmC/lcYA2DW1QLsP6ItoVwucy4tzOdyffFqDbQLQBCyFAdOJryrUajG
         DWgf1WyR4q7vGrC+acQKoO2WUGlR9drWhQj3HSEsJjuK5DdW291JUiHVq/dxP50h9vca
         qypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uMtp7LKm5ZrgglhLvgXAGqa2KgxyCfqfcKKjsIpeGmg=;
        b=KWdlxlxuhAVxjOO74GuWVayS1eFl/0icyCMrbqNeW5NTihdpujAK38dDHIYN+w8rZL
         wyxmKt3oxcLI8IjSFE8C8vWRPOAqAK/ETvU1O52GzCqYioylyx5uTNK8D7jWPl+v1rq8
         Q5GvfsEdmbmQT/5PKvN3wBZkV5JhJVOUWzvuTKQKtLRSd+6iu3POpGg/5EGVgz8Frc+8
         sSjqNpnHhm8BiJBKuCIGmjXv49ygs3CxmX/ZsaRzp8qpTs71T7UmQ8wWmd/CI3392bJd
         jdFRPid7oKgZ8SFbJ+SJT5Z8rYXxr883kegdr+pz/CXdD+QiwrLjRPT4cRhrbJ34t5mC
         vCkA==
X-Gm-Message-State: APjAAAW+wQyhrgXfqCCsnqqnVC7K9i4NAcDd8aFQMTnNDOS1kxJ0QT0c
        bZsqCbWYUQsGAKtQmDjVE2skNVQ=
X-Google-Smtp-Source: APXvYqzuqk0wBOzX6D1g5XWILjixOFVjNYwKxBs5DMgirsNTZfLOOVKocNA0O8WcWq1sO/ehNLIfeOk=
X-Received: by 2002:aca:d595:: with SMTP id m143mr862555oig.31.1556141503531;
 Wed, 24 Apr 2019 14:31:43 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:31:40 -0700
Message-Id: <20190424213141.201134-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next v4 1/2] bpf: support BPF_PROG_QUERY for
 BPF_FLOW_DISSECTOR attach_type
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, quentin.monnet@netronome.com,
        Stanislav Fomichev <sdf@google.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

target_fd is target namespace. If there is a flow dissector BPF program
attached to that namespace, its (single) id is returned.

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
 include/linux/skbuff.h    |  8 +++++++
 kernel/bpf/syscall.c      |  2 ++
 net/core/flow_dissector.c | 46 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

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
index fac712cee9d5..27466e54ad3a 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -65,6 +65,52 @@ void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
 }
 EXPORT_SYMBOL(skb_flow_dissector_init);
 
+int skb_flow_dissector_prog_query(const union bpf_attr *attr,
+				  union bpf_attr __user *uattr)
+{
+	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
+	u32 prog_id, prog_cnt = 0, flags = 0;
+	struct bpf_prog *attached;
+	struct net *net;
+	int ret = 0;
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
+	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags))) {
+		ret = -EFAULT;
+		goto out;
+	}
+	if (copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
+		goto out;
+
+	if (copy_to_user(prog_ids, &prog_id, sizeof(u32))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+out:
+	put_net(net);
+	return ret;
+}
+
 int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
 				       struct bpf_prog *prog)
 {
-- 
2.21.0.593.g511ec345e18-goog

