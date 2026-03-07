Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAFD3242D9;
	Sat,  7 Mar 2026 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772866637; cv=none; b=QySO7Jzw0RKE3Dcpryiv038noqSbwXIc95Sydn6/6hrOv+sAtOWtb85DlE13D8+FKYtOwtO7EvsKMhIKkKPouTzJe/IZksGKMcXy/L2Jlbn07zICAUWDS/FM6AuZ7N3FvUg82w9/RDd5ZCQJwQfslC+V2QW2N7AzQxTG/cWYLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772866637; c=relaxed/simple;
	bh=9e3HizxesXbXhWmRxb5kj0866GVNdp+APeAHFq+pvHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suDlVxqiT3hBsBHuDO6gfT75HHkyYYSvkkhgRRUiFQhhEgG1f9vahWwi6nFSg8Pf3yjPm2kWg3LjoqruyVFGgFFGpjVao4+n9srg8ex5z3cObR6td/stGmSs0kAlvPymucBkbd4lq9E29jgtphcuGf181uTZ2z20bVS+dAAb1dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fSYwt2VTfzKHM0d;
	Sat,  7 Mar 2026 14:57:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 901F140539;
	Sat,  7 Mar 2026 14:57:12 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgD3IQdGzKtpILwSAA--.8561S2;
	Sat, 07 Mar 2026 14:57:12 +0800 (CST)
Message-ID: <1ca67134-011b-416e-b632-4ad061b76c28@huaweicloud.com>
Date: Sat, 7 Mar 2026 14:57:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next v6 2/5] bpf: Pass bpf_verifier_env to jit
Content-Language: en-US
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>,
 Anton Protopopov <a.s.protopopov@gmail.com>,
 Shahab Vahedi <list+bpf@vahedi.org>, Russell King <linux@armlinux.org.uk>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>,
 Johan Almbladh <johan.almbladh@anyfinetworks.com>,
 Paul Burton <paulburton@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Christophe Leroy <chleroy@kernel.org>, Naveen N Rao <naveen@kernel.org>,
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>
References: <20260306102329.2056216-1-xukuohai@huaweicloud.com>
 <20260306102329.2056216-3-xukuohai@huaweicloud.com>
 <aavIVDaVYy/tr7/s@e129823.arm.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <aavIVDaVYy/tr7/s@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgD3IQdGzKtpILwSAA--.8561S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVWrJVCq3wAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r4a6rW5MxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/7/2026 2:40 PM, Yeoreum Yun wrote:
> Hi,
> 
> [...]
> 
>> -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
> 
> Does this also work for bpf_prepare_filter()?
> For example, ptp_classifier_init() calls it without invoking bpf_check(),
> so there is no env available in that context.
>

It works. The original bpf_prog_select_runtime() is preserved for
cbpf and test code, and passes NULL env to bpf_int_jit_compile().

> [...]
> 
> Thanks.
> 
> --
> Sincerely,
> Yeoreum Yun
> 
> 

