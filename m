Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C563859FF
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676985; cv=none; b=iemTKkIVKZWZKFZmMgE75+eKFbVFpdCOjY4hIZnrew8H7tUfna7e7o4+1VjXM8PFpl8gUgKcBzAsJhDaVm+wzSWN6PiTkk8ZlLSKo8R1g1783sEx+d9dPnifWAw84gnGmT7rC6za4DogluQL7joXml37kqDC0+sV4t0TfhhYYtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676985; c=relaxed/simple;
	bh=QbU1Bv7XlXjeylyNRX1ywIrS3AGROOjExS8d6DjLuC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCL+eLjpP3r3OGoV5OY2jR4+rbovL5VAlOn5uUBcIKyO5ZWZR+KQC6IHgsDsVyqjdL568l93++dmOckWk44SI2RjD+vLeFB/TTsnLGuXAc0SUpYXN0BgafJkWN3nvY9SPkF+oPbO1ohwQ2JN3QwSa7Efl92In9xALavMZJzLnSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wCHUT1K8OVpKESQAA--.1050S3;
	Mon, 20 Apr 2026 17:22:19 +0800 (CST)
Received: from [10.162.163.215] (unknown [10.162.163.215])
	by mail-app3 (Coremail) with SMTP id zS_KCgDX7nA18OVptwGYAA--.45924S3;
	Mon, 20 Apr 2026 17:21:57 +0800 (CST)
Message-ID: <34a15577-6624-4bbc-a435-17b67e50d2db@zju.edu.cn>
Date: Mon, 20 Apr 2026 17:21:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v6 1/2] bpf: Fix s16 truncation for large bpf-to-bpf
 call offsets
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Eduard <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Yazhou Tang <tangyazhou518@outlook.com>,
 Shenghao Yuan <shenghaoyuan0928@163.com>, Tianci Cao <ziye@zju.edu.cn>
References: <20260412170334.716778-1-tangyazhou@zju.edu.cn>
 <20260412170334.716778-2-tangyazhou@zju.edu.cn>
 <CAADnVQ+m2pFaPbRi=A+tsROKP2CPPkny_LXUKR3vUgH2+u1jRg@mail.gmail.com>
 <c93818d4-a556-48bf-b7d5-b5ece41c16bf@zju.edu.cn>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <c93818d4-a556-48bf-b7d5-b5ece41c16bf@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zS_KCgDX7nA18OVptwGYAA--.45924S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgEHCmnlMA0gewAAsg
X-CM-DELIVERINFO: =?B?NHMjRQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9LWfTdLO/jvf4uyl6EkhHCcvQpsbwE/ffp/bQo9WFjSq8rfD44e/Iya1gM48wY12sRJU
	aJ/1cHrYqkC54pFFkfnxfILks/U83LiiZ23xeeuob/gxCSot8oINbDM06ETMsA==
X-Coremail-Antispam: 1Uk129KBj93XoW7tw4UXryxKry3Jw1UZFy8CrX_yoW8XrWfpa
	n5Kw4UJrZ5JayIyF929F4DWFWfK3yIgFW5Zr4rGrykZw13JF97KrWxKF4q9as8Z3Z5Cr43
	C3yjk3s3Za1UCagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGO
	UUUUU

Hi Alexei,

A gentle ping on this thread.

If you don't have a strong preference regarding the target tree,
my plan is to rebase this patchset onto the bpf-next tree to
resolve the conflict with bpf_find_subprog().

I will also include the fix for the run-time OOB read caught by
Sashiko, and send out v7 later this week. Please let me know if
you'd prefer me to take a different approach.

Thanks,
Yazhou

On 4/13/26 10:38 AM, Yazhou Tang wrote:
> Hi Alexei,
> 
> Thanks for your review.
> 
> On 4/13/26 4:13 AM, Alexei Starovoitov wrote:
>> The patch doesn't apply anymore. This function was moved.
>>
>> Also see sashiko review. It flagged a real issue.
>>
>> pw-bot: cr
> 
> Regarding the apply failure: My patch was originally targeted at the bpf
> tree as a bugfix, where it applies cleanly. I see that commit f1606dd0ac49
> renamed find_subprog() to bpf_find_subprog() in the bpf-next tree.
> 
> Given this conflict, would you prefer I rebase and target bpf-next for the
> v7 submission, or should I keep targeting the bpf tree?
> 
> Regarding the Sashiko review: The issue of stack_depth exceeding MAX_BPF_STACK
> during JIT fallback is indeed a pre-existing bug (it originally caused a
> load-time OOB read). However, my patch inadvertently turned it into a more
> critical run-time OOB read.
> 
> I will fix this properly in v7. I plan to change the return type of
> bpf_patch_call_args() to int and add a strict boundary check of stack_depth
> to safely reject the fallback.
> 
> Thanks,
> Yazhou

