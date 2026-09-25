Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBE71922FD;
	Fri, 25 Sep 2026 04:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790310955; cv=none; b=jOtSZoFLSS6B/aUYFpgW6ZfTw/bORnwgFHSzGcUkVJX+HpPMduJY9Mk+Ye+dvedlq09peK9wMaZ4W0AogY0tZEqPEDUOqbLvJYxnSDsmImDovrRQYFwdkfPu53FvkJTew4L8yGqZ6FQecBRr51+XOMuDSUJeV8nFoMCIF/I3Gug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790310955; c=relaxed/simple;
	bh=5R/00RgV2CHP3vBjYoIYpHO3TakxBiNZ9JgtvqzTPYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxPGde7a/SAH7+fLhHSkUPDGq7x4G+YKJv1cKEb6nvUFi8v4DLU1/hteEFJbs4lwqDxh9crmrGjReAHyVXEz2y94VxuF0tsZFoz7/JqWQu/ZOkio+GylxEDlFwQqx5X8c8Q/QwZZEGhi7n4X678gpDiwPBx8R/R7iaZCJ3We1Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YpcBVlKO; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YpcBVlKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6S
	R9jQCvbn4qzh5twTIN9Zz5Q8q2WS36fgkLBJ4vwO8=; b=YpcBVlKODdBzwDoVR8
	qFub1QQg+cUqq/0janXB6ENoO84mV5FWbHtOh3LxUEA8xoVrTn7VMItHSYj0uk1q
	+KZ/MFMu3RrtiJpBILnxzIrSV42Z4qpCf8iSieFwMNX4PQtJvTgJbZriWdNphPuO
	oh/fv4AHGhETjWyKvxXl3JBQo=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3__T7+bVqQ0LEAg--.64744S2;
	Fri, 25 Sep 2026 12:35:09 +0800 (CST)
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
Subject: [PATCH bpf-next] bpf: Roll back freplace link state when bpf_arch_text_poke() fails
Date: Fri, 25 Sep 2026 12:35:00 +0800
Message-ID: <20260925043500.28030-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <4669addf.91e8.1a0d2da9b9c.Coremail.chenyuan_fl@163.com>
References: <4669addf.91e8.1a0d2da9b9c.Coremail.chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3__T7+bVqQ0LEAg--.64744S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF47WF4xZryfJw4Duw1ftFb_yoW8Aw45pF
	y7JF9xCr4DX34qq34vvw18WFWY93WkWw4xGrWjg397CFs3XrZ5Wry0gwnIvFyFgrs5u3WI
	qF4a9rn09r17WFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn8n5UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAh3Fg2q1+f3OaAAA3k

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
Suggested-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/trampoline.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

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
-- 
2.54.0

