Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C949B468
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591415; cv=none; b=tPRMN34parSvsFYc6EZT3l/sAPkKBU3l+qk90Tp2h0zSaekONTrLEtW9Kr24TrANmSafbNdW87QPfEIhR/fJuXGejWvHjxXUWgb+5CseGsZZva/tBZz8hVU8SDh5g7/6gU9fSwXZDNwYYSOunzFL6ylRenTCHcI9tUNtDDfMXiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591415; c=relaxed/simple;
	bh=Umb1btahHBPxFeqTuvhnYj9SaQesT9itvoTiSNvPFj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qe1kK6BH2hn+KGuzqH65HPHUG5uxKPiQOU8hYXBcLzdgj+JL3gKeV9BVXAMZxjPLfjktB4fWT/KAV8bpDNM6DsWtHQc80MW0lZyTMIZO+6Ge2uup4p+6GJaX6RwJqhN2BO2aKtciQxmF+PSt6TbX2CRC/rL3n1cpA9RLCaQ16N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=U6hgqbW2; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="U6hgqbW2"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 645C180E8A;
	Mon, 28 Sep 2026 12:30:04 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z9bacsdTlvLB; Mon, 28 Sep 2026 12:30:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1790591403; bh=Umb1btahHBPxFeqTuvhnYj9SaQesT9itvoTiSNvPFj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U6hgqbW2E+rPR++Hg7NiwVsF7nmRIRnG6P9Cx1Kh1e+nM7aicG8xwIWN4E+F5Z2NR
	 9HTugZl54AmowfFdLJTvoCxE34mI6aLAkzspCben3N8UnXlmqIGmaTMMvnu9ERRXaR
	 /YoezdgwcQZSZl3hLZPilPGmgDZAOLNrkZg3XYSR8a9zBfXvaW/XFWG90Hfz8nZCaf
	 5Ij/8HVjGJSuVDldbmOv3PBtjJFuX/DIyFqftzy5hF96VjfSxd/EfCLwbOiQH8vqyP
	 WEaDoCaITt8ZPJ7pn1AnTIAgPvHcRvg7Bi290WBIESWj+QqntA0/HMsvPBrRfe0OhE
	 mLCbKoYEsZiBQ==
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
Subject: [PATCH 1/2] bpf: Fix incorrect handling of user flags by percpu map updates
Date: Mon, 28 Sep 2026 11:28:20 +0100
Message-ID: <20260928102821.995214-2-maghasi@disroot.org>
In-Reply-To: <20260928102821.995214-1-maghasi@disroot.org>
References: <20260928102821.995214-1-maghasi@disroot.org>
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
 kernel/bpf/arraymap.c | 4 ++--
 kernel/bpf/hashtab.c  | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 0fe9afd4a591..1be86e9b2e84 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -438,7 +438,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	u32 size;
 	int cpu, off = 0;
 
-	if (unlikely((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS))
+	if (unlikely((u32)map_flags & ~(BPF_EXIST | BPF_NOEXIST | BPF_F_CPU | BPF_F_ALL_CPUS)))
 		/* unknown flags */
 		return -EINVAL;
 
@@ -446,7 +446,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 		/* all elements were pre-allocated, cannot insert a new one */
 		return -E2BIG;
 
-	if (unlikely(map_flags == BPF_NOEXIST))
+	if (unlikely(map_flags & BPF_NOEXIST))
 		/* all elements already exist */
 		return -EEXIST;
 
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 53c99fe4f176..648b9aeb917c 100644
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
-- 
2.47.3

