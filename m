Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E9C3CF021;
	Sun, 18 Oct 2026 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338806; cv=none; b=hjxZTRFFkFu2mdJnhjiUq7UpZqlNGRfFp+P1/zyDDJMXVgEYMngU8oucrxUWL+zqc5s67HIYOigWwn4lUpvCWyLeelxwrLIm8k7paBEbkWvORYIZw5iaVycYgL+hZX/kB3Xj48U8BO5hB+HbvDNTlMduOgefGkemvVG7jjavX3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338806; c=relaxed/simple;
	bh=WQ1o4GK0tdNo3Y01jJSxMiQbh9jgQAy0dZqUBK4myIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nPULGYZ1m8ErURYUViwf34M/NNjV5oRFstMoy3SXM9OBrUcOP9tI7pBOqRPzKtQOWfk9gecUKBzi1vPTt6PpqR8j4KK4HVDFe7WEB6IKXIdav5Mm0gSFOTVlPHaOhjsbI55D3h8t8EusNlb8DD0lH2nxqCvTPMVD3pvb7PsR3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=TINsNkve; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="TINsNkve"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC4-001KAw-21; Sun, 18 Oct 2026 17:53:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=UuhMU7Chf/rdn2OCSvMo6Kb/JJg8h81N+WpNKm+WSv4=; b=TINsNkveGj/EQ4z6A3Lw4xAjrk
	ybvJ7uKjvUtacY2YAUz89JKjti95QByOdSLL5Yao8d+k3f8F34zqBjftgikbZJmDQYUFR/piY8AZY
	P6SeT5x8L0xJd2D8cA8tON1TZ8KMB4LlLW/Omn+p+mo5Ly+aaia5Vt0/lTdVCTDp9V9yfZldKZcTe
	YVawaJgXuFTR+UZ+mz5G7MKnJCdU5nIKXHTL6p8zvSrpc9txdzQ2aEnpRz8SZSqc8NURheQyO5dQc
	bnZ2ApynLq/o/+FIERPPOcTZ/04ESE57LGj6ZXGlLFDtCPq7DAq6ajdGz6OH7asINDkRPBw790EK2
	KqEzKZOw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITBy-0000BN-K7; Sun, 18 Oct 2026 17:52:58 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xITBj-004q3U-B7;
	Sun, 18 Oct 2026 17:52:43 +0200
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
Subject: [PATCH v2 next 11/15] kallsyms: scripts/kallsyms: Keep full expansion of tokens
Date: Sun, 18 Oct 2026 16:52:02 +0100
Message-Id: <20261018155206.132411-12-david.laight.linux@gmail.com>
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

Expand the full string when a new token is allocated.
Saves the recursive expansions later on.
It probably means that token 0 could be used earlier, but the reverse
order is maintained so that the output files can be compared.

The entries for the initial tokens [0-9A-Za-z_.] are now no different
and don't need special casing.

No change to generated output.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 scripts/kallsyms.c | 117 +++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 57 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 5603b2a6c77b..9e1bc0fdaa9f 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -74,8 +74,8 @@ static int token_profit[0x10000];
 
 /* the table that holds the result of the compression */
 static struct token_table {
-	unsigned short len;
-	unsigned char  ch[2];
+	char           *str;		/* Full expansion, '\0' terminated */
+	unsigned short len;		/* Length of str */
 } token_table[256];
 
 static void usage(void)
@@ -301,29 +301,17 @@ static void output_value(const char *label, unsigned int value)
 	printf("\n");
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
-		if (token_table[c].ch[0] == c && token_table[c].len == 1) {
-			*result++ = c;
-			total++;
-		} else {
-			/* if not, recurse and expand */
-			rlen = expand_symbol(token_table[c].ch, token_table[c].len, result);
-			total += rlen;
-			result += rlen;
-		}
-		data++;
-		len--;
+	struct token_table *tt;
+	unsigned int total = 0;
+
+	while (len--) {
+		tt = token_table + *data++;
+		memcpy(result + total, tt->str, tt->len);
+		total += tt->len;
 	}
-	*result=0;
+	result[total] = 0;
 
 	return total;
 }
@@ -396,8 +384,8 @@ static void write_src(void)
 		 * Now that we wrote out the compressed symbol name, restore the
 		 * original name and print it in the comment.
 		 */
-		expand_symbol(se->sym, se->len, buf);
-		strcpy((char *)se->sym, buf);
+		se->len = expand_symbol(se->sym, se->len, buf);
+		memcpy(se->sym, buf, se->len + 1);
 		printf("\t/* %s */\n", se->sym);
 	}
 	table_size = off;
@@ -415,9 +403,8 @@ static void write_src(void)
 	off = 0;
 	for (i = 0; i < 256; i++) {
 		best_idx[i] = off;
-		expand_symbol(token_table[i].ch, token_table[i].len, buf);
-		printf("\t.asciz\t\"%s\"\n", buf);
-		off += strlen(buf) + 1;
+		off += token_table[i].len + 1;
+		printf("\t.asciz\t\"%s\"\n", token_table[i].str);
 	}
 	printf(".size kallsyms_token_table, . - kallsyms_token_table\n");
 	printf("\n");
@@ -454,7 +441,8 @@ static void write_src(void)
 	for (i = 0; i < symbol_cnt; i++) {
 		se = symbol[i];
 		off = se->seq << 1;
-		if (i && !strcmp((char *)symbol[i - 1]->sym + 1, (char *)se->sym + 1))
+		if (i && symbol[i - 1]->len == se->len &&
+		    !memcmp(symbol[i - 1]->sym + 1, se->sym + 1, se->len - 1))
 			/* Mark that this is a duplicate of the previous symbol */
 			off |= 1;
 		if (off_size == 24) {
@@ -510,20 +498,22 @@ static void build_initial_token_table(void)
 }
 
 static unsigned char *find_token(unsigned char *str, int len,
-				 const unsigned char *token)
+				 unsigned int want)
 {
+	unsigned int token = PAIR(0, *str++);
 	int i;
 
 	for (i = 0; i < len - 1; i++) {
-		if (str[i] == token[0] && str[i+1] == token[1])
-			return &str[i];
+		token = PAIR(RIGHT(token), *str++);
+		if (token == want)
+			return str - 2;
 	}
 	return NULL;
 }
 
 /* replace a given token in all the valid symbols. Use the sampled symbols
  * to update the counts */
-static void compress_symbols(const unsigned char *str, int idx)
+static void compress_symbols(unsigned int token_pair, int idx)
 {
 	unsigned int i, len, size;
 	unsigned char *p1, *p2;
@@ -534,7 +524,7 @@ static void compress_symbols(const unsigned char *str, int idx)
 		p1 = symbol[i]->sym;
 
 		/* find the token on the symbol */
-		p2 = find_token(p1, len, str);
+		p2 = find_token(p1, len, token_pair);
 		if (!p2) continue;
 
 		/* decrease the counts for this symbol's tokens */
@@ -553,7 +543,7 @@ static void compress_symbols(const unsigned char *str, int idx)
 			if (size < 2) break;
 
 			/* find the token on the symbol */
-			p2 = find_token(p1, size, str);
+			p2 = find_token(p1, size, token_pair);
 
 		} while (p2);
 
@@ -569,8 +559,8 @@ static int find_best_token(void)
 {
 	int i, best, bestprofit;
 
-	bestprofit=-10000;
-	best = 0;
+	bestprofit = 0;
+	best = -1;
 
 	for (i = 0; i < 0x10000; i++) {
 		if (token_profit[i] > bestprofit) {
@@ -585,43 +575,56 @@ static int find_best_token(void)
 static void optimize_result(void)
 {
 	int i, best;
+	unsigned int len;
+	struct token_table *left, *right;
+	char *str;
 
-	/* using the '\0' symbol last allows compress_symbols to use standard
-	 * fast string functions */
+	/* Use the '\0' symbol last so the output is unchanged */
 	for (i = 255; i >= 0; i--) {
+		/* Ignore tokens used for the original character codes. */
+		if (token_table[i].len)
+			continue;
 
-		/* if this table slot is empty (it is not used by an actual
-		 * original char code */
-		if (!token_table[i].len) {
+		/* find the token pair with the best profit value */
+		best = find_best_token();
+		if (best < 0)
+			break;
 
-			/* find the token with the best profit value */
-			best = find_best_token();
-			if (token_profit[best] == 0)
-				break;
+		/* replace this token pair in all the valid symbols */
+		compress_symbols(best, i);
 
-			/* place it in the "best" table */
-			token_table[i].len = 2;
-			token_table[i].ch[0] = LEFT(best);
-			token_table[i].ch[1] = RIGHT(best);
+		/* Generate the full name for this symbol */
+		left = &token_table[LEFT(best)];
+		right = &token_table[RIGHT(best)];
 
-			/* replace this token in all the valid symbols */
-			compress_symbols(token_table[i].ch, i);
-		}
+		len = left->len + right->len;
+		str = xmalloc(len + 1);
+		str[len] = 0;
+		memcpy(str, left->str, left->len);
+		memcpy(str + left->len, right->str, right->len);
+		token_table[i].str = str;
+		token_table[i].len = len;
 	}
 }
 
 /* start by placing the symbols that are actually used on the table */
 static void insert_real_symbols_in_table(void)
 {
-	unsigned int i, j, c;
+	unsigned int i, j;
 
 	for (i = 0; i < symbol_cnt; i++) {
 		for (j = 0; j < symbol[i]->len; j++) {
-			c = symbol[i]->sym[j];
-			token_table[c].ch[0] = c;
-			token_table[c].len = 1;
+			token_table[symbol[i]->sym[j]].len = 1;
 		}
 	}
+
+	for (i = 0; i <= 255; i++) {
+		if (!token_table[i].len)
+			continue;
+		token_table[i].str = xmalloc(2);
+		token_table[i].str[0] = i;
+		token_table[i].str[1] = 0;
+	}
 }
 
 static void optimize_token_table(void)
-- 
2.39.5

