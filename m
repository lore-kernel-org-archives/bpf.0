Received: from mta0.migadu.com (out-17.mta0.migadu.com [91.218.175.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61995381EBD
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788075208; cv=none; b=evquCvmfnP3pqcLnFj1izZ/f2JNuYS89jFByZfwbaJOu82p8gyCcGWfxgIbuBZvxTUZZQCVNtBKAVTGB+mOB9D69lNr2LpyjaK90SatwmcxXE47hjpq3hRa3qIodiQmA4lO+CQ5ErQjdcHkR5ROoDJd+PGwLdsZHfhho1tVkLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788075208; c=relaxed/simple;
	bh=s+hno46646Ftcg4sO1qvoDzrwEmHBxTBKiCcgLmq0KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9J7GAkUcZuOPpKOzHjAcX2veq5cysOhvM191E7NSvmGBHk1kObFSV5qB2pdG0tPYiVqeggqXKOgTwkwhlolX06+bjHizdPyYP34oqnrJXynVAdo6PqzmuAtgS2WuA/3CkInidY/Eq1nGJnUOlX3i3xyT6L2SftkC3LTbBd0/8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vD21z1mF; arc=none smtp.client-ip=91.218.175.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vD21z1mF"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=s+hno46646Ftcg4sO1qvoDzrwEmHBxTBKiCcgLmq0KQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788075205; v=1; x=1788680005;
 b=vD21z1mFauS+Lrxnd+BySCazay2IwmLwVSxLQWEC3H21SavkHgTM3X0Ze2mIEmZUL9bDffwQ
 sKZbC28QZMmHAyz/QQTdBlBAq1rcxKh7y2T730uGbKJcQpnwJW7JwVZjtdu9+qMqHKC4hBUV7Xe
 79TGXGDTBYTGEHgvObJA83Gc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id db3a522f16ad53d8;
	Sun, 30 Aug 2026 07:33:25 +0000
X-Mizu-Trace-ID: db3a522f16ad53d8
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
Subject: [PATCH bpf v2 1/4] bpf: Reject key-less BTF for hash maps
Date: Sun, 30 Aug 2026 15:30:56 +0800
Message-ID: <20260830073242.148092-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830073242.148092-1-jiayuan.chen@linux.dev>
References: <20260830073242.148092-1-jiayuan.chen@linux.dev>
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

Since commit 1df97a7453ee ("bpf: Register dtor for freeing special
fields") htab and rhtab got a ->map_check_btf to register a dtor, but
it does not look at the key, so a key-less hash map now passes
map_check_btf() and gets created. Reading it back through bpffs then
feeds the key type_id 0 into btf_type_seq_show(); btf_type_by_id()
returns the void type, kind_ops[BTF_KIND_UNKN] is NULL, and
btf_type_show() dereferences it:

KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
RIP: 0010:btf_type_show (kernel/bpf/btf.c:8251)
Call Trace:
 <TASK>
 btf_type_seq_show_flags (kernel/bpf/btf.c:8269)
 btf_type_seq_show (kernel/bpf/btf.c:8277)
 htab_map_seq_show_elem (kernel/bpf/hashtab.c:1669)
 map_seq_show (kernel/bpf/inode.c:293)
 seq_read_iter (fs/seq_file.c:273)
 seq_read (fs/seq_file.c:163)
 vfs_read (fs/read_write.c:572)
 ksys_read (fs/read_write.c:716)
 __x64_sys_read (fs/read_write.c:725)
 do_syscall_64 (arch/x86/entry/syscall_64.c:61)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
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

