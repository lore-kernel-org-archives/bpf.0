Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7163A3B19B7
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107729; cv=none; b=mqmqYCm4DiAtPG3La37aZIZqLI0MG6cFoiKJ4WJihTPKGPpPyRgXyu+lXi//Mk+1SZuU1v/FURu5/yNd9zg1jsGgfAIPhEnRkwl2Nir+ZHHoMcJBBF3C+P1/Nazt09lwrXGuGf9cSsCWz3nmZK0eXf5JRQUKezucEVcbg5Zpsq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107729; c=relaxed/simple;
	bh=uSwF8oSlv0A6TNXHp0b7ZlXImXaVRQqeD6cloMWgLIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EaTZdP52RMdbsetw6SqxtoOpGl88NZnCxM78FenzdtKSZzy2hIV7cTM1vKgs/9/OjEQbo1y4gJ6FogBleh2zux2d+KhOdH/+2V8GRB+Tv4nhDJDmdMcffvHxqNI27o+7N042Y1CNpBeyz8zZ10iXlFs1KXUxnx7Crhp0LSOwddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qXi/mCry; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXi/mCry"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6b1ae6b2010so144934eaf.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790107709; x=1790712509; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hU8R4H4DyIVzYPzLtsXcibjq0wK/EbWMtmm1iMO2MGU=;
        b=qXi/mCryMvu6Qjzs7V7B1D+PkPGpTy8bq2gwbBZXZhxc4YfmTnRgntUxqPF6YuJS3S
         hhBdirNiKrFrcytPDYq+k/JizqnLdIAi58RcuOl8B8Q6mwDPCXauR9odeTsdw0xhOJFA
         9eu3wi/UWdLKxf7R3IQBrEgoDPLBwldCsx7ggyekIZCY39CNZtZYLKPzmyKxz8W+jhvY
         KJM2ddLWKtRIZagsgF/y83A/l2JZvKc24tmStJsSkv68hHmXz+fMLv3AEs/UgWcbLxzI
         DIxawRUshu8Bius8GJAyrJeTONMt12ZwgSvUBTes5ZjFovTZqGPR2pcSVIwmhRqIYlq5
         jMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107709; x=1790712509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hU8R4H4DyIVzYPzLtsXcibjq0wK/EbWMtmm1iMO2MGU=;
        b=X/IlI3KrtaF+dw9W0t/f15l5g3uo/hUKAtFIrECGaiNTVXcYNjYUqoXQcuKtIxKfAF
         u3j+pSFaX+pLEqWET8NAGT7k6MCgVGwVckjSSMEvRyz3rxq885t3Me8Ij4SDvMJ7xj/u
         Tx9XqlcQnAYIVKw6wq3wypZ6Lt/Mx7Um9Kuxhb3e/oJoytQXCdiZ0KGGT12auQNkZnFG
         pcM/aaLMQhzI86ypeJxY/mBseGvKzH+NkYXF7pzb0A4iBF4oMs4a6lgWgZJFIC74Miye
         YAQqFYRTwmvbKd4ah+e/tmNnfNBOWKy3l994Rk2yv87yoHAyw9c4MMnTUcQuRckrEW/F
         z5gw==
X-Forwarded-Encrypted: i=1; AKwUvBxmzB/7nQo6UtSnPlHVBR2egMyEEGs5UPpzwjVu/3L7JKAF6biibawIkqAP74+jZu+CqPE=@vger.kernel.org
X-Gm-Message-State: AFuF++khQeLtx0pzXxLkdbKuWMyCXvIUJDWiptsu5kci4huIwdJzibo7
	KiX5c0BlFmk+bFPSxBkcGz/JMzJekRK7TNbVLaOvqYCEByDOpdCRbyxF
X-Gm-Gg: AYBFou0wMOJg2n5F0MLTmWzklToJgPupqmFdgrcpNdeSEMXUlp8M+xl2zBiNMYFAoqR
	FaL4J/2IoCq6bgrr84iH8hfO6KJEgMq/JL/i0UJqcsLblr8Kj/0hw6lrfCK6VY9Fk7dPvhklc7k
	GoIXNsEH4QOm+R8draPMHW9dZ9yt4uUgof59O8HF2LJwQODKihrU8vxNZsYVMvFKhi/RQQoAyZs
	AehwsYoSZVaajDcxfifJ2gVKDq34yMAtVgxFzIVXc+k6/UdinciiavCuILyRBRX/kxLtEBVNnv4
	F6ou0RPbE4lfjD8pfmT8wEYf+fzAmUOiZke3D2OootKEEadrdtZ8pB1QlxEPxQPJ60j7pqMipfb
	NyxdRDu7H75SGTOY7hpGkBJmgsfMIB9xJ6OcWg8bpjWO/SjKPd8szLIr1tQoXnfICvOs34Quy45
	ZC98WWfh1zTyv91iZVC0hVYGPu6enTAYo4Mmd54xm76M7fzy0AHNgw4djG2P5kBRboB0JZ2Jgvl
	/29Z8bEfzEFd+CRaPDu8P2mQvnLXh5sJ2HryPmlHUJUaObAz9pEUwD7upRsH8vlBHZEF2OI8j2B
	ZqNBeRGdExdW0Q8HLCQ=
X-Received: by 2002:a05:6820:c84:b0:6cd:3fcc:96ce with SMTP id 006d021491bc7-6d2d4011734mr383971eaf.76.1790107708875;
        Tue, 22 Sep 2026 13:08:28 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4908eb9237asm564087fac.12.2026.09.22.13.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:08:28 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 22 Sep 2026 14:08:19 -0600
Subject: [PATCH v4 2/4] kallsyms: Match compressed tokens on the fly during
 binary search
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ksyms-tune-v4-2-92acea84b911@gmail.com>
References: <20260922-ksyms-tune-v4-0-92acea84b911@gmail.com>
In-Reply-To: <20260922-ksyms-tune-v4-0-92acea84b911@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790107704; l=6596;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=uSwF8oSlv0A6TNXHp0b7ZlXImXaVRQqeD6cloMWgLIg=;
 b=/tW6RZRloOuryOC5xA4efhF3zwIkn8HHOER8txp3BY+91F5eJdUteV4ztrCpuKMcTnyJpH2+R
 kyP+0nRyZ3uCS8oMyRS2eUwNGKoru1wbFDQ+/KP2i3xCifRtQPccFFb
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

kallsyms_lookup_names() runs a binary search across kallsyms_names[],
a packed array of ~130k encoded kernel symbols.  For each of the ~17
comparisons in the search, it currently decompresses the candidate
symbol into a temporary buffer on the stack before calling strcmp().

Comparing raw tokens directly in compressed space is impossible.  The
BPE token table assigns values by frequency, not alphabetical order
(e.g. token 0x05 might expand to "zebra" while 0x42 expands to "apple"),
so comparing raw token values scrambles lexicographical order.

However, full string expansion is equally wasteful: roughly 16 of the
17 binary search steps fail within the first two characters.

Introduce kallsyms_strcmp_symbol() to compare ASCII queries against
compressed tokens on the fly.  It walks kallsyms_token_index and
kallsyms_token_table incrementally, matching characters directly and
bailing out on the first character mismatch without expanding subsequent
tokens.

This optimization:

0. Avoids decompressing non-matching tokens, short-circuiting ~94% of
   binary search character expansions without adding any tables in
   .rodata.

1. Drops the 512-byte namebuf buffer from the kernel stack in
   kallsyms_lookup_names().

2. Cuts unindexed lookup latency by ~530 ns (~14% faster) while leaving
   sequential address ordering and kallsyms_expand_symbol() streaming
   invariants intact for /proc/kallsyms and table walks.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v3:
- Reorder patch ahead of dynamic batch index in series, establishing an
  active proof of string matching savings on unindexed baseline
  (addresses David Laight review).
- Optimize kallsyms_strcmp_symbol(): drop skipped_first tracking and
  test len at loop bottom (addresses David Laight review).
- Guard first token with while (*tptr) to handle 1-byte type tokens.
- Introduce get_symbol_data() helper in this patch for reuse in later
  subsystems.

Changes in v2:
- Rebase onto mainline v7.3-rc4, removing external dependencies on
  Lorenzo Stoakes' kbuild series.
---
 kernel/kallsyms.c | 94 ++++++++++++++++++++++++++++++++++---------------------
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
2.55.0

