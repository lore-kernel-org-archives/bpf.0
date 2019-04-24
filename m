Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3787DC10F11
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 18:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0687E208E4
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 18:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2QVTLA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDXSwd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:52:33 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:53145 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDXSwd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 14:52:33 -0400
Received: by mail-oi1-f202.google.com with SMTP id s184so7986578oig.19
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DbGUwbX0eMLZrV6bsfN5Yjl9aMsVjLw4ecSSmgDI3t4=;
        b=R2QVTLA7vXwW+jjuooyibmrzKp8HRdw/m8xj/dZrilLtz8PKvUIC4BQ69q5a2BaGjF
         YLSm1RdhTW+kIoaQSacIlSd9dO9WJnrDNkyEzDkwyXtX91XSSqaQfzo9qPH1yr9Mah2T
         vhgPdXJ6WJ4GZqFE6+5HQDCxyAsofFxg01ET8aH+XqcHOKZLdlWv/C84BGMgMvWyMDpr
         CL+ncEZNgfOAD6pijh9xl6Wt788dJojbOuoVtQmDCWn0rokCcSN1XZ4qLjpxR3jTzNVB
         UHyoYl55c17nvH5vGWqRURioKM+yo3f0qxtqXermbfhsmC7txu8KHAWPP+b51yUvUyJY
         POog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DbGUwbX0eMLZrV6bsfN5Yjl9aMsVjLw4ecSSmgDI3t4=;
        b=SWsabY25HWkwMNz1rsxQVf+H9juz9Jq8pFrG3wwkveJW9Qc6f1hIlxqV2eWTzTRgcO
         QAUhPRpBUjnxHEsLgTRVVOpPzLlvp614lboRpW+bG355xRODb+XZLBLmpAOh5MtirXfI
         U9vq38G3EymmIRFmDb8D/Dmz8UiI8pN1d4QRlt7bZKY0/7WFsFQ1v/VmcEP3ASWVqfRa
         Kt4bui0fGwoeQXdmLv1vKr+d7fQZ8GqM8NlarGS2vK7wQO4OFDjs1Frlm0N7vnNoggqo
         MIDS1UJgKQG/vBc7ZF7lXD+FWWTR0pw/NyYTy+ncowCEFg1SH/LJ6MH2i3ywYI/RpkzL
         Issw==
X-Gm-Message-State: APjAAAW+EEAqzlEdwcl3R3VN8get2KpLGRCshhw8ew+5i38zHw54diwi
        HsqnYNPy54ECSCsk+R5rXBVDSfw=
X-Google-Smtp-Source: APXvYqzR7kvVV3mxKcK4umBLN2BErIq2S+XgbJYo9hmW6L3jy38GsqHNOC/yde0l25LP/UUXl7OX7LY=
X-Received: by 2002:aca:d614:: with SMTP id n20mr352136oig.135.1556131952823;
 Wed, 24 Apr 2019 11:52:32 -0700 (PDT)
Date:   Wed, 24 Apr 2019 11:52:29 -0700
Message-Id: <20190424185230.251550-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next v3 1/2] bpf: support BPF_PROG_QUERY for
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

v3:
* add missing inline to skb_flow_dissector_prog_query static def
  (kbuild test robot <lkp@intel.com>)

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

