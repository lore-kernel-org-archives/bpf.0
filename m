Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243B135E1C0;
	Mon, 25 May 2026 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779695409; cv=none; b=XdP9R7xSLyGB/lNYTVSnFHOeuqCiHtYMKg05aemmKgnv+SUmN//Om/abmwia21TlxCg8Ykppb2ZnM3bNMPmc4EvBSlMT8HhI1WjrZ850QHRlvlmDaAy5F+wTXT10Qvkc8iANNaKlfZ7eex2sFwscvb0qj/qhGKtr+foCJnT1mJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779695409; c=relaxed/simple;
	bh=0z3FwoPCmTDA6eH9A7Wd6SvYizMYZW+8/bK5PbzUxdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hizLCVA+Z4CVpUkR1QjG2vcH8/WBgsB1lC7MmEN8DeRvKRXqY3a7MaIcSkgWYfx2kFdwMa3UdgswSeuMyL3EDNSGbjmejO5KRhcls1JdZcdclanqZvri9fdR6qesgOa/B2Rr0xrKBCrXqI/Bdo87ZTknTT0JeRUXF36XSAOxTQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Ejrow0VE; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Ejrow0VE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=LVPOoFvr82rb5v2iSCz0LdXvYwgsBV5EypSpRRlKRBg=;
	b=Ejrow0VECiHZYVO92FkJGQ4cC7gVtFwI8EbpVPUDkI8Rfk/cSoHAFXLvfcS+8X
	71pPHpRmEoB6wg2QCwpMr3ErEi8+TslANogX4/g73S3CwZlynB0bcBLiJaujKzuy
	RAk68rQvKPgjzv0WVijAFJZ4R0HrtyoCzuaV6uaI25N+o=
Received: from [10.41.105.18] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_0Wg_hNq5X35AA--.1368S2;
	Mon, 25 May 2026 15:47:46 +0800 (CST)
Message-ID: <ea0903f9-8fe3-41eb-940d-00b469cef26e@126.com>
Date: Mon, 25 May 2026 15:47:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kernel/bpf/btf.c: reject to register duplicated kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bot+bpf-ci@kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kaitao Cheng <kaitao.cheng@linux.dev>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20260524082944.10625-1-chensong_2000@126.com>
 <e5ca9aed83f28248172fb088e55dc1cf7170417b0e45ec564ee0da4791bcee99@mail.kernel.org>
 <CAADnVQKVwHLX8-jo48zAijROpJ_K1VqgF=gG2oxiO0Mw7EeObA@mail.gmail.com>
Content-Language: en-US
From: Song Chen <chensong_2000@126.com>
In-Reply-To: <CAADnVQKVwHLX8-jo48zAijROpJ_K1VqgF=gG2oxiO0Mw7EeObA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_0Wg_hNq5X35AA--.1368S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy3GFy3Jw15tr18JF4ktFb_yoW8CF1DpF
	4rJF4YkF40y345X34Ig3WDWr1Yyry5Gw4a9Fn5KayfZrZ0grsFqFW0kw45uayIkr48Gw1I
	vw4j9a9Yvw4fZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jRlk3UUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBsgJHxmoT-qID7gAA35

Hi,

在 2026/5/24 17:42, Alexei Starovoitov 写道:
> On Sun, May 24, 2026 at 11:15 AM <bot+bpf-ci@kernel.org> wrote:
>>
>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>> index 17d4ab0a8206..425c9f5c64fa 100644
>>> --- a/kernel/bpf/btf.c
>>> +++ b/kernel/bpf/btf.c
>>> @@ -8673,6 +8673,47 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
>>>        return 0;
>>>   }
>>>
>>> +static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind)
>>> +{
>>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>>> +     struct btf_module *btf_mod, *tmp;
>>> +#endif
>>> +     s32 id;
>>> +     int ret = 0;
>>> +
>>> +     if (!btf_is_module(btf))
>>> +             goto out;
>>
>> During v2 review, Alexei Starovoitov suggested a different approach: instead
>> of rejecting duplicate kfunc registration, he proposed allowing module kfuncs
>> to override kernel kfuncs, similar to livepatching. He stated: "imo that's a
>> more interesting use case than helping out-of-tree module to produce nicier
>> error" and "I'm not convinced that we should be doing it... because ^^^ is
>> what I think we should be doing instead."
>>
>> The author requested implementation guidance on how the override mechanism
>> would determine which kfunc to call, but received no maintainer response.
>>
>> Should this implementation be reconsidered?
> 
> It was considered and I said later to defer this idea for now.
> AI should consider the whole discussion thread instead of immediate replies.
> I guess in this case the threads were broken into multiple
> due to different subjects.
> 
> Song,
> in the future please try to use one subject.

will do. AI review is really amazing and I'm so impressed to its smartness.

> 
> Also "kernel/bpf/btf.c:" is not a valid prefix.
> I will fix it up while applying when trees are ffwded after pending PR.

will do and I appreciate it.

Song

