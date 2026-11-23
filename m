Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795413502;
	b=iGL2WL9ww2Duwwjdz7vmBYCdki9HBd++nS9aBBayDfnL1gW6mV4f5x5tF2lLkcKwMIIW
	 Ur2ezgMnZBG4YXqGWwuax1iKhNFshqlC8w0gaqZPiawpeaS1y3gHhX0od1VrmVFIumXPN
	 rBO3LFDxf4ZIxk/eAwN7FHT/S/gNmSo0YmlMgUlEsOQp/qTVRdmr3N5pW0qyB9Mz0llwo
	 0KAJ9nbGvgHHjmJQMVk9a6iuIVuOxEZBaA0iCmlZhIflAFWdcREhl05Nw6ul+PoV2k9H9
	 D3AcP+Wvxk5QuSdSsGpStzjiLkol2tvqNoXelTWgPDP1YF2MZeFPN51+xqVzFZwIP3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795413502;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=YLf1S+MnQeI8Ls8W4X2DgtFqwNxZc/6UwBNrJnsmSFk=;
	b=vdWRs7WSj5Y1eUZIzHCKE7CSeF7ma2DeMv+eexdD4wo6wZJswcy+0ewVO7l4ShrOz7iR
	 uIosn6c4d2SsOSfnx19FKbk5GnqHu2u/Ia8s+4oyzDquNYJX/SVZOChP8E4ld6Q2otar7
	 Xg6gAKHG6EDyXM9/bnNWj6cT630GtHkuLi9fCjL8rJf0j0s+0CdIcvit4guHhIYBBADPK
	 CYQataPjVyvxYEGVh+y1U5gtvfVNZWSG2p9A1Fe/ANMlz0upLXnp0w7NUo2eglephm+Om
	 RfqX4QR2w8dUuw0YJijD9d1YdZuG0ScsRYFdj62jVYYrGWjZlwK/vmeRy5St2UosFAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KUkbAMCV;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE7606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 05:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09EE7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KUkbAMCV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=YL
	f1S+MnQeI8Ls8W4X2DgtFqwNxZc/6UwBNrJnsmSFk=; b=KUkbAMCVTj1eGbYah3
	zHaVaqdEcAMl3Cl4SODTozWPLR6m8E1hhVUGPvEkyxpB0hfRucnD8DoSy3d3Bu+S
	ut2GAPwPT6M72ugq1YU1xSY5BlcEw74lHIy9OciKOJN4dh3J06qxzKIX7tSxKg9D
	rigrOO1i0Pc2mLP+jIPSFr2WM=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3dzy+1QNrMgTmJg--.22062S3;
	Mon, 23 Nov 2026 13:57:24 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	ihor.solodrai@linux.dev,
	memxor@gmail.com,
	nirmoyd@nvidia.com,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v7 1/2] bpf: Fix kfunc implicit arg inject type detection to prevent invalid pointer deref
Date: Mon, 23 Nov 2026 13:57:07 +0800
Message-ID: <20261123055708.684107-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123055708.684107-1-chenyuan_fl@163.com>
References: <20261123055708.684107-1-chenyuan_fl@163.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3dzy+1QNrMgTmJg--.22062S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3XF47Aw4ftr15tFy7uw43GFg_yoW7Wr45pF
	WrJr1qkrWkGw4rKrsFyrWfAry5Xa1fZa13JF4DGFyFvan8Ww4xtw4rKr9I9F90yr15Jr42
	vw1qqrWDKFyUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jcb18UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5QRCAGsD1cSWJAAA3o

From: Yuan Chen <chenyuan@kylinos.cn>

When a module kfunc declares an implicit struct bpf_prog_aux * argument,
the verifier must identify it so the kernel injects env->prog->aux into
the correct register at runtime.  The original check used
is_kfunc_arg_prog_aux() which calls btf_types_are_same() to compare the
module BTF type against vmlinux.

Root Cause

This issue was triggered by pahole 1.30 generating module BTF with
incorrect type information, which caused the kernel's distilled base BTF
deduplication for modules to fail.  As a result, the module retained its
own copy of struct bpf_prog_aux with a different BTF ID than vmlinux's
definition.  While pahole 1.31 fixed the BTF generation issue, the kernel
must be robust against such inconsistencies: a BTF mismatch should result
in a clean rejection, not a kernel crash or information disclosure.

When the distilled base dedup fails and btf_types_are_same() cannot match
the module's bpf_prog_aux type against vmlinux's, is_kfunc_arg_prog_aux()
returned false and the code fell through silently without setting
arg_prog.  The kfunc then received whatever value was in the argument
register and dereferenced it as a bpf_prog_aux pointer, leading to:

  BUG: kernel invalid pointer dereference, address: 00000000000009e2
  RIP: bpf_prog_get_assoc_struct_ops+0xa/0xc0
  RDI: 0x000000000000046d (stale register value)

In the observed crash the stale value was the process PID, causing a
dereference within the unmapped NULL page.  However, an attacker able to
control the register value -- for example by writing a BPF program that
explicitly sets the argument register before calling a KF_IMPLICIT_ARGS
kfunc -- could redirect the dereference to arbitrary kernel memory,
turning this into an information disclosure.  The fix ensures the
verifier either validates and injects the correct bpf_prog_aux pointer,
or rejects the program outright -- no silent fallthrough that could be
exploited.

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

Split the combined is_kfunc_arg_ignore() || is_kfunc_arg_implicit() check
in get_kfunc_arg_type() so that an implicit argument that was not
recognized by is_kfunc_arg_prog_aux() is rejected with -EFAULT instead of
silently skipped.  The non-bpf_prog_aux implicit arguments handled by
bpf_fixup_kfunc_call() (obj_new, percpu_obj_new, obj_drop,
percpu_obj_drop, refcount_acquire, list_push, rbtree_add) are explicitly
allowed.

All other KF_IMPLICIT_ARGS kfuncs take a struct bpf_prog_aux * argument,
which is matched by the preceding is_kfunc_arg_prog_aux() check and
injected through insn_aux_data.arg_prog, so they never reach the new
rejection path.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Fixes: 64e1360524b9 ("bpf: Verifier support for KF_IMPLICIT_ARGS")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/verifier.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14055,8 +14055,26 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	if (is_kfunc_arg_prog_aux(meta->btf, &args[arg]))
 		return ARG_PTR_TO_PROG_AUX;
 
-	if (is_kfunc_arg_ignore(meta->btf, &args[arg]) || is_kfunc_arg_implicit(meta, arg))
+	if (is_kfunc_arg_ignore(meta->btf, &args[arg]))
 		return ARG_IGNORE;
+
+	if (is_kfunc_arg_implicit(meta, arg)) {
+		/*
+		 * These kfuncs have non-prog_aux implicit arguments that
+		 * bpf_fixup_kfunc_call() patches up after verification.
+		 */
+		if (is_bpf_obj_new_kfunc(meta->func_id) ||
+		    is_bpf_percpu_obj_new_kfunc(meta->func_id) ||
+		    is_bpf_obj_drop_kfunc(meta->func_id) ||
+		    is_bpf_percpu_obj_drop_kfunc(meta->func_id) ||
+		    is_bpf_refcount_acquire_kfunc(meta->func_id) ||
+		    is_bpf_list_push_kfunc(meta->func_id) ||
+		    is_bpf_rbtree_add_kfunc(meta->func_id))
+			return ARG_IGNORE;
+		verbose(env, "%s unrecognized implicit argument, possible BTF mismatch\n",
+			reg_arg_name(env, argno));
+		return -EFAULT;
+	}
 
 	t = btf_type_skip_modifiers(meta->btf, args[arg].type, NULL);
 
-- 
2.54.0

