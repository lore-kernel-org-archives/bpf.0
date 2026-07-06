Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E952F3F1ABF;
	Mon,  6 Jul 2026 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322655; cv=none; b=d1zpiVNw+heDyAHx5PlR9zqf0GmHrNq0PiVADIY7SEOVfSG2Hu+Ccg1Zrk6t1PdhtEpg7qno/KQ+yRxLzq4CImRk9eDNYu7cfCnSBW012mbt9VnFqF9+oX6tCBM4LiYBlSxT1qrGIEJ9ln3v+lQW6YYKh590pg874i7L0YVOgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322655; c=relaxed/simple;
	bh=Y4qhRwaVxcdJTWM4dNACYz/CJOGPg7Mj1MrFRrjMOyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjL2seJwjba5/3j7w34/3SYX/hdO776Mfftkx8FQqOj0g7GPqy5MCkzudpVRiANixgBSaTC/bOXpyo0jjz8zVVvsiOJrvNFTEHO3YpcjqYGHqa4HX4V++sL6bUdsSq+iwPhyFfsPasSOopN1xj1BWl6KXA32/lwPga0RvN+HR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gtwnd5K9HzKHMND;
	Mon,  6 Jul 2026 15:23:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 20C944056D;
	Mon,  6 Jul 2026 15:23:51 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgB3qVoGWEtqqtDzAA--.50057S2;
	Mon, 06 Jul 2026 15:23:50 +0800 (CST)
Message-ID: <bf647816-d292-419c-b79f-fc048122aebc@huaweicloud.com>
Date: Mon, 6 Jul 2026 15:23:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 6/6] selftests/bpf: Remove tailcalls tests
 from DENYLIST.riscv64
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: bjorn@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, pulehui@huawei.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260629140048.733346-7-pulehui@huaweicloud.com>
 <0c8408eb97828eb59c171d971793a92654f8018ada812d6ac1703330ec4059fb@mail.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <0c8408eb97828eb59c171d971793a92654f8018ada812d6ac1703330ec4059fb@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3qVoGWEtqqtDzAA--.50057S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF43KF4ruw18Aw17AF4kCrg_yoWDJwb_WF
	4Iyr93W3y8Jay7WF48Ca1UXrnxuan7ua4UAw15Jry3WrnFkrs5uF9rXrs0vryUWa9xWr9r
	ZayrJ3y5Kw4UGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	7PEDUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/6/30 0:19, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Remove tailcalls tests from DENYLIST.riscv64
>>
>> Remove tailcalls tests from DENYLIST.riscv64.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> 
> This isn't a bug, but the changelog restates the subject and the diff
> without saying why the entry can be dropped now.
> 
> The deny-list line being removed documented that the JIT could not mix
> bpf2bpf and tailcalls, and the preceding commit "riscv, bpf: Mixing
> bpf2bpf and tailcalls" adds that support.
> 
> Could the changelog note that the RV64 JIT now supports mixing bpf2bpf
> and tailcalls, rather than restating the diff?

alright, will add more detail to commit msg.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28384109028

