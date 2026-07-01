Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF96A3612F4
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 02:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782874155; cv=none; b=raglMs4EyD/7uedkJLgnMo8kOgGds9ydM345+a0NsqRJAVArESmA2S48cWJDfFCrDSSSfh6b4DLwmMovoPZ4dEC0N+x3uJjv1sQlQ3goNG+p2nsqO1mkIY4N+bOt0xW1qIrsqbQua+4WwTVmmuj9n3zJszVXHEo3M2Gfr6rB5LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782874155; c=relaxed/simple;
	bh=KswhC1GjMM0kKLGhDIGEHASN67ijd4UyjqWxnHxMM1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgRHVsGt6qSphdGeeP5zaBcOkKRWm6f7AURhtWn2GzvMqaC7TGHftfVG9UiAI1Xve1UWhwGUhFK9DdycVgH2jqqmT2XwEccCWh1UGyejm9ZBTBltJT22T4SDdZI6S2rvPG+EGtp2TEllLKlVMncGGDnjDIpJ7HRa8UsxGPHtqxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U3cs7tv5; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U3cs7tv5"
Message-ID: <90c32de0-feac-4e63-9757-2a1d115be08c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782874152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bZemTHMQBiokww3rs4dgDs35lW2Jl0ntSPrs+YU1SY=;
	b=U3cs7tv5MlMt7u/t6FUNMm9Pkqwc1kaqx1CTMI+SKEpkewnTlI2viMT/Fz7T7kJvJpp6Ia
	C22vCrpHWzxMJvwXCyc78jwmP/h52cwTO3FQgwX5aYdfV9Rl8rKgA6lhiNy63F9Fg8TY9+
	dP/uZu7Wjq5cs2tFVfYN0gH/hoyn5Ck=
Date: Wed, 1 Jul 2026 10:49:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: PROBLEM: BPF interpreter fallback after JIT compilation of
 BPF_ADDR_PERCPU leads to kernel panic
Content-Language: en-US
To: Vincent Thiberville <vincent@harfanglab.fr>,
 "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <MR1P264MB331494502C9D13D8A9EAFB99B7E82@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
 <d255172d-d9e9-4116-9243-975cf4bdf3d0@linux.dev>
 <MR1P264MB33143D31DA8982ADB2E0D808B7F72@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <MR1P264MB33143D31DA8982ADB2E0D808B7F72@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 30/6/26 20:08, Vincent Thiberville wrote:
> Hello
> 
> Thank you for the quick feedback. I cannot reproduce the issue using my reproducer on bpf-next, nor on 7.1.0-rc1. However, as I said, it works on 6.12.74 and on 7.0.13.
> 
> My best guess would be that a patch like this one: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d3e945223e0158c85dbde23de4f89493a2a817f6 makes the reproducer no longer work, but I do not know.
> I don't know if this means the bug is no longer reachable on kernels >=7.1,  or if my reproducer no longer works but the bug is reachable with other setups.
> 
> To the best of my understanding however, the reproducer should work between (and including) 6.10 and 7.0. I have not tested to find the exact version bounds however.
> 
> Best Regards
> Vincent
> 

Pls do not top-post. And reply in plain text mode.

See
https://docs.kernel.org/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions.

[...]
>>
>>
>>    *
>> Call bpf_map_lookup_elem (1)
>>    *
>> Dereference the result if non null (2)
>>    *
>> Jump with a large enough offset (>=11000) over instructions using constants (3)
>>
>> ```
>>      0: .......... (62) *(u32 *)(r10 -4) = 0
>>      1: .......... (bf) r2 = r10
>>      2: ..2....... (07) r2 += -4
>>      3: ..2....... (18) r1 = 0xffff8f0708cca200
>>      5: .12....... (85) call bpf_map_lookup_elem#1
>>      6: 0......... (15) if r0 == 0x0 goto pc+1
>>      7: 0......... (79) r0 = *(u64 *)(r0 +0)
>>      8: .......... (b7) r0 = 0

- 190 │     prog[8] = BPF_MOV64_IMM(BPF_REG_0, 0);
+ 190 │     prog[8] = BPF_JMP_IMM(BPF_IMM, 0, 0, 0);

By changing 'r0 = 0' to nop, I can reproduce the BUG with bpf-next code:

[  742.666733] BUG: unable to handle page fault for address:
0000339b72aa42b8
[  742.667846] #PF: supervisor read access in kernel mode
[  742.ogr6a6m8595] # PiFs INT:E RePrRror_code(0x0000) - not-present page


With this diff, the internal BPF_ADDR_PERCPU insn is supported in the
interpreter.


diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6b28c8641b26..d0672f1ea1b1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1918,6 +1918,9 @@ static u64 ___bpf_prog_run(u64 *regs, const struct
bpf_insn *insn)
                case 32:
                        DST = (s32) SRC;
                        break;
+               case BPF_ADDR_PERCPU:
+                       DST = (unsigned long)raw_cpu_ptr((void __percpu
*)(unsigned long)SRC);
+                       break;
                }
                CONT;
        ALU64_MOV_K:


The reproducer cannot crash the kernel after fixing.

./bpf-interpreter-bug
BPF_ADDR_PERCPU JIT bug reproducer

WARNING: this WILL crash the kernel. Run in a disposable VM.

Current config: bpf_jit_enable=1 bpf_jit_harden=2 bpf_jit_limit=528482304
Created per-cpu array map (fd 3)
Loaded target BPF program (fd 4)
Verifier:
processed 11012 insns (limit 1000000) max_states_per_insn 0 total_states
2 peak_states 2 mark_read 0
insn 10893 cannot be patched due to 16-bit range

BPF program is INTERPRETED (JIT failed as expected)
Sending UDP packet to trigger the BPF program...
If the bug is present, the kernel crashes NOW.
No crash — The kernel is either too old or has a fix.

Thanks,
Leon

