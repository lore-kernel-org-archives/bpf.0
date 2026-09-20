Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FD93CF660
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 03:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789876749; cv=none; b=Dg4RS3H0MuYmpOGmOSmjHODw7Psa+73BLRclilrga4epntq+CGXGYpyn7x+BDlNjVpJA+KqTABzNwMZF+Otrs6tP6MpUhDIi1+ycw31iUVnGXrsSwsLfVGNJL07PdjATq1uN3v/S6yIa/PjvumGa1dcwFTu9AiG220b8fjmohI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789876749; c=relaxed/simple;
	bh=LumYwkTWkCz84GQ68MaksoLHoAbrKV8RYga/OmBRWWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXCWk4+SJN714tV6lE+3ztODddVpgOVDKzSNRegQSg1hq4j4R4XYV5WPMXmQ2AlY7h9Ka/uecZ/sFUa7Zd3A/1c66kgEQtTJpi2J6MEpvIkx9cwRk9OrrCTGQSiwneMUVa5goJ1RVXoaTmskDOJdHx3JqZG8aa0tB/FkcolsfYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wffv17K4; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wffv17K4"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-486e0f56cddso803327fac.3
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 20:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789876746; x=1790481546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SpHEPLob7KaPi++v6k6BcQW51q0CtS8LphwQtLRxilE=;
        b=Wffv17K4gh6S7m20WqfeJcK5j9YLtH873wwPf9IdQ8kxflCt/hQFfBXEM8Qa5DzNT9
         7DZy4njZFVsTh6ABwBhYmdxh4qLPKVGJFhEWvHHOicO/559z63STggAXcj3PE6xr3yu5
         2+SbmI8DJx+1AhQ1JFB0g5XbtwEz6OWoMgiuWHFcSm+cbb+ITmx9L2720gf2IN6y3G3/
         AVYELfmWZj8okdMbqEcFxv7bgnfx2je8Y+enzBvX1n7wfvukEFJkqbjEn2dZaxziissW
         CwtefMluFof67/40pOtcQWB/QhjTBapuTr78qHGX2iAPCQs9TJEN/E+7akSwZMxx3Ng/
         QNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789876746; x=1790481546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SpHEPLob7KaPi++v6k6BcQW51q0CtS8LphwQtLRxilE=;
        b=rkLuExR3G1UvWTZeCz7S36L4PF0jcbND2yYY204O6m8dPjvgQvHR55IoUKjWTDe3y8
         wftR/5hyTGk4ViF24rrQgd6tjqIQ0PkHfuyxDbjKI/aVCbfnQ3JcB2mjLtc2QdggFSil
         FAuQtGbthWSZ8hyiKgya059HHNvl5ziWjPL13oQV3PRti7gVGDpn9XcKIKQ0ttzKU3jC
         W7Ozq3FP5y1hdED/LlE4YkWk1Sum/nCthFsxARX3XLkXkeSU8KBEgUAwjU1ruKNWSYFK
         kZYiKB7gnmFGeowlokqjwnxX0Vo/YX169JTIdosJycGVTwsVaaAyEUprNoRksHyvg6Hv
         /EDw==
X-Forwarded-Encrypted: i=1; AKwUvBxazM4qbnhP5DQQp5ZwSG/jOb2Dyo8oPc05f/uO77dBl563icF9L2vAa++FFmHKu9MLqyI=@vger.kernel.org
X-Gm-Message-State: AFuF++mGzLugmgKAyNkMDooXxTNxu9It2ROsatOYOSXiO84bHOSIluCa
	10tKtiUOzZKO2+oDGF3jU4rwRMIwLu6C+XoY/vkCe8yoINEMZT8D40zB
X-Gm-Gg: AYBFou0cTg5KrrSjiqQh5EtPiy1+H1nODCe7fCDPPYpsKaGO327G9Wbb6bw7gMv44r7
	/py8VlAg6lsAN0NJqcn6op/fSRJ9NVphue38NTb67X0Ov6PDgp9A8E4/pa6voyKU5MkAktoKWb2
	qFk/LwqQHP7Td+V5aZ4n62EdZVr/77t27XXpQ50mdgFknOxbTxPgmnQVY7KqRr/WpGaDcHHJUWU
	xAOF4i0NQmpWiHmnP6D8nZzubGlEm/6wVNjbOhyNjkqM4g+5uHc5Pfa/YXNU39QAh2oKwDlXQFQ
	+R+aqVR1T8mmTiql7wQMkg+me+qENUfjAnkphIejCD+50ZVpkWgtbIqSaZBwQZ3Q+NaYj4nnJ9l
	5fkfRAsN5OGCsOoPhIu3XzpLYz6l94BAQuMgRUyJSZTd0HkGoj+tvuzEp0zLKLW03DXniMlgjaU
	KYx+9zkETyipyD+LcUF2HmuQl/97FbzfSbw9+qg/8kdvZ1+H/DpqDZh2Vkw/7R+YZtjnlGrgf5o
	qfliAVDpucJRIT/c5EszWNzZOfdHrX6kx3jWW1sbnd2tOiaDU2tFGi5OMuNYKYpNshnX2yUZiZX
	X1u20EWAycKZA4mehWsx
X-Received: by 2002:a05:6820:4b18:b0:6cd:3fdc:a935 with SMTP id 006d021491bc7-6cd3fecc3c1mr3196386eaf.82.1789876746486;
        Sat, 19 Sep 2026 20:59:06 -0700 (PDT)
Received: from [192.168.0.197] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4881f4d7861sm4146915fac.1.2026.09.19.20.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 20:59:05 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 19 Sep 2026 21:58:57 -0600
Subject: [PATCH 3/3] kallsyms: Match compressed tokens on the fly during
 binary search
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-ksyms-tune-v1-3-d85c97da1a32@gmail.com>
References: <20260919-ksyms-tune-v1-0-d85c97da1a32@gmail.com>
In-Reply-To: <20260919-ksyms-tune-v1-0-d85c97da1a32@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789876740; l=6186;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=LumYwkTWkCz84GQ68MaksoLHoAbrKV8RYga/OmBRWWs=;
 b=oS3hBEoeOTkeYDkz1jG8Ny3J/8fwD+3PwYvYnH6Ac/Mpbw5Lm1Ne4swRspc9e85QONQzuKzMD
 VLchWBUNSXtDQZUCborGNhn92k+CKydkQQ3Pfws1HSTfIh43VLgd4Ds
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

2. Leaves sequential address ordering and kallsyms_expand_symbol()
   streaming invariants intact for /proc/kallsyms and table walks.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 kernel/kallsyms.c | 97 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 36 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 21adc5b74ec5..3be2b4e74057 100644
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
@@ -91,7 +90,7 @@ static unsigned int kallsyms_expand_symbol(unsigned int off,
 	if (maxlen)
 		*result = '\0';
 
-	/* Return to offset to the next symbol. */
+	/* Return offset to the next symbol. */
 	return off;
 }
 
@@ -101,16 +100,46 @@ static unsigned int kallsyms_expand_symbol(unsigned int off,
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
 }
 
+/*
+ * Compare an uncompressed ASCII string against a compressed symbol table entry.
+ * Returns negative if name < sym, positive if name > sym, 0 if equal.
+ * Exits immediately on the first mismatched character without decompressing
+ * the rest of the symbol name.
+ */
+static int kallsyms_strcmp_symbol(unsigned int off, const char *name)
+{
+	int skipped_first = 0;
+	const char *tptr;
+	unsigned int len;
+	const u8 *data = get_symbol_data(off, &len);
+
+	while (len) {
+		tptr = &kallsyms_token_table[kallsyms_token_index[*data]];
+		data++;
+		len--;
+
+		while (*tptr) {
+			if (skipped_first) {
+				int diff = (unsigned char)*name - (unsigned char)*tptr;
+
+				if (diff != 0)
+					return diff;
+				name++;
+			} else {
+				skipped_first = 1;
+			}
+			tptr++;
+		}
+	}
+
+	return (unsigned char)*name - '\0';
+}
 
 /*
  * Find the offset on the compressed table given an index in the
@@ -145,7 +174,6 @@ static int kallsyms_lookup_names(const char *name,
 	int ret;
 	int low, mid, high;
 	unsigned int seq, off;
-	char namebuf[KSYM_NAME_LEN];
 
 	low = 0;
 	high = kallsyms_num_syms - 1;
@@ -154,8 +182,7 @@ static int kallsyms_lookup_names(const char *name,
 		mid = low + (high - low) / 2;
 		seq = get_symbol_seq(mid);
 		off = get_symbol_offset(seq);
-		kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
-		ret = strcmp(name, namebuf);
+		ret = kallsyms_strcmp_symbol(off, name);
 		if (ret > 0)
 			low = mid + 1;
 		else if (ret < 0)
@@ -171,8 +198,7 @@ static int kallsyms_lookup_names(const char *name,
 	while (low) {
 		seq = get_symbol_seq(low - 1);
 		off = get_symbol_offset(seq);
-		kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
-		if (strcmp(name, namebuf))
+		if (kallsyms_strcmp_symbol(off, name) != 0)
 			break;
 		low--;
 	}
@@ -183,8 +209,7 @@ static int kallsyms_lookup_names(const char *name,
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

