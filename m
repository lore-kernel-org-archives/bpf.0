Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=63.250.43.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818524;
	b=r01JLwDo6/fgHiAStXanGnARXP85dUrotugtmSGAvQ3++o+Dxpv6z2QEmo8dtJhwjvqI
	 pDCdQ52g5cTVhZBLrlNre0zk2w+wy0jHqX8O5pXYKMdPiweUdnvTJWnwPvY5DrMLXO+jE
	 q2Buweof30ZyXF3BU4BgLuEwY1M9T7Sd6aLuqS6Km0+h6B9SFfqySYyBoCeLUM9UOA2n4
	 KkoO3Gh60upa9WyCgXu+ESVldt2Ex5scm3kPTOK8fZDXZjf8nS/dqcT3XlK1Cqd7K9z1z
	 VzJnp8KKhwpDy73DbIkP0TuayZW9Xtmy/lhrb2se2sDV6Jyo7N0DTqr8LEspLiI2naA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818524;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Envelope-From;
	bh=DRYW9LsOkwqorjTVMq50L2691tSj2pAGda8sueNbSfA=;
	b=hO0DtxU6Bzp2NdXu0Ti1Sly6AVCYXRsws9H5SkDH+H3DcGYS4Q7stqKnJAmzK30OfXCa
	 XcEVQaLd5MciZuWQU3vrG6speqxb6XNjcVcP4Z980V7t6xkpTebjbntyvmMoYDkbzzndF
	 iisgmq0/YXWiJi/NTTC0t3RHBUJPo0DTyGzAFPAtIsvcls3cnMGToe7mQty0TznF2vfpl
	 TjQhETJZ+PjDmOgHefDAtVOIbqlX4D5Y3Ly0voTkEkQZsUwR+7vJBndCdpPeu8yGjjSiI
	 o/cZ6RtSy6PIdu/wXxnPokBYGkbvsq4Y3Wd3b2xSB5HqpfH3tfP31Ke4sqp/TKQEAgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=CNSEiBMp;
	arc=none smtp.remote-ip=63.250.43.118
Received: from out-2uec-a118.jellyfish.systems (out-2uec-a118.jellyfish.systems [63.250.43.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FC8606D806
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 18:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47FC8606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=CNSEiBMp
Received: from fedora (ec2-52-197-241-54.ap-northeast-1.compute.amazonaws.com [52.197.241.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jKZPw6vxVz6tkN;
	Wed, 04 Nov 2026 18:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1793818520;
	bh=DRYW9LsOkwqorjTVMq50L2691tSj2pAGda8sueNbSfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNSEiBMpIUDH/JQOCa1wiKQ2Rt3j23XpZ3rTpwWIWxEKtCKwB+ocnvvcFaXDMv4R6
	 cj445Jb7B6poRFgOQ3tHSUpBgFQxD9ocTLmJzXkgzuyGQZz3bz/32/sMoplZXiJKVF
	 eKyLvM3YDtYsnMbIk8DNzRjenrJZ09Hw9Q1lOC/RPXafwDmN/dykxUHvX2a0pcabEf
	 mpyWsjkSJgU+In5MERXl1pLPp8tG8uyB2Prc9jTjA++kNU0Hv7XR184r6/DAbnxrJg
	 4fCj4n4p1IMdQZlGQkMO97Uff5fM7Emsho03jgP66KhIAaIuqjlwI9Ec3kCruCYpvk
	 kzvN4m89OPLQg==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	alexei.starovoitov@gmail.com
Subject: [PATCH bpf-next v8 1/2] bpftool: Use batch lookups for map dumps
Date: Thu,  5 Nov 2026 03:55:03 +0900
Message-ID: <7a728136ad18840c94836ec1ce988f8bc2fcfb35.1793818387.git.hi@tychen.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793818387.git.hi@tychen.cc>
References: <cover.1793818387.git.hi@tychen.cc>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Dumping a map takes two BPF syscalls per element: one to get the next
key and one to look it up. Use BPF_MAP_LOOKUP_BATCH instead, with keys
and values bounded to 1 MiB and per-CPU value strides accounted for.
The output is unchanged.

For a hash map with 100,000 4-byte keys and values, a plain dump takes 5
BPF syscalls instead of 200,005. With output to /dev/null, the median of
15 runs in an x86-64 KVM guest on Linux 7.3 dropped from 86 ms to 52 ms
(JSON: 78 ms to 42 ms). Printing to a terminal dominates either way.

If a batch lookup fails, discard its output and continue with individual
lookups after the last printed key. bpf_map_get_next_key() walks the map
in the same order. This covers maps without batch support, and hash
maps whose bucket lock cannot be taken, which individual lookups do not
need.

Link: https://github.com/libbpf/bpftool/issues/63
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 tools/bpf/bpftool/map.c | 97 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 82 insertions(+), 15 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 4b65edf74859b..c0bd9bf846492 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -59,13 +59,16 @@ static int map_type_from_str(const char *type)
 	return -1;
 }
 
-static void *alloc_value(struct bpf_map_info *info)
+static size_t map_value_size(struct bpf_map_info *info)
 {
 	if (map_is_per_cpu(info->type))
-		return malloc(round_up(info->value_size, 8) *
-			      get_possible_cpus());
-	else
-		return malloc(info->value_size);
+		return (size_t)round_up(info->value_size, 8) * get_possible_cpus();
+	return info->value_size;
+}
+
+static void *alloc_value(struct bpf_map_info *info)
+{
+	return malloc(map_value_size(info));
 }
 
 static int do_dump_btf(const struct btf_dumper *d,
@@ -741,15 +744,10 @@ static int do_show(int argc, char **argv)
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
@@ -763,10 +761,74 @@ static int dump_map_elem(int fd, void *key, void *value,
 	} else {
 		print_entry_plain(map_info, key, value, cpu_ids, cpu_cnt);
 	}
+}
 
+static int dump_map_elem(int fd, void *key, void *value,
+			 struct bpf_map_info *map_info, struct btf *btf,
+			 json_writer_t *btf_wtr, const int *cpu_ids, int cpu_cnt)
+{
+	if (bpf_map_lookup_elem(fd, key, value)) {
+		print_entry_error(map_info, key, errno);
+		return -1;
+	}
+
+	print_map_elem(key, value, map_info, btf, btf_wtr, cpu_ids, cpu_cnt);
 	return 0;
 }
 
+#define MAP_DUMP_BATCH_BYTES (1U << 20)
+
+/*
+ * Print the elements returned by batched lookups, leaving the last one in
+ * @key. Return true at the end of the map. After any error, the caller
+ * continues with bpf_map_get_next_key(), which walks the map in the same order.
+ */
+static bool dump_map_batch(int fd, void *key, void *value,
+			   struct bpf_map_info *info, struct btf *btf,
+			   json_writer_t *wtr, const int *cpu_ids, int cpu_cnt,
+			   unsigned int *num_elems)
+{
+	size_t value_size = map_value_size(info);
+	void *keys, *values, *batch, *in_batch = NULL;
+	__u32 capacity, count, i;
+	bool done = false;
+	int err;
+
+	capacity = min(MAP_DUMP_BATCH_BYTES / (info->key_size + value_size),
+		       (size_t)info->max_entries);
+	if (!capacity)
+		return false;
+
+	/* Hash table batch cursors are u32 bucket indices; other maps use keys. */
+	batch = malloc(max(info->key_size, 4U));
+	keys = malloc((size_t)capacity * info->key_size);
+	values = malloc((size_t)capacity * value_size);
+	if (!batch || !keys || !values)
+		goto out;
+
+	do {
+		count = capacity;
+		err = bpf_map_lookup_batch(fd, in_batch, batch, keys, values,
+					   &count, NULL);
+		if (err && err != -ENOENT)
+			goto out;
+		for (i = 0; i < count; i++) {
+			/* Preserve alignment for odd-sized BTF keys and values. */
+			memcpy(key, keys + (size_t)i * info->key_size, info->key_size);
+			memcpy(value, values + (size_t)i * value_size, value_size);
+			print_map_elem(key, value, info, btf, wtr, cpu_ids, cpu_cnt);
+		}
+		*num_elems += count;
+		in_batch = batch;
+	} while (!err);
+	done = true;
+out:
+	free(batch);
+	free(keys);
+	free(values);
+	return done;
+}
+
 static int maps_have_btf(int *fds, int nb_fds)
 {
 	struct bpf_map_info info = {};
@@ -836,7 +898,8 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	struct btf *btf = NULL;
 	int *cpu_ids = NULL;
 	int cpu_cnt = 0;
-	int err;
+	bool done = false;
+	int err = 0;
 
 	key = malloc(info->key_size);
 	value = alloc_value(info);
@@ -895,7 +958,11 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		p_info("Warning: cannot read values from %s map with value_size != 8",
 		       map_type_str);
 	}
-	while (true) {
+	done = dump_map_batch(fd, key, value, info, btf, wtr, cpu_ids, cpu_cnt,
+			      &num_elems);
+	if (num_elems)
+		prev_key = key;
+	while (!done) {
 		err = bpf_map_get_next_key(fd, prev_key, key);
 		if (err) {
 			if (errno == ENOENT) {
-- 
2.56.0

