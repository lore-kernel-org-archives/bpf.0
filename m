Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398390;
	b=TOYIte6gQxDZ+Kr2yATTBunjjHB3KdMyxUjQCQuRnhsb9ZCNbYD8EqOrNWjMn7BWoStp
	 ZsVvFVidhw+bqndJrs0JaTW6tgLu9mbb/bmaEiGWFABcCq9cNBYyIBXjcC+/zM4TmKr7/
	 9uLjQVAybcQfrDO04LRDpqejv15iYwUb1c1zDu3UoS4q+l/zHqsbi2MLzPUNjr6eKrAvy
	 dWqYRxs9aFyeF+U0/NvP2yaET0SNKq+rHfDLaDrcmwNa5en3X+YrM5OLDjsZIRi3e74ac
	 3q4bEZOu2Uo7k37k+R/YvvaVmBxmV87TiGAINrbut8eHhHqLcav8dVgUc+fLyk/ID/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398390;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0g3fmKbAIBV/u/GBVfPPSUss1Q9dp4eeX9ZvejKVwoM=;
	b=LSUKFOeqXlmJoXzHPUpCRGLgg1pUIWebIFQwadM5oDdsZNqmZH5R9mRLIb4C+P39mlQ8
	 /N+FFFRxxPmkGVCZIbPiEqtdIQUOENZMSrU0zWvOAtPj04Uc6gKWPe0yRj17HhZ0H8Xmr
	 vcIB6oalDRGVNyLGlPBuWLjyV6MjN0Y7oHI7k5/M3CAZu5/+q/QSEwY71k4XLZ/ZsyGZt
	 ObSqt6TiXJDYNXZBFsNufxMwlUnsle9YgSi/MpZNr3W1IiJcTAf9gU8oApSXuoz2J1zTP
	 RHlPjd9M3CgoJD0O3GKYuv0Mr3R6h6jeaHWxBt1/MpFKmJYoKFFuwGN60UAqKvhWIoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=pFeXRfYM;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46950606A330;
	Wed, 11 Nov 2026 11:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46950606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=pFeXRfYM
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xR6zN-001rxs-6m; Wed, 11 Nov 2026 12:59:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=0g3fmKbAIBV/u/GBVfPPSUss1Q9dp4eeX9ZvejKVwoM=; b=pFeXRfYMNYx2f3rx5LGQV317H9
	00ws7Qcgz4vl+vtfy7DbIOkqvB8ltDVuGxNrNtv25TdCkjnpCXBs6AGYkie4Yt/7p6IyRQPxLVYGB
	qEb9ljhSDhjoo5U9KznL+qmOVQN/R6C6MGtAHn8YONCTGGtUjchqFz324KWv4j0P5Yl3R3y2ImRK5
	I7HlklLXredgGbof9hitaWHmw9/3fI72e5x6A9N3lx7mh6dRJZAuGKk1nUMpmITxeYNWC8HglSMHo
	/BD76vLiuJDbY/DtGOmQ7kPNeoPcQur48BFIhl2tMHiMgyMP5gIwPHCjep8cPukTM+TS6xfvAHCK8
	//Z6Ag1Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xR6zH-0000VV-PV; Wed, 11 Nov 2026 12:59:35 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xR6zA-001mRM-E4;
	Wed, 11 Nov 2026 12:59:28 +0100
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
Subject: [PATCH v3 next 10/13] scripts/kallsyms: Keep full expansion of tokens
Date: Wed, 11 Nov 2026 11:59:08 +0000
Message-Id: <20261111115911.1142000-11-david.laight.linux@gmail.com>
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

Expand the full string when a new compression token is allocated.
Saves the recursive expansions later on.
It means that token 0 could be used earlier, but the reverse
order is maintained so that the output files can be compared.

The entries for the initial tokens [0-9A-Za-z_.] are now no different
and don't need special casing.

Change find_best_token() to return -1 if there are no tokens
(eg if the input file is very small) to save the caller rechecking
token_profit[].

Save the original symbol name length and check that the expanded
symbol has the same length.

No change to generated output.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

About 3ms (in 175ms) can be saved by keeping a copy of the name
itself and avoiding expand_symbol(), but it is messy.
And another 18ms by doing the alphabetic sort in a thread.

v3:
- Reworked on top of the changes in 7.4-rc1
- Avoid printf("%s", NULL) on initial 'no symbol' build.
  While fine with glibc, other libs dump core.

 scripts/kallsyms.c | 156 +++++++++++++++++++++++++--------------------
 1 file changed, 88 insertions(+), 68 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index c27aaabccd1b..cbf05972043b 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -36,7 +36,8 @@
 
 struct sym_entry {
 	unsigned long long addr;
-	unsigned int len;
+	unsigned short len;
+	unsigned short orig_len;
 	unsigned int seq;
 	unsigned char sym[];
 };
@@ -76,12 +77,21 @@ struct sym_arr {
 /* Every pair of bytes is a token. */
 #define NR_TOKENS	0x10000
 
+/*
+ * token_profit[token_index(first, second)] is the number of times the characters
+ * first and second appear adjacent (in that order) and is usually the same
+ * as the number of bytes saved (the profit) by replacing the pair with
+ * a single byte token.
+ */
 static int token_profit[NR_TOKENS];
+/* The symbols that contain each pair of characters. */
 static struct sym_arr token_syms[NR_TOKENS];
 
 /* the table that holds the result of the compression */
-static unsigned char best_table[256][2];
-static unsigned char best_table_len[256];
+static struct best_table {
+	char           *str;		/* Full expansion, '\0' terminated */
+	unsigned short len;		/* Length of str */
+} best_table[256];
 
 static void stamp(const char *where)
 {
@@ -199,6 +209,7 @@ static struct sym_entry *add_symbol(unsigned long long addr, char type,
 	sym = xmalloc(sizeof(*sym) + len + 1);
 	sym->addr = addr;
 	sym->len = len;
+	sym->orig_len = len;
 	sym->sym[0] = type;
 	strcpy(sym_entry_name(sym), name);
 
@@ -351,29 +362,17 @@ static void write_incbin(unsigned long *bin_offset, unsigned long size)
 	*bin_offset += size;
 }
 
-/* uncompress a compressed symbol. When this function is called, the best table
- * might still be compressed itself, so the function needs to be recursive */
-static int expand_symbol(const unsigned char *data, int len, char *result)
+static unsigned int expand_symbol(const unsigned char *data, int len, char *result)
 {
-	int c, rlen, total=0;
-
-	while (len) {
-		c = *data;
-		/* if the table holds a single char that is the same as the one
-		 * we are looking for, then end the search */
-		if (best_table[c][0]==c && best_table_len[c]==1) {
-			*result++ = c;
-			total++;
-		} else {
-			/* if not, recurse and expand */
-			rlen = expand_symbol(best_table[c], best_table_len[c], result);
-			total += rlen;
-			result += rlen;
-		}
-		data++;
-		len--;
+	struct best_table *bt;
+	unsigned int total = 0;
+
+	while (len--) {
+		bt = best_table + *data++;
+		memcpy(result + total, bt->str, bt->len);
+		total += bt->len;
 	}
-	*result=0;
+	result[total] = 0;
 
 	return total;
 }
@@ -405,7 +404,7 @@ static void sort_symbols_by_name(void)
 
 static void write_src(void)
 {
-	unsigned int i, k, len, off, off_size, table_size;
+	unsigned int i, k, off, off_size, table_size;
 	unsigned int best_idx[256];
 	unsigned int *markers, markers_cnt;
 	unsigned long bin_offset = 0;
@@ -422,10 +421,9 @@ static void write_src(void)
 	output_label("kallsyms_token_table");
 	off = 0;
 	for (i = 0; i < 256; i++) {
-		len = expand_symbol(best_table[i], best_table_len[i], buf);
 		best_idx[i] = off;
-		off += len + 1;
-		printf("\t.asciz\t\"%s\"\n", buf);
+		off += best_table[i].len + 1;
+		printf("\t.asciz\t\"%s\"\n", best_table[i].str);
 	}
 	printf(".size kallsyms_token_table, . - kallsyms_token_table\n");
 	printf("\n");
@@ -451,19 +449,15 @@ static void write_src(void)
 	write_incbin_header("names", &bin_offset);
 	off = 0;
 	for (i = 0; i < table_cnt; i++) {
-		unsigned int se_len, len_len;
+		unsigned int len_len;
 		unsigned char len[2];
 
 		se = table[i];
 		se->seq = off;
 
-		/* The length must be less than that of the original symbol. */
-		if (!se->len || se->len > KSYM_NAME_LEN)
-			errx(EXIT_FAILURE, "symbol %d has corrupt compressed length %d",
-			     i, se->len);
-
-		/* Generate the original name */
-		se_len = expand_symbol(se->sym, se->len, buf);
+		/* Generate the original name in a temporary buffer */
+		if (expand_symbol(se->sym, se->len, buf) != se->orig_len)
+			errx(EXIT_FAILURE, "symbol %d has corrupt compressed data", i);
 
 		/* Encode length with ULEB128. */
 		if (se->len <= 0x7F) {
@@ -498,8 +492,8 @@ static void write_src(void)
 		off += len_len + se->len;
 
 		/* Restore the original name. */
-		se->len = se_len;
-		memcpy(se->sym, buf, se_len + 1);
+		se->len = se->orig_len;
+		memcpy(se->sym, buf, se->len + 1);
 	}
 	write_incbin(&bin_offset, off);
 	table_size = off;
@@ -618,7 +612,7 @@ static void write_src(void)
 	write_incbin_header("end", &bin_offset);
 }
 
-static unsigned int token_index(unsigned char first, unsigned char second)
+static unsigned int token_index(unsigned int first, unsigned int second)
 {
 	return first + (second << 8);
 }
@@ -628,6 +622,16 @@ static unsigned int sym_token_index(const unsigned char *symbol, int first_idx)
 	return token_index(symbol[first_idx], symbol[first_idx + 1]);
 }
 
+static unsigned int token_first(unsigned int token)
+{
+	return token & 0xff;
+}
+
+static unsigned int token_second(unsigned int token)
+{
+	return token >> 8;
+}
+
 /* table lookup compression functions */
 
 /* count all the possible tokens in a symbol */
@@ -718,22 +722,23 @@ static void build_initial_token_table(void)
 }
 
 static unsigned char *find_token(unsigned char *str, int len,
-				 const unsigned char *token)
+				 unsigned int want)
 {
+	unsigned int token = token_index(0, *str++);
 	int i;
 
 	for (i = 0; i < len - 1; i++) {
-		if (str[i] == token[0] && str[i+1] == token[1])
-			return &str[i];
+		token = token_index(token_second(token), *str++);
+		if (token == want)
+			return str - 2;
 	}
 	return NULL;
 }
 
 /* replace a given token in all the valid symbols. Use the sampled symbols
  * to update the counts */
-static void compress_symbols(const unsigned char *str, int compressed_chr)
+static void compress_symbols(unsigned int token_idx, int compressed_chr)
 {
-	const unsigned int token_idx = sym_token_index(str, 0);
 	struct sym_arr *arr = &token_syms[token_idx];
 	unsigned int sym_idx, j, len, size;
 	unsigned char *p1, *p2;
@@ -746,7 +751,7 @@ static void compress_symbols(const unsigned char *str, int compressed_chr)
 		p1 = table[sym_idx]->sym;
 
 		/* find the token on the symbol */
-		p2 = find_token(p1, len, str);
+		p2 = find_token(p1, len, token_idx);
 		if (!p2) continue;
 
 		/* decrease the counts for this symbol's tokens */
@@ -765,7 +770,7 @@ static void compress_symbols(const unsigned char *str, int compressed_chr)
 			if (size < 2) break;
 
 			/* find the token on the symbol */
-			p2 = find_token(p1, size, str);
+			p2 = find_token(p1, size, token_idx);
 
 		} while (p2);
 
@@ -785,8 +790,8 @@ static int find_best_token(void)
 {
 	int i, best, bestprofit;
 
-	bestprofit=-10000;
-	best = 0;
+	bestprofit = 0;
+	best = -1;
 
 	for (i = 0; i < ARRAY_SIZE(token_profit); i++) {
 		if (token_profit[i] > bestprofit) {
@@ -800,29 +805,39 @@ static int find_best_token(void)
 /* this is the core of the algorithm: calculate the "best" table */
 static void optimize_result(void)
 {
+	struct best_table *bt, *first, *second;
+	unsigned int len;
 	int i, best;
+	char *str;
 
-	/* using the '\0' symbol last allows compress_symbols to use standard
-	 * fast string functions */
+	/* Use the '\0' symbol last so the output is unchanged */
 	for (i = 255; i >= 0; i--) {
+		bt = best_table + i;
+		/* Ignore tokens used for the original character codes. */
+		if (bt->len)
+			continue;
 
-		/* if this table slot is empty (it is not used by an actual
-		 * original char code */
-		if (!best_table_len[i]) {
-
-			/* find the token with the best profit value */
-			best = find_best_token();
-			if (token_profit[best] == 0)
-				break;
-
-			/* place it in the "best" table */
-			best_table_len[i] = 2;
-			best_table[i][0] = best & 0xFF;
-			best_table[i][1] = (best >> 8) & 0xFF;
+		/* Find the token that appears most often. */
+		best = find_best_token();
+		if (best < 0)
+			break;
 
-			/* replace this token in all the valid symbols */
-			compress_symbols(best_table[i], i);
-		}
+		/* Replace this token in all the valid symbols. */
+		compress_symbols(best, i);
+
+		/* Generate the full name for this token ... */
+		first = best_table + token_first(best);
+		second = best_table + token_second(best);
+		len = first->len + second->len;
+		str = xmalloc(len + 1);
+		str[len] = 0;
+		memcpy(str, first->str, first->len);
+		memcpy(str + first->len, second->str, second->len);
+
+		/* ... and save. */
+		free(bt->str);
+		bt->str = str;
+		bt->len = len;
 	}
 }
 
@@ -834,10 +849,15 @@ static void insert_real_symbols_in_table(void)
 	for (i = 0; i < table_cnt; i++) {
 		for (j = 0; j < table[i]->len; j++) {
 			c = table[i]->sym[j];
-			best_table[c][0]=c;
-			best_table_len[c]=1;
+			best_table[c].len = 1;
 		}
 	}
+
+	for (i = 0; i <= 255; i++) {
+		best_table[i].str = xmalloc(2);
+		best_table[i].str[0] = best_table[i].len ? i : 0;
+		best_table[i].str[1] = 0;
+	}
 }
 
 static void optimize_token_table(void)
-- 
2.39.5

