Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D72349B15
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338804; cv=none; b=RJjtkNJ+UNf7q0CEG3vFY6ijnS+EqzAe4W71Ovuafh9t3aBgJ/VjgL4boo8MB0Cclef3g6+NRZSyffl3OYvzErF+czShmmcYIZFhsFIuOLYffMSu/B4zge22Z7N+Vu0jhth2ooU7eLAadQhCMFNBVxft0uKzf4uDBTJzDmcXXyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338804; c=relaxed/simple;
	bh=/KcvjAAotjY3kSYHV4XzrJ+/cCO74FreeMbHM+lHM4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KYc4jon2jY/DrFVjh0lG92aK9N1I3VOWdpDbXHOcEJGWQJ929RbyCzoajpnlR/qmX0TWbSdOvhc7I8mXYuveU4PIbmbVAmrzbnEw1Zuuxu6boR3VSLxavjNKAmLazCXpzB0MOItaR6GZrjVPVUCt5Y23E9dw/qyx1Mu0qrZ5tP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=BWrNYupf; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="BWrNYupf"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC3-001KAb-7g; Sun, 18 Oct 2026 17:53:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=lzqNFug0wnON7GfzAG9E91iHafcUZj58vKUZGTFbbOo=; b=BWrNYupfBivwVspK5W8nwQwlqA
	s7EnEGRVCs63W1YjTY+LUHq2q1e/3GfcHpYOPbdYV8F1E4oepJKHt3Q8dFDs+fqt458NfoOfzkDg3
	tFA/AeiolpRD55tHsz0FRNO3CZ4XsHHaCnjh5D9/8wBDrIdF4lSmCs+Ks6f6OEpkRLY9yAHnV7j2H
	6hZZF66jraB5r5s6jP9Fw061aZ0bWz0JbvCCMD8r5vZD+3WNn7i+UBWJW8xwNh0uReSicmRPUTb8s
	yhgBzVEv/IR8fBK2vnIB3D1w72k74gdHtjM6uKA08DjnQZGHRNc4O+KdHDePr/cnypV9M08l0s3qV
	uTEx/TlQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITBx-0001oZ-Pw; Sun, 18 Oct 2026 17:52:58 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xITBf-004q3U-IV;
	Sun, 18 Oct 2026 17:52:39 +0200
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
Subject: [PATCH v2 next 04/15] kallsyms: scripts/kallsyms: Check for output file write errors
Date: Sun, 18 Oct 2026 16:51:55 +0100
Message-Id: <20261018155206.132411-5-david.laight.linux@gmail.com>
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

Exit with an error status if any writes to the output file fail.
The file is big and it might the point where 'disk full' is reached.

Use errx() for all the error exits to simplify the code and ensure
the program name is added.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 scripts/kallsyms.c | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index bda8921c95ef..2e936317fb09 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -18,6 +18,7 @@
  *
  */
 
+#include <err.h>
 #include <errno.h>
 #include <getopt.h>
 #include <stdbool.h>
@@ -135,18 +136,16 @@ static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
 
 	addr = strtoull(*buf, &p, 16);
 
-	if (*buf == p || *p++ != ' ' || !isascii((type = *p++)) || *p++ != ' ') {
-		fprintf(stderr, "line format error\n");
-		exit(EXIT_FAILURE);
-	}
+	if (*buf == p || *p++ != ' ' || !isascii((type = *p++)) || *p++ != ' ')
+		errx(1, "line format error");
 
 	name = p;
 	len = strlen(name);
 
 	if (len >= KSYM_NAME_LEN) {
-		fprintf(stderr, "Symbol %s too long for kallsyms (%zu >= %d).\n"
-				"Please increase KSYM_NAME_LEN both in kernel and kallsyms.c\n",
-			name, len, KSYM_NAME_LEN);
+		warnx("Symbol %s too long for kallsyms (%zu >= %d).\n"
+		      "Please increase KSYM_NAME_LEN both in kernel and kallsyms.c",
+		      name, len, KSYM_NAME_LEN);
 		return NULL;
 	}
 
@@ -253,10 +252,8 @@ static void read_map(const char *in)
 	size_t buflen = 0;
 
 	fp = fopen(in, "r");
-	if (!fp) {
-		perror(in);
-		exit(1);
-	}
+	if (!fp)
+		err(1, "failed to open %s", in);
 
 	while (!feof(fp)) {
 		sym = read_symbol(fp, &buf, &buflen);
@@ -362,18 +359,12 @@ static void write_src(void)
 		table[i]->seq = i;
 
 		/* There cannot be any symbol of length zero. */
-		if (table[i]->len == 0) {
-			fprintf(stderr, "kallsyms failure: "
-				"unexpected zero symbol length\n");
-			exit(EXIT_FAILURE);
-		}
+		if (table[i]->len == 0)
+			errx(1, "unexpected zero symbol length");
 
 		/* Only lengths that fit in up-to-two-byte ULEB128 are supported. */
-		if (table[i]->len > 0x3FFF) {
-			fprintf(stderr, "kallsyms failure: "
-				"unexpected huge symbol length\n");
-			exit(EXIT_FAILURE);
-		}
+		if (table[i]->len > 0x3FFF)
+			errx(1, "unexpected huge symbol length");
 
 		/* Encode length with ULEB128. */
 		if (table[i]->len <= 0x7F) {
@@ -431,12 +422,9 @@ static void write_src(void)
 		if (pc_relative) {
 			long long offset = table[i]->addr - _text;
 
-			if (offset < INT_MIN || offset > INT_MAX) {
-				fprintf(stderr, "kallsyms failure: "
-					"relative symbol value %#llx out of range\n",
-					table[i]->addr);
-				exit(EXIT_FAILURE);
-			}
+			if (offset < INT_MIN || offset > INT_MAX)
+				errx(1, "relative symbol value %#llx out of range",
+				     table[i]->addr);
 			printf("\t.long\t_text - . + (%d)\t/* %s */\n",
 			       (int)offset, table[i]->sym);
 		} else {
@@ -456,6 +444,10 @@ static void write_src(void)
 			(unsigned char)(table[i]->seq >> 0),
 		       table[i]->sym);
 	printf("\n");
+
+	fflush(stdout);
+	if (ferror(stdout))
+		errx(1, "error writing to output file");
 }
 
 
-- 
2.39.5

