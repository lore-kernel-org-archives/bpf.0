Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2263112CDA5;
	Mon,  8 Jun 2026 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928858; cv=none; b=u67e/K0EYbJQunePqSqbpM1W8QM7mRFTsH9B1O7DLG5EeYJjX6kqiTOcAY5hQ7fFBQfQbofnlUmvgM0z6zcYsk1ipaxVxX+ADnm8tTX0W0ZwjE3nTGrwpowreubp8QbSQqsgoYVZpx9l0rUFRsLY4PmLlVuI9VSCHXYGvAq2s3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928858; c=relaxed/simple;
	bh=+j/JAhJnALJ4cCbHA+VTYEnS7qq7B8wQYlLy0761Q8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlOhonClG+qlGILopT8/SWJ5RUbFzWh3iOz0cJgHwovchIhc/Dq8/8JE70Qe3bsQOccWQrsT9praKf0vWy7wL80v+bF6T0gJjMndp9e7AoPwFwUD25y0AJF78UpTCIoAfboiBNHJDgpJgghEhBhRr/GFWRQRWN8aWXMgTpZO08s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kZbQgVkJ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kZbQgVkJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=q3
	f0C7K6TnXwmufgRurL9Y/1EPh762OHN/OQvjdWdWY=; b=kZbQgVkJqIE3zyrAyW
	x0S0CvaO21UJIfT2E2KKSKLbbHsF+s6Bh7rvtI0zHaOoXTTLkBkfoSENo1p9eqkJ
	X8IH88VkfN+Obu6QIhppbKB19QyjyNBs6idDJbyHU/yd7z0ZFHF6nEXBnM32dVUi
	YZIcDNQ9N7YYOM4qCmZIz0pzk=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBXwtUW0SZqv3LYBw--.1507S3;
	Mon, 08 Jun 2026 22:26:38 +0800 (CST)
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
Subject: [PATCH bpf v5 1/2] bpf: Fix kfunc implicit arg inject type detection to prevent invalid pointer deref
Date: Mon,  8 Jun 2026 22:26:17 +0800
Message-ID: <20260608142618.3064380-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608142618.3064380-1-chenyuan_fl@163.com>
References: <20260602093836.2632714-1-chenyuan_fl@163.com>
 <20260608142618.3064380-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXwtUW0SZqv3LYBw--.1507S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr1xAr4kAryDAr4xKryUZFb_yoW7Gr1rpF
	WrJr1qkr4kGw4xKwn3Ar4fAry5uw4xAa13JFWDGFyFvFs8Ww4SqwsYkry3uF90yr15JF42
	vw1qqrWqgFyUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zir-BtUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAR6fXWom0R6L2wAA3O

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
 kernel/bpf/verifier.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ed484cb1a8a..91aaed7a5eeb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11885,9 +11885,27 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			continue;
 		}
 
-		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
+		if (is_kfunc_arg_ignore(btf, &args[i]))
 			continue;
 
+		if (is_kfunc_arg_implicit(meta, i)) {
+			/* kfuncs with implicit args (e.g. 'off' parameter)
+			 * handled during verification in bpf_fixup_kfunc_call():
+			 * obj_new, percpu_obj_new, obj_drop, percpu_obj_drop,
+			 * refcount_acquire, list_push, rbtree_add. Don't flag them. */
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

