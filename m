Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5E530C637;
	Wed, 23 Sep 2026 00:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790124221; cv=none; b=R6w2LR/ulvk5M2JXrt167U8RVXtuBBnwO3kHncYU7wpVJI4fa3J1E1G4IzsqrD+MxC23lij6xZv0fCJ2sBbWllriIgHGaP/rVrTrMeMl+5JeTU29wbqTmelq2Djqci08KLU20HMmoghQPzthAn0HquPljLja7gBeB5VP+hYMo6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790124221; c=relaxed/simple;
	bh=usbFL1DwWzktdyMdm2JCWGjCtD9ckRjAU/8kFMZkk6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJ8qt0zoDpbIcnY5gY4poy17lYKd8lDZbsRl+2+II4blcU5s1NtOudb0mYYefKtiyS+kdUsdwG1fGK8ecQAgl3Rq7oLLNBTEXwggQPzhYpFwDcnRuAnNLUOIo3BkUYMGASIj5ey/wCIwajgsLqaT1s1AE3jqetBKpLy/LSgk7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=epeufcNh; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="epeufcNh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2y
	1YWmy+0mgj1bR1m3OpgvRq3vXmtj2/xJX/dVqKG+I=; b=epeufcNh1Q0UudDOyp
	K37Mw1CZG2oDeXEo/kHO8EVeviCAus4yq0Aa/Ody42x0EgmZvvC7jioyUNU4O/lN
	IrYvrQdeu++zgqOzVCA/4mZM/y++3aQsfhibZjoeTM0lXE4gnWf102QcXZ0/T5Ma
	B+3fv/8HOmbhJJ2fumneO45UA=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHT_iFILNqR8XfAA--.55586S2;
	Wed, 23 Sep 2026 08:42:46 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH bpf-next v3 1/2] bpftool: Fix CPU IDs in per-CPU map output
Date: Wed, 23 Sep 2026 09:42:42 +0900
Message-ID: <20260923004243.969919-2-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923004243.969919-1-sh_def@163.com>
References: <20260923004243.969919-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHT_iFILNqR8XfAA--.55586S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3ZFyrXrW3WF4xWw4xurW5Awb_yoWDZr47p3
	y5t34kKr48XrW3Ww4fCa98uF45Krn7Gw17JasrG3yrZrWfXrn7ZF4UKF10kr15urWFva1j
	krs0yryj9ayxAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUU8n5UUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6QawEGqzIIYpPAAA3l

bpftool uses dense per-CPU value-buffer slots when printing per-CPU map
values. It also uses the slot index as the CPU ID, which produces
incorrect labels when the possible CPU mask is sparse, such as 0,2-3.

Parse the possible CPU mask and use the corresponding logical CPU ID in
plain, JSON, and BTF-formatted output. Keep the dense slot index for
accessing the per-CPU value buffer.

Pass the parsed CPU count together with the CPU ID array so that the
printed CPU IDs and loop bounds come from the same possible-CPU mask.
Propagate CPU-ID lookup and map output errors through the shared output
path to its callers.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Link: https://lore.kernel.org/bpf/20260813155131.1022745-3-sh_def@163.com/
Signed-off-by: Hui Su <sh_def@163.com>
---
 tools/bpf/bpftool/common.c | 40 ++++++++++++++++
 tools/bpf/bpftool/main.h   |  1 +
 tools/bpf/bpftool/map.c    | 95 +++++++++++++++++++++++++-------------
 3 files changed, 103 insertions(+), 33 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index ef366ccc9650..f9b87efa7c9a 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -31,6 +31,7 @@
 #include <bpf/bpf.h>
 #include <bpf/hashmap.h>
 #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
+#include <bpf/libbpf_internal.h>
 #include <bpf/btf.h>
 #include <zlib.h>
 
@@ -655,6 +656,45 @@ unsigned int get_possible_cpus(void)
 	return cpus;
 }
 
+int get_possible_cpu_ids(int **cpu_ids)
+{
+	const char *possible_cpus_file = "/sys/devices/system/cpu/possible";
+	bool *mask = NULL;
+	int mask_sz, nr_cpus = 0;
+	int *ids = NULL;
+	int i, res;
+
+	*cpu_ids = NULL;
+
+	res = parse_cpu_mask_file(possible_cpus_file, &mask, &mask_sz);
+	if (res) {
+		p_err("failed to parse possible CPU mask: %s", strerror(-res));
+		return res;
+	}
+
+	for (i = 0; i < mask_sz; i++)
+		nr_cpus += mask[i];
+
+	ids = calloc(nr_cpus, sizeof(*ids));
+	if (!ids) {
+		p_err("mem alloc failed");
+		res = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0, nr_cpus = 0; i < mask_sz; i++) {
+		if (mask[i])
+			ids[nr_cpus++] = i;
+	}
+	*cpu_ids = ids;
+	ids = NULL;
+	res = nr_cpus;
+out:
+	free(ids);
+	free(mask);
+	return res;
+}
+
 static char *
 ifindex_to_name_ns(__u32 ifindex, __u32 ns_dev, __u32 ns_ino, char *buf)
 {
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 9315a1db1f7c..48eedcb9f6c0 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -216,6 +216,7 @@ void print_hex_data_json(uint8_t *data, size_t len);
 
 unsigned int get_page_size(void);
 unsigned int get_possible_cpus(void);
+int get_possible_cpu_ids(int **cpu_ids);
 const char *
 ifindex_to_arch(__u32 ifindex, __u64 ns_dev, __u64 ns_ino, const char **opt);
 
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 684a8fb72414..20d59eab09a1 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -70,7 +70,7 @@ static void *alloc_value(struct bpf_map_info *info)
 
 static int do_dump_btf(const struct btf_dumper *d,
 		       struct bpf_map_info *map_info, void *key,
-		       void *value)
+		       void *value, const int *cpu_ids, int cpu_cnt)
 {
 	__u32 value_id;
 	int ret = 0;
@@ -93,15 +93,15 @@ static int do_dump_btf(const struct btf_dumper *d,
 		jsonw_name(d->jw, "value");
 		ret = btf_dumper_type(d, value_id, value);
 	} else {
-		unsigned int i, n, step;
+		unsigned int step;
+		int i;
 
 		jsonw_name(d->jw, "values");
 		jsonw_start_array(d->jw);
-		n = get_possible_cpus();
 		step = round_up(map_info->value_size, 8);
-		for (i = 0; i < n; i++) {
+		for (i = 0; i < cpu_cnt; i++) {
 			jsonw_start_object(d->jw);
-			jsonw_int_field(d->jw, "cpu", i);
+			jsonw_int_field(d->jw, "cpu", cpu_ids[i]);
 			jsonw_name(d->jw, "value");
 			ret = btf_dumper_type(d, value_id, value + i * step);
 			jsonw_end_object(d->jw);
@@ -130,7 +130,8 @@ static json_writer_t *get_btf_writer(void)
 }
 
 static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
-			     unsigned char *value, struct btf *btf)
+			     unsigned char *value, struct btf *btf,
+			     const int *cpu_ids, int cpu_cnt)
 {
 	jsonw_start_object(json_wtr);
 
@@ -150,12 +151,12 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
 			};
 
 			jsonw_name(json_wtr, "formatted");
-			do_dump_btf(&d, info, key, value);
+			do_dump_btf(&d, info, key, value, cpu_ids, cpu_cnt);
 		}
 	} else {
-		unsigned int i, n, step;
+		unsigned int step;
+		int i;
 
-		n = get_possible_cpus();
 		step = round_up(info->value_size, 8);
 
 		jsonw_name(json_wtr, "key");
@@ -163,10 +164,10 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
 
 		jsonw_name(json_wtr, "values");
 		jsonw_start_array(json_wtr);
-		for (i = 0; i < n; i++) {
+		for (i = 0; i < cpu_cnt; i++) {
 			jsonw_start_object(json_wtr);
 
-			jsonw_int_field(json_wtr, "cpu", i);
+			jsonw_int_field(json_wtr, "cpu", cpu_ids[i]);
 
 			jsonw_name(json_wtr, "value");
 			print_hex_data_json(value + i * step,
@@ -183,7 +184,7 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
 			};
 
 			jsonw_name(json_wtr, "formatted");
-			do_dump_btf(&d, info, key, value);
+			do_dump_btf(&d, info, key, value, cpu_ids, cpu_cnt);
 		}
 	}
 
@@ -245,7 +246,7 @@ print_entry_error(struct bpf_map_info *map_info, void *key, int lookup_errno)
 }
 
 static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
-			      unsigned char *value)
+			      unsigned char *value, const int *cpu_ids, int cpu_cnt)
 {
 	if (!map_is_per_cpu(info->type)) {
 		bool single_line, break_names;
@@ -273,9 +274,9 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
 
 		printf("\n");
 	} else {
-		unsigned int i, n, step;
+		unsigned int step;
+		int i;
 
-		n = get_possible_cpus();
 		step = round_up(info->value_size, 8);
 
 		if (info->key_size) {
@@ -284,9 +285,9 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
 			printf("\n");
 		}
 		if (info->value_size) {
-			for (i = 0; i < n; i++) {
-				printf("value (CPU %02u):%c",
-				       i, info->value_size > 16 ? '\n' : ' ');
+			for (i = 0; i < cpu_cnt; i++) {
+				printf("value (CPU %02d):%c",
+				       cpu_ids[i], info->value_size > 16 ? '\n' : ' ');
 				fprint_hex(stdout, value + i * step,
 					   info->value_size, " ");
 				printf("\n");
@@ -742,7 +743,7 @@ static int do_show(int argc, char **argv)
 
 static int dump_map_elem(int fd, void *key, void *value,
 			 struct bpf_map_info *map_info, struct btf *btf,
-			 json_writer_t *btf_wtr)
+			 json_writer_t *btf_wtr, const int *cpu_ids, int cpu_cnt)
 {
 	if (bpf_map_lookup_elem(fd, key, value)) {
 		print_entry_error(map_info, key, errno);
@@ -750,7 +751,7 @@ static int dump_map_elem(int fd, void *key, void *value,
 	}
 
 	if (json_output) {
-		print_entry_json(map_info, key, value, btf);
+		print_entry_json(map_info, key, value, btf, cpu_ids, cpu_cnt);
 	} else if (btf) {
 		struct btf_dumper d = {
 			.btf = btf,
@@ -758,9 +759,9 @@ static int dump_map_elem(int fd, void *key, void *value,
 			.is_plain_text = true,
 		};
 
-		do_dump_btf(&d, map_info, key, value);
+		do_dump_btf(&d, map_info, key, value, cpu_ids, cpu_cnt);
 	} else {
-		print_entry_plain(map_info, key, value);
+		print_entry_plain(map_info, key, value, cpu_ids, cpu_cnt);
 	}
 
 	return 0;
@@ -833,6 +834,8 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	void *key, *value, *prev_key;
 	unsigned int num_elems = 0;
 	struct btf *btf = NULL;
+	int *cpu_ids = NULL;
+	int cpu_cnt = 0;
 	int err;
 
 	key = malloc(info->key_size);
@@ -845,6 +848,14 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 
 	prev_key = NULL;
 
+	if (map_is_per_cpu(info->type)) {
+		cpu_cnt = get_possible_cpu_ids(&cpu_ids);
+		if (cpu_cnt < 0) {
+			err = cpu_cnt;
+			goto exit_free;
+		}
+	}
+
 	if (wtr) {
 		err = get_map_kv_btf(info, &btf);
 		if (err) {
@@ -876,7 +887,8 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 				err = 0;
 			break;
 		}
-		if (!dump_map_elem(fd, key, value, info, btf, wtr))
+		if (!dump_map_elem(fd, key, value, info, btf, wtr,
+				   cpu_ids, cpu_cnt))
 			num_elems++;
 		prev_key = key;
 	}
@@ -893,6 +905,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 exit_free:
 	free(key);
 	free(value);
+	free(cpu_ids);
 	free_map_kv_btf(btf);
 
 	return err;
@@ -1035,17 +1048,30 @@ static int do_update(int argc, char **argv)
 	return err;
 }
 
-static void print_key_value(struct bpf_map_info *info, void *key,
-			    void *value)
+static int print_key_value(struct bpf_map_info *info, void *key,
+			   void *value)
 {
 	json_writer_t *btf_wtr;
 	struct btf *btf;
+	int *cpu_ids = NULL;
+	int cpu_cnt = 0;
+	int err = 0;
 
-	if (get_map_kv_btf(info, &btf))
-		return;
+	if (map_is_per_cpu(info->type)) {
+		cpu_cnt = get_possible_cpu_ids(&cpu_ids);
+
+		if (cpu_cnt < 0) {
+			err = cpu_cnt;
+			goto out;
+		}
+	}
+
+	err = get_map_kv_btf(info, &btf);
+	if (err)
+		goto out;
 
 	if (json_output) {
-		print_entry_json(info, key, value, btf);
+		print_entry_json(info, key, value, btf, cpu_ids, cpu_cnt);
 	} else if (btf) {
 		/* if here json_wtr wouldn't have been initialised,
 		 * so let's create separate writer for btf
@@ -1055,7 +1081,7 @@ static void print_key_value(struct bpf_map_info *info, void *key,
 			p_info("failed to create json writer for btf. falling back to plain output");
 			free_map_kv_btf(btf);
 			btf = NULL;
-			print_entry_plain(info, key, value);
+			print_entry_plain(info, key, value, cpu_ids, cpu_cnt);
 		} else {
 			struct btf_dumper d = {
 				.btf = btf,
@@ -1063,13 +1089,16 @@ static void print_key_value(struct bpf_map_info *info, void *key,
 				.is_plain_text = true,
 			};
 
-			do_dump_btf(&d, info, key, value);
+			do_dump_btf(&d, info, key, value, cpu_ids, cpu_cnt);
 			jsonw_destroy(&btf_wtr);
 		}
 	} else {
-		print_entry_plain(info, key, value);
+		print_entry_plain(info, key, value, cpu_ids, cpu_cnt);
 	}
 	free_map_kv_btf(btf);
+out:
+	free(cpu_ids);
+	return err;
 }
 
 static int do_lookup(int argc, char **argv)
@@ -1114,7 +1143,7 @@ static int do_lookup(int argc, char **argv)
 	}
 
 	/* here means bpf_map_lookup_elem() succeeded */
-	print_key_value(&info, key, value);
+	err = print_key_value(&info, key, value);
 
 exit_free:
 	free(key);
@@ -1404,7 +1433,7 @@ static int do_pop_dequeue(int argc, char **argv)
 		goto exit_free;
 	}
 
-	print_key_value(&info, key, value);
+	err = print_key_value(&info, key, value);
 
 exit_free:
 	free(key);
-- 
2.55.0

