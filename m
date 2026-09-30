Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BE3911CA;
	Wed, 30 Sep 2026 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756309; cv=none; b=n+t6R5e+XlM24y1faA/ie95CP08/O/c+1jFpHY/p6AHvPZoQZECKa0pJu5lRKlbeBqjtdKKs8BBSR0OT+di/pp0pjocqllVItLhBedp3Z3HNC117gHdfLFBqJdP4TorCWLGT/vSBnVG+oZ3wggExla+AMHNargvnffNG4BZNGQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756309; c=relaxed/simple;
	bh=izKiWFKK09TXlCCDIaOIbP5DIjakpZ0Pyde0+1T85oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WOYoklHz16Gms578rXUflP61TPZ85K5/m02VCYwILRTWDkQ5pTrRLNJqsCZ3lmbjaWiTwikakeuUlkti7aJXKUWFxuM9kKfweI2VFkWlBmApqNOi2K7u8KL0qxRrk7AlNpH9Qmf4KgvtR+zuUxpZbGd7Rag8ywl0ypgS+fRSw9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=31BUgC0Q; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="31BUgC0Q"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=H/v8r7WAxF+ClL9lg5Ll6V9s2rSOCFEtn12e421wW7k=;
	b=31BUgC0QH5FLNXCVCICCF4YtBGI1mNCmBLH9PhuSjKoqnLZlaGaK5mx5StnxveLmG8yZNxQmv
	vsjSutx17yihJIeAupMhNcWFL3IGtdOmKQZL0KE4EY66yL1AbVEi4apjkOg8wxZeqS8ywCh9QmI
	dqIXtZQIlhOFyfYz0cvfDF4=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hvng84xY9zmV8H;
	Wed, 30 Sep 2026 16:06:12 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 84CA140586;
	Wed, 30 Sep 2026 16:18:21 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 16:18:20 +0800
Message-ID: <469b2e24-dad9-4e78-a390-03f9a7f00853@huawei.com>
Date: Wed, 30 Sep 2026 16:18:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Update qemu config for
 riscv64 in vmtest.sh
To: <bot+bpf-ci@kernel.org>, <pulehui@huaweicloud.com>, <bjorn@kernel.org>,
	<bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<eddyz87@gmail.com>, <memxor@gmail.com>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
	<emil@etsalapatis.com>, <ihor.solodrai@linux.dev>, <puranjay@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <alex@ghiti.fr>,
	<martin.lau@kernel.org>, <mason@kernel.org>
References: <20260930064607.1908864-4-pulehui@huaweicloud.com>
 <f5ed8c5179098109e321e1cc42ced4bf30fc4bf80603fdaeef517277f38834eb@mail.kernel.org>
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <f5ed8c5179098109e321e1cc42ced4bf30fc4bf80603fdaeef517277f38834eb@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/9/30 15:19, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Update qemu config for riscv64 in vmtest.sh
> 
> TL;DR: The new '-cpu max' riscv64 option in vmtest.sh needs qemu 8.2.0+, so
> cross-runs on qemu 7.2 to 8.1 may fail; the "v7.2.0+" comment and commit
> message may be stale.
> 
>> diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
>> --- a/tools/testing/selftests/bpf/vmtest.sh
>> +++ b/tools/testing/selftests/bpf/vmtest.sh
> 
> [ ... ]
> 
>> @@ -36,13 +36,13 @@ aarch64)
>>   	;;
>>   riscv64)
>>   	# required qemu version v7.2.0+
>>   	QEMU_BINARY=qemu-system-riscv64
>>   	QEMU_CONSOLE="ttyS0,115200"
>>   	HOST_FLAGS=(-M virt -cpu host -enable-kvm -smp 8)
>> -	CROSS_FLAGS=(-M virt -cpu rv64,sscofpmf=true -smp 8)
>> +	CROSS_FLAGS=(-M virt -cpu max,sscofpmf=false -smp 8)
>>   	BZIMAGE="arch/riscv/boot/Image"
>>   	ARCH="riscv"
>>   	;;
> 
> Is the "required qemu version v7.2.0+" comment still accurate after this
> change?
> 
> The riscv 'max' CPU model isn't available in qemu before v8.2.0.  In
> target/riscv/cpu.c, v7.2.0 and v8.1.0 have no riscv_max_cpu_init() and no
> TYPE_RISCV_CPU_MAX, and v8.2.0 is the release that adds:
> 
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX, riscv_max_cpu_init)
> 
> The previous '-cpu rv64,sscofpmf=true' worked on qemu 7.2 because the
> sscofpmf property already exists there.
> 
> On a non-riscv host, run-qemu takes the CROSS_FLAGS path and runs
> ${QEMU_BINARY} with "${QEMU_FLAGS[@]}".  With qemu 7.2 through 8.1 (Debian 12
> ships 7.2, for example), qemu-system-riscv64 would fail with "unable to find
> CPU model 'max'" and the script would abort under 'set -e'.
> 
> The commit message doesn't mention the raised minimum qemu version either.
> Should the comment be updated to v8.2.0+, or should the commit message state
> the new requirement?

make sense

> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36681333169
