Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249B03AAF45
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786352756; cv=none; b=gxIyASIra6H6KgJw/ECHdnC99EitGO3ZpAYYALlBS3XEe9uGM/HmRYSCWu0u+0nnU05RJgTTXTxdVANZAQsX2rPtVc9w4AcZXqgxsguRpGmv2mtw5stFOBHiA6jaa6YxlZDQ2vwxohi/H6PkNl5aBgHKjrQ+ofDozVaVF58tkmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786352756; c=relaxed/simple;
	bh=IE1++EMItDbe4o9Ydl5Iz1t0Ffg5QcNVcIAOd09kCnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJUjdXalq1zfm2LOepoaVe/DhQCGSdR6ZHKIFQ6Bn+t+sWpwguLcOWao8/D6LJDL/IyBSlJCq+H1PJAb8k4tVqit3F/+GZDRh1jjhoU2GheXheLHb/Ox9eOJv7FweNX/vHqjYqIengvAKi3H0PM6XHcDF+jB/445I3A9HT1rbS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g1kLRmkt; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g1kLRmkt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=CT
	gWTAKgdKI8Y7UGX7h4TmLE+wqaJQ9tHq4Pkxh0/9g=; b=g1kLRmktT1mqbKxAts
	0ynSnhQMPO64xO8+8csdzRUSBJAytjn4o6jgAYmNVWRqPvFolTwgzq1bVi35Mf4P
	eUrdeJRHR0nSKi9UuCfqJn+WgK9ZQsebokMS1+LAHePXgB534stj8MBIIFOF0jXF
	ktuK/shVflfK6Z0tQIxpub9ts=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wB3fphFlHlq933IOQ--.8396S4;
	Mon, 10 Aug 2026 17:05:14 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v4 2/3] bpftool: fix spurious batch file read error
Date: Mon, 10 Aug 2026 17:04:58 +0800
Message-ID: <20260810090459.2666243-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810090459.2666243-1-chenyuan_fl@163.com>
References: <20260810090459.2666243-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3fphFlHlq933IOQ--.8396S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4rWrykury3Xw17Gw1UAwb_yoW8tr1UpF
	ZxJr9xtrW8XrWFyFWxArW5uFyrWrZ3trZxuan3Kw4YyF15Gr1aqr48KFyrXFy7XrWSya1U
	tFnI9FZ5Z3WDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfAwxUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQow7Wp5lErnHAAA3g

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

