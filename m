Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79777158538
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 05:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771479148; cv=none; b=qXvjsOamnHgyg8b6ZYapX6G+gYxtIo/dXwnF2ydoKQLUft40xEzt4buxulPkNE9FrfHvL4apPwM/uJX2vLxitajPE02LHUFkntiSvqYQDGz4yLX7HjW4aEoN4KolKGFegNNtGj1jpytmrLglg7YW5ya2YqTfY6qyHT+78WWza44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771479148; c=relaxed/simple;
	bh=G7KE4YFT5Ai2C+M4+3zOhvqmO2eze3mqYfY8+jxtra8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2F2+9TQHv7CzEkVXMAZ16c1tkucqtXcmgX+jJsXCgC2fmkxkYpBkG3+C8+vP05yCq/bIIw+HHyWNN1uXzzw2HAkuaiLULJcrFHhVSpV0R8S7gLwOEaFwCjafggC9RjNJGhRKXnKZBEobNGIeZwYJiQEqVBiPjwDnuzHdVQcLDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MshEQMZ/; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MshEQMZ/"
Message-ID: <808d144c-3bd9-4d32-96e0-7f554f26ddb0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771479134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sg1k1MrfU6z7OOoIUxroWwEB9dmR5G+UywmxXUiSdxg=;
	b=MshEQMZ/BNW2LH8O2+QVqJIjWW27ONrlZ7jF7P+qwKiEfxhN0BvDOsQp/FheOlFxNpt0wy
	gTlNP5+ed3ERvnoPyvwnAHa9iyqufQpToDhpbMJNbevpDF+rb0jLmwaF0muN+hy5jUqFP1
	ghNkrmxwFQ0sAqtkH9nc06h68YMUrP4=
Date: Wed, 18 Feb 2026 21:31:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 1/1] libbpf: Auto-upgrade uprobes to
 multi-uprobes when supported
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Varun R Mallya <varunrmallya@gmail.com>, andrii@kernel.org,
 alan.maguire@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260212152013.17351-1-varunrmallya@gmail.com>
 <20260212152013.17351-2-varunrmallya@gmail.com>
 <82d31503-24d8-45b8-b1dd-2cb35bd28509@linux.dev> <aY9dxEBCvurRfzJU@roxy>
 <a1655fee-4ed8-41bd-ab48-cf22db76c586@linux.dev>
 <CAEf4BzZZpsuDZNCLky53WT0iLy7tLV06TWo02pnrVxsRX74o8w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZZpsuDZNCLky53WT0iLy7tLV06TWo02pnrVxsRX74o8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2/18/26 11:07 AM, Andrii Nakryiko wrote:
> On Fri, Feb 13, 2026 at 9:25 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 2/13/26 9:22 AM, Varun R Mallya wrote:
>>> On Thu, Feb 12, 2026 at 04:06:22PM -0800, Yonghong Song wrote:
>>>> On 2/12/26 7:20 AM, Varun R Mallya wrote:
>>>>> This patch modifies libbpf to automatically "upgrade" standard
>>>>> SEC("uprobe") and SEC("uretprobe") programs to use the multi-uprobe
>>>>> infrastructure (BPF_TRACE_UPROBE_MULTI) at load time if the kernel
>>>>> supports it, making them compatible with BPF tokens.
>>>>>
>>>>> To maintain backward compatibility and handle rare cases where singular
>>>>> uprobes are required, new SEC("uprobe.single") and SEC("uretprobe.single")
>>>>> section types are introduced. These force libbpf to use the legacy
>>>>> perf_event_open() attachment path.
>>>> Maybe you can have bpf programs for both uprobe/uretprobe
>>>> and uprobe.multi/uretprobe.multi?
>>>>
>>>> You can add "?" before the section name (e.g., SEC("?uprobe") so you can
>>>> selectively enable those programs before loading. This one if one choice
>>>> e.g. uprobe/uretprobe is not working, you can then try
>>>> uprobe.multi/uretprobe.multi.
>>> This is a good idea, but isn't making the upgradation built-in a better
>>> choice ?
>>> This way, anyone writing the program does not have to rewrite
>>> the same thing twice, keeping their programs pretty clean. This also
>>> moves the upgradation logic (which is probably going to be repeated multiple times)
>>> into the library which makes it easier for anyone to have something BPF
>>> Token compatible without having to write all this extra logic. Since "uprobe.multi"
>>> is compatible with "uprobe", I don't think anything will break as well.
>>> (The current breakages in the selftests are due to the patch being in
>>> nascent stages and I'll fix it after I get some feedback on my
>>> questions.)
>> I still feel this is a hack, esp. for libbpf. The libbpf provides various
>> APIs as the building block. Automatic upgrading inside libbpf does not
>> sound right. These upgrading thing should happen in applications.
>>
>>   From bpf program side, you can have progs for both uprobe and uprobe_multi.
>> You can have static function which can be used for both uprobe and uprobe_multi.
>> It should not be hard. Looks at bpf selftest, there are quite some programs
>> with prefix "?" which gives application a choice whether it should be
>> enabled or not during to kernel probing or other things.
>>
> Yeah, you can definitely handle this without needing to duplicate the
> logic in BPF code, but the idea here is to make uprobe work
> transparently inside user namespaced containers (assuming BPF token
> was provided), without having to explicitly accommodate this as a
> special mode.
>
> So while it can be seen as a bit of a hack, in practice whether you
> use uprobe or uprobe.multi doesn't really matter (they have equivalent
> features from BPF/kernel POV), but being able to just use
> SEC("uprobe") is great because you don't have to worry about old
> kernels not supporting uprobe.multi, plus you get automatic BPF token
> compatibility.

Okay. Thanks for explanation. uprobe.multi is a superset of uprobe.
So I guess it is okay for libbpf to upgrade from uprobe to uprobe.multi
if necessary.

>
> This is a bit harder for kprobes because singular kprobe can be
> installed at an offset, while kprobe.multi only support offset zero.
> But even with kprobe, I think it's worth trying to transparently make
> them BPF token-aware using a similar approach.

