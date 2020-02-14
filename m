Return-Path: <SRS0=yg+S=4C=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D73DC2BA83
	for <bpf@archiver.kernel.org>; Fri, 14 Feb 2020 18:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4263A2168B
	for <bpf@archiver.kernel.org>; Fri, 14 Feb 2020 18:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704148;
	bh=JrHjtwzZrIE4QpB3v0AizW6puXMwCqlkDOToOFzYGYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lF7pEXjZS13Vn8rOcvqWXvuFYAaPwet6ps/qaVqhR/PrWdbmiYN9Lw+wN8mqrDKzt
	 do3h9ukUMFnQKUGCn9abLwMHBToXmgw/2SF9elnSWfVch4b26cZt+xzxOi1kfBFLSr
	 sFwCSOzQWKgs0dzSDE+hcHiDTu3gXX36Zroro7yM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgBNSPm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:15:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730860AbgBNPvt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Feb 2020 10:51:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A2D5222C4;
        Fri, 14 Feb 2020 15:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695509;
        bh=JrHjtwzZrIE4QpB3v0AizW6puXMwCqlkDOToOFzYGYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxigJgjfb3D51Jkjy+gZjeLiyjHX1/UqMVMVKWIkohKhk4M4GmAoua9bi17npNsq6
         CKcapLI0h1saFEkdBD1F013g3reOcD7Mpg2rupIjBNVZhV4UBVrFNKyLCR7XqgVgzt
         xP9+aJcH/4YQt8mU2F4yOUXclUbv/b4RZp3mpS7A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 134/542] bpf, sockhash: Synchronize_rcu before free'ing map
Date:   Fri, 14 Feb 2020 10:42:06 -0500
Message-Id: <20200214154854.6746-134-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jakub Sitnicki <jakub@cloudflare.com>

[ Upstream commit 0b2dc83906cf1e694e48003eae5df8fa63f76fd9 ]

We need to have a synchronize_rcu before free'ing the sockhash because any
outstanding psock references will have a pointer to the map and when they
use it, this could trigger a use after free.

This is a sister fix for sockhash, following commit 2bb90e5cc90e ("bpf:
sockmap, synchronize_rcu before free'ing map") which addressed sockmap,
which comes from a manual audit.

Fixes: 604326b41a6fb ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20200206111652.694507-3-jakub@cloudflare.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock_map.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 8998e356f4232..058422b932607 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -250,6 +250,7 @@ static void sock_map_free(struct bpf_map *map)
 	raw_spin_unlock_bh(&stab->lock);
 	rcu_read_unlock();
 
+	/* wait for psock readers accessing its map link */
 	synchronize_rcu();
 
 	bpf_map_area_free(stab->sks);
@@ -873,6 +874,9 @@ static void sock_hash_free(struct bpf_map *map)
 	}
 	rcu_read_unlock();
 
+	/* wait for psock readers accessing its map link */
+	synchronize_rcu();
+
 	bpf_map_area_free(htab->buckets);
 	kfree(htab);
 }
-- 
2.20.1

