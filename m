Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8D478E38
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796693; cv=none; b=Qr32plpL1dODvfn9v40+6WTK/iPlfQvojiUd6NCLgmAA2HpdJjWvKlgqOnfXdXVRNJWL7iWTSp12IRzKQMcLxhIPO3BEmzXY5sBnK9NC4pU1ioBViz1O5tcoCEeMuU3CKx7pybYO3en+zs2ENkE7CgfrPslLkaubkGcpQwMEpac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796693; c=relaxed/simple;
	bh=A/P8bl5+NQArxGjyDFTPfY19b5wCM3KpTaqJ9DWQpJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBOftZmyOfGSE6sofcEjiyhbZq2aw5XPpZlspMz6Ypt34wEjjxqMXZZ58O/cMjS5/XAAyyAgD889OHSWtvHgkc8ALUKwCGnhfvD5AoMOis5zAIlhqFxKf8z1TyAwyImdj32UMp/9BeaUCFScHSvQK5Gtk4q9sSelnahqCinTwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FxN2hBqs; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FxN2hBqs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=iK
	lw9ss4epJGxDhmwZewJPU8Qm5WVDuUBMpRibtGAZM=; b=FxN2hBqsdFoTN7upLg
	Q+XynmrnN0+vVhv/qx9tB5gwpx87i9BoCqqXu23D0JQ5qaDpItAwuH/knzu7iwMt
	MbzrCeQNiRgAj185YuWdjvIKlqP/FrbxTDoFFGpcMxO0s54g3x8qpUITJcMJLp7/
	H/W8X0XgLZayUR7x75RXee854=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCH70Tw3p5q96raBA--.14810S2;
	Mon, 07 Sep 2026 23:57:36 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	Hui Su <sh_def@163.com>
Subject: [PATCH bpf 1/2] bpftool: Fix CPU IDs in per-CPU map output
Date: Tue,  8 Sep 2026 00:57:34 +0900
Message-ID: <20260907155735.2929529-2-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260907155735.2929529-1-sh_def@163.com>
References: <20260907155735.2929529-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH70Tw3p5q96raBA--.14810S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GryUZF4UAF4xAry8AF1fZwb_yoWfKrWfpa
	15t34UKr48XrW3W3ySka98uF4Ygrs7Cw17JasrG3yrZFWfXrn7XF48KF10kr15urWFvF4j
	yFs0yryUua1xAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRyGQfUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRI2lWqe3vKzHQAA3G

bpftool uses dense per-CPU value-buffer slots when printing per-CPU map
values. It also uses the slot index as the CPU ID, which produces
incorrect labels when the possible CPU mask is sparse, such as 0,2-3.

Parse the possible CPU mask and use the corresponding logical CPU ID in
plain, JSON, and BTF-formatted output. Keep the dense slot index for
accessing the per-CPU value buffer, and propagate CPU-ID lookup errors
through map lookup output.

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
Signed-off-by: Hui Su <sh_def@163.com>
Link: https://lore.kernel.org/bpf/20260813155131.1022745-3-sh_def@163.com/
---
 tools/bpf/bpftool/common.c | 37 ++++++++++++++++++
 tools/bpf/bpftool/main.h   |  1 +
 tools/bpf/bpftool/map.c    | 77 +++++++++++++++++++++++++++-----------
 3 files changed, 93 insertions(+), 22 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index ef366ccc9650..d6f35257b203 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -31,6 +31,7 @@
 #include <bpf/bpf.h>
 #include <bpf/hashmap.h>
 #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
+#include <bpf/libbpf_internal.h>
 #include <bpf/btf.h>
 #include <zlib.h>
 
@@ -655,6 +656,42 @@ unsigned int get_possible_cpus(void)
 	return cpus;
 }
 
+int get_possible_cpu_ids(int **cpu_ids)
+{
+	const char *possible_cpus_file = "/sys/devices/system/cpu/possible";
+	bool *mask = NULL;
+	int mask_sz, nr_cpus = 0;
+	int *ids = NULL;
+	int i, err;
+
+	*cpu_ids = NULL;
+
+	err = parse_cpu_mask_file(possible_cpus_file, &mask, &mask_sz);
+	if (err)
+		return err;
+
+	for (i = 0; i < mask_sz; i++)
+		nr_cpus += mask[i];
+
+	ids = calloc(nr_cpus, sizeof(*ids));
+	if (!ids) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0, nr_cpus = 0; i < mask_sz; i++) {
+		if (mask[i])
+			ids[nr_cpus++] = i;
+	}
+	*cpu_ids = ids;
+	ids = NULL;
+	err = nr_cpus;
+out:
+	free(ids);
+	free(mask);
+	return err;
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
index 684a8fb72414..e4e4a520401e 100644
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
@@ -845,6 +847,17 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 
 	prev_key = NULL;
 
+	if (map_is_per_cpu(info->type)) {
+		err = get_possible_cpu_ids(&cpu_ids);
+		if (err < 0)
+			goto exit_free;
+		if (err != (int)get_possible_cpus()) {
+			p_err("possible CPU count mismatch");
+			err = -1;
+			goto exit_free;
+		}
+	}
+
 	if (wtr) {
 		err = get_map_kv_btf(info, &btf);
 		if (err) {
@@ -876,7 +889,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 				err = 0;
 			break;
 		}
-		if (!dump_map_elem(fd, key, value, info, btf, wtr))
+		if (!dump_map_elem(fd, key, value, info, btf, wtr, cpu_ids))
 			num_elems++;
 		prev_key = key;
 	}
@@ -893,6 +906,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 exit_free:
 	free(key);
 	free(value);
+	free(cpu_ids);
 	free_map_kv_btf(btf);
 
 	return err;
@@ -1035,17 +1049,33 @@ static int do_update(int argc, char **argv)
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
+
+	if (map_is_per_cpu(info->type)) {
+		int cpu_cnt = get_possible_cpu_ids(&cpu_ids);
+
+		if (cpu_cnt < 0) {
+			err = cpu_cnt;
+			goto out;
+		}
+		if (cpu_cnt != (int)get_possible_cpus()) {
+			p_err("possible CPU count mismatch");
+			err = -EINVAL;
+			goto out;
+		}
+	}
 
 	if (get_map_kv_btf(info, &btf))
-		return;
+		goto out;
 
 	if (json_output) {
-		print_entry_json(info, key, value, btf);
+		print_entry_json(info, key, value, btf, cpu_ids);
 	} else if (btf) {
 		/* if here json_wtr wouldn't have been initialised,
 		 * so let's create separate writer for btf
@@ -1055,7 +1085,7 @@ static void print_key_value(struct bpf_map_info *info, void *key,
 			p_info("failed to create json writer for btf. falling back to plain output");
 			free_map_kv_btf(btf);
 			btf = NULL;
-			print_entry_plain(info, key, value);
+			print_entry_plain(info, key, value, cpu_ids);
 		} else {
 			struct btf_dumper d = {
 				.btf = btf,
@@ -1063,13 +1093,16 @@ static void print_key_value(struct bpf_map_info *info, void *key,
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
@@ -1114,7 +1147,7 @@ static int do_lookup(int argc, char **argv)
 	}
 
 	/* here means bpf_map_lookup_elem() succeeded */
-	print_key_value(&info, key, value);
+	err = print_key_value(&info, key, value);
 
 exit_free:
 	free(key);
-- 
2.54.0

