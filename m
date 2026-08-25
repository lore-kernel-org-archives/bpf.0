Received: from mta0.migadu.com (out-139.mta0.migadu.com [91.218.175.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDBE38330F
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649354; cv=none; b=W9W+pCYsMQKBdYJNyn526F5h4hU8LzGx8V6jBEkCxyP2UqXxo3DbI3Q22DnpS7jajW/bXtOoLpDLX9QmSVmuy2msS8ShOX1i7pbsdFO99vz8AxSylOMVturvSzYTMxfDaQ8cmZAq8j5u2PwQ8Mdy/UT+k2ysh7GDBzlx3ATdjdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649354; c=relaxed/simple;
	bh=j+tbezDeWUrYa4sNr0BZuAA+Uyg1Ybwbp6Wt8H6jZ6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdQwiWsg7EOBbScbB9FaRQ1eyJnYUp199l0xQSP8HtzscBQpc7kWvOrMpYC2zW/NJHPbjMSq9wfwVo4bhmxAt+ny09xnoTcjQs4waBZgDhfdB8/qZIe9ui9mrG6kcKCMVlUUzVEQ1hRSUNDrqTHq34AeI9uTAzseSZNCmzF1kd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o5vwTeqP; arc=none smtp.client-ip=91.218.175.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o5vwTeqP"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=j+tbezDeWUrYa4sNr0BZuAA+Uyg1Ybwbp6Wt8H6jZ6k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787649350; v=1; x=1788254150;
 b=o5vwTeqPCgFC4BKv6Sx2xIoVcPNf1nI+BkEQhWn7G6KXVxg3niVJp5RtFtBGxZPe/F4AhNW3
 btyMs5VEFCtuwjO/t1YBHbbXP5TsYrmMVfpLSz0OHRRBT126UptRo/HPq9ieSq/BlgL5MF2lnPJ
 3h6cDaxKAY3HuTXG5Dl9K70U=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.54.25.56] (210.22.144.162)
	by smtp.migadu.com with ESMTPS id 4aaed82a7bad93f0;
	Tue, 25 Aug 2026 09:15:50 +0000
X-Mizu-Trace-ID: 4aaed82a7bad93f0
X-Migadu-Flow: FLOW_OUT
Message-ID: <29ed6371-c10f-4de5-baac-4e6f590a6ab3@linux.dev>
Date: Tue, 25 Aug 2026 17:15:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SECURITY] KASAN global-out-of-bounds in BPF disassembler
 (bpf_ldsx_string, kernel 6.4+)
To: gandalf 4a <baksmali404@gmail.com>, security@kernel.org,
 bpf@vger.kernel.org
Cc: st@kernel.org, daniel@iogearbox.net, andrii@kernel.org
References: <CAOHg6aBPdesARUtOwR9NbsWT77L+GqTmfLGsdAQ=hf1YAGOitg@mail.gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAOHg6aBPdesARUtOwR9NbsWT77L+GqTmfLGsdAQ=hf1YAGOitg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/25/26 4:37 PM, gandalf 4a wrote:
> Hi,
> I am writing to report a KASAN-detected global-out-of-bounds read
> vulnerability in the BPF disassembler that affects Linux kernel v6.4
> and later (all versions with BPF_MEMSX support). I have attached a
> minimal C reproducer and a one-line fix patch.
> == Vulnerability Summary ==
> The bpf_ldsx_string[] array in kernel/bpf/disasm.c is missing an
> entry for BPF_DW (64-bit). The disassembler function print_bpf_insn()
> calculates the index as BPF_SIZE(insn->code) >> 3, which yields 3 for
> BPF_DW, but the array only has 3 entries (indices 0-2 for BPF_W,
> BPF_H, BPF_B). This causes an 8-byte out-of-bounds read.
> Trigger opcode: 0x99 = BPF_LDX (0x01) | BPF_MEMSX (0x80) | BPF_DW (0x18)
> == Trigger Path ==
> The crash occurs in the diagnostic printing path that runs BEFORE the
> verifier validates the instruction:
> bpf(BPF_PROG_LOAD)
> -> bpf_check() [verifier.c:21097]
> -> check_subprogs() [verifier.c:3057] <- early
> -> bpf_diag_program_structure() [diagnostics.c:1215]
> -> bpf_diag_source() [diagnostics.c:896]
> -> format_disasm_line() [diagnostics.c:633]
> -> print_bpf_insn() [disasm.c:302] <- CRASH
> The verifier correctly rejects BPF_LDX + BPF_MEMSX + BPF_DW in


Thanks for reporting this.

The issue has been fixed

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=37e5c4f4d2856290b1c56e573ced91dcd88db8ec


> check_load_mem() (verifier.c:6616-6618), but the disassembler crash
> occurs earlier in check_subprogs(), before opcode validation runs.
> == Impact ==
> - Denial of Service: With panic_on_warn=1 (common in fuzzing/test
> environments, also present in some production configs), KASAN
> detection triggers a kernel panic.
> - Unprivileged trigger: bpf(BPF_PROG_LOAD) with BPF_PROG_TYPE_SCHED_CLS
> does not require CAP_BPF. Any unprivileged user can trigger this.
> - Info leak (theoretical): On non-KASAN kernels, the 8-byte OOB read
> returns data from .rodata after bpf_ldsx_string.
> == Affected Versions ==
> Linux 6.4 (commit introducing BPF_MEMSX) through 7.2+ (latest mainline).

I don't think 6.4 suffer from this. Although the issue is associated 
with BPF_MEMSX, but OOB didn't happen until a8f427835394.



