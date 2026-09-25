Received: from out-2uec-a116.jellyfish.systems (out-2uec-a116.jellyfish.systems [63.250.43.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1234B4026
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358291; cv=none; b=aXd+2b4Ce+h37YuUBprCxFRnvau1ySNWM14xBLq5m6rqJzsBoj6iJW4YIGdV1SHuqePynfxkq2oTzCRuBH3uPojxptTj+C+XNODb2SBx9Awvl2ZHKAUhYLc3zn1rENagHpgvX9t1Cf/ko7GXX0xqld7gXh4Uj9EJPTaDe0TvPZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358291; c=relaxed/simple;
	bh=Mpe2+MnvynNvvXOGyTAnTjspIyfD/u8fOGC6+yCgdvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPMDNcbWzTJ8uviDPQwCI7suywGu/FPTJZSfO3lnkayr1jSpEsS6FRwLTkhocLjvvhQMbLueY96xCM8ThUD9+NWTyFiuotby0dLT7HQIaS9YUgMUdwz0qBdTM4Z8Xio6gXpU+A0MGU+bzcYn+q4+4rFX7HX6GxBpPu1Nj4HaVfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=c9zWya0v; arc=none smtp.client-ip=63.250.43.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="c9zWya0v"
Received: from 192.168.50.46 (unknown [114.92.81.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hrykW2VL4z2xFY;
	Fri, 25 Sep 2026 17:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790358263;
	bh=XlyIijP6eelkujcES0j/mMHA4XzxLMpM+aS6x9+dyAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c9zWya0vzA2bcCtam6iNOXTTZ8z4Ryu5O9prV7smMR9HL6Ax7rgSZVtMCPu7l6LZ2
	 jDo+csA5Pd8ndf2SvCYQ/jUqzk6MvBCST157K5wQ53jngw5YhiZAJalzP3LKEIbpd1
	 dPQD/o1OmQLYuTtXFPFdNSPemVA7xRYEqrSX3+ek60smGdvdayIepuvxpc9WJPTWCI
	 lEHQKEAAVP9wg0PY5qEVywtVVp3wZXGjYP4uZQSHapmfCkBXG5MBZ1zUiPYH4z+V9b
	 qbBxGV4t1JuMErznvjchyDr4Y+BjQpiKFhfLDq5mgEBcGrT47X6e1YUZjPsQ5pm++Z
	 GpDp9l0XCHv5g==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v6 1/2] bpftool: Use batch lookups for hash map dumps
Date: Sat, 26 Sep 2026 02:44:11 +0900
Message-ID: <20260925174412.2028749-2-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925174412.2028749-1-hi@tychen.cc>
References: <20260925174412.2028749-1-hi@tychen.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Use BPF_MAP_LOOKUP_BATCH when dumping ordinary hash maps to reduce BPF
syscalls while preserving plain, JSON and BTF formatting.

Compare against the unpatched base using a populated 100,000-entry hash
map with 4-byte keys and values, with stdout redirected to /dev/null.
In an x86-64 KVM guest running Linux 7.2.5, both builds use GCC 16.2.1
and run on one vCPU. After two warm-ups per binary and output mode,
alternate baseline and patched runs for 15 untraced samples each:

                 baseline       batch       elapsed-time reduction
  plain          87.043 ms      54.631 ms    37.2%
  JSON           80.707 ms      47.844 ms    40.7%

These are median wall times, including process startup and formatting.
Separately, strace counts 200,004 versus 395 BPF syscalls for the plain
dump. These results are specific to this fixture and guest.

Limit the combined key/value batch buffers to 4 MiB rather than limiting
the map's maximum capacity. Start with up to 256 entries and grow on
ENOSPC using the same input cursor. If a bucket cannot fit at the buffer
limit, continue individual lookups from the last emitted key, or from
the beginning if nothing was emitted. This retains the existing
non-atomic traversal semantics without restarting completed output.

Fall back from an unsupported initial batch operation as well. Process
the final partial batch on ENOENT, but do not trust output buffers after
other errors. Keep fatal diagnostics on stderr so JSON element arrays
contain only map entries.

Link: https://github.com/libbpf/bpftool/issues/63

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 tools/bpf/bpftool/map.c | 123 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 20d59eab09a1..3147e3c4b8c6 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -741,15 +741,10 @@ static int do_show(int argc, char **argv)
 	return errno == ENOENT ? 0 : -1;
 }
 
-static int dump_map_elem(int fd, void *key, void *value,
-			 struct bpf_map_info *map_info, struct btf *btf,
-			 json_writer_t *btf_wtr, const int *cpu_ids, int cpu_cnt)
+static void print_map_elem(void *key, void *value,
+			   struct bpf_map_info *map_info, struct btf *btf,
+			   json_writer_t *btf_wtr, const int *cpu_ids, int cpu_cnt)
 {
-	if (bpf_map_lookup_elem(fd, key, value)) {
-		print_entry_error(map_info, key, errno);
-		return -1;
-	}
-
 	if (json_output) {
 		print_entry_json(map_info, key, value, btf, cpu_ids, cpu_cnt);
 	} else if (btf) {
@@ -763,10 +758,113 @@ static int dump_map_elem(int fd, void *key, void *value,
 	} else {
 		print_entry_plain(map_info, key, value, cpu_ids, cpu_cnt);
 	}
+}
+
+static int dump_map_elem(int fd, void *key, void *value,
+			 struct bpf_map_info *map_info, struct btf *btf,
+			 json_writer_t *btf_wtr, const int *cpu_ids, int cpu_cnt)
+{
+	if (bpf_map_lookup_elem(fd, key, value)) {
+		print_entry_error(map_info, key, errno);
+		return -1;
+	}
 
+	print_map_elem(key, value, map_info, btf, btf_wtr, cpu_ids, cpu_cnt);
 	return 0;
 }
 
+#define MAP_DUMP_BATCH_FALLBACK 1
+#define MAP_DUMP_BATCH_SIZE 256U
+#define MAP_DUMP_BATCH_MAX_BYTES (4 * 1024 * 1024)
+
+static bool map_dump_can_batch(const struct bpf_map_info *info)
+{
+	return info->type == BPF_MAP_TYPE_HASH && info->max_entries &&
+	       (__u64)info->key_size + info->value_size <= MAP_DUMP_BATCH_MAX_BYTES;
+}
+
+/* Return MAP_DUMP_BATCH_FALLBACK to continue with individual lookups. */
+static int dump_map_batch(int fd, void *key, void *value,
+			  struct bpf_map_info *info, struct btf *btf,
+			  json_writer_t *wtr, unsigned int *num_elems)
+{
+	/* HASH batch cursors are u32 bucket indices, independent of key size. */
+	__u32 batch = 0, next_batch = 0;
+	__u32 capacity, max_capacity, count, i;
+	void *keys = NULL, *values = NULL, *buf;
+	bool first = true, can_restart = true;
+	int err;
+
+	max_capacity = MAP_DUMP_BATCH_MAX_BYTES / (info->key_size + info->value_size);
+	max_capacity = min(max_capacity, info->max_entries);
+	capacity = min(max_capacity, MAP_DUMP_BATCH_SIZE);
+resize:
+	buf = realloc(keys, (size_t)capacity * info->key_size);
+	if (!buf) {
+		err = ENOMEM;
+		goto error;
+	}
+	keys = buf;
+	buf = realloc(values, (size_t)capacity * info->value_size);
+	if (!buf) {
+		err = ENOMEM;
+		goto error;
+	}
+	values = buf;
+
+	while (true) {
+		count = capacity;
+		err = bpf_map_lookup_batch(fd, first ? NULL : &batch,
+					   &next_batch, keys, values, &count, NULL);
+		err = err ? errno : 0;
+		/*
+		 * Older kernels reject the command before updating count. Do not
+		 * inspect the buffers on these errors, or restart after progress.
+		 */
+		if (can_restart && (err == EINVAL || err == EOPNOTSUPP ||
+				     err == 524 /* ENOTSUPP */)) {
+			err = MAP_DUMP_BATCH_FALLBACK;
+			goto out;
+		}
+		can_restart = false;
+		if (err == ENOSPC) {
+			if (capacity == max_capacity) {
+				err = MAP_DUMP_BATCH_FALLBACK;
+				goto out;
+			}
+			capacity += min(capacity, max_capacity - capacity);
+			/* Preserve the input cursor: the oversized bucket was not read. */
+			goto resize;
+		}
+		/* In particular, EFAULT can leave count and the buffers invalid. */
+		if (err && err != ENOENT)
+			goto error;
+		for (i = 0; i < count; i++) {
+			/*
+			 * Keep the alignment provided by individual lookups, including
+			 * for BTF types whose map key/value size is not aligned.
+			 */
+			memcpy(key, keys + (size_t)i * info->key_size, info->key_size);
+			memcpy(value, values + (size_t)i * info->value_size, info->value_size);
+			print_map_elem(key, value, info, btf, wtr, NULL, 0);
+			(*num_elems)++;
+		}
+		if (err == ENOENT) {
+			err = 0;
+			goto out;
+		}
+		first = false;
+		batch = next_batch;
+	}
+error:
+	fprintf(stderr, "Error: can't lookup map batch: %s\n", strerror(err));
+	err = -1;
+out:
+	free(keys);
+	free(values);
+	return err;
+}
+
 static int maps_have_btf(int *fds, int nb_fds)
 {
 	struct bpf_map_info info = {};
@@ -880,6 +978,14 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		p_info("Warning: cannot read values from %s map with value_size != 8",
 		       map_type_str);
 	}
+	if (map_dump_can_batch(info)) {
+		err = dump_map_batch(fd, key, value, info, btf, wtr, &num_elems);
+		if (err != MAP_DUMP_BATCH_FALLBACK)
+			goto end_dump;
+		/* Continue after the last emitted key rather than restarting. */
+		if (num_elems)
+			prev_key = key;
+	}
 	while (true) {
 		err = bpf_map_get_next_key(fd, prev_key, key);
 		if (err) {
@@ -893,6 +999,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		prev_key = key;
 	}
 
+end_dump:
 	if (wtr) {
 		jsonw_end_array(wtr);	/* elements */
 		if (show_header)
-- 
2.55.0

