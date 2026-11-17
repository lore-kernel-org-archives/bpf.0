Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911673;
	b=xyhg+WxjNGwngBV7N+WdDZPry+8zT/4Q+YqF5kzv9RV6/is3tHce7w5obCJMS7nmnRee
	 Z10pnAmJBbxrLRs4wZxKjooeZgHZ5AyYp4YA3zY0qeZwSP6UhwQL2a3XX8HHuofEWOhPC
	 I0F7H+mhRM27pNxflGBhZzuttb84JS7U8cZgLOw1KxLz6HV/8kCydk45F21cgZIjUJGm4
	 X5SzrD05uQWSxbBYIbCRpJmo/PG/ynoREt+XzD3KUaSihYodO9fD70dy+0SLpFYeevA9e
	 9ULzz7t/dpDw+52HwLXXkUKS6P1tnWlbk4sJ8CsY8eN6VsxTWtQJV3mCJlNAVl4yKJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911673;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eAOQ1s+gPzNsuJpV8C1O9PE4dm/X+jR4Bq/PX7siDc8=;
	b=3pXtLAqLnsjuXuBre1flXsaalKeg1DxQQeBT8JupEEPVHpYeWw1U28rp21QNS5JgGg1T
	 WoYkuXwp5JW/XWg8mXlPaJUVZ6w9NtlecLlzLxAXNavDXoh086ccnlp0qL2WvpS40cdMa
	 /uimrtkPc8GqviyYM43lO7zat1UkboMk/vPxyhY56tKFb8diKvd4mUq11TpE74oC/x00G
	 NTEv4Ye+SFREXY56t9KJOwAYgYVE+gI/qJuSD5pCMYia+T3vDAQTlXsihr0zFL8oZ6zpJ
	 y3PxYihZVS1MzM0MB3YNrtznp7t0MWnb6GrJ1u29InYnGPrikSQsAzbbA6ZA4gxSVug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=O+PEqNCr;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A261606A333;
	Tue, 17 Nov 2026 10:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A261606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=O+PEqNCr
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW7-002Lje-CF; Tue, 17 Nov 2026 11:34:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=eAOQ1s+gPzNsuJpV8C1O9PE4dm/X+jR4Bq/PX7siDc8=; b=O+PEqNCrDR2SDtmy4Jmi6AOP14
	jAYcSmT67ar8/1bXWn1nmgDVFDc7app2z4fMC02PLq0u7rIGev9UeAigBT+fKcrEQJvDkqlGrCP0Q
	dEpsr+k2KP2hnU2I1AuTyirArVp0Zfi3AHVqzHJcrx3Tk7Pxh7bMQ8oJu1Fsy+2Nj/6LEdT2dD9aR
	+sOQ8tRm4ApyxD6tsDn/OeftrjCz50MhiGpXCvdf084N5pWf9Y+J170Gglykc5TQnYd5vEpaL3HER
	iS72lX1pBVav6VsRQjtliz1deQE+UK2RpvIwAkvNXIqgDHv/kEvbFK2udq2GBrjkpYuPrWf3NARcg
	nUy3INmA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW1-0002f5-UT; Tue, 17 Nov 2026 11:34:18 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xTGVr-005qHU-7t;
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
Subject: [PATCH v4 next 12/13] scripts/kallsyms: Reuse tokens that have no references
Date: Tue, 17 Nov 2026 10:33:51 +0000
Message-Id: <20261117103352.1244657-13-david.laight.linux@gmail.com>
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

Keep track of the number of times each compression token is used.
If the count becomes zero (eg if the only x are in axb and y is
substituted for xb giving ay) then x can be reused.

This means that a token can refer to a long string without needing
tokens for all the shorter strings.

Output the counts in comments in the output file.

For my normal kernel build four tokens get reused saving 8.5k of data.
The savings may be greater if there are symbols with long matching prefix.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

v3: Formally patch 13, rebased on 7.4-rc1
v4: No change.

 scripts/kallsyms.c | 72 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 15 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 69b9e5aa7b08..da397ab4c07e 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -91,6 +91,7 @@ static struct sym_arr token_syms[NR_TOKENS];
 static struct best_table {
 	char           *str;		/* Full expansion, '\0' terminated */
 	unsigned short len;		/* Length of str */
+	unsigned int   refs;		/* Number of times used in a symbol */
 } best_table[256];
 
 static void stamp(const char *where)
@@ -428,7 +429,8 @@ static void write_src(void)
 	for (i = 0; i < 256; i++) {
 		best_idx[i] = off;
 		off += best_table[i].len + 1;
-		printf("\t.asciz\t\"%s\"\n", best_table[i].str);
+		printf("\t.asciz\t\"%s\"\t/* %u: refs %u */\n",
+		       best_table[i].str, i, best_table[i].refs);
 	}
 	printf(".size kallsyms_token_table, . - kallsyms_token_table\n");
 	printf("\n");
@@ -646,12 +648,14 @@ static void check_tables(void)
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
@@ -670,8 +674,10 @@ static void check_tables(void)
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
@@ -695,6 +701,12 @@ static void check_tables(void)
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
@@ -703,6 +715,7 @@ static void check_tables(void)
 			     tok_info[idx].refs, token_profit[idx]);
 		}
 	}
+
 }
 
 /* count all the possible tokens in a symbol */
@@ -725,6 +738,19 @@ static void token_add_symbol(unsigned int token_idx, unsigned int sym_idx)
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
@@ -790,11 +816,11 @@ static unsigned char *find_token(unsigned char *str, unsigned char *end,
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
 
@@ -822,8 +848,11 @@ compress_symbols(unsigned int token_idx, int compressed_chr)
 	}
 
 	/* No symbol contains this token any more. */
+	subs = token_profit[token_idx];
 	token_profit[token_idx] = 0;
 	sym_arr_free(arr);
+
+	return subs;
 }
 
 /* search the token with the maximum profit */
@@ -847,28 +876,40 @@ static int find_best_token(void)
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
@@ -890,13 +931,14 @@ static void insert_real_symbols_in_table(void)
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

