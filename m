Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911675;
	b=tVKS7cu6EPdekW969zaOvieFyThNXM0NyZKGI9VUqsm5fewo3PBd+hww7tirC2s3mHbV
	 d7h3qfG9rJlf5/4kXN/p2Yc1I7WXmYGnpJgzyc3+qy1TW4kp+ObhGOTZcoDh2pKjool8+
	 +iGgVS51FlGI2+IYvD9Wob/HIF4SFhYmiCWMvzEDjnEKQNig5AtagzSIO2hrriCO0mtut
	 NzToaJh7s1yUI9pVZJBHgEw5eRy1kGsLzQ2CIkEx1oHe2T1ymKyn2aABgCew8ndN0dvOV
	 iwJr2QT1lGRPwY59sBeonZLZqBVPkrck6lq5fPZAK+5AFN9Mbgo+Uj/OYqNmenzRozw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911675;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xdvblP+N5Gd4YzHBQJEFvm9RZs4h+QProNeeeXtqUao=;
	b=baIcu1afOyn0w0pXDgrlMi2M2JQKXhxT90FiBhB7dMCav8xV46uxJ9EGgj9GyWdYfTSx
	 xBb9UytkT0BOIm3InzgwbQ0tt1aauEubfkFCXhzl0STDKLhoppjkXYfh2rudGo5X8473X
	 2WYBa61lt7gHmiNP5AVzHwjkaLs0c8oB/VnySFdR/CoySvKFkBwpiZeM32UUAdDaVL5+1
	 V+2m5BXOqfuXdM30gVCgd1t5x3eglf+GtyChIYUPq0RHO0YOWJv8eaaPpB4KYgajffXVG
	 LZPVuHER7SK/EfOX+jT/Dm7wZAt7zsXrq9lTdFCREBYkCIrihTVxnghOi5E0nbdwJ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=XCrebI3K;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7A60A262A;
	Tue, 17 Nov 2026 10:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26D7A60A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=XCrebI3K
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW9-002LkJ-A7; Tue, 17 Nov 2026 11:34:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=xdvblP+N5Gd4YzHBQJEFvm9RZs4h+QProNeeeXtqUao=; b=XCrebI3KFFZ36YFHpsqt5B/R3M
	r0mMM0mwwt2seTCSgwB2VIMjWO6yHAGJx6EEMLBsPiFlhAML2dz4imW9IXRXsaJOyQeKdGHkGJrH4
	31Fvfb3DNfqLunLR/gcJsIqEB+wT3BwyNlaIHzC/hCE20V0JvIoP0sPa6+2y3ctWLM/1rq6lprhSI
	I2tY8jSvEU77YxnJZ1d2oZeoP0kG8OSJoOz5WcTz7q0Fr8znl+KbZCxHF+TP3X36GE46W+zIA3Hij
	T1kNdUVpaslCXehJErn7GFg4ZTzyq256HOwKp1XkBCIb1qbHwuCVdmc4l97RFCefIP6ls5GPH8GLU
	k8gHY1WA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW3-0002FP-WB; Tue, 17 Nov 2026 11:34:20 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xTGVp-005qHU-8x;
	Tue, 17 Nov 2026 11:34:05 +0100
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
Subject: [PATCH v4 next 09/13] kallsyms: Add a kernel parameter to change the kallsyms_markers[] density
Date: Tue, 17 Nov 2026 10:33:48 +0000
Message-Id: <20261117103352.1244657-10-david.laight.linux@gmail.com>
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

The density is a tradeoff between data size and execution speed.
Reducing it from 256 to 64 gives a 35% improvement for name lookups.

Change scripts/kallsyms to take the density from a --marker-shift command
line parameter so that it can be build specific.
Write the value used to the output file to ensure the kernel uses the
correct value.

The program's default is unchanged at 1 marker per 256 symbols,
The kernel config defaults to 1 marker per 64 symbols.
This increases the static data by a little less than 1 bit for every
two symbols.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

v3:
- Previously patches 8 and 9
v4:
- Fix rounding of the size of 'markers' array.
  Allocate oversize, and count the entries added.

 init/Kconfig               | 19 ++++++++++++++
 kernel/kallsyms.c          | 16 +++++------
 kernel/kallsyms_internal.h |  1 +
 scripts/kallsyms.c         | 54 ++++++++++++++++++++++++++------------
 scripts/link-vmlinux.sh    |  6 +++++
 5 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 4013781e0a02..b2db123a51d7 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1908,6 +1908,25 @@ config KALLSYMS
 	  symbolic stack backtraces. This increases the size of the kernel
 	  somewhat, as all symbols have to be loaded into the kernel image.
 
+config KALLSYMS_MARKER_SHIFT
+	int "Interval between kallsyms markers (6 => 64, 8 => 256)"
+	depends on KALLSYMS
+	default 6
+	range 0 24
+	help
+	  Set the interval between the kallsyms marker entries as a power of 2.
+
+	  This bounds the linear search when locating the name of a symbol
+	  from its index in the array of values (and v.v.).
+
+	  Smaller values speed up the search but increase the memory footprint.
+	  Values below 5 (one 32 bit marker every 32 symbols) are unlikely to
+	  make a significant difference because other parts of the code
+	  dominate.
+
+	  The default of 6 is a reasonable compromise. It makes looking up a
+	  symbol by name around 35% faster than setting it to 8.
+
 config KALLSYMS_SELFTEST
 	bool "Test the basic functions and performance of kallsyms"
 	depends on KALLSYMS
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index fd42a1a8ed3e..2c4264a3e0c5 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -147,13 +147,11 @@ static int kallsyms_strcmp_symbol(unsigned int off, const char *name)
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
@@ -161,7 +159,7 @@ static unsigned int get_symbol_offset(unsigned long pos)
 	 * so we just need to add the len to the current pointer for every
 	 * symbol we wish to skip.
 	 */
-	for (i = 0; i < (pos & 0xFF); i++) {
+	while (pos--) {
 		len = *name;
 
 		/*
@@ -185,7 +183,7 @@ static unsigned long get_name_address(unsigned int name_offset)
 	unsigned int low, pos, high;
 
 	low = 0;
-	high = ((kallsyms_num_syms - 1) >> 8) + 1;
+	high = ((kallsyms_num_syms - 1) >> kallsyms_marker_shift) + 1;
 
 	while (high - low > 1) {
 		pos = low + (high - low) / 2;
@@ -196,7 +194,7 @@ static unsigned long get_name_address(unsigned int name_offset)
 	}
 
 	pos = kallsyms_markers[low];
-	for (low <<= 8; pos < name_offset; low++) {
+	for (low <<= kallsyms_marker_shift; pos < name_offset; low++) {
 		unsigned int len = kallsyms_names[pos];
 		if (len & 0x80)
 			len += (kallsyms_names[pos + 1] << 7) - 0x7f;
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 11fb0de92ede..9137870ad00f 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -12,6 +12,7 @@ extern const unsigned int kallsyms_num_syms;
 extern const char kallsyms_token_table[];
 extern const u16 kallsyms_token_index[];
 
+extern const unsigned int kallsyms_marker_shift;
 extern const unsigned int kallsyms_markers[];
 
 /* Although constant, size is volatile for better code generation. */
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 39426f736cb7..f1c952a94e01 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -59,6 +59,8 @@ static unsigned int table_size, table_cnt;
 static int all_symbols;
 static int pc_relative;
 static int verbose;
+/* Default to one kallsyms_markers[] entry for each 256 symbols */
+static unsigned long marker_shift = 8;
 
 static int big_endian;	/* Extracted from the elf file */
 
@@ -410,7 +412,7 @@ static void write_src(void)
 {
 	unsigned int i, k, len, off, off_size, table_size;
 	unsigned int best_idx[256];
-	unsigned int *markers, markers_cnt;
+	unsigned int *markers, markers_cnt, markers_mask;
 	unsigned long bin_offset = 0;
 	char buf[1 + KSYM_NAME_LEN];
 	struct sym_entry *se;
@@ -446,9 +448,10 @@ static void write_src(void)
 	stamp("write token table");
 
 	/* table of offset markers, that give the offset in the compressed stream
-	 * every 256 symbols */
-	markers_cnt = (table_cnt + 255) / 256;
-	markers = xmalloc(sizeof(*markers) * markers_cnt);
+	 * every (1 << marker_shift) (typically 64 or 256) symbols */
+	markers = xmalloc(sizeof(*markers) * ((table_cnt >> marker_shift) + 1));
+	markers_cnt = 0;
+	markers_mask = (1u << marker_shift) - 1;
 
 	output_label("kallsyms_names");
 	write_incbin_header("names", &bin_offset);
@@ -481,14 +484,14 @@ static void write_src(void)
 		}
 
 		if (out_bin_file) {
-			if ((i & 0xFF) == 0)
-				markers[i >> 8] = big_endian ? htobe32(off) : htole32(off);
+			if ((i & markers_mask) == 0)
+				markers[markers_cnt++] = big_endian ? htobe32(off) : htole32(off);
 
 			fwrite(len, 1, len_len, out_bin_file);
 			fwrite(se->sym, 1, se->len, out_bin_file);
 		} else {
-			if ((i & 0xFF) == 0)
-				markers[i >> 8] = off;
+			if ((i & markers_mask) == 0)
+				markers[markers_cnt++] = off;
 
 			printf("\t/* n:%u */\t.byte\t%u", off, len[0]);
 			if (len_len == 2)
@@ -509,6 +512,10 @@ static void write_src(void)
 	printf(".size kallsyms_names, . - kallsyms_names\n");
 	printf("\n");
 
+	output_label("kallsyms_marker_shift");
+	printf("\t.long\t%lu\n" , marker_shift);
+	printf("\n");
+
 	output_label("kallsyms_markers");
 	if (out_bin_file) {
 		write_incbin_header("markers", &bin_offset);
@@ -930,6 +937,7 @@ static void usage(void)
 		"Usage: kallsyms [options] [vmlinux [out.bin]] > out.S\n"
 		"       kallsyms --sysmap vmlinux > out.map\n"
 		"           --all-symbols     Include all local symbols\n"
+		"           --marker-shift=n  Interval between makers (6 => 64, 8 => 256)\n"
 		"           --pc-relative     Output symbol offsets\n"
 		"           --sysmap=out.map  Text map file\n"
 		"           --verbose         Extra diagnostic output\n"
@@ -950,21 +958,33 @@ int main(int argc, char **argv)
 
 	while (1) {
 		static const struct option long_options[] = {
-			{"all-symbols",     no_argument, &all_symbols,     1},
-			{"pc-relative",     no_argument, &pc_relative,     1},
-			{"sysmap",    optional_argument, NULL,           's'},
-			{"verbose",         no_argument, &verbose,         1},
+			{"all-symbols",        no_argument, &all_symbols,     1},
+			{"marker-shift", required_argument, NULL,           'm'},
+			{"pc-relative",        no_argument, &pc_relative,     1},
+			{"sysmap",       optional_argument, NULL,           's'},
+			{"verbose",            no_argument, &verbose,         1},
 			{},
 		};
 
-		int c = getopt_long(argc, argv, "", long_options, NULL);
-
-		if (c == -1)
+		switch (getopt_long(argc, argv, "", long_options, NULL)) {
+		case -1:
 			break;
-		if (c == 's')
+		case 0:
+			continue;
+		case 'm':
+			if (!optarg[0])
+				continue;
+			marker_shift = strtoul(optarg, NULL, 10);
+			if (marker_shift > 24)
+				usage();
+			continue;
+		case 's':
 			sysmap = optarg ?: "";
-		else if (c != 0)
+			continue;
+		default:
 			usage();
+		}
+		break;
 	}
 
 	stamp(NULL);
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 44b5a6d78ce5..61cf8f287ebe 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -37,6 +37,10 @@ is_enabled() {
 	grep -q "^$1=y" include/config/auto.conf
 }
 
+value() {
+	sed -n "/^$1=/{s///;p;q}" include/config/auto.conf
+}
+
 # Nice output in kbuild format
 # Will be suppressed by "make -s"
 info()
@@ -140,6 +144,8 @@ kallsyms()
 		kallsymopt="${kallsymopt} --pc-relative"
 	fi
 
+	kallsymopt="${kallsymopt} --marker-shift=$(value CONFIG_KALLSYMS_MARKER_SHIFT)"
+
 	info KSYMS "${2}.S"
 	scripts/kallsyms ${kallsymopt} ${1:+"${1}" "${2}.bin"} > "${2}.S"
 
-- 
2.39.5

