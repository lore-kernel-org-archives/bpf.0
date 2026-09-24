Received: from out-utut-a192.jellyfish.systems (out-utut-a192.jellyfish.systems [198.177.127.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5144F415F15
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.177.127.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267674; cv=none; b=mv8ZmqeSskhkG6MMC2J+nAC61q5Do+j5UpDPa0lkh1zhu4n9lXMdvDLI1EGxtbudni58w6Wnx5KTjpAtZUPt6BMibFvYBHFo/ViXOVRPqluKK3iv5NHilmW6HJF3SYN9LOYSIHft2RmZ441j/nY1qvT80VaivFuQ+TtadeKAJr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267674; c=relaxed/simple;
	bh=rhtN+i6en60AYLiQreOaN7a61SqvIEM7BT2YT/OyIn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPBK0gqGoir2cBe8SjthV78XRuNsKHmggvskc15JCfkZWkGYVqwtlWqdIbqrWmZPHIQcVnXftge2HXFyhB4QIchjzjpXfN++87YPiwS1yul9AwjJ9kus/hIx0r4r2a38MpWU1fcFsAW0EqTjBvRL5yDoCWfK+2eclhquFcA9UV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=k4v/3Gp4; arc=none smtp.client-ip=198.177.127.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="k4v/3Gp4"
Received: from fedora (unknown [124.160.34.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hrKD80dpTz2xBB;
	Thu, 24 Sep 2026 16:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790267659;
	bh=3i27VWm1VbklNNEd2kUJT4/e3/U7fcLrjkkOBYnHGIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k4v/3Gp4Wx9mBjLUr3SEPu1O8PjHOjh6JJ78Olza7k65wp8bwnFAtaGqFrUC1NQnu
	 nkVNRUbvKTA/KD/40lku8kef8jkxOri/P9sbr5GkxBAx7UdRimCKyr4oj7RHsGUJiE
	 vG2BnFFwTVWI/UdRACbwReiM5cKOyy8NzpI0iW9/POYQxDP8vrElZmHkoo7HFagliw
	 m4BqKIiHirDFfC4ZRXYc1oB686Wzt6fGKHPKYMJ7iLKVm6AnMvYuTmLs5wS32h/zwd
	 Daq3jy5aovTpjqU92/XypdKyCN5podAWr/mFQ62b1TpmYzifGswdGcMu1aEGJyPFcz
	 pEng5u2hN4n7A==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 1/2] bpftool: Use batch lookups for bounded hash map dumps
Date: Fri, 25 Sep 2026 01:34:02 +0900
Message-ID: <20260924163403.203491-2-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924163403.203491-1-hi@tychen.cc>
References: <20260924163403.203491-1-hi@tychen.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Use BPF_MAP_LOOKUP_BATCH when dumping hash maps to reduce the number
of BPF syscalls while preserving plain, JSON and BTF formatting.

Compare against the unpatched base using a populated 100,000-entry hash
map with 4-byte keys and values, with stdout redirected to /dev/null.
In an x86-64 KVM guest running Linux 7.2.5, both builds use GCC 16.2.1
and run on one vCPU. After two warm-ups per binary and output mode,
alternate baseline and patched runs for 15 untraced samples each:

                 baseline       batch       elapsed-time reduction
  plain          88.165 ms      54.951 ms    37.7%
  JSON           81.973 ms      48.216 ms    41.2%

These are median wall times, including process startup and formatting.
Separately, strace counts 200,004 versus 395 BPF syscalls for the plain
dump. Complete JSON output is identical for this map. These results are
specific to this fixture and guest, not a general speedup guarantee.

Hash batch lookup must fit an entire bucket. Restrict eligibility to
maps whose maximum key/value storage fits in 4 MiB, so even a worst-case
bucket can fit without restarting a partially printed dump. Start with
up to 256 entries and grow on ENOSPC using the same input cursor.

Fall back to individual lookups only when the initial batch operation
is unsupported. Restarting after output has begun would duplicate
entries. Process the final partial batch on ENOENT, but do not trust
count or output buffers after other errors. Keep fatal diagnostics on
stderr so JSON element arrays contain only map entries.

Link: https://github.com/libbpf/bpftool/issues/63

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 tools/bpf/bpftool/map.c | 117 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 109 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 20d59eab09a1..b12c06a6f755 100644
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
@@ -763,10 +758,112 @@ static int dump_map_elem(int fd, void *key, void *value,
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
+/* Return MAP_DUMP_BATCH_FALLBACK only before batch traversal starts. */
+static int dump_map_batch(int fd, void *key, void *value,
+			  struct bpf_map_info *info, struct btf *btf,
+			  json_writer_t *wtr, unsigned int *num_elems)
+{
+	__u32 capacity, count, batch = 0, next_batch = 0, i;
+	void *keys = NULL, *values = NULL, *buf;
+	bool first = true, can_fallback = true;
+	int err;
+
+	/*
+	 * Hash lookup batches must accommodate a whole bucket. Restrict the
+	 * optimization to maps whose worst-case bucket fits the memory budget,
+	 * so a later ENOSPC never forces a restart after printing some entries.
+	 * Division also bounds the allocation multiplications on 32-bit hosts.
+	 */
+	if (info->type != BPF_MAP_TYPE_HASH || !info->max_entries ||
+	    (__u64)info->key_size + info->value_size >
+	    MAP_DUMP_BATCH_MAX_BYTES / info->max_entries)
+		return MAP_DUMP_BATCH_FALLBACK;
+
+	capacity = min(info->max_entries, MAP_DUMP_BATCH_SIZE);
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
+		 * inspect the buffers on these errors, or fall back after progress.
+		 */
+		if (can_fallback && (err == EINVAL || err == EOPNOTSUPP ||
+				     err == 524 /* ENOTSUPP */)) {
+			err = MAP_DUMP_BATCH_FALLBACK;
+			goto out;
+		}
+		can_fallback = false;
+		if (err == ENOSPC) {
+			if (capacity == info->max_entries)
+				goto error;
+			capacity += min(capacity, info->max_entries - capacity);
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
@@ -880,6 +977,9 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		p_info("Warning: cannot read values from %s map with value_size != 8",
 		       map_type_str);
 	}
+	err = dump_map_batch(fd, key, value, info, btf, wtr, &num_elems);
+	if (err != MAP_DUMP_BATCH_FALLBACK)
+		goto end_dump;
 	while (true) {
 		err = bpf_map_get_next_key(fd, prev_key, key);
 		if (err) {
@@ -893,6 +993,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		prev_key = key;
 	}
 
+end_dump:
 	if (wtr) {
 		jsonw_end_array(wtr);	/* elements */
 		if (show_header)
-- 
2.55.0

