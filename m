Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F8C3A75A1
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488108; cv=none; b=F8L+Zd0clAL5wXUQsllC5jiSB/zF5nIEGuQ2KdPRf2iqXeiOGRItmALNEdeFLs4mSsU+whgFJssD4C5ENh/7QyKR8UFm9VHtuOl4BM4O3I6m/EKyoD82fn+bTxfXnu9M5TV9A/GoqsoWa7EcqedWrSLiJ0KD6ZSnoe3bG7hHWX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488108; c=relaxed/simple;
	bh=SiQMwdODgbxirG0qGBf1CPJvPL11sW59gxQSaj8++5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awaTf848czFzvKqvdk3p6F8yLrapGUJn7nNKOm1eNSvSBbs3ZSWvR4lrqZs4Q6BK0wO99OIfa1pI3b+967EQogr6EZc8IqK1E29BEibfDwq6qRAHMipCf4RPpiULZ4a7rxKijAJ437IaEn28O/W4I/OcynUM40A5VpueuoGpzhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wA3EUYTkwFqgDNCAQ--.280S3;
	Mon, 11 May 2026 16:28:04 +0800 (CST)
Received: from [10.162.163.215] (unknown [10.162.163.215])
	by mail-app2 (Coremail) with SMTP id zC_KCgA3pssRkwFq2J4VAQ--.7053S3;
	Mon, 11 May 2026 16:28:02 +0800 (CST)
Message-ID: <0f4f6677-f547-47d2-8428-3e8a6cbaf6b9@zju.edu.cn>
Date: Mon, 11 May 2026 16:28:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v10 0/3] bpf: Fix call offset truncation and OOB
 read in bpf_patch_call_args()
To: bpf@vger.kernel.org, ast@kernel.org, eddyz87@gmail.com,
 emil@etsalapatis.com, puranjay@kernel.org, xukuohai@huaweicloud.com,
 qmo@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shenghaoyuan0928@163.com, ziye@zju.edu.cn
References: <20260506094714.419842-1-tangyazhou@zju.edu.cn>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <20260506094714.419842-1-tangyazhou@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zC_KCgA3pssRkwFq2J4VAQ--.7053S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgIICmoA348dnwABs7
X-CM-DELIVERINFO: =?B?bUlaFgXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9CLTJWQcNUvg5k5pzEA16SVPlL+/VbC9yxEpJVma/or26uv+Nwz+stTIheikg0Ft/GCI
	w0yW46YbPxvQZFRjjy7qr/XXzNUrrNPsgT1xHPzL/jDDzd55RxZNOQAIpDSx8g==
X-Coremail-Antispam: 1Uk129KBj93XoW3Wr1rAFyrArWkuw1DWF1fKrX_yoW7Ww17pF
	s5K34fGr4vqrWIkrZ7AF47uF1Yyan8CF47uF18X34fZF4avF1xtFy8Kr4a9F9xArZ3C3W7
	ZF4a9F9xCa4UA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8c
	xan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13r
	cDUUUUU==

Hi all,

On 5/6/26 5:47 PM, Yazhou Tang wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
> 
> This patchset addresses a silent truncation bug in the BPF verifier that
> occurs when a bpf-to-bpf call involves a massive relative jump offset.
> Additionally, it fixes a pre-existing out-of-bounds (OOB) read issue
> in the interpreter fallback path.
> 
> Because the BPF instruction set utilizes a 32-bit imm field for bpf-to-bpf
> calls, implicitly downcasting it to the 16-bit insn->off in bpf_patch_call_args()
> causes incorrect call targets or subprog ID resolution for large BPF programs.
> While fixing this by swapping the imm and off fields, it was discovered that
> the original code also had a load-time OOB read vulnerability when the stack
> depth exceeds MAX_BPF_STACK during JIT fallback.
> 
> Patch 1/3 fixes the pre-existing OOB read in bpf_patch_call_args(). It
> changes the function to return an int and explicitly rejects the JIT
> fallback if the stack depth exceeds MAX_BPF_STACK, preventing a potential
> stack buffer overflow.
> 
> Patch 2/3 fixes the s16 truncation bug.
> 1. Keep the original imm field unchanged and use the off field to store
>     the interpreter function index.
> 2. Adjust the JMP_CALL_ARGS case in ___bpf_prog_run() accordingly.
> 3. Restore the legacy xlated dump layout in bpf_insn_prepare_dump().
> 
> Patch 3/3 introduces a selftest for this fix.
> 
> ---
> 
> Change log:
> 
> v10:
> 1. Make the error log in patch 1/3 more clear. (Kuohai)
> 2. Drop bpftool and disasm_helpers.c changes, and instead restore the
>     legacy xlated dump layout in bpf_insn_prepare_dump(). This avoids
>     requiring bpftool compatibility handling. (Quentin and Alexei)
> 
> v9: https://lore.kernel.org/bpf/20260429171904.107244-1-tangyazhou@zju.edu.cn/
> 1. Modify the selftest in patch 3/3: use __clobber_all in inline asm.
>     (Sashiko AI reviewer)
> 
> v8: https://lore.kernel.org/bpf/20260429105608.92741-1-tangyazhou@zju.edu.cn/
> 1. Update cfg_partition_funcs() in bpftool to use insn->imm for call target
>     calculation. (Sashiko AI reviewer)
> 2. Modify the selftest in patch 3/3: add a large padding before the call
>     instruction, preventing the kernel panic on kernel without the fix.
>     (Sashiko AI reviewer)
> 3. Modify the selftest in patch 3/3: make it more clear.
> 
> v7: https://lore.kernel.org/bpf/20260421144504.823756-1-tangyazhou@zju.edu.cn/
> 1. Rebase the patchset to the bpf-next tree to resolve the apply conflict.
>     (Alexei)
> 2. Add Patch 1/3 to properly fix a pre-existing OOB read in bpf_patch_call_args().
>     (Sashiko AI reviewer)
> 
> v6: https://lore.kernel.org/bpf/20260412170334.716778-1-tangyazhou@zju.edu.cn/
> 1. Use a different but clearer approach to resolve this issue: keeping
>     the original imm field unchanged and using the off field to store the
>     interpreter function index. (Kuohai)
> 2. Update the related dumper code and remove a previous workaround in the
>     selftests disasm helpers, which is no longer needed after this fix.
> 
> v5: https://lore.kernel.org/bpf/20260326090133.221957-1-tangyazhou@zju.edu.cn/
> 1. Some minor changes in commit messages. (AI Reviewer)
> 
> v4: https://lore.kernel.org/bpf/20260326063329.10031-1-tangyazhou@zju.edu.cn/
> 1. Remove some redundant commit messages of patch 2/3. (Emil)
> 2. Change the number of instructions in padding_subprog() from 200,000
>     to 32,765, which is the minimum number of instructions required to
>     trigger the verifier failure. (Emil)
> 
> v3: https://lore.kernel.org/bpf/20260323122254.98540-1-tangyazhou@zju.edu.cn/
> 1. Resend to fix a typo in v2 and add "Fixes" tag. The rest of the changes
>     are identical to v2.
> 
> v2 (incorrect): https://lore.kernel.org/bpf/20260323081748.106603-1-tangyazhou@zju.edu.cn/
> 1. Move the s16 boundary check from fixup_call_args() to bpf_patch_call_args(),
>     and change the return type of bpf_patch_call_args() to int. (Emil)
> 2. Add Patch 3/3 to fix the incorrect subprog ID in dumped bpf_pseudo_call
>     instructions, which is caused by the same truncation issue. (Puranjay)
> 3. Refine the new selftest for clarity and add detailed comments explaining
>     the test design. (Emil)
> 
> v1: https://lore.kernel.org/bpf/20260316190220.113417-1-tangyazhou@zju.edu.cn/
> 
> Yazhou Tang (3):
>    bpf: Fix out-of-bounds read in bpf_patch_call_args()
>    bpf: Fix s16 truncation for large bpf-to-bpf call offsets
>    selftests/bpf: Add test for large offset bpf-to-bpf call
> 
>   include/linux/bpf.h                           |  8 ++-
>   include/linux/filter.h                        |  3 -
>   kernel/bpf/core.c                             | 27 +++++---
>   kernel/bpf/fixups.c                           | 13 ++--
>   kernel/bpf/syscall.c                          | 26 ++++++++
>   .../selftests/bpf/prog_tests/verifier.c       |  2 +
>   .../bpf/progs/verifier_call_large_imm.c       | 66 +++++++++++++++++++
>   7 files changed, 129 insertions(+), 16 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_call_large_imm.c
> 

The GitHub CI failure on this submission appears unrelated to this series.
I re-ran the CI manually through a PR and it passed:

https://github.com/kernel-patches/bpf/pull/11984

Just wanted to clarify the CI status. Please let me know if anything else
is needed from my side.

Thanks,
Yazhou

