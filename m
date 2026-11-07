Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017788;
	b=nBCfP3wYwvTPh6Tykq1MHpO/SCguHLGACix807/BfjeNrCG01/6BUR2telUZtaxaJPcm
	 xgzNsaO0oQu7WG3Zdtvlbj0EJvrXfF7zvoBxFJ5/AN/ktPFHfUmzZkytRwL7wd9sPum9t
	 cuEG2JtjLKCS+coZqPioT/bPHb9vw1Q/KsbitEolASHwx48gwxtQ5ZNbUttJyx30Oqf6l
	 Rf6N4HJ94C/ZVSZUiwkQ145rtq6TqP7QXIdQL0GpBK9EAccWZ0AMFtu6FDvC6/p9Bhx7l
	 UZkABaUzxVbycPclrmyFI+12gkNHCuYqLXt6BDv0sZoHPK5LkR8i2GXai5XoUIcGThA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017788;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=blAcGwT6RrU9VkPRjXupRrOhmEXz2ix0BTNPVck3W3E=;
	b=exVnkRbBIqn3TDTwfvWbnngHt1t1iMA0YHxJ7zqib+a8ybuT8udqSzYAzAbNofIFIEUw
	 83R4i0sCNBeyGZ3pZHDHqvNW7/POjeHMpDc8PgpjtjqmynP/aHEjC0FYH/xQEeS/kwk47
	 dnVibN90lbW7UfG8QGvZ8o0QzTDFXHhBYcO3A1px/XgQC+SlVveI7sEz3CBwugBXky9lD
	 0O0O5kxPbUd6bpARLCbKt7GShhOSX+ZU+5I9+YKNsdWHlAZaZy+z+ElihShQTHffQsWvf
	 yoCHUbzF42oI1aLi4BKtMzfvAgzpHx2EN9gpMA6njVr86h0ibEEUl2IY/rNOz71u3UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7CD606A326;
	Sat,  7 Nov 2026 02:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E7CD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxS_D4ie5qOEwdAA--.19238S3;
	Sat, 07 Nov 2026 10:16:24 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxX8_zie5qfOEyAA--.38436S2;
	Sat, 07 Nov 2026 10:16:20 +0800 (CST)
Subject: Re: [PATCH v1 2/2] LoongArch: BPF: Use beqz and bnez instructions for
 trampoline
To: Huacai Chen <chenhuacai@kernel.org>
Cc: bot+bpf-ci@kernel.org, hengqi.chen@gmail.com, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
References: <20261102072808.23080-3-yangtiezhu@loongson.cn>
 <c3b8e6ae47164ab1a643a1730f0600993de03c8a30e35122a9812ac73d807697@mail.kernel.org>
 <1276eb14-b851-aee7-36ad-d61e2ddd9ba4@loongson.cn>
 <CAAhV-H4GyC5=PvF5yvYnoBpUpU3VTuE8kdNUnApNqvN4vHZfhg@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <20f7051a-4f56-7122-c241-93948c465dc9@loongson.cn>
Date: Sat, 7 Nov 2026 10:16:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4GyC5=PvF5yvYnoBpUpU3VTuE8kdNUnApNqvN4vHZfhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxX8_zie5qfOEyAA--.38436S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw4DJr1DJw1fArW3ZFWrJFc_yoW8JFWDpw
	s5JF17KF95tr47Zrs2y3yFga4Fkw1IvFW7W3W5CFyrGw1rAr1IqrWxWryS9FyUXr1I9F1F
	vFyvqFWkWa1UZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUceOJUUUUU

On 11/6/26 10:45 PM, Huacai Chen wrote:
> On Tue, Nov 3, 2026 at 10:27 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> On 2026/11/2 下午3:53, bot+bpf-ci@kernel.org wrote:
>>>> LoongArch: BPF: Use beqz and bnez instructions for trampoline
>>>
>>> TL;DR: Commit message only: the claimed branch-overflow risk looks impossible,
>>> since trampolines fit in one page and the old code behaved identically, so the
>>> Fixes: and Cc: stable tags may not be justified.
>>
>> ...
>>
>>> Could the changelog drop the overflow-risk wording, or describe the change
>>> as a cleanup, and could the Fixes: and Cc: stable tags be reconsidered given
>>> that stable-kernel-rules requires a fix for a real bug?
>>
>> Will update the commit message and remove the 'Fixes' and 'Cc: stable'
>> tags. If no more comments, I will send out v2 next week.
> Fixes can be removed but I suggest keep Cc: stable, the overflow risk
> actually exists.

Since the branch overflow is technically impossible under the current
1-page limit of BPF trampoline, I plan to drop the Fixes and Cc: stable
tags in v2 to align with standard upstream cleanup rules.

If you still prefer to backport this for architecture-level defense,
please feel free to append the Cc: stable tag when applying the patch.

Thanks,
Tiezhu

