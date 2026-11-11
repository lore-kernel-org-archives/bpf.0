Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.177.127.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381611;
	b=Qcs3tv92kiT6/AGwl1EWYKhG/xtfBVlUmk6kaLis9V4aJFoN3wrrbSxZ5Zt0YhTdB1WH
	 8zaYsOF18ucI7RCXs0DXyNqqVSE3VcUgm/7MBrimI3wUUltooLJ10BvmmFHzFN7uuqpnw
	 s31kRO8pipBNo+IVNuiktqFb0QBM6kHU1MLsAeikMzvYEcmyF+NubQKjIISHXoT1k0mQy
	 TuRmNk3wg4bLuN9FMaNYya+s4/lpnjOaSCWDD96oM1JDAzfP5mrhxQIZCCuzdF7uKnl78
	 Ql0egqJe8C0ehFZTOtZsMTRNeKCYgEVgWfimw078xw4DtN2/N9eJQA8GkY6ulh21s7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381611;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Envelope-From;
	bh=l4Y30uuUmGx5yEFtZPI0xuCGShTdIEol1lwBNT2HohE=;
	b=zYho6Ci6yIbyUGOuG/q1NVBhZ9ec/vkoCqH4zN2vS03onXJ6lj4zOBs4Sv2Qi2T3Zxi0
	 JjNv2+hCSdp0vIE3fCOQbS07/OJfx6QQqTlQ/f9UWt0hbdQz1nRUenjbKwCuRnEcjkhAo
	 6lT5OwtViT66YzAL47glvF8dMnI14hwyK+guzh/Cump6RrBE6eQ8FakWjT+ua00bji95V
	 QG83KHWysmjBKNY/0o4MJ/tRnksH09f1vOuyQINrlECCk7MMFLwZzIyJhOPGVkH6BqfSl
	 Yhm4taM7g9YB1rpjT8G4iI89gx27kF8q1ZP2KveI8/mMb0BZtJGj+gxp6wy69uKju2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=KlT9rEsY;
	arc=none smtp.remote-ip=198.177.127.192
Received: from out-utut-a192.jellyfish.systems (out-utut-a192.jellyfish.systems [198.177.127.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0798A606A326
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 07:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0798A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=KlT9rEsY
Received: from fedora (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jPZf90dPlz8sWQ;
	Wed, 11 Nov 2026 07:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1794381590;
	bh=l4Y30uuUmGx5yEFtZPI0xuCGShTdIEol1lwBNT2HohE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KlT9rEsYbbcL+SCYQqiP/rzuqHfl2qGILygqlkH710JczFkiLlBCMEFGGScMb9E3L
	 WylWPkZqAuy44iveZYhu2zhzV0dcV9ufrY9XvCGv1kINL26vYuSwNjrbKE3HqeutZp
	 FqybWXOvQn/x4y/MB8iKy9kbp+zkC0y2pH6tqQQ23wb2aSxKg5JrySeFp8a1LBfYdT
	 BPrX0N7OIYhTF778NQso/tcMQyP95mSM/sK/YahcS7ZTbLuBP53LORQgLM5PyzHkBy
	 WCXSD8HCaxfZR+eNB0Q+WXADX0Q0zcfSnUNggp5QsHlxci/e4W5RiBQh2h1tIEZ6mV
	 BvxpWZ8kttzWg==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	qmo@kernel.org,
	ihor.solodrai@linux.dev
Subject: [PATCH bpf-next v12 2/3] bpftool: Add recursive map dumping
Date: Wed, 11 Nov 2026 16:19:26 +0900
Message-ID: <237281e76007092c3cd8debdc8dddce418f7354b.1794380385.git.hi@tychen.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794380385.git.hi@tychen.cc>
References: <cover.1794380385.git.hi@tychen.cc>
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

Dumping an array_of_maps or a hash_of_maps shows the IDs of the inner
maps but not their contents. Add a recursive keyword to map dump that
also dumps each inner map in the entry that references it. JSON gains
an "inner_map" object next to "inner_map_id". Plain output separates
inner maps with blank lines and indents their raw entries and element
counts. Output without the keyword is unchanged.

The kernel permits only one map-in-map level. Look up outer entries
individually, then open, dump and close each referenced inner map
immediately. This uses one extra map FD; inner dumps may still use batch
lookups. Shared inner maps are dumped at every referring entry. If an
inner map has disappeared, report the error in that entry and continue.

Link: https://github.com/libbpf/bpftool/issues/58
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpf/bpftool/Documentation/bpftool-map.rst |  10 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +
 tools/bpf/bpftool/map.c                       | 123 +++++++++++++++---
 3 files changed, 113 insertions(+), 23 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index e4ed7e701c9e..92706668df76 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -29,7 +29,7 @@ MAP COMMANDS
 | **bpftool** **map create**     *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE* \
 |     **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**inner_map** *MAP*] \
 |     [**offload_dev** *NAME*]
-| **bpftool** **map dump**       *MAP*
+| **bpftool** **map dump**       *MAP* [**recursive**]
 | **bpftool** **map update**     *MAP* [**key** *DATA*] [**value** *VALUE*] [*UPDATE_FLAGS*]
 | **bpftool** **map lookup**     *MAP* [**key** *DATA*]
 | **bpftool** **map getnext**    *MAP* [**key** *DATA*]
@@ -87,10 +87,16 @@ bpftool map create *FILE* type *TYPE* key *KEY_SIZE* value *VALUE_SIZE*  entries
     Keyword **offload_dev** expects a network interface name, and is used to
     request hardware offload for the map.
 
-bpftool map dump    *MAP*
+bpftool map dump    *MAP* [recursive]
     Dump all entries in a given *MAP*.  In case of **name**, *MAP* may match
     several maps which will all be dumped.
 
+    With **recursive**, each entry of an **array_of_maps** or **hash_of_maps**
+    also has the dump of the inner map that it refers to. Plain output
+    separates inner maps with blank lines and indents their entries. An inner
+    map that cannot be opened, for example because it was replaced, is
+    reported as an error in that entry.
+
 bpftool map update  *MAP* [key *DATA*] [value *VALUE*] [*UPDATE_FLAGS*]
     Update map entry for a given *KEY*.
 
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index a28af31937ad..78fdb9396e96 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -718,6 +718,9 @@ _bpftool()
                             return 0
                             ;;
                         *)
+                            if [[ $command == dump && $cword -eq 5 ]]; then
+                                COMPREPLY=( $( compgen -W 'recursive' -- "$cur" ) )
+                            fi
                             return 0
                             ;;
                     esac
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 9e4dc3881060..79d33af257b6 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -22,6 +22,10 @@
 #include "main.h"
 
 static struct hashmap *map_table;
+static bool recursive_dump;
+static const char *map_dump_prefix = "";
+
+static void dump_inner_map(__u32 id);
 
 static bool map_is_per_cpu(__u32 type)
 {
@@ -143,9 +147,14 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
 		print_hex_data_json(key, info->key_size);
 		jsonw_name(json_wtr, "value");
 		print_hex_data_json(value, info->value_size);
-		if (map_is_map_of_maps(info->type))
+		if (map_is_map_of_maps(info->type)) {
 			jsonw_uint_field(json_wtr, "inner_map_id",
 					 *(unsigned int *)value);
+			if (recursive_dump) {
+				jsonw_name(json_wtr, "inner_map");
+				dump_inner_map(*(unsigned int *)value);
+			}
+		}
 		if (btf) {
 			struct btf_dumper d = {
 				.btf = btf,
@@ -194,6 +203,17 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
 	jsonw_end_object(json_wtr);
 }
 
+static void print_hex_data_plain(void *data, unsigned int size)
+{
+	unsigned int i;
+
+	for (i = 0; i < size; i += 16) {
+		if (i)
+			printf("\n%s", map_dump_prefix);
+		fprint_hex(stdout, data + i, min(size - i, 16U), " ");
+	}
+}
+
 static void
 print_entry_error_msg(struct bpf_map_info *info, unsigned char *key,
 		      const char *error_msg)
@@ -204,12 +224,15 @@ print_entry_error_msg(struct bpf_map_info *info, unsigned char *key,
 	break_names = info->key_size > 16 || msg_size > 16;
 	single_line = info->key_size + msg_size <= 24 && !break_names;
 
-	printf("key:%c", break_names ? '\n' : ' ');
-	fprint_hex(stdout, key, info->key_size, " ");
+	printf("%skey:%c%s", map_dump_prefix, break_names ? '\n' : ' ',
+	       break_names ? map_dump_prefix : "");
+	print_hex_data_plain(key, info->key_size);
 
 	printf(single_line ? "  " : "\n");
 
-	printf("value:%c%s", break_names ? '\n' : ' ', error_msg);
+	printf("%svalue:%c%s%s", single_line ? "" : map_dump_prefix,
+	       break_names ? '\n' : ' ', break_names ? map_dump_prefix : "",
+	       error_msg);
 
 	printf("\n");
 }
@@ -259,23 +282,30 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
 			!break_names;
 
 		if (info->key_size) {
-			printf("key:%c", break_names ? '\n' : ' ');
-			fprint_hex(stdout, key, info->key_size, " ");
+			printf("%skey:%c%s", map_dump_prefix,
+			       break_names ? '\n' : ' ', break_names ? map_dump_prefix : "");
+			print_hex_data_plain(key, info->key_size);
 
 			printf(single_line ? "  " : "\n");
 		}
 
 		if (info->value_size) {
+			if (!info->key_size || !single_line)
+				printf("%s", map_dump_prefix);
 			if (map_is_map_of_maps(info->type)) {
-				printf("inner_map_id:%c", break_names ? '\n' : ' ');
+				printf("inner_map_id:%c%s", break_names ? '\n' : ' ',
+				       break_names ? map_dump_prefix : "");
 				printf("%u ", *(unsigned int *)value);
 			} else {
-				printf("value:%c", break_names ? '\n' : ' ');
-				fprint_hex(stdout, value, info->value_size, " ");
+				printf("value:%c%s", break_names ? '\n' : ' ',
+				       break_names ? map_dump_prefix : "");
+				print_hex_data_plain(value, info->value_size);
 			}
 		}
 
 		printf("\n");
+		if (recursive_dump && map_is_map_of_maps(info->type))
+			dump_inner_map(*(unsigned int *)value);
 	} else {
 		unsigned int step;
 		int i;
@@ -283,16 +313,16 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
 		step = round_up(info->value_size, 8);
 
 		if (info->key_size) {
-			printf("key:\n");
-			fprint_hex(stdout, key, info->key_size, " ");
+			printf("%skey:\n%s", map_dump_prefix, map_dump_prefix);
+			print_hex_data_plain(key, info->key_size);
 			printf("\n");
 		}
 		if (info->value_size) {
 			for (i = 0; i < cpu_cnt; i++) {
-				printf("value (CPU %02d):%c",
-				       cpu_ids[i], info->value_size > 16 ? '\n' : ' ');
-				fprint_hex(stdout, value + i * step,
-					   info->value_size, " ");
+				printf("%svalue (CPU %02d):%c%s", map_dump_prefix,
+				       cpu_ids[i], info->value_size > 16 ? '\n' : ' ',
+				       info->value_size > 16 ? map_dump_prefix : "");
+				print_hex_data_plain(value + i * step, info->value_size);
 				printf("\n");
 			}
 		}
@@ -954,6 +984,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		}
 		jsonw_start_array(wtr);		/* elements */
 	} else if (show_header) {
+		printf("%s", map_dump_prefix);
 		show_map_header_plain(info);
 	}
 
@@ -965,8 +996,10 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		p_info("Warning: cannot read values from %s map with value_size != 8",
 		       map_type_str);
 	}
-	done = dump_map_batch(fd, key, value, info, btf, wtr, cpu_ids, cpu_cnt,
-			      &num_elems);
+	/* Open each inner map immediately after looking up its ID. */
+	if (!recursive_dump || !map_is_map_of_maps(info->type))
+		done = dump_map_batch(fd, key, value, info, btf, wtr, cpu_ids, cpu_cnt,
+				      &num_elems);
 	if (num_elems)
 		prev_key = key;
 	while (!done) {
@@ -990,7 +1023,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		if (show_header)
 			jsonw_end_object(wtr);	/* map object */
 	} else if (!err) {
-		printf("Found %u element%s\n", num_elems,
+		printf("%sFound %u element%s\n", map_dump_prefix, num_elems,
 		       num_elems != 1 ? "s" : "");
 	}
 
@@ -1003,6 +1036,43 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	return err;
 }
 
+/* The kernel has one level of map-in-map: inner maps have no inner maps. */
+static void dump_inner_map(__u32 id)
+{
+	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts, .open_flags = BPF_F_RDONLY);
+	struct bpf_map_info info = {};
+	json_writer_t *btf_wtr = NULL;
+	__u32 len = sizeof(info);
+	int fd;
+
+	fd = bpf_map_get_fd_by_id_opts(id, &opts);
+	if (fd < 0) {
+		p_err("can't get map by id (%u): %s", id, strerror(errno));
+		return;
+	}
+	if (bpf_map_get_info_by_fd(fd, &info, &len)) {
+		p_err("can't get map info: %s", strerror(errno));
+		goto out;
+	}
+
+	if (!json_output && info.btf_value_type_id)
+		btf_wtr = get_btf_writer();
+
+	if (!json_output) {
+		printf("\n");
+		map_dump_prefix = "    ";
+	}
+	map_dump(fd, &info, json_output ? json_wtr : btf_wtr, true);
+	map_dump_prefix = "";
+
+	if (btf_wtr)
+		jsonw_destroy(&btf_wtr);
+	if (!json_output)
+		printf("\n");
+out:
+	close(fd);
+}
+
 static int do_dump(int argc, char **argv)
 {
 	json_writer_t *wtr = NULL, *btf_wtr = NULL;
@@ -1012,8 +1082,8 @@ static int do_dump(int argc, char **argv)
 	int *fds = NULL;
 	int err = -1;
 
-	if (argc != 2)
-		usage();
+	if (!REQ_ARGS(2))
+		return -1;
 
 	fds = malloc(sizeof(int));
 	if (!fds) {
@@ -1024,6 +1094,16 @@ static int do_dump(int argc, char **argv)
 	if (nb_fds < 1)
 		goto exit_free;
 
+	while (argc) {
+		if (**argv && is_prefix(*argv, "recursive")) {
+			NEXT_ARG();
+			recursive_dump = true;
+		} else {
+			p_err("expected 'recursive', got: '%s'", *argv);
+			goto exit_close;
+		}
+	}
+
 	if (json_output) {
 		wtr = json_wtr;
 	} else {
@@ -1070,6 +1150,7 @@ static int do_dump(int argc, char **argv)
 exit_free:
 	free(fds);
 	free_btf_vmlinux();
+	recursive_dump = false;
 	return err;
 }
 
@@ -1578,7 +1659,7 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s create     FILE type TYPE key KEY_SIZE value VALUE_SIZE \\\n"
 		"                                  entries MAX_ENTRIES name NAME [flags FLAGS] \\\n"
 		"                                  [inner_map MAP] [offload_dev NAME]\n"
-		"       %1$s %2$s dump       MAP\n"
+		"       %1$s %2$s dump       MAP [recursive]\n"
 		"       %1$s %2$s update     MAP [key DATA] [value VALUE] [UPDATE_FLAGS]\n"
 		"       %1$s %2$s lookup     MAP [key DATA]\n"
 		"       %1$s %2$s getnext    MAP [key DATA]\n"
-- 
2.56.0

