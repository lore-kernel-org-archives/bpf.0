Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5618312819;
	Thu, 20 Aug 2026 04:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787199145; cv=none; b=j1DaNcM/gek7yRg0dIsIB66r7vZk2MHeybdfJ7TzZ6aKsctTM7aMoJibDiyaYaGoDEwbjG3PYDgiSpLQkkpkNXWXPvy/Di6Mln9GqbL88Fa42v7uFUDYHK7I60i0m9puESUn/ZIhtOGGJVTO809NTVpHUThtNuGYvXqlK+f2ZXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787199145; c=relaxed/simple;
	bh=V3ca0mlb/7KaViZBZMLIfqyopHMyAiDxQQ5RRvPTg6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uHzLTBXVd3qjP2s0fTs3WSBLgLm8LsVoMgRgoQ8suykkM3S/FJSuTDF65OXc0B6litWr+05IvZ595ihDdRpmhJi6xablOqXZevE3t6izJk+dhxEw/o4In4WE6LkQNlVjPzpMO3JEm0PIalmRGxy+jfFBPZvTljoDefdmGUlWk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XEBX6BNp; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XEBX6BNp"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=C2UVYU8EnWG2+bWacBuEvh5oiuNPv4fmf2gWJFql9MI=;
	b=XEBX6BNp6GkzfJ3nnaNPsv+uYf2n1fWJrMOsWXw+gnlzaDzZlGwAkYAQp0dJ9nko5djwQto/C
	gaFzgPTKY3fwJaSjAD/1tD2LTGQgE7DuansFdTanUcq3MOFyK2VKKXfH48yjByVw4qWpdayOomb
	8BZQuBfX1+bLOQCJ0XsTonQ=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hQVBD60Xrz12LDV;
	Thu, 20 Aug 2026 12:01:56 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D46140561;
	Thu, 20 Aug 2026 12:12:17 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 20 Aug
 2026 12:12:16 +0800
Message-ID: <0f57cace-5588-4f34-bd3e-1e737b8d0d7f@huawei.com>
Date: Thu, 20 Aug 2026 12:12:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Enable arena LDSX tests
 for riscv64
Content-Language: en-US
To: Chen Pei <cp0613@linux.alibaba.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>,
	<bjorn@kernel.org>, <puranjay@kernel.org>
CC: <ihor.solodrai@linux.dev>, <eddyz87@gmail.com>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
	<emil@etsalapatis.com>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<shuah@kernel.org>, <guoren@kernel.org>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1787140923.git.cp0613@linux.alibaba.com>
 <1bab696ec36f196fa6ec74a0f056030b39730da7.1787140923.git.cp0613@linux.alibaba.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <1bab696ec36f196fa6ec74a0f056030b39730da7.1787140923.git.cp0613@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/8/19 20:09, Chen Pei wrote:
> Now that the riscv64 JIT supports signed arena loads
> (BPF_PROBE_MEM32SX), enable the arena LDSX tests on riscv64:
> add JIT disassembly assertions for arena_ldsx_disasm (arena base in
> s7, add into t2, sign-extending lw/lh/lb loads) and run
> arena_ldsx_exception and arena_ldsx_s8/s16/s32 on riscv64.
> 
> Reviewed-by: Pu Lehui <pulehui@huawei.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>   .../testing/selftests/bpf/progs/verifier_ldsx.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> index 41340877dc9d..ed0a0f159bc1 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> @@ -286,6 +286,19 @@ __jited("add	x11, x0, x28")
>   __jited("ldrsh	x22, [x11, #0x18]")
>   __jited("add	x11, x0, x28")
>   __jited("ldrsb	x22, [x11, #0x20]")
> +__arch_riscv64
> +__jited("add	t2, a5, s7")
> +__jited("lw	s3, 0x10(t2)")
> +__jited("add	t2, a5, s7")
> +__jited("lh	s3, 0x18(t2)")
> +__jited("add	t2, a5, s7")
> +__jited("lb	s3, 0x20(t2)")
> +__jited("add	t2, a0, s7")
> +__jited("lw	s4, 0x10(t2)")
> +__jited("add	t2, a0, s7")
> +__jited("lh	s4, 0x18(t2)")
> +__jited("add	t2, a0, s7")
> +__jited("lb	s4, 0x20(t2)")
>   __naked void arena_ldsx_disasm(void *ctx)
>   {
>   	asm volatile (
> @@ -317,6 +330,7 @@ __description("Arena LDSX Exception")
>   __success __retval(0)
>   __arch_x86_64
>   __arch_arm64
> +__arch_riscv64
>   __naked void arena_ldsx_exception(void *ctx)
>   {
>   	asm volatile (
> @@ -338,6 +352,7 @@ __description("Arena LDSX, S8")
>   __success __retval(-1)
>   __arch_x86_64
>   __arch_arm64
> +__arch_riscv64
>   __naked void arena_ldsx_s8(void *ctx)
>   {
>   	asm volatile (
> @@ -369,6 +384,7 @@ __description("Arena LDSX, S16")
>   __success __retval(-1)
>   __arch_x86_64
>   __arch_arm64
> +__arch_riscv64
>   __naked void arena_ldsx_s16(void *ctx)
>   {
>   	asm volatile (
> @@ -400,6 +416,7 @@ __description("Arena LDSX, S32")
>   __success __retval(-1)
>   __arch_x86_64
>   __arch_arm64
> +__arch_riscv64
>   __naked void arena_ldsx_s32(void *ctx)
>   {
>   	asm volatile (

Tested-by: Pu Lehui <pulehui@huawei.com>
