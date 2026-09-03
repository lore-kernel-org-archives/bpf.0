Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841F43CE6D
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424123; cv=none; b=RhA5WasWS76s/nhLMpCG/8HnTt3rgviePWfbLf1j9+dZq4nxlF/WwW5J3MqAQKfqptksJXA4ZYCp6a4dzGIUL8QAJ+yVCPNK6AN51Zut4wEfSfXExhFJbICWvCn7KRxWVps863b7rcsMGY/WyqmaRuCX+Pqlt6rZO6vP4UXdcxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424123; c=relaxed/simple;
	bh=LapsRDyuHDDEeVRPjufP+HuLMUW9oyH/4jZueZEUj7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqfcU7JwBOUjlroDuJfCjWjSPuAXDhPfQMle110ZmcThnW4MZTIVGIA+z5rppa4gfguR3Qvg7/CmRNVpgOUIN/5NLSRCZLjN0gLsH+lnaLo7LgBr8ZhHP/fvlISOJ+cwtV6QhYnDVqcK+vYDuYlWWNSWiSnmzCQfv87alASxumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Q9pwMoA2; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Q9pwMoA2"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id AAC3D88779;
	Thu, 03 Sep 2026 10:28:38 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lZUZkJcunvZO; Thu,  3 Sep 2026 10:28:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1788424117; bh=LapsRDyuHDDEeVRPjufP+HuLMUW9oyH/4jZueZEUj7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q9pwMoA2UlSrTtSWKbfgXUkW8jLoytPUftSjqLX3klY4RK8GCLOHfWt14DBe0En5P
	 m5ytYOomYjAcVxo1Ko3k4C8Yj+s69rGQPDiZnsaLa6T3QmWB2XZupJw94oxvyxk+jz
	 SRg4Ln371eql2E9qmZ1NbxjkTtDTW0IM9HqTuRwiMfVuUOfdhaOCXrHcai9BhCw4QM
	 AKB0+QUl/ZRLgCQkwcPrH4FA4Mh9aMy5fqHhVuZaGqsRq39uwdq1lCrmBztjKkJHCH
	 7HhZnzH4snBZnTA0TL9NyAB+GbsK3giWuKKaxouQue5ZObMoN42lgfmIggcwdDIl5t
	 eql6Kr4V161xw==
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
Subject: [PATCH v3] bpf: Fix u32 overflow issue in map batch operations
Date: Thu,  3 Sep 2026 09:27:34 +0100
Message-ID: <20260903082734.623904-1-maghasi@disroot.org>
In-Reply-To: <20260902204439.287888-1-maghasi@disroot.org>
References: <20260902204439.287888-1-maghasi@disroot.org>
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

Add size_t casts to prevent the affected offset and size calculations
from overflowing.

Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")
Fixes: aa2e93b8e58e ("bpf: Add generic support for update and delete batch ops")
Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
Signed-off-by: Masoud Aghasi <maghasi@disroot.org>
---
v3:
- Reword the commit message to use imperative style.

v2: https://lore.kernel.org/bpf/20260902204439.287888-1-maghasi@disroot.org/
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

