Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84CF30E834;
	Sat,  7 Mar 2026 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853030; cv=none; b=BNWNnwSlRaPLX+uS1QRTJXhdBeTvJPqnV4Me1Lw0kjVup6e+MCpWriDt5tZzWSJ/8cYfKY9O7/Fs+8bFoo+9AvDZio9If9tPr/mOPD0JGNNBzILgbaS6BeJb5pVY1On9T+tRxQQBEC4ZLuGFr7YPe8NTgOXUeJrgG7qadWj76JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853030; c=relaxed/simple;
	bh=Qq1it+lIT56cpv0llEyFBwafxVvZ5T/DqOvFYCNBEfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQ9yDKI/zXpO/886K2DYp4BFyITj/gBtp7leE/Sm3q9lS0bz3iTBMOnNCpBLLcMVfsn8ki3R9uZujNPU6xDdRBgklc2IrQQvs7YT7BJv5O0/qFDeR5PizNleh3ZO+k+IkYZmZ9qytXIN+NbSLiATIUDp/x7isNGVtzMknJjvsNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fSStc0xKvzYQtjb;
	Sat,  7 Mar 2026 11:09:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1F8944058C;
	Sat,  7 Mar 2026 11:10:24 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgAH42wel6tpvdAAAA--.1963S2;
	Sat, 07 Mar 2026 11:10:23 +0800 (CST)
Message-ID: <fec87624-2d73-45e1-8c45-6f98e2fcbf95@huaweicloud.com>
Date: Sat, 7 Mar 2026 11:10:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next v6 1/5] bpf: Move constants blinding from JIT to
 verifier
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>,
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
 <20260306102329.2056216-2-xukuohai@huaweicloud.com>
 <CAADnVQLv1+8SePM9K0A0gS+zqjePafSmwtNAo=Sh7cEEy99Xkw@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAADnVQLv1+8SePM9K0A0gS+zqjePafSmwtNAo=Sh7cEEy99Xkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAH42wel6tpvdAAAA--.1963S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWfWFyrWw47XFWfWr1kAFb_yoW8ur15pF
	9xCw13Cr4vgFn7ur1aqF48Jryaqr48Xr47ZF1akryrJFnIvry7Xrs8Kw1rZFZ8ArWxtw1F
	vrWYkrn8Ca4kZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU04xRDUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/7/2026 2:30 AM, Alexei Starovoitov wrote:
> On Fri, Mar 6, 2026 at 1:56 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> During the JIT stage, constants blinding rewrites instructions but only
>> rewrites the private instruction copy of the JITed subprog, leaving the
>> global instructions and insn_aux_data unchanged. This causes a mismatch
>> between subprog instructions and the global state, making it difficult
>> to look up the global insn_aux_data in the JIT.
>>
>> To avoid this mismatch, and given that all arch-specific JITs already
>> support constants blinding, move it to the generic verifier code, and
>> switch to rewrite the global env->insnsi with the global states
>> adjusted, as other rewrites in the verifier do.
>>
>> This removes the constant blinding calls in each JIT, which are largely
>> duplicated code across architectures.
>>
>> And the prog clone functions and insn_array adjustment for the JIT
>> constant blinding are no longer needed, remove them too.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   arch/arc/net/bpf_jit_core.c      |  20 +--
>>   arch/arm/net/bpf_jit_32.c        |  41 +----
>>   arch/arm64/net/bpf_jit_comp.c    |  59 ++-----
>>   arch/loongarch/net/bpf_jit.c     |  50 ++----
>>   arch/mips/net/bpf_jit_comp.c     |  20 +--
>>   arch/parisc/net/bpf_jit_core.c   |  38 +----
>>   arch/powerpc/net/bpf_jit_comp.c  |  45 ++----
>>   arch/riscv/net/bpf_jit_core.c    |  45 ++----
>>   arch/s390/net/bpf_jit_comp.c     |  41 +----
>>   arch/sparc/net/bpf_jit_comp_64.c |  41 +----
>>   arch/x86/net/bpf_jit_comp.c      |  40 +----
>>   arch/x86/net/bpf_jit_comp32.c    |  33 +---
>>   include/linux/filter.h           |   3 -
>>   kernel/bpf/core.c                | 263 -------------------------------
>>   kernel/bpf/verifier.c            | 215 +++++++++++++++++++++++--
>>   15 files changed, 288 insertions(+), 666 deletions(-)
> 
> JIT changes are fine, but pls don't move main
> bpf_jit_blind* logic from core.c.
> It makes the diff unnecessary big.
>

ok, will leave it there

> pw-bot: cr

