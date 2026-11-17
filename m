Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911682;
	b=ha6Uti0q4BXSoKE9Ycw7/sb/h15rV0OcVCPEKkOnfE8lEbFaI/VJywt9ggNin6VbC+Fh
	 fg4D/dKy2KwKQhCU8X2c3VCsblQ+EQSvBlK5reI9AgGP0bLpWZPlBP8vzQxcb52LXLY40
	 a/m3tg+LAgGMPJ3/2RD/pg5ISgXfTCVTYbYB1CDxN3YJM56AV7K6D5eHxngj3NFmCT5Ij
	 9gwf6ojLrMZQ0rm9srWbuMDTH9XeFrxFXkbDK5ct87ZYCKLkwB1HriWdMZfbtTcq7YTyJ
	 6yx08TiOC80qahOLtwfs+kSmOFdZSrQoi74gZyXOOZKKVyqbhjRDSQaiQyTsWq+GeOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911682;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V5vkJdaSnhL0zVEOcXz2X42q6feAZfN1uTwod7belvA=;
	b=bpBQVci8KQEPGpmT+Pz0kMzHhICXtGVI1JMNBwCWXrTNEuL42NgsS84qmaEkaWLhug5p
	 d+pwodmO05cTEbWpCato8Rk6yQFiWONk9AeE0qfM2bCN+fsdRZD6fjzwLjib90YHnUNP6
	 AWyb2aPoV2loDK6rwpQJSx7BEbyrywYlDzwzSkBAas3Fj8jCRBD5wpRihVVKPcIqHo76U
	 uqRswuRTaH6pHFZM1DjjUlRPcSf4tzto0f81JLS/981jjee4T6MC+t6jOpcwNhVzQ4eR5
	 /q7ito1LZYFlAKp74I7ikgPYh/NBXHDDWjHsm/LDca3P4GWcPCo3FI8nGOVY3xXdBVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=ccRZ0dcC;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7260A3819;
	Tue, 17 Nov 2026 10:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EE7260A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=ccRZ0dcC
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGWD-001QYg-Cm; Tue, 17 Nov 2026 11:34:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=V5vkJdaSnhL0zVEOcXz2X42q6feAZfN1uTwod7belvA=; b=ccRZ0dcCEsHLo+FZPX+4eJz0HX
	U94YaLUIQ9UXzfmVaRdNDv6kBhiG3OwQpMOX7yW/kVbTXe75AqxElQsntq1u6OzSvylJXnfJ/sG5+
	cdOYPTWStyu3u6SL5OKokmull335JITSlR6KUW8CFV7G8ISdWQ4lLOO/MAi2LZx/N4Lecd4sVOQNa
	+zrh6EN/5ZGdVH6stP5cb7A5vOGBnnv0LGdGTyUC+C7+5fFxhm6+6KtqPzy7Z0JMJrPrt/dlyT5X1
	Rw65PsjvUvLqvHF10Ufi5jqc3E2hxAP5HtTS4Jpt8+EX0hBfdrmmdnk4UUa8c6E2Oj175mJXUs/6o
	bn0jFuUA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW2-0002fL-Ra; Tue, 17 Nov 2026 11:34:19 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xTGVk-005qHU-MN;
	Tue, 17 Nov 2026 11:34:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Petr Mladek <pmladek@suse.com>,
	Kees Cook <kees@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Samuel Wu <wusamuel@google.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 next 02/13] scripts/kallsyms: Improve error reporting
Date: Tue, 17 Nov 2026 10:33:41 +0000
Message-Id: <20261117103352.1244657-3-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117103352.1244657-1-david.laight.linux@gmail.com>
References: <20261117103352.1244657-1-david.laight.linux@gmail.com>
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

Report fatal errors with err() not perror().

Using err/errx() adds the program name to the output and allows rather
more descriptive errors.

Add fflush() calls before checking ferror(), use errx() for these
since errno isn't valid.

Use a single error check for the length of the compressed symbol.
It must be shorter than the original length - but that isn't kept,
so check against KSYM_NAME_LEN (allowing 1 for the symbol type).

Move the usage() function to just before main().
Remove the usage text from the top of file comment and put the info
into the usage() output.
Removes the need to keep two copies of the same text in line with
the actual code.

Add a --verbose option that outputs some timestamps.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Note that the long 'usage' message was only added for 7.4-rc1.

v3: New patch, subsumes the old patch 4.
v4: Fix some minor issues with err() and errx() messages.

 scripts/kallsyms.c | 154 ++++++++++++++++++++++++++-------------------
 1 file changed, 91 insertions(+), 63 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 140e888bf713..ee2438a4aca0 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,15 +5,7 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: kallsyms [--all-symbols] [--pc-relative] [--sysmap=out.map] in out.bin > out.S
- *        kallsyms --sysmap=out.map in
- *
- *      in is vmlinux; an empty file stands for the first link, which has no
- *  symbols yet, and gives an empty table. --sysmap also writes the symbols
- *  in System.map format.
- *
- *      The byte tables go to out.bin and are pulled into out.S with .incbin;
- *  wider tables stay assembler source for endianness and relocations.
+ * Generate asm source containing a compressed copy of the kernel symbol table.
  *
  *      Table compression uses all the unused char codes on the symbols and
  *  maps these to the most used substrings (tokens). For instance, it might
@@ -26,11 +18,13 @@
  *
  */
 
+#include <err.h>
 #include <getopt.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <time.h>
 #include <ctype.h>
 #include <limits.h>
 #include <sys/stat.h>
@@ -64,6 +58,7 @@ static struct sym_entry **table;
 static unsigned int table_size, table_cnt;
 static int all_symbols;
 static int pc_relative;
+static int verbose;
 
 /* A dynamic array of symbols, encoded by symbol index. */
 struct sym_arr {
@@ -81,6 +76,23 @@ static struct sym_arr token_syms[NR_TOKENS];
 static unsigned char best_table[256][2];
 static unsigned char best_table_len[256];
 
+static void stamp(const char *where)
+{
+	static unsigned long long prev;
+	struct timespec now;
+	unsigned long long delta;
+
+	if (!verbose)
+		return;
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+	delta = now.tv_sec * 10000ull + now.tv_nsec / 100000 - prev;
+	prev += delta;
+	if (where)
+		fprintf(stderr, "kallsyms: stamp %s %llu.%llu ms\n",
+			where, delta / 10, delta % 10);
+}
+
 static unsigned int sym_arr_last(const struct sym_arr *arr)
 {
 	return arr->cnt ? arr->sym_indexes[arr->cnt - 1] : UINT_MAX;
@@ -110,14 +122,6 @@ static void sym_arr_free(struct sym_arr *arr)
 	arr->cap = 0;
 }
 
-static void usage(void)
-{
-	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--pc-relative] [--sysmap=out.map]\n"
-			"                in out.bin > out.S\n"
-			"       kallsyms --sysmap=out.map vmlinux\n");
-	exit(1);
-}
-
 static char *sym_entry_name(const struct sym_entry *s)
 {
 	return (char *)s->sym + 1;
@@ -278,10 +282,8 @@ static bool file_is_empty(const char *path)
 {
 	struct stat st;
 
-	if (stat(path, &st)) {
-		perror(path);
-		exit(EXIT_FAILURE);
-	}
+	if (stat(path, &st))
+		err(EXIT_FAILURE, "stat(%s) failed", path);
 
 	return st.st_size == 0;
 }
@@ -324,10 +326,8 @@ static long bin_pos(FILE *file)
 {
 	const long pos = ftell(file);
 
-	if (pos < 0) {
-		perror("kallsyms: ftell");
-		exit(EXIT_FAILURE);
-	}
+	if (pos < 0)
+		err(EXIT_FAILURE, "ftell on out.bin file failed");
 
 	return pos;
 }
@@ -419,19 +419,10 @@ static void write_src(FILE *out_bin_file, const char *out_bin_name)
 			markers[i >> 8] = off;
 		table[i]->seq = i;
 
-		/* There cannot be any symbol of length zero. */
-		if (table[i]->len == 0) {
-			fprintf(stderr, "kallsyms failure: "
-				"unexpected zero symbol length\n");
-			exit(EXIT_FAILURE);
-		}
-
-		/* Only lengths that fit in up-to-two-byte ULEB128 are supported. */
-		if (table[i]->len > 0x3FFF) {
-			fprintf(stderr, "kallsyms failure: "
-				"unexpected huge symbol length\n");
-			exit(EXIT_FAILURE);
-		}
+		/* The length must be less than that of the original symbol. */
+		if (!table[i]->len || table[i]->len > KSYM_NAME_LEN)
+			errx(EXIT_FAILURE, "symbol %d has corrupt compressed length %d",
+			     i, table[i]->len);
 
 		/* Encode length with ULEB128. */
 		if (table[i]->len <= 0x7F) {
@@ -465,6 +456,8 @@ static void write_src(FILE *out_bin_file, const char *out_bin_name)
 
 	free(markers);
 
+	stamp("write compressed names");
+
 	output_label("kallsyms_token_table");
 	bin_start = bin_pos(out_bin_file);
 	off = 0;
@@ -483,18 +476,18 @@ static void write_src(FILE *out_bin_file, const char *out_bin_name)
 		printf("\t.short\t%d\n", best_idx[i]);
 	printf("\n");
 
+	stamp("write token table");
+
 	output_label("kallsyms_offsets");
 
 	for (i = 0; i < table_cnt; i++) {
 		if (pc_relative) {
 			long long offset = table[i]->addr - _text;
 
-			if (offset < INT_MIN || offset > INT_MAX) {
-				fprintf(stderr, "kallsyms failure: "
-					"relative symbol value %#llx out of range\n",
-					table[i]->addr);
-				exit(EXIT_FAILURE);
-			}
+			if (offset < INT_MIN || offset > INT_MAX)
+				errx(EXIT_FAILURE, "relative symbol %s value %#llx out of range",
+				     sym_entry_name(table[i]), table[i]->addr);
+
 			printf("\t.long\t_text - . + (%d)\t/* %s */\n",
 			       (int)offset, table[i]->sym);
 		} else {
@@ -505,6 +498,8 @@ static void write_src(FILE *out_bin_file, const char *out_bin_name)
 	printf(".size kallsyms_offsets, . - kallsyms_offsets\n");
 	printf("\n");
 
+	stamp("write symbol values");
+
 	sort_symbols_by_name();
 	output_label("kallsyms_seqs_of_names");
 	bin_start = bin_pos(out_bin_file);
@@ -515,6 +510,8 @@ static void write_src(FILE *out_bin_file, const char *out_bin_name)
 	}
 	write_incbin(out_bin_name, bin_start, bin_pos(out_bin_file));
 	printf("\n");
+
+	stamp("write name index");
 }
 
 static unsigned int token_index(unsigned char first, unsigned char second)
@@ -742,10 +739,13 @@ static void insert_real_symbols_in_table(void)
 static void optimize_token_table(void)
 {
 	build_initial_token_table();
+	stamp("build initial token table");
 
 	insert_real_symbols_in_table();
+	stamp("insert real symbols in table");
 
 	optimize_result();
+	stamp("optimize result");
 }
 
 /* guess for "linker script provide" symbol */
@@ -822,6 +822,25 @@ static void sort_symbols(void)
 	qsort(table, table_cnt, sizeof(table[0]), compare_symbols);
 }
 
+static void usage(void)
+{
+	fprintf(stderr,
+		"Usage: kallsyms [options] vmlinux out.bin > out.S\n"
+		"       kallsyms --sysmap=out.map vmlinux\n"
+		"           --all-symbols     Include all local symbols\n"
+		"           --pc-relative     Output symbol offsets\n"
+		"           --sysmap=out.map  Text map file\n"
+		"           --verbose         Extra diagnostic output\n"
+		"           vmlinux: File to read, can be empty\n"
+		"           out.S: Assembler source output file.\n"
+		"           out.bin: Binary data; included in out.S using .incbin\n"
+		"       In the second form only the symbol table out.map is generated,\n"
+		"       the compressed data is not generated.\n"
+		"       --pc-relative is required for all 64 bit kernels and relocatable\n"
+		"       32 bit ones.\n");
+	exit(EXIT_FAILURE);
+}
+
 int main(int argc, char **argv)
 {
 	const char *in, *sysmap = NULL, *out_bin_name;
@@ -832,6 +851,7 @@ int main(int argc, char **argv)
 			{"all-symbols",     no_argument, &all_symbols,     1},
 			{"pc-relative",     no_argument, &pc_relative,     1},
 			{"sysmap",    required_argument, NULL,           's'},
+			{"verbose",         no_argument, &verbose,         1},
 			{},
 		};
 
@@ -845,49 +865,57 @@ int main(int argc, char **argv)
 			usage();
 	}
 
+	stamp(NULL);
+
 	if (optind + 2 != argc && !(sysmap && optind + 1 == argc))
 		usage();
 
 	in = argv[optind];
 	if (sysmap) {
 		sysmap_out = fopen(sysmap, "w");
-		if (!sysmap_out) {
-			perror(sysmap);
-			exit(EXIT_FAILURE);
-		}
+		if (!sysmap_out)
+			err(EXIT_FAILURE, "failed to open sysmap output file %s", sysmap);
 	}
 
 	if (optind + 1 == argc) {
 		read_elf(in, sysmap_out);
-		if (ferror(sysmap_out) || fclose(sysmap_out)) {
-			perror(sysmap);
-			exit(EXIT_FAILURE);
-		}
+		fflush(sysmap_out);
+		if (ferror(sysmap_out) || fclose(sysmap_out))
+			errx(EXIT_FAILURE, "error writing sysmap file %s", sysmap);
 		return 0;
 	}
 
 	out_bin_name = argv[optind + 1];
 	out_bin_file = fopen(out_bin_name, "w");
-	if (!out_bin_file) {
-		perror(out_bin_name);
-		exit(EXIT_FAILURE);
-	}
+	if (!out_bin_file)
+		err(EXIT_FAILURE, "failed to open out.bin file %s", out_bin_name);
 
 	read_elf(in, sysmap_out);
-	if (sysmap_out && (ferror(sysmap_out) || fclose(sysmap_out))) {
-		perror(sysmap);
-		exit(EXIT_FAILURE);
+	if (sysmap_out) {
+		fflush(sysmap_out);
+		if (ferror(sysmap_out) || fclose(sysmap_out))
+			errx(EXIT_FAILURE, "error writing sysmap file %s", sysmap);
 	}
+	stamp("read elf");
+
 	shrink_table();
+	stamp("shrink table");
+
 	sort_symbols();
+	stamp("sort symbols");
+
 	optimize_token_table();
+
 	write_src(out_bin_file, out_bin_name);
 
 	/* Write errors are latched in the stream, so one check at the end covers them all. */
-	if (ferror(out_bin_file) || fclose(out_bin_file)) {
-		perror(out_bin_name);
-		exit(EXIT_FAILURE);
-	}
+	fflush(out_bin_file);
+	if (ferror(out_bin_file) || fclose(out_bin_file))
+		errx(EXIT_FAILURE, "error writing out.bin file %s", out_bin_name);
+
+	fflush(stdout);
+	if (ferror(stdout))
+		errx(EXIT_FAILURE, "error writing output file");
 
 	return 0;
 }
-- 
2.39.5

