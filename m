Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DA2380FC3;
	Thu, 17 Sep 2026 01:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610178; cv=none; b=HD1BUnBJ7q5eC2DBCJ3sFSXWflqa9lOW2ful9+R28abk6bLKzbI5MOxamuPl7dczFChprtaS2l3gaCyZiCVTn/b0CXbKtUSCNYRZdUrCz6a5X3WEwaP9G78rmy6PPKsoMWBBH8gonH96olmK+uFOo0ttRNTGIEpv9vvqHj/+wns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610178; c=relaxed/simple;
	bh=5s5S18z4A1sNaj6fri7ON6LiM5xkiNn7dalDg7H++XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDySZOQ9HzK+jPOXlL/sVL/46Pd0XJ1j9X7+qNzsS0n4rF9MVaSWLcc+hvmStLQgIrSOy0xOhQoiHUoqu+T+Cc+tE9/aGmbE3ky+Jxb+xsPRPym5agmngUfv9iPSGpsjyCTjYcrNpnaDmqZOFv2im2iJFuAiXeCt9qggSfGZJpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=PTx694vY; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PTx694vY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=fnBgR565PA6VuCVVHUTKJbrew5TWmOVzzld1yXKSBzU=; b=PTx694vYGRfe
	SBgwIqeQx3g9CdCAEk9gK6sbSY6P6RzEwVN2l3VHvDhiYkvjvO694881wu5b44Pw46FvZF7/+u3/X
	UwovwcoWWuHFTPHj0Selx8JmYmx3TCtNL3KXkgsA3ms581RzQi7PQ0lE2B8yw/Z4pdN21gvNB3bAL
	Saxh1RIocHtJvctWfie2gPp4MKMMKe74w+RsQ3R+TQNe9GGroRwRA/k3ESBvdhx9PZytvrhZhyC96
	1BDOWoWRJwoN4x3xLupoGYj4eiGD/EOXjzq5+8WHj2LOBX3AKrpQW24zuJadetCpZiDrPfhqjMmI7
	5Xj3R6NTA25+7DOxuRYdqw==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=LekKit-T14)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <eva.kurchatova@virtuozzo.com>)
	id 1x71JO-00132Z-1r;
	Thu, 17 Sep 2026 03:56:08 +0200
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Cc: linux-kernel@vger.kernel.org,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests: bpf: size the map in test_lru_sanity3 to whole refills
Date: Thu, 17 Sep 2026 04:55:57 +0300
Message-ID: <20260917015605.2464043-2-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917015605.2464043-1-eva.kurchatova@virtuozzo.com>
References: <20260917015605.2464043-1-eva.kurchatova@virtuozzo.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_lru_sanity3 fills a map of tgt_free * 2 elements and then reads
back all but the last few, which fails on a machine with six CPUs:

  test_lru_sanity3 (map_type:9 map_flags:0x0): test_lru_map.c:463:
  test_lru_sanity3: Assertion `!bpf_map_lookup_elem_with_ref_bit(
  lru_map_fd, key, value)' failed.

Elements are handed to a CPU in refills of lru->target_free, which
bpf_lru_populate() derives from the map size as clamp((nr_elems /
num_possible_cpus()) / 2, 1, LOCAL_FREE_TARGET), so 21 for a 256 element
map and six CPUs. A refill that the global free list cannot satisfy in
full does not stop there: bpf_lru_list_pop_free_to_local() calls
__bpf_lru_list_shrink() for the remainder, which evicts elements that
are still in the map. 256 is not a multiple of 21, so filling the map
ends on a partial refill that drops 17 of the elements the test goes on
to reference, and the lookup fails on the first of them.

Whether the size divides evenly depends on the CPU count alone, which is
why this passes on two and on sixty four CPUs and fails on six.

batch_size is already __tgt_size(tgt_free), the refill size of a map of
__map_size(batch_size) elements, so size the map that way and filling it
consumes whole refills and evicts nothing. Start the keys of the last
insert at map_size + 1, they were placed just past the old size.

Fixes: 5e9388f7984a ("selftests/bpf: adapt one more case in test_lru_map to the new target_free")
Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
---
 tools/testing/selftests/bpf/test_lru_map.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
index 0921939532c6..fc67a337d3c1 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -441,8 +441,18 @@ static void test_lru_sanity3(int map_type, int map_flags, unsigned int tgt_free)
 	assert(sched_next_online(0, &next_cpu) != -1);
 
 	batch_size = __tgt_size(tgt_free);
+	if (!batch_size)
+		batch_size = 1;
+
+	/* The local free list is refilled lru->target_free elements at a
+	 * time, and a refill the global free list cannot satisfy in full
+	 * shrinks the LRU list, which evicts elements that are still live.
+	 * Size the map so that target_free divides it, otherwise filling it
+	 * ends on a partial refill and evicts the elements referenced below.
+	 */
+	map_size = __map_size(batch_size);
+	assert(__tgt_size(map_size) == batch_size);
 
-	map_size = tgt_free * 2;
 	lru_map_fd = create_map(map_type, map_flags, map_size);
 	assert(lru_map_fd != -1);
 
@@ -466,7 +476,7 @@ static void test_lru_sanity3(int map_type, int map_flags, unsigned int tgt_free)
 	}
 
 	/* Insert new batch_size: replaces the non-referenced elements */
-	key = 2 * tgt_free + 1;
+	key = 1 + map_size;
 	end_key = key + batch_size;
 	for (; key < end_key; key++) {
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
-- 
2.55.0

