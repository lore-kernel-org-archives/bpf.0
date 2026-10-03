Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437EB4519B5
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791043427; cv=none; b=UnurZ776rxIpq5vGnQimwuju+x1bA3xdmmlKh04ZnxEV0gWN2pO1ZPs68JiMne57Oue/6NF7Pyq1VEu3JyhwvwYjjNjJjRViFW8Ob7PueYpbz5DVKpN3JEL0jqYuktcXZWp6045x77TH/A7NbMgs3e+EbSO5q1UNr7nbPN0Zw08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791043427; c=relaxed/simple;
	bh=6nsVqmjd8FeQYoJt/aJDbl3LD5zQkcFDPlEI8/gmOeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRDOJPS0a/hShuLN5khGLMrJAgINAY5RPVIo02fv/kkPfxydORvd/fWpweLrLNDgqGCrJ9sEOIO7hGSTdIUCBL9ZcQDGnaj+tmM1lwtFY9tFGqZyxRM464Ofh6YxDi7+tGRKpsbcXKA52K8894HC/2QUfA4nR07jelHVE2uPVjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=XyW6qfUj; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="XyW6qfUj"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id BB50282D14;
	Sat, 03 Oct 2026 18:03:41 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4d36x_v5rRAl; Sat,  3 Oct 2026 18:03:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791043421; bh=6nsVqmjd8FeQYoJt/aJDbl3LD5zQkcFDPlEI8/gmOeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XyW6qfUj7/KYBByVYOlsWuXxcxph2DqauXN6EzKwXJt4LYJO8jumwOBw3HLkhr222
	 ryxVSYZpUyaf2HY7mshcAxZluLg4VUmmLe+QTxiizX8UdHkYUmwJyrMNdjQR0w+YmC
	 wgW+dfp51WDzKrYU1sT+dnmYXFz/NOi9a2TK6BE8d5baR0zxzZXe3k7+aBvq9v95s+
	 7auPcRLkkfSC2UXD3K0mtioFbiJswKRqkhILc/TSdWfdR2kzBh2zHUhRvx3CKsiYJX
	 oZyPUvhB5+8nZvGz0Au68cxqd/GvHqhHcdvf6rpUhOpkTVByUttSVVRW0cIokalt7n
	 OXkNoekRVDFgQ==
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
Subject: [PATCH bpf v3 2/3] bpf: Fix incorrect handling of user flags by percpu hash map updates
Date: Sat,  3 Oct 2026 17:02:12 +0100
Message-ID: <20261003160213.2641506-3-maghasi@disroot.org>
In-Reply-To: <20261003160213.2641506-1-maghasi@disroot.org>
References: <20261003160213.2641506-1-maghasi@disroot.org>
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
with (BPF_F_CPU, BPF_F_ALL_CPUS) flags.
This causes the (BPF_NOEXIST, BPF_EXIST) flags to lose their effect.

For example, when using (BPF_F_CPU | BPF_EXIST) flag combination
with bpf_map_update_elem() on a BPF_MAP_TYPE_PERCPU_HASH map, the
BPF_EXIST flag does not prevent new insertions as expected.

This patch fixes the bug by adding proper flag validations and checks.

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

