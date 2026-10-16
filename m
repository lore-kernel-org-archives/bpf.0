Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC6833688A;
	Fri, 16 Oct 2026 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792115515; cv=none; b=HumAt4DkX56oN3nMeRwbCCuVoBY+6Skw5G7V/tbhGN+rjxvlpDQem/zx/UzkalVevDO5JFGq2L94KAczjsz5bUfpbxCDaatRt6EGDIk8tTyHY0JJlCiBUOCrtSGNSxn9f/Z/Vj6gp4H8h6WbAU29lia22Bayb6PIC95IpC4bl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792115515; c=relaxed/simple;
	bh=BKJENa/Afb35SFjH+QDUfboiPYpG4nD30UBNwpk6XcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKmvmI+MMrx0XrDRZsoL0/K6fsQv2fORs0bO/pSWDqyFV9d/xG02BTa6wjYj4gScFIB4l63cPEOkX8PBjaKAxPZRShMvIQiAIxoVL8CAtO4gG4q++Bg/jjIOUVec4sAD/6mJ+Et9RWpXKOqMpu0DvSWdS6bZadONpp236obFVwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RENH57Ri; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RENH57Ri"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=IO
	fCfowZvlKQd9kiCs1X/5e0m9ryQAG68JY8hobuzU8=; b=RENH57RiqlIbLG7r3F
	g2N6qlDZYvIDm8IfLBj4w87nV6PrFfA127vgo55civEUh+A38z5B32veS8ZLuiAH
	ggXpLAGgIbR+XfhhaDf0vofD5JkX3n61U1xrQAH7TKb3ZXtgkKrmorXjBQPfMniW
	EPxpBmAc2kE0fbKKlHrXOFnc4=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD334kKg9Fq5xKnAQ--.14590S2;
	Fri, 16 Oct 2026 09:51:07 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Yuan Chen <chenyuan@kylinos.cn>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpftool: Fix inverted tracefs validation when scanning /proc/mounts
Date: Fri, 16 Oct 2026 09:50:57 +0800
Message-ID: <20261016015057.127061-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD334kKg9Fq5xKnAQ--.14590S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4kZw18Kw17Jry8GF4Uurg_yoWDtFc_Ka
	yUXa1kXFsxGF9F9rsakrWUW34FyFZ8Xr4DCr18JFy5KrWUJa93KFnY93yUXF98X34qqF9a
	ga4xXw1rJr4ftjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ma0PUUUUU==
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQvxr2rRgwtpcwAA39

From: Yuan Chen <chenyuan@kylinos.cn>

The /proc/mounts fallback in get_tracefs_pipe() accepts only
non-tracefs mount points, so a tracefs mounted outside the default
locations is ignored: bpftool prog tracelog then mounts a second
tracefs, or exits silently with --nomount. Negate the condition.

Fixes: be3245e22d22 ("tools: bpftool: attempt to mount tracefs if required for tracelog cmd")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/tracelog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/tracelog.c b/tools/bpf/bpftool/tracelog.c
index 573a8d99f009..e104748c8350 100644
--- a/tools/bpf/bpftool/tracelog.c
+++ b/tools/bpf/bpftool/tracelog.c
@@ -86,7 +86,7 @@ static bool get_tracefs_pipe(char *mnt)
 	fclose(fp);
 
 	/* The string from fscanf() might be truncated, check mnt is valid */
-	if (found && validate_tracefs_mnt(mnt, TRACEFS_MAGIC))
+	if (found && !validate_tracefs_mnt(mnt, TRACEFS_MAGIC))
 		goto exit_found;
 
 	if (block_mount)
-- 
2.54.0

