Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B535B125;
	Wed, 30 Sep 2026 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749478; cv=none; b=l69eaOZ6GYooq1kTtq1KMByhINYgjwKGlpOMx1ZLF+n+ugCyjf7yEntJSFvFY10AtTo8pR24vZ9pgsvFoaBsK7k3oxQ1KGRm6qCJzc4rpDPKQRh63zBn46mBObmZiwqsskaCW9qywhaEEr8V45S+xdzSGCpvd5xNmrRNjMDtEa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749478; c=relaxed/simple;
	bh=MBsl6ZrxMqZohP7TBwRcTnbcbZtA8oZGrHuyoFYIXCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihxpPX5RTy16A6HP616HsKGg883tI5u+aekGQEeM88zrAMPe3DMXeWlZAQy2UTtK/RDlVf/+yxphs4EXbOCLE9pym8fZzurZX/KiMJpHGxZoh2UqubZWOc/yvTY5rtyP7gN0yGiwT2g2qKnPhF+ko7jea3jnGk7nqP6XE0WJ6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hvlPF2McjzYQttb;
	Wed, 30 Sep 2026 14:24:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CABC74056D;
	Wed, 30 Sep 2026 14:24:29 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDHP_ocq7xq2+WwCA--.12019S2;
	Wed, 30 Sep 2026 14:24:29 +0800 (CST)
Message-ID: <52daee54-9127-445c-b924-64623ca2e125@huaweicloud.com>
Date: Wed, 30 Sep 2026 14:24:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: Use /tmp for temporary file
 in d_path
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Puranjay Mohan
 <puranjay@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Pu Lehui <pulehui@huawei.com>
References: <20260929083924.1851840-1-pulehui@huaweicloud.com>
 <20260929083924.1851840-4-pulehui@huaweicloud.com>
 <DLRXY2AQRPYP.1YQ75SL3XHQHN@gmail.com>
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <DLRXY2AQRPYP.1YQ75SL3XHQHN@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDHP_ocq7xq2+WwCA--.12019S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr4rJr48XF13Ar15CFW5trb_yoWDXFb_Cw
	4YkF93Jw1Dta1jqa109r4UZr18ur4vvF18KasYgry7Zas3Zr98WF4kCr9Y9Fs2va4Iva45
	Xr13u3y3tr47CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jIks
	gUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/9/30 0:29, Alexei Starovoitov wrote:
> On Tue, Sep 29, 2026 at 08:39 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
>> The failure occurs because the rootfs created by libbpf/ci [0] does not
>> mount /dev/shm, causing temporary file creation under /dev/shm to fail.
>>
>> Let's switch to using /tmp instead to fix this issue.
> 
> This will break BPF CI.
> The test was using /tmp up to v4 and was moved to /dev/shm in v5,
> since /tmp is on 9p in BPF CI and 9p doesn't support fallocate. See
> https://lore.kernel.org/all/20251206141210.3148-1-electronlsr@gmail.com/
> vmtest's init mounts tmpfs at /dev/shm, /run and /mnt, but not at /tmp.
> So fallocate() will return EOPNOTSUPP and d_path/check_mem_access
> will fail on x86, arm64 and s390.
> 
> Mount tmpfs at /dev/shm in mkrootfs_tweak.sh like you did for /tmp in [1]
> and drop this patch.
> 
> pw-bot: cr

Hi Alexei and Ihor,

I have been make a pr for mount tmpfs at /dev/shm, pls take a look.

https://github.com/libbpf/ci/pull/239

