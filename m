Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F33E3CC32E;
	Sun, 18 Oct 2026 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338801; cv=none; b=XbwxnXwmT4N+8zkGTrQaWO56XyJ2T1yw0MPIMnSD/5D5cBxmIwGKw79bHy2RrbmSKcTn+q9YwRLgH3a0OcEzEcWMxHtFdzc4QZ5a6nszlTuEScd4oAPouRU2srjTv9fweSwzKZqt6qVT8hHeVtztvzRtIXxpOQFLRu0zR/psXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338801; c=relaxed/simple;
	bh=i1EzgNJL2S9vOfb5HZhYVap6XLyQf3vqrUkue/U4mNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E+lrU3m6sI3CnhOc9XmF7br8IpJiB8p4n317CI9tjlD4VJsyjmXzl0sHIjuxntftLYnQDhjAMKBh3ca9mJQ7+7esomVVD0bnX/zqWFW7SWV4BpsRRNaaql9oMpBkVwyzmBrHlCGTaVkw2kfAL/dsZEYgxAmG7/g/5gqOAIRTsvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=VtoHCC/S; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="VtoHCC/S"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC4-001KBK-JB; Sun, 18 Oct 2026 17:53:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=onZbcfovHqzmXwY+mqMgdCZsa6Vs2UJUZMC/6Kvk400=; b=VtoHCC/ShOmdtVZsIgjjMtmLyX
	OaSjp7vE0I8DcveP2RFBRqKH6cnQBSEHtET+vCTGd6Er6c42m5OpR+RVTmJgUBi7DyH0AaPSpTsdi
	6nbyThM759mUrzFIfTDxa1l2rio/bMYlqRYybjNbKCESsUz+y6AUku1pv5/SLTJ9jV/LBCgNuymrw
	y9YYgekMCUghktRFJ29zWc/csj2qdUVlIi13NcKLDr2iFMvdSA7XOx2YFXfxFxSPeOFf+2G86Rc4s
	6VLzdKx3V1tIAj/q+lhSKb9h22Oji0Lmnjp/6xLwqJCdccEnVAmLnMQPKpdHlzY5NJjpfnTribNnn
	9gDh/mhA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITBz-0001pi-Av; Sun, 18 Oct 2026 17:52:59 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xITBi-004q3U-Pv;
	Sun, 18 Oct 2026 17:52:42 +0200
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Kees Cook <kees@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 next 10/15] kallsyms: scripts/kallsyms: Rename some variables for clarity
Date: Sun, 18 Oct 2026 16:52:01 +0100
Message-Id: <20261018155206.132411-11-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261018155206.132411-1-david.laight.linux@gmail.com>
References: <20261018155206.132411-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the array that holds the symbol table from table[] to symbol[].
The typical use is then symbol[i] - giving the data for the i'th symbol.
Rename table_size to symbol_table_size and table_cnt to symbol_cnt to match.
Save repetetive code by using struct sym_entry *se = symbol[i] in loops.
(That might make the code better because it saves reloading the pointers,
or make it worse because it causes a spill to stack.)

Add a comment block explaining token_profit[] (it used to have a short
comment when it was the 'profit' field of a struct) and add defines
LEFT(), RIGHT() and PAIR() for converting token pairs to/from indexes.

Put the two arrays that contain info about the tokens used the
compressed data into an 'array of struct'.
This should give better d-cache locality.
No idea why they were called best_table[] - the search gives the
'best token' but the value is a 'token' not a 'best'.
(You can't use 'symbol' for the compression output because the code
is compressing a symbol table.)

No logic changes and the output file is unchanged.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 scripts/kallsyms.c | 154 ++++++++++++++++++++++++---------------------
 1 file changed, 83 insertions(+), 71 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index d2d3ac8c33a1..5603b2a6c77b 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -54,19 +54,29 @@ static struct addr_range text_ranges[] = {
 #define text_range_text     (&text_ranges[0])
 #define text_range_inittext (&text_ranges[1])
 
-static struct sym_entry **table;
-static unsigned int table_size, table_cnt;
+static struct sym_entry **symbol;
+static unsigned int symbol_table_size, symbol_cnt;
 static int all_symbols;
 static int pc_relative;
 /* Default to one kallsyms_markers[] entry for each 256 symbols */
 static unsigned long marker_shift = 8;
 
+/*
+ * token_profit[PAIR(left, right)] is the number of times the characters
+ * left and right appear adjacent (in that order) and is usually the same
+ * as the number of bytes saved (the profit) by replacing the pair with
+ * a single byte token.
+ */
+#define LEFT(pair) ((pair) & 0xff)
+#define RIGHT(pair) ((pair) >> 8)
+#define PAIR(left, right) ((left) | (right) << 8)
 static int token_profit[0x10000];
 
 /* the table that holds the result of the compression */
-static unsigned char best_table[256][2];
-static unsigned char best_table_len[256];
-
+static struct token_table {
+	unsigned short len;
+	unsigned char  ch[2];
+} token_table[256];
 
 static void usage(void)
 {
@@ -234,16 +244,16 @@ static void shrink_table(void)
 	unsigned int i, pos;
 
 	pos = 0;
-	for (i = 0; i < table_cnt; i++) {
-		if (symbol_valid(table[i])) {
+	for (i = 0; i < symbol_cnt; i++) {
+		if (symbol_valid(symbol[i])) {
 			if (pos != i)
-				table[pos] = table[i];
+				symbol[pos] = symbol[i];
 			pos++;
 		} else {
-			free(table[i]);
+			free(symbol[i]);
 		}
 	}
-	table_cnt = pos;
+	symbol_cnt = pos;
 }
 
 static void read_map(const char *in)
@@ -262,14 +272,14 @@ static void read_map(const char *in)
 		if (!sym)
 			continue;
 
-		sym->seq = table_cnt;
+		sym->seq = symbol_cnt;
 
-		if (table_cnt >= table_size) {
-			table_size += 10000;
-			table = xrealloc(table, sizeof(*table) * table_size);
+		if (symbol_cnt >= symbol_table_size) {
+			symbol_table_size += 10000;
+			symbol = xrealloc(symbol, sizeof(*symbol) * symbol_table_size);
 		}
 
-		table[table_cnt++] = sym;
+		symbol[symbol_cnt++] = sym;
 	}
 
 	free(buf);
@@ -301,12 +311,12 @@ static int expand_symbol(const unsigned char *data, int len, char *result)
 		c = *data;
 		/* if the table holds a single char that is the same as the one
 		 * we are looking for, then end the search */
-		if (best_table[c][0]==c && best_table_len[c]==1) {
+		if (token_table[c].ch[0] == c && token_table[c].len == 1) {
 			*result++ = c;
 			total++;
 		} else {
 			/* if not, recurse and expand */
-			rlen = expand_symbol(best_table[c], best_table_len[c], result);
+			rlen = expand_symbol(token_table[c].ch, token_table[c].len, result);
 			total += rlen;
 			result += rlen;
 		}
@@ -340,7 +350,7 @@ static int compare_names(const void *a, const void *b)
 
 static void sort_symbols_by_name(void)
 {
-	qsort(table, table_cnt, sizeof(table[0]), compare_names);
+	qsort(symbol, symbol_cnt, sizeof(symbol[0]), compare_names);
 }
 
 static void write_src(void)
@@ -348,46 +358,47 @@ static void write_src(void)
 	unsigned int i, k, off, off_size, table_size;
 	unsigned int best_idx[256];
 	char buf[1 + KSYM_NAME_LEN];
+	struct sym_entry *se;
 
 	printf("\t.section .rodata, \"a\"\n");
 
-	output_value("kallsyms_num_syms", table_cnt);
+	output_value("kallsyms_num_syms", symbol_cnt);
 
 	output_label("kallsyms_names");
 	off = 0;
-	for (i = 0; i < table_cnt; i++) {
-		table[i]->seq = off;
+	for (i = 0; i < symbol_cnt; i++) {
+		se = symbol[i];
+		se->seq = off;
 
 		/* There cannot be any symbol of length zero. */
-		if (table[i]->len == 0)
+		if (se->len == 0)
 			errx(1, "unexpected zero symbol length");
 
 		/* Only lengths that fit in up-to-two-byte ULEB128 are supported. */
-		if (table[i]->len > 0x3FFF)
+		if (se->len > 0x3FFF)
 			errx(1, "unexpected huge symbol length");
 
 		/* Encode length with ULEB128. */
-		if (table[i]->len <= 0x7F) {
+		if (se->len <= 0x7F) {
 			/* Most symbols use a single byte for the length. */
-			printf("\t.byte 0x%02x", table[i]->len);
-			off += table[i]->len + 1;
+			printf("\t.byte 0x%02x", se->len);
+			off += se->len + 1;
 		} else {
 			/* "Big" symbols use two bytes. */
 			printf("\t.byte 0x%02x, 0x%02x",
-				(table[i]->len & 0x7F) | 0x80,
-				(table[i]->len >> 7) & 0x7F);
-			off += table[i]->len + 2;
+				(se->len & 0x7F) | 0x80, (se->len >> 7) & 0x7F);
+			off += se->len + 2;
 		}
-		for (k = 0; k < table[i]->len; k++)
-			printf(", 0x%02x", table[i]->sym[k]);
+		for (k = 0; k < se->len; k++)
+			printf(", 0x%02x", se->sym[k]);
 
 		/*
 		 * Now that we wrote out the compressed symbol name, restore the
 		 * original name and print it in the comment.
 		 */
-		expand_symbol(table[i]->sym, table[i]->len, buf);
-		strcpy((char *)table[i]->sym, buf);
-		printf("\t/* %s */\n", table[i]->sym);
+		expand_symbol(se->sym, se->len, buf);
+		strcpy((char *)se->sym, buf);
+		printf("\t/* %s */\n", se->sym);
 	}
 	table_size = off;
 	printf(".size kallsyms_names, . - kallsyms_names\n");
@@ -395,8 +406,8 @@ static void write_src(void)
 
 	output_value("kallsyms_marker_shift", marker_shift);
 	output_label("kallsyms_markers");
-	for (i = 0; i < table_cnt; i += 1u << marker_shift)
-		printf("\t.long\t%u\n", table[i]->seq);
+	for (i = 0; i < symbol_cnt; i += 1u << marker_shift)
+		printf("\t.long\t%u\n", symbol[i]->seq);
 	printf(".size kallsyms_markers, . - kallsyms_markers\n");
 	printf("\n");
 
@@ -404,7 +415,7 @@ static void write_src(void)
 	off = 0;
 	for (i = 0; i < 256; i++) {
 		best_idx[i] = off;
-		expand_symbol(best_table[i], best_table_len[i], buf);
+		expand_symbol(token_table[i].ch, token_table[i].len, buf);
 		printf("\t.asciz\t\"%s\"\n", buf);
 		off += strlen(buf) + 1;
 	}
@@ -418,18 +429,19 @@ static void write_src(void)
 
 	output_label("kallsyms_offsets");
 
-	for (i = 0; i < table_cnt; i++) {
+	for (i = 0; i < symbol_cnt; i++) {
+		se = symbol[i];
 		if (pc_relative) {
-			long long offset = table[i]->addr - _text;
+			long long offset = se->addr - _text;
 
 			if (offset < INT_MIN || offset > INT_MAX)
 				errx(1, "relative symbol value %#llx out of range",
-				     table[i]->addr);
+				     se->addr);
 			printf("\t.long\t_text - . + (%d)\t/* %s */\n",
-			       (int)offset, table[i]->sym);
+			       (int)offset, se->sym);
 		} else {
 			printf("\t.long\t%#x\t/* %s */\n",
-			       (unsigned int)table[i]->addr, table[i]->sym);
+			       (unsigned int)se->addr, se->sym);
 		}
 	}
 	printf(".size kallsyms_offsets, . - kallsyms_offsets\n");
@@ -439,9 +451,10 @@ static void write_src(void)
 	off_size = table_size < (1u << 23) ? 24 : 32;
 	output_value("kallsyms_off_size", off_size);
 	output_label(off_size == 24 ? "kallsyms_off_24_of_names" : "kallsyms_off_32_of_names");
-	for (i = 0; i < table_cnt; i++) {
-		off = table[i]->seq << 1;
-		if (i && !strcmp((char *)table[i - 1]->sym + 1, (char *)table[i]->sym + 1))
+	for (i = 0; i < symbol_cnt; i++) {
+		se = symbol[i];
+		off = se->seq << 1;
+		if (i && !strcmp((char *)symbol[i - 1]->sym + 1, (char *)se->sym + 1))
 			/* Mark that this is a duplicate of the previous symbol */
 			off |= 1;
 		if (off_size == 24) {
@@ -449,10 +462,9 @@ static void write_src(void)
 			off = __builtin_bswap32(off) >> 8;
 #endif
 			printf("\t.byte\t0x%02x, 0x%02x, 0x%02x\t/* %s */\n",
-				off & 0xff, (off >> 8) & 0xff, off >> 16,
-			       table[i]->sym);
+				off & 0xff, (off >> 8) & 0xff, off >> 16, se->sym);
 		} else {
-			printf("\t.long\t%#04x\t/* %s */\n", off, table[i]->sym);
+			printf("\t.long\t%#04x\t/* %s */\n", off, se->sym);
 		}
 	}
 	/* Terminator without the 'duplicate' flag. */
@@ -471,21 +483,21 @@ static void write_src(void)
 /* table lookup compression functions */
 
 /* count all the possible tokens in a symbol */
-static void learn_symbol(const unsigned char *symbol, int len)
+static void learn_symbol(const unsigned char *sym, int len)
 {
 	int i;
 
 	for (i = 0; i < len - 1; i++)
-		token_profit[ symbol[i] + (symbol[i + 1] << 8) ]++;
+		token_profit[PAIR(sym[i], sym[i + 1])]++;
 }
 
 /* decrease the count for all the possible tokens in a symbol */
-static void forget_symbol(const unsigned char *symbol, int len)
+static void forget_symbol(const unsigned char *sym, int len)
 {
 	int i;
 
 	for (i = 0; i < len - 1; i++)
-		token_profit[ symbol[i] + (symbol[i + 1] << 8) ]--;
+		token_profit[PAIR(sym[i], sym[i + 1])]--;
 }
 
 /* do the initial token count */
@@ -493,8 +505,8 @@ static void build_initial_token_table(void)
 {
 	unsigned int i;
 
-	for (i = 0; i < table_cnt; i++)
-		learn_symbol(table[i]->sym, table[i]->len);
+	for (i = 0; i < symbol_cnt; i++)
+		learn_symbol(symbol[i]->sym, symbol[i]->len);
 }
 
 static unsigned char *find_token(unsigned char *str, int len,
@@ -516,17 +528,17 @@ static void compress_symbols(const unsigned char *str, int idx)
 	unsigned int i, len, size;
 	unsigned char *p1, *p2;
 
-	for (i = 0; i < table_cnt; i++) {
+	for (i = 0; i < symbol_cnt; i++) {
 
-		len = table[i]->len;
-		p1 = table[i]->sym;
+		len = symbol[i]->len;
+		p1 = symbol[i]->sym;
 
 		/* find the token on the symbol */
 		p2 = find_token(p1, len, str);
 		if (!p2) continue;
 
 		/* decrease the counts for this symbol's tokens */
-		forget_symbol(table[i]->sym, len);
+		forget_symbol(symbol[i]->sym, len);
 
 		size = len;
 
@@ -545,10 +557,10 @@ static void compress_symbols(const unsigned char *str, int idx)
 
 		} while (p2);
 
-		table[i]->len = len;
+		symbol[i]->len = len;
 
 		/* increase the counts for this symbol's new tokens */
-		learn_symbol(table[i]->sym, len);
+		learn_symbol(symbol[i]->sym, len);
 	}
 }
 
@@ -580,7 +592,7 @@ static void optimize_result(void)
 
 		/* if this table slot is empty (it is not used by an actual
 		 * original char code */
-		if (!best_table_len[i]) {
+		if (!token_table[i].len) {
 
 			/* find the token with the best profit value */
 			best = find_best_token();
@@ -588,12 +600,12 @@ static void optimize_result(void)
 				break;
 
 			/* place it in the "best" table */
-			best_table_len[i] = 2;
-			best_table[i][0] = best & 0xFF;
-			best_table[i][1] = (best >> 8) & 0xFF;
+			token_table[i].len = 2;
+			token_table[i].ch[0] = LEFT(best);
+			token_table[i].ch[1] = RIGHT(best);
 
 			/* replace this token in all the valid symbols */
-			compress_symbols(best_table[i], i);
+			compress_symbols(token_table[i].ch, i);
 		}
 	}
 }
@@ -603,11 +615,11 @@ static void insert_real_symbols_in_table(void)
 {
 	unsigned int i, j, c;
 
-	for (i = 0; i < table_cnt; i++) {
-		for (j = 0; j < table[i]->len; j++) {
-			c = table[i]->sym[j];
-			best_table[c][0]=c;
-			best_table_len[c]=1;
+	for (i = 0; i < symbol_cnt; i++) {
+		for (j = 0; j < symbol[i]->len; j++) {
+			c = symbol[i]->sym[j];
+			token_table[c].ch[0] = c;
+			token_table[c].len = 1;
 		}
 	}
 }
@@ -692,7 +704,7 @@ static int compare_symbols(const void *a, const void *b)
 
 static void sort_symbols(void)
 {
-	qsort(table, table_cnt, sizeof(table[0]), compare_symbols);
+	qsort(symbol, symbol_cnt, sizeof(symbol[0]), compare_symbols);
 }
 
 int main(int argc, char **argv)
-- 
2.39.5

