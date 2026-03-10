Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A73451BB;
	Tue, 10 Mar 2026 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125071; cv=none; b=jRtRbpzfzopy8dcKQH2LxaQa7/pSVYp2R45oNOPwOFJn1pHXWBEezB+pEdVH2oVXeModnyWa3HrZcB7PK9QTCbMVYTt4yYpMBk7rBPEHe37DtXFrKFjhUVfJ5dn3Wr9BUuS96HtaVDL55q+BGGny0Iq2H6It0yYkgPkLEtaVzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125071; c=relaxed/simple;
	bh=1PqoyMYKkOQWXrc+FFHGquG6EKD5UJB1dod7rRfi8J0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqsj5Sm3r8uUF98MFeFY6vflaLw/9X8MyQICKtbh0ctG7aN4pwSNfoPpwbjA7JJtvL87GJjhCUCDFQ/+A3/3+YDfqpmii63Za3Mg6/i1Q0EE2T0+WftHyU7Cxh+rKhejJLmYDhoKyhJgy0QwEQKPrk2NhP9K8KzkcGrrBg9e6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fVPVf4gFMzKHMgw;
	Tue, 10 Mar 2026 14:44:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7868540573;
	Tue, 10 Mar 2026 14:44:25 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgAnK9vHva9pmwB8AQ--.50985S2;
	Tue, 10 Mar 2026 14:44:25 +0800 (CST)
Message-ID: <137eda3f-d2b5-46c2-b96c-b8baa8a5852c@huaweicloud.com>
Date: Tue, 10 Mar 2026 14:44:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next v8 2/5] bpf: Pass bpf_verifier_env to JIT
Content-Language: en-US
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>, Shahab Vahedi <list+bpf@vahedi.org>,
 Russell King <linux@armlinux.org.uk>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Hengqi Chen <hengqi.chen@gmail.com>,
 Johan Almbladh <johan.almbladh@anyfinetworks.com>,
 Paul Burton <paulburton@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Christophe Leroy <chleroy@kernel.org>, Naveen N Rao <naveen@kernel.org>,
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>
References: <20260309140044.2652538-1-xukuohai@huaweicloud.com>
 <20260309140044.2652538-3-xukuohai@huaweicloud.com>
 <aa772hrf7ibyWH5S@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <aa772hrf7ibyWH5S@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAnK9vHva9pmwB8AQ--.50985S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr1ftr15uF17AFWxGFW3KFg_yoWfWFc_C3
	y2qw18Ca1DGa1fJw1UCFsFvF95JrW8CF929w4v9Fnxu3ZxJFyDZFyvvrnaga4xZr4ftFW7
	GrZ3Xa1qvrn29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIF
	4iUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/10/2026 12:56 AM, Anton Protopopov wrote:

[...]

>> -struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>> +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
>>   {
>>   	vm_dump(prog);
>>   
>>   	/* Was this program already translated? */
>>   	if (!prog->jited)
>> -		return do_normal_pass(prog);
>> +		return do_normal_pass(env, prog);
>>   	else
>> -		return do_extra_pass(prog);
>> +		return do_extra_pass(env, prog);
> 
> Why is this necessary to pass env all the way through jit_ctx_init?


Right, this is indeed stale code. In the earlier version, jit_ctx_init
invoked constants blinding function which required env. But constants
blinding was removed, passing env is not necessary now.

> All below looks good, so minus the above:
> 
> Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>

Thanks for the reviewing!

