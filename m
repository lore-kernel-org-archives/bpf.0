Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6618592A
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965173; cv=none; b=khe10bCiGCDaACyjEEa94vbVzAOyxO0RjMKrhS705BhTj1aj/XjQ9O+NrDtIimwDuja8lBHt2Xhcq4DKGHpiuCb1AQNpBkq+Dtl3QMyBBwGsJ5VSE/pI3UowQ9swwM3bWxA6Y7GuQRBRSkAGbQ73olHUn7OEHHGA8yT0Dzo0TWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965173; c=relaxed/simple;
	bh=2phJ7QkwthDNu8T5xsVMkXxbshunQfDBz/hwjFgzEKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lJ/KZWeBF8KqPDtWR8NtbFZY6snEWR7LcVa1voH98OOADId+v3W1t68ulUa0CL6dgrFmWPqzqikSgwwApTcg8APBUSB3UZMV9J3FeGRaHIT79uDMrtx4o6lS3cN46+Yx0IncKcuKjeuADhUuwwUju8t/QKckOHErGwHpD2L4ZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTM6AAdv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTM6AAdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3BDC433F1;
	Wed, 20 Mar 2024 20:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710965172;
	bh=2phJ7QkwthDNu8T5xsVMkXxbshunQfDBz/hwjFgzEKA=;
	h=From:To:Cc:Subject:Date:From;
	b=BTM6AAdv4EXK4kfjtfQ5373fooR1H8ddxJiPrHXqKYk78LgKGISNQAkfoapQ5Xfok
	 raVayfb2aU/RHRDqTvauxaeTIw0YRETYYz+prC7SrOvlmyABD2XCTW72w+FRl6SiHE
	 bJGk1RhBrB+QlW5omY68TrBZTibuymrrL4dpMfyoEq5UgDfRRylBpJG+iS5d0MGAAn
	 w82ZpzRWlpg0n2+oAzU02BjeKtjAVkC7A0LJpursRLpslN/elqN7NrfCeCpXfiK66v
	 1b+1MRzy/UXUXNNq4sMtYaITlpV+XISkaMu2MceFZgbI1XTPJ5DsXwBFjOsF/HK+8V
	 8xHfQ3v2b0jxQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: mark kprobe_multi_link_prog_run as always inlined function
Date: Wed, 20 Mar 2024 13:06:10 -0700
Message-ID: <20240320200610.2556049-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kprobe_multi_link_prog_run() is called both for multi-kprobe and
multi-kretprobe BPF programs from kprobe_multi_link_handler() and
kprobe_multi_link_exit_handler(), respectively.
kprobe_multi_link_prog_run() is doing all the relevant work, with those
wrappers just satisfying ftrace's interfaces (kprobe callback is
supposed to return int, while kretprobe returns void).

With this structure compile performs tail-call optimization:

Dump of assembler code for function kprobe_multi_link_exit_handler:
   0xffffffff8122f1e0 <+0>:     add    $0xffffffffffffffc0,%rdi
   0xffffffff8122f1e4 <+4>:     mov    %rcx,%rdx
   0xffffffff8122f1e7 <+7>:     jmp    0xffffffff81230080 <kprobe_multi_link_prog_run>

This means that when trying to capture LBR that traces all indirect branches
we are wasting an entry just to record that kprobe_multi_link_exit_handler
called/jumped into kprobe_multi_link_prog_run.

LBR entries are especially sparse on AMD CPUs (just 16 entries on latest CPUs
vs typically 32 on latest Intel CPUs), and every entry counts (and we already
have a bunch of other LBR entries spent getting to a BPF program), so it would
be great to not waste any more than necessary.

Marking it as just `static inline` doesn't change anything, compiler
still performs tail call optimization only. But by marking
kprobe_multi_link_prog_run() as __always_inline we ensure that compiler
fully inlines it, avoiding jumps:

Dump of assembler code for function kprobe_multi_link_exit_handler:
   0xffffffff8122f4e0 <+0>:     push   %r15
   0xffffffff8122f4e2 <+2>:     push   %r14
   0xffffffff8122f4e4 <+4>:     push   %r13
   0xffffffff8122f4e6 <+6>:     push   %r12
   0xffffffff8122f4e8 <+8>:     push   %rbx
   0xffffffff8122f4e9 <+9>:     sub    $0x10,%rsp
   0xffffffff8122f4ed <+13>:    mov    %rdi,%r14
   0xffffffff8122f4f0 <+16>:    lea    -0x40(%rdi),%rax

   ...

   0xffffffff8122f590 <+176>:   call   0xffffffff8108e420 <sched_clock>
   0xffffffff8122f595 <+181>:   sub    %r14,%rax
   0xffffffff8122f598 <+184>:   add    %rax,0x8(%rbx,%r13,1)
   0xffffffff8122f59d <+189>:   jmp    0xffffffff8122f541 <kprobe_multi_link_exit_handler+97>

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 434e3ece6688..0bebd6f02e17 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2796,7 +2796,7 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 	return run_ctx->entry_ip;
 }
 
-static int
+static __always_inline int
 kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 			   unsigned long entry_ip, struct pt_regs *regs)
 {
-- 
2.43.0

