Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911675;
	b=b2e9dgdSTlH6cowrxLzw7Nyq9FBeJv0n8vFhe1QUBMZDF3BIzqnNq9viIlbYzRfC8VXv
	 REhRvPPQ/ta6ylmZfP0ZmXOrm2FE6KpOeTWevBd5DUZV1VL6saD5rJix2otvUqxcQ+XHS
	 7jq6B4V3IuOibp5f6gRcxxBcOu+Knl60fRnuqX6h1iSRGWS8HR3MIx9YQ/Lt2et3vstOh
	 aaBoRRGVFvT4OKXbrUQcAGfNJ2VqoLcWJCt3M+ek1G5y1CvJaZgnouTDmrP5EGORUcXHQ
	 v8EgAluG0VkMnV/a1TgblqI6pot68G06ELXaeZdzKgDUekCArHQ7sHNjZxS2qPmgGKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911675;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7hyyliDUJPx5CWjKFQZgmcGE/nTdnoO3sdoocU4KRXY=;
	b=EehhDEsd16iWpw1NCbYilCOJ5driER/087NEQF6rpOFw948kcGznHRKZ8OKqCzH8JeT3
	 FAj0eDq5x5U9y/wtP/5BJtQ4mMbR4Uq0ALo4xLhfJzHuMMqsNF743wrELkLwaMsIVBv4X
	 lFJ/BSTE3+zt4S1WghgeMzKWIdxvkbQDMEKmauxUfjtu3Unu9+9Ka217PNkYxxA1vP2OS
	 oMRi/tXivP8RLTs9CpjyN1W6FXSWLLQiDhOqaigYowS5MrMzutIsAuROrlt/ZjKqAeaDR
	 idQUMW1ibcYLqFj64nAszZqgo47QpVKeDbvTOzrGaVdAI4UNHD75Y8PrGdFCE1t6cCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=YVxPcjpa;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B262606A8AB;
	Tue, 17 Nov 2026 10:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B262606A8AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=YVxPcjpa
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW7-002Ljj-NO; Tue, 17 Nov 2026 11:34:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=7hyyliDUJPx5CWjKFQZgmcGE/nTdnoO3sdoocU4KRXY=; b=YVxPcjpaCzwrW8fEnhhOp/Jdy3
	zoaMBmNdX/3pxPR/ClwdFMzPEtm5RE+cKBJu7J4O7WiBq43fNBHrXKN74X/qIZKOmJ3QH+hewS2Zw
	U0Wdj/wXZiFPx9XocTvcOYxnJ+GrRXVPOcvORpMkAJvpzbVNruHpFLvDC/ttJhUNLIHkDPAirC9y2
	sNDLBfdIBkDciufiStfgVYdVN5FXJmTQMHxWX4lv3qGpNUafo8LBZM3lfbfdp5HNmwT5f1DDG1j3T
	LvpDhbdLReC89Jll0BK9ZIwe28U+PV32dqxWQyHKqgKgn0xn/Zd72SjiiCzWF9XryC8jmTQHoXlhR
	9dwEhR9w==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW2-0002f9-5V; Tue, 17 Nov 2026 11:34:18 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xTGVr-005qHU-Rc;
	Tue, 17 Nov 2026 11:34:07 +0100
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
Subject: [PATCH v4 next 13/13] scripts/kallsyms: Reuse little-used compression tokens
Date: Tue, 17 Nov 2026 10:33:52 +0000
Message-Id: <20261117103352.1244657-14-david.laight.linux@gmail.com>
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

If the symbols contain a lot of "abc" and "abd" and a few "abe" then
the compression code first substitutes (say) 'x' for "ab" giving
"xc", "xd" and "xe".
It might later substitute 'y' for "xc" and 'z' for "xd" giving
"y", "z" and "xe".
The token 'x' is then hardly used, expanding "xe" back to "abe"
costs one byte every time it is used, but frees up 'x' to be used
for a much more common symbol pair.

Add a check at the end of the compression that all the counts still match.

Increases the compression ratio by about 3% on both the 'normal'
kernel I'm building and on the x86-64 allyesconfig kernel.
Since the compression ration is about 50% this is a 6% reduction.

For simplicity the code will only expand tokens where the two tokens
that were merged are still in the table and tokens that expand to
three characters (which are never removed).

It is possible to find some others, but the cost of locating them
adds completity and slows down the build and the gains are limited.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

v3:
- Formally patch 15, rebased on 7.4-rc1
- Additionally support splitting tokens that contain three characters.

v4:
- Enhance check_tables() to check best_table[].syms (nothing found).
- Don't exclude tokens that refer to 3 characters from being considered
  for splitting just because they wouldn't save any bytes.
- Clear best_table[ch].syms.cnt in sym_arr_free_all() - there can be
  no references. Saves scanning symbols that can't match later on.

 scripts/kallsyms.c | 318 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 272 insertions(+), 46 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index da397ab4c07e..85e1f013c725 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -91,7 +91,10 @@ static struct sym_arr token_syms[NR_TOKENS];
 static struct best_table {
 	char           *str;		/* Full expansion, '\0' terminated */
 	unsigned short len;		/* Length of str */
+	unsigned short token;		/* Original token pair for this entry */
+	unsigned char  splits;		/* Number of times this token has been split */
 	unsigned int   refs;		/* Number of times used in a symbol */
+	struct sym_arr syms;		/* Symbols using this token (if len != 1) */
 } best_table[256];
 
 static void stamp(const char *where)
@@ -111,11 +114,6 @@ static void stamp(const char *where)
 			where, delta / 10, delta % 10);
 }
 
-static unsigned int sym_arr_last(const struct sym_arr *arr)
-{
-	return arr->cnt ? arr->sym_indexes[arr->cnt - 1] : UINT_MAX;
-}
-
 static void sym_arr_maybe_expand(struct sym_arr *arr)
 {
 	if (arr->cap > arr->cnt)
@@ -126,10 +124,55 @@ static void sym_arr_maybe_expand(struct sym_arr *arr)
 				    arr->cap * sizeof(*arr->sym_indexes));
 }
 
-static void sym_arr_add(struct sym_arr *arr, unsigned int sym_idx)
+static void sym_arr_add(struct sym_arr *sa, unsigned int sym_idx)
 {
-	sym_arr_maybe_expand(arr);
-	arr->sym_indexes[arr->cnt++] = sym_idx;
+	unsigned int cnt = sa->cnt;
+	unsigned int lo, hi, try;
+	unsigned int *syms;
+
+	/* Ensure there is space to add a new entry */
+	sym_arr_maybe_expand(sa);
+	syms = sa->sym_indexes;
+
+	/* Mostly we are adding a new symbol in number order */
+	if (!cnt || sym_idx > syms[cnt - 1]) {
+		syms[cnt] = sym_idx;
+		sa->cnt = cnt + 1;
+		return;
+	}
+
+	/* Or we found the same pair of characters twice in the same symbol */
+	if (sym_idx == syms[cnt - 1])
+		return;
+
+	/* split_token() can generate an out of order reference, insert. */
+	if (sym_idx <= syms[0]) {
+		if (sym_idx == syms[0])
+			return;
+		try = 0;
+	} else {
+		lo = 0;
+		hi = cnt - 1;
+		for (;;) {
+			try = (lo + hi) / 2;
+			if (sym_idx == syms[try])
+				/* Already present - common. */
+				return;
+			if (try == lo)
+				break;
+			if (sym_idx > syms[try])
+				lo = try;
+			else
+				hi = try;
+		}
+		try++;
+	}
+
+	/* Insert before syms[try] */
+	syms += try;
+	memmove(syms + 1, syms, (cnt - try) * sizeof(*syms));
+	*syms = sym_idx;
+	sa->cnt = cnt + 1;
 }
 
 static void sym_arr_free(struct sym_arr *arr)
@@ -140,6 +183,15 @@ static void sym_arr_free(struct sym_arr *arr)
 	arr->cap = 0;
 }
 
+static void sym_arr_prealloc(struct sym_arr *sa, unsigned int count)
+{
+	if (sa->cap >= count)
+		return;
+
+	sa->cap = count;
+	sa->sym_indexes = xrealloc(sa->sym_indexes, count * sizeof(sa->sym_indexes[0]));
+}
+
 static char *sym_entry_name(const struct sym_entry *s)
 {
 	return (char *)s->sym + 1;
@@ -642,53 +694,106 @@ static unsigned int token_second(unsigned int token)
 /* table lookup compression functions */
 
 /* Check that the compression data is consistent. */
+static int check_sa_sorted(struct sym_arr *sa)
+{
+	unsigned int i;
+
+	for (i = 0; i + 1 < sa->cnt; i++) {
+		if (sa->sym_indexes[i] >= sa->sym_indexes[i + 1])
+			return i;
+	}
+	return -1;
+}
+
+static int scan_sa(struct sym_arr *sa, unsigned int idx, unsigned int sym)
+{
+	/* token_syms[]->sym_indexes holds symbol numbers in order. */
+	for (; idx < sa->cnt; idx++) {
+		if (sa->sym_indexes[idx] == sym)
+			return idx;
+	}
+	return -1;
+}
+
+static struct best_info {
+	unsigned int refs;
+	unsigned int idx;
+} best_info[256];
+
+static void check_best_refs(unsigned char tok, unsigned int sym)
+{
+	struct best_info *bi = best_info + tok;
+	int idx;
+
+	bi->refs++;
+	if (best_table[tok].len <= 1)
+		return;
+
+	idx = scan_sa(&best_table[tok].syms, bi->idx, sym);
+	if (idx < 0) {
+		char buf[1 + KSYM_NAME_LEN];
+		expand_symbol(table[sym]->sym, table[sym]->len, buf);
+
+		errx(EXIT_FAILURE, "symbol %u (%s) not in best_table[%u (%s)].syms",
+		     sym, buf, tok, best_table[tok].str);
+	}
+	bi->idx = idx;
+}
+
 static void check_tables(void)
 {
 	struct {
 		unsigned int refs;
 		unsigned int idx;
 	} tok_info[NR_TOKENS], *ti;
-	unsigned int tok_refs[256];
+	struct best_table *bt;
 	unsigned int sym_idx, token;
 	unsigned char *cp, *end;
 	struct sym_arr *sa;
-	unsigned int i, idx;
+	int idx;
 
 	memset(&tok_info, 0, sizeof(tok_info));
-	memset(&tok_refs, 0, sizeof(tok_refs));
+	memset(&best_info, 0, sizeof(best_info));
 
 	/* Check that token_syms[]->sym_indexes is correctly sorted. */
 	for (token = 0; token < NR_TOKENS; token++) {
 		sa = token_syms + token;
-		for (i = 0; i + 1 < sa->cnt; i++) {
-			if (sa->sym_indexes[i] < sa->sym_indexes[i + 1])
-				continue;
+		idx = check_sa_sorted(sa);
+		if (idx >= 0) {
 			errx(EXIT_FAILURE, "sym_indexes[%x (%s/%s)] missorted at %u %u >= %u",
 			     token, best_table[token_first(token)].str,
 			     best_table[token_second(token)].str,
-			     i, sa->sym_indexes[i], sa->sym_indexes[i + 1]);
+			     idx, sa->sym_indexes[idx], sa->sym_indexes[idx + 1]);
+		}
+	}
+
+	/* Similarly for best_table[].syms */
+	for (token = 0; token < 256; token++) {
+		bt = best_table + token;
+		idx = check_sa_sorted(&bt->syms);
+		if (idx >= 0) {
+			errx(EXIT_FAILURE, "best_table[%u (%s)].syms missorted at %u %u >= %u",
+			     token, bt->str, idx, bt->syms.sym_indexes[idx],
+			     bt->syms.sym_indexes[idx + 1]);
 		}
 	}
 
-	/* Check that every token pair is in token_syms[]->sym_indexes[]. */
+	/* Check that every token pair is in token_syms[]->sym_indexes[].
+	 * Check every token is in best_table[]->syms. */
 	for (sym_idx = 0; sym_idx < table_cnt; sym_idx++) {
 		cp = table[sym_idx]->sym;
 		end = cp + table[sym_idx]->len;
-		tok_refs[*cp]++;
+		check_best_refs(*cp, sym_idx);
 		/* Scan all pairs */
 		while (++cp < end) {
-			tok_refs[*cp]++;
+			check_best_refs(*cp, sym_idx);
 			token = token_index(cp[-1], cp[0]);
 			ti = tok_info + token;
 			ti->refs++;
 
-			/* token_syms[]->sym_indexes holds symbol numbers in order. */
 			sa = token_syms + token;
-			for (idx = ti->idx; idx < sa->cnt; idx++) {
-				if (sym_idx == sa->sym_indexes[idx])
-					break;
-			}
-			if (idx >= sa->cnt) {
+			idx = scan_sa(sa, ti->idx, sym_idx);
+			if (idx < 0) {
 				char buf[1 + KSYM_NAME_LEN];
 				expand_symbol(table[sym_idx]->sym, table[sym_idx]->len, buf);
 				errx(EXIT_FAILURE,
@@ -701,10 +806,10 @@ static void check_tables(void)
 	}
 
 	/* Check the reference counts for all tokens. */
-	for (i = 0; i < 256; i++) {
-		if (tok_refs[i] != best_table[i].refs)
+	for (idx = 0; idx < 256; idx++) {
+		if (best_info[idx].refs != best_table[idx].refs)
 			errx(EXIT_FAILURE, "token reference error for %u (%s) %u != %u",
-			     i, best_table[i].str, best_table[i].refs, tok_refs[i]);
+			     idx, best_table[idx].str, best_table[idx].refs, best_info[idx].refs);
 	}
 
 	for (idx = 0; idx < NR_TOKENS; idx++) {
@@ -729,13 +834,7 @@ static void learn_symbol(const unsigned char *symbol, int len)
 
 static void token_add_symbol(unsigned int token_idx, unsigned int sym_idx)
 {
-	struct sym_arr *arr = &token_syms[token_idx];
-
-	/* Symbol indexes kept in sorted order, check for duplicate. */
-	if (sym_arr_last(arr) == sym_idx)
-		return;
-
-	sym_arr_add(arr, sym_idx);
+	sym_arr_add(&token_syms[token_idx], sym_idx);
 }
 
 static unsigned int sym_arr_free_all(unsigned int ch)
@@ -748,6 +847,8 @@ static unsigned int sym_arr_free_all(unsigned int ch)
 		token_syms[token_index(ch, i)].cnt = 0;
 	}
 
+	best_table[ch].syms.cnt = 0;
+
 	return ch;
 }
 
@@ -784,16 +885,8 @@ static void build_initial_token_table(void)
 	 * The initial occurrence counts tell us exactly how much memory should
 	 * be reserved for each token's symbol array.
 	 */
-	for (i = 0; i < ARRAY_SIZE(token_syms); i++) {
-		const int nr_syms = token_profit[i];
-
-		if (!nr_syms)
-			continue;
-
-		token_syms[i].cap = nr_syms;
-		token_syms[i].sym_indexes =
-			xmalloc(nr_syms * sizeof(unsigned int));
-	}
+	for (i = 0; i < ARRAY_SIZE(token_syms); i++)
+		sym_arr_prealloc(&token_syms[i], token_profit[i]);
 
 	/* For every symbol, index every token -> symbol it is present in. */
 	for (i = 0; i < table_cnt; i++)
@@ -824,6 +917,8 @@ compress_symbols(unsigned int token_idx, int compressed_chr)
 	unsigned char *sym, *p, *end;
 	struct sym_entry *se;
 
+	sym_arr_prealloc(&best_table[compressed_chr].syms, token_profit[token_idx]);
+
 	/* Iterate through all symbols this token is found in and compress. */
 	for (j = 0; j < arr->cnt; j++) {
 		sym_idx = arr->sym_indexes[j];
@@ -844,7 +939,11 @@ compress_symbols(unsigned int token_idx, int compressed_chr)
 			adjust_profit(sym_idx, token_second(token_idx), compressed_chr, p[2], p[2]);
 			memmove(p + 1, p + 2, len);
 		}
+		if (se->len == end - sym)
+			/* No substitutions. */
+			continue;
 		se->len = end - sym;
+		sym_arr_add(&best_table[compressed_chr].syms, sym_idx);
 	}
 
 	/* No symbol contains this token any more. */
@@ -855,6 +954,125 @@ compress_symbols(unsigned int token_idx, int compressed_chr)
 	return subs;
 }
 
+/* Change every occurance of idx back to token_pair/triple.
+ * This extends all the symbol table entries but frees up a token. */
+static __attribute__((noinline)) void
+uncompress_symbols(unsigned int token_pair, int idx)
+{
+	struct best_table *bt = best_table + idx;
+	unsigned int sym_idx, len;
+	unsigned char *sym, *p, *end;
+	unsigned int substitutions;
+	unsigned int third_char;
+
+	third_char = token_pair >> 16;
+	token_pair &= 0xffff;
+
+	for (int j = 0; j < bt->syms.cnt; j++) {
+		sym_idx = bt->syms.sym_indexes[j];
+
+		sym = table[sym_idx]->sym;
+		len = table[sym_idx]->len;
+		end = sym + len;
+
+		for (p = sym; (p = memchr(p, idx, len)); p += 2) {
+			len = end - p - 1;
+			if (len) {
+				if (third_char) {
+					/* Adding three characters */
+					adjust_profit(sym_idx, idx, third_char, p[1], p[1]);
+					memmove(p + 3, p + 1, len);
+				} else {
+					adjust_profit(sym_idx, idx, token_second(token_pair), p[1], p[1]);
+					memmove(p + 2, p + 1, len);
+				}
+			}
+			if (p != sym)
+				adjust_profit(sym_idx, p[-1], p[-1], idx, token_first(token_pair));
+			token_add_symbol(token_pair, sym_idx);
+			p[0] = token_first(token_pair);
+			p[1] = token_second(token_pair);
+			end++;
+			if (third_char) {
+				token_add_symbol(token_index(p[1], third_char), sym_idx);
+				p[2] = third_char;
+				end++;
+				p++;
+			}
+		}
+		/* sym_idx is already in best_table[].syms from earlier. */
+		table[sym_idx]->len = end - sym;
+	}
+
+	substitutions = bt->refs;
+
+	bt->refs = 0;
+	sym_arr_free_all(idx);
+
+	token_profit[token_pair] += substitutions;
+	best_table[token_first(token_pair)].refs += substitutions;
+	best_table[token_second(token_pair)].refs += substitutions;
+
+	if (third_char) {
+		best_table[third_char].refs += substitutions;
+		token_profit[token_index(token_second(token_pair), third_char)] += substitutions;
+	}
+}
+
+static int split_token(unsigned int profit)
+{
+	struct best_table *bt, *first, *second;
+	const unsigned int max_splits = 10;
+	unsigned int i, best_token;
+	int best_ch = -1;
+
+	for (i = 0; i < 256; i++) {
+		bt = best_table + i;
+
+		if (bt->len == 1 || bt->refs >= profit || bt->splits >= max_splits)
+			continue;
+
+		/* Ignore tokens where the original parts have been reused ... */
+		first = &best_table[token_first(bt->token)];
+		second = &best_table[token_second(bt->token)];
+		if (bt->len != first->len + second->len ||
+		    memcmp(bt->str, first->str, first->len) ||
+		    memcmp(bt->str + first->len, second->str, second->len)) {
+			/* ... unless they are three characters. */
+			if (bt->len != 3) {
+				/* Don't consider again */
+				bt->splits = max_splits;
+				continue;
+			}
+			if (bt->refs * 2 >= profit)
+				continue;
+			best_token = token_index(bt->str[0], bt->str[1]) | bt->str[2] << 16;
+			profit = bt->refs * 2;
+		} else {
+			best_token = bt->token;
+			profit = bt->refs;
+		}
+
+		best_ch = i;
+	}
+	if (best_ch < 0)
+		return -1;
+
+	/*
+	 * Triplets (eg foo_xxx_bar) count as two pairs (in token_profit[]) but
+	 * the substitution only saves one byte making the recently merged token
+	 * a candidate for splitting again. This might cause an infinite loop.
+	 * But I have seen t_/alloc_tag get merged then t_alloc_tag/_cntr merged
+	 * leaving a single referece to t_alloc_tag - so it is split again.
+	 * So only allow a token to be split a few times.
+	 */
+	best_table[best_ch].splits++;
+
+	uncompress_symbols(best_token, best_ch);
+
+	return best_ch;
+}
+
 /* search the token with the maximum profit */
 static int find_best_token(void)
 {
@@ -887,17 +1105,25 @@ static void optimize_result(void)
 			to_process[idx++] = i;
 	}
 
-	while (idx) {
+	for (;;) {
 		/* find the token that appears most often */
 		best = find_best_token();
 		if (best < 0)
 			break;
-		i = to_process[--idx];
+		if (idx) {
+			i = to_process[--idx];
+		} else {
+			/* Try to free up a little-used token. */
+			i = split_token(token_profit[best]);
+			if (i < 0)
+				break;
+		}
 
 		/* Replace this token in all the valid symbols. */
 		refs = compress_symbols(best, i);
 
 		bt = best_table + i;
+		bt->token = best;
 		first = best_table + token_first(best);
 		second = best_table + token_second(best);
 
-- 
2.39.5

