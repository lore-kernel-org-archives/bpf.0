Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCD92DB4C4;
	Tue, 29 Apr 2025 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970833; cv=none; b=fAxtxgHjJ9/TYkbwPoGWtVsqR0RU7AsWE/da1GluVK3F+5qVvq2BLLR71LBNfZpJ2g1yosV0htsQ7/6VG74fR7176BtfIjuttmoFvOvcWogElpuJ2Y6PGhLuiNqb0DfpEcYkCEVnLcZxEaRs1C7CKuPqEvbJVSKyedCEzAiE4mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970833; c=relaxed/simple;
	bh=rw+mq8QobftmM/0Yg3TRFb0QYvgbSwfuj2NwWl10AcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B5E2IFg+rbWaRNsetObXIJJQbdQCYesCSBpTdCX+ply6zw99bhJ13Wb5qeG/UrNJpXPpQ/prDSvxZ48PRqlgKbutKYrlIIsqPjz2A5205H8cAkZfqWaWBOlYbh3/sXCAfZOoGk5EJsEOsBOCTkBNbVeNQlZV7gHZKyhsfR3Zrec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob1AIDHt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob1AIDHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1ECC4CEE3;
	Tue, 29 Apr 2025 23:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970833;
	bh=rw+mq8QobftmM/0Yg3TRFb0QYvgbSwfuj2NwWl10AcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ob1AIDHt21joW7Eb6pyuqQzSvqC5vauvhExE9oj4gO1S8Gl+aAFaCZzxmqTOuCyXP
	 KLTYDU1W9aPYDvpQuymezpmIreGzXISirpPzsFNT4NNnfT9EWXCpZghljRoOJgBvVv
	 NlT03IHweLkxw1NNxK0nrWss289Aln3u8SdwHrlIcVJ/w8+p5LgLTLu016DHruHD4K
	 ER4RRU8+vS4KzvCBlcNT0YYN8yl/FVY3JYLhHq/ri7tlGkeBFdZ17K+E7ZXGMvjeZZ
	 yVbdZBIzyhgjXQW0/P8Lio/bHln21IDVBgVcDS0iNwYKqigMhG6nDSToNqCctNEB5h
	 TP1sxOgCQuyIg==
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
Subject: [PATCH AUTOSEL 5.15 6/7] bpf: fix possible endless loop in BPF map iteration
Date: Tue, 29 Apr 2025 19:53:37 -0400
Message-Id: <20250429235339.538269-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235339.538269-1-sashal@kernel.org>
References: <20250429235339.538269-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
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
index d08fe64e0e453..24258c54057d4 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2102,7 +2102,7 @@ static int bpf_for_each_hash_elem(struct bpf_map *map, void *callback_fn,
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

