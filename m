Received: from out-2uec-a98.jellyfish.systems (out-2uec-a98.jellyfish.systems [63.250.43.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D93A963A
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714541; cv=none; b=V/HrxrmDhkIMcMRXLH6Hfu4zDcRydsFkaN39BOy4ETnkvMlhjUqlg7mIDceD/+Vy3WY9SkMNVHavtf7GhyjQ/EY/7Le55kDQ/2aRP0VyMyvbuSv5uH4jrxVYsX2/+1xkxDx369WsbzhKzDmqOhNWGYYc+rMkqPldT4gB/nwjt3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714541; c=relaxed/simple;
	bh=dJy8K7QpTEAQGyMtp7rRVTUQldhttr9jIZVdtHql6D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syXtPDIRIWfpXU6OMkkGTzyuUzovt8x+kGz03HH+o9V/PtNMYqwJM6vUpWF55Sn+x1+iMXDkkbzyc4enL2sd4B92UYATSzu2tWy1KRooSFKiIhNE3Ooz4vSSx6gGQ5vduK1kWiT+FXTGBVNbRk+Mybj3Yn4oQHClDwXitOYETNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=d3QRuOHM; arc=none smtp.client-ip=63.250.43.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="d3QRuOHM"
Received: from fedora (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdGr41rpLz8sXJ;
	Sun, 06 Sep 2026 17:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788714523;
	bh=pEaJ0IworLq94kzj0A5eN/+Ym81HOT70PvZyiKxaOOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d3QRuOHM0NXOvHlwAaAO95wMHLjxSgm0qPB5e2lxiCi7mN3VQl2Xk6rCWz6q2+967
	 MKqR/1jQ7jo3nmkL+v2wvoko9roMg3eytXJBqHRl9+qVar4c/nAfSIl4/hf4GmJK5M
	 XmQ7ET70TTMjVJ+HuwEdKdt+4xMBER7Sr8rixLga1LKk3NGHJefE2b6zerGRZZHUg9
	 zCkH03HTRUHocKo5hBLGhtNFAWRqk8Og4jLT3Il6DGc04wvn9cwzAhBWPWCcnErL30
	 ho2zFG1urzQz5LnfDujGOdjdWpuC8Sxp8iBwbC6SKOiFfsXcRj73tQP43Hg51YW2BS
	 nO505y0Q1AW5Q==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpftool: Use batch lookups for bounded hash map dumps
Date: Mon,  7 Sep 2026 01:08:18 +0800
Message-ID: <20260906170819.1212661-2-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906170819.1212661-1-hi@tychen.cc>
References: <20260906170819.1212661-1-hi@tychen.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Use BPF_MAP_LOOKUP_BATCH when dumping hash maps to reduce the number
of BPF syscalls. Share element formatting with individual lookups to
preserve plain, JSON and BTF output.

Start with up to 256 entries and grow on ENOSPC without advancing the
input cursor. Restrict the optimization to maps whose maximum key and
value storage fits in 4 MiB, so even a worst-case bucket can fit without
restarting a partially printed dump. Preserve aligned element buffers
for formatting keys and values with odd sizes.

Fall back to individual lookups only if the initial batch operation is
unsupported. Process the final partial batch on ENOENT, but never use
count or output buffers after other errors. Report errors after batch
traversal starts without restarting and duplicating output.

Assisted-by: Codex:GPT-6
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 tools/bpf/bpftool/map.c | 113 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 105 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 684a8fb7241..1eccdc0d1e9 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -740,15 +740,10 @@ static int do_show(int argc, char **argv)
 	return errno == ENOENT ? 0 : -1;
 }
 
-static int dump_map_elem(int fd, void *key, void *value,
-			 struct bpf_map_info *map_info, struct btf *btf,
-			 json_writer_t *btf_wtr)
+static void print_map_elem(void *key, void *value,
+			   struct bpf_map_info *map_info, struct btf *btf,
+			   json_writer_t *btf_wtr)
 {
-	if (bpf_map_lookup_elem(fd, key, value)) {
-		print_entry_error(map_info, key, errno);
-		return -1;
-	}
-
 	if (json_output) {
 		print_entry_json(map_info, key, value, btf);
 	} else if (btf) {
@@ -762,10 +757,108 @@ static int dump_map_elem(int fd, void *key, void *value,
 	} else {
 		print_entry_plain(map_info, key, value);
 	}
+}
+
+static int dump_map_elem(int fd, void *key, void *value,
+			 struct bpf_map_info *map_info, struct btf *btf,
+			 json_writer_t *btf_wtr)
+{
+	if (bpf_map_lookup_elem(fd, key, value)) {
+		print_entry_error(map_info, key, errno);
+		return -1;
+	}
 
+	print_map_elem(key, value, map_info, btf, btf_wtr);
 	return 0;
 }
 
+#define MAP_DUMP_BATCH_SIZE 256U
+#define MAP_DUMP_BATCH_MAX_BYTES (4 * 1024 * 1024)
+
+/* Return 1 to use individual lookups, but only before batch traversal starts. */
+static int dump_map_batch(int fd, void *key, void *value,
+			  struct bpf_map_info *info, struct btf *btf,
+			  json_writer_t *wtr, unsigned int *num_elems)
+{
+	__u32 capacity, count, batch = 0, next_batch = 0, i;
+	void *keys = NULL, *values = NULL, *buf;
+	bool first = true, can_fallback = true;
+	int err;
+
+	/* Hash lookup batches must accommodate a whole bucket. Restrict the
+	 * optimization to maps whose worst-case bucket fits the memory budget,
+	 * so a later ENOSPC never forces a restart after printing some entries.
+	 * Division also bounds the allocation multiplications on 32-bit hosts.
+	 */
+	if (info->type != BPF_MAP_TYPE_HASH || !info->max_entries ||
+	    (__u64)info->key_size + info->value_size >
+	    MAP_DUMP_BATCH_MAX_BYTES / info->max_entries)
+		return 1;
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
+		/* Older kernels reject the command before updating count. Do not
+		 * inspect the buffers on these errors, or fall back after progress.
+		 */
+		if (can_fallback && (err == EINVAL || err == EOPNOTSUPP ||
+				     err == 524 /* ENOTSUPP */)) {
+			err = 1;
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
+			/* Keep the alignment provided by individual lookups, including
+			 * for BTF types whose map key/value size is not aligned.
+			 */
+			memcpy(key, keys + (size_t)i * info->key_size, info->key_size);
+			memcpy(value, values + (size_t)i * info->value_size, info->value_size);
+			print_map_elem(key, value, info, btf, wtr);
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
+	p_err("can't lookup map batch: %s", strerror(err));
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
@@ -869,6 +962,9 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		p_info("Warning: cannot read values from %s map with value_size != 8",
 		       map_type_str);
 	}
+	err = dump_map_batch(fd, key, value, info, btf, wtr, &num_elems);
+	if (err != 1)
+		goto end_dump;
 	while (true) {
 		err = bpf_map_get_next_key(fd, prev_key, key);
 		if (err) {
@@ -881,6 +977,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		prev_key = key;
 	}
 
+end_dump:
 	if (wtr) {
 		jsonw_end_array(wtr);	/* elements */
 		if (show_header)
-- 
2.55.0

