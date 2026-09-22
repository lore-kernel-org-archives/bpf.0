Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBB14CDDFC
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061579; cv=none; b=lH8KdfcXDLve8nvQZ/Qfw9zfZCBZAK6ohNiLNDAuv6fCqxFhX4RtdB0tih7xYjnJWr8uWeKQMmg4Rfjw7MdnWOZJSNvnTrUU+jPQORISEtISGH8g/nG0XLUH30WNikGiDFLIYVNIqfm/5fj/HCWza8bg+0toXCFCp8Y/S6Tdw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061579; c=relaxed/simple;
	bh=9+xXUpbmhRcfphY9oEfLvGM9tZCICquHCMD3yOi8tIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WS2dmW+IztKy11jtSLCGAgiyZEu+tsIM4WEj92+YiD2ogI23GszKcu/3MnRBYXhWu62wqUXGuNL1luPhsn0kehmXOoJKAZwQeuT4NC4yZuyv1URnag2haMovt2LyFNVlpanljmZBlVlEp5MtIXy4evgjqfxsPgRVQwF4mDTXb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAtIGZnG; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAtIGZnG"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-811424a645bso1217337a34.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 00:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790061569; x=1790666369; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U9x3FI5E4GbuVg0Jfsu35zQ33gdkfajY2nImRMYOyJE=;
        b=BAtIGZnGN6Wph4it868B9tZapl14iGOUMvokwOo3HUHwT4wBh/0wqCDN8VV/kI6bPK
         DzfcvFygSfaz9YbbYH0pOWrIvPh8NfHafL5MezzROsNErXMN9xxYqjqF5POSS4aqWoMd
         5NX8vRqcQqBi//89WI/xuhMd72OWGnPT5/mZVGMvvMzoDcCCbBJzEWsA1POyk5Rk85pi
         YCMreAOmt3wb42nGGI5PXoDeuXhAHfzAKPk7zogVCxYaD35JqyB3nGzSM92ZwY3rskGi
         Y/RMUH64uQH1ip/sFLfgG/DtyWHXRuVJYWDmIXG5e6iAsg2niKOaqh5cPekv5j/jWrCq
         cihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061569; x=1790666369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U9x3FI5E4GbuVg0Jfsu35zQ33gdkfajY2nImRMYOyJE=;
        b=OJfF7aMgbxFHzFskZUv6ujG19hfapp/vay9EylSdQPv5ym3eqjWecGJlWdYBB7mBbW
         PmPk9aur9KMdcADRjTMsiaILP0pBJlY0xhSiHqe0UVrwdPLnqV1Psm8WHe8oS9j984LZ
         M+4d0oxqz7sD9BDbWmSUCVqVrkb3Ntl0sRP3ZGSgo4UaIJWxcUNdzJdYzmbL5cjaJKM5
         r0WojY5b67KUi+Dzc2hlM+D+BRy2Wkmyq1HaP7YiutRo6t6LrFSjkvWII/uFr87ZefEp
         xWL+WPranUZIZldO63BF4Wp+t1A8AsT079fpYpni4KA1GCKEzC4y5FfM1zQ2l9u3OJV2
         3Pfw==
X-Forwarded-Encrypted: i=1; AKwUvBxl2ovVr2StuYE5OPRhyAHInHauxDv2UyTVtvtLidyc0HkOeE7mLYsvYsi2JMtTeien6M8=@vger.kernel.org
X-Gm-Message-State: AFuF++nzM978+DY+AiS8SWa6VDCR8kq/Ba3gR2CsbjStFlhu/X36Lo3R
	06U8TdkmVVQaoeZ9FYCleGy8414PZLhL2zolGN6NbaSfLj9fbUEWvnjUs1n/wA==
X-Gm-Gg: AYBFou01gHH6oRnVnlSjO3V4LNYN6t36dhwicQuC9CWBoCyYCXenRvDuaV1WxIVgmnd
	PENsSs/nNnTPw8lQwvH78yowdaQoGKKWsJZE5zq3KdgWBn9mlOjTMjjvXlInU/0g1raMZgMWYAy
	SFfZ4w+BDcALI7+N3A8pN1UjB1EEEcaEe3PaOzKg9TyJt84FKCXWSiBlGJV+PdpB4TfUemgF2Es
	sYN5cOMeCg87TeyZuls9Sgp59obRDNJSMhi23YhGwz/GBXyTQJvBp4TqfxtiqXCt1YQC4RvP3fK
	u6nhX05wCsPX92xUpY5V3g8ZH1Fqtvwqy9fjQ94Lz5Z8nQ1sruYFeEru8IWpLcBA75967pkYA1Z
	n8ZjZ/aMi+6PIRyujgmnQsvEJ/RfzGTFFoyZzdPAp0tTqI97G6fCU6q9mKTimXydehQMIKqNAnI
	/rGW1EUdhMOXPDcOKI+a52Z3wQL0iJ9tzJv0h+4q8K9EhL/+EMv2rXw2Xv0C6BJ0i8n2n47cpOw
	L9f3PsuHkAMT8F8sutEl5630wL+5nwUzRhodenF+mUmGDgJa+YBMxoq6whiqDpZqwjMp8bEvDvd
	Y9oU28TFNSzLmhARkwE=
X-Received: by 2002:a05:6830:81ca:b0:80b:6c70:94b9 with SMTP id 46e09a7af769-80de27dc7cfmr15537606a34.19.1790061569165;
        Tue, 22 Sep 2026 00:19:29 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-814e598483esm1116801a34.5.2026.09.22.00.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:19:28 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 22 Sep 2026 01:19:21 -0600
Subject: [PATCH v2 3/3] kallsyms: Match compressed tokens on the fly during
 binary search
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ksyms-tune-v2-3-a333ee31eac7@gmail.com>
References: <20260922-ksyms-tune-v2-0-a333ee31eac7@gmail.com>
In-Reply-To: <20260922-ksyms-tune-v2-0-a333ee31eac7@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790061561; l=6187;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=9+xXUpbmhRcfphY9oEfLvGM9tZCICquHCMD3yOi8tIk=;
 b=zvOk3ZkgBsIKOndl6sO4Rqw248xKhWqXl2uhZas4Z5pbHJ3c+gNrOlSTb0rUNyBL4je9U9P4V
 sF+gitZnIB5CO1l8uvrKFK/4s0k6FN9UBAVmfs1iON3kx3I1T7uaQ5A
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
index 862a6b773ac5..4a04d63e4b7d 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -37,6 +37,21 @@
 
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
@@ -45,28 +60,12 @@
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
@@ -94,7 +93,7 @@ static unsigned int kallsyms_expand_symbol(unsigned int off,
 	if (maxlen)
 		*result = '\0';
 
-	/* Return to offset to the next symbol. */
+	/* Return offset to the next symbol. */
 	return off;
 }
 
@@ -104,16 +103,46 @@ static unsigned int kallsyms_expand_symbol(unsigned int off,
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
  * Find the offset on the compressed stream given an index in the
@@ -261,7 +290,6 @@ static int kallsyms_lookup_names(const char *name,
 	int ret;
 	int low, mid, high;
 	unsigned int seq, off;
-	char namebuf[KSYM_NAME_LEN];
 
 	low = 0;
 	high = kallsyms_num_syms - 1;
@@ -271,8 +299,7 @@ static int kallsyms_lookup_names(const char *name,
 		mid = low + (high - low) / 2;
 		seq = get_symbol_seq(mid);
 		off = get_symbol_offset(seq);
-		kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
-		ret = strcmp(name, namebuf);
+		ret = kallsyms_strcmp_symbol(off, name);
 		if (ret > 0)
 			low = mid + 1;
 		else if (ret < 0)
@@ -290,8 +317,7 @@ static int kallsyms_lookup_names(const char *name,
 	while (low) {
 		seq = get_symbol_seq(low - 1);
 		off = get_symbol_offset(seq);
-		kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
-		if (strcmp(name, namebuf))
+		if (kallsyms_strcmp_symbol(off, name) != 0)
 			break;
 		low--;
 	}
@@ -302,8 +328,7 @@ static int kallsyms_lookup_names(const char *name,
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

