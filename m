Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAAB340A76
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776943570; cv=none; b=pLQjCcpg0UXIyQH7nHH1aZC9u+uqOtKlNtD+fKBYa9gEo/Pbd8JXpE5hIwQ7FUmjiEggQHx1jaS6C979Lg0fdui0ZNzrbuEKcYMnJpPO3XDkvywmoFJKtVeett9+p3ALQ3shQqVJT0QPo0MHFxG6vQ3dEZ8aOkCmyBn7YWmb7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776943570; c=relaxed/simple;
	bh=gWhsZ7A6OAJHZXOLsX1CYn69oaTJs0fZGt+loZzPFg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MItbYNev1pcspT+B0Sw/p//79hqFaOx7hMr5WLs8LC6fgrJdQraXOZ6xBn1QJSiTFDzBpnne4uYsEq+hiE9i7zX4rsP8HJWb05S2v+f7oSOTZCN7tmbWg++diE8XdwZdGnnwGMAGrhJrhBvHPcNfbrBHLPSBi8EwY8/2Ym0R540=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nzOh6IIK; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nzOh6IIK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=wgIen2v+MDc7ya6jPJxlqhDzIe69FhwYdwvZh9M7XAU=;
	b=nzOh6IIK6Byuwy6FPjVTc8h9MhhupFcOK6ROaNpBNEiS+Igt8L55ofW2xXO4m7
	SFiISoOe+uopSE5BfQ7igCqhnY/knsJruU/Iy3FJbDz9k7iGkssjVXvlNMR6rFbE
	kTlJF8B0Wgmzduz5RuYG85mHQFO0xbyYUq1u2Yqaz19I0=
Received: from [10.193.191.26] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBn_JJOAeppaE0sBA--.31S2;
	Thu, 23 Apr 2026 19:24:05 +0800 (CST)
Message-ID: <b67c42e6-27d4-455b-9db6-7eed719e007c@163.com>
Date: Thu, 23 Apr 2026 19:23:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: replace min/max fields with struct
 cnum{32,64}
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Yazhou Tang <tangyazhou@zju.edu.cn>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>, Paul Chaignon <paul.chaignon@gmail.com>,
 Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
 Tianci Cao <ziye@zju.edu.cn>
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
 <9d47111a-61c8-491b-8750-63fb79968125@zju.edu.cn>
 <DHZRWV9NZOPX.1PD401F76IUT9@gmail.com>
 <7a7f3455-3cb2-42a8-a1a1-47ba40ee1a2f@zju.edu.cn>
 <CAADnVQ+2O2zgdy11+vxE6dOp+3Br4zZBysHF-Hne7cP+eeucnQ@mail.gmail.com>
From: shenghao yuan <shenghaoyuan0928@163.com>
In-Reply-To: <CAADnVQ+2O2zgdy11+vxE6dOp+3Br4zZBysHF-Hne7cP+eeucnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBn_JJOAeppaE0sBA--.31S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1xJw4rXF47Ww1UJw1UZFb_yoW5Gr1fpF
	ZxJFs0kF4kJ39F9F92v3yavFyYva1xJFWUurn5GrW5A39IqrySvryxKr45ua4xG3Z3W347
	trW2vF98Za45A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UewZcUUUUU=
X-CM-SenderInfo: xvkh0w5kdr53ldqqmjqy6rljoofrz/xtbCzhVqa2nqAVX87AAA3d

Hi Alexei,

On 2026/4/23 0:13, Alexei Starovoitov wrote:
> On Wed, Apr 22, 2026 at 8:32 AM Yazhou Tang <tangyazhou@zju.edu.cn> wrote:
>>
>> Hi Alexei,
>>
>> Thanks for the quick response!
>>
>> On 4/22/26 11:03 PM, Alexei Starovoitov wrote:
>>> On Wed Apr 22, 2026 at 7:50 AM PDT, Yazhou Tang wrote:
>>>> This was built for potential integration into Solana BPF and is
>>>
>>> we were thinking about adding these insns as well
>>>
>>> uhmul64_imm   dst = ((u128)dst * (u128)imm)>>64       0x77    BPF_PQR BPF_UHMUL | BPF_K       v2
>>> uhmul64_reg   dst = ((u128)dst * (u128)src)>>64       0x7f    BPF_PQR BPF_UHMUL | BPF_X       v2
>>> shmul64_imm   dst = ((i128)dst * (i128)imm)>>64       0x87    BPF_PQR BPF_SHMUL | BPF_K       v2
>>> shmul64_reg   dst = ((i128)dst * (i128)src)>>64       0x8f    BPF_PQR BPF_SHMUL | BPF_X       v2
>>>
>>> if you have kernel patches for that please share.
>>
>> We haven't implemented the interpreter and JIT backends for these
>> new uhmul64 and shmul64 instructions yet. However, we are actually
>> very familiar with these specific high-half multiplication
>> instructions, as they are already implemented in Solana BPF
>> (which we work closely with).
>>
>> We would absolutely love to take this on for the Linux kernel.
>> We can prepare the implementation across several RFC patchsets,
>> which will include:
>>
>> 1. Verifier: The value analysis for these new uhmul/shmul instructions
>>      using tnum and the upcoming cnum, backed by our formal proofs.
>> 2. Interpreter: The core implementation in kernel/bpf/core.c for
>>      these 4 instructions.
>> 3. JIT support starting with x86_64 (and subsequently arm64, etc.).
>>
>> (Note: We assume the LLVM frontend/backend support for emitting
>> these instructions might be handled separately, but we are happy
>> to provide the kernel-side implementation first).
>>
>> For the initial RFC, we plan to focus on the first two parts
>> (the Interpreter and Verifier semantics) to establish the groundwork.
> 
> We need to see end-to-end first. Which means LLVM + x86 JIT.
> You can skip the interpreter completely.
> The verifier needs to check safety of the operations,
> but updates to cnum/tnum should be conservative. Just mark as unbounded.
> No need for formal proofs or cnum work.

Regarding new eBPF insns topic, we will give an end-to-end solution in the
next RFC proposal once a prototype is ready. Please let me know if there
are any additional points you would like to highlight, discuss, or share.

Alternatively, we can have a deeper discussion when the prototype is ready.

Best wishes,
Shenghao and Yazhou

