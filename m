Received: from mail-pz2-f7.google.com (mail-pz2-f7.google.com [74.125.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0F13B6BFA
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 02:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095046; cv=none; b=QBxYNbYoKigCVV9Ln36a2mrMWvKYo/4xtCWKeBKsr/q2OcF1SpicH0qX3jQs5uoJquHHzF63mWFZNstoKRNAZYEDaGDy7dPw04wx8+NWpNhYStVmKMhCrOVATl1Ukzmhyhig1j+hPVANwylMdEllWkOurUNl8hgEiR7HeNZ9XXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095046; c=relaxed/simple;
	bh=qZMBuFOS61SoGYX1bt/H7POk5TgKw1Hfsfmh5IQTYqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=deUhLhF+qVpdf/aSjewq4ZNvB6HcwzJ2gMIzDqZw93x9SnOp2KKssglxmVUg3XLF+cFJ2m91IjG3biWXXADgE16V6Hxzkzji178a0I+DmJdeER+o1UzPWtmvHoM+dBf6hNXJYTU8svwfc9t0zpRqXtxTCZZ3W5Vq/KwqzusEIZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3vnYXF5; arc=none smtp.client-ip=74.125.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3vnYXF5"
Received: by mail-pz2-f7.google.com with SMTP id 41be03b00d2f7-cc4b1f7e8b7so132664a12.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 19:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789095044; x=1789699844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4giGc4vyIVZJOAViaxjJmZeSymKkMLSjlhuqN+0g3rI=;
        b=P3vnYXF5uJLFD4G8tSEwhN/jpRRJyIoF51bn3NkpJvsEEZ9OYaLA0n39YLidOwHA8d
         1CBGr9FtzsjTWP0b7ilCtb7toFtyH5vZsPIKXsOcktCcvoBTOTDPFFQ1APAFgw0QpxTT
         4/o8yoy2CbznT5+bZaJMijQ88B/Gd/olep1iUuLxS03bqKuk+WCn57Buq8yotSIBJLuC
         xyks/TUelLXeGZo5qJyHU/794iNpqqsSGlCpNIK6HsKb1xQAqdbwn+ZB159apht33of2
         L3jWaMrxWEbkDUASvXohUwkDGF5/WxadXQtktqUGKbr4+igt2EC1E6FW8hhkhTNS4zrQ
         bL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789095044; x=1789699844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4giGc4vyIVZJOAViaxjJmZeSymKkMLSjlhuqN+0g3rI=;
        b=CY+pIFCYnBLtOi+o5enSZGfDL+4OgCRt9dp7JkANlEY3mby+pe7PaHpfhrwcWToZle
         kRgr5ss3XEwF9UgnIxgZZ6llugyIEKWbp977b1+bAAROv9WPP1pElgRePPKQnr8urZqe
         dpGyH5YTlTClb8Vd5sFx8c28MxzLbVR3ixccUDoms+owx24k3766OB/cSgius4inaGn1
         zUITS7DIjx/2E4XUX7XLygWMCkOGZ78ZM3rYa2M8tsfuHhQgs1qG/pfZHJzp7FEhF7CW
         1caXLFJ2efh10JQWtkOm0pqPMxPwSdwjxuqqPpG4Gi8GmLWsLAPj2PmPAxCJqGuFFoYz
         bSuw==
X-Forwarded-Encrypted: i=1; AKwUvBwdgEJpFnoU0OrhR5teEaWA/ArUqY4T1KZcfIV+oZiF21JiNrpvC2tQRGO1CE3iys1qWw4=@vger.kernel.org
X-Gm-Message-State: AFuF++lGAtBR+m6rn42dKpOw+v8Sp3Ssm06lNlWkk/WBm84nBssDv596
	oxbEhrUArCXKOUjgNjT1xxWreUuHwzLQABYAYXDYTg26hDwj/z/8z8Nh
X-Gm-Gg: AYBFou0Ww3wO2A6RU2FH4T/z21FJ06/m2urp3XMAvBlH81YUYgl91RnFzDhgQN8/Woc
	/qtZ+iEoFp6EXZNZHjOkgemBJJn53IodYXfKVRiMS9oC3IcmxsrQ8rjRf7WnTuWMPp7BMq13617
	OAJWmIQYjmyUW6L22WHIN9/f1Rh43ytHcIYNahqy2G3B0rA517R1m6t9ER/pOKIUXKvGUwUAIrD
	zqzXcNepnmtmpDy5zikKwc/aEyo+j6Oxr676EWCYrQqg8lOyddNgdMdcVhtQXfWguV1iihl8W63
	b14+q0PVoLD+iKki6DO5PMBJUh2YgVC8WisamgMmgs9zLQA/Irm5lXvwQXpCTsQBhfBsb1K/o1i
	iewD7TKRopuFMi0pYxMB4q2O2B3LOn9oListv6igFaLVYIKaugeqt26TqzQ0W/OMd9rY2tz/C+t
	PfrjYpj1vuDHRaZPVSDhYHvgGBNQNlmPXaTHmLqQDJkMvKNHzNo4x3Phhk9wrXuUHd
X-Received: by 2002:a05:6a00:1c95:b0:85a:bc69:bfc4 with SMTP id d2e1a72fcca58-86b2c0e9a55mr3797212b3a.0.1789095044177;
        Thu, 10 Sep 2026 19:50:44 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6572ecasm406973a12.22.2026.09.10.19.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 19:50:43 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Cc: ihor.solodrai@linux.dev,
	yonghong.song@linux.dev,
	brianvv@google.com,
	pctammela@mojatatu.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v3] selftests/bpf: Check returned keys in map batch validators
Date: Fri, 11 Sep 2026 10:50:36 +0800
Message-ID: <20260911025036.190487-1-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyi Chen <hi@tychen.cc>

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
Changes in v3:
- Rebase onto current bpf/master; the v2 test logic is unchanged.

Validation: test_maps passed in an x86-64 KVM guest running the rebuilt
bpf/master kernel (Linux 7.3.0-rc2), with LLVM 20-built selftests.
The hash, array and LPM batch tests passed; test_maps reported 0 skipped
and returned 0.

The v2 CI PR expired after repeated "Patch is empty" reports without
conflicting hunks. This patch applies cleanly to the current tree and is
sent in a new thread with git format-patch and git send-email.

v2: https://lore.kernel.org/r/178870889323.880246.16480713814270899611.bpf-batch-v2@tychen.cc

 .../bpf/map_tests/array_map_batch_ops.c       |  5 ++++-
 .../bpf/map_tests/htab_map_batch_ops.c        |  4 +++-
 .../bpf/map_tests/lpm_trie_map_batch_ops.c    | 19 ++++++++++---------
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
index b595556315bc..76d3800a82af 100644
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
index 5da493b94ae2..430949f9691d 100644
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
index fe3e19f96244..3b51670b3cd4 100644
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

base-commit: 15071f2a1263e82150c77eeb1e94dbfc31950a8e
-- 
2.55.0

