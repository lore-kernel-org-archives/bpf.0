Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398393;
	b=IvvI52Tp4h8Xy47x9LwpumW7uISi4e60NW7NrXMEAJl7hrcbOWC5ZqAXxPyvIxcri9Dg
	 vsE3lKP1xjxsShzFJ7HmVDm6YuFK+f2BfJpgz48/v4Q7+u2xnc92oUMRDDYpr8z3O/VG/
	 KzceXU6rdxFwHGQ6IF7zUk31IjpiJ2ZBsc1mc46YctylzSTYte/iMUDkPAIYGz17Qp3GO
	 8eI6XWXN7zlPYhd06VWN+ALpYff1yln9KL6YxuFev+dxXb6JvaaR45J1ClS2S9CWL5NWp
	 qLB7WAZGSk58bQOKMBJ9x5NEK2+0X/j8AnFwJIQ4OEPht69WuOJb7ram7UsMf6jzlfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398393;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OLAomnyrsjeNiY2lkcnDf9o4rt/Z5zdq1DKyqCjrrn4=;
	b=s9+p+LD7ZglMu8crK9jwEaKLrjIxjnet5mwSKLjNwob2a/kEZfDa3m6ZtFb+7jRlRC/m
	 PdcEDiKNUtXweldFuEvjHnsuLAbh6/dVpQdMebdpD7vdDIlhiR/TOjlcoyj7V46N5g7bX
	 Ti9sWgqRFgyo/JoZT95mIL665Rd2IieKrc1mzqrcxLziftPOoQNVQo/TEqFVQTtl1CxwD
	 z9twK69u0FqERYFqcjWe8LKMitKzzxCZ28foh/43aDlpfUjxCX27inzP74Ni1JYD7ujmv
	 Zx1EUO7ueLgQpN0epk1q/A2Gxv6R1iTvUO9kQPQpSjiJeGSCYgjwuKRDJ99/tni45Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=OUgNfAgq;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E0360A2617;
	Wed, 11 Nov 2026 11:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27E0360A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=OUgNfAgq
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xR6zN-001SvT-4W; Wed, 11 Nov 2026 12:59:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=OLAomnyrsjeNiY2lkcnDf9o4rt/Z5zdq1DKyqCjrrn4=; b=OUgNfAgquLPHycE2cfy4B1tNFH
	Rdo0N9mhHCn16t1gv3QonGU9ESfv7h2a/mA9C1z2d2aQ/bj0q1jgzWjWz74Aogcd/dPxQ1gXP7sLM
	nAJSEGXa+aUgm+xk28RGKTTY67gBAuS8+6bPx2gp4srnJ8a4dGLebLFIS6AFf2UOFKk2Hr1FzdqIx
	ZNrIqSkVdP3yDVOBckUVBqEYggHU7u47KQm3x3mz8gMzi+XWQoxCZFRA8dnRahHdPq/bzirf6a+j1
	x0RyPR/3avo9Lv4WPocuMt7yIlu+JhsZ+nJ7QrtiWXRaZkeHLqe2sFYQuCD4oC1OQdmls/Rcu2V4u
	LndGqlPg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xR6zH-0000Us-Bg; Wed, 11 Nov 2026 12:59:35 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xR6z6-001mRM-GA;
	Wed, 11 Nov 2026 12:59:24 +0100
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
Subject: [PATCH v3 next 04/13] scripts/kallsyms: make use of binary data output optional
Date: Wed, 11 Nov 2026 11:59:02 +0000
Message-Id: <20261111115911.1142000-5-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261111115911.1142000-1-david.laight.linux@gmail.com>
References: <20261111115911.1142000-1-david.laight.linux@gmail.com>
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

While writing some of the output in binary (and using the .incbin directive
to get the assembler to read it) speeds up normal kernel builds, it makes
debugging kallsyms almost impossible.

Change the command line processing so that the out.bin file is optional,
if absent everything is written to out.S (at is was prior to 83da9f3197e5).

To make the command line parsing possible the argument to --sysmap is made
optional, if absent the sysmap output is written to stdout and the
compression code skipped.

Instead of requiring an empty input file when generating .tmp_vmlinux0.kallsyms
make the input file itself optional.

There is no need to use ftell() to find the offset in the out.bin file
(and worry about it failing), the code knows exactly how many bytes have
been written to the file - so use that instead.

To help anyone who ends up looking an hexdump of out.bin, add a text header
and 16 byte align each table.
The size is noise and it doesn't affect the assembler.

Extract the target endianness from the elf input file and use it to write
the 'markers' table array to the out.bin file.
Use fwrite() for all the symbols entries - faster than printf().

Reduces the time on my system for:
scripts/kallsyms --all-symbols --pc-relative .tmp_vmlinux2 /dev/null >/dev/null
from 194 ms to 185ms.

Output the token table first and always to out.S (it doesn't take long).
This makes the out.S file diffable even with minor changes.

The re-instated printf() use %u for bytes, shorter than 0x%02x and just
as good since the data isn't really a table with columns.
But don't worry too much about the file size when the binary file isn't
specified.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

New patch for v3.
Makes the ols patch 14 redundant.

 scripts/kallsyms-sysmap.c |   1 +
 scripts/kallsyms.c        | 293 ++++++++++++++++++++++++--------------
 scripts/kallsyms.h        |   1 +
 scripts/link-vmlinux.sh   |   7 +-
 4 files changed, 191 insertions(+), 111 deletions(-)

diff --git a/scripts/kallsyms-sysmap.c b/scripts/kallsyms-sysmap.c
index a482968eba51..6897eddd724f 100644
--- a/scripts/kallsyms-sysmap.c
+++ b/scripts/kallsyms-sysmap.c
@@ -224,6 +224,7 @@ struct sysmap *sysmap_read(const char *path)
 		exit(EXIT_FAILURE);
 	map->syms = elf_read_symbols(&map->elf, &map->nr_syms);
 	map->addr_width = elf_map_long_size(map->elf.base) * 2;
+	map->big_endian = elf_map_big_endian(map->elf.base);
 
 	return map;
 }
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index aa3a8ec83fbb..74db751600b4 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -60,6 +60,11 @@ static int all_symbols;
 static int pc_relative;
 static int verbose;
 
+static int big_endian;	/* Extracted from the elf file */
+
+static const char *out_bin_name;
+static FILE *out_bin_file;
+
 /* A dynamic array of symbols, encoded by symbol index. */
 struct sym_arr {
 	unsigned int *sym_indexes;
@@ -278,26 +283,16 @@ static void add_table_entry(struct sym_entry *sym)
 	table[table_cnt++] = sym;
 }
 
-static bool file_is_empty(const char *path)
-{
-	struct stat st;
-
-	if (stat(path, &st))
-		err(EXIT_FAILURE, "stat(%s) failed", path);
-
-	return st.st_size == 0;
-}
-
 /*
- * Read the symbols from vmlinux, writing System.map if asked to. The first
- * link has no symbols yet: an empty file gives an empty table.
+ * Read the symbols from vmlinux, writing System.map if asked to.
+ * The first link has no symbols yet: an absent file gives an empty table.
  */
 static void read_elf(const char *path, FILE *sysmap_out)
 {
 	struct sysmap *map;
 	size_t i;
 
-	if (file_is_empty(path))
+	if (!path || !*path)
 		return;
 
 	map = sysmap_read(path);
@@ -312,6 +307,8 @@ static void read_elf(const char *path, FILE *sysmap_out)
 			add_table_entry(sym);
 	}
 
+	big_endian = map->big_endian;
+
 	sysmap_free(map);
 }
 
@@ -322,22 +319,34 @@ static void output_label(const char *label)
 	printf("%s:\n", label);
 }
 
-static long bin_pos(FILE *file)
+static void write_incbin_header(const char *msg, unsigned long *bin_offset)
 {
-	const long pos = ftell(file);
+	static unsigned char marker[18] = "################" "#";
+	static unsigned char nulls[16];
+	unsigned long off;
 
-	if (pos < 0)
-		err(EXIT_FAILURE, "ftell on bin.out file failed");
+	if (!out_bin_file)
+		return;
 
-	return pos;
+	off = *bin_offset;
+
+	/* 16 byte align and add header for diagnostic hexdumps */
+	off += fwrite(nulls, 1, -off & 15, out_bin_file);
+	off += fwrite(marker, 1, 16 + 2, out_bin_file);
+	off += fwrite(msg, 1, strlen(msg), out_bin_file);
+	off += fwrite(nulls, 1, -off & 15, out_bin_file);
+	off += fwrite(marker, 1, 16, out_bin_file);
+
+	*bin_offset = off;
 }
 
-static void write_incbin(const char *filename, long start, long end)
+static void write_incbin(unsigned long *bin_offset, unsigned long size)
 {
-	if (start >= end)
+	if (!out_bin_name || !size)
 		return;
 
-	printf("\t.incbin \"%s\", %ld, %ld\n", filename, start, end - start);
+	printf("\t.incbin \"%s\", %ld, %ld\n", out_bin_name, *bin_offset, size);
+	*bin_offset += size;
 }
 
 /* uncompress a compressed symbol. When this function is called, the best table
@@ -392,13 +401,15 @@ static void sort_symbols_by_name(void)
 	qsort(table, table_cnt, sizeof(table[0]), compare_names);
 }
 
-static void write_src(FILE *out_bin_file, const char *out_bin_name)
+static void write_src(void)
 {
-	unsigned int i, off;
+	unsigned int i, k, len, off, seq;
 	unsigned int best_idx[256];
 	unsigned int *markers, markers_cnt;
-	long bin_start;
+	unsigned long bin_offset = 0;
 	char buf[1 + KSYM_NAME_LEN];
+	struct sym_entry *se;
+	const char *sep;
 
 	printf("\t.section .rodata, \"a\"\n");
 
@@ -406,51 +417,105 @@ static void write_src(FILE *out_bin_file, const char *out_bin_name)
 	printf("\t.long\t%u\n", table_cnt);
 	printf("\n");
 
+	output_label("kallsyms_token_table");
+	off = 0;
+	for (i = 0; i < 256; i++) {
+		len = expand_symbol(best_table[i], best_table_len[i], buf);
+		best_idx[i] = off;
+		off += len + 1;
+		printf("\t.asciz\t\"%s\"\n", buf);
+	}
+	printf(".size kallsyms_token_table, . - kallsyms_token_table\n");
+	printf("\n");
+
+	output_label("kallsyms_token_index");
+	sep = "\t.short\t";
+	for (i = 0; i < 256; i++) {
+		printf("%s%d", sep, best_idx[i]);
+		sep = (i + 1) & 15 ? "," : "\n\t.short\t";
+	}
+	printf("\n");
+	printf(".size kallsyms_token_index, . - kallsyms_token_index\n");
+	printf("\n");
+
+	stamp("write token table");
+
 	/* table of offset markers, that give the offset in the compressed stream
 	 * every 256 symbols */
 	markers_cnt = (table_cnt + 255) / 256;
 	markers = xmalloc(sizeof(*markers) * markers_cnt);
 
 	output_label("kallsyms_names");
-	bin_start = bin_pos(out_bin_file);
+	write_incbin_header("names", &bin_offset);
 	off = 0;
 	for (i = 0; i < table_cnt; i++) {
-		if ((i & 0xFF) == 0)
-			markers[i >> 8] = off;
-		table[i]->seq = i;
+		unsigned int se_len, len_len;
+		unsigned char len[2];
+
+		se = table[i];
+		se->seq = i;
 
 		/* The length must be less than that of the original symbol. */
-		if (!table[i]->len || table[i]->len > KSYM_NAME_LEN)
+		if (!se->len || se->len > KSYM_NAME_LEN)
 			errx(EXIT_FAILURE, "symbol %d has corrupt compressed length %d",
-			     i, table[i]->len);
+			     i, se->len);
+
+		/* Generate the original name */
+		se_len = expand_symbol(se->sym, se->len, buf);
 
 		/* Encode length with ULEB128. */
-		if (table[i]->len <= 0x7F) {
+		if (se->len <= 0x7F) {
 			/* Most symbols use a single byte for the length. */
-			fputc(table[i]->len, out_bin_file);
-			off += table[i]->len + 1;
+			len[0] = se->len;
+			len_len = 1;
 		} else {
 			/* "Big" symbols use two bytes. */
-			fputc((table[i]->len & 0x7F) | 0x80, out_bin_file);
-			fputc((table[i]->len >> 7) & 0x7F, out_bin_file);
-			off += table[i]->len + 2;
+			len[0] = 0x80 | se->len;
+			len[1] = se->len >> 7;
+			len_len = 2;
 		}
-		fwrite(table[i]->sym, 1, table[i]->len, out_bin_file);
 
-		/*
-		 * Now that we wrote out the compressed symbol name, restore the
-		 * original name for the comments below.
-		 */
-		expand_symbol(table[i]->sym, table[i]->len, buf);
-		strcpy((char *)table[i]->sym, buf);
+		if (out_bin_file) {
+			if ((i & 0xFF) == 0)
+				markers[i >> 8] = big_endian ? htobe32(off) : htole32(off);
+
+			fwrite(len, 1, len_len, out_bin_file);
+			fwrite(se->sym, 1, se->len, out_bin_file);
+		} else {
+			if ((i & 0xFF) == 0)
+				markers[i >> 8] = off;
+
+			printf("\t.byte\t%u", len[0]);
+			if (len_len == 2)
+				printf(",%u", len[1]);
+
+			for (k = 0; k < se->len; k++)
+				printf(",%u", se->sym[k]);
+			printf("\t/* %c %s */\n", buf[0], buf + 1);
+		}
+		off += len_len + se->len;
+
+		/* Restore the original name. */
+		se->len = se_len;
+		memcpy(se->sym, buf, se_len + 1);
 	}
-	write_incbin(out_bin_name, bin_start, bin_pos(out_bin_file));
+	write_incbin(&bin_offset, off);
 	printf(".size kallsyms_names, . - kallsyms_names\n");
 	printf("\n");
 
 	output_label("kallsyms_markers");
-	for (i = 0; i < markers_cnt; i++)
-		printf("\t.long\t%u\n", markers[i]);
+	if (out_bin_file) {
+		write_incbin_header("markers", &bin_offset);
+		fwrite(markers, sizeof(*markers), markers_cnt, out_bin_file);
+		write_incbin(&bin_offset, sizeof(*markers) * markers_cnt);
+	} else {
+		sep = "\t.long\t";
+		for (i = 0; i < markers_cnt; i++) {
+			printf("%s%u", sep, markers[i]);
+			sep = (i + 1) & 7 ? "," : "\n\t.long\t";
+		}
+		printf("\n");
+	}
 	printf(".size kallsyms_markers, . - kallsyms_markers\n");
 	printf("\n");
 
@@ -458,31 +523,15 @@ static void write_src(FILE *out_bin_file, const char *out_bin_name)
 
 	stamp("write compressed names");
 
-	output_label("kallsyms_token_table");
-	bin_start = bin_pos(out_bin_file);
-	off = 0;
-	for (i = 0; i < 256; i++) {
-		best_idx[i] = off;
-		expand_symbol(best_table[i], best_table_len[i], buf);
-		fwrite(buf, 1, strlen(buf) + 1, out_bin_file);
-		off += strlen(buf) + 1;
-	}
-	write_incbin(out_bin_name, bin_start, bin_pos(out_bin_file));
-	printf(".size kallsyms_token_table, . - kallsyms_token_table\n");
-	printf("\n");
-
-	output_label("kallsyms_token_index");
-	for (i = 0; i < 256; i++)
-		printf("\t.short\t%d\n", best_idx[i]);
-	printf("\n");
-
-	stamp("write token table");
-
 	output_label("kallsyms_offsets");
 
 	for (i = 0; i < table_cnt; i++) {
 		if (pc_relative) {
+			/* All 64 bit builds and (at least) relocatable 32 bit ones */
+			static char line[] = "\t.long\t_text - . +123456789";
+			char *end = line + sizeof(line) - 1;
 			long long offset = table[i]->addr - _text;
+			int off32;
 
 			if (offset < INT_MIN || offset > INT_MAX) {
 				errx(EXIT_FAILURE, "kallsyms failure: "
@@ -490,12 +539,28 @@ static void write_src(FILE *out_bin_file, const char *out_bin_name)
 					table[i]->addr);
 				exit(EXIT_FAILURE);
 			}
-			printf("\t.long\t_text - . + (%d)\t/* %s */\n",
-			       (int)offset, table[i]->sym);
+
+			/* Build the line so the the faster fwrite() can be used */
+			*end-- = out_bin_file ? '\n' : '\t';
+			memset(end - 8, ' ', 8);
+			off32 = offset;
+			if (off32 < 0) {
+				end[-9] = '-';
+				offset = -off32;
+			} else {
+				end[-9] = '+';
+			}
+			do
+				*end-- = '0' + off32 % 10;
+			while (off32 /= 10);
+
+			fwrite(line, 1, sizeof(line), stdout);
 		} else {
-			printf("\t.long\t%#x\t/* %s */\n",
-			       (unsigned int)table[i]->addr, table[i]->sym);
+			printf("\t.long\t%#x%c", (unsigned int)table[i]->addr,
+			       out_bin_file ? '\n' : '\t');
 		}
+		if (!out_bin_file)
+			printf("/* %c %s */\n", table[i]->sym[0], table[i]->sym + 1);
 	}
 	printf(".size kallsyms_offsets, . - kallsyms_offsets\n");
 	printf("\n");
@@ -503,17 +568,29 @@ static void write_src(FILE *out_bin_file, const char *out_bin_name)
 	stamp("write symbol values");
 
 	sort_symbols_by_name();
+	stamp("sort by name");
+
 	output_label("kallsyms_seqs_of_names");
-	bin_start = bin_pos(out_bin_file);
+	write_incbin_header("seq_of_names", &bin_offset);
 	for (i = 0; i < table_cnt; i++) {
-		fputc(table[i]->seq >> 16, out_bin_file);
-		fputc(table[i]->seq >> 8, out_bin_file);
-		fputc(table[i]->seq >> 0, out_bin_file);
+		se = table[i];
+		seq = se->seq;
+		if (out_bin_file) {
+			unsigned int seq_be = htobe32(seq);
+			fwrite((char *)&seq_be + 1, 1, 3, out_bin_file);
+		} else {
+			/* The three spaces before the tab line up the comments */
+			printf("\t.byte\t%u,%u,%u   \t/* %8d %c %s */\n",
+				seq >> 16, (seq >> 8) & 0xff, seq & 0xff,
+				seq, se->sym[0], se->sym + 1);
+		}
 	}
-	write_incbin(out_bin_name, bin_start, bin_pos(out_bin_file));
-	printf("\n");
+	write_incbin(&bin_offset, table_cnt * 3);
+	printf(".size kallsyms_seqs_of_names, . - kallsyms_seqs_of_names\n");
 
 	stamp("write name index");
+
+	write_incbin_header("end", &bin_offset);
 }
 
 static unsigned int token_index(unsigned char first, unsigned char second)
@@ -827,13 +904,13 @@ static void sort_symbols(void)
 static void usage(void)
 {
 	fprintf(stderr,
-		"Usage: kallsyms [options] vmlinux out.bin > out.S\n"
-		"       kallsyms --sysmap=out.map vmlinux\n"
+		"Usage: kallsyms [options] [vmlinux [out.bin]] > out.S\n"
+		"       kallsyms --sysmap vmlinux > out.map\n"
 		"           --all-symbols     Include all local symbols\n"
-		"           --pc-relative     Output symbols offsets\n"
+		"           --pc-relative     Output symbol offsets\n"
 		"           --sysmap=out.map  Text map file\n"
 		"           --verbose         Extra diagnostic output\n"
-		"           vmlinux: File to read, can be empty\n"
+		"           vmlinux: File to read\n"
 		"           out.S: Assembler source output file.\n"
 		"           out.bin: Binary data; included in out.S using .incbin\n"
 		"       In the second form only the symbol table out.map is generated,\n"
@@ -845,14 +922,14 @@ static void usage(void)
 
 int main(int argc, char **argv)
 {
-	const char *in, *sysmap = NULL, *out_bin_name;
-	FILE *sysmap_out = NULL, *out_bin_file;
+	const char *sysmap = NULL;
+	FILE *sysmap_out = NULL;
 
 	while (1) {
 		static const struct option long_options[] = {
 			{"all-symbols",     no_argument, &all_symbols,     1},
 			{"pc-relative",     no_argument, &pc_relative,     1},
-			{"sysmap",    required_argument, NULL,           's'},
+			{"sysmap",    optional_argument, NULL,           's'},
 			{"verbose",         no_argument, &verbose,         1},
 			{},
 		};
@@ -862,44 +939,44 @@ int main(int argc, char **argv)
 		if (c == -1)
 			break;
 		if (c == 's')
-			sysmap = optarg;
+			sysmap = optarg ?: "";
 		else if (c != 0)
 			usage();
 	}
 
 	stamp(NULL);
 
-	if (optind + 2 != argc && !(sysmap && optind + 1 == argc))
+	if (argc - optind > 2)
 		usage();
 
-	in = argv[optind];
 	if (sysmap) {
-		sysmap_out = fopen(sysmap, "w");
-		if (!sysmap_out)
-			err(EXIT_FAILURE, "failed to open sysmap output file %s", sysmap);
-	}
-
-	if (optind + 1 == argc) {
-		read_elf(in, sysmap_out);
-		fflush(sysmap_out);
-		if (ferror(sysmap_out) || fclose(sysmap_out))
-			errx(EXIT_FAILURE, "error writing sysmap file %s", sysmap);
-		return 0;
+		if (*sysmap) {
+			sysmap_out = fopen(sysmap, "w");
+			if (!sysmap_out)
+				err(EXIT_FAILURE, "failed to open sysmap output file %s", sysmap);
+		} else {
+			/* Compressed output supressed */
+			sysmap_out = stdout;
+		}
 	}
 
-	out_bin_name = argv[optind + 1];
-	out_bin_file = fopen(out_bin_name, "w");
-	if (!out_bin_file)
-		err(EXIT_FAILURE, "failed to open nin.out file %s", out_bin_name);
-
-	read_elf(in, sysmap_out);
+	read_elf(argv[optind], sysmap_out);
 	if (sysmap_out) {
 		fflush(sysmap_out);
 		if (ferror(sysmap_out) || fclose(sysmap_out))
 			errx(EXIT_FAILURE, "error writing sysmap file %s", sysmap);
+		if (sysmap_out == stdout)
+			exit(0);
 	}
 	stamp("read elf");
 
+	if (argc - optind >= 2) {
+		out_bin_name = argv[optind + 1];
+		out_bin_file = fopen(out_bin_name, "w");
+		if (!out_bin_file)
+			err(EXIT_FAILURE, "failed to open bin.out file %s", out_bin_name);
+	}
+
 	shrink_table();
 	stamp("shrink table");
 
@@ -908,12 +985,14 @@ int main(int argc, char **argv)
 
 	optimize_token_table();
 
-	write_src(out_bin_file, out_bin_name);
+	write_src();
 
 	/* Write errors are latched in the stream, so one check at the end covers them all. */
-	fflush(out_bin_file);
-	if (ferror(out_bin_file) || fclose(out_bin_file))
-		errx(EXIT_FAILURE, "error writing out.bin file %s", out_bin_name);
+	if (out_bin_file) {
+		fflush(out_bin_file);
+		if (ferror(out_bin_file) || fclose(out_bin_file))
+			errx(EXIT_FAILURE, "error writing out.bin file %s", out_bin_name);
+	}
 
 	fflush(stdout);
 	if (ferror(stdout))
diff --git a/scripts/kallsyms.h b/scripts/kallsyms.h
index 4b2801ba6285..c5ead7e60570 100644
--- a/scripts/kallsyms.h
+++ b/scripts/kallsyms.h
@@ -34,6 +34,7 @@ struct sysmap {
 	struct sysmap_symbol *syms;
 	size_t nr_syms;
 	int addr_width;		/* hex digits of an address */
+	int big_endian;
 	struct elf_file elf;	/* the mapping the names point into */
 };
 
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index d5710e900bd4..44b5a6d78ce5 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -141,7 +141,7 @@ kallsyms()
 	fi
 
 	info KSYMS "${2}.S"
-	scripts/kallsyms ${kallsymopt} "${1}" "${2}.bin" > "${2}.S"
+	scripts/kallsyms ${kallsymopt} ${1:+"${1}" "${2}.bin"} > "${2}.S"
 
 	info AS "${2}.o"
 	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
@@ -162,7 +162,7 @@ sysmap_and_kallsyms()
 mksysmap()
 {
 	info SYSMAP ${2}
-	scripts/kallsyms --sysmap="${2}" "${1}"
+	scripts/kallsyms --sysmap "${1}" >"${2}"
 }
 
 sorttable()
@@ -213,8 +213,7 @@ case "${WARN_ON_UNUSED_TRACEPOINTS}" in
 esac
 
 if is_enabled CONFIG_KALLSYMS; then
-	true > .tmp_vmlinux0.syms
-	kallsyms .tmp_vmlinux0.syms .tmp_vmlinux0.kallsyms
+	kallsyms "" .tmp_vmlinux0.kallsyms
 fi
 
 if is_enabled CONFIG_KALLSYMS || is_enabled CONFIG_DEBUG_INFO_BTF; then
-- 
2.39.5

