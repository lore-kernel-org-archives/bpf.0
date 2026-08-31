Received: from mta0.migadu.com (out-235.mta0.migadu.com [91.218.175.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E862DC791
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174265; cv=none; b=X35xTWLsHFDXXOflqOrXo+URdd6r5qvco6Li9vHjvOlsQUsliPxebXaIMzXoY48MooAzK1L1HELHog3rd82b98ElKU5q08vfq6yotovu7voK4jUXbeEZlbjWOm4IDh188mv02O75GJwAJve3D6PUvfSv8LdCM6hDhRiXNUql9ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174265; c=relaxed/simple;
	bh=MZqBEMfNU2/DRjrc3AMVWf0ULkLuJij9FfiG6ryc5V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUInMoUw1ulP2y8PQ1QaOr5KZCa94u4f5F7zO0BtY68xBrCvnVQm0azIcOQe1qX5b2eklvNFvjBrZ9L2lDDI1P+15U+ZuT5JeJyuSvpeDnANWDVR30KmHBADv8OphBKFP1HcgeVkgEq7Y6C9r4RacsFz9VxugPzStxMAT198e48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UXfvt/k2; arc=none smtp.client-ip=91.218.175.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UXfvt/k2"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MZqBEMfNU2/DRjrc3AMVWf0ULkLuJij9FfiG6ryc5V8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788174261; v=1; x=1788779061;
 b=UXfvt/k2ZbhuKuP5rfveqerf8sd6weitkYAHzkW/m701o5KKAjmw3MBxcxMe2CtkRdMuDjH5
 GzZS8CWhJTCrQ8xq4jfOd8kj9/PckC8zxewBtcIHfBNG6Xq0ZlDbLKmXNIIxqqQ3j/BNH31/YcW
 SPIdyHL/DFA19b7qOyaCMEXo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b7e16e44ec0b80f5;
	Mon, 31 Aug 2026 11:04:21 +0000
X-Mizu-Trace-ID: b7e16e44ec0b80f5
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
Subject: [PATCH bpf v3 2/5] bpf: Fix NULL-ptr-deref when showing a void BTF type
Date: Mon, 31 Aug 2026 19:01:07 +0800
Message-ID: <20260831110314.150870-3-jiayuan.chen@linux.dev>
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

btf_modifier_show() resolves the modifier and then calls
btf_type_ops(t)->show() unconditionally. For the void type (type_id 0,
BTF_KIND_UNKN) kind_ops[] has no entry, so ->show is NULL.

The map dump path cannot reach a void type (a map key/value must have a
size and void has none), but bpf_snprintf_btf() takes a type_id straight
from the BPF program, and a "const void" (a modifier that resolves to
void, present in the vmlinux BTF) NULL-derefs there:

KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
RIP: 0010:btf_modifier_show (kernel/bpf/btf.c:2914)
Call Trace:
 <TASK>
 btf_type_show (kernel/bpf/btf.c:8251)
 btf_type_snprintf_show (kernel/bpf/btf.c:8321)
 bpf_snprintf_btf (kernel/trace/bpf_trace.c:1047)
 bpf_prog_test_run_raw_tp (net/bpf/test_run.c:829)
 __sys_bpf (kernel/bpf/syscall.c:4804)
 do_syscall_64 (arch/x86/entry/syscall_64.c:94)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
 </TASK>

void has no size, so there is nothing to render - not even a byte length
to fall back to dumping as raw hex. btf_df_show() is already the ->show
for the other kinds that carry no value to print - FWD, FUNC, FUNC_PROTO,
FLOAT and DECL_TAG - and emits an "<unsupported kind:N>" placeholder;
void belongs to the same group and only lacks a show op because it has
no kind_ops[] entry at all. Fall back to btf_df_show() in
btf_modifier_show() when the resolved type has no show op, so a void type
prints that placeholder instead of crashing; bpf_snprintf_btf() then
returns the length as usual.

Fixes: c4d0bfb45068 ("bpf: Add bpf_snprintf_btf helper")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/btf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 91b8ce77f699..6e267c4c4e1f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2911,7 +2911,15 @@ static void btf_modifier_show(const struct btf *btf,
 	else
 		t = btf_type_skip_modifiers(btf, type_id, NULL);
 
-	btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
+	/*
+	 * A modifier can resolve to the void type (e.g. "const void"), which
+	 * has no show op (kind_ops[BTF_KIND_UNKN] is NULL). Print a placeholder
+	 * instead of dereferencing NULL.
+	 */
+	if (!btf_type_ops(t))
+		btf_df_show(btf, t, type_id, data, bits_offset, show);
+	else
+		btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
 }
 
 static void btf_var_show(const struct btf *btf, const struct btf_type *t,
-- 
2.43.0

