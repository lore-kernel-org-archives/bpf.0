Received: from mail-wr2-f24.google.com (mail-wr2-f24.google.com [74.125.225.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B4F2DF128
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774494; cv=none; b=kW829HMeEQ/qdk7YewzJ/d+7Z5HlyBEqJs+pgNEbaucOlMONkZoaK7HeiGBphPys4ezTjiqKThri0B/lA0VqovF/hb3w6WLMkz/RjQr4yKgfxbTrFwN0hCw9uujbrmxsoZv/21WQhZ/PKrrF2bSz8QWmzy1ww/TuLp/+JH9TwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774494; c=relaxed/simple;
	bh=9w7RU5zcujV+KSe7J6OW/8YyFKXnIOzIBtcy+k5du9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IQ7bAcMhnUOix657xyroBPJ+3e9CCcJ/LcZzMERpxxqg6o3W9ufdwpwIixKT+BVDH1eAFiKkIbRJI1RLlEEJC+WCsrllhYwFlQ/kJ8HNzUB15FnxJTCdciVpTT/+GMsw7LG25XfoGkG2zwpaoWmlFknScvJBJ9IGAxJbHJv02bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8f1QJW+; arc=none smtp.client-ip=74.125.225.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8f1QJW+"
Received: by mail-wr2-f24.google.com with SMTP id ffacd0b85a97d-482f63546c3so4187410f8f.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 06:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790774474; x=1791379274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fP6dHKs+XEgtmnRzI+NAxjgMH9T3XFvRmKv/GSHjTzw=;
        b=T8f1QJW+hBGBIC4/uBQJ2Tq0Or/Q/G0nvJ5jvtHCajP8MyOMZOBeKMHevPb9OkE3aK
         0JesZQVP2AKaoAClL2KBmZvm3xlLNICkuR8P7pKPRCC3B9YPQRnkCGg+VpyOpE43W81V
         pCbB16vAhAM70pFVRp+JGulEkg10SVvGu/+Rqnma4QDhjMINNz/6SgeToIk1gUadi7Q8
         2GxLN1XCC64WJh/rJhx/DkMhtsS3pKceKS/3NSnCnP7c0LROBqKaOIjbCRvHZ+CdmrKt
         /MqTp+PWsbdM0lx1qPssIFnyr/gOUAy5J2e03JTfFH7JwjcswPNXYgPXoAWo9rS33T5q
         EpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790774474; x=1791379274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fP6dHKs+XEgtmnRzI+NAxjgMH9T3XFvRmKv/GSHjTzw=;
        b=H7b2iTJVgvoOSi1MoUXKj6ZARpaqjua01Rgtf7xYpVa/8qp+e2TZXRL6zCz9ZFlGqA
         Fk9I5oJ/yiTReK+Ny8gN0Yckjv7p+6akAo/m3WHBKPBAxrgsKidzXlWno0K7HNYWHk2Y
         1qKTHPCeZvLnJkQmr754a7Llo6QS0YYwUjsgUoXfMdkt+U5SfKhKr4xzq3ZZYKLNZd0u
         fmuWiytu8V4uTRpgafVMyzrK7D/pZ9LYMu0ZhvwKgYPVe+uwoA/p006WxsOd1s0UFR3t
         1WCl5vSQjiTyeZIC7SVhoxU9mofsx3pENZFKX7p9e002yWAb6A2GOT0Omm3EMqi05g5l
         ZbEw==
X-Forwarded-Encrypted: i=1; AKwUvBxOJ6KYQkyBZnDxrakLo1HKjCbsXwiNUnRMFDI8l3ig6YBf3QQ2fIGwcO4KH7IHTEQSND8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBS3RGUdhfRenZu9axnUToFpLcSiHAOpRhEzOuVQ4OfmY2esKl
	zrFp+4sno9TNQftn/ZuGS4Pn5SzCxoeWbi/gzguxrO+FNfeM+Rf4ja24
X-Gm-Gg: AYBFou1WQh11sCQEl88ZgYHIiaksS/bf/ARIrvBZh8llUiXABhss098jaUdI0+dYG9v
	MCJEiSxVZiephzuHpMpmg1rWzH5WuMEyP7J7W8cAG+CSJnMHmpMH5UBHyi0M07aw9MNdPY7OwOr
	m1pL7aGoSlv9d1F+BpfjIRJWrbTbiCE0r4I2yzd94snSyOFUumC4A+FaJ2uL+XrOlCecnrzMTi0
	+ZezBOVc4YzCRU9yzepaCucpMkpq9jwj+EiORJ5ADOVLZIrorY4HQR12EZiSuU4gScBfWqUYGoa
	8YKu4s1P0IxOqPbRkUI69q85RWEd4X89vdePQg58ectkno8Wo3+HQZ1WLWE7O0/fJS2sijFOt9F
	6RY8zPNng1Sycga0xE9lH/oEoIPaEmhG1k7Bu9EnZTORDamsXqo4ehmH3A2QR8eS/fpiRzOzHz/
	aQgmciHNnDPy6/jU+pWJ3eZd/c5p+oEbuJSjHs8qCY26unRI3rA5dDluxOntkDTzt5EahqwbHfG
	s0hFQ1Cfgc0WpVL1qDMAiIK4ujqBM9+7Nu1D8HBwXaBfJi9rqdNB4w=
X-Received: by 2002:a05:6000:2401:b0:48a:f404:6960 with SMTP id ffacd0b85a97d-48b024c5c7amr3123964f8f.9.1790774473825;
        Wed, 30 Sep 2026 06:21:13 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b029bef64sm5047284f8f.10.2026.09.30.06.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 06:21:13 -0700 (PDT)
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
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/2] kallsyms: Match compressed tokens on the fly during binary search
Date: Wed, 30 Sep 2026 14:21:07 +0100
Message-Id: <20260930132109.260597-2-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260930132109.260597-1-david.laight.linux@gmail.com>
References: <20260930132109.260597-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Cromie <jim.cromie@gmail.com>

kallsyms_lookup_names() runs a binary search across ~184k tokenized
(compressed) symbols.  For each of the ~17 comparisons in the search, it
currently decompresses the candidate symbol into a temporary buffer on
the stack before calling strcmp().

Comparing tokenized symbols directly in compressed space is
impossible.  The BPE token table assigns values by frequency, not
alphabetical order (e.g. token 0x05 might expand to "zebra" while 0x42
expands to "apple"), so comparing raw token values scrambles
lexicographical order.  Even sorting the token table alphabetically
wouldn't help; "bpf_" and "bpf_foo_" do not *have* a determinative
sorting order, because the suffixes following those tokens would
matter.

However, full string expansion at every step is equally wasteful: of
the ~17 strcmps in the binary search, only the last needs to check
all N chars in both strings, earlier steps will know +/- outcome at
char 0,1,2..N-1.

However, full string expansion at every step is equally wasteful: of
the ~17 strcmp()s in the binary search, only the final matching step
needs to test all characters.  Earlier non-matching steps diverge at
the first differing character (0..N-1), but the baseline expands every
candidate symbol to the stack unconditionally, before comparing.

So we introduce kallsyms_strcmp_symbol() to compare ASCII search_name
against tokenized symbols on the fly.  Like strcmp, it tests the
strings char by char, but when it hits a token in the symbol-string,
it continues the char-test against that token-string, which is in
kallsyms_token_table[].  It returns +- on 1st mismatch.

Measured across all ~184k symbols via CONFIG_KALLSYMS_SELFTEST, this
shaves ~530 ns (~14%) off average kallsyms_lookup_name() latency (from
~3810 ns to ~3280 ns on the default 256:1 baseline) and drops the
512-byte namebuf buffer stack-alloc in kallsyms_lookup_names().

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 kernel/kallsyms.c | 94 +++++++++++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 35 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index aec2f06858af..d18d78e626db 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -34,6 +34,21 @@
 
 #include "kallsyms_internal.h"
 
+/*
+ * Get the compressed symbol length and data pointer.
+ */
+static inline const u8 *get_symbol_data(unsigned int off, unsigned int *len)
+{
+	const u8 *p = &kallsyms_names[off];
+	unsigned int l = *p++;
+
+	if (unlikely(l & 0x80))
+		l = (l & 0x7F) | (*p++ << 7);
+	*len = l;
+
+	return p;
+}
+
 /*
  * Expand a compressed symbol data into the resulting uncompressed string,
  * if uncompressed string is too long (>= maxlen), it will be truncated,
@@ -42,28 +57,12 @@
 static unsigned int kallsyms_expand_symbol(unsigned int off,
 					   char *result, size_t maxlen)
 {
-	int len, skipped_first = 0;
+	int skipped_first = 0;
 	const char *tptr;
-	const u8 *data;
+	unsigned int len;
+	const u8 *data = get_symbol_data(off, &len);
 
-	/* Get the compressed symbol length from the first symbol byte. */
-	data = &kallsyms_names[off];
-	len = *data;
-	data++;
-	off++;
-
-	/* If MSB is 1, it is a "big" symbol, so needs an additional byte. */
-	if ((len & 0x80) != 0) {
-		len = (len & 0x7F) | (*data << 7);
-		data++;
-		off++;
-	}
-
-	/*
-	 * Update the offset to return the offset for the next symbol on
-	 * the compressed stream.
-	 */
-	off += len;
+	off = (data - kallsyms_names) + len;
 
 	/*
 	 * For every byte on the compressed symbol data, copy the table
@@ -101,14 +100,43 @@ static unsigned int kallsyms_expand_symbol(unsigned int off,
  */
 static char kallsyms_get_symbol_type(unsigned int off)
 {
-	/*
-	 * Get just the first code, look it up in the token table,
-	 * and return the first char from this token. If MSB of length
-	 * is 1, it is a "big" symbol, so needs an additional byte.
-	 */
-	if (kallsyms_names[off] & 0x80)
-		off++;
-	return kallsyms_token_table[kallsyms_token_index[kallsyms_names[off + 1]]];
+	unsigned int len;
+	const u8 *data = get_symbol_data(off, &len);
+
+	return kallsyms_token_table[kallsyms_token_index[*data]];
+}
+
+/*
+ * Compare an uncompressed ASCII string against a compressed symbol table entry.
+ * Returns negative if name < sym, positive if name > sym, 0 if equal.
+ * Exits immediately on the first mismatched character without decompressing
+ * the rest of the symbol name.
+ */
+static int kallsyms_strcmp_symbol(unsigned int off, const char *name)
+{
+	const char *tptr;
+	unsigned int len;
+	const u8 *data = get_symbol_data(off, &len);
+
+	tptr = &kallsyms_token_table[kallsyms_token_index[*data++]] + 1;
+	while (*tptr) {
+		int diff = (unsigned char)*name++ - (unsigned char)*tptr++;
+
+		if (diff)
+			return diff;
+	}
+
+	while (--len) {
+		tptr = &kallsyms_token_table[kallsyms_token_index[*data++]];
+		do {
+			int diff = (unsigned char)*name++ - (unsigned char)*tptr++;
+
+			if (diff)
+				return diff;
+		} while (*tptr);
+	}
+
+	return (unsigned char)*name;
 }
 
 
@@ -174,7 +202,6 @@ static int kallsyms_lookup_names(const char *name,
 	int ret;
 	int low, mid, high;
 	unsigned int seq, off;
-	char namebuf[KSYM_NAME_LEN];
 
 	low = 0;
 	high = kallsyms_num_syms - 1;
@@ -183,8 +210,7 @@ static int kallsyms_lookup_names(const char *name,
 		mid = low + (high - low) / 2;
 		seq = get_symbol_seq(mid);
 		off = get_symbol_offset(seq);
-		kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
-		ret = strcmp(name, namebuf);
+		ret = kallsyms_strcmp_symbol(off, name);
 		if (ret > 0)
 			low = mid + 1;
 		else if (ret < 0)
@@ -200,8 +226,7 @@ static int kallsyms_lookup_names(const char *name,
 	while (low) {
 		seq = get_symbol_seq(low - 1);
 		off = get_symbol_offset(seq);
-		kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
-		if (strcmp(name, namebuf))
+		if (kallsyms_strcmp_symbol(off, name) != 0)
 			break;
 		low--;
 	}
@@ -212,8 +237,7 @@ static int kallsyms_lookup_names(const char *name,
 		while (high < kallsyms_num_syms - 1) {
 			seq = get_symbol_seq(high + 1);
 			off = get_symbol_offset(seq);
-			kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
-			if (strcmp(name, namebuf))
+			if (kallsyms_strcmp_symbol(off, name) != 0)
 				break;
 			high++;
 		}
-- 
2.39.5

