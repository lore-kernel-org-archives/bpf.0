Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A996A42377F
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791112275; cv=none; b=nFGviC42rqW+p6UP0iP8To9F5bNPUwhO4YAP0h+OTV70audNwoCtM3gxkdlwIBb+DKSIl/pZ/lbkqKnaCQT6rSWgaPFxr9FGLCp+W51UP2BIJ6jT/CcpB8cgu/P9dTRxJFzrVbtM1GXUDnFmRC+00AgFizc2lQLQnnCyNYpzHPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791112275; c=relaxed/simple;
	bh=uU9XumU1Meprks3wNk3jnHf2DczbMhlTtPZFZkJ1g+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYZuHlYr2B/UULf9EW11dyweWbCk/KDrizUZLxW2PQockDlqB4RtrlZxrF5VXvnkYFX0cNku8lKpYrbv9ERVV8NuI3LPVgojamZB9GcQyMLBZXjmNJ/xdZwyACCPFyfoIxPcjKT9kvg9k5mL0ncJvo+5m/uKDzaLTriXX4jrbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=cdsMvjzE; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="cdsMvjzE"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C92B1810B1;
	Sun, 04 Oct 2026 13:11:08 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QHAcLb56rWvN; Sun,  4 Oct 2026 13:11:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791112267; bh=uU9XumU1Meprks3wNk3jnHf2DczbMhlTtPZFZkJ1g+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cdsMvjzEBlZ7DwLp3RsJThCCCDwQE4wfa1Ow6WT5oiTztn/LeIKoB7KMa8CGvXf8g
	 cCq7RlNsYG+NpLZVNvSVW6gz+3zBUcjt02cYHmy9/XpebhiLUvh2ApQXer5tMC0ZRH
	 VXLQOU0bT0aiVzeB6TyL8ZoE+YPoy/lojsB0qZ4UmPchFMYPjvhFvNRPr/KdmkA+vP
	 TTPI7pCprtZFS0sVRSsTQV/NI/oOX1W9hwVtOLvOu6PIrce042hA4h3Zmu6UlUYvEk
	 FtpKgoDVMd0bg1hhzn9mwodllpNrLPciyz3BIKR3QtRbIiWpVZxQIMXt7/Dx1eNugO
	 BqqCwPwD0Un3w==
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
Subject: [PATCH bpf v4 2/3] bpf: Fix incorrect handling of user flags by percpu hash map updates
Date: Sun,  4 Oct 2026 12:10:05 +0100
Message-ID: <20261004111007.3216186-3-maghasi@disroot.org>
In-Reply-To: <20261004111007.3216186-1-maghasi@disroot.org>
References: <20261004111007.3216186-1-maghasi@disroot.org>
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
 kernel/bpf/hashtab.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

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

