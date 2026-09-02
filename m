Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44CC3A9DB6
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382364; cv=none; b=Tw+ya+URp4uzjCCpx2mOwTc5Z+FddNsxMNSkIgKPnN2Gdxe+19tBfJUHfGOd6+rSyqwcr1Umj7dlSZK+NicYPq0lbO4CXJ3/ShLaFLDQcDd20XXcws8nTqXnnjCEQF7+ivtEEA6uuc0faEQTqbA9nkIMUghdenRZU0f3fN2r7Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382364; c=relaxed/simple;
	bh=2+G26k5CAMyM6qZCC5bAE6nlzBJRz1I84N5Q7MY8NQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCr0Mr9c7blBVY0hWGY8alE511O4XexOxCygqJziyRz2y7VLJOrr4IYORxpCFH3kNMVFzIsQ32yhOwFG6B32ExEVHvR3bpU0ziUOLdbB4aYyUIEGNA31hXstUZlpOlswG6TiIrv6aHyOSCTfisjtMsxBQ9c66qwwfQJ9JWq0/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=EUz0ZvMt; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="EUz0ZvMt"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E24EE88634;
	Wed, 02 Sep 2026 22:46:03 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bT010e45iueF; Wed,  2 Sep 2026 22:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1788381962; bh=2+G26k5CAMyM6qZCC5bAE6nlzBJRz1I84N5Q7MY8NQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EUz0ZvMtdGLTYNc4IBXwCZp/D6ysiW/fdyibv2HfZB1bviUM9txOKxGIRNuBI084o
	 gg6TcPfqdMvPSK2Kc77LnKgdzjnNiXh+96++EUffWRJtl4mz79MMxGILvAnjXMKhBt
	 GbndYRfwikiIUVPP+mbTrGH29i0EzfD1hfn6Gwvruy9XOavJ9Y1AO8aZeDUZjbGhGV
	 lHL9gFp6tRTNCRF71lNshJTCfVIIQltDUe11AnreqbGN1h22g2bLEZrklllFpP03e7
	 tWbLqm4Tp9SVRTg7PfrkCs+f5rlp27czcP7wqV9cOqKe5KZ0FK5MBGU6KX31nCGPrs
	 40l1eB0bm+yAQ==
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
	john.fastabend@gmail.com,
	brianvv@google.com,
	Masoud Aghasi <maghasi@disroot.org>
Subject: [PATCH v2] bpf: Fix u32 overflow issue in map batch operations
Date: Wed,  2 Sep 2026 21:44:39 +0100
Message-ID: <20260902204439.287888-1-maghasi@disroot.org>
In-Reply-To: <317cc6ae-eeb6-4de1-b986-cdbaa16bcc2f@disroot.org>
References: <317cc6ae-eeb6-4de1-b986-cdbaa16bcc2f@disroot.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several map batch operation implementations such as
generic_map_lookup_batch() use calculations in the form of
"values + cp * map->value_size" to compute the desired userspace memory
address for reading or writing. This can overflow the u32 type
(the result of "cp * map->value_size") when the map size exceeds 4GB.

generic_map_lookup_batch() may corrupt values for some keys in
userspace memory, and in some cases it mismatches values for some keys
while still reporting success.

Other batch operations may fail to delete or update some keys,
or the syscall may return unexpected errors.

This patch resolves the mentioned issues by adding size_t casts in the
affected places.

Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")
Fixes: aa2e93b8e58e ("bpf: Add generic support for update and delete batch ops")
Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")

Signed-off-by: Masoud Aghasi <maghasi@disroot.org>
---
v2:
- Fix the additional u32 overflow pointed out by Sashiko bot.
- Simplify the commit message by removing the reproducer program.
- Add all relevant fixes tags to the commit message.

v1: https://lore.kernel.org/bpf/20260824113123.270057-1-maghasi@disroot.org/

 kernel/bpf/hashtab.c |  8 ++++----
 kernel/bpf/syscall.c | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d40cb5dd446c..bd3704ed9333 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1977,10 +1977,10 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 
 	rcu_read_unlock();
 	bpf_enable_instrumentation();
-	if (bucket_cnt && (copy_to_user(ukeys + total * key_size, keys,
-	    key_size * bucket_cnt) ||
-	    copy_to_user(uvalues + total * value_size, values,
-	    value_size * bucket_cnt))) {
+	if (bucket_cnt && (copy_to_user(ukeys + (size_t)total * key_size, keys,
+	    (size_t)key_size * bucket_cnt) ||
+	    copy_to_user(uvalues + (size_t)total * value_size, values,
+	    (size_t)value_size * bucket_cnt))) {
 		ret = -EFAULT;
 		goto after_loop;
 	}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6874ba1424af..731388ae00ad 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2036,7 +2036,7 @@ int generic_map_delete_batch(struct bpf_map *map,
 
 	for (cp = 0; cp < max_count; cp++) {
 		err = -EFAULT;
-		if (copy_from_user(key, keys + cp * map->key_size,
+		if (copy_from_user(key, keys + (size_t)cp * map->key_size,
 				   map->key_size))
 			break;
 
@@ -2098,9 +2098,9 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 
 	for (cp = 0; cp < max_count; cp++) {
 		err = -EFAULT;
-		if (copy_from_user(key, keys + cp * map->key_size,
+		if (copy_from_user(key, keys + (size_t)cp * map->key_size,
 		    map->key_size) ||
-		    copy_from_user(value, values + cp * value_size, value_size))
+		    copy_from_user(value, values + (size_t)cp * value_size, value_size))
 			break;
 
 		err = bpf_map_update_value(map, map_file, key, value,
@@ -2179,12 +2179,12 @@ int generic_map_lookup_batch(struct bpf_map *map,
 		if (err)
 			goto free_buf;
 
-		if (copy_to_user(keys + cp * map->key_size, key,
+		if (copy_to_user(keys + (size_t)cp * map->key_size, key,
 				 map->key_size)) {
 			err = -EFAULT;
 			goto free_buf;
 		}
-		if (copy_to_user(values + cp * value_size, value, value_size)) {
+		if (copy_to_user(values + (size_t)cp * value_size, value, value_size)) {
 			err = -EFAULT;
 			goto free_buf;
 		}
-- 
2.47.3

