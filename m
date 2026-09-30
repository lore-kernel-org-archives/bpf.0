Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277354BD78D
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776744; cv=none; b=M8Xb3w8OLcP7zpFAitdVKabNfIi3AhSZNWPuZvmCSU+afSfS/uGvoJKToDapl8ORBhnoEfZOfs4PTgkpAiD9YTlRiKSoWVWToM5k2ljjRy/gE1/nMPZzzdG7Et48fGswO+4cb5J2nDT/kvGVEJt2f+xxb4k8L1MDn7Ve49e2pd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776744; c=relaxed/simple;
	bh=MYa5KoRMOjMHbhrmBk06Y2Gw1N86pmqrNai/q8suwV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJ57kpjd99px/OOxiMUkHgiBkMo8EHLAGRlH1HqOfMFGxabokn9iamA4jWlTEb3zzsMeUM4vWkToG2ikOfg1JS5b+RZ0ZnEx9Eh1p3lPMxCQXrKgkzOx8veIcZmeV7t9rtDF6QAHfvS08+VqG/hJrItHbcsY6i4qPcuews88oDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hPUka+4Q; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hPUka+4Q"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7F40D80BB3;
	Wed, 30 Sep 2026 15:58:55 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xor5EcMjvXuB; Wed, 30 Sep 2026 15:58:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1790776734; bh=MYa5KoRMOjMHbhrmBk06Y2Gw1N86pmqrNai/q8suwV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hPUka+4QdDQ5I0crdeupfLCzoTL5bLvBIlbLpJc/+D9GJuz8/Gp/h/eJ4MPHP51b0
	 mkuNABLdd0T4Jvt0+r3uX8/f1hQ8YgMdON0iwYpyywJL51HKg9LU467tR0/IniLI8f
	 VOVBbZ06cTtuuy9jeYJGOewdnqCTPahPHBbcvXIOusMQPAXP0jjMCoFOhWjOUWhrvg
	 u+aq5n9oThueeF2dV/Ihm3bygzAnATVUlH6Czat0TNU1p0YoCrFrPFCwZiztJu+un3
	 VBrue3LDy0d4uZEOZpAbGTwE9CM5hyI7oQq6LhRJNSu+lsQnqV62+d2jBZV9DU2AJO
	 Sww7BcnJcOWww==
From: Masoud Aghasi <maghasi@disroot.org>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	leon.hwang@linux.dev,
	Masoud Aghasi <maghasi@disroot.org>
Subject: [PATCH v2 1/2] bpf: Fix incorrect handling of user flags by percpu map updates
Date: Wed, 30 Sep 2026 14:57:52 +0100
Message-ID: <20260930135753.1063495-2-maghasi@disroot.org>
In-Reply-To: <20260930135753.1063495-1-maghasi@disroot.org>
References: <20260930135753.1063495-1-maghasi@disroot.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For BPF_MAP_TYPE_PERCPU_HASH map, htab_map_check_update_flags() and
check_flags() are not considering the possibility of a combination of
(BPF_NOEXIST, BPF_EXIST) flags with (BPF_F_CPU, BPF_F_ALL_CPUS) flags.
This causes the (BPF_NOEXIST, BPF_EXIST) flags to lose their effect.

For example, when using (BPF_F_CPU | BPF_EXIST) flag combination
with bpf_map_update_elem() on a BPF_MAP_TYPE_PERCPU_HASH map, the
BPF_EXIST flag does not prevent new insertions as expected.

Also for BPF_MAP_TYPE_PERCPU_ARRAY map, using the (BPF_F_ALL_CPUS |
BPF_EXIST) flag combination with bpf_map_update_elem() results in an
incorrect EINVAL error response, even though the flag combination is
valid.

This patch fixes the bug by adding proper flag validations and checks.

Fixes: c6936161fd55 ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps")
Fixes: 8eb76cb03f0f ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps")
Signed-off-by: Masoud Aghasi <maghasi@disroot.org>
---
 kernel/bpf/arraymap.c |  5 +++--
 kernel/bpf/hashtab.c  | 11 +++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 0fe9afd4a591..4edfde6a624c 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -438,7 +438,8 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	u32 size;
 	int cpu, off = 0;
 
-	if (unlikely((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS))
+	if (unlikely((map_flags & BPF_EXIST) && (map_flags & BPF_NOEXIST)) ||
+	    unlikely((u32)map_flags & ~(BPF_EXIST | BPF_NOEXIST | BPF_F_CPU | BPF_F_ALL_CPUS)))
 		/* unknown flags */
 		return -EINVAL;
 
@@ -446,7 +447,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 		/* all elements were pre-allocated, cannot insert a new one */
 		return -E2BIG;
 
-	if (unlikely(map_flags == BPF_NOEXIST))
+	if (unlikely(map_flags & BPF_NOEXIST))
 		/* all elements already exist */
 		return -EEXIST;
 
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 53c99fe4f176..2106b82894b2 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1196,11 +1196,11 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 static int check_flags(struct bpf_htab *htab, struct htab_elem *l_old,
 		       u64 map_flags)
 {
-	if (l_old && (map_flags & ~BPF_F_LOCK) == BPF_NOEXIST)
+	if (l_old && (map_flags & BPF_NOEXIST))
 		/* elem already exists */
 		return -EEXIST;
 
-	if (!l_old && (map_flags & ~BPF_F_LOCK) == BPF_EXIST)
+	if (!l_old && (map_flags & BPF_EXIST))
 		/* elem doesn't exist, cannot update it */
 		return -ENOENT;
 
@@ -1383,9 +1383,12 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 
 static int htab_map_check_update_flags(bool onallcpus, u64 map_flags)
 {
+	if (unlikely((map_flags & BPF_EXIST) && (map_flags & BPF_NOEXIST)))
+		return -EINVAL;
 	if (unlikely(!onallcpus && map_flags > BPF_EXIST))
 		return -EINVAL;
-	if (unlikely(onallcpus && ((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS)))
+	if (unlikely(onallcpus &&
+	    ((u32)map_flags & ~(BPF_EXIST | BPF_NOEXIST | BPF_F_CPU | BPF_F_ALL_CPUS))))
 		return -EINVAL;
 	return 0;
 }
@@ -1483,7 +1486,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	 * to remove older elem from htab and this removal
 	 * operation will need a bucket lock.
 	 */
-	if (map_flags != BPF_EXIST) {
+	if (!(map_flags & BPF_EXIST)) {
 		l_new = prealloc_lru_pop(htab, key, hash);
 		if (!l_new)
 			return -ENOMEM;
-- 
2.47.3

