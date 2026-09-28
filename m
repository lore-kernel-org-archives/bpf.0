Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD53C4908DB;
	Mon, 28 Sep 2026 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586735; cv=none; b=fBx7Fdj4SRWN3txp810SyHdccu0BFzGx24Z9tc3flVmXp5khcT28c0SvMAqIgmyXUHEpqMgRwr963pVw7Yww7SfGFHWuUss1rBK8IPKMuWPROOgYdow5avphxNW2TG4lq8Ro/DBDlKCjnx1PYP1oYbBTSn4kq1wMh0/4UlZxwKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586735; c=relaxed/simple;
	bh=oWDsKPqdVG6HI+vqmVYue8J1RAxym1CioagqYk1d3u8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=os+yRT9U7ivTaESQomHeG+fgYZlJTKAKgdKUCXEk7jVxU16dMuH2DxK0JqCa6EpA89y3WYCf2tRQI+DWseIEH7ZEAxrpDzL7JayyocUAf9T4WEFtnQ3RoGGeMvwwIcnfq2xM5bG7M4IufAZu09GqibH89EasrIbqc2+CCHUNEds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LakdI4sa; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LakdI4sa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=xs
	y8W+bzuVW+Jy66wmLJR6wyBP8aBExoTzzBMEK5CKY=; b=LakdI4saXmS0VxwGGL
	PDAEZZVV5JRJ+Tzuvay+gxEeQDd2jgwB1telkaWcU46n1xrgsXE2Q8WND7zbKoFK
	51YMZFHmWQ8GRI9K6GL8UDLrMCgZ4bvKz3Kz9TLOoGVK2jSraxC2pKjGepK/+sbN
	Blr3ewnz1f7xaR7XhYjIR7REM=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3F0lDL7pql9AwBQ--.62771S2;
	Mon, 28 Sep 2026 17:11:31 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	jolsa@kernel.org,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [bpf-next v2] bpf: Roll back freplace link state when bpf_arch_text_poke() fails
Date: Mon, 28 Sep 2026 17:11:21 +0800
Message-ID: <20260928091121.219333-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3F0lDL7pql9AwBQ--.62771S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF47WF4xZryfJw4DKF18AFb_yoW8urW7pF
	y7GF9xCr4qq34qq34vvw1xWFW09w1DWw4xGryjg397uFyfJrWrWry0gwnIvF9Igrs8W3WI
	vw4a9F909r17Wa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnb18UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAgMl4mq6L0OK0gAA3i

From: Yuan Chen <chenyuan@kylinos.cn>

A freplace attach claims the target prog by bumping
tgt_prog->aux->freplace_link_cnt and setting tr->extension_prog.
bpf_arch_text_poke() then makes the extension take effect.  If the
poke fails, the claims are never released: the attach unwinds
through bpf_link_cleanup(), which clears link->prog, so
bpf_trampoline_unlink_prog() never runs.

Drop the link count under ext_mutex on the error path, and set
tr->extension_prog only after the poke succeeded.  The count is
still bumped before the poke: it blocks prog_array updates while
the entry is patched.

Fixes: d6083f040d5d ("bpf: Prevent tailcall infinite loop caused by freplace")
Fixes: be8704ff07d2 ("bpf: Introduce dynamic program extensions")
Suggested-by: Leon Hwang <leon.hwang@linux.dev>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/trampoline.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

Changes in v2:
- Add Fixes tag for tr->extension_prog, whose assignment before the
  poke dates back to be8704ff07d2, as suggested by Leon Hwang.
- Collect Acked-by from Leon Hwang.

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index da85bd580ef0..bf4ab0ac264e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -973,10 +973,17 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 		err = bpf_freplace_link_tgt_prog(tgt_prog);
 		if (err)
 			return err;
+		err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_NOP,
+					 BPF_MOD_JUMP, NULL,
+					 node->link->prog->bpf_func);
+		if (err) {
+			/* Undo the claim from bpf_freplace_link_tgt_prog(). */
+			guard(mutex)(&tgt_prog->aux->ext_mutex);
+			tgt_prog->aux->freplace_link_cnt--;
+			return err;
+		}
 		tr->extension_prog = node->link->prog;
-		return bpf_arch_text_poke(tr->func.addr, BPF_MOD_NOP,
-					  BPF_MOD_JUMP, NULL,
-					  node->link->prog->bpf_func);
+		return 0;
 	}
 	err = bpf_trampoline_add_prog(tr, node, cnt);
 	if (err)

