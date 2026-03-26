Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADF43C3434
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519104; cv=none; b=RhJpmpopTWEh8QwFu80WMg0yoiQDHLMeQscLHAZqw+rt+/dysiLp/8FmN/HJfng9OTkl+im1EcAfNATwBnQQhUDQueMFvkBTJrq4D02aeXn4NlW05PC5/c0UAoOcLlOVWm4UbakmekrIVB9ajDFo0qbiVJY3Bu39qujIXa6nQIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519104; c=relaxed/simple;
	bh=oikzp10J2ldiw/wzSNsbBFDlrKScj41nc4sjR1M/qBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQPXADNY6spX3+jG+2S7JUTX95Xv47ZX14J/1CJ+cYYEGPkrRkvMsYmhBVgy7a38Ykt94C0wjfuMXbEAM5XoNZB2s3goWIf85mcF/OPpWxFbyrU/J5QnD5OJhDta/GMjD01dejUAGp613LWNezLU2j28hIaeIaFW31EWc2LfheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [115.236.2.94])
	by mtasvr (Coremail) with SMTP id _____wCHwAkWA8Vp0EsGAA--.144S3;
	Thu, 26 Mar 2026 17:57:43 +0800 (CST)
Received: from [0.0.0.0] (unknown [115.236.2.94])
	by mail-app4 (Coremail) with SMTP id zi_KCgBnmjEUA8Vpk7YcAA--.28149S3;
	Thu, 26 Mar 2026 17:57:41 +0800 (CST)
Message-ID: <dc459496-fe51-4927-9192-ad7a68ca9a08@zju.edu.cn>
Date: Thu, 26 Mar 2026 17:57:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5 3/3] bpf: Fix incorrect subprog ID in dumped
 bpf_pseudo_call instructions
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn,
 Emil Tsalapatis <emil@etsalapatis.com>
References: <20260326090133.221957-1-tangyazhou@zju.edu.cn>
 <20260326090133.221957-4-tangyazhou@zju.edu.cn>
 <CANk7y0iuC=4aD+zzJujWrwdref0zA+ZOt4Uqst_bOM+7Kqweug@mail.gmail.com>
 <CANk7y0gKbC22yrsBec_6JmyLSN76eTshcX2_W_zhSYSgXkenxQ@mail.gmail.com>
 <afaa5cb2-57d4-4fc8-849e-34db300f34a3@zju.edu.cn>
 <CANk7y0jjLH_hYm4Ga9WAs03-QicbVPxqPWJQFRvqSVud_5We1A@mail.gmail.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <CANk7y0jjLH_hYm4Ga9WAs03-QicbVPxqPWJQFRvqSVud_5We1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zi_KCgBnmjEUA8Vpk7YcAA--.28149S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhICCmnEOospAQAAso
X-CM-DELIVERINFO: =?B?RASA8AXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9DXIn+6ro37HmzLxrMvvUs+iM6gEeWNzRbRVd/5lM0J/dphEymzyql+cmgCDuS4EsUZx
	e2QGIhOz/qsosBQlEmmBRHqX/uYC/okkLEbCXNvBW64oPiS26Z2xqUjAVse3Qg==
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280
	aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I
	0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
	1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	YxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=

Hi Puranjay,

On 3/26/26 17:51, Puranjay Mohan wrote:
> If I understand correctly, truncated insn->off will only be used for
> dumping the program assembly and will not affect the program at
> runtime. My suggestion would also be to keep the comment but not add a
> WARN() as it is unnecessary log spam.
Makes sense. This is exactly what I did in patch 3/3 of v5.

Thanks,
Yazhou

