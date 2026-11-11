Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398391;
	b=2AgmstEx2y4ofGRmDmsTHdLhiVT1RULuZKeC+a9VGOKe74S2qT23NR1/k7FCiJ50KEnP
	 kGpbkrMpi/VDdg2LXUL6HBOW28/GMnqgsEpAtWPauPp7z4szI9RYpfMc8/RopnlDDXdKo
	 5RvLAb7B5IQF01V4B3OeSpk4quws78SAA5iX2swZKm8g/zFphzdmjYw70OErGSd2+N5vA
	 gKY9yu2Ume7slI1/9Im9pNsAywaKx0mw+QUtiRrB7EpprK4ddCcGgrbb9cKtGr1m3JFXI
	 AQxy3pObpE5BEdIqnVyiGrCVFF1PWb9YIrzZzi/T95whSdfhOFdRlhhBp2V0afmIM5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398391;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xlBa0++MchyYF2HXCkHIh6FGi/jkZlKN4wycmf7jXd0=;
	b=yZe5+bV4I0LA89gggy5HbwJ9brcDg597Z0HJw6Nmk7iFfXW1hVdD2/KwnrFu4dkbRPUK
	 MbjPdr1L0XOAZWy1nQ8GF81H2Vl9Sjik6B9lqSl4/C1HtI+Cf9POHPQ0vddMJW7hLEdVW
	 LCtMtJ5t/BcIBdYfQfNHO11VTfUhf45glJmBxehxGDp8efRSslXVvw9qebLCu98mThXEy
	 lgJm7AL02LFssBRDXztMpcjT//L+v4ou8VIsCjvm8uqCjZRtHdSF8Na18tuUjbLETLIro
	 ngr9GBgXhms88No4c0XXRxmDVHL8lNiLG5s7ZPzDshcuFndukn6gA5mp2S59xEWYnbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=J8C8eJ1F;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A54606A334
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 11:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46A54606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=J8C8eJ1F
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xR6zN-001rxx-Ei; Wed, 11 Nov 2026 12:59:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=xlBa0++MchyYF2HXCkHIh6FGi/jkZlKN4wycmf7jXd0=; b=J8C8eJ1FbXW8j34Z/Nkm2L61su
	/R6bsAiFvlUCLkAAGU58MiB90vo67GsWEHc0ghxzi6ePaO/c3DrK1L6c1POofeSqorJPyRFajI3ZF
	lu68hA11Hoxgmyn+q0T3Vvhqazp7XYehH0yNpwGm0WT9sw4nPBmIHqCy47q9yyOYFCE7zHnLH9dK/
	pqNMvrzmcl+Rnnxq0Bj2929bnTitZfj6I2vVn/XzqpIPPbRsmrrPAtgkwCku+7WOfeTeSHlectlhV
	86StXH+I3s6yylbCrEh3dq5rtUKVZfXdzeB9uV64MvooubJPY70VAth6RD/RibDIl8xnA0I15Qm5t
	S6JE9Yug==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xR6zI-0000VZ-13; Wed, 11 Nov 2026 12:59:36 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xR6zC-001mRM-CE;
	Wed, 11 Nov 2026 12:59:30 +0100
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
Subject: [PATCH v3 next 13/13] scripts/kallsyms: Reuse little-used compression tokens
Date: Wed, 11 Nov 2026 11:59:11 +0000
Message-Id: <20261111115911.1142000-14-david.laight.linux@gmail.com>
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

 scripts/kallsyms.c | 223 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 196 insertions(+), 27 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 2f517873e9b4..8370347a9ab0 100644
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
@@ -724,13 +776,7 @@ static void learn_symbol(const unsigned char *symbol, int len)
 
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
@@ -779,16 +825,8 @@ static void build_initial_token_table(void)
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
@@ -819,6 +857,8 @@ compress_symbols(unsigned int token_idx, int compressed_chr)
 	unsigned char *sym, *p, *end;
 	struct sym_entry *se;
 
+	sym_arr_prealloc(&best_table[compressed_chr].syms, token_profit[token_idx]);
+
 	/* Iterate through all symbols this token is found in and compress. */
 	for (j = 0; j < arr->cnt; j++) {
 		sym_idx = arr->sym_indexes[j];
@@ -839,7 +879,11 @@ compress_symbols(unsigned int token_idx, int compressed_chr)
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
@@ -850,6 +894,123 @@ compress_symbols(unsigned int token_idx, int compressed_chr)
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
+		table[sym_idx]->len = end - sym;
+	}
+
+	substitutions = bt->refs;
+
+	bt->refs = 0;
+	bt->syms.cnt = 0;
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
+			if (bt->len != 3 || bt->refs * 2 >= profit) {
+				/* Don't consider again */
+				bt->splits = max_splits;
+				continue;
+			}
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
@@ -882,17 +1043,25 @@ static void optimize_result(void)
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

