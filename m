Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41943399351;
	Tue,  9 Jun 2026 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009619; cv=none; b=ATOnOBnYGqY1vL5haWCgC1zQpordHfKkXa/Dc8z8mYNMXi13IJpJpOYqebYgjLmSZ8mbYmf9BfMDQDL5Ve8lKsfWAOLncv+dIznilRUG+Y1VV9u52tdrMSczk4q8JEiJz+FHs6TvcoxasOeJd43cjPvCwr6sDfza1eYTA0wRHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009619; c=relaxed/simple;
	bh=YNxZ/YO140sFwyflBdzBe4JKsnOsi20InoK8tYuRJr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQe0EOLQx7wilynufjHrQOW8O2wpKF8ZziSQ+WYxn2Aw2yTVe0Wqj5TYzT8eS60Yp5Ayha1knwlZFfG1Ts1jSe1npZlumsl/tIZ0jrXEeTX9FIRKbk1U/9W0NV9eje+cnK9fzw5sQBqBb+BGrp2gYdeW6wZsSqi9ilssqhJEFOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UZ49X4zr; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UZ49X4zr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=X4
	VJPfnT108rWbi8XePHBDXGaFZvJKhHWyZuhhK5KuA=; b=UZ49X4zrd0pbMsynCi
	FK1huilolJXnIBgGveUscdM5l+XEwWlP2r0HuHcEZqrcGwwlP6VTB1ph8lal85tW
	6QL7CNYVDzPfkLsJHNusg+rxEQ/yaKw1rhlQzhm1C0iXMhZi6OmESazDeBfSu457
	sDmp+dE0XSjCTom9vGnz8bJ3M=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBXfwCHDChqml32CQ--.44113S3;
	Tue, 09 Jun 2026 20:52:30 +0800 (CST)
From: chenyuan_fl@163.com
To: chenyuan_fl@163.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bot+bpf-ci@kernel.org,
	bpf@vger.kernel.org,
	chenyuan@kylinos.cn,
	clm@meta.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH bpf v6 1/2] bpf: Fix kfunc implicit arg inject type detection to prevent invalid pointer deref
Date: Tue,  9 Jun 2026 20:52:13 +0800
Message-ID: <20260609125214.3096351-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609125214.3096351-1-chenyuan_fl@163.com>
References: <20260608142618.3064380-1-chenyuan_fl@163.com>
 <20260609125214.3096351-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXfwCHDChqml32CQ--.44113S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr1xAr4kAryDAr4xKryUZFb_yoW7JrW5pF
	WrXr1qkr4kGw4xKwn3Ar4fAry5uw4fZa13JF4kGFyFvan8Ww4SqrsYkry3uF90yr15JF42
	qw1qqrWqgFyUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zir-BtUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAg-KiGooDI-jywAA3m

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
rejected with -EFAULT, instead of silently skipped.  Existing implicit
      args in bpf_fixup_kfunc_call() (obj_new, percpu_obj_new, obj_drop,
      percpu_obj_drop, refcount_acquire, list_push, rbtree_add) are
      explicitly allowed.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Fixes: 64e1360524b9 ("bpf: Verifier support for KF_IMPLICIT_ARGS")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/verifier.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ed484cb1a8a..0d598a419008 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11885,9 +11885,28 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			continue;
 		}
 
-		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
+		if (is_kfunc_arg_ignore(btf, &args[i]))
 			continue;
 
+		if (is_kfunc_arg_implicit(meta, i)) {
+			/*
+			 * This is an exhaustive list of the non-bpf_prog_aux
+			 * implicit args kfuncs, which are handled
+			 * post-verification by bpf_fixup_kfunc_call().
+			 */
+			if (is_bpf_obj_new_kfunc(meta->func_id) ||
+			    is_bpf_percpu_obj_new_kfunc(meta->func_id) ||
+			    is_bpf_obj_drop_kfunc(meta->func_id) ||
+			    is_bpf_percpu_obj_drop_kfunc(meta->func_id) ||
+			    is_bpf_refcount_acquire_kfunc(meta->func_id) ||
+			    is_bpf_list_push_kfunc(meta->func_id) ||
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

