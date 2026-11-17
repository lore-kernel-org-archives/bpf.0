Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911674;
	b=QijlKpS3axcXewT4112Rb562gWfSeN3fwhxgTkshvxhvsmbxvtxKGqKg5Ya2pY+fbt6S
	 wYlE4TQKjg9iuUmIf8qePF58igqEOuXH/QLfkF2yFS1ch2V0cT3efzS4P+HwaG8HRGzq5
	 WE4SPWCCOG0eiv0K+hiXq9iUtYQJ2PLhznnj8ZH3MNdSPCaiP64mhL0wXVYrS0BYglMLU
	 NCdPmePoIZtxO1GdD8tyMoo1aajSLAH4QKiHhfcfQw48SUTlW6VaOA6Hz/IM+vgt8cJUj
	 mCsKU0OQTSe7MHgjVkUfyBtWepCA+w7iQ5VOqstnzv/2GhRNB+7NC+ov/DOVh7tRR1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911674;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HcNd76WousIs8PdoPoXsEFeHtUzPt/XcpoXtQbyY/NM=;
	b=PelwrsY8MOjfAyuw/fMZZZaQXzUtIQwBcISVdCuuCSc5TYvj5rHcu5ZBbvn06kUbpOcD
	 BTfItSYAenILB2LJI6qsmxP1teu6isjOrp/I3IRc0v7rKTTZGRhkn9+uDXQtbViev5aW1
	 qGs5nJJz+DhDjOLaA1Vumaswt4/wouwdJ/dnFN3COePfg619bdhfwO5ox/35G9DkkwCnp
	 PkO8JOO+vNroC/iFkMgkRSxoptCPbysogxkQDWXV74hYSAKNimzsupJVTCsf9O12+DEy2
	 JWDm6JpUVeJZ/1Ues2bmbW/mXi6ksQsDV41CHVw2TxX4n93CvdXrtOWGBTYvTAI7NpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=SsFyMJ94;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54622606A898;
	Tue, 17 Nov 2026 10:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54622606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=SsFyMJ94
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW6-002LjO-SW; Tue, 17 Nov 2026 11:34:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=HcNd76WousIs8PdoPoXsEFeHtUzPt/XcpoXtQbyY/NM=; b=SsFyMJ948MLUocpyir6zUA8ppx
	5DCt9Q8kr97+aTDUm+I9qruBW1vDY9gOhcRhx+x18pXaTeTbEcILJt/aEFiD7BDlFyXMbMCxQ79S3
	ez23uV7/jcdL+Rj+MiMxDeXLvgNqvxQ5NNALEx3BLilUxPyoueB6auEwTklY7Macdz1hv/cHSU5yn
	h9LfxGG80lSmu0g2puIo5DuFW6xFJBCGpFfjbblIPzumdZfU7rwzxJtdcEY9fhTMQnrwQUxkCsVHx
	S8qWtiwxHzedk/wZ2xx7eAuXEQC45SBQLfqSBzxWG+ShtmHnmf6e3VfMBk7IChBIU9RJwcGzuuMJi
	iZHypU2Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW1-0002F3-Gk; Tue, 17 Nov 2026 11:34:17 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xTGVq-005qHU-HE;
	Tue, 17 Nov 2026 11:34:06 +0100
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
Subject: [PATCH v4 next 11/13] scripts/kallsyms: Optimise compress_symbols()
Date: Tue, 17 Nov 2026 10:33:50 +0000
Message-Id: <20261117103352.1244657-12-david.laight.linux@gmail.com>
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

When (say) axyb is replaced with azb instead of decrementing the
token_profit[] value for every pair of token in the old string before
the substitution and then incrementing it afterwards just decrement
the counts for ax and yb and increment the ones for az and zb.
Set the count for xy (the number of actual substitions) to zero
afterwards.

On my system this reduces the execution time for optimize_result()
from 98ms to 64ms

The gain will be far more for kernels containing very long symbol names.

Add a function to verify the compression tables are correct.
Call before generating the output when 'incbin' isn't being used.

Output file unchanged.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

v3: Formally patch 12, rebased on 7.4-rc1
v4: No change.

 scripts/kallsyms.c | 169 ++++++++++++++++++++++++++++-----------------
 1 file changed, 105 insertions(+), 64 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index a63e0ce833f9..69b9e5aa7b08 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -639,22 +639,79 @@ static unsigned int token_second(unsigned int token)
 
 /* table lookup compression functions */
 
-/* count all the possible tokens in a symbol */
-static void learn_symbol(const unsigned char *symbol, int len)
+/* Check that the compression data is consistent. */
+static void check_tables(void)
 {
-	int i;
+	struct {
+		unsigned int refs;
+		unsigned int idx;
+	} tok_info[NR_TOKENS], *ti;
+	unsigned int sym_idx, token;
+	unsigned char *cp, *end;
+	struct sym_arr *sa;
+	unsigned int i, idx;
+
+	memset(&tok_info, 0, sizeof(tok_info));
+
+	/* Check that token_syms[]->sym_indexes is correctly sorted. */
+	for (token = 0; token < NR_TOKENS; token++) {
+		sa = token_syms + token;
+		for (i = 0; i + 1 < sa->cnt; i++) {
+			if (sa->sym_indexes[i] < sa->sym_indexes[i + 1])
+				continue;
+			errx(EXIT_FAILURE, "sym_indexes[%x (%s/%s)] missorted at %u %u >= %u",
+			     token, best_table[token_first(token)].str,
+			     best_table[token_second(token)].str,
+			     i, sa->sym_indexes[i], sa->sym_indexes[i + 1]);
+		}
+	}
 
-	for (i = 0; i < len - 1; i++)
-		token_profit[sym_token_index(symbol, i)]++;
+	/* Check that every token pair is in token_syms[]->sym_indexes[]. */
+	for (sym_idx = 0; sym_idx < table_cnt; sym_idx++) {
+		cp = table[sym_idx]->sym;
+		end = cp + table[sym_idx]->len;
+		/* Scan all pairs */
+		while (++cp < end) {
+			token = token_index(cp[-1], cp[0]);
+			ti = tok_info + token;
+			ti->refs++;
+
+			/* token_syms[]->sym_indexes holds symbol numbers in order. */
+			sa = token_syms + token;
+			for (idx = ti->idx; idx < sa->cnt; idx++) {
+				if (sym_idx == sa->sym_indexes[idx])
+					break;
+			}
+			if (idx >= sa->cnt) {
+				char buf[1 + KSYM_NAME_LEN];
+				expand_symbol(table[sym_idx]->sym, table[sym_idx]->len, buf);
+				errx(EXIT_FAILURE,
+				     "symbol %u (%s) not in sym_indexes[] for token %x (%s/%s)",
+				     sym_idx, buf, token, best_table[cp[-1]].str,
+				     best_table[cp[0]].str);
+			}
+			ti->idx = idx;
+		}
+	}
+
+	/* Check the reference counts for all tokens. */
+	for (idx = 0; idx < NR_TOKENS; idx++) {
+		if (tok_info[idx].refs != token_profit[idx]) {
+			errx(EXIT_FAILURE, "profit error for %x (%s/%s) discrepency %u != %u",
+			     idx, best_table[token_first(idx)].str,
+			     best_table[token_second(idx)].str,
+			     tok_info[idx].refs, token_profit[idx]);
+		}
+	}
 }
 
-/* decrease the count for all the possible tokens in a symbol */
-static void forget_symbol(const unsigned char *symbol, int len)
+/* count all the possible tokens in a symbol */
+static void learn_symbol(const unsigned char *symbol, int len)
 {
 	int i;
 
 	for (i = 0; i < len - 1; i++)
-		token_profit[sym_token_index(symbol, i)]--;
+		token_profit[sym_token_index(symbol, i)]++;
 }
 
 static void token_add_symbol(unsigned int token_idx, unsigned int sym_idx)
@@ -680,23 +737,14 @@ static void symbol_index_all_tokens(const unsigned char *symbol, int len,
 	}
 }
 
-/*
- * The symbol just got compressed. The only parts of the symbol that changed
- * meaningfully are those containing the newly assigned compressed char, so
- * index those.
- */
-static void symbol_index_new_tokens(const unsigned char *symbol, int len,
-				    unsigned int sym_idx, int compressed_chr)
+static void adjust_profit(unsigned int sym_idx,
+			  unsigned int old_first, unsigned int new_first,
+			  unsigned int old_second, unsigned int new_second)
 {
-	int i;
+	token_profit[token_index(old_first, old_second)]--;
+	token_profit[token_index(new_first, new_second)]++;
 
-	for (i = 0; i < len - 1; i++) {
-		const unsigned int token_idx = sym_token_index(symbol, i);
-
-		if (symbol[i] == compressed_chr ||
-		    symbol[i + 1] == compressed_chr)
-			token_add_symbol(token_idx, sym_idx);
-	}
+	token_add_symbol(token_index(new_first, new_second), sym_idx);
 }
 
 static void build_initial_token_table(void)
@@ -726,13 +774,12 @@ static void build_initial_token_table(void)
 		symbol_index_all_tokens(table[i]->sym, table[i]->len, i);
 }
 
-static unsigned char *find_token(unsigned char *str, int len,
+static unsigned char *find_token(unsigned char *str, unsigned char *end,
 				 unsigned int want)
 {
 	unsigned int token = token_index(0, *str++);
-	int i;
 
-	for (i = 0; i < len - 1; i++) {
+	while (str < end) {
 		token = token_index(token_second(token), *str++);
 		if (token == want)
 			return str - 2;
@@ -741,53 +788,42 @@ static unsigned char *find_token(unsigned char *str, int len,
 }
 
 /* replace a given token in all the valid symbols. Use the sampled symbols
- * to update the counts */
-static void compress_symbols(unsigned int token_idx, int compressed_chr)
+ * to update the counts.
+ * Marked noinline to help register allocation. */
+static __attribute__((noinline)) void
+compress_symbols(unsigned int token_idx, int compressed_chr)
 {
 	struct sym_arr *arr = &token_syms[token_idx];
-	unsigned int sym_idx, j, len, size;
-	unsigned char *p1, *p2;
+	unsigned int sym_idx, j, len;
+	unsigned char *sym, *p, *end;
+	struct sym_entry *se;
 
 	/* Iterate through all symbols this token is found in and compress. */
 	for (j = 0; j < arr->cnt; j++) {
 		sym_idx = arr->sym_indexes[j];
 
-		len = table[sym_idx]->len;
-		p1 = table[sym_idx]->sym;
-
-		/* find the token on the symbol */
-		p2 = find_token(p1, len, token_idx);
-		if (!p2) continue;
-
-		/* decrease the counts for this symbol's tokens */
-		forget_symbol(table[sym_idx]->sym, len);
-
-		size = len;
-
-		do {
-			*p2 = compressed_chr;
-			p2++;
-			size -= (p2 - p1);
-			memmove(p2, p2 + 1, size);
-			p1 = p2;
-			len--;
-
-			if (size < 2) break;
-
-			/* find the token on the symbol */
-			p2 = find_token(p1, size, token_idx);
-
-		} while (p2);
-
-		table[sym_idx]->len = len;
-
-		/* increase the counts for this symbol's new tokens */
-		learn_symbol(table[sym_idx]->sym, len);
-		symbol_index_new_tokens(table[sym_idx]->sym, len, sym_idx,
-					compressed_chr);
+		se = table[sym_idx];
+		sym = se->sym;
+		end = sym + se->len;
+
+		for (p = sym; (p = find_token(p, end, token_idx)); p++) {
+			len = end - p - 2;
+			end--;
+			*p = compressed_chr;
+			if (p != sym)
+				adjust_profit(sym_idx, p[-1], p[-1],
+					      token_first(token_idx), compressed_chr);
+			if (!len)
+				break;
+			adjust_profit(sym_idx, token_second(token_idx), compressed_chr, p[2], p[2]);
+			memmove(p + 1, p + 2, len);
+		}
+		se->len = end - sym;
 	}
 
-	sym_arr_free(arr); /* No symbol contains this token any more. */
+	/* No symbol contains this token any more. */
+	token_profit[token_idx] = 0;
+	sym_arr_free(arr);
 }
 
 /* search the token with the maximum profit */
@@ -875,6 +911,11 @@ static void optimize_token_table(void)
 
 	optimize_result();
 	stamp("optimize result");
+
+	if (!out_bin_file) {
+		check_tables();
+		stamp("check tables");
+	}
 }
 
 /* guess for "linker script provide" symbol */
-- 
2.39.5

