Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE63E95AE;
	Tue, 10 Mar 2026 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128366; cv=none; b=MJOIgxe6V8l600xuzOyspQSMMGDZO9L73tln6aeJhJTHKGQruabss244higp0yb2+0I68BoauzFnlvPuurORxgQYJXeDKlWvN2/GJ2pYBxCu4P4E8bGMnOkNfaxPjEX/g2B6+NoiyFXR+Qfa78YD3Tu18Rd3wQVqdAptWdKV0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128366; c=relaxed/simple;
	bh=sSM6VyXq3GO2cyQKqMQUbuDrniGTOcw6nGb9h+6jtc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8v3f7rjsS/yIs8I54VMFZAF5uYRJEfm/Y5BLG55+GZm9Bn+eCZsvmJPGvEitmDs0FSD72PAUjxUEhpmvlkXqoBHKRGEp44MKYlEkJQagCFfgjg9JHQ7oEgXeDjLNkpSKT2tP58chKBnjBdv8YvqcoiP1rGSjKQUXVEtD7Xiirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fVQjM4NzczYQv74;
	Tue, 10 Mar 2026 15:38:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 068144057A;
	Tue, 10 Mar 2026 15:39:17 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgAnBVKgyq9pcMZ+AQ--.56907S2;
	Tue, 10 Mar 2026 15:39:13 +0800 (CST)
Message-ID: <017ac6a8-2a17-41c0-8bfd-bd7bdd76509f@huaweicloud.com>
Date: Tue, 10 Mar 2026 15:39:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next v8 1/5] bpf: Move constants blinding from JIT to
 verifier
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
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
References: <20260309140044.2652538-1-xukuohai@huaweicloud.com>
 <20260309140044.2652538-2-xukuohai@huaweicloud.com>
 <7905ed2d99a46a2f7a4eb41d4cb9f1dec108ecd3.camel@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <7905ed2d99a46a2f7a4eb41d4cb9f1dec108ecd3.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAnBVKgyq9pcMZ+AQ--.56907S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWDKF45Zr48uFWfAF43ZFb_yoW8KFyxpF
	4DJF17Cw4qgr4UWF47t3W8JF4Utw4jgFW7uF4YkrZYkFn0qrs7XF1ak3yj9FZxZry5Xw1r
	Aay8Kr9Fka4v9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jxCztUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/10/2026 5:25 AM, Eduard Zingerman wrote:
> On Mon, 2026-03-09 at 22:00 +0800, Xu Kuohai wrote:
> 
> This was discussed some time ago in [1]. In that message Daniel notes
> the following:
> 
>    > constant blinding needs to work from native bpf(2) as well as from
>    > cbpf->ebpf (seccomp-bpf, filters, etc)
> 
> It appears this patch does not address the cbpf->ebpf part, or did I
> miss something?
> 
> [1] https://lore.kernel.org/bpf/284404c7-c6e0-4cf9-8ada-71ebfc681541@iogearbox.net/
>

Hmm, I overlooked that the cbpf jit also needs constant blinding. I'll add it back
in bpf_prog_select_runtime() before the JIT is invoked.

> [...]
> 
>> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
>> index 52162e4a7f84..7a7c49640a2f 100644
>> --- a/arch/powerpc/net/bpf_jit_comp.c
>> +++ b/arch/powerpc/net/bpf_jit_comp.c
> 
> [...]
> 
>> @@ -272,7 +250,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>>   				       extra_pass)) {
>>   			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
>>   			bpf_jit_binary_pack_free(fhdr, hdr);
>> -			fp = org_fp;
> 
> Is it necessary to set `...; fp->jited = 0; ...` here?
> It seems it does if extra_pass is set.
> 
Yes. When extra_pass is set, orig_fp and fp are the same, so the original
fp = orig_fp cannot restore fp either.

>>   			goto out_addrs;
>>   		}
>>   		bpf_jit_build_epilogue(code_base, &cgctx);
>> @@ -301,7 +278,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>>   
>>   	if (!fp->is_func || extra_pass) {
>>   		if (bpf_jit_binary_pack_finalize(fhdr, hdr)) {
>> -			fp = org_fp;
>> +			fp->bpf_func = NULL;
>> +			fp->jited = 0;
>> +			fp->jited_len = 0;
>>   			goto out_addrs;
>>   		}
>>   		bpf_prog_fill_jited_linfo(fp, addrs);
> 
> [...]
> 
>> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
>> index 1f9a6b728beb..d6de2abfe4a7 100644
>> --- a/arch/s390/net/bpf_jit_comp.c
>> +++ b/arch/s390/net/bpf_jit_comp.c
> 
> [...]
> 
>> @@ -2383,7 +2360,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>>   	if (!fp->is_func || extra_pass) {
>>   		if (bpf_jit_binary_lock_ro(header)) {
>>   			bpf_jit_binary_free(header);
>> -			fp = orig_fp;
> 
> In the similar condition for powerpc you reset `...; prog->jited = 0; ...`,
> is this case different?
>

No difference, will fix it.

>>   			goto free_addrs;
>>   		}
>>   	} else {
> 
> [...]

