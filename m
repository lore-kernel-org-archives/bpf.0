Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3CD3C0611;
	Sun, 18 Oct 2026 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338791; cv=none; b=LZHTR9qwEgjc7HkQQJ0X0gAeUmn7ec40sUpLEWMVV4YkRVykVmsh1owlHc9d/xN6KW/T79J415PEXm9mZrGbSdmt1khknvy39w7D0V2eaRONC6rr9Px/Jk7bV2SLRSpgpfE9X9tWIIkk5aj4rzDdGf2rZ0msD5tt/LfAZXtIFZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338791; c=relaxed/simple;
	bh=NBK3Uq6mJnMGLcuPcZsF3oQ5rq60icza9Ut44wW3kN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TkJf9nhOzCtx3OEaE7+uFZfMwHIWktHcS7B3cVtcEEs5WPzlVEdT5M8OSZwdoOFlYmkAQSgXJC7Irs7DhOdEVDGfVncsTjgbMdTqQGsmCWOhm1Z7ponJSJKdjvhw51z1k0XB/l+5xHL6AMhME6GTuCrqMW4MDa2PgZoyRnGX5cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=JIFleeIn; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="JIFleeIn"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC5-000Idb-F6; Sun, 18 Oct 2026 17:53:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=vt+DX7it/eANWApqnIWyB+tp9rxNTB9Pm45wqeF5kRw=; b=JIFleeIn7HVgMjlf5C8m2aAEr3
	VqHTtuXnEVLOKTLhIHcVz3szVYMPUhRZ38pwwd8ZTa3/5vsdlV0auVlVUGHKsgha8y41ZxayVIRH3
	h+95ArV9CthJVBJIoRMfHF6h2dlnOgM+P3Fnw2ucAC6RS6PK77iafuR3MU4rOVdeck3Oez852cTlS
	9bGM7NxPbZuQ69IKkJGM49tGJU/6bnEvrpwms6W08x7Teix2RCHR6nn2AVofMp+Xgd/95JLsLlNXR
	Z6Ihjex8hdY8louMRqHsB8qGPV0wYwvSztPFlfJr7MGpqX09mJCIBuSVizcO1MkcMU6PvMU0oymY7
	mZ90A8Fg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC0-0001pm-3J; Sun, 18 Oct 2026 17:53:00 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xITBh-004q3U-7N;
	Sun, 18 Oct 2026 17:52:41 +0200
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
Subject: [PATCH v2 next 07/15] kallsyms: Optimise detection of duplicate symbol names
Date: Sun, 18 Oct 2026 16:51:58 +0100
Message-Id: <20261018155206.132411-8-david.laight.linux@gmail.com>
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

While most symbol names are unique, some local symbols have duplicate names.
The first (usually lowest address) one is expected to be returned.

After the binary search finds a match, insted of doing a lookup of the
preceeding symbol to check it isn't a duplicate use the low bit of the
name offset to indicate this is a duplicate of the previous symbol.

If a short linear search fails to find a non-duplicate repeat the binary
search because some symbols (eg __func__.0) can occur hundreds of times.
(Or tens of thousands of times in an allyesconfig kernel.)

Change kallsyms_on_each_match_symbol() to do a linear scan until it finds
a non-duplicate instead does the search in kallsyms_lookup_names().
Add a zero marker to the end of the table so that scan terminates for the
last symbol.

The slowest 'lookup by name' changes being a symbol that is duplicated a lot
to one that is very long.

Rename the kallsyms_off_24/32_of_names symbols to ensure code mismatch
causes a link fail.

Stealing a bit from the name offset means that 32bit offsets are needed
if the compressed name table exceeds 8GB rather than 16GB.
The table for the kernel I'm building is about 1.5GB.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 kernel/kallsyms.c          | 88 ++++++++++++++++++--------------------
 kernel/kallsyms_internal.h |  4 +-
 scripts/kallsyms.c         | 16 +++++--
 3 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 31451feac822..e393ede35111 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -117,7 +117,7 @@ static int kallsyms_strcmp_symbol(unsigned int off, const char *name)
 {
 	const char *tptr;
 	unsigned int len;
-	const u8 *data = get_symbol_data(off, &len);
+	const u8 *data = get_symbol_data(off >> 1, &len);
 
 	tptr = &kallsyms_token_table[kallsyms_token_index[*data++]] + 1;
 	while (*tptr) {
@@ -221,8 +221,8 @@ static DEFINE_STATIC_KEY_TRUE(kallsyms_off_size_24);
 static inline unsigned int get_symbol_name_offset(unsigned long index)
 {
 	if (static_branch_likely(&kallsyms_off_size_24))
-		return kallsyms_off24_of_names[index].v;
-	return kallsyms_off32_of_names[index];
+		return kallsyms_off_24_of_names[index].v;
+	return kallsyms_off_32_of_names[index];
 }
 
 static void set_kallsyms_off_size(void)
@@ -231,58 +231,51 @@ static void set_kallsyms_off_size(void)
 		static_branch_disable(&kallsyms_off_size_24);
 }
 
-static int kallsyms_lookup_names(const char *name,
-				 unsigned int *start,
-				 unsigned int *end)
+static int kallsyms_lookup_names(const char *name, unsigned int *start)
 {
+	unsigned int mid, off;
+	int low, high;
 	int ret;
-	int low, mid, high;
-	unsigned int off;
 
 	DO_ONCE_LITE(set_kallsyms_off_size);
 
 	low = 0;
 	high = kallsyms_num_syms - 1;
 
-	while (low <= high) {
+	for (;;) {
+		if (low > high)
+			return -1;
 		mid = low + (high - low) / 2;
 		off = get_symbol_name_offset(mid);
 		ret = kallsyms_strcmp_symbol(off, name);
-		if (ret > 0)
+		if (ret > 0) {
 			low = mid + 1;
-		else if (ret < 0)
-			high = mid - 1;
-		else
-			break;
-	}
-
-	if (low > high)
-		return -1;
-
-	ret = off;
-
-	low = mid;
-	while (low) {
-		off = get_symbol_name_offset(low - 1);
-		if (kallsyms_strcmp_symbol(off, name) != 0)
-			break;
-		low--;
-		ret = off;
-	}
-	*start = low;
-
-	if (end) {
-		high = mid;
-		while (high < kallsyms_num_syms - 1) {
-			off = get_symbol_name_offset(high + 1);
-			if (kallsyms_strcmp_symbol(off, name) != 0)
+			continue;
+		}
+		if (!ret) {
+			/*
+			* Found a match, but need the first one.
+			* Most symbols (and all exported/global ones) only occur
+			* once, most of the others only occur a small number of
+			* times so it is worth doing a linear scan that avoids the
+			* kallsyms_strcmp_symbol() call.
+			* However some symbols occur a large number of times
+			* (_sub_D_65535_0 is repeated 24610 times in an x86-64
+			* allyesconfig, __func__.0 442 in a more normal kernel).
+			* Avoid a long linear scan by returning to the binary
+			* search if a short linear search is fruitless.
+			*/
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
 
-	return ret;
+	*start = mid;
+	return off;
 }
 
 /* Lookup the address for this symbol. Returns 0 if not found. */
@@ -295,9 +288,9 @@ unsigned long kallsyms_lookup_name(const char *name)
 	if (!*name)
 		return 0;
 
-	ret = kallsyms_lookup_names(name, &i, NULL);
+	ret = kallsyms_lookup_names(name, &i);
 	if (ret >= 0)
-		return get_name_address(ret);
+		return get_name_address(ret >> 1);
 
 	return module_kallsyms_lookup_name(name);
 }
@@ -328,18 +321,19 @@ int kallsyms_on_each_match_symbol(int (*fn)(void *, unsigned long),
 				  const char *name, void *data)
 {
 	int name_offset, ret;
-	unsigned int sym_number, last;
+	unsigned int sym_number;
 
-	name_offset = kallsyms_lookup_names(name, &sym_number, &last);
+	name_offset = kallsyms_lookup_names(name, &sym_number);
 	if (name_offset < 0)
 		return 0;
 
-	for (;; name_offset = get_symbol_name_offset(sym_number)) {
-		ret = fn(data, get_name_address(name_offset));
-		if (ret || ++sym_number > last)
+	do {
+		ret = fn(data, get_name_address(name_offset >> 1));
+		if (ret)
 			break;
 		cond_resched();
-	}
+		name_offset = get_symbol_name_offset(++sym_number);
+	} while (name_offset & 1);
 
 	return ret;
 }
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index ec6eca5654e6..e4a1f737aed1 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -15,7 +15,7 @@ extern const u16 kallsyms_token_index[];
 extern const unsigned int kallsyms_markers[];
 
 extern const unsigned int kallsyms_off_size;
-extern struct { unsigned int v:24 __packed; } __packed kallsyms_off24_of_names[] __weak;
-extern u32 kallsyms_off32_of_names[] __weak;
+extern struct { unsigned int v:24 __packed; } __packed kallsyms_off_24_of_names[] __weak;
+extern u32 kallsyms_off_32_of_names[] __weak;
 
 #endif // LINUX_KALLSYMS_INTERNAL_H_
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index a02fa17428d3..2e579e1cf7de 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -433,11 +433,14 @@ static void write_src(void)
 	printf("\n");
 
 	sort_symbols_by_name();
-	off_size = table_size < (1u << 24) ? 24 : 32;
+	off_size = table_size < (1u << 23) ? 24 : 32;
 	output_value("kallsyms_off_size", off_size);
-	output_label(off_size == 24 ? "kallsyms_off24_of_names" : "kallsyms_off32_of_names");
+	output_label(off_size == 24 ? "kallsyms_off_24_of_names" : "kallsyms_off_32_of_names");
 	for (i = 0; i < table_cnt; i++) {
-		off = table[i]->seq;
+		off = table[i]->seq << 1;
+		if (i && !strcmp((char *)table[i - 1]->sym + 1, (char *)table[i]->sym + 1))
+			/* Mark that this is a duplicate of the previous symbol */
+			off |= 1;
 		if (off_size == 24) {
 #ifdef CONFIG_CPU_BIG_ENDIAN
 			off = __builtin_bswap32(off) >> 8;
@@ -449,7 +452,12 @@ static void write_src(void)
 			printf("\t.long\t%#04x\t/* %s */\n", off, table[i]->sym);
 		}
 	}
-	printf(".size kallsyms_off%d_of_names, . - kallsyms_off%d_of_names\n", off_size, off_size);
+	/* Terminator without the 'duplicate' flag. */
+	if (off_size == 24)
+		printf("\t.byte\t0,0,0\n");
+	else
+		printf("\t.long\t0\n");
+	printf(".size kallsyms_off_%d_of_names, . - kallsyms_off_%d_of_names\n", off_size, off_size);
 
 	fflush(stdout);
 	if (ferror(stdout))
-- 
2.39.5

