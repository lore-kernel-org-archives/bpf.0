Received: from mta1.migadu.com (out-241.mta1.migadu.com [95.215.58.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C447DD4B
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259828; cv=none; b=L384jzcI8kT1LVHiVOW81QmR+7e1JZwu/upLsaVzBqN0XC9RzIjg7iY8Mss8aSQvTRXwNCPxPKrpiNiGToMgAn94QL1SiQlHRs/8uf8Mus5TuIW6BeL7ioS0DBGtVDQHiZ9QretXEXUkrB/cj9qIfle6njAPWc9fP2arqaPrzLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259828; c=relaxed/simple;
	bh=C1F/at+ZpcyorQfJWG9U8cQlYWLtImAZlUOYJDjZBzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iti0nIfn9VFCRwtp9rrHKwEhYo1jCR2ialOjNSCdN7OrRA0TOBBjU8oixMmfIpEUmKrM8rrdwbbjWhNOuCSl8M3vl5wLdItx1SoMzPXGAZ/4I1zEL9DegR5cGZ0zBvBHw32bF+2rzIpucYYX1QBxdixU4MfpY0pMG6JcNwDe6Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ffIRWfs2; arc=none smtp.client-ip=95.215.58.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ffIRWfs2"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=C1F/at+ZpcyorQfJWG9U8cQlYWLtImAZlUOYJDjZBzI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788259824; v=1; x=1788864624;
 b=ffIRWfs2rAMdJUQDG4RdDwe3TcQ2D0ZAYSf84qZPOer4+iwaeOxJsYzBon5LhrA9f1a16pls
 stJekjK43m4degTk5e1VQ6XvFft7DziBFyG9KhcSb1t8TNM3ynKkNVVL9YgtnrlC9SfYakTQVwr
 yRTLR9QeUBc9Jcv8ZsTi8bmw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d642d75bbf501021;
	Tue, 01 Sep 2026 10:50:24 +0000
X-Mizu-Trace-ID: d642d75bbf501021
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+37b56485bbbf90ad8489@syzkaller.appspotmail.com,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
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
	Shuah Khan <shuah@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v4 1/5] bpf: Reject key-less BTF for hash maps
Date: Tue,  1 Sep 2026 18:47:35 +0800
Message-ID: <20260901104924.346187-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901104924.346187-1-jiayuan.chen@linux.dev>
References: <20260901104924.346187-1-jiayuan.chen@linux.dev>
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

RIP: 0010:btf_type_show+0x223/0x2e0 kernel/bpf/btf.c:8232
RSP: 0018:ffffc9000399f868 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000028
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc9000399f970 R11: 0000000000000001 R12: ffffffff9b96b140
R13: ffffc9000399f8e0 R14: ffff88803d393c00 R15: 0000000000000003
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000000 CR3: 000000003d213000 CR4: 0000000000352ef0
DR0: 0000000039ae8f55 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btf_type_seq_show_flags+0xca/0x120 kernel/bpf/btf.c:8250
 htab_map_seq_show_elem+0x12e/0x350 kernel/bpf/hashtab.c:1669
 map_seq_show+0x13d/0x1e0 kernel/bpf/inode.c:293
 traverse.part.0.constprop.0+0x107/0x650 fs/seq_file.c:112
 traverse fs/seq_file.c:99 [inline]
 seq_read_iter+0x93f/0x1270 fs/seq_file.c:196
 seq_read+0x344/0x4d0 fs/seq_file.c:163
 vfs_read+0x1e4/0xb40 fs/read_write.c:572
 ksys_pread64 fs/read_write.c:764 [inline]
 __do_sys_pread64 fs/read_write.c:772 [inline]
 __se_sys_pread64 fs/read_write.c:769 [inline]
 __x64_sys_pread64+0x1eb/0x250 fs/read_write.c:769
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reject a key-less BTF in htab_map_check_btf() and rhtab_map_check_btf(),
restoring the previous behavior.

Fixes: 1df97a7453ee ("bpf: Register dtor for freeing special fields")
Fixes: 6905f8601298 ("bpf: Allow special fields in resizable hashtab")
Reported-by: syzbot+37b56485bbbf90ad8489@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a8f4e88.27659fcc.2ceef7.0008.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/hashtab.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d40cb5dd446c..7f55d6421e72 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -530,6 +530,9 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 
+	if (btf_type_is_void(key_type))
+		return -EINVAL;
+
 	if (htab_is_prealloc(htab))
 		return 0;
 	/*
@@ -3110,6 +3113,9 @@ static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
 {
 	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
 
+	if (btf_type_is_void(key_type))
+		return -EINVAL;
+
 	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor);
 }
 
-- 
2.43.0

