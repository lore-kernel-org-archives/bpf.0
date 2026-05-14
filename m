Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421BA1A7264;
	Thu, 14 May 2026 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762743; cv=none; b=lmqE061zkHmVAQjsqyyG9+y7zVFZdcERaJ1Q0T0NnQxup80OmDRH9UXz8kMr58476pY/e9j9IkXRsyxnrnXjXCUTdp2JBOsReghMkTlVpeINQQt6s7rgERtbtHWK7nTefSDB3JrMzcQCVlXPrT9LFIfJ83gXNay0YCVR6y2zghA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762743; c=relaxed/simple;
	bh=PWWsmg54Tt9lOl/hezGdPbbSgqsb5bTfM8zh+lNGJDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqJdg5A54tlsSrFdAxRZOl8Kh6aQhDvKG+X9AH417ZRZAjf4sbQgafEfxp45aDBuOY5UfyTMNZhweVRuaSicYqQgYowAj/2bVS5lOhxBFi0sKNl1K8QHpN4SAFQWoyULK0jh30ZEqZ9kR+jY928tnJ/JyzIW8lwQG6Dij71Tm1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=KgIiF83b; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="KgIiF83b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=LhIddh5A0idIBMcsr1JbG9HJj5gIEsxku/D3rEHjSd4=;
	b=KgIiF83bvkBoWrOJt21KU4laLGcgZnELd4jSF16AhS0rl1clquCrfqrsg/ZvxF
	l5vIBz10pPCPhYuae/nnfCtBC0TOslSvlqb+uEZt2ym8Q/lMQp4X7jLTBzGJGl2R
	xaEGX0HM7dtc/G17Tx9/Nv+0bNJQLtsMcV7qXJ5PLvFCQ=
Received: from [IPV6:2408:8210:480a:2590:67b8:4623:bebc:2a2] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3V+MXwgVq_hZ5BQ--.62255S2;
	Thu, 14 May 2026 20:37:44 +0800 (CST)
Message-ID: <cec221f3-a97b-4a84-b1e2-0820ccac11a2@126.com>
Date: Thu, 14 May 2026 20:37:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] tools/lib/bpf/libbpf: Prioritize module kfuncs
 over vmlinux kfuncs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, andrii@kernel.org,
 eddyz87@gmail.com, alexei.starovoitov@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260510030136.27876-1-chensong_2000@126.com>
 <CAP01T77aPyqjV+9CVVL-YSEajvQYaMg9SNX3fygr0kTeKrBquw@mail.gmail.com>
Content-Language: en-US
From: Song Chen <chensong_2000@126.com>
In-Reply-To: <CAP01T77aPyqjV+9CVVL-YSEajvQYaMg9SNX3fygr0kTeKrBquw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3V+MXwgVq_hZ5BQ--.62255S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryDKF18KFWUWF1xtF1DWrg_yoW8KrWkpF
	45Kr4YkF48Jr9akanaqF4jqr90g3yfKr4jqFy3Jw17AF1YqFyIvFnFyr1ruFyDCws7Ja4D
	uayjqF17Ca45ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUfHUUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpBiSEmoFwhjfJgAA3w



On 5/12/26 09:33, Kumar Kartikeya Dwivedi wrote:
> On Sun, 10 May 2026 at 05:05, Song Chen <chensong_2000@126.com> wrote:
>>
>> Change the kfunc resolution order in find_ksym_btf_id() to search
>> module BTFs before vmlinux BTF. This allows kernel modules to override
>> vmlinux kfuncs with the same name, enabling a form of live-patching
>> for kfuncs.
>>
>> Previously, vmlinux kfuncs were always preferred, making it impossible
>> for modules to provide enhanced or fixed versions of existing kfuncs.
>> With this change, modules can now override kernel kfuncs, while
>> programs that don't use module BTFs remain unaffected.
>>
>> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Signed-off-by: Song Chen <chensong_2000@126.com>
>>
>> ---
>> changelog:
>> v1 -->  v2:
>> 1, introduce namespace to specify which module the kfunc belongs to, like:
>> modulea__foo
>> moduleb__foo
>> foo
>> As a result, kfunc foo can co-exist in modulea, moduleb and vmlinux, ebpf
>> code owner can specify which one he wants to call.
>> ---
>>   tools/lib/bpf/libbpf.c | 60 +++++++++++++++++++++++++++++++-----------
>>   1 file changed, 45 insertions(+), 15 deletions(-)
>>
> 
> Instead of modulea___ prefix, how about using declaration tags instead?
> We can use `namespace:vmlinux` and `namespace:module` to choose
> precedence for module or vmlinux.
> Then further scope using `namespace:moduleA` or `namespace:moduleB`.
> 

Thanks for the suggestion. Just to clarify — are you proposing this
as a BTF/string-level naming convention, or as something that would
appear in actual C identifiers? Since colons aren't valid in C
identifiers, I want to make sure I understand the intended mechanism.


> By default, I think preferring vmlinux symbols over modules makes
> sense. If one wants to prefer an overload with the same name coming
> from a module, they can place the right tag. But we need more
> consensus from other folks before you respin again. If we didn't have
> a way of indicating the preference, I would agree picking the one in
> module would allow more interesting cases by default, but since we do
> have a mechanism, it makes sense to pick a more sensible conservative
> default, in my opinion.
> 
> Anyway, let's see what others might say.
> 
yes, many thanks.

Best regards,

Song

> pw-bot: cr
> 
>> [...]

