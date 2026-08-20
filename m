Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D6C2D9792
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787203434; cv=none; b=Cv2l8wJZBkwJKoymaTDpA5mxWNxWLlydUNuyW43sijHeGZGFcLkQRvP+44nv3KNBVfkDHxOJMPlBBETvg8Q2fVtWFSCHtAuYh6OwBkzTVu/9o1CT+JtDhjLuGn+x2GahQ5mvu/GbGA0/IUudpBwS6zKTxNGyfZEnBDEbRylmvG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787203434; c=relaxed/simple;
	bh=OCv8b10weztwTyjWoGyYVV5kRv5YYtwyMy0Y4FrMRV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THb+9nbhPkLMZ8/vyC8Jfel1/5EX3uccx0xnViqP3Vb1dB1ejTQjRjwmD2K4z89OQhVmzpfOMQ4gceCor7XaNj3g06dpHgO7f5BERAeCbLAPFV/CiXhxjK6U/TaVQV9pqo0r3Ev5+Iz7YGVLJhn5Ti7J7OSV1fdG9mHceZlcs5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Si5vF0rN; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Si5vF0rN"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OCv8b10weztwTyjWoGyYVV5kRv5YYtwyMy0Y4FrMRV8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787203428; v=1; x=1787808228;
 b=Si5vF0rN/gX+kqDaa9RRdxpuOf9JVs9uaj9c4DAaXN4qFSBfxhhDEhV/KahHdaLxNrCntBSc
 W36vsWGE0WUmC/Q+TH68OYXlYeEi15WaZaLMwh/DQfdeoi3Sl4rO92v1Plxk70tpz79NTwz7SHD
 7HzM47osKDw2cRUUwlAjzFHs=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.54.25.56] (222.72.143.228)
	by smtp.migadu.com with ESMTPS id 495c2699a5c914d7;
	Thu, 20 Aug 2026 05:23:38 +0000
X-Mizu-Trace-ID: 495c2699a5c914d7
X-Migadu-Flow: FLOW_OUT
Message-ID: <abc32187-a946-46b2-8be5-8b61c5c58abc@linux.dev>
Date: Thu, 20 Aug 2026 13:23:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Reject invalid LDSX instruction in
 disassembly
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: syzbot+3544d9b2a9206be8ba37@syzkaller.appspotmail.com,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com,
 kernel-team@meta.com
References: <20260820022020.3450479-1-memxor@gmail.com>
 <20260820022020.3450479-2-memxor@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260820022020.3450479-2-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/20/26 10:20 AM, Kumar Kartikeya Dwivedi wrote:
> The signed-load mnemonic table has entries for byte, half-word, and word
> loads because BPF_MEMSX does not support double-word loads. A BPF_MEMSX
> | BPF_DW instruction nevertheless selects index 3, past the end of this
> table.
>
> Program Structure diagnostics can disassemble a malformed instruction
> before check_and_resolve_insns() rejects its opcode. Placing the invalid
> signed double-word load at the end of a program therefore triggers an
> out-of-bounds access while reporting subprogram fallthrough.
>
> Treat signed double-word loads as invalid in the disassembler and use
> the existing BUG_ldx fallback instead.
>
> Fixes: a8f427835394 ("bpf: Report Program Structure CFG errors")
> Reported-by: syzbot+3544d9b2a9206be8ba37@syzkaller.appspotmail.com
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Sign-extending a 64-bit load is truly meaningless for printing

and this opcode is already treated as invalid in bpf_opcode_in_insntable()


> ---
>   kernel/bpf/disasm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> index 50b3ca5149a0..b1a3fbe3fda5 100644
> --- a/kernel/bpf/disasm.c
> +++ b/kernel/bpf/disasm.c
> @@ -295,7 +295,8 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
>   			verbose(cbs->private_data, "BUG_st_%02x", insn->code);
>   		}
>   	} else if (class == BPF_LDX) {
> -		if (BPF_MODE(insn->code) != BPF_MEM && BPF_MODE(insn->code) != BPF_MEMSX) {
> +		if ((BPF_MODE(insn->code) != BPF_MEM && BPF_MODE(insn->code) != BPF_MEMSX) ||
> +		    (BPF_MODE(insn->code) == BPF_MEMSX && BPF_SIZE(insn->code) == BPF_DW)) {
>   			verbose(cbs->private_data, "BUG_ldx_%02x", insn->code);
>   			return;
>   		}
