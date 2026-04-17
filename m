Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612B3921ED
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776419255; cv=none; b=FQ5dGidXBEjtq+ifqLFx5dtoSXiVE2Pt5IgyxmL1yGs35XcX5z0zuIobqRO+REemrHL+R/uZg7+L5H0woHly94Iy/ufFQawVArQ/rDHLnzwbbUnoRweENY1gifiUBSuzae9V8XG1MmVLh/v8Zlw//bfyqY8RuXIjZTR0kRhG1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776419255; c=relaxed/simple;
	bh=sOCv1E6naRzZGKYHQy9Nds1xdDAjNbOxghR1iYbUZIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjD4FfcrJHCZdTXG95Ditgt44raWGIzsbK5CFywagP9pzGphB9cDPuwH18y8iKwCezM5OJ89YVcCV501YXg8eaGbzBQEnwSfH1Ilpyv1a5iET4eMimeI2E3abmxRjsbuWHhH88ngMTCLH3lu9IBtXiirxskTjNXpqaZTeyh+AWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1wDfnJ-0006pu-J0; Fri, 17 Apr 2026 11:47:25 +0200
Message-ID: <afb5bbb7-3ad7-4632-9909-4c003f8ea44a@pengutronix.de>
Date: Fri, 17 Apr 2026 11:47:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: XDP BPF JIT memory leak on armv7
To: Puranjay Mohan <puranjay12@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>, Russell King
 <linux@armlinux.org.uk>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <b63e9174-7a3d-4e22-8294-16df07a4af89@pengutronix.de>
 <96a56535-6016-402e-ad25-237427c2caaf@iogearbox.net>
 <CANk7y0h8F2rhosKzHuf7eewuwCofjNLut0pQ=v-gehHdMcT0Bw@mail.gmail.com>
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <CANk7y0h8F2rhosKzHuf7eewuwCofjNLut0pQ=v-gehHdMcT0Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bpf@vger.kernel.org

Hello Daniel,
Hello Puranjay,

On 2026-04-16 16:36, Daniel Borkmann wrote:
> I don't have access to arm32, but it looks like its completely missing the
> ability to do BPF to BPF calls.. you would need something like the below
> (uncompiled / untested).

Applying your Patch to latest master leads to a paging error [1] and
segmentation fault in xdp_program__attach when I run
./xdp_pass_user -d lo

> I think the problem is that BPF to BPF calls are not supported but the
> JIT doesn't reject them as well, so the best way to fix this would be
> to do:
> 
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index deeb8f292454..91fef10e88bc 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -2047,6 +2047,8 @@ static int build_insn(const struct bpf_insn
> *insn, struct jit_ctx *ctx)
>          /* function call */
>          case BPF_JMP | BPF_CALL:
>          {
> +               if (insn->src_reg == BPF_PSEUDO_CALL)
> +                       goto notyet;
>                  const s8 *r0 = bpf2a32[BPF_REG_0];
>                  const s8 *r1 = bpf2a32[BPF_REG_1];
>                  const s8 *r2 = bpf2a32[BPF_REG_2];
> 
> This will cause the memory to be freed properly.

This works for me and resolves the issue.

Tested-by: Jonas Rebmann <jre@pengutronix.de>

>> It would actually be nice to you have any chance to run through the BPF
>> selftests to see what else is broken on arm32. Outside of x86-64, arm64,
>> riscv64 and s390x BPF JITs the results might vary quite a lot on what works
>> and what doesn't. :/
> 
> I will do that soon when I get some time, the selftests won't easily
> compile for 32-bit archs as pointers are 32-bit and bpf pointers are
> 64 bit, etc. etc.

Thank you!

Regards,
Jonas

[1]:
8<--- cut here ---
Unable to handle kernel paging request at virtual address bf0abbb0 when write
[bf0abbb0] *pgd=42290811, *pte=703364df, *ppte=7033665e
Internal error: Oops: 80f [#4] SMP ARM
Modules linked in:
CPU: 0 UID: 0 PID: 2049 Comm: xdp_pass_user Tainted: G      D             7.0.0-08392-gcd33e05e22fa #19 VOLUNTARY
Tainted: [D]=DIE
Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
PC is at build_prologue+0x20/0x180
LR is at bpf_int_jit_compile+0xe0/0x440
pc : [<c0131f8c>]    lr : [<c0135fcc>]    psr: a00f0013
sp : f0c19b98  ip : f0c19be0  fp : 00000000
r10: bf0ab000  r9 : 00000001  r8 : 00000060
r7 : c23b1bc0  r6 : c3e96a40  r5 : f0adf000  r4 : f0adf000
r3 : e92d4bf0  r2 : f0c19bc0  r1 : bf0abbb0  r0 : 00000000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4553c06a  DAC: 00000051
Register r0 information: NULL pointer
Register r1 information: 1-page vmalloc region starting at 0xbf0ab000 allocated at bpf_jit_binary_alloc+0x64/0xfc
Register r2 information: 2-page vmalloc region starting at 0xf0c18000 allocated at kernel_clone+0xb4/0x3f8
Register r3 information: non-slab/vmalloc memory
Register r4 information: 1-page vmalloc region starting at 0xf0adf000 allocated at bpf_prog_alloc_no_stats+0x28/0x17c
Register r5 information: 1-page vmalloc region starting at 0xf0adf000 allocated at bpf_prog_alloc_no_stats+0x28/0x17c
Register r6 information: slab kmalloc-64 start c3e96a40 pointer offset 0 size 64
Register r7 information: slab task_struct start c23b1bc0 pointer offset 0 size 2368
Register r8 information: non-paged memory
Register r9 information: non-paged memory
Register r10 information: 1-page vmalloc region starting at 0xbf0ab000 allocated at bpf_jit_binary_alloc+0x64/0xfc
Register r11 information: NULL pointer
Register r12 information: 2-page vmalloc region starting at 0xf0c18000 allocated at kernel_clone+0xb4/0x3f8
Process xdp_pass_user (pid: 2049, stack limit = 0x95192730)
Stack: (0xf0c19b98 to 0xf0c1a000)
9b80:                                                       f0adf000 f0adf000
9ba0: c3e96a40 c0135fcc c2001180 00000000 00000002 00000004 00000002 bf0abbb0
9bc0: f0adf000 00000000 00000024 00000016 00000009 00000000 c40bd4c0 bf0abbb0
9be0: 00000050 99439246 c4f44600 f0a8d000 c5070000 00000000 bf0abbb0 c5076000
9c00: f0a8d048 c02c04e0 f0a91000 f0a8d048 00000004 c4f445fc f0a8d000 00000000
9c20: c5076000 00100cc0 c4f44600 f0a8d048 c4f445fc 00000000 00000000 00000000
9c40: ffffffff f0c19ed0 c5070830 00000002 c5070000 00000000 00000001 c029a6ac
9c60: 00000000 00000000 00000000 00000000 c5076000 c5070000 f0c19d68 00000000
9c80: 00000000 c23b1bc0 00000000 00000000 00000000 3aa2f52f 00000075 00000001
9ca0: c5070458 f0a8d048 00000000 c4f44600 00000048 38e38e39 00000000 c4f4460c
9cc0: c5070878 00000000 f0c19ed0 00000001 beffea78 00000000 00000400 00000000
9ce0: 00000000 00000000 00000001 00000000 00000000 00000000 00000000 00000000
9d00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 99439246
9d20: c1009d80 f0c19ed0 00000000 c4e9b730 f0c19d60 000000a8 00000002 c23b1bc0
9d40: 00000000 c027315c 000000a8 00000003 f0a8d048 00000020 c12cd684 00000000
9d60: beffea78 00000000 f0a8d000 00000000 c504e680 c4f4a180 0000000c 00000000
9d80: 0000001c f0c19dec c504e680 c0412a6c 00000000 004c5047 00000000 00000000
9da0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9dc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9de0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9e00: 00000000 00000000 00000000 00000000 00000000 99439246 f0c19e90 c23b1bc0
9e20: f0c19e90 beffea78 f0c19e70 00000000 00000005 000000a8 00000051 c02786dc
9e40: 00000001 c2272540 c2272540 99439246 000000c0 c2272540 00000000 c018dfc4
9e60: ffffff9c f0c19ebc c07247cc c2141418 beffea78 00000000 c160423c c01cc100
9e80: 00000001 00000001 c23b0000 eefe8a00 beffea78 00000000 c293ba70 00000088
9ea0: c23b1bc0 c23b0000 c15afa00 2da39000 c23b070c 800f0093 f0c19efc c018894c
9ec0: f0c19ec4 00000000 00000000 00000000 00000002 00000004 beffec20 00000000
9ee0: b6f97d4c 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9f00: 5f746564 5f677261 00787463 00000000 00000000 00000000 00000003 00000008
9f20: beffec10 00000000 00000002 00000000 00000000 00000000 00000000 00000000
9f40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9f60: 00000000 00000000 00000000 00000000 00000000 00000000 c4132c00 99439246
9f80: 00000006 beffeb58 00000000 00000002 00000182 c01002c4 c23b1bc0 00000182
9fa0: 000001a4 c0100060 beffeb58 00000000 00000005 beffea78 000000a8 0000005c
9fc0: beffeb58 00000000 00000002 00000182 beffea78 beffea78 00000005 000001a4
9fe0: beffea38 beffea28 b6f681f1 b6eaab02 200f0030 00000005 00000000 00000000
Call trace:
  build_prologue from bpf_int_jit_compile+0xe0/0x440
  bpf_int_jit_compile from bpf_jit_subprogs+0x8e4/0xa60
  bpf_jit_subprogs from bpf_check+0x1840/0x30e0
  bpf_check from bpf_prog_load+0x720/0xec4
  bpf_prog_load from __sys_bpf+0x4cc/0x25d4
  __sys_bpf from ret_fast_syscall+0x0/0x54
Exception stack(0xf0c19fa8 to 0xf0c19ff0)
9fa0:                   beffeb58 00000000 00000005 beffea78 000000a8 0000005c
9fc0: beffeb58 00000000 00000002 00000182 beffea78 beffea78 00000005 000001a4
9fe0: beffea38 beffea28 b6f681f1 b6eaab02
Code: e3510000 0a00004e e3043bf0 e34e392d (e7813100)
---[ end trace 0000000000000000 ]---

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
