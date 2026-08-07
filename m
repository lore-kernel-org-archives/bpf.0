Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE57042C4E9;
	Fri,  7 Aug 2026 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098696; cv=none; b=YR2iG6gXFogPe6PNt7q1+pfWNdCrGRrd2OiQ0+sdHSQW/cDHmtl4M3akpDKyX+bNdVFXXHs9IC4WDNJDvIl/uzlLxpDDYzwmfadWB2beexLHMRCGIzfrc2gang+iqAP/H2/A6RUCwYnvn9zI7rZoViJSw3KUFm6C5pA67R4W4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098696; c=relaxed/simple;
	bh=LpJ4PEk9qXKDUl933A4rRTWInwiH3Evdy/g4yPO+Spc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qzF4OKd4cftJsB6C1qXr34JlX0P+m6QXlHuNhXM6sQtZz4bERty5chwgMO02eJgInrnuVgaZfho3GZfhc3OVadXKTdpKCHWJ/gEa9zPmCsVmS+LRK1ZtlttoH1ngsCcmyWXfikHu0Zx7KaTFay46z0KW3cMqtyaoDKSt6jmgT3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=L0YQlyNl; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="L0YQlyNl"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tZOgB4SUcTAmfp77kdwj+Rujdsu+THyI2W2oKnE96dw=;
	b=L0YQlyNlKVwp/nJ7DS9dylFqRowilJDNzFGF0Ll2LzCmblz1UvwmKiBSveVs/A89o8K05a244
	zTbaJP/B8T2Or5QNWX+UJdXIMghq2ykJteHrgPfzbqbdVVbrg5qU6dw3IkZ3Prp2h6srAvKjDSr
	TT2g5R7G//NucE+U88aL9DY=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hGgCR4jBjz1cyPY;
	Fri,  7 Aug 2026 18:20:51 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id C69E54057C;
	Fri,  7 Aug 2026 18:31:24 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 7 Aug
 2026 18:31:24 +0800
Message-ID: <d1ed3be8-7a4a-4395-947a-1969125259ea@huawei.com>
Date: Fri, 7 Aug 2026 18:31:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5] bpf, cgroup: Fix storage null-ptr-deref after
 replacing prog
Content-Language: en-US
To: Leon Hwang <leon.hwang@linux.dev>, Pu Lehui <pulehui@huaweicloud.com>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrii Nakryiko
	<andrii@kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Yonghong
 Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Jiri Olsa
	<jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Amery Hung
	<ameryhung@gmail.com>
References: <20260805035342.349421-1-pulehui@huaweicloud.com>
 <77241871-37a8-430f-b7a0-0c127daf5fc4@linux.dev>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <77241871-37a8-430f-b7a0-0c127daf5fc4@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/8/5 12:59, Leon Hwang wrote:
> On 5/8/26 11:53, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Syzkaller reported a storage null-ptr-deref issue after replacing prog.
>> This occurs in the following scenario:
>> 1. prog A, an empty prog, is attached to a cgrp.
>> 2. prog B uses BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE and calls the
>>     bpf_get_local_storage helper.
>> 3. link_update is called to replace prog A with prog B.
>>
>> The reason is that __cgroup_bpf_replace fails to alloc and assign the
>> required cgrp storage for the incoming replacement prog. Consequently,
>> the new prog inherits an uninit storage, leading to null-ptr-deref panic
>> when kick the new prog.
>>
>> Fix this by rejecting link update with -EPERM if new_prog's cgroup
>> storage is incompatible with link->prog.
>>
>> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
>> Reviewed-by: Amery Hung <ameryhung@gmail.com>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> 
> 
> Looks much simpler than the previous versions.
> 
> Other than the -EPERM in the commit msg, lgtm.

Thanks review, I'd better send a new version first.

> 
> Acked-by: Leon Hwang <leon.hwang@linux.dev>
> 
>> [...]
> 
