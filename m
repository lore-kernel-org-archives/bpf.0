Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40FD25392C
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786347285; cv=none; b=NgcpYpBWNWNHnjhqzQBIHeEEE2Wdgzjur+0H2QKCUR17a3AgLdQzGyUuNHOe3JHGhk6EKNvC2CiGUOohazEAOlHE+TSEAidk3kuTOVPg6Ej/pjrRqknBFlLLIh+98VdKONYF4S3vCgiadLVC0nKcjUhjVgIHswkf5Waz+bR56nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786347285; c=relaxed/simple;
	bh=ZofdUzCemN8x1UmAUQA5Wk8TnN+hpMnDIFPBq798mVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcnewKE/YCDWgtQOdy69HmuZi3BBetWC8leJxbxXCJz3G8nql+E5tpRc+YlMgAYHBxZS0dqUWl3tDNhiDw6+2SNsBtP14luAr3wwUK6RDgvd267dmmvoOoOisqyafTUcEuCjFZMuI87QpDxnA/MPXugbNtyL3CrkBvtPSs2PuAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KjaKGpfl; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KjaKGpfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2Q
	Km1iCpOCV6YF7Ds/LwuSwdoVQFCnNf1q/Yvs+XSyM=; b=KjaKGpfl+AvcxI9DHB
	xF+K0tZtg+gfOBN0csHtL05HOGrHt4q5PiXM3SvkD0ng+pjQDSrYIF1sqQXrfIGW
	23jpyTPcHeOM7pnpH8SnqrVa2dTJrh5xYqMEvssR6afNyFIrHwCsDnogoSDGridc
	9hByw1+bv6WtVoPpX1Fv8Nmzg=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnDk_mfnlqA1WHOw--.8184S4;
	Mon, 10 Aug 2026 15:34:09 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v3 2/3] bpftool: fix spurious batch file read error
Date: Mon, 10 Aug 2026 15:33:47 +0800
Message-ID: <20260810073348.2586225-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810073348.2586225-1-chenyuan_fl@163.com>
References: <20260810073348.2586225-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnDk_mfnlqA1WHOw--.8184S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4rWrW8JryUXryxJry7Jrb_yoW8Xw1UpF
	WDGryDtrW8XrWayFWxArZ8WFy5Wrs3KrZ7Zan3K3y5ZF1rGr9IqFW8KFnYqry2grWSya1U
	tr9I9FZ5ZFn7ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfAwxUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5RHUkmp5fvGk6AAA3i

From: Yuan Chen <chenyuan@kylinos.cn>

do_batch() checks errno after the read loop to detect read failures,
but fgets() does not clear errno on success, so a stale errno left by
a previously executed command (e.g. map dump's EBADF from a double
close) makes bpftool report a batch file read failure and exit with an
error even though every command succeeded. Use ferror() instead, and
track the too-long-line case explicitly.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index c91e1a6e1a1e..c9a86039c400 100644
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
-- 
2.54.0

