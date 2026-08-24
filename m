Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7D538B7CD;
	Mon, 24 Aug 2026 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606631; cv=none; b=VRS90AuJwApFjYbsTHHS+nK9ixlbl7TMRPRYQ9zNiJGOqgdQRyc97ia0vz3e9dTp6QgckSomc3XTzho8u5svaJZ66jR9PwsB6+L522Kpl+67D7AOCTVo1rd+DIaHGRu286ZNCKDvPFhabwNRcoLJJYAF92sP0UNdqIStt1KZCLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606631; c=relaxed/simple;
	bh=TFIXTO5yudrYERSCvFKOJIZDgMmrEtnf4HKglHaZbPk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fXTEO6JF53uqQvkD4nAF+0GUZchM1jT8bFdTql2aVkYyRqWqMSNlOOh07x5tTyquIgsljMx2aQpPpndIUSp0OLuQbqTJ+IKTob2UK4NBCgdKH3shXSQn0KN24A+nNFKpc7EdIsnij/flnkZCprhhnAFfGsq0HZaTIguFOVJ1+jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkpBXAuW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkpBXAuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77BF1F000E9;
	Mon, 24 Aug 2026 21:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787606630;
	bh=OlhXWa3+sJIK4y8YEaqq2LANF4iiCL1i2JZT62CxDnM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NkpBXAuWna1VsjVdYdDOdHcI2uLlx1Zo4H8CH0tHbSk/m3cYoKdkmtgRDezwynKgy
	 y92I7jthfstC6De05eQoavCZJpOoKu/ojFqLeaYL4PF+RSxniAUPFHH+5UUsg2RlNJ
	 TXWXvbY6Dim8Xanv9RTX5pbLD6rubq165gJFrVWEeBy4cFpL633NehPOvSRgwaKqP7
	 6fdfF5lZqfsceLetIPYhKV1fIWtuLzv26kOkZPaCq9ndHPnpuYv8Ta5BNtjd2yDrS3
	 f+U3JJqMisl3NSIGMEtUP+g2EcloHyKZTjRAG+dBF+rAryWd4TFS+EGYpPjZtpsoeH
	 +QeAGivteyuYg==
Content-Type: multipart/mixed; boundary="===============6055100282738757698=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e9a5d1c0a976b92212a3795c3f72682392b89c3311baeca594740782ca1a6747@mail.kernel.org>
In-Reply-To: <20260824164143.485301ca@fangorn>
References: <20260824164143.485301ca@fangorn>
Subject: Re: [PATCH] bpf: fix array-index-out-of-bounds in print_bpf_insn
From: bot+bpf-ci@kernel.org
To: riel@surriel.com,ast@kernel.org
Cc: qmo@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 21:23:49 +0000 (UTC)

--===============6055100282738757698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> syzkaller triggers UBSAN array-index-out-of-bounds and panic_on_warn
> panic in print_bpf_insn() when loading a BPF program containing
> BPF_LDX | BPF_MEMSX | BPF_DW.

The panic_on_warn claim appears unsupported by the underlying report.
While __ubsan_handle_out_of_bounds can trigger a panic when
panic_on_warn is set, the referenced report shows no panic - it ends
with '---[ end trace ]---' and the kernel continued. Can this line be
adjusted to describe what actually occurred?

> bpf_ldsx_string[] holds three entries for B/H/W (s8/s16/s32).
> BPF_DW gives index 3 and reads past the array. check_subprogs()
> prints the program via bpf_diag_program_structure() before
> do_check() validates the instruction, so the illegal insn reaches
> the disassembler.

The validation order may not be quite right here. Looking at
bpf_check(), the sequence is:

  bpf_check()
    check_subprogs()              (verifier.c:21236)
    check_and_resolve_insns()     (verifier.c:21246)
      bpf_opcode_in_insntable()   (verifier.c:19282)
    do_check_subprogs()           (verifier.c:21307)

The opcode 0x99 (BPF_LDX|BPF_MEMSX|BPF_DW) is rejected by
bpf_opcode_in_insntable() inside check_and_resolve_insns(), which runs
after check_subprogs() but before do_check_subprogs(). This instruction
never reaches do_check() at all - do_check() is not what validates it.
Should the explanation reference check_and_resolve_insns() instead?

>     UBSAN: array-index-out-of-bounds in kernel/bpf/disasm.c:306:21
>     index 3 is out of range for type 'char *[3]'
>     print_bpf_insn+0x2328/0x2940 kernel/bpf/disasm.c:306
>     format_disasm_line kernel/bpf/diagnostics.c:633
>     diag_print_insn_context+0x3a5/0x930 kernel/bpf/diagnostics.c:783
>     bpf_diag_source+0x615/0x14a0 kernel/bpf/diagnostics.c:896
>     bpf_diag_program_structure+0x1f9/0x280 kernel/bpf/diagnostics.c:1215
>     check_subprogs+0x5c3/0x650 kernel/bpf/verifier.c:3057
>     bpf_check+0x1935/0x89f0 kernel/bpf/verifier.c:21097
>     bpf_prog_load+0x17dd/0x2990 kernel/bpf/syscall.c:3133

This trace doesn't match the original report. The column is 6 not 21,
the type is 'const char *const[3]' not 'char *[3]', and every symbol
offset differs:

  print_bpf_insn+0x21f1/0x2910 (not +0x2328/0x2940)
  diag_print_insn_context+0x433/0xd00 (not +0x3a5/0x930)
  bpf_diag_source+0x66a/0x1950 (not +0x615/0x14a0)
  bpf_diag_program_structure+0x31c/0x430 (not +0x1f9/0x280)
  check_subprogs+0x66b/0x740 (not +0x5c3/0x650)
  bpf_check+0x17ba/0x2e10 (not +0x1935/0x89f0)
  bpf_prog_load+0x14d6/0x1c20 (not +0x17dd/0x2990)

Some of the line numbers are also impossible: verifier.c:3057 falls
outside check_subprogs() which spans 3060-3125 (its
bpf_diag_program_structure calls are at 3093 and 3111), and
verifier.c:21097 falls outside bpf_check() which starts at 21115
(its check_subprogs call is at 21236). Was this trace from a different
build or kernel version? It would help to include the exact trace from
the original report.

> Guard any size index beyond the corresponding string table and emit
> BUG_ldx instead of accessing memory beyond the end of the the array.
> Fixes: f835bb622299 ("bpf: Add kernel/bpftool asm support for new
> instructions")

The f835bb622299 commit is where the unguarded code was introduced, but
is it the right Fixes target for a crash tag? That code was unreachable
for three years because print_bpf_insn was only called on instructions
that had already passed bpf_opcode_in_insntable(). The OOB became
reachable when check_subprogs() started emitting Program Structure
diagnostics before opcode validation. Should the Fixes tag point at the
commit that made check_subprogs() print diagnostics instead?

> Assisted-by: claw:muse-spark-1.2 syzkaller
> Signed-off-by: Rik van Riel <riel@surriel.coM>

The commit states 'syzkaller triggers ...' but includes no Reported-by,
Closes, or Link tag. The original report explicitly requests 'IMPORTANT:
if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3544d9b2a9206be8ba37@syzkaller.appspotmail.com'.
Should these tags be added so the report can be auto-closed and
reviewers can cross-check the trace?

Also, the Signed-off-by email shows 'riel@surriel.coM' (capital M) while
the Author line shows 'riel@surriel.com' (lowercase m).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32776324846
--===============6055100282738757698==--
