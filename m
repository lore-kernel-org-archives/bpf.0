Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.177.127.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732545;
	b=QL+fNJT4u2fwcrmzX5IF5usa8D7OBK0gugfnl17giN+dBEiT9Pw7TFltra2V81plYsmz
	 O9ai9OXdeJHDyz7MWRL9DjXhP/z41PEbhcjCmRA6/934a7laUiTzWT99OT48U/E2xQven
	 d1UK7dk/is4k2gYRYkgi+ctTktUC8UPH871bwnt/k/dt+v+ufiG5x/xCSOxHshWhfT5OQ
	 7OCpG0AVybK80oqSmBH+nGlLhw3Zp3HAtIfxvYiQRdmvuDudabTJZgYfNvwrkHX3ynmMW
	 ofnDShrrpyRfap3cTbPYj5UIijO6uViFDov4JfGHkT+744+6WIHRoUv7zJIjjfdShxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732545;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:In-Reply-To:
	 References:From:Date:Subject:To:Cc:X-Envelope-From;
	bh=A0NXQigfG7o2z/nsemmVGXh5yUv0thm9WI5A+OfJ4Bs=;
	b=SLhRsWtHFDMXyC884K5X7BSNXkFLpCWhQKKyRA7B155Xqp/ivMWkGp4F2PxVDKAL6gwX
	 SpuLGkNcdu+xbRDW8H4Jyqnd8kQWkYbMnI6HbJUHLV1aZ2VCrlIJ5qlAFolPw93/0qWaR
	 YoypFQL/lrUe0IEqWFZctBxK1Pj8Fror4FoBEHF8wG5N5EJeQVT9SqMjYo1DQ9pLtNTk7
	 tEnEW5c8aVz2xRMbbTS8/jg8JwT3zw9Xu9W+M0WJrmBoEU7Qcc0nXPEaccE4/3s643tXr
	 6zffNlbWxUp2Tamy6Cib/VJz/wXwSDdKGO2Ox25lqBbtqeK1fZYJXkaRzrR1Ab/PtXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=fzhB2h6c;
	arc=none smtp.remote-ip=198.177.127.221
Received: from out-utut-a221.jellyfish.systems (out-utut-a221.jellyfish.systems [198.177.127.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB7C606A329
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 19:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAB7C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=fzhB2h6c
Received: from [10.18.116.108] (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jJyc30S1hz8sWP;
	Tue, 03 Nov 2026 19:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1793732518;
	bh=A0NXQigfG7o2z/nsemmVGXh5yUv0thm9WI5A+OfJ4Bs=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=fzhB2h6cHwH/RV5U9GR/dEUxiegfhoGe4+mRDpgS8NVB8S33ElTraayGXEikFJvX7
	 8NO/y/7V9Piw9K9Ws3exXynmq9stQhp+wQN++FKGIi9RR+BEECF681BUhTBlPJtu2/
	 AyrgIKsXR+t9r7ZLz+OOY5PeHe5QDZzHfkfC2/I3a6vpsZq/tYiL2UdOgZgvQ+j9KS
	 dy6ypTy94uijALoMDaiX49mN01w0WFYT4Xx3NbJJttxy+1q4V3qCdcnm0SHHcOKS1b
	 zU7URtHu5HFv1k2QIMfZ/m1Sed+maK5A1DHQp3YiOQzhUOocmb29trV8nDuN2mmfqJ
	 A9HcAklm6A8Nw==
Message-ID: <a107a124d50c11a6d26363acce98e5e3b8377155.1793732386.git.hi@tychen.cc>
In-Reply-To: <cover.1793732386.git.hi@tychen.cc>
References: <cover.1793732386.git.hi@tychen.cc>
From: Tianyi Chen <hi@tychen.cc>
Date: Wed, 04 Nov 2026 04:01:54 +0900
Subject: [PATCH bpf-next v7 1/2] bpftool: Use batch lookups for hash map dumps
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
    andrii@kernel.org,
    eddyz87@gmail.com,
    ihor.solodrai@linux.dev,
    linux-kselftest@vger.kernel.org,
    daniel@iogearbox.net,
    ast@kernel.org,
    hi@tychen.cc
X-Envelope-From: hi@tychen.cc
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Use BPF_MAP_LOOKUP_BATCH for ordinary hash maps to reduce BPF syscalls
while preserving plain, JSON and BTF output.

Bound the combined key/value buffers to 4 MiB. Start with up to 256
entries and grow on ENOSPC using the same input cursor. At the buffer
limit, continue individual lookups from the last emitted key without
restarting output. Also fall back if the initial batch is unsupported.

Process the final partial batch on ENOENT, but do not read output buffers
on other errors. Keep fatal diagnostics on stderr so JSON arrays contain
only map entries. Traversal remains non-atomic.

For a 100,000-entry map with 4-byte keys and values, median wall times
with stdout redirected to /dev/null were:

               baseline       batch
  plain        87.460 ms      55.677 ms
  JSON         78.495 ms      47.157 ms

Both builds used GCC 16.2.1 in an x86-64 KVM guest running
7.3.0-4.cachyos1.fc44.x86_64, pinned to one guest CPU. After two warm-ups,
15 untraced samples per binary and mode alternated baseline and patched
runs. Separate strace runs counted 200,005 versus 396 BPF syscalls for a
plain dump. These results are specific to this fixture and guest.

Link: https://github.com/libbpf/bpftool/issues/63
Acked-by: Quentin Monnet <qmo@kernel.org>
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 tools/bpf/bpftool/map.c | 123 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 4b65edf74859b..fdd32cd40709b 100644
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
+				    err == 524 /* ENOTSUPP */)) {
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
+	fprintf(stderr, "Error: can't lookup map batch: %s\n", bpf_strerror(err));
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
@@ -895,6 +993,14 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
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
@@ -911,6 +1017,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		prev_key = key;
 	}
 
+end_dump:
 	if (wtr) {
 		jsonw_end_array(wtr);	/* elements */
 		if (show_header)
-- 
2.56.0

