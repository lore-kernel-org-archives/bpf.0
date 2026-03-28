Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D3620C490
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 02:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774663510; cv=none; b=li/3zZnaFMbk1EeA8TqCKdyB3tR80JGLyLyAmJfGkjQdIMIdkEmCAj/7QS3s1u1qEjw45GBXomh5IH281/bBDhUmX19I1fR7yl1623WwnO4Ln2XhvflO/XGUHTW5uG7ejN/Vub9zIp3DsPSIMTUraqoAhe9apkJq8obw78savAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774663510; c=relaxed/simple;
	bh=JtHgUqkwdkCRYNz15WJdO1o1AFeketY7ygfEvn8DbNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rmoh8DGA25bxjAaxXe3hFxXqz/84FFHCBLmasvsz7jCdC/G+QJdMOH5FdcUWAZZ+krfFhtYovmxyzqcgPCIkn/euwwsyO/S4huOs89XBU5dFaBFis8fv4UuAtVLTK7oL1iS+EAlg5wpDHGRsVYvKPzXfQY0h7pq+aFgZgTyRXfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fjLS22jZDzYQtkZ
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 10:04:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 17CDA40594
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 10:05:05 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgDnEAZPN8dp4urjCQ--.23758S2;
	Sat, 28 Mar 2026 10:05:04 +0800 (CST)
Message-ID: <fa28e388-fbd4-43af-982a-828f5c0456eb@huaweicloud.com>
Date: Sat, 28 Mar 2026 10:05:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5 1/3] bpf: Reject bpf-to-bpf call with large offset
 in interpreter
Content-Language: en-US
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com, ziye@zju.edu.cn,
 Emil Tsalapatis <emil@etsalapatis.com>
References: <20260326090133.221957-1-tangyazhou@zju.edu.cn>
 <20260326090133.221957-2-tangyazhou@zju.edu.cn>
 <319906e9-3b47-472f-9a11-a0da60626144@huaweicloud.com>
 <9a61d64e-7943-4e39-8c82-c79bb9ac65b4@zju.edu.cn>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <9a61d64e-7943-4e39-8c82-c79bb9ac65b4@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnEAZPN8dp4urjCQ--.23758S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyDXr17Jr15XFWfXw18Xwb_yoW8Xr43pF
	Wvga4Yyw1DA39Fk397Zw48Aw1jgrs2ya1UGFZ8GryfAw43Gr1YvF15KFZY9Fy29rs3Cryj
	qFWYv34kAas0kaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
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
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/27/2026 5:37 PM, Yazhou Tang wrote:
> Hi Kuohai,
> 
> On 3/26/26 21:45, Xu Kuohai wrote:
>> Maybe I’m missing something, but since interpreters_args is a small array, why not
>> just store the index (round_up(stack_depth, 32) / 32) - 1 in insn->off?
>>
>> That way, the interpreter could directly use this index to find the function address,
>> without needing insn->imm to record the address offset, thus avoiding the need to use
>> another field like insn->off in the instruction to back up the original insn->imm.
> 
> Thanks for the suggestion! Conceptually, storing the array index in insn->off and keeping the 32-bits insn->imm unchanged is a very elegant way to solve this problem.
> But I think it will introduce a performance regression in the interpreter's hot path (___bpf_prog_run).
> 
> Currently, the array lookup is done once during verification. The resulting offset is stored in insn->imm, allowing the runtime to use a fast ALU addition: __bpf_call_base_args + insn->imm.
> 
> However, If we store the index in insn->off instead, we force the runtime to perform a memory load (interpreters_args[insn->off]) on every single bpf-to-bpf call.
> 
> Because of this overhead, rejecting out-of-bounds offsets at load time with -EINVAL (as done in v5) seems to be the safer and more performant trade-off.
> 
> What are your thoughts on this?
>

Do you have any performance data?
TBH, I am curious if the overhead is even measurable.

> Best,
> Yazhou
> 

