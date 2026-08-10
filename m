Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B7F35B645
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786352749; cv=none; b=o3Nnlii2fPXaTdMXlXDpFmwARIEOwo3Gef2BniDurJ9xR8cSLbdWo4MnSWx+QsuDbEQi6OZr6gHaoJCbg11tjPQFwpCY+eCuOZYYT+mCmIKvxTcKEkmi3hSj66zosGhF9hOH8QW5+jpM5m0GmM5EyyE+/oKqsQ5J5/P8hfEK2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786352749; c=relaxed/simple;
	bh=xd9ifndo1JwICDYprlV416oYxlc2Pyks938k00dPVeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9DvDIIfqm0vpiyFVhi5HDubD4LGdxC0PAGiwhY4pF0POnIy779cwF/ZKoQMg6oI2CM9Z/1cB7pq5SSKL1LORk4gcYcBHoJNa2xhQ1fhTOZqkpsc6NlwgWfnKNzTLbZswotWUoNCK0OeBMpGNyMG3rJmT/Q5AoAzCu1eMG2EFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jxnLMNR9; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jxnLMNR9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Fd
	Y0tR7LUu4iboY65sE5brMxllYlyqTjk65sOVlpklk=; b=jxnLMNR9Jorm3zY62a
	HCzMtUPkg0O+uKAX/rYnkZhofrgJJibJtt15RjlLX6qUloFBXcOxmLJ4bwjdrNbL
	uNBCGcxoydki/ddFzc8KpW2AFukipz87z7iInLAFZ5DNmGGkXZx4+NoFkozkqUMY
	5mx0IzWzPj6gArL2i2cCqzosk=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wB3fphFlHlq933IOQ--.8396S5;
	Mon, 10 Aug 2026 17:05:15 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v4 3/3] bpftool: Fix bypass of the batch line length check by comments
Date: Mon, 10 Aug 2026 17:04:59 +0800
Message-ID: <20260810090459.2666243-4-chenyuan_fl@163.com>
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
X-CM-TRANSID:_____wB3fphFlHlq933IOQ--.8396S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww47CF47KFWUAF4UJFW3GFg_yoW8tw43pF
	s8Ka4rtFZrW34Yvr9rAF4kWFWrXws3tFWUCr47G3yvyF1DWrn3trW7Kr9Y9w1UXr4SvF1U
	Jr9I9F4kZrsrZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jlZX5UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5gsw7Wp5lEtSIwAA3N

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

Record whether fgets() truncated the line before stripping the comment,
and use that for the line-length checks, so overlong lines are rejected
regardless of comments.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 0bbb2e198450..cef779aa72fb 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -367,11 +367,13 @@ static int do_batch(int argc, char **argv)
 	if (json_output)
 		jsonw_start_array(json_wtr);
 	while (fgets(buf, sizeof(buf), fp)) {
+		bool truncated = strlen(buf) == sizeof(buf) - 1;
+
 		cp = strchr(buf, '#');
 		if (cp)
 			*cp = '\0';
 
-		if (strlen(buf) == sizeof(buf) - 1) {
+		if (truncated) {
 			line_too_long = true;
 			break;
 		}
@@ -380,6 +382,8 @@ static int do_batch(int argc, char **argv)
 		 * with '\' in the batch file).
 		 */
 		while ((cp = strstr(buf, "\\\n")) != NULL) {
+			bool cont_truncated;
+
 			if (!fgets(contline, sizeof(contline), fp) ||
 			    strlen(contline) == 0) {
 				p_err("missing continuation line on command %u",
@@ -388,11 +392,14 @@ static int do_batch(int argc, char **argv)
 				goto err_close;
 			}
 
+			cont_truncated = strlen(contline) == sizeof(contline) - 1;
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

