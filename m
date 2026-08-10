Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624D73E316C
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371802; cv=none; b=iw1wBNM4pwyQIRDdtuMRAHthtI6xJEquImEhXUImR30nZZ8kbrP/VOQu3BBw3vXkZ6vOgl6r6xeIGU7PniphEs20XmcDnTDlNQXKY/G4xYnbKDz4gDZySt99kQo94+5NC0pIwi/6LhXz1XQYWTpDcHBvwRBsoRH21Ti3IC5Jy+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371802; c=relaxed/simple;
	bh=IE1++EMItDbe4o9Ydl5Iz1t0Ffg5QcNVcIAOd09kCnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cw8DnsRhcN6929L7ZHdqx1tVpykmB/cJsfJobUxoBMDbKFjk2g5N0VCrNY4BVl8CLfW4BJD1GPlWMbpTjzrcy1tyOpzmLxk9KbRSuw+549cKX7xEEbK30BQf7IkIR2GpM9ZbwxfdPiUkIFJ06rUvNyrKTaMu8jW9sSWfliM2dfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DcC0klqb; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DcC0klqb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=CT
	gWTAKgdKI8Y7UGX7h4TmLE+wqaJQ9tHq4Pkxh0/9g=; b=DcC0klqbsJ4WzPf4uh
	DwW9JT+Qg9R1RXcjgfI/syQgLQ1zj83Z6+tLqfWnX2zKtwKlQbTTIamBNyFXWfA7
	/IWEw0BiQSXMwWm+X2xkueg1FbIIJZwZ8c0FDdGiKpWuOVo81pfbnElEobPhAnh/
	esSMp+L8B+tY8N5FP5Kb38/qA=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3n9ip3nlq3APzNA--.8292S4;
	Mon, 10 Aug 2026 22:22:41 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v5 2/3] bpftool: fix spurious batch file read error
Date: Mon, 10 Aug 2026 22:22:23 +0800
Message-ID: <20260810142224.2907373-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810142224.2907373-1-chenyuan_fl@163.com>
References: <20260810142224.2907373-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n9ip3nlq3APzNA--.8292S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4rWrykury3Xw17Gw1UAwb_yoW8tr1UpF
	ZxJr9xtrW8XrWFyFWxArW5uFyrWrZ3trZxuan3Kw4YyF15Gr1aqr48KFyrXFy7XrWSya1U
	tFnI9FZ5Z3WDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfiSdUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDARHcmmp53rH3pwAA36

From: Yuan Chen <chenyuan@kylinos.cn>

do_batch() checks errno after the read loop to detect read failures,
but fgets() does not clear errno on success, so a stale errno left by
a previously executed command (e.g. map dump's EBADF from a double
close) makes bpftool report a batch file read failure and exit with an
error even though every command succeeded. Use ferror() instead, and
track the too-long-line case explicitly.

Since do_batch() no longer inspects errno to detect read failures, drop
the USE_LIBCAP errno reset in main() that existed only to keep errno
clean for the batch mode.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/main.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index c91e1a6e1a1e..0bbb2e198450 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -336,6 +336,7 @@ static int do_batch(int argc, char **argv)
 	char buf[BATCH_LINE_LEN_MAX], contline[BATCH_LINE_LEN_MAX];
 	char *n_argv[BATCH_ARG_NB_MAX];
 	unsigned int lines = 0;
+	bool line_too_long = false;
 	int n_argc;
 	FILE *fp;
 	char *cp;
@@ -371,7 +372,7 @@ static int do_batch(int argc, char **argv)
 			*cp = '\0';
 
 		if (strlen(buf) == sizeof(buf) - 1) {
-			errno = E2BIG;
+			line_too_long = true;
 			break;
 		}
 
@@ -429,7 +430,10 @@ static int do_batch(int argc, char **argv)
 		lines++;
 	}
 
-	if (errno && errno != ENOENT) {
+	if (line_too_long) {
+		p_err("reading batch file failed: %s", strerror(E2BIG));
+		err = -1;
+	} else if (ferror(fp)) {
 		p_err("reading batch file failed: %s", strerror(errno));
 		err = -1;
 	} else {
@@ -467,16 +471,6 @@ int main(int argc, char **argv)
 
 	setlinebuf(stdout);
 
-#ifdef USE_LIBCAP
-	/* Libcap < 2.63 hooks before main() to compute the number of
-	 * capabilities of the running kernel, and doing so it calls prctl()
-	 * which may fail and set errno to non-zero.
-	 * Let's reset errno to make sure this does not interfere with the
-	 * batch mode.
-	 */
-	errno = 0;
-#endif
-
 	last_do_help = do_help;
 	pretty_output = false;
 	json_output = false;
-- 
2.54.0

