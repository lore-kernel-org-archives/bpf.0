Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398390;
	b=F/sO3qk9z58tdr8uouRQdVSbKrnyFfnwnqSDaaxa2wlfRDphXX8BvEXN016+i/Oj/IOR
	 DDHWOPeC0EjeGEuwPlc6sd4RucSB1JvUqHvgFogHJNXJqu/LsU7e7CkacRAWiKUkomdoj
	 zUNzIObm1fvLsDtF37aAk36zAoP3cvIdRuU+p+AOnnbsqKFw69hp7JB5PIqY1mDQL48l/
	 0/fo0bb0pE7poAHrfoEIah2HOC37TPxoQDM4PZ0ZAdbcSEObdpQa59FHIoi+GkoxvObup
	 c8F71onHdxhvmhnNjL+EwhH6ZKB+DP+p4x+929g15ZBrlwe3OuoqWBcvlMJB4+0lVfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398390;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=L04WzWSsKKGN0pGNKi+XVbOaj5lMu/AG1QPutKe1oaM=;
	b=kS6n6py6WDl4scXFUU6Q7lO5V9TlOB4nYWFnW8j30d/lPSuWGtRp7nOOCK0QglI6BeME
	 G4PmdEUrFPJ+xma3AammX4y5d+0yI0/SdMupGCHzd6mVfG18WaH25qAvw9rzbRi6gsVwK
	 6iimkZZR7AhEWl2KIWBThOflK5g+jf/ByJouiy0mV92llP4zbmTGYd2SFd+ILbakpR/UA
	 XT8qIGaA0O7rXJqc3cTqUvIvAXt8fvOskLCUz7lEbwe/rk+5igPeE22S237fr12Ky0iSB
	 iB4LHL+WBGrYnTAXW65gOxJ8MKM9HrlHPWbVETWGP4eCp8cXuJJz9StQVKr2rgSLvbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=IKJa5hBF;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420F0606A33B;
	Wed, 11 Nov 2026 11:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 420F0606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=IKJa5hBF
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xR6zM-001SvA-Ej; Wed, 11 Nov 2026 12:59:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=L04WzWSsKKGN0pGNKi+XVbOaj5lMu/AG1QPutKe1oaM=; b=IKJa5hBFwGTd05abOTcBYiEoqQ
	qHCcL0gDd+7fQmMD65ARBWWLbeA2DoaApxruTLN30wEG3I6JqdEUXqJM3cjG8h7/nsfn/Msd2u9xV
	I9i4WF21M919L9rtddfHWlfAcR7MFZCkkx+VeIyBWb15tYX0YJYWQG1H9I4mduCrlZwhuMOLUi5Z9
	M/JUx1H2ypQ2ASWrM+TJ77wucdwO5ZmcEdcWfI8os1jFyLszcgzBV7I1k8yyU1PBPhOGUXxVN8Xuk
	8q8LJYIdED0mFOGdJWtKMJUIIbIdRJ5oosfiaNmYxRcfqTUMnv/XtAzRJhQ+9oL0sw0LeNHe96ufj
	BnXGzZTg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xR6zG-0000Un-U6; Wed, 11 Nov 2026 12:59:35 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xR6z9-001mRM-5U;
	Wed, 11 Nov 2026 12:59:27 +0100
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
Subject: [PATCH v3 next 08/13] kallsyms: Optimise symbol name search
Date: Wed, 11 Nov 2026 11:59:06 +0000
Message-Id: <20261111115911.1142000-9-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261111115911.1142000-1-david.laight.linux@gmail.com>
References: <20261111115911.1142000-1-david.laight.linux@gmail.com>
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

Change the alphabetically ordered lookup table (kallsyms_seqs_of_names)
to one that indexes the table of compressed names rather than the
array of symbol values.
This removes all the linear scans during the binary search for the symbol
name.
Once the name has been found a second binary search of the 'markers' array
followed by a linear scan for the symbols address gives the symbol value.

This linear scan is done once for each address returned, whereas the old
code did the scan for each of the ~17 comparisons in the binary search
(and the binary search was done twice for a symbol that appears once).

For normal kernels the index table stays at 24 bits per symbol (now host
ordered), but a 32 bit table is used if necessary (probably only for
allyesconfig builds - which needs 26 bits on x86-64).

Use the low bit of the index table value to indicate that the symbol has
the same name as the previous one.
Use this to avoid the second lookup to find if the name is unique, speed
up the search for the first symbol with a given name, and simplify
kallsyms_on_each_match_symbol().

Speeds up lookup by name by a factor of about 12, and makes a massive
difference to the time taken to lookup symbols that occur 100s or
1000s (or maybe 10000s) of times.

The slowest 'lookup by name' changes being a symbol that is duplicated a lot
to one that is very long.

Build for BE kernels correctly flips the byte order in the index table.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

v3:
- Use a discrimant union for the name table instead of weak symbols.
  Undefined weak symbols can't be guaranteed to be zero and a build
  mismatch left both undefined.
- Patch the kallsyms_off_size_24 static key from an initcall,
  the first name lookup might not be allowed to sleep.
  Leave a conditional in the 32bit offset case, it is unlikely
  to be needed for a real kernel.
- Merge in the following patch that optimised the scan for duplicates.

 kernel/kallsyms.c          | 162 ++++++++++++++++++++++++-------------
 kernel/kallsyms_internal.h |   7 +-
 scripts/kallsyms.c         |  49 +++++++----
 3 files changed, 148 insertions(+), 70 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index d18d78e626db..fd42a1a8ed3e 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -177,6 +177,36 @@ static unsigned int get_symbol_offset(unsigned long pos)
 	return name - kallsyms_names;
 }
 
+/*
+ * Find the value of a symbol given the offset in the compressed stream.
+ */
+static unsigned long get_name_address(unsigned int name_offset)
+{
+	unsigned int low, pos, high;
+
+	low = 0;
+	high = ((kallsyms_num_syms - 1) >> 8) + 1;
+
+	while (high - low > 1) {
+		pos = low + (high - low) / 2;
+		if (name_offset >= kallsyms_markers[pos])
+			low = pos;
+		else
+			high = pos;
+	}
+
+	pos = kallsyms_markers[low];
+	for (low <<= 8; pos < name_offset; low++) {
+		unsigned int len = kallsyms_names[pos];
+		if (len & 0x80)
+			len += (kallsyms_names[pos + 1] << 7) - 0x7f;
+		pos += 1 + len;
+	}
+
+	return kallsyms_sym_address(low);
+}
+
+
 unsigned long kallsyms_sym_address(int idx)
 {
 	/* non-relocatable 32-bit kernels just embed the value directly */
@@ -185,66 +215,87 @@ unsigned long kallsyms_sym_address(int idx)
 	return (unsigned long)offset_to_ptr(kallsyms_offsets + idx);
 }
 
-static unsigned int get_symbol_seq(int index)
-{
-	unsigned int i, seq = 0;
+static DEFINE_STATIC_KEY_FALSE(kallsyms_off_size_24);
 
-	for (i = 0; i < 3; i++)
-		seq = (seq << 8) | kallsyms_seqs_of_names[3 * index + i];
+/*
+ * Get the offset into the compressed list of names for the n'th
+ * symbol in the 'sorted by name' list.
+ * Returns 'offset << 1 | is_duplicate_name'.
+ * To save memory (the array can have 200k+ entries) the values are usually
+ * 24 bit (host ordered) but will be 32 bit if necessary.
+ */
+static inline unsigned int get_symbol_name_offset(unsigned long index)
+{
+	if (static_branch_likely(&kallsyms_off_size_24) ||
+	    unlikely(kallsyms_offs_of_names.size == 24)) {
+		u8 *off = kallsyms_offs_of_names.offs + index * 3;
+#if !defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
+		return ((struct {unsigned int v:24 __packed; } __packed *)off)->v;
+#else
+#if defined(__BIG_ENDIAN)
+		return (*(u32 *)(off - 1)) & 0xffffff;
+#else
+		return (*(u32 *)(off - 1)) >> 8;
+#endif
+#endif
+	}
 
-	return seq;
+	return ((u32 *)&kallsyms_offs_of_names.offs)[index];
 }
 
-static int kallsyms_lookup_names(const char *name,
-				 unsigned int *start,
-				 unsigned int *end)
+static int kallsyms_set_kallsyms_off_size(void)
 {
+	if (kallsyms_offs_of_names.size == 24)
+		static_branch_enable(&kallsyms_off_size_24);
+
+	return 0;
+}
+early_initcall(kallsyms_set_kallsyms_off_size);
+
+static int kallsyms_lookup_names(const char *name, unsigned int *start)
+{
+	unsigned int mid, off;
+	int low, high;
 	int ret;
-	int low, mid, high;
-	unsigned int seq, off;
 
 	low = 0;
 	high = kallsyms_num_syms - 1;
 
-	while (low <= high) {
+	for (;;) {
+		if (low > high)
+			return -1;
 		mid = low + (high - low) / 2;
-		seq = get_symbol_seq(mid);
-		off = get_symbol_offset(seq);
-		ret = kallsyms_strcmp_symbol(off, name);
-		if (ret > 0)
+		off = get_symbol_name_offset(mid);
+		ret = kallsyms_strcmp_symbol(off >> 1, name);
+		if (ret > 0) {
 			low = mid + 1;
-		else if (ret < 0)
-			high = mid - 1;
-		else
-			break;
-	}
-
-	if (low > high)
-		return -ESRCH;
-
-	low = mid;
-	while (low) {
-		seq = get_symbol_seq(low - 1);
-		off = get_symbol_offset(seq);
-		if (kallsyms_strcmp_symbol(off, name) != 0)
-			break;
-		low--;
-	}
-	*start = low;
-
-	if (end) {
-		high = mid;
-		while (high < kallsyms_num_syms - 1) {
-			seq = get_symbol_seq(high + 1);
-			off = get_symbol_offset(seq);
-			if (kallsyms_strcmp_symbol(off, name) != 0)
+			continue;
+		}
+		if (!ret) {
+			/*
+			 * Found a match, but need the first one.
+			 * Most symbols (and all exported/global ones) only occur
+			 * once, most of the others only occur a small number of
+			 * times so it is worth doing a linear scan that avoids the
+			 * kallsyms_strcmp_symbol() call.
+			 * However some symbols occur a large number of times
+			 * (_sub_D_65535_0 is repeated 24610 times in an x86-64
+			 * allyesconfig, __func__.0 442 in a more normal kernel).
+			 * Avoid a long linear scan by returning to the binary
+			 * search if a short linear search is fruitless.
+			 */
+			unsigned int scan = 16;
+			while ((off & 1) && scan--)
+				off = get_symbol_name_offset(--mid);
+			if (!(off & 1))
 				break;
-			high++;
 		}
-		*end = high;
+		high = mid - 1;
 	}
 
-	return 0;
+	*start = mid;
+
+	return off;
 }
 
 /* Lookup the address for this symbol. Returns 0 if not found. */
@@ -257,9 +308,9 @@ unsigned long kallsyms_lookup_name(const char *name)
 	if (!*name)
 		return 0;
 
-	ret = kallsyms_lookup_names(name, &i, NULL);
-	if (!ret)
-		return kallsyms_sym_address(get_symbol_seq(i));
+	ret = kallsyms_lookup_names(name, &i);
+	if (ret >= 0)
+		return get_name_address(ret >> 1);
 
 	return module_kallsyms_lookup_name(name);
 }
@@ -289,17 +340,20 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, unsigned long),
 int kallsyms_on_each_match_symbol(int (*fn)(void *, unsigned long),
 				  const char *name, void *data)
 {
-	int ret;
-	unsigned int i, start, end;
+	int name_offset, ret;
+	unsigned int sym_number;
 
-	ret = kallsyms_lookup_names(name, &start, &end);
-	if (ret)
+	name_offset = kallsyms_lookup_names(name, &sym_number);
+	if (name_offset < 0)
 		return 0;
 
-	for (i = start; !ret && i <= end; i++) {
-		ret = fn(data, kallsyms_sym_address(get_symbol_seq(i)));
+	do {
+		ret = fn(data, get_name_address(name_offset >> 1));
+		if (ret)
+			break;
 		cond_resched();
-	}
+		name_offset = get_symbol_name_offset(++sym_number);
+	} while (name_offset & 1);
 
 	return ret;
 }
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 81a867dbe57d..11fb0de92ede 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -13,6 +13,11 @@ extern const char kallsyms_token_table[];
 extern const u16 kallsyms_token_index[];
 
 extern const unsigned int kallsyms_markers[];
-extern const u8 kallsyms_seqs_of_names[];
+
+/* Although constant, size is volatile for better code generation. */
+extern struct {
+	volatile unsigned int size;	/* 24 or 32 */
+	unsigned char offs[];		/* int:24[] or int:32[] */
+} kallsyms_offs_of_names;
 
 #endif // LINUX_KALLSYMS_INTERNAL_H_
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 74db751600b4..930ec27a53c0 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -403,7 +403,7 @@ static void sort_symbols_by_name(void)
 
 static void write_src(void)
 {
-	unsigned int i, k, len, off, seq;
+	unsigned int i, k, len, off, off_size, table_size;
 	unsigned int best_idx[256];
 	unsigned int *markers, markers_cnt;
 	unsigned long bin_offset = 0;
@@ -453,7 +453,7 @@ static void write_src(void)
 		unsigned char len[2];
 
 		se = table[i];
-		se->seq = i;
+		se->seq = off;
 
 		/* The length must be less than that of the original symbol. */
 		if (!se->len || se->len > KSYM_NAME_LEN)
@@ -485,7 +485,7 @@ static void write_src(void)
 			if ((i & 0xFF) == 0)
 				markers[i >> 8] = off;
 
-			printf("\t.byte\t%u", len[0]);
+			printf("\t/* n:%u */\t.byte\t%u", off, len[0]);
 			if (len_len == 2)
 				printf(",%u", len[1]);
 
@@ -500,6 +500,7 @@ static void write_src(void)
 		memcpy(se->sym, buf, se_len + 1);
 	}
 	write_incbin(&bin_offset, off);
+	table_size = off;
 	printf(".size kallsyms_names, . - kallsyms_names\n");
 	printf("\n");
 
@@ -560,7 +561,7 @@ static void write_src(void)
 			       out_bin_file ? '\n' : '\t');
 		}
 		if (!out_bin_file)
-			printf("/* %c %s */\n", table[i]->sym[0], table[i]->sym + 1);
+			printf("/* n:%u %c %s */\n", table[i]->seq, table[i]->sym[0], table[i]->sym + 1);
 	}
 	printf(".size kallsyms_offsets, . - kallsyms_offsets\n");
 	printf("\n");
@@ -570,23 +571,41 @@ static void write_src(void)
 	sort_symbols_by_name();
 	stamp("sort by name");
 
-	output_label("kallsyms_seqs_of_names");
-	write_incbin_header("seq_of_names", &bin_offset);
+	off_size = table_size < (1u << 23) ? 24 : 32;
+	output_label("kallsyms_offs_of_names");
+	printf("\t.long\t%u\n", off_size);
+	write_incbin_header("offs_of_names", &bin_offset);
 	for (i = 0; i < table_cnt; i++) {
 		se = table[i];
-		seq = se->seq;
+		off = se->seq << 1;
+		if (i && se->len == table[i - 1]->len &&
+		    !memcmp(se->sym + 1, table[i - 1]->sym + 1, se->len - 1))
+			/* Mark that this is a duplicate of the previous symbol */
+			off |= 1;
 		if (out_bin_file) {
-			unsigned int seq_be = htobe32(seq);
-			fwrite((char *)&seq_be + 1, 1, 3, out_bin_file);
+			unsigned int off_te = big_endian ? htobe32(off) >> (32 - off_size): htole32(off);
+			fwrite(&off_te, 1, off_size / 8 , out_bin_file);
 		} else {
-			/* The three spaces before the tab line up the comments */
-			printf("\t.byte\t%u,%u,%u   \t/* %8d %c %s */\n",
-				seq >> 16, (seq >> 8) & 0xff, seq & 0xff,
-				seq, se->sym[0], se->sym + 1);
+			if (off_size == 32) {
+				printf("\t.long\t%#4x", off);
+			} else {
+				if (big_endian)
+					off = __builtin_bswap32(off) >> 8;
+				/* The trailing three spaces line up the comments */
+				printf("\t.byte\t%u,%u,%u   ",
+					off & 0xff, (off >> 8) & 0xff, off >> 16);
+			}
+			printf("\t/* n:%-8d %c %s */\n",
+				se->seq, se->sym[0], se->sym + 1);
 		}
 	}
-	write_incbin(&bin_offset, table_cnt * 3);
-	printf(".size kallsyms_seqs_of_names, . - kallsyms_seqs_of_names\n");
+	write_incbin(&bin_offset, table_cnt * (off_size / 8));
+	/* Add a terminator without the 'duplicate' flag. */
+	if (off_size == 24)
+		printf("\t.byte\t0,0,0\n");
+	else
+		printf("\t.long\t0\n");
+	printf(".size kallsyms_offs_of_names, . - kallsyms_offs_of_names\n");
 
 	stamp("write name index");
 
-- 
2.39.5

