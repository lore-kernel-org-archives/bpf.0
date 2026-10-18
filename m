Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191F37B018;
	Sun, 18 Oct 2026 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338790; cv=none; b=GH6qL3qYpfHTwQLDdbhaGXvmNpA3DJFQ2/df9zo7LsrAGoWmqZ/d1BrtVyyOybraNmPhd11iLunawr+HxXyVhHhk7pWSJxNDESP0dKl0lCvTSLv/WkM9Uak7AlzMMcvM7vv0+qNT/3GSU/WGZdkYJCv31l/08MClbCDsINxI9q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338790; c=relaxed/simple;
	bh=DiKpmdS4KQm2r0VrjKS9ujJ5b9ErohUGt5MV9Z7+fA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HxPPN8mez273P9OgfgsUW0sHAvj/Ud5900XaE1yK7eTIJI+T5Lw1dJiocy0dBP5GWX9glhhljB3WzUd23wf7vy/2hJvpaEwu59BL2YXmCn1iye8j4KJJJnk21H7VWDhGhxf4YBtbWXSAqCDXyLNxA6U+GK4V2eaABVYTxlmUXwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=pBsAGL86; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="pBsAGL86"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC4-000Icw-BX; Sun, 18 Oct 2026 17:53:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=XLWj42Gp3WKATmlphZIlU2KwFHLwg2r80unskEaDjI4=; b=pBsAGL86PAIBI04TLn6wz/ToTu
	Tz20Sk7hhC4p/AK6XBcT94QcC0nS4fkCxfY9WKI7sT+RE6Ez9IrRdoppXxk+qDFx2WSmAXhJFmtda
	KgNk8vgqdRkQjOPgBjjWraWAThZKK9v8ijOdep5KY/hJiUavZDplMaIOgF2uPiqK91jrrUwQZ7Akc
	UB0Tpb9GtjybScVmVybxgdIjsH8UiSPYNmwV4jzTfm97l31uIHHcEE+JJAoqymR3UAalxlhJ0Ng49
	cGyYF8vt4UDrkIi0Jbr1q6no6V2Daovc7FDF3lI9nXENsAC6ZrPVe50YjdZsxWBh4yvW1lF6MGaaZ
	6dGZrW2Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITBy-0001pZ-UX; Sun, 18 Oct 2026 17:52:59 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xITBj-004q3U-SQ;
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
Subject: [PATCH v2 next 12/15] kallsyms: scripts/kallsyms: Optimise compress_symbols()
Date: Sun, 18 Oct 2026 16:52:03 +0100
Message-Id: <20261018155206.132411-13-david.laight.linux@gmail.com>
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

When (say) axyb is replaced with azb instead of decrementing the
token_profit[] value for every pair of token in the old string before
the substitution and then incrementing it afterwards just decrement
the counts for ax and yb and increment the ones for az and zb.
Set the count for xy (the number of actual substitions) to zero
afterwards.

This pretty much halves the time taken to do the actual compression
which is by far largest part of the entire process.

Output file unchanged.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 scripts/kallsyms.c | 74 ++++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 45 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 9e1bc0fdaa9f..ee06a9c7435f 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -479,13 +479,11 @@ static void learn_symbol(const unsigned char *sym, int len)
 		token_profit[PAIR(sym[i], sym[i + 1])]++;
 }
 
-/* decrease the count for all the possible tokens in a symbol */
-static void forget_symbol(const unsigned char *sym, int len)
+static void adjust_profit(unsigned int old_left, unsigned int new_left,
+			  unsigned int old_right, unsigned int new_right)
 {
-	int i;
-
-	for (i = 0; i < len - 1; i++)
-		token_profit[PAIR(sym[i], sym[i + 1])]--;
+	token_profit[PAIR(old_left, old_right)]--;
+	token_profit[PAIR(new_left, new_right)]++;
 }
 
 /* do the initial token count */
@@ -497,13 +495,12 @@ static void build_initial_token_table(void)
 		learn_symbol(symbol[i]->sym, symbol[i]->len);
 }
 
-static unsigned char *find_token(unsigned char *str, int len,
+static unsigned char *find_token(unsigned char *str, unsigned char *end,
 				 unsigned int want)
 {
 	unsigned int token = PAIR(0, *str++);
-	int i;
 
-	for (i = 0; i < len - 1; i++) {
+	while (str < end) {
 		token = PAIR(RIGHT(token), *str++);
 		if (token == want)
 			return str - 2;
@@ -512,46 +509,33 @@ static unsigned char *find_token(unsigned char *str, int len,
 }
 
 /* replace a given token in all the valid symbols. Use the sampled symbols
- * to update the counts */
-static void compress_symbols(unsigned int token_pair, int idx)
+ * to update the counts.
+ * Marked noinline to help register allocation. compress_symbols() is only called
+ * about 200 times whereas find_token() can be called well over a million times. */
+static __attribute__((noinline)) void compress_symbols(unsigned int token_pair, int idx)
 {
-	unsigned int i, len, size;
-	unsigned char *p1, *p2;
+	unsigned int i, len;
+	unsigned char *sym, *p, *end;
 
 	for (i = 0; i < symbol_cnt; i++) {
-
-		len = symbol[i]->len;
-		p1 = symbol[i]->sym;
-
-		/* find the token on the symbol */
-		p2 = find_token(p1, len, token_pair);
-		if (!p2) continue;
-
-		/* decrease the counts for this symbol's tokens */
-		forget_symbol(symbol[i]->sym, len);
-
-		size = len;
-
-		do {
-			*p2 = idx;
-			p2++;
-			size -= (p2 - p1);
-			memmove(p2, p2 + 1, size);
-			p1 = p2;
-			len--;
-
-			if (size < 2) break;
-
-			/* find the token on the symbol */
-			p2 = find_token(p1, size, token_pair);
-
-		} while (p2);
-
-		symbol[i]->len = len;
-
-		/* increase the counts for this symbol's new tokens */
-		learn_symbol(symbol[i]->sym, len);
+		sym = symbol[i]->sym;
+		end = sym + symbol[i]->len;
+
+		for (p = sym; (p = find_token(p, end, token_pair)); p++) {
+			len = end - p - 2;
+			end--;
+			*p = idx;
+			if (p != sym)
+				adjust_profit(p[-1], p[-1], LEFT(token_pair), idx);
+			if (!len)
+				break;
+			adjust_profit(RIGHT(token_pair), idx, p[2], p[2]);
+			memmove(p + 1, p + 2, len);
+		}
+		symbol[i]->len = end - sym;
 	}
+
+	token_profit[token_pair] = 0;
 }
 
 /* search the token with the maximum profit */
-- 
2.39.5

