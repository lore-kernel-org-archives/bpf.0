Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C104B377563;
	Tue, 18 Aug 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063255; cv=none; b=WuSLJb5AJYhyvQPY0Tb4TWltzN3UjWWOo0iOY405srvpPB3BR5gKvtXr9CRwlu/bWkQLiZ6z5cNZSWMoALnOLI74enO55fxtUZJFP8JLla8A14bpXKHXUBkejnSFFbKsKMuwVZhbmZBqXiE63fSMMXwu29JkyEPTs2kyAQL7Amk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063255; c=relaxed/simple;
	bh=C4zu9jxnwgrniKiiWHf3b4n/GyIjcTor0MVL3LeqNd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=brngAwEwydABpueZ2dzavZGNr/qcKXkGQ7lv8SnxtKzZqMyJhYYhyyZYoE74bwku8W3RN/ujv3XxyNzgWb9lDAqRPQd+Om1dnIYlEVfto7se2qemuyRBQme93cZQZuhPtQBnnFe+x3IvJDY4wHl9Jta3inAd8ISwiOPg79fw6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DleWKusk; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DleWKusk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Tdxqggf1hro1Pv7ntd9QLCSlna75ZP2bccaIl3m9ALk=;
	b=DleWKuskomEAg/rJgUuXJABJahz5xAmoScEUly4LU5VKXjZHfR2B3eXAEflW5KL67wN/SbAbd
	17LtmbexV61USAeqsLSJG/U8wezST5rPoxuWtuso/EY33cVKjXsoSUAM23NwQ6/acsC4VE6VKac
	KSxO6Y/WmPx/bK4NCoJLBZc=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hPWxN3crKz1T4MG;
	Tue, 18 Aug 2026 22:17:28 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id B0F284058C;
	Tue, 18 Aug 2026 22:27:27 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 18 Aug
 2026 22:27:26 +0800
Message-ID: <e6d593d6-ef57-440e-b624-a6ff4ad79744@huawei.com>
Date: Tue, 18 Aug 2026 22:27:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Enable arena LDSX tests for
 riscv64
Content-Language: en-US
To: Chen Pei <cp0613@linux.alibaba.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>,
	<bjorn@kernel.org>, <puranjay@kernel.org>
CC: <eddyz87@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <shuah@kernel.org>,
	<guoren@kernel.org>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1786708960.git.cp0613@linux.alibaba.com>
 <913f4fd8b3d0b7470428d9e6f0ed64f3a89e8a98.1786708960.git.cp0613@linux.alibaba.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <913f4fd8b3d0b7470428d9e6f0ed64f3a89e8a98.1786708960.git.cp0613@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/8/17 15:24, Chen Pei wrote:
> Now that the riscv64 JIT supports signed arena loads
> (BPF_PROBE_MEM32SX), enable the arena LDSX tests on riscv64:
> add JIT disassembly assertions for arena_ldsx_disasm (arena base in
> s7, add into t2, sign-extending lw/lh/lb loads) and run
> arena_ldsx_exception and arena_ldsx_s8/s16/s32 on riscv64.
> 
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

Reviewed-by: Pu Lehui <pulehui@huawei.com>
