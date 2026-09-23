Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD147D925;
	Wed, 23 Sep 2026 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154462; cv=none; b=GfjxGW5CA2vaFIEMzFO352+rUaD8RbdZ/F6DDc8h3IFG3gXKmDYIAXYghyYdWDCgk4pzxMLVFbPXqp4VzqxnuAxmhpvj9cC23Fnyj/w4cjW5spHam/4Qw54UKb61aYs191JjOPzse3fqkr9desDWIqSA0CP5xXW7wh/5ERNquSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154462; c=relaxed/simple;
	bh=hMeF6zvrbmtd5L0Fl4kFRnK2npu6Nm4haLoxXNRAyRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZOz/z/kaYgltrMSIIk1j3JhMLzHk7VWEerv+U9l3/yxvrK1XikWhIGnfQZWeUBUT58M4BZRhDDiY9h68RQ8GW3xiovSwv6wGDi2ZxiWj4WiRlal9/Z/zvdqZFEypITgnQtWToHiuSco8xqacqyL1TI+Ikds/IS8rfHUbBrQNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Mj9HmEPg; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Mj9HmEPg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/g
	TM73/F9WSA8hdHaJIMje7bLTqx7CUbbRHTg5nU5F8=; b=Mj9HmEPgqJQd/2cuBw
	yMb2vmv7/2cHF92s2fN+FAOrEohlZ1u1Qs6Fqk2vUc1CinBHpcwPes8wziMiF4EL
	ZanFHh9ZJkm5aoKnOkJppBbS/9ykeXxHyYEY0LkZNpaKptXg4Q9oWaug4c8IZOk1
	AnLRUy3CpDq8pzpjfOxbJHR0Q=
Received: from nec8-i7 (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXvIWmlrNqQZffAw--.40141S3;
	Wed, 23 Sep 2026 17:06:49 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next 1/2] bpf: Keep target extended until its last freplace link detaches
Date: Wed, 23 Sep 2026 17:06:34 +0800
Message-ID: <20260923090635.368488-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923090635.368488-1-chenyuan_fl@163.com>
References: <20260923090635.368488-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXvIWmlrNqQZffAw--.40141S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFy5Wryxtr4fWF4rtFyrZwb_yoWrCFWUpF
	WUJr1UCr4UXw4qq34kAw1UZw4a9w1kX3yxGFWrG3W0vFZIqrWkua4UW3sIkFyFvFW0yF1S
	va10grWDAw1xGFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joNtxUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQlXFWqzlqk3CwAA3Q

From: Yuan Chen <chenyuan@kylinos.cn>

The is_extended / prog_array_member_cnt protocol introduced by commit
d6083f040d5d ("bpf: Prevent tailcall infinite loop caused by freplace")
keeps a prog extended by a freplace program out of prog_array maps, and
vice versa: once a tail call re-enters an extended subprogram, its
tail_call_cnt resets on every execution and the loop never terminates.

But is_extended is a plain boolean, while one target prog can carry
several freplace links at the same time, one on its entry and one on a
global subprogram.  __bpf_trampoline_unlink_prog() cleared is_extended
whenever *any* freplace link detached, so detaching one of two links
re-armed the unbounded loop through the remaining one.

Replace the is_extended boolean with a count of the freplace links
attached to each target prog, so the target stays extended until its
last link detaches.  Also rename bpf_freplace_check_tgt_prog() to
bpf_freplace_link_tgt_prog(), as the helper has never been a pure
check: it reserves the target prog on success.

Fixes: d6083f040d5d ("bpf: Prevent tailcall infinite loop caused by freplace")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 include/linux/bpf.h     |  4 ++--
 kernel/bpf/arraymap.c   |  2 +-
 kernel/bpf/trampoline.c | 10 ++++++----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 73bacfc6444d..fc9011b8446d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1773,7 +1773,6 @@ struct bpf_prog_aux {
 	bool xdp_has_frags;
 	bool exception_cb;
 	bool exception_boundary;
-	bool is_extended; /* true if extended by freplace program */
 	bool jits_use_priv_stack;
 	bool priv_stack_requested;
 	bool changes_pkt_data;
@@ -1785,7 +1784,8 @@ struct bpf_prog_aux {
 		u8 verdict;
 	} sig;
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
-	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
+	u64 freplace_link_cnt; /* counts freplace links extending this prog */
+	struct mutex ext_mutex; /* mutex for freplace_link_cnt and prog_array_member_cnt */
 	struct bpf_arena *arena;
 	void (*recursion_detected)(struct bpf_prog *prog); /* callback if recursion is detected */
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 248b4818178c..3bcff6a0430d 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -974,7 +974,7 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
 	}
 
 	mutex_lock(&prog->aux->ext_mutex);
-	is_extended = prog->aux->is_extended;
+	is_extended = prog->aux->freplace_link_cnt > 0;
 	if (!is_extended)
 		prog->aux->prog_array_member_cnt++;
 	mutex_unlock(&prog->aux->ext_mutex);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ed7999ad6c66..d18a913bc80f 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -813,7 +813,7 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 	}
 }
 
-static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
+static int bpf_freplace_link_tgt_prog(struct bpf_prog *tgt_prog)
 {
 	struct bpf_prog_aux *aux = tgt_prog->aux;
 
@@ -827,7 +827,7 @@ static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
 		 */
 		return -EBUSY;
 
-	aux->is_extended = true;
+	aux->freplace_link_cnt++;
 	return 0;
 }
 
@@ -933,7 +933,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 		/* Cannot attach extension if fentry/fexit are in use. */
 		if (cnt)
 			return -EBUSY;
-		err = bpf_freplace_check_tgt_prog(tgt_prog);
+		err = bpf_freplace_link_tgt_prog(tgt_prog);
 		if (err)
 			return err;
 		tr->extension_prog = node->link->prog;
@@ -979,7 +979,9 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_node *node,
 					 tr->extension_prog->bpf_func, NULL);
 		tr->extension_prog = NULL;
 		guard(mutex)(&tgt_prog->aux->ext_mutex);
-		tgt_prog->aux->is_extended = false;
+		if (WARN_ON_ONCE(!tgt_prog->aux->freplace_link_cnt))
+			return err;
+		tgt_prog->aux->freplace_link_cnt--;
 		return err;
 	}
 	bpf_trampoline_remove_prog(tr, node);
-- 
2.54.0

