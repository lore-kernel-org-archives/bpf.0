Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A2F4DD3C0;
	Fri, 18 Sep 2026 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726922; cv=none; b=ZTli5gy82o+cBum/fVyxsvtFSIi6s0/eYJaNcwTWmyUU89xO2FuAt3xKULQoLCqQG6c6RVJa41JOf7wyc3P0jSwg99uqFjktwIJDysyC9/CWKi+2J7i1yu02uPcv1VjHeeQbNg2cd6eNT0dFFagaDF//w/k1oArw8juhwlnLc7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726922; c=relaxed/simple;
	bh=QFXDH9UXsakrxfEHCXhFRjO+WWgVPallibyVnpTnnkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHQgylybEYk5kwUDt5UYXUgldqSMEMX237Ozi1/I11tKuBj/UEXEPyKfWLKIOsZVhh2U9SX3LUZEU+NUdozd4/zFKPsfoG+KYoMECKjrI8NaR8gmo1q1iSb3mv4rF81ucXmrE8C1UaNCf49mzcJQjTF2MFx44G1AM4llYSn4png=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Me6JNl3W; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Me6JNl3W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+7
	teu6LWN+4dSUq6xi9dPDxZX4IejJ2vSM2DIUCr+OU=; b=Me6JNl3W5IZ1PJdOG0
	rkWyNJtxSjyVGww8bboc9avoXhFJKnuPKChTQMaYtSDWUKqAniU5SJxf9kRfARri
	TfOXyHHhjNZcSawSHXAfBdVDtkL8hnASuqkh+UEBwUl0t1VOjzfY8zFZtKE12hI7
	b8cNJOHl5DzdcfAQT5L/QTo48=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgB3ObOQEK1qLLNJAA--.8472S2;
	Fri, 18 Sep 2026 18:21:05 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
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
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH bpf v2 1/2] bpftool: Fix CPU IDs in per-CPU map output
Date: Fri, 18 Sep 2026 19:20:51 +0900
Message-ID: <20260918102052.1247819-2-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918102052.1247819-1-sh_def@163.com>
References: <20260918102052.1247819-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgB3ObOQEK1qLLNJAA--.8472S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GryUZF4UAF4xAry8AF1fZwb_yoWDGF1Upw
	45t348Kr48XrW3Ww4Ska98uF4Ygrs7Gw17JasrG3yrZFWfXrn7ZF4UKF10kr15urWFvF4j
	yFs0vryj9a1xCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi8pndUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6hMujWqtEJP8CQAA3r

bpftool uses dense per-CPU value-buffer slots when printing per-CPU map
values. It also uses the slot index as the CPU ID, which produces
incorrect labels when the possible CPU mask is sparse, such as 0,2-3.

Parse the possible CPU mask and use the corresponding logical CPU ID in
plain, JSON, and BTF-formatted output. Keep the dense slot index for
accessing the per-CPU value buffer, and propagate CPU-ID lookup and map
output errors through the shared output path to its callers.

Tested:
- Built tools/bpf/bpftool successfully on the host.
- Booted an arm64 QEMU guest with a patched virt device tree reporting
  possible=0,2-3, present=0,2-3, and online=0,2-3.
- Compared pre-fix and fixed plain and JSON map output in that guest:
  labels changed from CPU 0,1,2 to CPU 0,2,3.
- Loaded a BTF-described per-CPU array and dumped it with the fixed
  bpftool in plain BTF and JSON formats; both formats reported CPU 0,2,3
  while preserving the three dense per-CPU values.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Link: https://lore.kernel.org/bpf/20260813155131.1022745-3-sh_def@163.com/
Signed-off-by: Hui Su <sh_def@163.com>
---
 tools/bpf/bpftool/common.c | 40 ++++++++++++++++++++
 tools/bpf/bpftool/main.h   |  1 +
 tools/bpf/bpftool/map.c    | 76 ++++++++++++++++++++++++++------------
 3 files changed, 93 insertions(+), 24 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index ef366ccc9650..ad10bfe8a0fc 100644
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
+		p_err("failed to allocate possible CPU IDs: %s", strerror(ENOMEM));
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
index 78b6e0ebb85d..6540b632a3ac 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -216,6 +216,7 @@ void print_hex_data_json(uint8_t *data, size_t len);
 
 unsigned int get_page_size(void);
 unsigned int get_possible_cpus(void);
+int get_possible_cpu_ids(int **cpu_ids);
 const char *
 ifindex_to_arch(__u32 ifindex, __u64 ns_dev, __u64 ns_ino, const char **opt);
 
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 684a8fb72414..586c9e076a48 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -70,7 +70,7 @@ static void *alloc_value(struct bpf_map_info *info)
 
 static int do_dump_btf(const struct btf_dumper *d,
 		       struct bpf_map_info *map_info, void *key,
-		       void *value)
+		       void *value, const int *cpu_ids)
 {
 	__u32 value_id;
 	int ret = 0;
@@ -101,7 +101,7 @@ static int do_dump_btf(const struct btf_dumper *d,
 		step = round_up(map_info->value_size, 8);
 		for (i = 0; i < n; i++) {
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
+			     const int *cpu_ids)
 {
 	jsonw_start_object(json_wtr);
 
@@ -150,7 +151,7 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
 			};
 
 			jsonw_name(json_wtr, "formatted");
-			do_dump_btf(&d, info, key, value);
+			do_dump_btf(&d, info, key, value, cpu_ids);
 		}
 	} else {
 		unsigned int i, n, step;
@@ -166,7 +167,7 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
 		for (i = 0; i < n; i++) {
 			jsonw_start_object(json_wtr);
 
-			jsonw_int_field(json_wtr, "cpu", i);
+			jsonw_int_field(json_wtr, "cpu", cpu_ids[i]);
 
 			jsonw_name(json_wtr, "value");
 			print_hex_data_json(value + i * step,
@@ -183,7 +184,7 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
 			};
 
 			jsonw_name(json_wtr, "formatted");
-			do_dump_btf(&d, info, key, value);
+			do_dump_btf(&d, info, key, value, cpu_ids);
 		}
 	}
 
@@ -245,7 +246,7 @@ print_entry_error(struct bpf_map_info *map_info, void *key, int lookup_errno)
 }
 
 static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
-			      unsigned char *value)
+			      unsigned char *value, const int *cpu_ids)
 {
 	if (!map_is_per_cpu(info->type)) {
 		bool single_line, break_names;
@@ -285,8 +286,8 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
 		}
 		if (info->value_size) {
 			for (i = 0; i < n; i++) {
-				printf("value (CPU %02u):%c",
-				       i, info->value_size > 16 ? '\n' : ' ');
+				printf("value (CPU %02d):%c",
+				       cpu_ids[i], info->value_size > 16 ? '\n' : ' ');
 				fprint_hex(stdout, value + i * step,
 					   info->value_size, " ");
 				printf("\n");
@@ -742,7 +743,7 @@ static int do_show(int argc, char **argv)
 
 static int dump_map_elem(int fd, void *key, void *value,
 			 struct bpf_map_info *map_info, struct btf *btf,
-			 json_writer_t *btf_wtr)
+			 json_writer_t *btf_wtr, const int *cpu_ids)
 {
 	if (bpf_map_lookup_elem(fd, key, value)) {
 		print_entry_error(map_info, key, errno);
@@ -750,7 +751,7 @@ static int dump_map_elem(int fd, void *key, void *value,
 	}
 
 	if (json_output) {
-		print_entry_json(map_info, key, value, btf);
+		print_entry_json(map_info, key, value, btf, cpu_ids);
 	} else if (btf) {
 		struct btf_dumper d = {
 			.btf = btf,
@@ -758,9 +759,9 @@ static int dump_map_elem(int fd, void *key, void *value,
 			.is_plain_text = true,
 		};
 
-		do_dump_btf(&d, map_info, key, value);
+		do_dump_btf(&d, map_info, key, value, cpu_ids);
 	} else {
-		print_entry_plain(map_info, key, value);
+		print_entry_plain(map_info, key, value, cpu_ids);
 	}
 
 	return 0;
@@ -833,6 +834,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	void *key, *value, *prev_key;
 	unsigned int num_elems = 0;
 	struct btf *btf = NULL;
+	int *cpu_ids = NULL;
 	int err;
 
 	key = malloc(info->key_size);
@@ -845,6 +847,16 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 
 	prev_key = NULL;
 
+	if (map_is_per_cpu(info->type)) {
+		int cpu_cnt;
+
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
@@ -876,7 +888,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 				err = 0;
 			break;
 		}
-		if (!dump_map_elem(fd, key, value, info, btf, wtr))
+		if (!dump_map_elem(fd, key, value, info, btf, wtr, cpu_ids))
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
@@ -1035,17 +1048,29 @@ static int do_update(int argc, char **argv)
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
+	int err = 0;
 
-	if (get_map_kv_btf(info, &btf))
-		return;
+	if (map_is_per_cpu(info->type)) {
+		int cpu_cnt = get_possible_cpu_ids(&cpu_ids);
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
+		print_entry_json(info, key, value, btf, cpu_ids);
 	} else if (btf) {
 		/* if here json_wtr wouldn't have been initialised,
 		 * so let's create separate writer for btf
@@ -1055,7 +1080,7 @@ static void print_key_value(struct bpf_map_info *info, void *key,
 			p_info("failed to create json writer for btf. falling back to plain output");
 			free_map_kv_btf(btf);
 			btf = NULL;
-			print_entry_plain(info, key, value);
+			print_entry_plain(info, key, value, cpu_ids);
 		} else {
 			struct btf_dumper d = {
 				.btf = btf,
@@ -1063,13 +1088,16 @@ static void print_key_value(struct bpf_map_info *info, void *key,
 				.is_plain_text = true,
 			};
 
-			do_dump_btf(&d, info, key, value);
+			do_dump_btf(&d, info, key, value, cpu_ids);
 			jsonw_destroy(&btf_wtr);
 		}
 	} else {
-		print_entry_plain(info, key, value);
+		print_entry_plain(info, key, value, cpu_ids);
 	}
 	free_map_kv_btf(btf);
+out:
+	free(cpu_ids);
+	return err;
 }
 
 static int do_lookup(int argc, char **argv)
@@ -1114,7 +1142,7 @@ static int do_lookup(int argc, char **argv)
 	}
 
 	/* here means bpf_map_lookup_elem() succeeded */
-	print_key_value(&info, key, value);
+	err = print_key_value(&info, key, value);
 
 exit_free:
 	free(key);
@@ -1404,7 +1432,7 @@ static int do_pop_dequeue(int argc, char **argv)
 		goto exit_free;
 	}
 
-	print_key_value(&info, key, value);
+	err = print_key_value(&info, key, value);
 
 exit_free:
 	free(key);
-- 
2.55.0

