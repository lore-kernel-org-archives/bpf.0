Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBFC3E40FC
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276444; cv=none; b=R8zQ/KOgu/uZLEfrIpt8HMllPvlBq7C2toaN0RifaFuBUKl6J0hElvIxDbqKceBWjk8CTgphpKqQTuvnlCfj5epEvAmE3tVWDlze1Yf6qnpYf7eQe0NVsjYfad48/KCrnyCtV4uY15GYVh9uZpVjmBVXk4xL32toU+0lEqtOVJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276444; c=relaxed/simple;
	bh=ee0kvfphfn6fGmV2E/pXlWjSehJACttxgQP2FYWBfG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIer414avGlj/9G+u5AbX4+mlzY1W4HmtRWIV9LCb/pKtwADhUTn6OCD1Y1nFt4PMxFlUI2AZrgs2D60lhTFL6O5QDqzcsuxh4t+umE1KxruSTWvpE1Tx7O34DrxmbS7N5qee2c3GaGIua3n/ccNOt9m91GCVJR7+0G6io+bi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=fIgXFmcB; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="fIgXFmcB"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8300F807CA;
	Tue, 06 Oct 2026 10:47:20 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id khWcLLgTFRwn; Tue,  6 Oct 2026 10:47:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791276439; bh=ee0kvfphfn6fGmV2E/pXlWjSehJACttxgQP2FYWBfG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fIgXFmcB/rUYgok5zrwQXj4mafhYOXpq6qUaCuyff+2slw0/rcsjO9k64z7uIhdbC
	 NY5tS59MoHSW22vk4RHXNZ/p03T7anIdo3PGdkFMd6DK/DQjYt5XeL29zOY2mWwpMN
	 OFiqhKP4jFmrB00UCuY3M2BXe2WS0InLpcFS0zNB2pjdWit0m+giuNyn6bPj/TVstt
	 REYb8rwkCsLRtdHevA/T42hb4itaqplTryMkz01presSjQcs9lziizuQfXCuKx4/TU
	 yBvoR9Y16eEZcZh+Wntux0K9pQYOerQo0scnskj/Os5DNRi3ca+txDnowqsk078jzx
	 xE7GNxCUp/wAA==
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
Subject: [PATCH bpf v5 2/3] bpf: Fix incorrect handling of user flags by percpu hash map updates
Date: Tue,  6 Oct 2026 09:46:03 +0100
Message-ID: <20261006084604.780456-3-maghasi@disroot.org>
In-Reply-To: <20261006084604.780456-1-maghasi@disroot.org>
References: <20261006084604.780456-1-maghasi@disroot.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For BPF_MAP_TYPE_PERCPU_HASH and BPF_MAP_TYPE_LRU_PERCPU_HASH maps,
htab_map_check_update_flags() and check_flags() are not considering
the possibility of a combination of (BPF_NOEXIST, BPF_EXIST) flags
with (BPF_F_CPU, BPF_F_ALL_CPUS) flags. This causes the
(BPF_NOEXIST, BPF_EXIST) flags to lose their effect in some cases.

For example, when using (BPF_F_CPU | BPF_EXIST) or
(BPF_F_CPU | BPF_NOEXIST) flag combinations with bpf_map_update_elem()
on a percpu hash map, the BPF_EXIST flag does not prevent new
insertions as expected and BPF_NOEXIST flag does not prevent
modification of existing entries as expected.

This patch fixes the bug by adding proper flag validations and checks.
Before this patch, htab_map_check_update_flags() rejected
(BPF_F_ALL_CPUS | BPF_EXIST) and (BPF_F_ALL_CPUS | BPF_NOEXIST) with
-EINVAL. After the patch those combinations are accepted.

This patch also starts returning -EINVAL for (BPF_EXIST | BPF_NOEXIST),
with or without BPF_F_CPU, which was previously accepted.

Fixes: c6936161fd55 ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps")
Signed-off-by: Masoud Aghasi <maghasi@disroot.org>
---
 kernel/bpf/hashtab.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 53c99fe4f176..0202922b7f37 100644
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
 
@@ -1383,9 +1383,11 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 
 static int htab_map_check_update_flags(bool onallcpus, u64 map_flags)
 {
+	if (unlikely((map_flags & BPF_EXIST_FLAGS) == BPF_EXIST_FLAGS))
+		return -EINVAL;
 	if (unlikely(!onallcpus && map_flags > BPF_EXIST))
 		return -EINVAL;
-	if (unlikely(onallcpus && ((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS)))
+	if (unlikely(onallcpus && ((u32)map_flags & ~(BPF_EXIST_FLAGS | BPF_CPU_FLAGS))))
 		return -EINVAL;
 	return 0;
 }
@@ -1483,7 +1485,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
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

