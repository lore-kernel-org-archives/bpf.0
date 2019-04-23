Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C40C10F03
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31904218D2
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KTAXfqSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfDWXWD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:22:03 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:54454 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbfDWXWD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 19:22:03 -0400
Received: by mail-vk1-f201.google.com with SMTP id r132so7686955vke.21
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2019 16:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=G81tbpx1/z7MKLtkWvboQ/UYJPgEYa4nABCy284fRiA=;
        b=KTAXfqSiwa8Bz59Tr8EEdVYTkHkGCft5qb1mq3lv/HFQakW8/4e9Al9k3W/jZGjD4b
         q+gFKAZgMdjYsQ3VbZrsuFsckcXMa6NLLYBR2VFAWV34kG7DqYzsASoOREPIA3ksag0r
         DCEx+CpU2zpMqBgWSdSY0CXWLJYSPIzoxAC7i7KKP9Jtl63DeXtWyVcq7qEXAsN53Mm9
         fau5at7EgHywxrJnbqoNi+lJBDAF/HXonjefK4z9ivHeQLqCMLO2QL2NJ5H6oZqp96PC
         DARbdCpwTZOzsNw2XfDxU2dkcEcMcdnIZVx0IMbTtqjkgqAbF6+L01OwrTqUQdL+5HP1
         cZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=G81tbpx1/z7MKLtkWvboQ/UYJPgEYa4nABCy284fRiA=;
        b=BXYC5XviE9kfy4RQ2CggKoqly4EvGfuIEeXP59KBVh6HQMeXLTFPptUVRrcpz8FIyy
         dvE4bIiB38oMaz34/my0T2Owz16kKuvgWvIYSZ+nvwGgm0USmCajJTkmRtWNmX2cXD4W
         bqHlhoy/Bb4nXuHuwnnlo0quKLhAMsWOa3hDfEJQu1pS228AqLA6xOEcRNzMefF9zp2J
         CEZrr36e3UwhxY73o+cWO29YDNbFAvBbvYlnTZg+fWeHile1uRv2KQrr1x12F/oJA7Iu
         eQKO7hHLNtLYO/HI6GoSUwTp1UeT7dpAclWzAdhIGkuNWUrrPBw4XLuvETjVq9qj3rmb
         zauw==
X-Gm-Message-State: APjAAAV5A89kdKYp889EZu2RWBne9Q9bNLbMYx/tnWGAqvZDRs/j/rUB
        6bTzDIVy6j3BhhbBmYq2YZ86X2g=
X-Google-Smtp-Source: APXvYqxHSF0VggEFAo3IbWyy4A8ZZnpJpzmOTyNG4yz9yWn27HsgRDvcYx60Dx51BR2GuHfTvQ4JYC4=
X-Received: by 2002:a1f:97ce:: with SMTP id z197mr15127775vkd.58.1556061722351;
 Tue, 23 Apr 2019 16:22:02 -0700 (PDT)
Date:   Tue, 23 Apr 2019 16:21:59 -0700
Message-Id: <20190423232200.101627-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next 1/2] bpf: support BPF_PROG_QUERY for
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

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/skbuff.h    |  8 ++++++++
 kernel/bpf/syscall.c      |  2 ++
 net/core/flow_dissector.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

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
index fac712cee9d5..d3c41cb7dbb8 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -65,6 +65,42 @@ void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
 }
 EXPORT_SYMBOL(skb_flow_dissector_init);
 
+int skb_flow_dissector_prog_query(const union bpf_attr *attr,
+				  union bpf_attr __user *uattr)
+{
+	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
+	struct bpf_prog *attached;
+	u32 cnt = 0, flags = 0;
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
+		cnt = 1;
+		if (prog_ids &&
+		    copy_to_user(prog_ids, &attached->aux->id, sizeof(u32))) {
+			rcu_read_unlock();
+			return -EFAULT;
+		}
+	}
+	rcu_read_unlock();
+
+	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)))
+		return -EFAULT;
+
+	if (copy_to_user(&uattr->query.prog_cnt, &cnt, sizeof(cnt)))
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

