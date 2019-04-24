Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CEAC282E1
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 16:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6341208E4
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 16:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l7hLhP5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbfDXQJz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:09:55 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:48510 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731189AbfDXQJz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 12:09:55 -0400
Received: by mail-yb1-f202.google.com with SMTP id 133so6841448yby.15
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6+nh+Oe/DxBT521/rRdIEfM736FsnAmMOm07mS27pIc=;
        b=l7hLhP5MouJr2Wduv1OVMnd3EoCdUF0Z+QY0F7INm9y2ETXusUaVhRAkUKRYkMzD9n
         FpK6JdoEJ7B8MSxvRGataMfdb5uV3fm/zMkedd4Ble/+BdC0O08YyGVcp4iaH0/5e6r5
         6o6QMyyuw+uPGqvRTqFSmNe9M3uuGyAZlTLs4j0dt9do9oUiohgbqZKjgRaPUo9rI8gm
         AN8xMXvtUhBWJDOyQMhst6KWQHiY+YhVCJBxmna/D/PFl0C6IUJz0MACKJ7kGsockE8j
         45G4kmP4nmnJ9bMTTUpJEBi/rzVrG8Vm1gvyEEZZu3dtoQ+9hu0hRrS5QHQy5yJmtx5T
         Hf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6+nh+Oe/DxBT521/rRdIEfM736FsnAmMOm07mS27pIc=;
        b=iOxl99y8TY4/qGq2n31vVU0igHoZ0kHqiwpPmJbuDqxxAyMxYs2Eo7PQVn1C4NSiyA
         l/po0Y/VIxpMvIhJQOi13BTm5Vue6K64q6RR+Ybt8lUWbz/LZbtN3iE9vAKcaHhIgOu2
         ES5td8+ppZdze09YYRPOWm60V8m9D22cZwGZyVn+gtDxTY10MRLIkrw+QcGJHE661PCe
         37tsIVv27tu4Z/dQ9lqKXX8RWTdLm8zWsNPyOMGR3oW1eRur2cDXFBF4dGRVAgSc8wpr
         7FV3gStaBiAzmMhxw04xorUi1ZozLfAyOAR6pCg2ucNLG4r2ueeEtG+0N0fSQ+ybzSpB
         x31w==
X-Gm-Message-State: APjAAAWNYuzGjG/PMuDCiZN3s0oMXMJaa2vm8dYHSHxaxyjDX7vl86Rt
        L7k45/P1HljVCKkMJaDT2RxuSrw=
X-Google-Smtp-Source: APXvYqyywZVqOiYI4eOoPxsZGElfdVF+drfJsD/zSYEoK3LKi45RcD6kvZrytfDvHu3GRfCrpEkYuQ4=
X-Received: by 2002:a25:6544:: with SMTP id z65mr28151520ybb.66.1556122194158;
 Wed, 24 Apr 2019 09:09:54 -0700 (PDT)
Date:   Wed, 24 Apr 2019 09:09:50 -0700
Message-Id: <20190424160951.45865-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next v2 1/2] bpf: support BPF_PROG_QUERY for
 BPF_FLOW_DISSECTOR attach_type
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, quentin.monnet@netronome.com,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

target_fd is target namespace. If there is a flow dissector BPF program
attached to that namespace, its (single) id is returned.

v2:
* don't sleep in rcu critical section (Jakub Kicinski)
* check input prog_cnt (exit early)

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/skbuff.h    |  8 ++++++++
 kernel/bpf/syscall.c      |  2 ++
 net/core/flow_dissector.c | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 998256c2820b..9f499c0ac53b 100644
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
+static int skb_flow_dissector_prog_query(const union bpf_attr *attr,
+					 union bpf_attr __user *uattr)
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
index fac712cee9d5..12b92c7d1eae 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -65,6 +65,43 @@ void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
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

