Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5FA2D8180;
	Tue, 29 Apr 2025 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970816; cv=none; b=U3Yp5aJRJx4YtdMQlBnCw1V8jUq/Xza6orOf/rBnh46XUYPFVxJubZBsp9MDh6puU1LdgMf0biPYQc1N67cDEdxxXxQkJ01wGJhkOE2t4PFaZNdXHAWjSV7v0FIj6rM7aRYj0eGJkqkIceTd3ZeBX0zgbtP2aRLcRF+li7G05r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970816; c=relaxed/simple;
	bh=JKbRXcJvcvMSucEBBYME5qE9RmdEOPa9o6s6mQCt+50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aDCW+kshBa6gsuRw2V02lUSzalaWUnoeDMsTXodfKI+aPz+vpEuABw23D4evE83x/DXCTLUZurqqgXMsNZpqbUTRkcW4b66LcSt8e6veBUhgzwHaYN5zF7NWt7AW+cp3Q9KfmSFScgCELhyP030OESiqzG4PASKOtoO6txVjF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQLLAUD2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQLLAUD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F4DC4CEEB;
	Tue, 29 Apr 2025 23:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970816;
	bh=JKbRXcJvcvMSucEBBYME5qE9RmdEOPa9o6s6mQCt+50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQLLAUD22bCRBu0wLtNtPrABmoixRhBeoCDWS5tRrRRuNEa0W4jYF2UiWGivgCP7O
	 V3t1X7/Ewkj7xZAdB0Vvx0MHCUzjGnWQxeJr0xg6tUzwCnIMyEQ/UMWnOwiYn9KCAS
	 EhFI5Tvb4DO9+wVA3UFlLf6NvOPomBr0MZsNdl8Vt2piqlkUvzCY08GxHjdEUVUnm7
	 mwSiI4zEjuvdATm88Ts5klBzgdsBv/A7eVSmC3p/BJR3nU5fciceQQFCnki//S+ZSD
	 3/UuyTOQqJRiNxUc3MDN5YytcJI52fplKIDbL/eY3bIilCvCXhwVJ7tNsKxWCN1zEK
	 ZNtObY/72rqVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brandon Kammerdiener <brandon.kammerdiener@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/10] bpf: fix possible endless loop in BPF map iteration
Date: Tue, 29 Apr 2025 19:53:14 -0400
Message-Id: <20250429235316.538129-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235316.538129-1-sashal@kernel.org>
References: <20250429235316.538129-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.135
Content-Transfer-Encoding: 8bit

From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>

[ Upstream commit 75673fda0c557ae26078177dd14d4857afbf128d ]

The _safe variant used here gets the next element before running the callback,
avoiding the endless loop condition.

Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Link: https://lore.kernel.org/r/20250424153246.141677-2-brandon.kammerdiener@intel.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/hashtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index dae9ed02a75be..06bc7f26be06f 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2172,7 +2172,7 @@ static int bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_f
 		b = &htab->buckets[i];
 		rcu_read_lock();
 		head = &b->head;
-		hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
+		hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
 			key = elem->key;
 			if (is_percpu) {
 				/* current cpu value for percpu map */
-- 
2.39.5

