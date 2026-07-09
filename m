Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127953624D4;
	Thu,  9 Jul 2026 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609788; cv=none; b=Mgpdylsv17cEbzNVECtN/9uBNmz/UemCl/pf2KDKNwjGwf4Mcql1xBcJmz6NtZwwTabTdX/a2LG5lVerGuHLoIi+6lK0/5bTv5VST+8/1jbKM5rCOSofKlORfjdZ0VpH+W5ASjgDFIs0c8umHq0XTRyyLozUT9x83Tri4X9cz6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609788; c=relaxed/simple;
	bh=4SAXuezJs15/Icy6UwTi7EHJIBFfc3UDjHeLqVj9++0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nf4a2ZxHZy0Sb5q/yFyx4QpzEoRBwE5zwhLDMIl0tsQmeH7j1zCnrQ8i/gS06OESwzFkhg6XDpDliR0eM+bKI5FJSJEVb38lTIAnkf7W1V85PA6B+xGW9qMRU1OwKqKxJkMpNPr8ZKWNQtBdHhCO2ILnjJzMHav6SHFwBupz0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gwyzc41KWzKHMMD;
	Thu,  9 Jul 2026 23:09:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 508EE409D0;
	Thu,  9 Jul 2026 23:09:39 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgBnTCixuU9qsKCDAg--.2779S2;
	Thu, 09 Jul 2026 23:09:39 +0800 (CST)
Message-ID: <fc972c33-1b66-4979-97e9-71627fb6179f@huaweicloud.com>
Date: Thu, 9 Jul 2026 23:09:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 6/7] riscv, bpf: Mixing bpf2bpf and tailcalls
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, alex@ghiti.fr, pulehui@huawei.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260708064436.2971933-7-pulehui@huaweicloud.com>
 <a721df30ec2f824295000183c8e91f2c19d0bd56ae115b835b402be9eacc1c71@mail.kernel.org>
 <b4aadfde-9745-4c71-8dd4-ce433331f91b@huaweicloud.com>
 <CAJ+HfNi_icVbeB=jw-xnXrwzigZwP2OVRbzaF3VC87i6fDpdDw@mail.gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <CAJ+HfNi_icVbeB=jw-xnXrwzigZwP2OVRbzaF3VC87i6fDpdDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnTCixuU9qsKCDAg--.2779S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF48GrWkAF4xJrW7Kry3Jwb_yoW8ZF4UpF
	yruasrKFWkJFn2k3W7JF48Can0yrsxJ3yUGF1rJrnxA3s8Crn0gFW7G39Y9FyDursYkFy0
	9a1jgw45Jwn5A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/9 19:37, Björn Töpel wrote:
> Sorry for the delay here -- the bot had me thinking a bit.
> 
> On Wed, 8 Jul 2026 at 10:54, Pu Lehui <pulehui@huaweicloud.com> wrote:
> 
> ...
> 
>>> This assumes a fixed number of instructions before the tailcall entry
>>> point. When is_subprog is true, the rv_addi() instruction is not emitted,
>>> which means the tailcall entry point moves forward by 4 bytes relative to
>>> where RV_TAILCALL_OFFSET expects it to be.
>>>
>>> The tailcall entry is used in emit_bpf_tail_call() when calculating the
>>> jump target for the tail call. If RV_TAILCALL_OFFSET doesn't account for
>>> the conditional emission, could this cause the wrong entry point to be
>>> used when tail calling into subprograms?
>>
>> This is not an issue, subprog can not be the tailcall callee.
> 
> Say, that we have an entry function that does bpf_for_each_map_array()
> into a callback cb(). cb() is a subprogram, so no init of TCC. Now,
> cb() calls another subprogram that does a tailcall.
> 
> The callback to cb() is coming from the kernel, so a6 could have been
> clobbered, no? We're entering a subprogram coming from the C ABI. Now,
> if the callback calls a subprog that's tail-call reachable, the TCC
> can be garbage?

Sashiko reported the same issue yesterday. I verified that the verifier 
rejects cases where a tail call is invoked within a callback; 
specifically, while the callback's return value range is [0, 1], the 
simulation of the exit path in `check_helper_call` (handling the tail 
call helper) marks R0 as UNKNOWN, causing the verifier to reject it—so I 
didn't investigate further. However, I just verified that the verifier 
*does* accept the scenario where a callback calls a subprogram, and that 
subprogram subsequently calls a tail call. I believe this scenario ought 
to be rejected; perhaps some changes are needed in the verifier, 
otherwise tail calls on other architectures (like x86) would also be 
susceptible to infinite loop issues.

> 
> 
> Björn

