Return-Path: <SRS0=IWuG=RQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17981C43381
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 14:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1E8214AE
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 14:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjGp7uUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfCMOQV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:16:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33415 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfCMOQV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Mar 2019 10:16:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id h11so1650171pgl.0;
        Wed, 13 Mar 2019 07:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5SzNmbhlEr2CI8d5cFn0YP0wxuqdeqdMhKSN1wEWEP4=;
        b=XjGp7uUtyDmhYNOq7ou11pBDfq6UmqHtq2itFxAx30Dl2ux+udbzXzKpAJOUQsS8o0
         tz7A8hBrdOdpFjsTs8HrxSuV9aw/fieESEQWS7S/OebDVv9a+tHNfPFMf0w7bqSqOsl6
         4sgd/UZSaPlLv9MbMsBqNXaNuvV0l3lZOcQiiEIcJq0Jn75OJXNLiH59BvxY+zH968AW
         K9pQDv1eoZPEQvMNLT5Se1vhc6xON8W2zUBpQB9CTx2u4KtFOQaLyvN+CDhk2EBtOzid
         SxHpPBuBLARK5ofZfxCNn1VC2z2pfGnDSgJZlHxZe82O8BW8PSJKHcSawobwGbi6Ahik
         JQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5SzNmbhlEr2CI8d5cFn0YP0wxuqdeqdMhKSN1wEWEP4=;
        b=ocA49XTyggTYbh1/eFxdP0Pg/4N1G08pTm2N0uHgZjI+pHI8o2JNPrM4nLFf+4oIOr
         17+IyjuH8NdG9x7rijANjKpn5IirIiVZk2oL8LeaaH7C8ZxEcKOjp/yVtHE4FcR+VYFr
         ulGro0u9LU4b1PUgE3huLT3PcNt0bl37vVW6fRe4nOVWbbtttkooo+/2/hkIVGUry7mk
         xLootf63Cs3HRIz5Qu/10KC5KQBU65PvqlsXifodWWAquhRcCFBwQ1hUxz8arlo9LBeG
         PycwIKsGSYxyCHheTDknsnepEWBO9Dnc7DYOrgShhREI7dLroa7TNEQg0y+B2DK+4qk6
         pPSw==
X-Gm-Message-State: APjAAAX5ac3/lqScuuWLsZFWwPKS9lg3Bhh77dLWwKqHASm0tSTVGI2m
        QqNhzJ+AdycTB5GYPYFVAAI=
X-Google-Smtp-Source: APXvYqx4oBF6VLzR3jPQJhqeauVIlcw6t2MBdw2TuOVnl85F6w35us4ujZ5H+XELldrcciuQdfIvCw==
X-Received: by 2002:a17:902:f83:: with SMTP id 3mr47526012plz.125.1552486580086;
        Wed, 13 Mar 2019 07:16:20 -0700 (PDT)
Received: from btopel-mobl.ger.intel.com ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id l19sm15376140pff.185.2019.03.13.07.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 07:16:19 -0700 (PDT)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        jslaby@suse.cz
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, magnus.karlsson@gmail.com,
        bpf@vger.kernel.org
Subject: [PATCH bpf] xsk: fix umem memory leak on cleanup
Date:   Wed, 13 Mar 2019 15:15:49 +0100
Message-Id: <20190313141549.17783-1-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

When the umem is cleaned up, the task that created it might already be
gone. If the task was gone, the xdp_umem_release function did not free
the pages member of struct xdp_umem.

It turned out that the task lookup was not needed at all; The code was
a left-over when we moved from task accounting to user accounting [1].

This patch fixes the memory leak by removing the task lookup logic
completely.

[1] https://lore.kernel.org/netdev/20180131135356.19134-3-bjorn.topel@gmail.com/

Link: https://lore.kernel.org/netdev/c1cb2ca8-6a14-3980-8672-f3de0bb38dfd@suse.cz/
Fixes: c0c77d8fb787 ("xsk: add user memory registration support sockopt")
Reported-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 include/net/xdp_sock.h |  1 -
 net/xdp/xdp_umem.c     | 19 +------------------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 61cf7dbb6782..d074b6d60f8a 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -36,7 +36,6 @@ struct xdp_umem {
 	u32 headroom;
 	u32 chunk_size_nohr;
 	struct user_struct *user;
-	struct pid *pid;
 	unsigned long address;
 	refcount_t users;
 	struct work_struct work;
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 77520eacee8f..989e52386c35 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -193,9 +193,6 @@ static void xdp_umem_unaccount_pages(struct xdp_umem *umem)
 
 static void xdp_umem_release(struct xdp_umem *umem)
 {
-	struct task_struct *task;
-	struct mm_struct *mm;
-
 	xdp_umem_clear_dev(umem);
 
 	ida_simple_remove(&umem_ida, umem->id);
@@ -214,21 +211,10 @@ static void xdp_umem_release(struct xdp_umem *umem)
 
 	xdp_umem_unpin_pages(umem);
 
-	task = get_pid_task(umem->pid, PIDTYPE_PID);
-	put_pid(umem->pid);
-	if (!task)
-		goto out;
-	mm = get_task_mm(task);
-	put_task_struct(task);
-	if (!mm)
-		goto out;
-
-	mmput(mm);
 	kfree(umem->pages);
 	umem->pages = NULL;
 
 	xdp_umem_unaccount_pages(umem);
-out:
 	kfree(umem);
 }
 
@@ -357,7 +343,6 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (size_chk < 0)
 		return -EINVAL;
 
-	umem->pid = get_task_pid(current, PIDTYPE_PID);
 	umem->address = (unsigned long)addr;
 	umem->chunk_mask = ~((u64)chunk_size - 1);
 	umem->size = size;
@@ -373,7 +358,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 
 	err = xdp_umem_account_pages(umem);
 	if (err)
-		goto out;
+		return err;
 
 	err = xdp_umem_pin_pages(umem);
 	if (err)
@@ -392,8 +377,6 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 
 out_account:
 	xdp_umem_unaccount_pages(umem);
-out:
-	put_pid(umem->pid);
 	return err;
 }
 
-- 
2.19.1

