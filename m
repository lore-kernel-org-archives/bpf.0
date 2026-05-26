Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6F63A6B6C;
	Tue, 26 May 2026 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782221; cv=none; b=EX0kNJ0ZMhas8OzS9Qd3gUqHStLhBSZP6D7jovldq8hpLZuEwJ8wL+NOEPI+OR+wZtA8Z5XxavX17HGtZJpiBtmPOfMVgz8xuA1nDavzJudf4EN740LWMKpMFRC8HpIYqqFuvN6+JTZAKpWe0U86u6OQdBKnhlRy5bXjBfbjKQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782221; c=relaxed/simple;
	bh=46/Iy1Lm5gue+IWkgz1BsUU2RzewVILaEM8NaVQdwbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNiMqbU1C4MGgG22br7ED2FrYE8+XeCS/CWDzKsJL2xAdQbc9x9mI91qMiMtFkA7FEs5qwbSaWgn1P8dCgt8hLaixDXpWd4VLqirKtoVcV1c7l5CTL3NTEWuNLX34Y24jFai3UUS2mJpUoTaBAW/B1kBNsgl9OBe16y+Pk1qiSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gPlRv0jhbzYQtnZ;
	Tue, 26 May 2026 15:55:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 612264056B;
	Tue, 26 May 2026 15:56:49 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCnvFg_UhVqMwK8Dg--.40149S2;
	Tue, 26 May 2026 15:56:49 +0800 (CST)
Message-ID: <cbdc4da5-4752-4ce5-96f8-d59e9489e77f@huaweicloud.com>
Date: Tue, 26 May 2026 15:56:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add return value tests for lsm
 cgroup
Content-Language: en-US
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev
 <sdf@fomichev.me>, Matt Bobrowski <mattbobrowski@google.com>,
 Quan Sun <2022090917019@std.uestc.edu.cn>
References: <20260523085806.417723-1-xukuohai@huaweicloud.com>
 <20260523085806.417723-3-xukuohai@huaweicloud.com>
 <DIRZ9UKO3BLX.3ARMDFHZ5CQIA@etsalapatis.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <DIRZ9UKO3BLX.3ARMDFHZ5CQIA@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCnvFg_UhVqMwK8Dg--.40149S2
X-Coremail-Antispam: 1UD129KBjvdXoWrCw4UKF4xJr1rWr1kWr13twb_yoWxGFX_J3
	yvq34DWrn7Xw17J3y5tFnIyF48G345JryrA343tFn5Cry8XryrKFs7Grnav347KFW7t3Wq
	yrnIqFW3JrySgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 5/26/2026 2:43 AM, Emil Tsalapatis wrote:
> On Sat May 23, 2026 at 4:58 AM EDT, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> Add tests to check return values set by bpf_set_retval() helper for lsm
>> cgroup programs.
> 
> After fixing the task_struct arg feel free to add:
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
> Nit: The test messages are kinda obscure, could you replace -4095~0 with "valid errno or
> success" or something similar? E.g., test1/2/3/4 could be described as
> "success"/"valid errno"/"invalid errno"/invalid value" instead of numbers.
>

Makes sense, thanks.

