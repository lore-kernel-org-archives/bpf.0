Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A0F38836A;
	Thu,  9 Apr 2026 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775737686; cv=none; b=bOW6D+4LvRTdU2rBgeZHa9GAkRioxbLSEzBPI4116yXifl6DFbCJuSwaPOGbkdMCrf8GtwKojncpvaDqsE6HnkuaK1SLmdpVs05PnkmjBxwsrbU0YgCzT/lRFgiA1u8bX0ORgE0bN0yaXApHcXwUIwgUfEGXA5aHvOT4nq7+UKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775737686; c=relaxed/simple;
	bh=MdXtJzHBHKVV3IDKWU9NFqhXLBRpWmE+1d0HeHdsEE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWsZrs9Q1jbH/+HXX+m5iCJ8UIIo4Fqc69sLM+GubMOHlupBkzmM/eQxSl1LSzdtab3mSByWt0O2Q73K2LVwwPrhexxowuJKGTS756ioUAsPShX3fI6SREVUa/iCOGDw7Hkw/yiHiIU7vep+uLsinbVSJ63G5HLSUY4CRYVYjFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4frzjY1HTGzKHMLF;
	Thu,  9 Apr 2026 20:28:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5A7E640573;
	Thu,  9 Apr 2026 20:28:01 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgDnEAZPm9dpf7bHDw--.44043S2;
	Thu, 09 Apr 2026 20:28:00 +0800 (CST)
Message-ID: <b570acfd-ce59-4cfc-b066-4ad290d6e780@huaweicloud.com>
Date: Thu, 9 Apr 2026 20:27:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 1/5] bpf: Move constants blinding out of
 arch-specific JITs
Content-Language: en-US
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>,
 Anton Protopopov <a.s.protopopov@gmail.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
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
References: <20260403132811.753894-1-xukuohai@huaweicloud.com>
 <20260403132811.753894-2-xukuohai@huaweicloud.com>
 <DHJNB77853FP.3601X6NYXA9LY@etsalapatis.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <DHJNB77853FP.3601X6NYXA9LY@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnEAZPm9dpf7bHDw--.44043S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyxCw45Kr45Gr1xZr4fKrg_yoW3CrXEkr
	Z7G3s5Za95Cr17Jw4kWw1qkFWIgr4DXryUAF4fZr1Ivrn8ZrWF9r95Ga93Aas7t34fAF1U
	uF47JFWfJFy2qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
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

On 4/4/2026 12:04 AM, Emil Tsalapatis wrote:
>>   	/* Pass 3: Adjust jump offset and write final image */
>>   	if (build_body(&ctx, extra_pass) ||
>> -		WARN_ON_ONCE(ctx.idx != ctx.epilogue_offset)) {
>> -		prog = orig_prog;
>> +		WARN_ON_ONCE(ctx.idx != ctx.epilogue_offset))
> This thunk is slightly different now, the WARN_ON_ONCE() won't be checked
> if build_body() succeeds.

Sorry, I do not see the difference here. The WARN_ON_ONCE() is still checked
when build_body() returns 0 (succeeds) due to the '||' evaluation.

> Do we even need it? AFAICT the only case it
> wouldn't trigger if build_body() fails is if it did so at the very last
> instruction. Alternatively, should we check it if build_body() succeeds
> instead to retain the old behavior?
>
>>   		goto out_free_hdr;
>> -	}
>>   

