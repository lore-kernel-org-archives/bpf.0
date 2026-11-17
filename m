Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911674;
	b=g2aEDXgt3LfUtAzHvJpbO+R+F8tH3vGTqc2URKmvZ30D4reM9Y6uKK8vPYrpjT02twHt
	 ZjNizelk0sfqPKom+fjoax0OkRao9MwzjvDyUDST3aLgXJKw2NAoV1HIf3ZvU6paBm5op
	 qkvwIDkp9zKsxQfCw7HrXY7hHHK5iZAHEGlEc9VGHPJq8PxD2pm4UW2S3Q6Eckjptv4/j
	 CSH47C5WNbzymVeqPgoJ/RTdiUAACSfieEbNtKVWUFyF1nMf0L5TARKjQ5WV2B+jrWNNz
	 gl4YvVHh8shOpESuzoy7D8Sbc9h8/0AMobiJqSzXQcCv4NipzM4fIfcghG638hrrlOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911674;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B+0DLNmACn3+SrBn1yC8gA1y8lKikEJXoGSZdgbUn7s=;
	b=2Z7Y95ElNdsRmQBfTn/yvTlC7tatICsSUKrHGDMk+dG9q3XVLGQxYIu7+DQgO38mobw9
	 ml7VjJZLSydpq1WN75hfMob3w1fg6TgSNpgI1VIQ/SLPXBMRW95P5nSCPpoa7rW2bRnSs
	 cgP6Mnsu4MQAmdbB7XbyDzqcs7YveHpAHbwWNrmAz+gm/9XgEHm1FzMPM41znMLvK15Vj
	 uh6i1b6YBiT4UBeFWI6r561LrfTFudLtuolSENdqHvHcwnmTGt8O7Jo/QMx0XKCTcW+Vm
	 s84frH3CMcQDnmd9vjhy7o0dFlA3tL+0xbG0QMtaI4a3aXmZhUKi9CT7FO31rGF32Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=nW5unEf9;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510E4606A89D;
	Tue, 17 Nov 2026 10:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 510E4606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=nW5unEf9
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW6-002LjD-H6; Tue, 17 Nov 2026 11:34:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=B+0DLNmACn3+SrBn1yC8gA1y8lKikEJXoGSZdgbUn7s=; b=nW5unEf9uCrv+3AuGpRYh/44Iw
	onChHybEUv9KEuYaG5wS09b2p7XHaKud3MSaBDNlYgBvusDT5KRkCQJApw6DSqVrycspSgaFq7ME9
	g0+8qyXb6XEal9HD/fU6183mOv3HAn/ydPPdjMxGmchk4B/SyOnX/BH6lNM4G4q+rbwuP/6QSNuMr
	HvSwlgkDXl+3g7wPoP09Kk1jFEJPuWWDKlBc3gNysILyF5V3930p3my2CSVKgVKI/0GUDQ9fhd/AC
	nEnnrtqc7nbtV1amhDChw//4hB/uZG7MwEZhL29l2IAWjSabLyb1ur0DRpqkluPfqpN4qprB+GA3i
	hwQq1hhQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW0-0002Eo-Qo; Tue, 17 Nov 2026 11:34:17 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xTGVn-005qHU-V2;
	Tue, 17 Nov 2026 11:34:04 +0100
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
Subject: [PATCH v4 next 07/13] kallsyms: Match compressed tokens on the fly during binary search
Date: Tue, 17 Nov 2026 10:33:46 +0000
Message-Id: <20261117103352.1244657-8-david.laight.linux@gmail.com>
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
Reviewed-by: Samuel Wu <wusamuel@google.com>
---

Unchanged from Jim's patch.
I think this is the latest version of it, but any later changes
shouldn't cause problems.

v4:
- Delete a duplicated paragraph from the commit message.
- Added Samuel Wu's reviewed-by.

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

