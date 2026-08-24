Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB9240DB4B
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571164; cv=none; b=f73ohtOl8c40Gfsu+Kh2PHL/gkong0RxHYA6Cs9iRSdniHzIsRhNDdtTnqSY8OmoqyJb028ER1MsLKl40ZXIWJQXiV8ZjYCXbePBVi3RlgA40X3GGG1cbg/NIZvliqVRBa5FgQRmffb47c8Yu85GHTn/Vjf38pMztJacacA9yKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571164; c=relaxed/simple;
	bh=e1MwQCdukYPF2RpiHvdiAEc0gae2oi7F6gOv1HcqQPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rAKomMfUH+JH7Dy7MrQy2rpIz/12piHCnVzrjTnMJxwzQ7WPuGKjdIHYhR0wPfmX0E2LhmKYUZFMq17lz6owj3IbseFrs2AgM7gfW72CQ0QRr/8w98vP5XYkc2UrXUnuu3hZN6qniOxvxHa41x7574KLhPlZflMZlKP5Lpb70u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=cQThDxbF; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="cQThDxbF"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 509E887E25;
	Mon, 24 Aug 2026 13:32:33 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 73jJzrMQKmyq; Mon, 24 Aug 2026 13:32:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1787571152; bh=e1MwQCdukYPF2RpiHvdiAEc0gae2oi7F6gOv1HcqQPE=;
	h=From:To:Cc:Subject:Date;
	b=cQThDxbFmxKMUfXrhhFfGTv2VlWF+w/jEaP9qsLsDquODKze7F3Wb+44gMWE0fTtf
	 W96z4zxctIa7lf1UJf3Aifb/YWmHNtAheED9F+iss0cvNJKxc1R9IgHx4NDuduwrn3
	 8do/MxS8F+F/gAyK7cBMTTR5dRGT6ZA/i/HuRp4cJXIXxXdM9IY2INoiaThoIXl2c5
	 UVzR5ZviuhfyTlnHBS7WXEyR0OaKNFgIxryz8dSPE1qD87tRT8cHP+mVzM5HEcENzw
	 +M5phHJgJB5EndAJRrCFGFmQiSjX8uw2A6NO53mDpX3khg4c0pA9/NMyD03CegL75P
	 Cb1r/1gIlkfLg==
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
Subject: [PATCH] bpf: Fix u32 overflow issue in map batch operations
Date: Mon, 24 Aug 2026 12:31:23 +0100
Message-ID: <20260824113123.270057-1-maghasi@disroot.org>
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

This patch resolves the mentioned issues by converting the cp's type
to size_t in the effected places.

I created a BPF and a userspace C program to demonstrate the issue.
Example BPF program:
```c

struct my_value {
  char buf[0x10000000];
};

struct {
  __uint(type, BPF_MAP_TYPE_ARRAY);
  __uint(max_entries, 17);
  __type(key, int);
  __type(value, struct my_value);
} map SEC(".maps");

char LICENSE[] SEC("license") = "GPL";
```

Example userspace program:
```c

int main(int argc, char *argv[]) {
  struct bpf_object *obj;
  char filename[256];
  int err, ret = 0;
  struct bpf_map *map;
  int map_fd;
  const __u64 max_entries = 17;
  const __u64 value_size = 0x10000000; // 256MB
  char *values, *keys;
  __u32 count, out_batch;

  if (argc != 2) {
    printf("Usage: %s [bpf_prog.o]", argv[0]);
    return EXIT_FAILURE;
  }

  snprintf(filename, sizeof(filename), "%s", argv[1]);
  obj = bpf_object__open(filename);
  if (libbpf_get_error(obj)) {
    printf("BPF open failed!\n");
    return EXIT_FAILURE;
  }

  values = calloc(max_entries, value_size);
  if (!values) {
    printf("calloc values failed!\n");
    goto err_out;
  }

  keys = calloc(max_entries, sizeof(__u32));
  if (!keys) {
    printf("calloc keys failed!\n");
    goto err_out;
  }

  err = bpf_object__load(obj);
  if (err) {
    printf("BPF load failed! err:%d\n", err);
    goto err_out;
  }

  map = bpf_object__find_map_by_name(obj, "map");
  if (!map) {
    printf("map not found!\n");
    goto err_out;
  }

  map_fd = bpf_map__fd(map);
  if (map_fd < 0) {
    printf("invalid map FD!\n");
    goto err_out;
  }

  __u32 key;
  for (__u64 i = 0; i < max_entries; i++) {
    memset(values + (i * value_size), i & 0xFF, value_size);
    key = i;
    err = bpf_map_update_elem(map_fd, &key, values + (i * value_size), BPF_ANY);
    if (err) {
      printf("bpf_map_update_elem failed: %d\n", err);
      goto err_out;
    }
  }

  count = max_entries;
  err = bpf_map_lookup_batch(map_fd, NULL, &out_batch, keys, values, &count,
                             NULL);
  if (err) {
    printf("bpf_map_lookup_batch failed: %d\n", err);
    goto err_out;
  }

  printf("count: %u, out_batch: %u\n", count, out_batch);

  for (__u64 i = 0; i < max_entries; i++) {
    for (__u64 j = 0; j < value_size; j++) {
      if (values[(i * value_size) + j] != (unsigned char)(i & 0xFF)) {
        printf("Invalid map entry, key: %u, value: %hhu, i: %llu, j: %llu\n",
               *(((__u32 *)keys) + i), values[(i * value_size) + j], i, j);
        goto err_out;
      }
    }
  }

  printf("Finished with no errors!\n");
  ret = EXIT_SUCCESS;
  goto out;

err_out:
  ret = EXIT_FAILURE;

out:
  bpf_object__close(obj);
  if (values)
    free(values);
  if (keys)
    free(keys);
  return ret;
}
```

The test needs enough free memory (around 14GB for the total system).
The key/value mismatch occurs when max_entries is 17 and value_size
is 0x10000000 (256MB). Reducing max_entries to 16 eliminates the issue.

Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")

Signed-off-by: Masoud Aghasi <maghasi@disroot.org>
---
 kernel/bpf/hashtab.c |  4 ++--
 kernel/bpf/syscall.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d40cb5dd446c..384319aa9177 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1977,9 +1977,9 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 
 	rcu_read_unlock();
 	bpf_enable_instrumentation();
-	if (bucket_cnt && (copy_to_user(ukeys + total * key_size, keys,
+	if (bucket_cnt && (copy_to_user(ukeys + (size_t)total * key_size, keys,
 	    key_size * bucket_cnt) ||
-	    copy_to_user(uvalues + total * value_size, values,
+	    copy_to_user(uvalues + (size_t)total * value_size, values,
 	    value_size * bucket_cnt))) {
 		ret = -EFAULT;
 		goto after_loop;
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

