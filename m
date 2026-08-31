Received: from mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664073AC0E4
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174296; cv=none; b=nNjJGCttxBNWaP+T2xgZdwAelPZX3IU6069DFuMvVXvB0CIZoM7Vw2OArCPHwLMrUgKRj3XWZizyI4l5i6r2N6V0NcPuastm3bySltbGZ319kDTnc4AgPKUSZEXiWXqkgM45x8DEUAxXGFe3PLZgA5tcnuFDRe/U9/MJabdoW80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174296; c=relaxed/simple;
	bh=7IVZKYnERBZ3SOHrfGkdcEFGIt3uXESKgR5MqtCSsfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNtjGCBYDQhy4x2n1QFwCPC6Hzt21MVRTXHeK4+Fu4W+B0Xo0JCcAP20S+f1iFGjYcLSriX7/Di4y3sceTPnYc0hdhq2rRByN0NtARf4U6nTchLMcrLh/MpFJqT78fQby0n2QVorD/7tnYyZYyUhaWHpXtZUOB0Iyl0SdbSDrZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B7Vnotce; arc=none smtp.client-ip=95.215.58.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B7Vnotce"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7IVZKYnERBZ3SOHrfGkdcEFGIt3uXESKgR5MqtCSsfI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788174293; v=1; x=1788779093;
 b=B7VnotceCQHqKt+GDUC7TI5Bj9LwMQGJ+wIaoI6f4DEwMKVz7Mwnn8w/CUYxGvK1V+4JuO/G
 ZXu8xcHhLjRAHMK/DpnvUCk2PU/9a3aBkaYQln457SILsT8qiwjZIT9KWI7v+nUa8osHEcFtE9+
 ufqPVnRxb1jJ2clLRjFfu3PM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 46169a63f5267a32;
	Mon, 31 Aug 2026 11:04:53 +0000
X-Mizu-Trace-ID: 46169a63f5267a32
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
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
Subject: [PATCH bpf v3 3/5] bpf: Fix NULL-ptr-deref in btf_var_show()
Date: Mon, 31 Aug 2026 19:01:08 +0800
Message-ID: <20260831110314.150870-4-jiayuan.chen@linux.dev>
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

btf_var_show() calls btf_type_id_resolve() unconditionally, which
dereferences btf->resolved_ids. That is NULL for a base BTF - e.g. the
vmlinux BTF that bpf_snprintf_btf() renders against - since base BTF is
not resolved during parsing. btf_modifier_show() guards this with
'if (btf->resolved_ids)', but btf_var_show() does not.

A BPF program that passes the type_id of a BTF_KIND_VAR from the vmlinux
BTF to bpf_snprintf_btf() thus NULL-derefs:

KASAN: probably user-memory-access in range [0x46638-0x4663f]
RIP: 0010:btf_var_show (kernel/bpf/btf.c:2929)
Call Trace:
 <TASK>
 btf_type_show (kernel/bpf/btf.c:8259)
 btf_type_snprintf_show (kernel/bpf/btf.c:8329)
 bpf_snprintf_btf (kernel/trace/bpf_trace.c:1047)
 bpf_prog_test_run_raw_tp (net/bpf/test_run.c:829)
 __sys_bpf (kernel/bpf/syscall.c:4804)
 do_syscall_64 (arch/x86/entry/syscall_64.c:84)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
 </TASK>

Resolve the var's type directly with btf_type_skip_modifiers() when
resolved_ids is NULL, mirroring btf_modifier_show().

Fixes: c4d0bfb45068 ("bpf: Add bpf_snprintf_btf helper")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/btf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6e267c4c4e1f..3cf35ee49c10 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2926,7 +2926,15 @@ static void btf_var_show(const struct btf *btf, const struct btf_type *t,
 			 u32 type_id, void *data, u8 bits_offset,
 			 struct btf_show *show)
 {
-	t = btf_type_id_resolve(btf, &type_id);
+	/*
+	 * btf_type_id_resolve() dereferences btf->resolved_ids, which is NULL
+	 * for a base BTF (e.g. the vmlinux BTF that bpf_snprintf_btf() uses).
+	 * Resolve the var's type directly in that case.
+	 */
+	if (btf->resolved_ids)
+		t = btf_type_id_resolve(btf, &type_id);
+	else
+		t = btf_type_skip_modifiers(btf, t->type, &type_id);
 
 	btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
 }
-- 
2.43.0

