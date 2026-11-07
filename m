Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794014179;
	b=4TVGQmevfkg/bYh6JzTwl2WM36Ej5oR0lK4f2jupWDKXRu5zSRqfyF4MmF6JVXkOP9WJ
	 SIPFAuCIJ6B9c+zc1qJW0bN09wolF9xFY1ZSeOlTi2aa1hzSp5rKWlLo6V9OWNx2GLMCX
	 rzD8QhN7jy6UDiizUq5dQbXkevWsR9+2yxF7tHh3wh3Hn1hYUrFEA5I6NjOMURwxyvH7p
	 mdGZ8J1pQDao8839YMuJ9xsEGakxJ/CX+2F+ATmAim2nabXEpbXEV2DFyskIA2CfZqm6r
	 ctSq/0KvF/6z0EYrmwJtbcOr4oeVeCf6RgZ3ifsFAM8odtVcVpM0wFu0Y0ksjBsqfZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794014179;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 CC:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=09pdPTC0H3pX4QDaAkEJkvwP2Z2O6sdNBhQWaHjJtTk=;
	b=q8eE7hdEl+Hu2wHEgCXCJ/7e1WlSxXl/964kzX0Lsrebw00XuEv0bq0rm7cT0x1iW+E+
	 IcCp4yg3qXUtonsmUPPCwgQSmemdgQXY1zJiK8fCipF54rqv1sj48QTbAHQMLCwDPBd2J
	 xW3Wgkrn/p9aATA/rGF5DlfTsAk3xOcPn4LTwv5k/aZGfO67RcHPaUXcNxyrIbdHp59e1
	 egQw3modONagfu1LwxEUunafpxu2sq7lR9pTLHL9on4MNkEDpn7t9nPAP7yfbCJ5D5wB4
	 pzBGhuwiK1j5U0OzvP3GxXnZlPXmkRF21/O/x0RTLETDJGzrDFHu0AVFmtaswv1rKHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=J2F7P3Q8;
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917F606A326;
	Sat,  7 Nov 2026 01:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B917F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=J2F7P3Q8
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=09pdPTC0H3pX4QDaAkEJkvwP2Z2O6sdNBhQWaHjJtTk=;
	b=J2F7P3Q89MQRdCeGRgcWFeHu+EDvE216q7TDqn+24l8ihjJSIV1ZXv3ES9EjfdJ7DBiWLz0Cl
	WeLT/X3NubEtOCu9XYMZoNKS5G4EdgtFI229U9/NxApTWoJWaSEpgRy3N5sks5sJNWPN+dDJiUk
	Am0epWmj1C2LFbnx3HtxzZU=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jLylv6xSCzcZxr;
	Sat,  7 Nov 2026 09:15:39 +0800 (CST)
Received: from dggpemr500002.china.huawei.com (unknown [7.185.36.170])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A5ED40561;
	Sat,  7 Nov 2026 09:16:11 +0800 (CST)
Received: from whupemq100006.china.huawei.com (7.152.184.206) by
 dggpemr500002.china.huawei.com (7.185.36.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 7 Nov 2026 09:16:11 +0800
Received: from [10.67.110.154] (10.67.110.154) by
 whupemq100006.china.huawei.com (7.152.184.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 7 Nov 2026 09:16:09 +0800
Message-ID: <d0647583-f51c-4a74-b71c-6088abffe502@huawei.com>
Date: Sat, 7 Nov 2026 09:16:08 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: Test a private stack
 together with stack arguments
Content-Language: en-US
To: Chen Pei <cp0613@linux.alibaba.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>,
	<bjorn@kernel.org>, <puranjay@kernel.org>, <alexei.starovoitov@gmail.com>
CC: <eddyz87@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
	<ihor.solodrai@linux.dev>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <luke.r.nels@gmail.com>,
	<xi.wang@gmail.com>, <shuah@kernel.org>, <rgbi3307@gmail.com>,
	<guoren@kernel.org>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261106181558.1564-1-cp0613@linux.alibaba.com>
 <20261106181558.1564-4-cp0613@linux.alibaba.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20261106181558.1564-4-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemq100006.china.huawei.com (7.152.184.206)



On 2026/11/7 2:15, Chen Pei wrote:
> Add two asm programs to verifier_stack_arg.c, inside the block that is
> already gated on x86, arm64 and riscv64. A raw_tp program with a 64 byte
> frame calls a ten-argument subprog with a 64 byte frame of its own, and
> BPF_PROG_TEST_RUN runs the pair without attaching it. Args 9 and 10 stay
> in the kernel frame and arg 10 points into the caller's frame, so the two
> have to agree on where the outgoing area is. The callee returns what the
> caller stored plus arg 9, so a wrong area shows up as a wrong retval
> rather than as a crash.
> 
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>   .../selftests/bpf/progs/verifier_stack_arg.c  | 49 +++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> index 146cdf81bbc4..e8108e768b89 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> @@ -975,6 +975,55 @@ __naked void stack_arg_precision_fallback(void)
>   	);
>   }
>   
> +/* Writes both ends of its frame, then reads args 9, 10 and the frame of the caller. */
> +static __naked __noinline __used
> +long priv_stack_10args(long a, long b, long c, long d, long e, long f, long g, long h,
> +		       long i, long *j)
> +{
> +	asm volatile (
> +		"r1 = 0;"
> +		"*(u64 *)(r10 - 8) = r1;"
> +		"*(u64 *)(r10 - 64) = r1;"
> +		"r0 = *(u64 *)(r11 + 32);"
> +		"r1 = *(u64 *)(r11 + 40);"
> +		"r1 = *(u64 *)(r1 + 0);"
> +		"r0 += r1;"
> +		"exit;"
> +		::: __clobber_all
> +	);
> +}
> +
> +/*
> + * A frame of 64 bytes in a raw_tp prog goes to the private stack.
> + * arm64 and riscv64 pass args 9 and 10 on the kernel stack. On x86-64
> + * both frames stay there as well.
> + */
> +SEC("raw_tp")
> +__description("stack_arg: private stack in the caller and in the callee")
> +__success __retval(890)
> +__naked void stack_arg_priv_stack(void)
> +{
> +	asm volatile (
> +		"r1 = 800;"
> +		"*(u64 *)(r10 - 64) = r1;"
> +		"r1 = r10;"
> +		"r1 += -64;"
> +		"*(u64 *)(r11 - 40) = r1;"
> +		"*(u64 *)(r11 - 32) = 90;"
> +		"*(u64 *)(r11 - 24) = 8;"
> +		"*(u64 *)(r11 - 16) = 7;"
> +		"*(u64 *)(r11 - 8) = 6;"
> +		"r1 = 1;"
> +		"r2 = 2;"
> +		"r3 = 3;"
> +		"r4 = 4;"
> +		"r5 = 5;"
> +		"call priv_stack_10args;"
> +		"exit;"
> +		::: __clobber_all
> +	);
> +}
> +
>   #else
>   
>   /* No BTF tells about this store. The insn is what JIT has to deal with. */


Reviewed-by: Pu Lehui <pulehui@huawei.com>
