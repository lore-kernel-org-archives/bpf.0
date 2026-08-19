Received: from mta1.migadu.com (out-124.mta1.migadu.com [95.215.58.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F77389443
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 06:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119330; cv=none; b=lkhNJqQnzKiIl9wlz+mTXOSlLq0+tHuokyHs5X+Eb7kRMmnIs1iGP8aKrBwIpn7q8/AEwH6bECPEBPG0Gg2oN5oe4bEoS0RDg7u/ojcQXP4ZCdVXjSx8DvOeYnlw5cFASeMwaNwowKfE5n3ZM6U4yT9aoGTESEGnW0ACfzzIHuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119330; c=relaxed/simple;
	bh=TRcVLG1Vv6NM5OM5mxttVlGyGNnRHNEKs8bjSr/qqvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZDL0Jtr4nn+EBMeLpKCcT4kUCXo0xv/PrcseT4C+Ruz9US41sVDxkHU0oI/zcbOMVOrWS+KKOjwyvaAuqs3mhWtFH8L9UCriu0ZzNHEphn+KAVz4oHVDmxCGMr8gzOR8ThrGUgswuiPOaKTQpgI+i36LkeZfeGokRJb0ASMGZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IJLwfDMQ; arc=none smtp.client-ip=95.215.58.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IJLwfDMQ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TRcVLG1Vv6NM5OM5mxttVlGyGNnRHNEKs8bjSr/qqvc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787119323; v=1; x=1787724123;
 b=IJLwfDMQZvXXWiZBZt7D8llspl9lTSJAE8DgCheNggqiNugmS4GrTH7VppI9E1mbK6lsnb03
 QW3WlFX4GP+BbppRTOfp+Qqcg+YUad7Glif8pvMD03DTjwm1N9kcWO4Q0KTOQ991mWiw+Sh61i5
 YifEgZKpKbB9g31nlMUVMU2M=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:1f1b:84cb:1036:829e:9bdc:e63d] (2600:381:1f1b:84cb:1036:829e:9bdc:e63d)
	by smtp.migadu.com with ESMTPS id ab6c396956869644;
	Wed, 19 Aug 2026 06:02:03 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <4f6c72f7-9d21-4240-849d-08e10b0b2055@linux.dev>
Date: Tue, 18 Aug 2026 23:01:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LLVM regression in memcpy struct bpf_sock_ops->remote_ip6 to
 struct in6_addr
Content-Language: en-GB
To: YiFei Zhu <zhuyifei@google.com>, bpf <bpf@vger.kernel.org>,
 =?UTF-8?Q?=C3=96mer_Sinan_A=C4=9Facan?= <omeragacan@gmail.com>,
 yonghong-song <yhs@fb.com>
References: <CAA-VZPmzCKF5uhP0OG4mPwEs8WaL-xyjAYW=bE8z7Z_J4-h6cw@mail.gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAA-VZPmzCKF5uhP0OG4mPwEs8WaL-xyjAYW=bE8z7Z_J4-h6cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/21/26 4:56 PM, YiFei Zhu wrote:
> In one of our BPF progs, there is a pattern of copying IPv6 addresses
> (which are four u32s) off of struct bpf_sock_ops into a stack variable
> (a larger struct that contains struct in6_addr), then updating a map
> with that stack variable. After a recent LLVM upgrade, that program no
> longer loads.
>
> I wrote a reproducer:
>
>    #include <string.h>
>    #include <linux/in6.h>
>    #include <linux/bpf.h>
>    #include <bpf/bpf_helpers.h>
>
>    struct in6_addr addr6;
>
>    SEC("sockops")
>    int test(struct bpf_sock_ops *skops)
>    {
>            struct in6_addr stack_addr6;
>
>            memcpy(&stack_addr6, skops->remote_ip6, sizeof(skops->remote_ip6));
>            addr6 = stack_addr6;
>            return 0;
>    }
>
> This will fail loading at latest LLVM main with error:
>
>    -- BEGIN PROG LOAD LOG --
>    0: R1=ctx() R10=fp0
>    0: (7b) *(u64 *)(r10 -8) = r1         ; R1=ctx() R10=fp0 fp-8=ctx()
>    1: (79) r1 = *(u64 *)(r10 -8)         ; R1=ctx() R10=fp0 fp-8=ctx()
>    2: (79) r2 = *(u64 *)(r1 +40)
>    invalid bpf_context access off=40 size=8
>    processed 3 insns (limit 1000000) max_states_per_insn 0 total_states
> 0 peak_states 0 mark_read 0
>    -- END PROG LOAD LOG --

Are you using -O0 compile flag? The above code is not optimal.

I tried with llvm23/-O2, cpu v3, and get the following code:

        0:       w2 = *(u32 *)(r1 + 0x2c)
        1:       r3 = 0x0 ll
                 0000000000000008:  R_BPF_64_64  addr6
        3:       *(u32 *)(r3 + 0xc) = w2
        4:       w2 = *(u32 *)(r1 + 0x28)
        5:       *(u32 *)(r3 + 0x8) = w2
        6:       w2 = *(u32 *)(r1 + 0x24)
        7:       *(u32 *)(r3 + 0x4) = w2
        8:       w1 = *(u32 *)(r1 + 0x20)
        9:       *(u32 *)(r3 + 0x0) = w1
       10:       w0 = 0x0
       11:       exit

>
> It seems that the program is reading the address from the bpf_sock_ops
> as two u64s instead of four u32s, and the verifier understandably does
> not allow that due to the complexity of rewriting context accesses. I
> bisected the regression to
>
>    commit 790f0623411d5d9d5c989f14e87f2fe86f52eaf3
>    Author: Ömer Sinan Ağacan <omeragacan@gmail.com>
>    Date:   Tue Jun 9 16:03:26 2026
>
>        [SelectionDAG] Pass dest and src alignments separately to memcpy
> and memmove lowering functions (#201119)
>
> Looking at its PR [1], it seems that commit caused another regression
> for BPF selftests and that has been fixed, but this regression is
> still reproducible on main with that fix applied.
>
> I'm not really familiar enough with LLVM internals to understand
> exactly why it generates the code this way or how to fix the
> regression.
>
> YiFei Zhu
>
> [1] https://github.com/llvm/llvm-project/pull/201119
>

