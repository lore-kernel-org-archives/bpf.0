Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566AB3D7D6F
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326173; cv=none; b=L4tV5Bly3dS3ppYPuHvUyDy14h5CRZ5ui0yPGbmjTaaA1rynB0XbdhNSgOdopUQhz469OAq4tHS+JXbIm73+7fzsOrXH8N6CIZ+lcisafuLfZTOVXxC4XL1YJKJnmGvoUE4gHRzywzw56wNFBAtwMpMLqxHbIMtD+2INPEqoABk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326173; c=relaxed/simple;
	bh=bUznUtsdqlGv3f289tTLOITdy2kKCgiWjbjPQz+tpXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk4y5SaKMpRm9vUNWePIGiLNp7C+Gjexo8p+QBMyo+sU22+1XuYaKTWoJPBrIx4UQXb2Je8Y0US5F7tu5JPnXbMLGLzEA0xxVwjR5TdAcCAtuFOV5fQ4GKAU8CzKCQ5LjzwimF9GBZTGtI74qmW357ithANwYyMgMqYFdpU/IZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MQfkNwP9; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MQfkNwP9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=STWODVaRioFdCVCW9aSassZEPHyloQo0UvCRxkiz93o=; b=MQfkNwP9PZfk2wwhD07q3OH3iQ
	7dfcC6WfMafk8t+K+bOtWLouPumrBAIK3Rgb69v+TPEAHRjbIuzSqSYbIiKwOu3zrYY1bJ/2032WA
	TNKSeDbq0L0oM9oXY6/zqGEwOsfeJW4nklXKj7fisKo5MiYSrFtPXnriez96yFueGcQmg1Dra7jwQ
	WSeLiMg+HdjMTO+vIdFLaCZlGr5xZg7C2HHmS9Gq1pYqNzRqtu6AoocT9GTOuj15nx0/3onb68dAY
	ZqPkQ/X+jfro9tVk24Sdo3aMvIObfQaB13eahFvolGROieOZ/glqtxJRLbm8LykYuK2h3Z9EL5kG/
	EfS44bFg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wU4AE-000GWE-28;
	Mon, 01 Jun 2026 17:02:50 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	kpsingh@kernel.org
Subject: [PATCH bpf-next v2 2/7] bpf: Drop redundant hash_buf from map_get_hash operation
Date: Mon,  1 Jun 2026 17:02:43 +0200
Message-ID: <20260601150248.394863-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601150248.394863-1-daniel@iogearbox.net>
References: <20260601150248.394863-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28018/Mon Jun  1 08:31:13 2026)

bpf_map_get_info_by_fd() is the only caller of the ->map_get_hash
and always invokes it with hash_buf == map->sha and hash_buf_size
of SHA256_DIGEST_SIZE. array_map_get_hash() in turn lets sha256()
write the digest directly into that buffer (map->sha) and then
performs a trailing memcpy(), which evaluates to memcpy(map->sha,
map->sha, 32): a redundant self-copy. The hash_buf_size argument
was never used at all. Simplify this a bit, no functional change.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf.h   | 2 +-
 kernel/bpf/arraymap.c | 6 ++----
 kernel/bpf/syscall.c  | 8 +++-----
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1c6863ce89e0..d69cba55f30f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -111,7 +111,7 @@ struct bpf_map_ops {
 	long (*map_pop_elem)(struct bpf_map *map, void *value);
 	long (*map_peek_elem)(struct bpf_map *map, void *value);
 	void *(*map_lookup_percpu_elem)(struct bpf_map *map, void *key, u32 cpu);
-	int (*map_get_hash)(struct bpf_map *map, u32 hash_buf_size, void *hash_buf);
+	int (*map_get_hash)(struct bpf_map *map);
 
 	/* funcs called by prog_array and perf_event_array map */
 	void *(*map_fd_get_ptr)(struct bpf_map *map, struct file *map_file,
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index dfb2110ab733..e6271a2bf6d6 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -175,14 +175,12 @@ static void *array_map_lookup_elem(struct bpf_map *map, void *key)
 	return array->value + (u64)array->elem_size * (index & array->index_mask);
 }
 
-static int array_map_get_hash(struct bpf_map *map, u32 hash_buf_size,
-			       void *hash_buf)
+static int array_map_get_hash(struct bpf_map *map)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 
 	sha256(array->value, (u64)array->elem_size * array->map.max_entries,
-	       hash_buf);
-	memcpy(array->map.sha, hash_buf, sizeof(array->map.sha));
+	       array->map.sha);
 	return 0;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2aafd2131983..a27fa2b9b405 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5434,18 +5434,16 @@ static int bpf_map_get_info_by_fd(struct file *file,
 
 		if (!map->ops->map_get_hash)
 			return -EINVAL;
-
-		if (info.hash_size != SHA256_DIGEST_SIZE)
+		if (info.hash_size != sizeof(map->sha))
 			return -EINVAL;
-
 		if (!READ_ONCE(map->frozen))
 			return -EPERM;
 
-		err = map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, map->sha);
+		err = map->ops->map_get_hash(map);
 		if (err != 0)
 			return err;
 
-		if (copy_to_user(uhash, map->sha, SHA256_DIGEST_SIZE) != 0)
+		if (copy_to_user(uhash, map->sha, sizeof(map->sha)) != 0)
 			return -EFAULT;
 	} else if (info.hash_size) {
 		return -EINVAL;
-- 
2.43.0

