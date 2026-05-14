Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DEB26E6F2;
	Thu, 14 May 2026 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763399; cv=none; b=j9OByynnvViCUQcSniNS/eqRS3uS61Tm517T3AdNekSP1aK93k6SgEVJGzhrWxX7X2I19Jk7HRkaC7H89uKxMCOdAdzFu3XJcwWBmUi9v3ikZJ6mUVGg7L9dUETr4UBCMR84PLWFc2b59GKKJrLNLCMyUqu99Y5trgXF/BpRUGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763399; c=relaxed/simple;
	bh=uglqWkjQj7k166v/81/IlINnqfNqtutuvd2/6x8TRKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+wFTc3SVB3WVDsSNx8vSBZL1VMOdyhF7t1g8aYgpdLlmalj0Jj4aoEla/8pCkgafsRF+p+qEyn7YlZ/MHeIApbQIKhHxIIVi2TeY5K7zsINkJ1OmUZscK+STvQ7ybpYzpGIPYz8CBfZQvBVeCOGGAn3VvPYq+d8+lfIeKpyIIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=bHr/o2oB; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="bHr/o2oB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=wBc31Z2aJ0NXPmoiDoThoZ4VxZwWQ0Np3xYdMN7R5xI=;
	b=bHr/o2oBXEI9Al9e9EHPz/JQubsICvk8qukrvGyozW9QJSv+/43LCocvFp5jrs
	yROPIL/EIpp7M9jWWpt/Ry+S7T0lnpTNVwdjf7wWrDljmR8RtaAoNtOWNFhPrSSW
	ski9KnWrViChueUUPVjN4Z4R69aNpNFpKI47gJhmzV3PM=
Received: from [IPV6:2408:8210:480a:2590:67b8:4623:bebc:2a2] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3l_gYxgVq6ikhBg--.5614S2;
	Thu, 14 May 2026 20:54:49 +0800 (CST)
Message-ID: <f61ecd8f-675d-41e6-bdad-4496f5ecd076@126.com>
Date: Thu, 14 May 2026 20:54:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] tools/lib/bpf/libbpf: Prioritize module kfuncs
 over vmlinux kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, Hao Luo <haoluo@google.com>,
 KP Singh <kpsingh@kernel.org>, Song Liu <song@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>
References: <20260510030136.27876-1-chensong_2000@126.com>
 <a439f19e-1a47-46ce-8a2c-c53c9f038b8d@linux.dev>
 <CAADnVQLNLd7kV+pBV1i7YvPoQGMVzJusS71iPs6oc_K0Qpd9fA@mail.gmail.com>
Content-Language: en-US
From: Song Chen <chensong_2000@126.com>
In-Reply-To: <CAADnVQLNLd7kV+pBV1i7YvPoQGMVzJusS71iPs6oc_K0Qpd9fA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3l_gYxgVq6ikhBg--.5614S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4kAFy7Wr4DCFWUZr1rCrg_yoW5Gr1fpF
	W5GrnY9rs2q34xXFn7ZF1UWF129FWfJa1YvFn5X34xCw1Ygr4IvFW0vw4Y9FZ8trW8Kay0
	vFW2va4ak34UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCjgcUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBsxmTE2oFxhmFeQAA3m

Hi;

On 5/13/26 05:41, Alexei Starovoitov wrote:
> On Mon, May 11, 2026 at 8:19 PM Kaitao Cheng <kaitao.cheng@linux.dev> wrote:
>>
>> It seems that there are two problems to solve here:
>>
>> 1. Allowing kernel modules to override vmlinux kfuncs with the same
>>     name.
>>
>>     This should be relatively straightforward to implement by matching
>>     names in kernel modules first, and then falling back to vmlinux.
>>
>> 2. Handling the case where different kernel modules have kfuncs with
>>     the same name.
>>
>>     Could we use a new libbpf API to establish the mapping manually?
>>     for example:
>>         bpf_object__set_ksym_btf(obj, "kfunc_name", "module_name")
>>
>>     Or define a new attribute, for example:
>>         extern void kfunc_name(void) __ksym __module("module_name");
>>
>>     We probably need to hear suggestions from other developers on this.
> 
> I'm not excited about 2.
> Two different modules are not allowed to have two different functions
> with the same name.
> The kernel has only one global namespace.
> Hence I don't think we should be introducing such namespacing concept
> into kfuncs.
> 
> But 1, I feel, is useful for experiments and mitigations,
> but it probably should be done transparently to libbpf.
> 
> register_btf_kfunc_id_set() should be changed to return an error
> when a module attempts to register a kfunc with a name that already
> exists in the kernel.
> We also introduce override_btf_kfunc_set() that would register
> a replacement kfunc.
> override_btf_kfunc_set() would check that all overriding kfuncs
> have the exact same kfunc already in vmlinux BTF: proto and name should match.
> Then the kernel will just remember that the address of that kfunc
> is in the module.
> libbpf doesn't need to be aware of this substitution.
> It will find kfunc in the vmlinux BTF, but the verifier will supply
> implementation from the module to bpf prog.
> 2nd module should be able to override_btf_kfunc_set() from vmlinux
> and from 1st module that replaced some kfuncs.
> All that only for bpf progs that are loaded after override.
> Already loaded progs don't need to be live patched.
> Thoughts?

If i understand you correctly, you suggest instead of introduce 
namespace in libbpf, we should replace kfunc in 
vmlinux(btf->types[type_id]) with kfunc in modules by introducing 
override_btf_kfunc_set.

In [1], I simply returned an error, your suggestion is a little further 
than that, correct me if i'm wrong.

[1]:https://lore.kernel.org/all/20260122090404.15553-1-chensong_2000@189.cn/

best regards,

Song

