Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDED2D3FB4;
	Tue, 29 Apr 2025 23:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970793; cv=none; b=SkrcRoZ8ItDPzRBp1WUy4rHlxo3G0tr60P7GTc0zgPOg5z8EFEB1pp6ZVjesCQkQEPKdwjZiy0cwlo48DHI1OTAzKonSzATPHAhgxw9AwfT1glF4E/XGC5pqCyER1HQJJ3VQ/LNxGFFnqD1tUOyIm+1N/IFOnadxOxqxbzm2lsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970793; c=relaxed/simple;
	bh=CfWOt/JjFOfExcRczY+gftfEH2MEXx9odLS3CtWyd/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbc2UFvYrRDfY12NcRu2i9ZCGE1LB8zykGmBcOq3IKM5FAhbDuY2F2NOoKCiAcbLLpF+jsAncwXq0oYGYXUffcv9F+MB9ZiVSymLwLs65H7/JE+bT3P6xbNojXwbpYyXgnQ2uXsMM4EAcT9f4ml9JljNM828UtxK9PuSmCi7dvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idFuLsQq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idFuLsQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19889C4CEE3;
	Tue, 29 Apr 2025 23:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970793;
	bh=CfWOt/JjFOfExcRczY+gftfEH2MEXx9odLS3CtWyd/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idFuLsQqQfwfGKvueEsX38MOzQV3YhguVcidThehp4Wd3BJCDJHIgLWy4pi2s9cnp
	 fmNsxEX4bD82lEZYQyOSPmvtdaSSAEwT4KJHbDawd34cjxSP5Z4VY+Jb2Ml1BZTrMS
	 FSFnS3SXD5aoH64gI1DDp5gBMWgc+WPddI2TX+OvpP2B+26RmZCNZskklmiSKmTP1E
	 ujUW2q54moyjIqJkmVc5gtYh9y8GTfS0EF7oN65a5uQmsDMkbE0PJ49/2Eh82lNQG9
	 sofD+iLTyquUgBn7CsE9t+wJt6uTjO7QPEf934ILPLXOzA9PEb+xoEyhQGx8Qr/bbV
	 jdpN9nRGcyrMg==
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
Subject: [PATCH AUTOSEL 6.6 20/21] bpf: fix possible endless loop in BPF map iteration
Date: Tue, 29 Apr 2025 19:52:32 -0400
Message-Id: <20250429235233.537828-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235233.537828-1-sashal@kernel.org>
References: <20250429235233.537828-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.88
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
index fc34f72702cc4..8a3eadf17f785 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2212,7 +2212,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
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

