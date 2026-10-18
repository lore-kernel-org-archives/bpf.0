Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8347F3BFE24
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338789; cv=none; b=k3roOixexJasL96ImwWA+L1oPpodYR/W5DUYenXkmt5k/t9BlaqLE3u0NcOuEuqHa7ewr2NKsCyc5Z5xCRBDQJo2O1/1sb8QbslcLoHJ7K4IgjjY4HGxjpj8TmXYmMEPSbri1NXwr8buPWIra1ux2Pqd4IfhV+1i1wSjPc1fook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338789; c=relaxed/simple;
	bh=RTnC8G5DBeVOS2M9AHnV4nvSMzhl2+GoG6xp2b+F0Pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GasizFTGUeFx9BBGJWwlWj2M3/XPSivKgR7q/ENDr02iSE7ccyQtRk31WoC518LiE3rP+4KR8F8+HKE9dak3eQ5AD4sSoIPTIPsqAMLcsgX9cTDCyDkx7RPnVJVXNeQYJrSl20jB0tqGgUR/7d05aktODgbvWx8KI7U6Bh3j3MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=OYCX0q49; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="OYCX0q49"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC3-000Ica-G8; Sun, 18 Oct 2026 17:53:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=hPTBFfUaXQmkp4NywfZArcH01EXUNwFTkG369ZCgFnc=; b=OYCX0q49yzhgnN6cVGjZwuPVaT
	Kj5M7Tg/wxgHEpbkoXoZGaUDTB/5a/FsPfsRvHxui+vUlxZTD7Z/2IdrShr6lNS6e+LXcL/uY43Ht
	kTYKOu368I26dimSUWI7nLm5KyXrll9opkhUoA48slK/0DSK0s37CVpKrtrw+V8yr24oUQYoD59g6
	A8zY66r7suKEkdfaAH+89PAnPlsfLUGPURlImYQ8TXyy5FMZ2w6lvjnPxc9LBlTlT4jq/JI1Q3Bt5
	MZkKCb4cE1NAXG6MW3nwemlhA82M1dAd1xaq90BQp24EFn3XpMJ1J7H2olJMqmYBzotjXxuiAAPPW
	SUuEIKVA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITBy-0001og-3I; Sun, 18 Oct 2026 17:52:58 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xITBg-004q3U-Kr;
	Sun, 18 Oct 2026 17:52:40 +0200
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
Subject: [PATCH v2 next 06/15] kallsyms: Optimise symbol name search
Date: Sun, 18 Oct 2026 16:51:57 +0100
Message-Id: <20261018155206.132411-7-david.laight.linux@gmail.com>
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

Change the alphabetically ordered lookup table (kallsyms_seqs_of_names)
with one that indexed the table of compressed names rather than the
array of symbol values.
This removes all the linear scans during the binary search for the symbol
name.
Once the name has been found a second binary search of the 'markers' array
followed by a linear scan for the symbols address gives the symbol value.

This linear scan is done once for each address returned, whereas the old
code did the scan for each of the ~17 comparisons in the binary search
(and the binary search is done at least two times for a symbol that appears
once).

For normal kernels the index table stays at 24 bits per symbol (now host
ordered), but a 32 bit table is used if necessary (probably only for
allyesconfig builds - which needs 25 bits on x86-64).

Speeds up lookup by name by a factor of about 12.

Build for BE kernels correctly flips the byte order in the index table.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Changes for v2 (previously patch 2):
- Fixed the upper bound in get_name_address() so there isn't a long
  linear scan for items near the upper limit.
- The table entry size (24/32 bits) is read from a (constant) variable
  to avoid relying on detecting undefined 'weak' symbols.
- A static branch is used to select between the two table sizes.
  This needs to be initialised very early (really just after the other
  code patching) and non of the initcall lists seem to be early enough,
  so I've initialised it on the first call using DO_ONCE_LITE().
  The overhead of that shouldn't be measurable.

 kernel/kallsyms.c          | 86 ++++++++++++++++++++++++++++----------
 kernel/kallsyms_internal.h |  5 ++-
 scripts/Makefile           |  1 +
 scripts/kallsyms.c         | 56 ++++++++++++++-----------
 4 files changed, 99 insertions(+), 49 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index d18d78e626db..31451feac822 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -25,6 +25,7 @@
 #include <linux/filter.h>
 #include <linux/ftrace.h>
 #include <linux/kprobes.h>
+#include <linux/once_lite.h>
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
 #include <linux/module.h>
@@ -177,6 +178,36 @@ static unsigned int get_symbol_offset(unsigned long pos)
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
@@ -185,14 +216,19 @@ unsigned long kallsyms_sym_address(int idx)
 	return (unsigned long)offset_to_ptr(kallsyms_offsets + idx);
 }
 
-static unsigned int get_symbol_seq(int index)
-{
-	unsigned int i, seq = 0;
+static DEFINE_STATIC_KEY_TRUE(kallsyms_off_size_24);
 
-	for (i = 0; i < 3; i++)
-		seq = (seq << 8) | kallsyms_seqs_of_names[3 * index + i];
+static inline unsigned int get_symbol_name_offset(unsigned long index)
+{
+	if (static_branch_likely(&kallsyms_off_size_24))
+		return kallsyms_off24_of_names[index].v;
+	return kallsyms_off32_of_names[index];
+}
 
-	return seq;
+static void set_kallsyms_off_size(void)
+{
+	if (kallsyms_off_size != 24)
+		static_branch_disable(&kallsyms_off_size_24);
 }
 
 static int kallsyms_lookup_names(const char *name,
@@ -201,15 +237,16 @@ static int kallsyms_lookup_names(const char *name,
 {
 	int ret;
 	int low, mid, high;
-	unsigned int seq, off;
+	unsigned int off;
+
+	DO_ONCE_LITE(set_kallsyms_off_size);
 
 	low = 0;
 	high = kallsyms_num_syms - 1;
 
 	while (low <= high) {
 		mid = low + (high - low) / 2;
-		seq = get_symbol_seq(mid);
-		off = get_symbol_offset(seq);
+		off = get_symbol_name_offset(mid);
 		ret = kallsyms_strcmp_symbol(off, name);
 		if (ret > 0)
 			low = mid + 1;
@@ -220,23 +257,24 @@ static int kallsyms_lookup_names(const char *name,
 	}
 
 	if (low > high)
-		return -ESRCH;
+		return -1;
+
+	ret = off;
 
 	low = mid;
 	while (low) {
-		seq = get_symbol_seq(low - 1);
-		off = get_symbol_offset(seq);
+		off = get_symbol_name_offset(low - 1);
 		if (kallsyms_strcmp_symbol(off, name) != 0)
 			break;
 		low--;
+		ret = off;
 	}
 	*start = low;
 
 	if (end) {
 		high = mid;
 		while (high < kallsyms_num_syms - 1) {
-			seq = get_symbol_seq(high + 1);
-			off = get_symbol_offset(seq);
+			off = get_symbol_name_offset(high + 1);
 			if (kallsyms_strcmp_symbol(off, name) != 0)
 				break;
 			high++;
@@ -244,7 +282,7 @@ static int kallsyms_lookup_names(const char *name,
 		*end = high;
 	}
 
-	return 0;
+	return ret;
 }
 
 /* Lookup the address for this symbol. Returns 0 if not found. */
@@ -258,8 +296,8 @@ unsigned long kallsyms_lookup_name(const char *name)
 		return 0;
 
 	ret = kallsyms_lookup_names(name, &i, NULL);
-	if (!ret)
-		return kallsyms_sym_address(get_symbol_seq(i));
+	if (ret >= 0)
+		return get_name_address(ret);
 
 	return module_kallsyms_lookup_name(name);
 }
@@ -289,15 +327,17 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, unsigned long),
 int kallsyms_on_each_match_symbol(int (*fn)(void *, unsigned long),
 				  const char *name, void *data)
 {
-	int ret;
-	unsigned int i, start, end;
+	int name_offset, ret;
+	unsigned int sym_number, last;
 
-	ret = kallsyms_lookup_names(name, &start, &end);
-	if (ret)
+	name_offset = kallsyms_lookup_names(name, &sym_number, &last);
+	if (name_offset < 0)
 		return 0;
 
-	for (i = start; !ret && i <= end; i++) {
-		ret = fn(data, kallsyms_sym_address(get_symbol_seq(i)));
+	for (;; name_offset = get_symbol_name_offset(sym_number)) {
+		ret = fn(data, get_name_address(name_offset));
+		if (ret || ++sym_number > last)
+			break;
 		cond_resched();
 	}
 
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 81a867dbe57d..ec6eca5654e6 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -13,6 +13,9 @@ extern const char kallsyms_token_table[];
 extern const u16 kallsyms_token_index[];
 
 extern const unsigned int kallsyms_markers[];
-extern const u8 kallsyms_seqs_of_names[];
+
+extern const unsigned int kallsyms_off_size;
+extern struct { unsigned int v:24 __packed; } __packed kallsyms_off24_of_names[] __weak;
+extern u32 kallsyms_off32_of_names[] __weak;
 
 #endif // LINUX_KALLSYMS_INTERNAL_H_
diff --git a/scripts/Makefile b/scripts/Makefile
index 3434a82a119f..b481c2b291bb 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -29,6 +29,7 @@ generate_rust_target-rust := y
 rustdoc_test_builder-rust := y
 rustdoc_test_gen-rust := y
 
+HOSTCFLAGS_kallsyms.o += $(if $(CONFIG_CPU_BIG_ENDIAN),-DCONFIG_CPU_BIG_ENDIAN)
 HOSTCFLAGS_tracepoint-update.o = -I$(srctree)/tools/include
 HOSTCFLAGS_elf-parse.o = -I$(srctree)/tools/include
 HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 2e936317fb09..a02fa17428d3 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -281,6 +281,14 @@ static void output_label(const char *label)
 	printf("%s:\n", label);
 }
 
+static void output_value(const char *label, unsigned int value)
+{
+	output_label(label);
+	printf("\t.long\t%u\n", value);
+	printf(".size %s, 4\n", label);
+	printf("\n");
+}
+
 /* uncompress a compressed symbol. When this function is called, the best table
  * might still be compressed itself, so the function needs to be recursive */
 static int expand_symbol(const unsigned char *data, int len, char *result)
@@ -335,28 +343,18 @@ static void sort_symbols_by_name(void)
 
 static void write_src(void)
 {
-	unsigned int i, k, off;
+	unsigned int i, k, off, off_size, table_size;
 	unsigned int best_idx[256];
-	unsigned int *markers, markers_cnt;
 	char buf[1 + KSYM_NAME_LEN];
 
 	printf("\t.section .rodata, \"a\"\n");
 
-	output_label("kallsyms_num_syms");
-	printf("\t.long\t%u\n", table_cnt);
-	printf("\n");
-
-	/* table of offset markers, that give the offset in the compressed stream
-	 * every 256 symbols */
-	markers_cnt = (table_cnt + 255) / 256;
-	markers = xmalloc(sizeof(*markers) * markers_cnt);
+	output_value("kallsyms_num_syms", table_cnt);
 
 	output_label("kallsyms_names");
 	off = 0;
 	for (i = 0; i < table_cnt; i++) {
-		if ((i & 0xFF) == 0)
-			markers[i >> 8] = off;
-		table[i]->seq = i;
+		table[i]->seq = off;
 
 		/* There cannot be any symbol of length zero. */
 		if (table[i]->len == 0)
@@ -389,17 +387,16 @@ static void write_src(void)
 		strcpy((char *)table[i]->sym, buf);
 		printf("\t/* %s */\n", table[i]->sym);
 	}
+	table_size = off;
 	printf(".size kallsyms_names, . - kallsyms_names\n");
 	printf("\n");
 
 	output_label("kallsyms_markers");
-	for (i = 0; i < markers_cnt; i++)
-		printf("\t.long\t%u\n", markers[i]);
+	for (i = 0; i < table_cnt; i += 256)
+		printf("\t.long\t%u\n", table[i]->seq);
 	printf(".size kallsyms_markers, . - kallsyms_markers\n");
 	printf("\n");
 
-	free(markers);
-
 	output_label("kallsyms_token_table");
 	off = 0;
 	for (i = 0; i < 256; i++) {
@@ -436,14 +433,23 @@ static void write_src(void)
 	printf("\n");
 
 	sort_symbols_by_name();
-	output_label("kallsyms_seqs_of_names");
-	for (i = 0; i < table_cnt; i++)
-		printf("\t.byte 0x%02x, 0x%02x, 0x%02x\t/* %s */\n",
-			(unsigned char)(table[i]->seq >> 16),
-			(unsigned char)(table[i]->seq >> 8),
-			(unsigned char)(table[i]->seq >> 0),
-		       table[i]->sym);
-	printf("\n");
+	off_size = table_size < (1u << 24) ? 24 : 32;
+	output_value("kallsyms_off_size", off_size);
+	output_label(off_size == 24 ? "kallsyms_off24_of_names" : "kallsyms_off32_of_names");
+	for (i = 0; i < table_cnt; i++) {
+		off = table[i]->seq;
+		if (off_size == 24) {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+			off = __builtin_bswap32(off) >> 8;
+#endif
+			printf("\t.byte\t0x%02x, 0x%02x, 0x%02x\t/* %s */\n",
+				off & 0xff, (off >> 8) & 0xff, off >> 16,
+			       table[i]->sym);
+		} else {
+			printf("\t.long\t%#04x\t/* %s */\n", off, table[i]->sym);
+		}
+	}
+	printf(".size kallsyms_off%d_of_names, . - kallsyms_off%d_of_names\n", off_size, off_size);
 
 	fflush(stdout);
 	if (ferror(stdout))
-- 
2.39.5

