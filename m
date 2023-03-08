Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45935C6FD1E
	for <bpf@archiver.kernel.org>; Wed,  8 Mar 2023 07:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCHHAK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 8 Mar 2023 02:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCHHAJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 02:00:09 -0500
Received: from out-47.mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE04A21AC
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 23:00:07 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678258806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ojOwMo2t4T2E6qRbus19tZPOZySoyWyQToVVxaqBuL4=;
        b=IGEudCMN/0spF8ZKQUThZjPpAL2YL9OGaT2Yw5F4C1z6x7pTYRcSuCWj45kcmEakekJgzW
        Qiyg4OCp621dKPgWRRCC+PnYDNc9p+TTTXAVMWl126pLLy3CkF3TcZtDs2qEccO4F1dIWO
        4bLQJMfrxNd7VXgfD99x1rYr3pSnZKQ=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v2 bpf-next 05/17] bpf: Remember smap in bpf_local_storage
Date:   Tue,  7 Mar 2023 22:59:24 -0800
Message-Id: <20230308065936.1550103-6-martin.lau@linux.dev>
In-Reply-To: <20230308065936.1550103-1-martin.lau@linux.dev>
References: <20230308065936.1550103-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch remembers which smap triggers the allocation
of a 'struct bpf_local_storage' object. The local_storage is
allocated during the very first selem added to the owner.
The smap pointer is needed when using the bpf_mem_cache_free
in a later patch because it needs to free to the correct
smap's bpf_mem_alloc object.

When a selem is being removed, it needs to check if it is
the selem that triggers the creation of the local_storage.
If it is, the local_storage->smap pointer will be reset to NULL.
This NULL reset is done under the local_storage->lock in
bpf_selem_unlink_storage_nolock() when a selem is being removed.
Also note that the local_storage may not go away even
local_storage->smap is NULL because there may be other
selem still stored in the local_storage.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf_local_storage.h | 1 +
 kernel/bpf/bpf_local_storage.c    | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 5908a954ddc2..613b1805ed9f 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -83,6 +83,7 @@ struct bpf_local_storage_elem {
 
 struct bpf_local_storage {
 	struct bpf_local_storage_data __rcu *cache[BPF_LOCAL_STORAGE_CACHE_SIZE];
+	struct bpf_local_storage_map __rcu *smap;
 	struct hlist_head list; /* List of bpf_local_storage_elem */
 	void *owner;		/* The object that owns the above "list" of
 				 * bpf_local_storage_elem.
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 70df8dcb2066..5585dbfd9c66 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -213,6 +213,9 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 			kfree_rcu(selem, rcu);
 	}
 
+	if (rcu_access_pointer(local_storage->smap) == smap)
+		RCU_INIT_POINTER(local_storage->smap, NULL);
+
 	return free_local_storage;
 }
 
@@ -368,6 +371,7 @@ int bpf_local_storage_alloc(void *owner,
 		goto uncharge;
 	}
 
+	RCU_INIT_POINTER(storage->smap, smap);
 	INIT_HLIST_HEAD(&storage->list);
 	raw_spin_lock_init(&storage->lock);
 	storage->owner = owner;
-- 
2.34.1

