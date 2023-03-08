Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A74C678D5
	for <bpf@archiver.kernel.org>; Wed,  8 Mar 2023 07:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCHHAJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 8 Mar 2023 02:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCHHAI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 02:00:08 -0500
Received: from out-62.mta1.migadu.com (out-62.mta1.migadu.com [IPv6:2001:41d0:203:375::3e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E11CA1FFB
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 23:00:06 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678258804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SytDicbcgC8mK+O0GcbgZ65kuTzYapYT7v/rH4Sr3ZQ=;
        b=PTBMPCLRQjegY3RD20jIPluSkK5rKDOw297Nny1G3oqOFo9W1nbh3Dv6iUIiR3wl85OORM
        ICIEjQV0XNFEW6HRmw17ZUibu1RUIRsAecQlWs/e8cR5Ps/pQshlWr/MGR2fk6eg4K2Pok
        SaO1XVrtI0lfnJ4I78zIb/waCoujhJk=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v2 bpf-next 04/17] bpf: Remove the preceding __ from __bpf_selem_unlink_storage
Date:   Tue,  7 Mar 2023 22:59:23 -0800
Message-Id: <20230308065936.1550103-5-martin.lau@linux.dev>
In-Reply-To: <20230308065936.1550103-1-martin.lau@linux.dev>
References: <20230308065936.1550103-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

__bpf_selem_unlink_storage is taking the spin lock and there is
no name collision also. Having the preceding '__' is confusing
when reviewing the later patch.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index f7234a8d4959..70df8dcb2066 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -216,8 +216,8 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	return free_local_storage;
 }
 
-static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
-				       bool use_trace_rcu)
+static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
+				     bool use_trace_rcu)
 {
 	struct bpf_local_storage *local_storage;
 	bool free_local_storage = false;
@@ -288,7 +288,7 @@ void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool use_trace_rcu)
 	 * the local_storage.
 	 */
 	bpf_selem_unlink_map(selem);
-	__bpf_selem_unlink_storage(selem, use_trace_rcu);
+	bpf_selem_unlink_storage(selem, use_trace_rcu);
 }
 
 /* If cacheit_lockit is false, this lookup function is lockless */
-- 
2.34.1

