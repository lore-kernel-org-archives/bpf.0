Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3798373BF2
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563668; cv=none; b=INq2pykoCBmy0oTa6JhwVYtmcJaZom0/a0uNKc97//QDTm+uVU63HR97Q73EMjcHbUCjq7YxUM3D/4+LgYdBsBffSDnWaJwB8k8tIU1KPLHyiME8rb5RIslEph3I2WybNI/wJSeLQxctRJ3452o1kACDX+9bNMp2v2QPj+z/O6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563668; c=relaxed/simple;
	bh=tVu4r/4x7IbA2VH4N262G4JpEbygb/d/IigRoMPFvD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYRdylztsO0FWbapBDpBCbkx1B+NXpYxLV3WPwLBio3NWh/fTJfnxNbzG+XG7zWIC7aERSusni+j+Lbw1WFfkhsfArQBLZvmrOQ7BgZVFNgpQTSj81KnSmGsgELlg81JoSl+AqP5PJ5fh/L1R9jGN8+8H/yNIZZJAwbQUe5XtH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LfCk+bCk; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LfCk+bCk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mU
	2XjzNeumue/4DBlIEID38U3nPgw1tydSOIERbyM+8=; b=LfCk+bCknC0l8ACj3Q
	2hq7P/9JZZhkBP/eaQ2LrpPNM1SfThaqezR5eYYJoESD+q+lmMVV+mbr7LeAMbmj
	yviuxca3EGZjAp70MHi2ShOpnYuU3v5WUg/U0UVjwGM+JMrHwmdZvoc5OkQEhpqz
	bjKNdCRf4faUaJb9vDyYEjtlk=
Received: from nec8-i7 (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB3Kd9sDoxq8J3wNw--.45458S3;
	Mon, 24 Aug 2026 17:27:11 +0800 (CST)
From: Yuan Chen <chenyuan_fl@163.com>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Yuan Chen <chenyuan_fl@163.com>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v6 1/2] bpftool: fix spurious batch file read error
Date: Mon, 24 Aug 2026 17:26:56 +0800
Message-ID: <20260824092657.1789956-2-chenyuan_fl@163.com>
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
X-CM-TRANSID:PygvCgB3Kd9sDoxq8J3wNw--.45458S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw4rurWrZryfZw4rWFWUtwb_yoW8CF45pF
	Zxtry3trW8X34rZrWxGF4FqFy5Jr9ayrWDXr48GayYvr15Zr1SqrWxKas5Wa43Z34fAa4U
	ZF1S9aykZF9rXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zKQ6dbUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQ9cGmqMDm9SkQAA3M

do_batch() checks errno after the read loop to detect read failures,
but fgets() does not clear errno on success, so a stale errno left by
a previously executed command (e.g. map dump's EBADF from a double
close) makes bpftool report a batch file read failure and exit with an
error even though every command succeeded.

Clear errno before each fgets() call, so the post-loop check only
sees the outcome of the last read: zero on success or EOF, E2BIG for
an overlong line, and a genuine errno when fgets() fails.

Since errno is now reset before every read in batch mode, drop the
USE_LIBCAP errno reset in main() that existed only to keep errno clean
for the batch mode.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
v6: clear errno before each fgets() call instead of tracking the
    too-long-line case with an explicit flag and checking ferror(), as
    suggested by Andrii Nakryiko

 tools/bpf/bpftool/main.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index c91e1a6e1a1e..7a0c214f08a0 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -365,7 +365,11 @@
 
 	if (json_output)
 		jsonw_start_array(json_wtr);
-	while (fgets(buf, sizeof(buf), fp)) {
+	for (;;) {
+		errno = 0;
+		if (!fgets(buf, sizeof(buf), fp))
+			break;
+
 		cp = strchr(buf, '#');
 		if (cp)
 			*cp = '\0';
@@ -467,16 +471,6 @@
 
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
2.43.0

