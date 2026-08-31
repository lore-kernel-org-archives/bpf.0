Received: from mta1.migadu.com (out-10.mta1.migadu.com [95.215.58.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D123438BC
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174238; cv=none; b=V+IxQ4WycBrpO58aXOfnLfgobODnse2pjlBWMzyEk7b29UQLl8DI8E5rbLOI/J0l7ZcZADTDISvswLwD27nKcwWEb+qWQSuPzKRs3d+26YysZiZc16wsAIttlNPyXr7l4NGvhfiJHDsi0Y5su1bPJ+ZobnLfHmJ42x3tp+dKAUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174238; c=relaxed/simple;
	bh=ChU7rLrz5Ly5f6u8c+cGt26nIjegz2kM1bSEHnszRUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O58TvYfdbe3zeDBDV6VAAD2HsibTi3I7A6vzVh/5SRL58wwEdvEEyO7zvfSSbhK6qtf3ESPlrYgXVoupygPjHTLQOuPE6IyUPnQV/qrhLj6ZYcG5pjMBq0hNZ7NryLoiWGPz6gGD2WVXiicquP8Tls5viUg51yS5vGpnS8DLQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k24TjuTE; arc=none smtp.client-ip=95.215.58.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k24TjuTE"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ChU7rLrz5Ly5f6u8c+cGt26nIjegz2kM1bSEHnszRUA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788174233; v=1; x=1788779033;
 b=k24TjuTEfC9M2ABv7ZWe4IiiBxkyclLIiO8ON15C4hsyqY8Pqw05EGZ/BSAh6J+VyjIJsH+M
 lVIRzY6/zq1PB4SVZnVixt1i3rAfgunEXOwQRFYZhdwwMIBcthokQlwSwKywnbTBel3nrvd0FQB
 9qkhErXAgmGY96Xqo2LJt8fk=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 27ca0f8a3d15d337;
	Mon, 31 Aug 2026 11:03:53 +0000
X-Mizu-Trace-ID: 27ca0f8a3d15d337
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+37b56485bbbf90ad8489@syzkaller.appspotmail.com,
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
	Shuah Khan <shuah@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v3 1/5] bpf: Reject key-less BTF for hash maps
Date: Mon, 31 Aug 2026 19:01:06 +0800
Message-ID: <20260831110314.150870-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831110314.150870-1-jiayuan.chen@linux.dev>
References: <20260831110314.150870-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

map_check_btf() allows a key-less BTF (btf_key_type_id == 0) only for
maps that have a ->map_check_btf callback, and leaves the actual
decision to that callback. Hash maps used to have no ->map_check_btf,
so a key-less BTF was rejected outright.

That changed when htab and rhtab gained a ->map_check_btf to register a
dtor - htab in commit 1df97a7453ee ("bpf: Register dtor for freeing
special fields") and rhtab in commit 6905f8601298 ("bpf: Allow special
fields in resizable hashtab"). Neither looks at the key, so a key-less
hash map now passes map_check_btf() and gets created. Reading it back
through bpffs feeds the key type_id 0 into btf_type_seq_show();
btf_type_by_id() returns the void type, kind_ops[BTF_KIND_UNKN] is NULL,
and btf_type_show() dereferences it:

KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
RIP: 0010:btf_type_show+0x223/0x2e0 kernel/bpf/btf.c:8232
Call Trace:
 <TASK>
 btf_type_seq_show_flags+0xca/0x120 kernel/bpf/btf.c:8250
 htab_map_seq_show_elem+0x12e/0x350 kernel/bpf/hashtab.c:1669
 map_seq_show+0x13d/0x1e0 kernel/bpf/inode.c:293
 seq_read_iter+0x93f/0x1270 fs/seq_file.c:196
 seq_read+0x344/0x4d0 fs/seq_file.c:163
 vfs_read+0x1e4/0xb40 fs/read_write.c:572
 __x64_sys_pread64+0x1eb/0x250 fs/read_write.c:769
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

Reject a key-less BTF in htab_map_check_btf() and rhtab_map_check_btf(),
restoring the previous behavior.

Fixes: 1df97a7453ee ("bpf: Register dtor for freeing special fields")
Fixes: 6905f8601298 ("bpf: Allow special fields in resizable hashtab")
Reported-by: syzbot+37b56485bbbf90ad8489@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a8f4e88.27659fcc.2ceef7.0008.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/hashtab.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d40cb5dd446c..43123424183c 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -530,6 +530,10 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 
+	/* Hash maps have no use for a key-less BTF. */
+	if (btf_type_is_void(key_type))
+		return -EINVAL;
+
 	if (htab_is_prealloc(htab))
 		return 0;
 	/*
@@ -3110,6 +3114,10 @@ static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
 {
 	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
 
+	/* Hash maps have no use for a key-less BTF. */
+	if (btf_type_is_void(key_type))
+		return -EINVAL;
+
 	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor);
 }
 
-- 
2.43.0

