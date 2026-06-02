Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891122D7B5;
	Tue,  2 Jun 2026 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390786; cv=none; b=BiEiCA1dWrUotmRYNQd0kB18NIA4x/Ni9yIKwRfq3jTNTP0WSW2ssfezyKRGtxlM4vE9cGvnbMaoTLaAA+Tu1lT9oOPpaEBQSfK8mAfSMTv6I9ks2mbXyH+YYmeBFv+XbJ3Dczxc6Wa9GNpsX6DOjzJXedTjATyV8Yeqo544nb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390786; c=relaxed/simple;
	bh=pwOW5TW8vsikctmZCLn5YTy1sDBcakdOMZaBNU8qsnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+3LH4/NpRJPc6jIDTrPNT7MW6pIB5+L6+Ux8wA0P7gbBuDjmbgZiA+4Zf2MN8wNjrzQRY8RMkooPZ/nJQsH8DomL6aIba3povVnrbaRui7V6zXTUAZMyshaMqqR5eX9bZPeCy+yGWLRsD/RK3pQWsO0SS0i1JYV01LFXGT6rSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CVRMNoZI; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CVRMNoZI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ZP
	URPFg4yWj7LD+yXBjumibgjb/TDL6X0zxSW4SjaYc=; b=CVRMNoZIOLfF3Kf1H+
	0SavHCnh17w+qosXd/z4mvcyCa9mXHmvdYBN/p+/2RJQ+hqTySwrR1qKDo6amnkI
	fiwnEYdIS4zik5Rn/aavt6v1nXjQU3nlLNYlW3zbLZ4ZfqLHLT9YH3vcn+DoLIUu
	RKd3Hb34z/BC6USuIer3/ybIg=
Received: from nec8-i7 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCXKCA9mx5qOzE6AA--.5610S3;
	Tue, 02 Jun 2026 16:58:41 +0800 (CST)
From: chenyuan_fl@163.com
To: eddyz87@gmail.com,
	yonghong.song@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bot+bpf-ci@kernel.org,
	bpf@vger.kernel.org,
	chenyuan@kylinos.cn,
	chenyuan_fl@163.com,
	clm@meta.com,
	daniel@iogearbox.net,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org
Subject: [PATCH bpf v3 1/2] bpf: Fix kfunc implicit arg inject type detection to prevent invalid pointer deref
Date: Tue,  2 Jun 2026 16:58:25 +0800
Message-ID: <20260602085827.2562222-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602085827.2562222-1-chenyuan_fl@163.com>
References: <535798105630b24033f33f532051b93dc853bc0d.camel@gmail.com>
 <20260602085827.2562222-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCXKCA9mx5qOzE6AA--.5610S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr1xAr4kAryDAr4xKryUZFb_yoWrtrW7pF
	W5Xr1qkrWkGw4fG3Z2yF1rAry5Gw4rZa13JF4DC34Fva1DWw4ftrn5Krya9F90yr1rJF42
	qr1qqrWvgryUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zieWlDUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5QEZ1moem0EsrgAA3H

From: Yuan Chen <chenyuan@kylinos.cn>

When a module kfunc declares an implicit struct bpf_prog_aux * argument,
the verifier must identify it so the kernel injects env->prog->aux into
the correct register at runtime.  The original check used
is_kfunc_arg_prog_aux() which calls btf_types_are_same() to compare the
module BTF type against vmlinux.

Root Cause

This issue was triggered by pahole 1.30 generating module BTF with
incorrect type information, which caused the kernel's distilled base
BTF deduplication for modules to fail.  As a result, the module retained
its own copy of struct bpf_prog_aux with a different BTF ID than
vmlinux's definition.  While pahole 1.31 fixed the BTF generation issue,
the kernel must be robust against such inconsistencies: a BTF mismatch
should result in a clean rejection, not a kernel crash or information
disclosure.

When the distilled base dedup fails and btf_types_are_same() cannot
match the module's bpf_prog_aux type against vmlinux's,
is_kfunc_arg_prog_aux() returned false and the code fell through
silently without setting arg_prog.  The kfunc then received whatever
value was in the argument register and dereferenced it as a
bpf_prog_aux pointer, leading to:

  BUG: kernel invalid pointer dereference, address: 00000000000009e2
  RIP: bpf_prog_get_assoc_struct_ops+0xa/0xc0
  RDI: 0x000000000000046d (stale register value)

In the observed crash the stale value was the process PID, causing a
dereference within the unmapped NULL page.  However, an attacker able
to control the register value -- for example by writing a BPF program
that explicitly sets R2 before calling a KF_IMPLICIT_ARGS kfunc --
could redirect the dereference to arbitrary kernel memory, turning
this into an information disclosure.  The fix ensures the verifier
either validates and injects the correct bpf_prog_aux pointer, or
rejects the program outright -- no silent fallthrough that could
be exploited.

Crash Stack Trace

  PID: 1133     TASK: ffff8881057d3900  CPU: 3    COMMAND: "test_progs"
   #0 machine_kexec at ffffffff812f6e26
   #1 __crash_kexec at ffffffff8145a788
   #2 crash_kexec at ffffffff8145ac24
   #3 oops_end at ffffffff812bb67c
   #4 page_fault_oops at ffffffff813053a1
   #5 exc_page_fault at ffffffff828e60a1
   #6 asm_exc_page_fault at ffffffff810012a6
      [exception RIP: bpf_prog_get_assoc_struct_ops+10]
      RIP: ffffffff815c024a  RSP: ffffc90001b57e48  RFLAGS: 00010283
      RAX: ffff8881057d3900  RBX: ffffc90001b57e68  RCX: ffff8881057d3900
      RDX: 0000607d4d1768b8  RSI: 000000000000046d  RDI: 000000000000046d
   #7 bpf_kfunc_multi_st_ops_test_1_assoc at ffffffffc0013a85 [bpf_testmod]
   #8 bpf_trace_run2 at ffffffff814f8332
   #9 __traceiter_sys_enter at ffffffff81415f45
  #10 trace_syscall_enter at ffffffff81416735
  #11 do_syscall_64 at ffffffff828e06a1

Fix

Split the combined is_kfunc_arg_ignore() || is_kfunc_arg_implicit()
check in check_kfunc_args() so that an implicit argument reaching
is_kfunc_arg_implicit() without being handled by a prior handler is
rejected with -EFAULT, instead of silently skipped.  Recognized cases:

  - struct bpf_prog_aux *  : is_kfunc_arg_prog_aux()
  - __ign suffix args      : is_kfunc_arg_ignore()
  - list_push/rbtree_add   : is_bpf_list_push_kfunc() / is_bpf_rbtree_add_kfunc()

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Fixes: 64e1360524b9 ("bpf: Verifier support for KF_IMPLICIT_ARGS")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/verifier.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8dd79b735a69..55c74d064e4e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11916,9 +11916,22 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			continue;
 		}
 
-		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
+		if (is_kfunc_arg_ignore(btf, &args[i]))
 			continue;
 
+		if (is_kfunc_arg_implicit(meta, i)) {
+			/* list_push / rbtree_add kfuncs have implicit args
+			 * (e.g. 'off' parameter) handled during verification
+			 * in bpf_fixup_kfunc_call().  Don't flag them.
+			 */
+			if (is_bpf_list_push_kfunc(meta->func_id) ||
+			    is_bpf_rbtree_add_kfunc(meta->func_id))
+				continue;
+			verbose(env, "%s unrecognized implicit argument, possible BTF mismatch\n",
+				reg_arg_name(env, argno));
+			return -EFAULT;
+		}
+
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 
 		if (btf_type_is_scalar(t)) {
-- 
2.54.0

