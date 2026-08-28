Received: from mta1.migadu.com (out-57.mta1.migadu.com [95.215.58.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9548A3AB5C7
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787909524; cv=none; b=l0MTPI/S4Pd5B2zGgDMdJldIQcJskvTUp943CtHnK20ZeCvmrS1qC/YXuUFsU6lNd1PcA+PDjZAGqTSBY8S6iSlT3aE8GR451fIHIbZemGH7ZtV03jRe+GSGCBfveW5EEzMrAl5IYEzs5AUSHP5z7TZrH4fUUMtk5VycM4GZbSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787909524; c=relaxed/simple;
	bh=OmlSDs9I0u8FjaIs+dT9chTxqTmmbnf++knS9QEOf3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nh4g8rSrw2T+m3In99QHRCaD0WTSjDFF41n/iagJJhhggmzvn//ZVveO8BbZ4ARIITPkZL/gk+5YEEGX4Uheokk8MpNBt+xhYkSzN6zcVfqP6NRgCkaLycB4wMt4o4teODbWTKsbns8PBbtar0CfCxQoUqDsxw6JcWFkU9FKzjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B6Y0mpg3; arc=none smtp.client-ip=95.215.58.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B6Y0mpg3"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OmlSDs9I0u8FjaIs+dT9chTxqTmmbnf++knS9QEOf3I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787909517; v=1; x=1788514317;
 b=B6Y0mpg34bMVjcrF4ToIg6+nj9mXhJA02xeVeWwypAF1cAnqamlT2h04NZla4X75HZBXqUww
 hxmifMN7XtFGCEcVe95cEH32G6ZN8JNGCn879t4B84mYGMVfoSbYlJShIuivIs+JOmroi1AG28B
 I+/97Otc6r0dPHUguToHAt7A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 50127a13f27fa597;
	Fri, 28 Aug 2026 09:31:57 +0000
X-Mizu-Trace-ID: 50127a13f27fa597
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
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf: Fix NULL-ptr-deref when dumping a key-less BTF hash map
Date: Fri, 28 Aug 2026 17:31:16 +0800
Message-ID: <20260828093142.179856-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

map_check_btf() allows a key-less BTF (btf_key_type_id == 0) only for maps
that have a ->map_check_btf callback, and leaves the actual decision to
that callback. Hash maps used to have no ->map_check_btf, so a key-less
BTF was rejected outright.

That changed once htab and rhtab got a ->map_check_btf to register a dtor:
the callback does not look at the key, so a key-less hash map now passes
map_check_btf() and gets created. Reading it back through bpffs then feeds
the key type_id 0 into btf_type_seq_show(); btf_type_by_id() returns the
void type, kind_ops[BTF_KIND_UNKN] is NULL, and btf_type_show()
dereferences it:

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

Only array maps have a use for a key-less BTF (DataSec global data). Reject
it in htab_map_check_btf() and rhtab_map_check_btf(), restoring the
previous behavior, and also let btf_type_show() bail out on a type with no
show op instead of dereferencing NULL, so any other path that reaches it
with a void type degrades gracefully.

Fixes: 1df97a7453ee ("bpf: Register dtor for freeing special fields")
Fixes: 6905f8601298 ("bpf: Allow special fields in resizable hashtab")
Reported-by: syzbot+37b56485bbbf90ad8489@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a8f4e88.27659fcc.2ceef7.0008.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/btf.c     | 4 ++++
 kernel/bpf/hashtab.c | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 91b8ce77f699..3dbbbac4dd2e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8248,6 +8248,10 @@ static void btf_type_show(const struct btf *btf, u32 type_id, void *obj,
 	memset(&show->state, 0, sizeof(show->state));
 	memset(&show->obj, 0, sizeof(show->obj));
 
+	/* A void type (e.g. type_id 0) has no show op, don't deref NULL. */
+	if (!t || !btf_type_ops(t))
+		return;
+
 	btf_type_ops(t)->show(btf, t, type_id, obj, 0, show);
 }
 
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d40cb5dd446c..299859c58b41 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -530,6 +530,10 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 
+	/* Unlike array maps, hash maps have no use for a key-less BTF. */
+	if (btf_type_is_void(key_type))
+		return -EINVAL;
+
 	if (htab_is_prealloc(htab))
 		return 0;
 	/*
@@ -3110,6 +3114,10 @@ static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
 {
 	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
 
+	/* Unlike array maps, hash maps have no use for a key-less BTF. */
+	if (btf_type_is_void(key_type))
+		return -EINVAL;
+
 	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor);
 }
 
-- 
2.43.0

