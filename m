Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D936B90C
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786347294; cv=none; b=AzxwWLONfd3SHBw2nnTUahBrwix6VHHJx6m1pFmNhsmuimWucmRUDgSVY/9387Db8XrEKIzARIbenaCrAZ8lQHdeg+7elL1djNgqDed+olzieE6f1miuRa29PC/ZRlSvuB9hEXJDlmq5lNNAXUdnk2ZhlT0mFeME5yvhzR8NPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786347294; c=relaxed/simple;
	bh=cAydsrJxG+jI5SiBsSHMDzDYKdxMUmZstWjlpcXVf7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxscuqgSAF4HepkLKN3XwWRkRd3gCTrcceFbxxE4MGzsP03Lqx4R28igxMd6zL04cwykU0nodmd3NZ5zPW/WIVHUyWZ1FsChyiQg2OkZ1xXSShODdO+SINdyqFzQnlQUSWrCs9//cs2k+fxhWhTIXGUdT03ahPRhGaLYkrb1pTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VTmNvID4; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VTmNvID4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5K
	wgNv4/1IVca+d5VBVq/D8VL1huB2s98B2LdyLJUTs=; b=VTmNvID4P7xqJtz26W
	jsUv2+BESu2CJJrzlWkZwZToaYsefT6md4P25XifLAAt4Zjw75JMza2RHLkdMHls
	RI8XEuTMx+rpyjojqEUNxmlr1F5ReGMR7y5PYg6wbJw4cZ6XnTQmoeEPX58A9G/r
	l/jkuB7KgawdcpwOOHymiMtKw=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnDk_mfnlqA1WHOw--.8184S5;
	Mon, 10 Aug 2026 15:34:10 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v3 3/3] bpftool: Fix bypass of the batch line length check by comments
Date: Mon, 10 Aug 2026 15:33:48 +0800
Message-ID: <20260810073348.2586225-4-chenyuan_fl@163.com>
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
X-CM-TRANSID:_____wDnDk_mfnlqA1WHOw--.8184S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww47CF47KFWUAF4UJr47urg_yoW8GF1fpa
	98Ka48tFZFgw1YvryxCa1rWFWfWrs3JrZrCr4UG3yYvr1kWrnavry7KF90gw15Xr4Svr4j
	yryS9FZ3Zr4kuF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jldgJUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDARLUkmp5fvJD7QAA3k

From: Yuan Chen <chenyuan@kylinos.cn>

do_batch() strips trailing comments by truncating the line at '#'
before checking whether fgets() filled the buffer. If a batch line
longer than the buffer contains a '#' within the first
sizeof(buf) - 1 bytes, the truncation makes strlen(buf) smaller and the
line-length check is bypassed. The unread remainder of the line then
stays in the file stream and is parsed and executed as a separate
command on the next loop iteration.

Record whether fgets() truncated the line before stripping the comment,
and use that for the line-length check, so overlong lines are rejected
with E2BIG regardless of comments.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index c9a86039c400..c77e66bffbc9 100644
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
-- 
2.54.0

