Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B5D2BE65B;
	Tue, 29 Apr 2025 23:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970751; cv=none; b=tAXoC58WUjfFkOiU9VnESrq+gRvH8YQHzmlKCM8grM2MG4jPO8FIPr1v3ogFjwzTRRukQH3E1nAeadaTVQZqyEwZlHcaD5wmms6RUKqw3OV8Vw3H6zeWxe3D7R2TaIDtjZQ1qDjvZv75hiiVqA4eT2f0BTECG/qg1HjYul/ic/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970751; c=relaxed/simple;
	bh=Vgnw+P4H0P3R/lUDHnSv2SfIZGWcXwVPpr2ACAN6/F8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IgOpM07z54S/OLHSdEv/dqEwSii7tT3L8OcwNWnRlDKAU4V6EWnpot0+s9eRxJwkYPexoL90U0c8SK4gPkQhIGmXL2UIQxvxjFbroG3sZYEl+t11uq3HiGm/S4QKy4CR3i8AomjhxI0VGRbm0myZNWt2wibWUqvN2t3Ix7tpbtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQKRL8O+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQKRL8O+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDB2C4CEF0;
	Tue, 29 Apr 2025 23:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970751;
	bh=Vgnw+P4H0P3R/lUDHnSv2SfIZGWcXwVPpr2ACAN6/F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQKRL8O+BffPwsXb+/bxRMv7auzJFwEXQPB+9PpzOuK1sE378UgHg09K2C2TchyY5
	 as3tzh4RNM3yXzQdtJCSP9cevQvvByTl5OzigSxDos4euqHodr/rg1oufXcsU68d+D
	 bEnt1eWF+BpkmSgHev1eCLGaI2vEV2+RPefmZrAaypFbJn13qFN+b6Psg5Vop1Go+9
	 0smUgBeiWXomhI3EdWt5DgKwtymdqfFTBBGRZ//WakGBOuh6zsDCbIe/6YihkFqRXf
	 ZwTU7jQP3MnxCO28I5J1pQIg6LS0ytNT7BOJqbE0jYwovPYTEyvEu3AvQqEAVz790y
	 hxtzaME4HhlZQ==
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
Subject: [PATCH AUTOSEL 6.12 36/37] bpf: fix possible endless loop in BPF map iteration
Date: Tue, 29 Apr 2025 19:51:21 -0400
Message-Id: <20250429235122.537321-36-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235122.537321-1-sashal@kernel.org>
References: <20250429235122.537321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.25
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
index 3ec941a0ea41c..ff5cec99293a3 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2223,7 +2223,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
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

