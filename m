Return-Path: <SRS0=rM0N=7W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B172AC433E1
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 01:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B9E2078C
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 01:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664935;
	bh=h6qgXN4fgHCA3UiZlx2CBU9FEsMck4TG+MvMhPBdHmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MguGw+3i88+ALdxXsHRFPAG6+GSgx3T3Ca2eCg0oPhQC9rJFqYeknwW0bIGoefDUR
	 OzROauKFqGQWcFBxxUobzzLlmb+HDfqONFFbGrhyyqoRQUPFN+tom+aElPKBl+oMyk
	 0dinzwpCUiYbhKzhNpxFAVR89aAf035zBFwFM2c4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgFHXGl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbgFHXGi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 19:06:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6349120774;
        Mon,  8 Jun 2020 23:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657598;
        bh=h6qgXN4fgHCA3UiZlx2CBU9FEsMck4TG+MvMhPBdHmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=To50O7H1PqWbNIUyxLRobz+R59ApnaJDF2hwj2LgWMkrUj+QaYcfaK9XEa/SUIPtV
         BTDnW1b7+JcKAqmCiJjNFr2G78qEmIFu9Otgt8X9pgcRNJyXBkalmNCSVxn6o/HWtd
         mt3+hy4tyDLXZh5NFdVyTgeQtgnmANoO4Vn9vz5A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>, Alston Tang <alston64@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 024/274] libbpf: Fix memory leak and possible double-free in hashmap__clear
Date:   Mon,  8 Jun 2020 19:01:57 -0400
Message-Id: <20200608230607.3361041-24-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

[ Upstream commit 229bf8bf4d910510bc1a2fd0b89bd467cd71050d ]

Fix memory leak in hashmap_clear() not freeing hashmap_entry structs for each
of the remaining entries. Also NULL-out bucket list to prevent possible
double-free between hashmap__clear() and hashmap__free().

Running test_progs-asan flavor clearly showed this problem.

Reported-by: Alston Tang <alston64@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20200429012111.277390-5-andriin@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/hashmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
index 54c30c802070..cffb96202e0d 100644
--- a/tools/lib/bpf/hashmap.c
+++ b/tools/lib/bpf/hashmap.c
@@ -59,7 +59,14 @@ struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
 
 void hashmap__clear(struct hashmap *map)
 {
+	struct hashmap_entry *cur, *tmp;
+	int bkt;
+
+	hashmap__for_each_entry_safe(map, cur, tmp, bkt) {
+		free(cur);
+	}
 	free(map->buckets);
+	map->buckets = NULL;
 	map->cap = map->cap_bits = map->sz = 0;
 }
 
-- 
2.25.1

