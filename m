Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD063CF02E;
	Sun, 18 Oct 2026 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338800; cv=none; b=h5hkzjhK2osYwdIBa2MdZqZ2CHdQhgnL9evx/STT7PlUe/9nbWJuP4fJjzexh8ydMesz5SZJmuzfVkBzbKwDTz+CJkOEW+y7xDL40fIcY2myTnSB1ZL0RV0YIiD4KMAYQVUtk5cibE3N4gdmw03eDvJk5cDuW6jXZKZJkQxmPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338800; c=relaxed/simple;
	bh=vdYqoZ03LJO7F1XgrVhARurZZWKCeg2jISPyZuWRJ4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eLdtSO9RFPOtC8G+gTcPYNTu4qGwzThhQPCtO2CKaFFFaQOS4U09wJ/SXLsErk3HNY23CSZuJIXz1aoK4+6TXmRKewJ0WSSaWxSzz+tD/b3god8j/WFdmhxs/tPgWIMdd+t/F+QrxTUG1Na7XRiBLi0luEqzODMSxmPmkudqYvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=phhRCHBW; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="phhRCHBW"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC5-001KBn-H3; Sun, 18 Oct 2026 17:53:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=qIYHQGFjd83dSqjHRU58hsY4BNVUz+F0M4EHshm/Ozo=; b=phhRCHBWiVkl8z3lF3lDRVhBVM
	mv9xjhlgdHlM7fZh13T0jfSRHvLNaAdcAgt18Fk4OAaOFncYHehLpu3/9GGI4PTV4xf9X0ZjrHQZc
	DA74OnapajZnw9F2APgR04A3Mk8DXyO34+0dQVudCvXy1Q8Po5L6MluxLzKQAoJsHWMTFCIFuO7Aw
	SEZKYxSPnIZkR5efzT213oRnObe5uvifrFCW1sGjRSh1yZFPMwmr3CTCaYbKi9NcN6u8a4sXXzoqS
	49bNj4T/5hupTyeiqC++XmgrftAkAKweqRybTxX+fh9xayROj1jjI4scUe/Dovk4yKF58uV1eZMPU
	nqBuvW3Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC0-0001pq-8m; Sun, 18 Oct 2026 17:53:00 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xITBk-004q3U-UU;
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
Subject: [PATCH 14/15] kallsyms: scripts/kallsyms: Reduce the output file size
Date: Sun, 18 Oct 2026 16:52:05 +0100
Message-Id: <20261018155206.132411-15-david.laight.linux@gmail.com>
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

The output file isn't normally looked at by anyone; so doesn't need
redundant information or formatting.
Reduce the size somewhat:
- Use "%u" instead of " 0x%02x" for byte values.
  Remove some other spaces.
- Only include the symbol name once.
  Put the offset into the compressed symbol names in all three per-symbol
  tables so that the lines can be cross-referenced if necessary.
- Output the kallsyms_token_index table and kallsyms_markers with
  multiple values per line.
- Add the missing .size for kallsyms_token_index.
- Output the token table first.
There is still enough information to help debug the code.

All the printfs are slow - but find_token() dominates everything.

Reduces the file size by about 25%.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 scripts/kallsyms.c | 93 +++++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 38 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 189fb50ec8c5..8576fe6ad90b 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -350,6 +350,30 @@ static void write_src(void)
 	struct sym_entry *se;
 
 	printf("\t.section .rodata, \"a\"\n");
+	printf("\n");
+
+	output_label("kallsyms_token_table");
+	off = 0;
+	for (i = 0; i < 256; i++) {
+		best_idx[i] = off;
+		off += token_table[i].len + 1;
+		printf("\t.asciz\t\"%s\"\t/* %u: %u */\n",
+		       token_table[i].str, i, token_table[i].refs);
+	}
+	printf(".size kallsyms_token_table, . - kallsyms_token_table\n");
+	printf("\n");
+
+	output_label("kallsyms_token_index");
+	for (i = 0; i < 256; i++) {
+		if (i & 15)
+			printf(",");
+		else
+			printf("\n\t.short\t" + !i);
+		printf("%u", best_idx[i]);
+	}
+	printf("\n");
+	printf(".size kallsyms_token_index, . - kallsyms_token_index\n");
+	printf("\n");
 
 	output_value("kallsyms_num_syms", symbol_cnt);
 
@@ -359,35 +383,37 @@ static void write_src(void)
 		se = symbol[i];
 		se->seq = off;
 
-		/* There cannot be any symbol of length zero. */
-		if (se->len == 0)
-			errx(1, "unexpected zero symbol length");
+		/* The length must be less than that of the original symbol. */
+		if (!se->len || se->len > KSYM_NAME_LEN)
+			errx(1, "symbol %d has corrupt compressed length %d\n",
+			     i, se->len);
 
-		/* Only lengths that fit in up-to-two-byte ULEB128 are supported. */
-		if (se->len > 0x3FFF)
-			errx(1, "unexpected huge symbol length");
+		/*
+		 * Output the number that identifies the symbol at the start
+		 * of the line so that they line up nicely.
+		 */
+		printf("\t/* n:%u */\t.byte\t", off);
 
 		/* Encode length with ULEB128. */
 		if (se->len <= 0x7F) {
 			/* Most symbols use a single byte for the length. */
-			printf("\t.byte 0x%02x", se->len);
+			printf("%u", se->len);
 			off += se->len + 1;
 		} else {
 			/* "Big" symbols use two bytes. */
-			printf("\t.byte 0x%02x, 0x%02x",
-				(se->len & 0x7F) | 0x80, (se->len >> 7) & 0x7F);
+			printf("%u,%u", (se->len & 0x7F) | 0x80, (se->len >> 7) & 0x7F);
 			off += se->len + 2;
 		}
 		for (k = 0; k < se->len; k++)
-			printf(", 0x%02x", se->sym[k]);
+			printf(",%u", se->sym[k]);
+		printf("\n");
 
 		/*
 		 * Now that we wrote out the compressed symbol name, restore the
-		 * original name and print it in the comment.
+		 * original name.
 		 */
 		se->len = expand_symbol(se->sym, se->len, buf);
 		memcpy(se->sym, buf, se->len + 1);
-		printf("\t/* %s */\n", se->sym);
 	}
 	table_size = off;
 	printf(".size kallsyms_names, . - kallsyms_names\n");
@@ -395,25 +421,15 @@ static void write_src(void)
 
 	output_value("kallsyms_marker_shift", marker_shift);
 	output_label("kallsyms_markers");
-	for (i = 0; i < symbol_cnt; i += 1u << marker_shift)
-		printf("\t.long\t%u\n", symbol[i]->seq);
-	printf(".size kallsyms_markers, . - kallsyms_markers\n");
-	printf("\n");
-
-	output_label("kallsyms_token_table");
-	off = 0;
-	for (i = 0; i < 256; i++) {
-		best_idx[i] = off;
-		off += token_table[i].len + 1;
-		printf("\t.asciz\t\"%s\"\t/* %u: %u */\n",
-		       token_table[i].str, i, token_table[i].refs);
+	for (i = 0, k = 0; i < symbol_cnt; i += 1u << marker_shift, k++) {
+		if (k & 7)
+			printf(",");
+		else
+			printf("\n\t.long\t" + !k);
+		printf("%u", symbol[i]->seq);
 	}
-	printf(".size kallsyms_token_table, . - kallsyms_token_table\n");
 	printf("\n");
-
-	output_label("kallsyms_token_index");
-	for (i = 0; i < 256; i++)
-		printf("\t.short\t%d\n", best_idx[i]);
+	printf(".size kallsyms_markers, . - kallsyms_markers\n");
 	printf("\n");
 
 	output_label("kallsyms_offsets");
@@ -424,13 +440,13 @@ static void write_src(void)
 			long long offset = se->addr - _text;
 
 			if (offset < INT_MIN || offset > INT_MAX)
-				errx(1, "relative symbol value %#llx out of range",
-				     se->addr);
-			printf("\t.long\t_text - . + (%d)\t/* %s */\n",
-			       (int)offset, se->sym);
+				errx(1, "relative symbol %s value %#llx out of range\n",
+					se->sym + 1, se->addr);
+			printf("\t.long\t_text-.+%d\t/* n:%u %c %s */\n",
+			       (int)offset, se->seq, se->sym[0], se->sym + 1);
 		} else {
-			printf("\t.long\t%#x\t/* %s */\n",
-			       (unsigned int)se->addr, se->sym);
+			printf("\t.long\t%#x\t/* n:%u %c %s */\n",
+			       (unsigned int)se->addr, se->seq, se->sym[0], se->sym + 1);
 		}
 	}
 	printf(".size kallsyms_offsets, . - kallsyms_offsets\n");
@@ -451,10 +467,11 @@ static void write_src(void)
 #ifdef CONFIG_CPU_BIG_ENDIAN
 			off = __builtin_bswap32(off) >> 8;
 #endif
-			printf("\t.byte\t0x%02x, 0x%02x, 0x%02x\t/* %s */\n",
-				off & 0xff, (off >> 8) & 0xff, off >> 16, se->sym);
+			/* The three spaces before the tab line up the comments */
+			printf("\t.byte\t%u,%u,%u   \t/* n:%u */\n",
+				off & 0xff, (off >> 8) & 0xff, off >> 16, se->seq);
 		} else {
-			printf("\t.long\t%#04x\t/* %s */\n", off, se->sym);
+			printf("\t.long\t%#04x\t/* n:%u */\n", off, se->seq);
 		}
 	}
 	/* Terminator without the 'duplicate' flag. */
-- 
2.39.5

