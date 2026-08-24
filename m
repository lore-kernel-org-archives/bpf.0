Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597B3AA1AE
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563670; cv=none; b=sGnyiuXFD8R+oEo3lo75eUPdPpzqIAo4Fah5LqBKML+4fMX/9nx9sP94/yQzVbbeBOgBuXfqdUDoOssa4CssMpLHWB1zIkFUJhk+ekWFfBBrGrD75YTTUsCAlcsk/2E2Q1CHQJXeEGbgaCzV3rwcDlZTRGHVmLSS1qCDZVn1yPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563670; c=relaxed/simple;
	bh=b8c90bQ5IuzmbuETCFUyRxOWxnMsO2JzV8ZNIHaWVrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbAPZJhQLdcTsisCz0JhUhkz2iuMK1JkRKrSBntEUD2t+2t+uxgT8MeYtiwqNB37M2AUr1/9BldL1lpVusg+7nfWf3SFB/iDDvg/9fRtWqCyKPYzL+D8K+IuP0lANA0yapqlY6+G8IwGbnJtGgqFcsZwPtY+F2vjYJyTZ55Ns40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ka4U3QiU; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ka4U3QiU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=YA
	NqfUF8OFWxPoxfMiNHwPdTZU3p5myZC1ve7chaWG4=; b=Ka4U3QiUg/PufHSaIF
	7PpuCQgjYu5cPtwt2r/oA20Wqe9rnmGuetAU68EG3d26Ij8cqV3FcAZyXJsRedYZ
	cK95N6ez+Nzdk45TXeLKQaw8oozYIy2IpN6v9ppDbW/AgaVlebS3YOAUVakGuA1/
	SN2PmZ5WfxgFDcB1chSsMVZys=
Received: from nec8-i7 (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB3Kd9sDoxq8J3wNw--.45458S4;
	Mon, 24 Aug 2026 17:27:12 +0800 (CST)
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
Subject: [PATCH bpf-next v6 2/2] bpftool: Fix bypass of the batch line length check by comments
Date: Mon, 24 Aug 2026 17:26:57 +0800
Message-ID: <20260824092657.1789956-3-chenyuan_fl@163.com>
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
X-CM-TRANSID:PygvCgB3Kd9sDoxq8J3wNw--.45458S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww47CF47KFWUAF4UJFW3GFg_yoW8uw1fpF
	Z5Kw17tFZ7W34FvryxCFWrXFZ5W3s3ta1DWr4UGa9YvF4kWFs3KrW7Kr9Ygw15XrsavFyU
	Jr1S9F1kWrnruF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMxR6UUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5RBdG2qMDnCAEwAA34

do_batch() strips trailing comments by truncating the line at '#'
before checking whether fgets() filled the buffer. If a batch line
longer than the buffer contains a '#' within the first
sizeof(buf) - 1 bytes, the truncation makes strlen(buf) smaller and the
line-length check is bypassed. The unread remainder of the line then
stays in the file stream and is parsed and executed as a separate
command on the next loop iteration.

Continuation lines handled below are affected the same way: an overlong
continuation line containing '#' bypasses the "command is too long"
check, and its unread remainder is executed as a separate command.

Move the line-length checks before the comment is stripped, so they see
the full line as read from the file and overlong lines are rejected
regardless of comments. A line that fills the buffer exactly is now
rejected as well, which is fine: batch command lines are not expected
to come anywhere near the buffer limit.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
v6: move the line-length checks before comment stripping instead of
    detecting truncated reads with memchr()/feof(), as suggested by
    Andrii Nakryiko

 tools/bpf/bpftool/main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 7a0c214f08a0..5ababd8f7d0a 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -370,15 +370,15 @@
 		if (!fgets(buf, sizeof(buf), fp))
 			break;
 
-		cp = strchr(buf, '#');
-		if (cp)
-			*cp = '\0';
-
 		if (strlen(buf) == sizeof(buf) - 1) {
 			errno = E2BIG;
 			break;
 		}
 
+		cp = strchr(buf, '#');
+		if (cp)
+			*cp = '\0';
+
 		/* Append continuation lines if any (coming after a line ending
 		 * with '\' in the batch file).
 		 */
@@ -391,15 +391,15 @@
 				goto err_close;
 			}
 
-			cp = strchr(contline, '#');
-			if (cp)
-				*cp = '\0';
-
 			if (strlen(buf) + strlen(contline) + 1 > sizeof(buf)) {
 				p_err("command %u is too long", lines);
 				err = -1;
 				goto err_close;
 			}
+
+			cp = strchr(contline, '#');
+			if (cp)
+				*cp = '\0';
 			buf[strlen(buf) - 2] = '\0';
 			strcat(buf, contline);
 		}
-- 
2.43.0

