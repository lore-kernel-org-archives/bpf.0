Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8E5C43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF7D217F4
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEkw165+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfCSWT7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:19:59 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:54149 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfCSWT6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 18:19:58 -0400
Received: by mail-pf1-f201.google.com with SMTP id o67so333577pfa.20
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pu9K8qAZZblDYPDVA7EYOUqWou4R/bxvaqgJUXZvwfU=;
        b=MEkw165+Bg+STSkbOvl5OqjFvxEF5MN+8sgr/e9XIxqQ6qVCfUuAr9h84BdN+PL+de
         2yLXwpvn7lpnJzt/7Hv7QdoFhUD93Mrt43JHZkxLco0M3nhZ75A+VPqurLEy/A6Zpp+1
         Uioij5qilBxd+G/NHM2STAqNkHLJbwSSzB/WDouKdLwkS0v4YIRyX8hFfgegnfER7A4x
         HF0e8d2SwiI6K6v3rGlkgkwdaINkBQ2JrJ6oA4DSS5W29YEYPaZJd2zzzKUcWBjJQnWy
         j6Ipr5/lJL1jIeA3dLx4wXo6Wid8ZriqF5j3MY7/v1FIr3Y41ZaL8Pt7KsKEruPbhRGD
         fVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pu9K8qAZZblDYPDVA7EYOUqWou4R/bxvaqgJUXZvwfU=;
        b=TmiHvkGRj6BM2OisIv8TCo3vJbOAefocI6j4gKBbtiFmZ8t3uV3y1/ioe/tPMGg1yn
         Ai3Ar5bzHR0gOBfm4agmnu2qvBblSPwL9C3h8152O7BHxBgVB2ZfddToWuy14Gz6hgM1
         EQdU6c9y/tBgzteJrcctkqNRaky4SCTwDG6i2lSS+pKaoBjioHR6Xn+fKSTHEhJcXf4o
         uz8CFZNtSlr+9bPTZfYgwFgwpIZgVFFIdI5K5nFPC3eQeSP55dXhWOXB0gK+ewE5zSLc
         +KWOF6v/YAk7H6uPDeM6zkjTy6TeFsLcmlJrbdzmE8N2VYt9lD8d6Z1vfTGaCAVWwVpf
         3O0w==
X-Gm-Message-State: APjAAAVB/RjQ56Hfs16yiYSUFuN6wt58x4PT7pl3qT81UsVO9uJGKVPc
        E2Q9Eo+NvvSIAtevabPKL2fntaQ=
X-Google-Smtp-Source: APXvYqwLSSTm+bF8JyIuo/M42INuZSNpc8wy4wC7yaSzZ0O+c+NCwbVv+7X3pQhTOJd0u8aW7N/ZDVI=
X-Received: by 2002:a63:194e:: with SMTP id 14mr8354729pgz.53.1553033997301;
 Tue, 19 Mar 2019 15:19:57 -0700 (PDT)
Date:   Tue, 19 Mar 2019 15:19:41 -0700
In-Reply-To: <20190319221948.170441-1-sdf@google.com>
Message-Id: <20190319221948.170441-3-sdf@google.com>
Mime-Version: 1.0
References: <20190319221948.170441-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [RFC bpf-next v2 2/9] net: introduce skb_net helper
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        simon.horman@netronome.com, willemb@google.com,
        peterpenkov96@gmail.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

skb_net returns network namespace from the associated device or socket.

This will be used in the next commit.

I tried to inline it in skbuff.h, but I don't think it's feasible.
It depends on 'net/sock.h' for sock_net() and 'linux/netdevice.h' for
dev_net(), both of which we don't include from 'linux/skbuff.h' (but
both sock.h and netdevice.h include skbuff.h). I though about doing
it as a macro/putting it somewhere else, but we will have
skb_flow_dissect{_xyz} use it in the next commits.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/skbuff.h |  2 ++
 net/core/skbuff.c      | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index e8c1d5b97f96..75e1d4d73cca 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1275,6 +1275,8 @@ static inline int skb_flow_dissector_bpf_prog_detach(const union bpf_attr *attr)
 }
 #endif
 
+struct net *skb_net(const struct sk_buff *skb);
+
 struct bpf_flow_keys;
 bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
 			    const struct sk_buff *skb,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b413354ee709..d81f3a95fb4e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5725,3 +5725,19 @@ void __skb_ext_put(struct skb_ext *ext)
 }
 EXPORT_SYMBOL(__skb_ext_put);
 #endif /* CONFIG_SKB_EXTENSIONS */
+
+/**
+ * skb_net - Return network namespace associated with skb.
+ * @skb: skb
+ *
+ * Returns pointer to struct net or NULL.
+ */
+struct net *skb_net(const struct sk_buff *skb)
+{
+	if (skb->dev)
+		return dev_net(skb->dev);
+	else if (skb->sk)
+		return sock_net(skb->sk);
+	return NULL;
+}
+EXPORT_SYMBOL(skb_net);
-- 
2.21.0.225.g810b269d1ac-goog

