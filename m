Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2B3C1991
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338799; cv=none; b=sR9poYiUSy8VxhQmcjMqQBU4WF5hFj2AcPSDjkV6mkRoqBq8DV7xnG9Ggnhh+onHLh0tupXZqcPb6gGbyvQTD1UYOBXLgfyAN02WocJaocaH5sh0VSiKiGW4u61rCbcssI5pXjZxMz2kaQrbQeOlJRspJuwa9RsUX54syKkm2Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338799; c=relaxed/simple;
	bh=ti/pJ6n/J7rKpaYT9Mk8BukscTkwrN44pFD3IfsI628=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=myUwpRbnO9F0NAeEL9n7MPR3bg8bY7i3Z+CTZl+b78ftYDsCFNj0PLSFmWsbX/2uWUgIjrwMsQfhK2bcNRdO6wVSAfiaqxADh0htECrj4t77OydLzR8aCE+wBsLKtDNTBOb8zJ0Llcvp8mLvPYB6BpYdbsOnWgX2jqcLSoK1dlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=G4kbf5QG; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="G4kbf5QG"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC5-001KBb-6h; Sun, 18 Oct 2026 17:53:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=Xu9IW1jhtoKX0vGf+P8HUldKzEJOhAB84g1ZPSWkoHo=; b=G4kbf5QGaqiEPVaKEAWQkqI8sG
	hIEFgE7UAt0Vx0cxBBM+4+tHg1S8qmSxu5gnvVj7GBP1S8/agTYjxT6h+2QWCXaLmbo1sZ13vISEY
	JT/vxKx/F7Eqt3ny0nCTwWZc+aeoXY/wZERa3PSF8HtWPysN90l8UgwSO0q8crDPGxiVm/abPcXHm
	1JZ6DZ/+/4FC+uRzIT32O/ozFPnghGni5Ahpwjc6HzCo3wbBotM663poUc9p6KAyDO48VHkRbMDxz
	WmdmClyilqn4fBg9qE5NcG2lsv6FK4RQOPjkmqKNr7BWJK//firCBT5abOdYE/sG7fxRrdZzkFNBF
	dMZvvfBw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITBz-0000Bj-Sr; Sun, 18 Oct 2026 17:53:00 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xITBh-004q3U-OA;
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
Subject: [PATCH v2 next 08/15] kallsyms: Support changing the density of the kallsyms_markers[] array
Date: Sun, 18 Oct 2026 16:51:59 +0100
Message-Id: <20261018155206.132411-9-david.laight.linux@gmail.com>
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

The density is a tradeoff between data size and execution speed.
Reducing it from 256 to 64 gives a 35% improvement for name lookups.

Change scripts/kallsyms to take the density from a --marker-shift command
line parameter so that it can be build specific.
The default is unchanged at 1 marker per 256 symbols.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 kernel/kallsyms.c          | 16 +++++++---------
 kernel/kallsyms_internal.h |  1 +
 scripts/kallsyms.c         | 30 ++++++++++++++++++++++--------
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index e393ede35111..ff2da8c8f7e3 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -148,13 +148,11 @@ static int kallsyms_strcmp_symbol(unsigned int off, const char *name)
 static unsigned int get_symbol_offset(unsigned long pos)
 {
 	const u8 *name;
-	int i, len;
+	int len;
 
-	/*
-	 * Use the closest marker we have. We have markers every 256 positions,
-	 * so that should be close enough.
-	 */
-	name = &kallsyms_names[kallsyms_markers[pos >> 8]];
+	/* Scan from the marker before the requested symbol number */
+	name = &kallsyms_names[kallsyms_markers[pos >> kallsyms_marker_shift]];
+	pos &= (1 << kallsyms_marker_shift) - 1;
 
 	/*
 	 * Sequentially scan all the symbols up to the point we're searching
@@ -162,7 +160,7 @@ static unsigned int get_symbol_offset(unsigned long pos)
 	 * so we just need to add the len to the current pointer for every
 	 * symbol we wish to skip.
 	 */
-	for (i = 0; i < (pos & 0xFF); i++) {
+	while (pos--) {
 		len = *name;
 
 		/*
@@ -186,7 +184,7 @@ static unsigned long get_name_address(unsigned int name_offset)
 	unsigned int low, pos, high;
 
 	low = 0;
-	high = ((kallsyms_num_syms - 1) >> 8) + 1;
+	high = ((kallsyms_num_syms - 1) >> kallsyms_marker_shift) + 1;
 
 	while (high - low > 1) {
 		pos = low + (high - low) / 2;
@@ -197,7 +195,7 @@ static unsigned long get_name_address(unsigned int name_offset)
 	}
 
 	pos = kallsyms_markers[low];
-	for (low <<= 8; pos < name_offset; low++) {
+	for (low <<= kallsyms_marker_shift; pos < name_offset; low++) {
 		unsigned int len = kallsyms_names[pos];
 		if (len & 0x80)
 			len += (kallsyms_names[pos + 1] << 7) - 0x7f;
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index e4a1f737aed1..b98469b5c2f5 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -12,6 +12,7 @@ extern const unsigned int kallsyms_num_syms;
 extern const char kallsyms_token_table[];
 extern const u16 kallsyms_token_index[];
 
+extern const unsigned int kallsyms_marker_shift;
 extern const unsigned int kallsyms_markers[];
 
 extern const unsigned int kallsyms_off_size;
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 2e579e1cf7de..d2d3ac8c33a1 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -58,6 +58,8 @@ static struct sym_entry **table;
 static unsigned int table_size, table_cnt;
 static int all_symbols;
 static int pc_relative;
+/* Default to one kallsyms_markers[] entry for each 256 symbols */
+static unsigned long marker_shift = 8;
 
 static int token_profit[0x10000];
 
@@ -68,7 +70,7 @@ static unsigned char best_table_len[256];
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: kallsyms [--all-symbols] in.map > out.S\n");
+	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--pc-relative] [--marker-shift=n] in.map > out.S\n");
 	exit(1);
 }
 
@@ -391,8 +393,9 @@ static void write_src(void)
 	printf(".size kallsyms_names, . - kallsyms_names\n");
 	printf("\n");
 
+	output_value("kallsyms_marker_shift", marker_shift);
 	output_label("kallsyms_markers");
-	for (i = 0; i < table_cnt; i += 256)
+	for (i = 0; i < table_cnt; i += 1u << marker_shift)
 		printf("\t.long\t%u\n", table[i]->seq);
 	printf(".size kallsyms_markers, . - kallsyms_markers\n");
 	printf("\n");
@@ -696,17 +699,28 @@ int main(int argc, char **argv)
 {
 	while (1) {
 		static const struct option long_options[] = {
-			{"all-symbols",     no_argument, &all_symbols,     1},
-			{"pc-relative",     no_argument, &pc_relative,     1},
+			{"all-symbols", no_argument, &all_symbols, 1},
+			{"pc-relative", no_argument, &pc_relative, 1},
+			{"marker-shift", required_argument, NULL, 'm'},
 			{},
 		};
 
-		int c = getopt_long(argc, argv, "", long_options, NULL);
-
-		if (c == -1)
+		switch (getopt_long(argc, argv, "", long_options, NULL)) {
+		case -1:
 			break;
-		if (c != 0)
+		case 0:
+			continue;
+		case 'm':
+			if (!optarg[0])
+				continue;
+			marker_shift = strtoul(optarg, NULL, 10);
+			if (marker_shift > 24)
+				usage();
+			continue;
+		default:
 			usage();
+		}
+		break;
 	}
 
 	if (optind >= argc)
-- 
2.39.5

