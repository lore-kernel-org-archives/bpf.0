Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDAC3CF047;
	Sun, 18 Oct 2026 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338800; cv=none; b=nj0QVAKto3G67K3i/iJVB1WGjF3PmnJVMb2MXkgnOwIpABYGbABRKFDw4Z3w/RSSf+xrsHMlXtnsGjTb6kiOcOx8yvSGIB8Q1aPdXgUWpEsoviTIChB4RTUo1Oe5o7FaTdHcgsdQtCbydpPm/sPmUfoqjlBXuqs6bv7iWrh1PPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338800; c=relaxed/simple;
	bh=h48Jt4DOAyx1UsN/SeYOc9zyhdVg5SaIyCPO+fI7Atc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IinBza2DVAaRDM/02xtgog/QPuudKRv9QB1pe9LzLc8I+ESvKetskReiO0Ryg26yfejBJXJf+5VRXmBG3V2i2QL9FehQLzCJO7D7JfHjo37IV4J2QNg8NIXdq3MBfvbCQPhmam/RdBo0fqXk9C0srDw6ozab/JzA0f/yWobe60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=dZF1Ry3J; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="dZF1Ry3J"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC5-001KBv-P2; Sun, 18 Oct 2026 17:53:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=EL6NkSrwprg57F2VdDLVn9DgamauTvELvhUv6gcZ5dk=; b=dZF1Ry3J3eoaLckiS2i2rsFylN
	Q7RZimipLRhzbf4xFJezMrAOwe1DsffrOTSWxYyk3ZjOQhHpkwbh1vmnghLlR1fHn5vrj2FNb4hHc
	45xW2CCVvGMWadbTSsVbw84zuNWxrMygVD8sAj3B+WFHE2u9DfSkKjRLsXccKtDpfrvbR9dJQjK4j
	BSjj0HiG1dpabNCReEqylRYw+9gFRmjstQzQXz0Fo9yF0Z2ElascKuFxT6bo+mfBU8FMjQ6AXRSse
	myFcxrbzIxz/OY3s/dpJxV/JPpY+T5wbSAwrDD6oIZTLDx5h0/LU1WV8r4PqeFfqj6YSxpFVvr5x3
	mA4wJ3Sw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC0-0000Bo-Ek; Sun, 18 Oct 2026 17:53:00 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xITBk-004q3U-DC;
	Sun, 18 Oct 2026 17:52:44 +0200
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
Subject: [PATCH v2 next 13/15] kallsyms: scripts/kallsyms: Reuse tokens that have no references
Date: Sun, 18 Oct 2026 16:52:04 +0100
Message-Id: <20261018155206.132411-14-david.laight.linux@gmail.com>
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

Keep track of the number of times each compression token is used.
If the count becomes zero (eg if the only x are in axb and y is
substituted for xb giving ay) then x can be reused.

This means that a token can refer to a long string without needing
tokens for all the shorter strings.

For my normal kernel build four tokens get reused saving 8.5k of data.
The savings may be greater if there are symbols with long matching prefix.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 scripts/kallsyms.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index ee06a9c7435f..189fb50ec8c5 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -76,6 +76,7 @@ static int token_profit[0x10000];
 static struct token_table {
 	char           *str;		/* Full expansion, '\0' terminated */
 	unsigned short len;		/* Length of str */
+	unsigned int   refs;		/* Number of time used in a symbol */
 } token_table[256];
 
 static void usage(void)
@@ -404,7 +405,8 @@ static void write_src(void)
 	for (i = 0; i < 256; i++) {
 		best_idx[i] = off;
 		off += token_table[i].len + 1;
-		printf("\t.asciz\t\"%s\"\n", token_table[i].str);
+		printf("\t.asciz\t\"%s\"\t/* %u: %u */\n",
+		       token_table[i].str, i, token_table[i].refs);
 	}
 	printf(".size kallsyms_token_table, . - kallsyms_token_table\n");
 	printf("\n");
@@ -512,10 +514,11 @@ static unsigned char *find_token(unsigned char *str, unsigned char *end,
  * to update the counts.
  * Marked noinline to help register allocation. compress_symbols() is only called
  * about 200 times whereas find_token() can be called well over a million times. */
-static __attribute__((noinline)) void compress_symbols(unsigned int token_pair, int idx)
+static __attribute__((noinline)) unsigned int compress_symbols(unsigned int token_pair, int idx)
 {
 	unsigned int i, len;
 	unsigned char *sym, *p, *end;
+	unsigned int substitutions;
 
 	for (i = 0; i < symbol_cnt; i++) {
 		sym = symbol[i]->sym;
@@ -535,7 +538,10 @@ static __attribute__((noinline)) void compress_symbols(unsigned int token_pair,
 		symbol[i]->len = end - sym;
 	}
 
+	substitutions = token_profit[token_pair];
 	token_profit[token_pair] = 0;
+
+	return substitutions;
 }
 
 /* search the token with the maximum profit */
@@ -558,29 +564,41 @@ static int find_best_token(void)
 /* this is the core of the algorithm: calculate the "best" table */
 static void optimize_result(void)
 {
-	int i, best;
-	unsigned int len;
+	unsigned int i, idx, len, refs;
 	struct token_table *left, *right;
+	unsigned char to_process[256];
 	char *str;
+	int best;
 
-	/* Use the '\0' symbol last so the output is unchanged */
-	for (i = 255; i >= 0; i--) {
-		/* Ignore tokens used for the original character codes. */
-		if (token_table[i].len)
-			continue;
+	/* Generate a list of the unused tokens. */
+	for (i = 0, idx = 0; i < 256; i++) {
+		if (!token_table[i].len)
+			to_process[idx++] = i;
+	}
 
+	do {
 		/* find the token pair with the best profit value */
 		best = find_best_token();
 		if (best < 0)
 			break;
+		i = to_process[--idx];
 
 		/* replace this token pair in all the valid symbols */
-		compress_symbols(best, i);
+		refs = compress_symbols(best, i);
+
+		/* Update the number of times each token is used */
+		token_table[i].refs += refs;
 
 		/* Generate the full name for this symbol */
 		left = &token_table[LEFT(best)];
 		right = &token_table[RIGHT(best)];
+		if (!(left->refs -= refs))
+			/* There are no references left, reuse the token. */
+			to_process[idx++] = LEFT(best);
+		if (!(right->refs -= refs))
+			to_process[idx++] = RIGHT(best);
 
+		/* Generate the full name for this symbol */
 		len = left->len + right->len;
 		str = xmalloc(len + 1);
 		str[len] = 0;
@@ -588,7 +606,7 @@ static void optimize_result(void)
 		memcpy(str + left->len, right->str, right->len);
 		token_table[i].str = str;
 		token_table[i].len = len;
-	}
+	} while (idx);
 }
 
 /* start by placing the symbols that are actually used on the table */
@@ -598,13 +616,14 @@ static void insert_real_symbols_in_table(void)
 
 	for (i = 0; i < symbol_cnt; i++) {
 		for (j = 0; j < symbol[i]->len; j++) {
-			token_table[symbol[i]->sym[j]].len = 1;
+			token_table[symbol[i]->sym[j]].refs++;
 		}
 	}
 
 	for (i = 0; i <= 255; i++) {
-		if (!token_table[i].len)
+		if (!token_table[i].refs)
 			continue;
+		token_table[i].len = 1;
 		token_table[i].str = xmalloc(2);
 		token_table[i].str[0] = i;
 		token_table[i].str[1] = 0;
-- 
2.39.5

