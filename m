Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398391;
	b=eKUk7gVF2mC+EFg0CHnc9wUHa6CR2M3EqTb4sfeHVfLCoo774HW7ev7Q/7Xo2dvMxlWM
	 3hUD2IYjTDfxTuYVSa72nHolGBvjbPF3SMBTLkuCuICQNpt10OZJvwTRRP+RzI5d5gyg1
	 3rcMorsdpOehW2zlrc0Lj/oXLZCihexktj45QP9GfcMVzc0b6P4hziCvG0l5trjztYlnv
	 g8kaGVCuHKDZ+lGjP5wY7a0PVYjbfNn45o65UU3og0v04eDagYMnMV5cvfxkS27GKorLk
	 LidbcT7hE09IzyW3AgN0T78AzL6zdJNMNbBvw3S7vJdOxTAtNtnoYT+91uNZAUvNSvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398391;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MmFUrPjWSeZr4XHnSWVRAFYOICDxozmgBMYcOjzMloQ=;
	b=bUHzTy4JQunNQ3/iJCGG6iZrX3+yAPkHexi4GTRaCCq08b471Hif9uVM+LZzNlSRJcYz
	 8jvRB2CiR564z3eG9AogfQfQmROjYerqlccRuRz+jFJfo14jTVZa0rnpSG/iHsndIJ9ao
	 Jcvza88E15BQLZldKjN5iZ/X0QuapKcEhjl7scsp2KwhhuvUYoK1eS2SwMfyUNdwPkg7W
	 9rHOGKbEe0n5IvrSkD495ClyfMtDHXJa0Y/2AcPiXCRUyA2FQd1SOJpM34CXlWIbQPChx
	 plcHGwUVSEQdeW7yhO6SdgnXB5PqjDWB8pHiS0QeFVnQ/A7m1nFzBWiDUw17Trte2pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=YL2QuROD;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46999606A332;
	Wed, 11 Nov 2026 11:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46999606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=YL2QuROD
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xR6zN-001ry8-QB; Wed, 11 Nov 2026 12:59:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=MmFUrPjWSeZr4XHnSWVRAFYOICDxozmgBMYcOjzMloQ=; b=YL2QuRODsWWyT72eCUQh6nNAsj
	poyI+ZKuVNO+F6rGJHU4WeyUnkKJNWmZWUXNhVw/6PulhnY+lbBCcOMIKLyAl24uxqSt9MRqi/H3w
	+bMJjccufDlTxN4h162m0BbvxA8KPdAEZ/Vpcl7/xz12v/m/eewNK71HjxxGlAQ8tDxKbhG9JNJrP
	eq85lZ97PQRfRyu6/h8qA/k+4zhG7z3hG69GelVNdEABz1dKhSZYhDPOwZVSbR4HMEmHDcODr+B8c
	ETH+kx0lqTyKbFNXn3eF+0q6hry+WJYze2tv40E9wXpeMZg2Z1uWautnrx/QmPPTzSYCT69hfJ6Hc
	WheFf/SA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xR6zI-0004Jw-EK; Wed, 11 Nov 2026 12:59:36 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xR6zB-001mRM-NK;
	Wed, 11 Nov 2026 12:59:29 +0100
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
Subject: [PATCH v3 next 12/13] scripts/kallsyms: Reuse tokens that have no references
Date: Wed, 11 Nov 2026 11:59:10 +0000
Message-Id: <20261111115911.1142000-13-david.laight.linux@gmail.com>
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

Keep track of the number of times each compression token is used.
If the count becomes zero (eg if the only x are in axb and y is
substituted for xb giving ay) then x can be reused.

This means that a token can refer to a long string without needing
tokens for all the shorter strings.

Output the counts in comments in the output file.

For my normal kernel build four tokens get reused saving 8.5k of data.
The savings may be greater if there are symbols with long matching prefix.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
--

v3: Formally patch 13, rebased on 7.4-rc1

 scripts/kallsyms.c | 72 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 15 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 4da613e8e728..2f517873e9b4 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -91,6 +91,7 @@ static struct sym_arr token_syms[NR_TOKENS];
 static struct best_table {
 	char           *str;		/* Full expansion, '\0' terminated */
 	unsigned short len;		/* Length of str */
+	unsigned int   refs;		/* Number of times used in a symbol */
 } best_table[256];
 
 static void stamp(const char *where)
@@ -423,7 +424,8 @@ static void write_src(void)
 	for (i = 0; i < 256; i++) {
 		best_idx[i] = off;
 		off += best_table[i].len + 1;
-		printf("\t.asciz\t\"%s\"\n", best_table[i].str);
+		printf("\t.asciz\t\"%s\"\t/* %u: refs %u */\n",
+		       best_table[i].str, i, best_table[i].refs);
 	}
 	printf(".size kallsyms_token_table, . - kallsyms_token_table\n");
 	printf("\n");
@@ -641,12 +643,14 @@ static void check_tables(void)
 		unsigned int refs;
 		unsigned int idx;
 	} tok_info[NR_TOKENS], *ti;
+	unsigned int tok_refs[256];
 	unsigned int sym_idx, token;
 	unsigned char *cp, *end;
 	struct sym_arr *sa;
 	unsigned int i, idx;
 
 	memset(&tok_info, 0, sizeof(tok_info));
+	memset(&tok_refs, 0, sizeof(tok_refs));
 
 	/* Check that token_syms[]->sym_indexes is correctly sorted. */
 	for (token = 0; token < NR_TOKENS; token++) {
@@ -665,8 +669,10 @@ static void check_tables(void)
 	for (sym_idx = 0; sym_idx < table_cnt; sym_idx++) {
 		cp = table[sym_idx]->sym;
 		end = cp + table[sym_idx]->len;
+		tok_refs[*cp]++;
 		/* Scan all pairs */
 		while (++cp < end) {
+			tok_refs[*cp]++;
 			token = token_index(cp[-1], cp[0]);
 			ti = tok_info + token;
 			ti->refs++;
@@ -690,6 +696,12 @@ static void check_tables(void)
 	}
 
 	/* Check the reference counts for all tokens. */
+	for (i = 0; i < 256; i++) {
+		if (tok_refs[i] != best_table[i].refs)
+			errx(EXIT_FAILURE, "token reference error for %u (%s) %u != %u",
+			     i, best_table[i].str, best_table[i].refs, tok_refs[i]);
+	}
+
 	for (idx = 0; idx < NR_TOKENS; idx++) {
 		if (tok_info[idx].refs != token_profit[idx]) {
 			errx(EXIT_FAILURE, "profit error for %x (%s/%s) discrepency %u != %u",
@@ -698,6 +710,7 @@ static void check_tables(void)
 			     tok_info[idx].refs, token_profit[idx]);
 		}
 	}
+
 }
 
 /* count all the possible tokens in a symbol */
@@ -720,6 +733,19 @@ static void token_add_symbol(unsigned int token_idx, unsigned int sym_idx)
 	sym_arr_add(arr, sym_idx);
 }
 
+static unsigned int sym_arr_free_all(unsigned int ch)
+{
+	unsigned int i;
+
+	/* Just zero the counts, the entries are about to be reused. */
+	for (i = 0; i < 256; i++) {
+		token_syms[token_index(i, ch)].cnt = 0;
+		token_syms[token_index(ch, i)].cnt = 0;
+	}
+
+	return ch;
+}
+
 static void symbol_index_all_tokens(const unsigned char *symbol, int len,
 				    unsigned int sym_idx)
 {
@@ -785,11 +811,11 @@ static unsigned char *find_token(unsigned char *str, unsigned char *end,
 /* replace a given token in all the valid symbols. Use the sampled symbols
  * to update the counts.
  * Marked noinline to help register allocation. */
-static __attribute__((noinline)) void
+static __attribute__((noinline)) unsigned int
 compress_symbols(unsigned int token_idx, int compressed_chr)
 {
 	struct sym_arr *arr = &token_syms[token_idx];
-	unsigned int sym_idx, j, len;
+	unsigned int sym_idx, j, len, subs;
 	unsigned char *sym, *p, *end;
 	struct sym_entry *se;
 
@@ -817,8 +843,11 @@ compress_symbols(unsigned int token_idx, int compressed_chr)
 	}
 
 	/* No symbol contains this token any more. */
+	subs = token_profit[token_idx];
 	token_profit[token_idx] = 0;
 	sym_arr_free(arr);
+
+	return subs;
 }
 
 /* search the token with the maximum profit */
@@ -842,28 +871,40 @@ static int find_best_token(void)
 static void optimize_result(void)
 {
 	struct best_table *bt, *first, *second;
-	unsigned int len;
+	unsigned char to_process[256];
+	unsigned int idx, len, refs;
 	int i, best;
 	char *str;
 
-	/* Use the '\0' symbol last so the output is unchanged */
-	for (i = 255; i >= 0; i--) {
-		bt = best_table + i;
-		/* Ignore tokens used for the original character codes. */
-		if (bt->len)
-			continue;
+	/* Generate a list of the unused tokens. */
+	for (i = 0, idx = 0; i < 256; i++) {
+		if (!best_table[i].len)
+			to_process[idx++] = i;
+	}
 
-		/* Find the token that appears most often. */
+	while (idx) {
+		/* find the token that appears most often */
 		best = find_best_token();
 		if (best < 0)
 			break;
+		i = to_process[--idx];
 
 		/* Replace this token in all the valid symbols. */
-		compress_symbols(best, i);
+		refs = compress_symbols(best, i);
 
-		/* Generate the full name for this token ... */
+		bt = best_table + i;
 		first = best_table + token_first(best);
 		second = best_table + token_second(best);
+
+		/* Update the number of times each token is used. */
+		bt->refs += refs;
+		if (!(first->refs -= refs) && first->len > 1)
+			/* There are no references left, reuse the token. */
+			to_process[idx++] = sym_arr_free_all(token_first(best));
+		if (!(second->refs -= refs) && second->len > 1)
+			to_process[idx++] = sym_arr_free_all(token_second(best));
+
+		/* Generate the full name for this token ... */
 		len = first->len + second->len;
 		str = xmalloc(len + 1);
 		str[len] = 0;
@@ -885,13 +926,14 @@ static void insert_real_symbols_in_table(void)
 	for (i = 0; i < table_cnt; i++) {
 		for (j = 0; j < table[i]->len; j++) {
 			c = table[i]->sym[j];
-			best_table[c].len = 1;
+			best_table[c].refs++;
 		}
 	}
 
 	for (i = 0; i <= 255; i++) {
 		best_table[i].str = xmalloc(2);
-		best_table[i].str[0] = best_table[i].len ? i : 0;
+		best_table[i].len = best_table[i].refs ? 1 : 0;
+		best_table[i].str[0] = best_table[i].refs ? i : 0;
 		best_table[i].str[1] = 0;
 	}
 }
-- 
2.39.5

