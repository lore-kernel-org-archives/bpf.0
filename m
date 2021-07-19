Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA470C07E95
	for <bpf@archiver.kernel.org>; Mon, 19 Jul 2021 22:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FBB6113B
	for <bpf@archiver.kernel.org>; Mon, 19 Jul 2021 22:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390268AbhGSVyV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 19 Jul 2021 17:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243143AbhGSVTW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 17:19:22 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E0DC0613E1;
        Mon, 19 Jul 2021 14:48:58 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id k16so21735233ios.10;
        Mon, 19 Jul 2021 14:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HymHhQopj26OxK3+fnb/omh7xAPDnF9dX8lhezU6bTg=;
        b=ohNu1y0ok8cMLAjMs7ijjfDfhq9tKUi8qu8ehAR9hcRCEZvGY20LAC/3UT74S9nc3+
         DGgh2wB6BugWW1zgk9T1LdTaD9HzK6ZHUofjHr0TTVTSjRpnCbc/wvf4gzegp69Vf7hN
         +UZnVz9vzdIAOvYnODpIIUM0/uYNC5tSHQq7Z2RYZyosiVSJRXEx/xicwYj65RPrhQtA
         wTnFVNfs8OnsQ23lCEnE53t7z5wbjHDnO2ABpMMHpE3P6SQaVTsplA6KU3hptGqSMVMJ
         qqWfZ16jHWHzzdndyiUAPIrEgN1s2RtJIRlKVdzVjqVNntDwMf57b5UcX8XHSHSUF/ST
         NtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HymHhQopj26OxK3+fnb/omh7xAPDnF9dX8lhezU6bTg=;
        b=nWtqxE0TkxsFTiMaANOxKbl+4JCtLHgcivlxop70W7oX90ROeSG4hy4IsVuIPhkS4N
         eoAK4smbROWV0noyQSKzi0HkyJM9bru/qOLlf+EaspAo+Mg/8RfwT78GFbOhgZqGAmf5
         Vl6dN74j0rFOUCM4W3bRlXRTdLZTmveABCjzerbzv/rzghltB6P66O+kkn54DW8+qroc
         VwAcT4WwZzoeyna/R6AAJVrpJFTV7ayGzbUz/1NX1gW+tj9aK6GS95w00Mc8bddGVcQQ
         smjGN9JwU74u/p9ryxdzHoiKxiT4IxL+bGbBfNPXhAlCnA0yC5x5Q7SEghN+iNhk02WG
         O5LA==
X-Gm-Message-State: AOAM532eE4/WAMD63cQIkjHZDUKxCdcl8dehui7Jgk95sixIa7/tZq+0
        LmaNsWdWg98Slq+ryYCBrVE=
X-Google-Smtp-Source: ABdhPJxx0NheJtq7B+/Ya5SzxPN1byskNyQyGl7E84MSZYSBDCq8j0s98Tw0BcaTTS6GGHkXbWS0hA==
X-Received: by 2002:a02:94af:: with SMTP id x44mr23859679jah.79.1626731338394;
        Mon, 19 Jul 2021 14:48:58 -0700 (PDT)
Received: from john-XPS-13-9370.lan ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id d14sm10124758iln.48.2021.07.19.14.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 14:48:57 -0700 (PDT)
From:   John Fastabend <john.fastabend@gmail.com>
To:     jakub@cloudflare.com, daniel@iogearbox.net,
        xiyou.wangcong@gmail.com, alexei.starovoitov@gmail.com
Cc:     john.fastabend@gmail.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH bpf 1/3] bpf, sockmap: zap ingress queues after stopping strparser
Date:   Mon, 19 Jul 2021 14:48:32 -0700
Message-Id: <20210719214834.125484-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210719214834.125484-1-john.fastabend@gmail.com>
References: <20210719214834.125484-1-john.fastabend@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We don't want strparser to run and pass skbs into skmsg handlers when
the psock is null. We just sk_drop them in this case. When removing
a live socket from map it means extra drops that we do not need to
incur. Move the zap below strparser close to avoid this condition.

This way we stop the stream parser first stopping it from processing
packets and then delete the psock.

Fixes: a136678c0bdbb ("bpf: sk_msg, zap ingress queue on psock down")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/skmsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 15d71288e741..28115ef742e8 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -773,8 +773,6 @@ static void sk_psock_destroy(struct work_struct *work)
 
 void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
 {
-	sk_psock_stop(psock, false);
-
 	write_lock_bh(&sk->sk_callback_lock);
 	sk_psock_restore_proto(sk, psock);
 	rcu_assign_sk_user_data(sk, NULL);
@@ -784,6 +782,8 @@ void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
 		sk_psock_stop_verdict(sk, psock);
 	write_unlock_bh(&sk->sk_callback_lock);
 
+	sk_psock_stop(psock, false);
+
 	INIT_RCU_WORK(&psock->rwork, sk_psock_destroy);
 	queue_rcu_work(system_wq, &psock->rwork);
 }
-- 
2.25.1

