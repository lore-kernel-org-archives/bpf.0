Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B0E421EF8;
	Fri, 16 Oct 2026 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135129; cv=none; b=KzbJEsjS+/6cnaIjg3oJgEB8Kt9BBQzzsWm05QEaApoqjNrSaH407d23LQtm+h3X7rVsNgQAy7nA4mHlBCHxeKVYjQvYBc1MLCj7djHqXJ3rEznEW138L6Jlq2ZUWWEEwlLpWeU+vn+WDKB6HXH/mA0VxnZvYogXyEgQ0cfCY7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135129; c=relaxed/simple;
	bh=fx08jF1lGfBNxGHEObrn2q0urJVBldjrOMSeT87Twr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M29D7n84roA28fTtm2+VcZyBu17qwBMW91zeC/XMRwbqboBhhHebwX0DIhodw9NdkRhbptOzNe+yWoG5zHxpZ6KAtAx+PZvfMPVzNURbAkieioxjh/oIy+rdr/R+Ouajc8AIyzmSQyosilCxGiYYUeTg7D2HnX0csT6rZSKXUOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UeyY4PYD; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UeyY4PYD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=JP
	QpWeMISzrIunZ01qWhJTq/db8MK1NfPuxvC7OhWBo=; b=UeyY4PYDwnv6JCDgC1
	0kVwaZxiIA1QKKcYpxJc29SBQmAwoLzzXVUAT57wOPO24u514YiAP2RRxlveUAdF
	oe0QamVdR6Rw2JzalM4asbKQ7TMN+RGaKJkBGln5iE8rPwAw9KJzXKlqVZERbYKQ
	T3TYwCp9h2koLFriKxCzYpRic=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3jyaFz9FqVrDQAQ--.5020S2;
	Fri, 16 Oct 2026 15:17:29 +0800 (CST)
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
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next] bpftool: Print verified instruction count in prog show
Date: Fri, 16 Oct 2026 15:16:57 +0800
Message-ID: <20261016071700.280539-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3jyaFz9FqVrDQAQ--.5020S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF48WrW8KFyDurWrtw4rGrg_yoW5Gry3pa
	15JF97C3yUXw1rGw1kCFs5ZrW3Ga1Igwn7JF4xArW8XFn5Jrsaqry3KF4FvFn8XF1fta4r
	Z3yS9rW5tF1xZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jShFxUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAgkl4mrRz4kQFQAA30

From: Yuan Chen <chenyuan@kylinos.cn>

The number of instructions processed by the verifier is available
through bpf_prog_info::verified_insns and the program's fdinfo since
commit aba64c7da983 ("bpf: Add verified_insns to bpf_prog_info and
fdinfo"), but bpftool does not display it, leaving no convenient way
to check a program's verifier cost.

Print the count in the plain and JSON output of bpftool prog show,
following the convention of the other conditional stats
(run_time_ns, run_cnt, recursion_misses): kernels that do not fill
the field leave it zeroed and nothing is printed.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 3 ++-
 tools/bpf/bpftool/prog.c                         | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 8dbd34ef3d8b..d4a94e0737a9 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -285,7 +285,7 @@ EXAMPLES
 
 ::
 
-    10: xdp  name some_prog  tag 005a3d2123620c8b  gpl run_time_ns 81632 run_cnt 10
+    10: xdp  name some_prog  tag 005a3d2123620c8b  gpl run_time_ns 81632 run_cnt 10 verified_insns 528
             loaded_at 2017-09-29T20:11:00+0000  uid 0
             xlated 528B  jited 370B  memlock 4096B  map_ids 10
             pids systemd(1)
@@ -301,6 +301,7 @@ EXAMPLES
             "gpl_compatible": true,
             "run_time_ns": 81632,
             "run_cnt": 10,
+            "verified_insns": 528,
             "loaded_at": 1506715860,
             "uid": 0,
             "bytes_xlated": 528,
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index eb077236d2ea..c77e871b8859 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -441,6 +441,8 @@ static void print_prog_header_json(struct bpf_prog_info *info, int fd)
 	}
 	if (info->recursion_misses)
 		jsonw_uint_field(json_wtr, "recursion_misses", info->recursion_misses);
+	if (info->verified_insns)
+		jsonw_uint_field(json_wtr, "verified_insns", info->verified_insns);
 }
 
 static void print_prog_json(struct bpf_prog_info *info, int fd, bool orphaned)
@@ -526,6 +528,8 @@ static void print_prog_header_plain(struct bpf_prog_info *info, int fd)
 		       info->run_time_ns, info->run_cnt);
 	if (info->recursion_misses)
 		printf(" recursion_misses %llu", info->recursion_misses);
+	if (info->verified_insns)
+		printf(" verified_insns %u", info->verified_insns);
 	printf("\n");
 }
 
-- 
2.54.0

