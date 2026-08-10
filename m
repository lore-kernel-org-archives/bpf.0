Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886493E316C
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371811; cv=none; b=C8hDMUvKUeP9uSL87g2E0FIC/zZG/EOIl+W8CNQVASjTmyDYXELuXGZ/cBJAjz9nkwswJbsm40hBjnXakof/ZoaaukU+AxtHGHz4zR5BrnFiEKbtt0nuDJUuvcNRwuPx9hZLNhMDbJy0Bd4lR+OmeQRDTs8xq8bJIU1cMatjJt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371811; c=relaxed/simple;
	bh=O9oZ51Q4sLgBFxUKWbEoOuMEsaveAbROHy34DCAMMEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7FTefU/Pnm+p9NRnqCBxQ0SBAjMJDuMXtvVuBkXxlC69SevB+RuRtXDTGTvZFYr5UW76sGNgZ0Hm389W8oFls0CwMTvMXbUqa6fK9AgDlEFFu3szhEhA8+5pCcIPTMT3SkErvv8CCuUSh0pv1whza8GI6mxcTb6PDEN91A8MRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UuwqUfl7; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UuwqUfl7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mq
	ZK8qEmTHJ67uHJuEueZxzaa76BY3Ycbp3O1TF7NRE=; b=UuwqUfl7XRO/CjVz0P
	QRYeLQRfx7CwOh02+XextjPjh3M2NNo8EDyD59ZnVUVqjKZ/yOuh/xd7C7VXwXx2
	qE3fy6PMYgClGL39jIOj6c/iK+yeW2l24WxwzoiDzragzNMA78nVeE+bvPJafJge
	virkikgWQiGclDM0E/vgFBMyM=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3n9ip3nlq3APzNA--.8292S5;
	Mon, 10 Aug 2026 22:22:42 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v5 3/3] bpftool: Fix bypass of the batch line length check by comments
Date: Mon, 10 Aug 2026 22:22:24 +0800
Message-ID: <20260810142224.2907373-4-chenyuan_fl@163.com>
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
X-CM-TRANSID:_____wD3n9ip3nlq3APzNA--.8292S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrWDKF4kJF4fGrWDKFykZrb_yoW5ArWrpF
	s8Ka43trsrW343ZryxCF4rWFWfuws7tFyUCr47K3yrAF4DWrnIyrW7KF9Y9w4UZrWfZ3WU
	Jr9I9F4kurs8AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jlZX5UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5RPcmmp53rM17QAA3W

From: Yuan Chen <chenyuan@kylinos.cn>

do_batch() strips trailing comments by truncating the line at '#'
before checking whether fgets() filled the buffer. If a batch line
longer than the buffer contains a '#' within the first
sizeof(buf) - 1 bytes, the truncation makes strlen(buf) smaller and the
line-length check is bypassed. The unread remainder of the line then
stays in the file stream and is parsed and executed as a separate
command on the next loop iteration.

Continuation lines handled below are affected the same way: an overlong
continuation line containing '#' bypasses the "command is too
long" check, and its unread remainder is executed as a separate command.

Detect the truncated read before stripping the comment, using memchr()
to look for a newline (instead of strlen(), which is also fooled by an
embedded NUL byte) and feof() to tell an overlong line apart from a
final line without a trailing newline. A line that fills the buffer
exactly (the byte after the read is a newline) is not treated as
truncated, so valid maximal-length lines are no longer rejected. Use the
result for the line-length checks, so overlong lines are rejected
regardless of comments or NUL bytes.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/main.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 0bbb2e198450..337fbf1ec596 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -367,11 +367,27 @@ static int do_batch(int argc, char **argv)
 	if (json_output)
 		jsonw_start_array(json_wtr);
 	while (fgets(buf, sizeof(buf), fp)) {
+		bool truncated = !memchr(buf, '\n', sizeof(buf) - 1) && !feof(fp);
+
+		if (truncated) {
+			/*
+			 * fgets() filled the buffer. If the very next byte is
+			 * a newline, the line fits the buffer exactly and is
+			 * not truncated.
+			 */
+			int c = fgetc(fp);
+
+			if (c == '\n')
+				truncated = false;
+			else if (c != EOF)
+				ungetc(c, fp);
+		}
+
 		cp = strchr(buf, '#');
 		if (cp)
 			*cp = '\0';
 
-		if (strlen(buf) == sizeof(buf) - 1) {
+		if (truncated) {
 			line_too_long = true;
 			break;
 		}
@@ -380,6 +396,8 @@ static int do_batch(int argc, char **argv)
 		 * with '\' in the batch file).
 		 */
 		while ((cp = strstr(buf, "\\\n")) != NULL) {
+			bool cont_truncated;
+
 			if (!fgets(contline, sizeof(contline), fp) ||
 			    strlen(contline) == 0) {
 				p_err("missing continuation line on command %u",
@@ -388,11 +406,15 @@ static int do_batch(int argc, char **argv)
 				goto err_close;
 			}
 
+			cont_truncated = !memchr(contline, '\n', sizeof(contline) - 1) &&
+					 !feof(fp);
+
 			cp = strchr(contline, '#');
 			if (cp)
 				*cp = '\0';
 
-			if (strlen(buf) + strlen(contline) + 1 > sizeof(buf)) {
+			if (cont_truncated ||
+			    strlen(buf) + strlen(contline) + 1 > sizeof(buf)) {
 				p_err("command %u is too long", lines);
 				err = -1;
 				goto err_close;
-- 
2.54.0

