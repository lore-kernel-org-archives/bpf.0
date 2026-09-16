Received: from mta0.migadu.com (out-34.mta0.migadu.com [91.218.175.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2756849364B
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561321; cv=none; b=QziOpmI+gUZDUkgZ8uMk3x7oD0ZuIOSodoJk8f+JeB0z2ej511FPBUTyklyuAEduULY0hAbEHVTHtElp4Dbd0TATFEjp1/GOK6PBjzIIVOzdKv+N5kh7zTVWomd9EogWX8/YO14D2DcIw93qgMZ05igNGsW3Lh2fbfPDlrdfjWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561321; c=relaxed/simple;
	bh=NCVqjRr1k2CsOhHZ7+Az6mApzNV5ArQ7RRzIOhNW5kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxnWBNhpTNyqVGGVLQxQdPzXjQ4Sv+JPnX+zrKJllnNuFtekpgGK3z2/lToMQ1SQeHvDREzR3fMFc0XuTUjUCAQBtDDV+CCCwwRwSPSYKmklWVBSIKqAggUB+7xA2be+GWl8UBusV6jVLmum5o8Xc8bMUDAGW4pODu53ApjwF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GBW1Xq1a; arc=none smtp.client-ip=91.218.175.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GBW1Xq1a"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NCVqjRr1k2CsOhHZ7+Az6mApzNV5ArQ7RRzIOhNW5kg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789561317; v=1; x=1790166117;
 b=GBW1Xq1aZm7NG/JY6i++lgRem95d54p4Z9Uv3dlNoZepi4QB2u1Cihb/k3GFqVj3jAqR0Lqw
 qPn0IZaXTLZxoaFGV0snLsMv4c7Ja5f00l6hxxbSSo3AOJVgrNRNTZAgvanoDqCQUymPHmyjOQM
 u9vP3fj7dCOwmKgzv26GAu00=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7de8a246f47e0e91;
	Wed, 16 Sep 2026 12:21:57 +0000
X-Mizu-Trace-ID: 7de8a246f47e0e91
X-Migadu-Flow: FLOW_OUT
Message-ID: <2794e401-22a0-4d4d-9d89-16633fc7c609@linux.dev>
Date: Wed, 16 Sep 2026 20:21:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 03/11] bpf: Fix bpf_sock context code generation
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 daniel@iogearbox.net, netdev@vger.kernel.org,
 Nicholas Carlini <nicholas@carlini.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
 <20260916050830.8774-4-emil@etsalapatis.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260916050830.8774-4-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/16/26 1:08 PM, Emil Tsalapatis wrote:
> Currently, the ctx access code reads the rx_queue_mapping
> field with either a 4-byte or 2-byte load. The rest of the bits
> in the register are marked known zero by the verifier. However,
> the emitted ctx access code places in the register on certain
> the special value (-1) using BPF_MOV_IMM64, which gets sign-extended
> to turn on all the bits in the register. By shifting this value right,
> the program ends up with a value at runtime above what the verifier
> assumes is possible.
>
> Fix this by ensuring the read value is as wide as the assumed size.
> Use MOV32 instructions instead of MOV64 instructions to keep
> the upper bits zero as assumed by the verifier. Also properly report
> the size of the destination variable (the bpf_sock field, 4 bytes) instead
> of the source (the socket field, 2 bytes).
>
> Fixes: c3c16f2ea6d2 ("bpf: Add rx_queue_mapping to bpf_sock")
> Reported-by: Nicholas Carlini <nicholas@carlini.com>
> Suggested-by: Nicholas Carlini <nicholas@carlini.com>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>   net/core/filter.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e753..5d1705508 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10565,11 +10565,12 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
>   				       target_size));
>   		*insn++ = BPF_JMP_IMM(BPF_JNE, si->dst_reg, NO_QUEUE_MAPPING,
>   				      1);
> -		*insn++ = BPF_MOV64_IMM(si->dst_reg, -1);
> +		*insn++ = BPF_MOV32_IMM(si->dst_reg, -1);
>   #else
> -		*insn++ = BPF_MOV64_IMM(si->dst_reg, -1);
> -		*target_size = 2;
> +		*insn++ = BPF_MOV32_IMM(si->dst_reg, -1);
>   #endif
> +		*target_size = sizeof_field(struct bpf_sock, rx_queue_mapping);
> +
>   		break;
>   	}
>   
