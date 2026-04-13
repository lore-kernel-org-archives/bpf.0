Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4E740DFD5
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 02:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776047971; cv=none; b=LAd2DqhXX12H7R2FQZdT27sJNor2xszjVZZjUg0GuFWByPgRLSRwDWcqQc2v1Nf5+iYdnuwrSRGtWkTg1/GTjOut1/v9enVKeyXd6UlMuNrBvQUX3Ba9fCcav1Iauf13+AmI5TXRJpRuTQnBU4H0b2S0JDdYRvigpp+zAsZK8FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776047971; c=relaxed/simple;
	bh=5aMG8Y9lQBC4/Htgs6nHIi6KjiFrjSyf+BvWlgPjtiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHr2sOhPihs51bIGvseYhVI19XCic4zJ9rlDaPzTrNxySU2/rDoyZposogH3FDd5tAWPUoqWYh0h3K31NeV4vDnca024iQc15R8ypmblUWpQ32e9AszvvlRVWcpdtbXfmG9UHZ6e12abZZCsdLZBtySAZpgqmETxG4iMPm+yzKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wB3BS08V9xpm9JRAA--.5020S3;
	Mon, 13 Apr 2026 10:38:53 +0800 (CST)
Received: from [10.162.163.215] (unknown [10.162.163.215])
	by mail-app4 (Coremail) with SMTP id zi_KCgB3WzQ4V9xpQGdcAA--.53741S3;
	Mon, 13 Apr 2026 10:38:48 +0800 (CST)
Message-ID: <c93818d4-a556-48bf-b7d5-b5ece41c16bf@zju.edu.cn>
Date: Mon, 13 Apr 2026 10:38:47 +0800
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
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <CAADnVQ+m2pFaPbRi=A+tsROKP2CPPkny_LXUKR3vUgH2+u1jRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zi_KCgB3WzQ4V9xpQGdcAA--.53741S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhIACmnb9Y0J-AAAsh
X-CM-DELIVERINFO: =?B?hu/3YAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9LeWw/0zHTXLOK0vjQv36EbZtQvpwFWb/HW7AxFIyEVNuysBxI0evUGiFE5eaHszkKG9
	CgYkawT8MEqOzsJAP3ZM2fFnjTyJszEy35AMTVFTpy9YwEy1woGOLMoHT6tzSQ==
X-Coremail-Antispam: 1Uk129KBj9xXoWrur43Gr4xGw15KrWDKr17Jwc_yoWDAFcEk3
	95Kr1UJrWj9FnrZan3Cw1F9FWvkF1kCr13CrW8Xr13KF1UZan7WF40kas2v34Fy348Gry8
	Wr1vqFZFkF1I9osvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
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

Thanks for your review.

On 4/13/26 4:13 AM, Alexei Starovoitov wrote:
> The patch doesn't apply anymore. This function was moved.
> 
> Also see sashiko review. It flagged a real issue.
> 
> pw-bot: cr

Regarding the apply failure: My patch was originally targeted at the bpf
tree as a bugfix, where it applies cleanly. I see that commit f1606dd0ac49
renamed find_subprog() to bpf_find_subprog() in the bpf-next tree.

Given this conflict, would you prefer I rebase and target bpf-next for the
v7 submission, or should I keep targeting the bpf tree?

Regarding the Sashiko review: The issue of stack_depth exceeding MAX_BPF_STACK
during JIT fallback is indeed a pre-existing bug (it originally caused a
load-time OOB read). However, my patch inadvertently turned it into a more
critical run-time OOB read.

I will fix this properly in v7. I plan to change the return type of
bpf_patch_call_args() to int and add a strict boundary check of stack_depth
to safely reject the fallback.

Thanks,
Yazhou

