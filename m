Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA762F8EA1;
	Tue,  7 Jul 2026 01:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783387880; cv=none; b=nZcq/4sn2mTV112qPOg9UzCt5NLF68ZCgS7xrsp1aWnC5JUgrTJ19VGk+3JRNH4suNvtecFdugJSYx7DXSLvVH8c7TC+l2t082qz0fP8NWghHsFL3mnESyNEpjy3+0uzyrso3+EXUzlvYu51l11taJKUlBK5mzLFUulZ96Ua8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783387880; c=relaxed/simple;
	bh=qwbmjg8rIDVChG97HhEUKfS7+SDGM3C4aQ3URPossl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ku3f9IroR/NN4RU1Lf636YC5+jZ6aNW2hkDYTQX5or7BSt3JT9vbLbfysir0S/CdMeGpzbUUQxsHemvtTqLJzfJ2TLjDcvqnexQrez7F7ME3YYS84TWeHkxXPuVekEK6SU72LEHZf9ZOUVIIhhgpfv7hFBlV3iVzflCFGPOmsoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gvNwc40gZzYQtLG;
	Tue,  7 Jul 2026 09:31:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 16C674056E;
	Tue,  7 Jul 2026 09:31:15 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDnFljhVkxqvRxPAQ--.41591S2;
	Tue, 07 Jul 2026 09:31:14 +0800 (CST)
Message-ID: <b4ca552c-58b6-49dd-bd83-dc27ca49368a@huaweicloud.com>
Date: Tue, 7 Jul 2026 09:31:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/6] Mixing bpf2bpf and tailcalls for RV64
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alexandre Ghiti <alex@ghiti.fr>, Pu Lehui <pulehui@huawei.com>
References: <20260629140048.733346-1-pulehui@huaweicloud.com>
 <CAJ+HfNhn9eK+3xsd3ewEsG-duCgBeYXeLAtNan=qefas2Ya0dQ@mail.gmail.com>
 <d6647f5eb213d2ece82753285a79f28f600420d7.camel@gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <d6647f5eb213d2ece82753285a79f28f600420d7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnFljhVkxqvRxPAQ--.41591S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY37kC6x804xWl14x267AKxVW5JVWrJwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxV
	WUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_GFv_Wryl4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/7/7 3:29, Eduard Zingerman wrote:
> On Mon, 2026-06-29 at 16:21 +0200, Björn Töpel wrote:
> 
> Hi Björn,
> 
> I'm working through bpf patches queue and have a question regarding
> this series. What's your stance, does it need changes or can I apply
> it to bpf-next?

Hi Eduard,

I need to send out a new version to address the issue sashiko mentioned. 
It's already fixed locally, and I'll send it out after Björn's review 
feedback.

Thanks,
Lehui


> 
> Thanks,
> Eduard
> 
> [...]

