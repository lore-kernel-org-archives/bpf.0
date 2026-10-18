Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CA73B530F
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338792; cv=none; b=QiAjv7lUaez0/b0tr2EuUve7d6S0ZzR6JuvcOhr6gGYPGythpSdo+SEw/Rp2Q19dfm4lBjhPCQobsJTURaP1+l6lZzE+gxa2+GadR/8ifaFWAt7mokOspoM+5sIV3LaLDaghBS0SpoisOfwmrrCWMKiBAvDCIUY86HmTaDlWna0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338792; c=relaxed/simple;
	bh=bFtfrDFfJiFgzrOGha7X+aYjJEuOgNNxvP6urm8vnsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=omlUbubbrrjFGbxfgZd5OcLzTnOPHNa4vFJEy5qjHjUlN3KnGSamzIUKMgNPzIusLks0HfU/kFfvIOLB7UJ4Li1fbFffxKXy9AMDjOtR6R80VK/vxZ3vzjU3YhrbeUua3gcv+wmsBKwONGae7Ze5ASLyUhHHOdlAsmovRmiZZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=Xc1S+Jf8; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="Xc1S+Jf8"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC4-000IdH-US; Sun, 18 Oct 2026 17:53:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=yXPKNCrTN84ndLWWFsp5Lhf/pJS8VAJCKJYB6ObXzLQ=; b=Xc1S+Jf8vfCRaiAKGxAg5BZUkr
	+rmNykpMiVRy4hM7zw2uQGA81tQL4ACEEv0fEWCkHJlq+q9ROwhfVRAw9Y3t3MGvUb+Eii7OUlFbE
	AhtDrvUI0trMu1AtUlGkO+uefAqWOIPEn3aQ8XtxUDVaAjewFT196lF1+Vc3pXKE/yVgRJPN47OFD
	XUcvHhmJT0SJUWxQ+oEHPhJaLCIaNQ8jGjp4zEg8JhDMbDdiipqEk8E8ikreOC3QKwke+wKOjy/9E
	tD1N53lclZJls8GjgpQGEEbQ7+mcU0gJTnrckGP6vedKLgtlBvl9Tm2UJ2lz+QBO/eoN2T4lTBMq2
	fDcJgGJg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITBz-0000Bb-HJ; Sun, 18 Oct 2026 17:52:59 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xITBl-004q3U-Fh;
	Sun, 18 Oct 2026 17:52:45 +0200
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
Subject: [PATCH 15/15] kallsyms: scripts/kallsyms: Improve compression by about 2%
Date: Sun, 18 Oct 2026 16:52:06 +0100
Message-Id: <20261018155206.132411-16-david.laight.linux@gmail.com>
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

If the symbols contain a lot of "abc" and "abd" and a few "abe" then
the compression code first substitutes (say) 'x' for "ab" giving
"xc", "xd" and "xe".
It might later substitute 'y' for "xc" and 'z' for "xd" giving
"y", "z" and "xe".
The token 'x' is then hardly used, expanding "xe" back to "abe"
costs one byte every time it is used, but frees up 'x' to be used
for a much more common symbol pair.

Add a check at the end of the compression that all the counts still match.

Increases the compression ratio by about 2% on both the 'normal'
kernel I'm building and on the x86-64 allyesconfig kernel.

For simplicity the code will only expand a token where the two tokens
that were merged are still in the table.
It might be possible to find some others, eg ones that are 3 characters.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 scripts/kallsyms.c | 137 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 127 insertions(+), 10 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8576fe6ad90b..9dbd7c85eec1 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -76,6 +76,7 @@ static int token_profit[0x10000];
 static struct token_table {
 	char           *str;		/* Full expansion, '\0' terminated */
 	unsigned short len;		/* Length of str */
+	unsigned short pair;		/* Original token pair for this token */
 	unsigned int   refs;		/* Number of time used in a symbol */
 } token_table[256];
 
@@ -514,6 +515,37 @@ static void build_initial_token_table(void)
 		learn_symbol(symbol[i]->sym, symbol[i]->len);
 }
 
+/* Check that the token_profit[] matches the compressed symbols. */
+static void check_tables(void)
+{
+	unsigned int save_profit[0x10000];
+	unsigned int tok_refs[256];
+	unsigned int i, j;
+
+	memcpy(save_profit, token_profit, sizeof(save_profit));
+	memset(token_profit, 0, sizeof(token_profit));
+
+	build_initial_token_table();
+
+	for (i = 0; i < 0x10000; i++) {
+		if (token_profit[i] != save_profit[i])
+			errx(1, "profit error for %u,%u (%s/%s) discrepency %u != %u\n",
+			     LEFT(i), RIGHT(i), token_table[LEFT(i)].str,
+			     token_table[RIGHT(i)].str, token_profit[i], save_profit[i]);
+	}
+
+	memset(tok_refs, 0, sizeof(tok_refs));
+	for (i = 0; i < symbol_cnt; i++)
+		for (j = 0; j < symbol[i]->len; j++)
+			tok_refs[symbol[i]->sym[j]]++;
+
+	for (i = 1; i < 256; i++) {
+		if (tok_refs[i] != token_table[i].refs)
+			errx(1, "token reference error for %u (%s) %u != %u\n",
+			     i, token_table[i].str, token_table[i].refs, tok_refs[i]);
+	}
+}
+
 static unsigned char *find_token(unsigned char *str, unsigned char *end,
 				 unsigned int want)
 {
@@ -561,6 +593,47 @@ static __attribute__((noinline)) unsigned int compress_symbols(unsigned int toke
 	return substitutions;
 }
 
+/* Change every occurance of idx back to token_pair.
+ * This extends all the symbol table entries but frees up a token. */
+static __attribute__((noinline)) void uncompress_symbols(unsigned int token_pair, int idx)
+{
+	unsigned int i, len;
+	unsigned char *sym, *p, *end;
+	unsigned int substitutions;
+
+	for (i = 0; i < symbol_cnt; i++) {
+		sym = symbol[i]->sym;
+		len = symbol[i]->len;
+		p = memchr(sym, idx, len);
+		if (!p)
+			continue;
+		end = sym + len;
+
+		do {
+			len = end - p - 1;
+			end++;
+			if (len) {
+				adjust_profit(idx, RIGHT(token_pair), p[1], p[1]);
+				memmove(p + 2, p + 1, len);
+			}
+			p[0] = LEFT(token_pair);
+			p[1] = RIGHT(token_pair);
+			if (p != sym)
+				adjust_profit(p[-1], p[-1], idx, LEFT(token_pair));
+			p = memchr(p + 2, idx, len);
+		} while (p);
+		symbol[i]->len = end - sym;
+	}
+
+	substitutions = token_table[idx].refs;
+
+	token_profit[token_pair] += substitutions;
+
+	token_table[idx].refs = 0;
+	token_table[LEFT(token_pair)].refs += substitutions;
+	token_table[RIGHT(token_pair)].refs += substitutions;
+}
+
 /* search the token with the maximum profit */
 static int find_best_token(void)
 {
@@ -578,14 +651,47 @@ static int find_best_token(void)
 	return best;
 }
 
+static int split_token(unsigned int profit)
+{
+	struct token_table *tt, *left, *right;
+	unsigned int i;
+	int best = -1;
+
+	for (i = 0; i < 256; i++) {
+		tt = token_table + i;
+
+		if (tt->len == 1 || tt->refs >= profit)
+			continue;
+
+		/* Ignore tokens where the original parts have be reused */
+		left = &token_table[LEFT(tt->pair)];
+		right = &token_table[RIGHT(tt->pair)];
+		if (tt->len != left->len + right->len ||
+		    memcmp(tt->str, left->str, left->len) ||
+		    memcmp(tt->str + left->len, right->str, right->len))
+			continue;
+
+		best = i;
+		if (tt->refs == 2)
+			break;
+		profit = tt->refs;
+	}
+	if (best < 0)
+		return -1;
+
+	uncompress_symbols(token_table[best].pair, best);
+
+	return best;
+}
+
 /* this is the core of the algorithm: calculate the "best" table */
 static void optimize_result(void)
 {
-	unsigned int i, idx, len, refs;
-	struct token_table *left, *right;
+	struct token_table *t, *left, *right;
 	unsigned char to_process[256];
+	unsigned int idx, len, refs;
+	int i, best;
 	char *str;
-	int best;
 
 	/* Generate a list of the unused tokens. */
 	for (i = 0, idx = 0; i < 256; i++) {
@@ -593,20 +699,28 @@ static void optimize_result(void)
 			to_process[idx++] = i;
 	}
 
-	do {
+	for (;;) {
 		/* find the token pair with the best profit value */
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
 
 		/* replace this token pair in all the valid symbols */
 		refs = compress_symbols(best, i);
+		t = &token_table[i];
 
 		/* Update the number of times each token is used */
-		token_table[i].refs += refs;
+		t->refs += refs;
+		t->pair = best;
 
-		/* Generate the full name for this symbol */
 		left = &token_table[LEFT(best)];
 		right = &token_table[RIGHT(best)];
 		if (!(left->refs -= refs))
@@ -621,9 +735,10 @@ static void optimize_result(void)
 		str[len] = 0;
 		memcpy(str, left->str, left->len);
 		memcpy(str + left->len, right->str, right->len);
-		token_table[i].str = str;
-		token_table[i].len = len;
-	} while (idx);
+		free(t->str);
+		t->str = str;
+		t->len = len;
+	}
 }
 
 /* start by placing the symbols that are actually used on the table */
@@ -654,6 +769,8 @@ static void optimize_token_table(void)
 	insert_real_symbols_in_table();
 
 	optimize_result();
+
+	check_tables();
 }
 
 /* guess for "linker script provide" symbol */
-- 
2.39.5

