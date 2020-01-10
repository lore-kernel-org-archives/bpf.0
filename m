Return-Path: <SRS0=J/LN=27=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7ACC33CA5
	for <bpf@archiver.kernel.org>; Fri, 10 Jan 2020 10:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39F72077C
	for <bpf@archiver.kernel.org>; Fri, 10 Jan 2020 10:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XJBfsBdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgAJKus (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:50:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36598 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgAJKuj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jan 2020 05:50:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so1360105wru.3
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2020 02:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/PpG3/qK5hQR6KN+p/37WA4pTFpmd2R9d2LRqSHtZk=;
        b=XJBfsBdhVipFtWgm1WkSXSL9WdfaT807exLmP8idg9/ejh936CptxtA3uVXnh9zKxA
         1FsPripCK9a+bYOvWK0reZ7Q6DHtpcpKcvMjKwTfaY3vHR3TlRI8ra2Z3ydgHFvRH3AA
         4yQnDJIscVd35OM/vYsg0aEieBMYbMD/Qw/rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/PpG3/qK5hQR6KN+p/37WA4pTFpmd2R9d2LRqSHtZk=;
        b=cROThX0fa7E2wPPOK89+pJyogeXzj9+ttBMOXPjlkbHU0kiSsrcO/hmHZP3zfHaNhA
         WH85UaA2lQpKGb2tH31M5W8Ns1DqSUTLfWdyNlsfSjbTVfXfO6wEdfj25sO7txft1Yqs
         CPYswn1pk/Tk1nMnddnlV9b7Bh+D+EDOkFL+ZmWca0SMPcHhNF/uHwvuoIJqwSvfI65g
         ikc9qeVW2SttY/5elXtn45V8rHk9oEPpwpLeN8/3aG/vocaPgG1AmPR+KVUKzzml2J6b
         O/S2iQoFnxrSse7wm94it2yhwrGOfZPwV9Bzy2RWGVdd6GQMmVw7ZZbd+1ZE2LYYiTq2
         NatA==
X-Gm-Message-State: APjAAAXHi5IGriimu1UlFGXZHxVJDX7sh3f+buZ60WrmrncpEnEkYI3h
        eumL9w5Qruuw4//yjtMxVyv7LO/HLB2J1g==
X-Google-Smtp-Source: APXvYqwzgmXFAsPY2sRnLEcHD5sBCE3vayVrqcx4xFvfcNz0X94qZHJHfzk49wOWznaZrYdtInSzxg==
X-Received: by 2002:adf:fa0b:: with SMTP id m11mr2814160wrr.98.1578653437659;
        Fri, 10 Jan 2020 02:50:37 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id f1sm1821145wmc.45.2020.01.10.02.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 02:50:37 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Eric Dumazet <edumazet@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v2 06/11] bpf, sockmap: Don't set up sockmap progs for listening sockets
Date:   Fri, 10 Jan 2020 11:50:22 +0100
Message-Id: <20200110105027.257877-7-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110105027.257877-1-jakub@cloudflare.com>
References: <20200110105027.257877-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that sockmap can hold listening sockets, when setting up the psock we
will (i) grab references to verdict/parser progs, and (2) override socket
upcalls sk_data_ready and sk_write_space.

We cannot redirect to listening sockets so we don't need to link the socket
to the BPF progs, but more importantly we don't want the listening socket
to have overridden upcalls because they would get inherited by child
sockets cloned from it.

Introduce a separate initialization path for listening sockets that does
not change the upcalls and ignores the BPF progs.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 99daea502508..d1a91e41ff82 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -228,6 +228,30 @@ static int sock_map_link(struct bpf_map *map, struct sk_psock_progs *progs,
 	return ret;
 }
 
+static int sock_map_link_no_progs(struct bpf_map *map, struct sock *sk)
+{
+	struct sk_psock *psock;
+	int ret;
+
+	psock = sk_psock_get_checked(sk);
+	if (IS_ERR(psock))
+		return PTR_ERR(psock);
+
+	if (psock) {
+		tcp_bpf_reinit(sk);
+		return 0;
+	}
+
+	psock = sk_psock_init(sk, map->numa_node);
+	if (!psock)
+		return -ENOMEM;
+
+	ret = tcp_bpf_init(sk);
+	if (ret < 0)
+		sk_psock_put(sk, psock);
+	return ret;
+}
+
 static void sock_map_free(struct bpf_map *map)
 {
 	struct bpf_stab *stab = container_of(map, struct bpf_stab, map);
@@ -352,7 +376,15 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
 	if (!link)
 		return -ENOMEM;
 
-	ret = sock_map_link(map, &stab->progs, sk);
+	/* Only established or almost established sockets leaving
+	 * SYN_RECV state need to hold refs to parser/verdict progs
+	 * and have their sk_data_ready and sk_write_space callbacks
+	 * overridden.
+	 */
+	if (sk->sk_state == TCP_LISTEN)
+		ret = sock_map_link_no_progs(map, sk);
+	else
+		ret = sock_map_link(map, &stab->progs, sk);
 	if (ret < 0)
 		goto out_free;
 
-- 
2.24.1

