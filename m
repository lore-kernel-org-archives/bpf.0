Received: from out-zbxj-a75.jellyfish.systems (out-zbxj-a75.jellyfish.systems [198.54.127.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CB72DA74C
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788709050; cv=none; b=e5yHdPXWd3bvTCKN2gjNorwNh0CRQBOajdhx8s5dZ6eUfuo5s0b0T62SRzzOoYe55sYTrdTCbWXbZ4jCkvrOyGnTGEZBrpeVKfQQLLRKPzCibSQrQWZJZasd9eIgC1eZJkyvcjKc8UMtOIuLNR/1vcLO1PAMFQgefy7Dn5CGfPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788709050; c=relaxed/simple;
	bh=XyL7AOWnPAUqZgn9BzIhON3fVHrsyTT58SYLvVkw7jE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nS5fUCWwUrYL+q3LWN2RFPLNeHm8P9GVqSgGJzuCVKEWQkf0i7boFyjeWtvvOYQX4hUFoCVeJdf1S5+L5I1tPPn1yuRgxBf7iTx/lu0FKbJFrqrQemXielUSTvJnoLOizhZRKt3hiWr9fgf/WevHtse0fgDbWwP/Pj9muOUXM0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=Pi6yuokZ; arc=none smtp.client-ip=198.54.127.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="Pi6yuokZ"
Received: from fedora (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdDpV5cBvz8sWW;
	Sun, 06 Sep 2026 15:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788709032;
	bh=q6cSyvPreWKONkLUFI9E06SSGG6JGS8PdVxZdY0jEgY=;
	h=From:To:Cc:Subject:Date:From;
	b=Pi6yuokZh6qN1HunLPsbJs6jAtnWnvmy3KleAwr3/I+U7B/7CgHKV+SVt8ZfjC8WQ
	 9oNCjPugZfuuNqHZdV9XjotQkM0pWRm7ROAlpzFbjCvuWes7IbLPUcUYfrIeM+7vP3
	 r6e59eaGU6f0XPG/c0fUaQD8kV2pEU/KZ3Pztfc64oWmjR4utHDZ6+Zpq8iFSdtEXw
	 QQaHiw2xwj95/YZvh+3EIeVrwkkgQ/DE2h6X5Yh6azQzijo/rutuc6D8ZHuP99Lwra
	 jVAxe9pB2/3o2a0leT9TOXc6DK8moU+hs2fonwCbcZBiCJiSVawycJy99bEg0tnbnb
	 7CCwhTNUnaDuA==
From: Tianyi Chen <hi@tychen.cc>
To: andrii@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Tianyi Chen <hi@tychen.cc>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Brian Vazquez <brianvv@google.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH bpf v2] selftests/bpf: Check returned keys in map batch validators
Date: Sun,  6 Sep 2026 23:36:56 +0800
Message-ID: <178870889323.880246.16480713814270899611.bpf-batch-v2@tychen.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

The hash, array and LPM trie batch validators mark visited entries by
output position, making the subsequent completeness checks always
succeed. Duplicate keys with matching values can therefore hide
missing entries.

Check each returned key against the set populated by the test and
index the visited array by key. This detects missing entries while
preserving unordered results and existing per-CPU value validation.

For LPM trie keys, check the /32 prefix and complete IPv4 address
before using the host octet as the index. Compare the address directly
in host byte order instead of parsing its textual representation.

Fixes: 30ff3c59137d ("selftests/bpf: Add batch ops testing for htab and htab_percpu map")
Fixes: f0fac2cec286 ("selftests/bpf: Add batch ops testing to array bpf map")
Fixes: e9bd8cbd970b ("bpf: selftests: Add tests for batched ops in LPM trie maps")
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
Changes in v2:
- Cover the LPM trie batch validator as well, including its complete
  IPv4 key and /32 prefix before indexing visited.
- Move validation details out of the commit message.
- Retain CHECK(): these tests use the legacy test_maps.h framework,
  which does not provide test_progs.h's ASSERT_* helpers.

Validation:
- Rebuilt and ran the full test_maps suite on a matching 7.3.0-rc1 VM:
  all tests passed, with 0 skips, including all five batch variants.
- Exact old/new LPM validator controls under ASan and UBSan accept valid
  permutations and reject duplicates, invalid prefixes/networks/hosts
  and mismatched values with the new checks.
- The array/hash changes and their prior scalar/per-CPU controls are
  unchanged from v1.

v1: https://lore.kernel.org/bpf/20260906143918.848536-1-hi@tychen.cc/

 .../bpf/map_tests/array_map_batch_ops.c       |  5 ++++-
 .../bpf/map_tests/htab_map_batch_ops.c        |  4 +++-
 .../bpf/map_tests/lpm_trie_map_batch_ops.c    | 19 ++++++++++---------
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
index b595556315b..76d3800a82a 100644
--- a/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
@@ -45,6 +45,9 @@ static void map_batch_verify(int *visited, __u32 max_entries, int *keys,
 
 	memset(visited, 0, max_entries * sizeof(*visited));
 	for (i = 0; i < max_entries; i++) {
+		CHECK(keys[i] < 0 || keys[i] >= max_entries, "key checking",
+		      "error: i %d key %d out of range\n", i, keys[i]);
+
 		if (is_pcpu) {
 			cpu_offset = i * nr_cpus;
 			for (j = 0; j < nr_cpus; j++) {
@@ -59,7 +62,7 @@ static void map_batch_verify(int *visited, __u32 max_entries, int *keys,
 			      "error: i %d key %d value %lld\n", i, keys[i],
 			      values[i]);
 		}
-		visited[i] = 1;
+		visited[keys[i]] = 1;
 	}
 	for (i = 0; i < max_entries; i++) {
 		CHECK(visited[i] != 1, "visited checking",
diff --git a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
index 5da493b94ae..430949f9691 100644
--- a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
@@ -50,6 +50,8 @@ static void map_batch_verify(int *visited, __u32 max_entries,
 
 	memset(visited, 0, max_entries * sizeof(*visited));
 	for (i = 0; i < max_entries; i++) {
+		CHECK(keys[i] < 1 || keys[i] > max_entries, "key checking",
+		      "error: i %d key %d out of range\n", i, keys[i]);
 
 		if (is_pcpu) {
 			for (j = 0; j < bpf_num_possible_cpus(); j++) {
@@ -65,7 +67,7 @@ static void map_batch_verify(int *visited, __u32 max_entries,
 			      ((int *)values)[i]);
 		}
 
-		visited[i] = 1;
+		visited[keys[i] - 1] = 1;
 
 	}
 	for (i = 0; i < max_entries; i++) {
diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
index fe3e19f9624..3b51670b3cd 100644
--- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
@@ -44,18 +44,19 @@ static void map_batch_update(int map_fd, __u32 max_entries,
 static void map_batch_verify(int *visited, __u32 max_entries,
 			     struct test_lpm_key *keys, int *values)
 {
-	char buff[16] = { 0 };
-	int lower_byte = 0;
-	__u32 i;
+	__u32 i, ipv4, key;
 
 	memset(visited, 0, max_entries * sizeof(*visited));
 	for (i = 0; i < max_entries; i++) {
-		inet_ntop(AF_INET, &keys[i].ipv4, buff, 32);
-		CHECK(sscanf(buff, "192.168.1.%d", &lower_byte) == EOF,
-		      "sscanf()", "error: i %d\n", i);
-		CHECK(lower_byte != values[i], "key/value checking",
-		      "error: i %d key %s value %d\n", i, buff, values[i]);
-		visited[i] = 1;
+		ipv4 = ntohl(keys[i].ipv4.s_addr);
+		key = ipv4 & 0xff;
+		/* Expected keys are 192.168.1.1..max_entries with a /32 prefix. */
+		CHECK(keys[i].prefix != 32 || (ipv4 & 0xffffff00) != 0xc0a80100 ||
+		      key == 0 || key > max_entries, "key checking",
+		      "error: i %u prefix %u ipv4 %#x\n", i, keys[i].prefix, ipv4);
+		CHECK(key != values[i], "key/value checking",
+		      "error: i %u key %u value %d\n", i, key, values[i]);
+		visited[key - 1] = 1;
 	}
 	for (i = 0; i < max_entries; i++) {
 		CHECK(visited[i] != 1, "visited checking",
-- 
2.55.0

