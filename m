Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9718392C28
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851845; cv=none; b=O/hlCs6o9dZ6knRRP9K8Sd9aiLUfJwzgtICX8FNbOCeCNgnt2pfv/8OLgLNwCaQP6VQXZFPOZHEBwX1lktbdJ4EsLjv1lTOoU1HFbiTb9YRD8q3m8rTmb+dI0+3E97haGXX3CpEA6kkF8h9Dak/8T/cCWVKGE7VRjSn9tijXD/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851845; c=relaxed/simple;
	bh=VGTBHTjPLob1sXmP6ZAtzjf9LxcBeijTkHesnQos0lg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WcMq+bSLLPOOoLIbodIiKTyrZOKVp6nHjU3eZttiE54tgeybVbHOUJoDRPeSEFpnxDnU4nF0xbZym67uHEmB8UT5nDLRfOnHkn67SpREQuVU3sdSse2yg+XM3XbtaASbpfgK5sSnwm+SnKjyk9HmZR7JL/5h+ibOuhKX8/oJbYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9HgHLfA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9HgHLfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D121F00A3A;
	Tue, 30 Jun 2026 20:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851844;
	bh=X+RN9RZawh4t2O4lvbw6LPKzptVavZkm0/n/8B3veVQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=T9HgHLfADamK4n8BAOSKGaXxU4UhrJI49+QtKpZ0bVyDcvJtlyPz9y35MnZjzFvCt
	 YaMkuArFVcpouSI2ATIOBvR+dsJX2VuGJZFuqEiwBR4vB+qEjgngLii67UMDGHmBBf
	 yDFXP42GB5cmNwE91bqixeOofBfQfKrDwikKBL4oi4q9KstQ+MRq5I1xUouIzVNTaG
	 nzcX2ggpnaTzbt6hxjUj2EhndATIgL2Utj3iaMngCH1bsJvRMQFe6UCPdVHD3gN0Xa
	 +WsbfuzQ0eeJu0SSoarwkv1u7xdFaXM06/NaEV+divqhW5ypq9lnswtzs8lJJ8mCKv
	 gQ8DVAkgctYhg==
Message-ID: <67b2d2f5-8632-4c39-bdaf-07a0d4d48c1c@kernel.org>
Date: Tue, 30 Jun 2026 21:37:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next] libbpf: fix -Wformat warnings from
 format/argument type mismatches
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 kernel-team@meta.com
References: <20260624204946.2901178-1-andrii@kernel.org>
 <178248062788.457674.6865742035078097472.git-patchwork-notify@kernel.org>
 <CAEf4BzbUEi4zZxEBggHzbYRaSMtQ6wWJSjHhqfvE-omvGadApw@mail.gmail.com>
 <da07a0af-fbcf-4936-8194-1dc2d58bdf59@kernel.org>
 <CAEf4BzaCbvsBePEaiHaCniXWUBhgDnJ99=XPL4idLY3_xkH3dw@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CAEf4BzaCbvsBePEaiHaCniXWUBhgDnJ99=XPL4idLY3_xkH3dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-06-30 13:15 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Tue, Jun 30, 2026 at 1:01 PM Quentin Monnet <qmo@kernel.org> wrote:
>>
>> 2026-06-30 11:32 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
>>> On Fri, Jun 26, 2026 at 6:30 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
>>>>
>>>> Hello:
>>>>
>>>> This patch was applied to bpf/bpf-next.git (master)
>>>> by Alexei Starovoitov <ast@kernel.org>:
>>>>
>>>> On Wed, 24 Jun 2026 13:49:46 -0700 you wrote:
>>>>> Building libbpf with -Wall (as happens via bpftool's bootstrap build)
>>>>> surfaces ~120 -Wformat warnings where pr_warn/pr_debug format specifiers
>>>>> don't match their argument types: %d for __u32/Elf64_Word, %u for signed
>>>>> ints, %zd for size_t, %ld for unsigned long, and %x/%lx/%llx applied to
>>>>> signed values.
>>>>>
>>>>> Match each specifier to its argument's type where a correctly-signed
>>>>> specifier exists (%d<->%u, %ld->%lu, %zd->%zu). For hex conversions,
>>>>> which have no signed form, cast the argument instead (%x->(unsigned),
>>>>> %lx->(unsigned long), %llx->(unsigned long long)). No functional change.
>>>>>
>>>>> [...]
>>>>
>>>> Here is the summary with links:
>>>>   - [bpf-next] libbpf: fix -Wformat warnings from format/argument type mismatches
>>>>     https://git.kernel.org/bpf/bpf-next/c/df3153758ddb
>>>>
>>>
>>> Quentin,
>>>
>>> I synced these changes to libbpf's Github mirror. Can you please
>>> update bpftool mirror's libbpf reference to include this change, so
>>> that I can fix these noisy warnings for wprof? Thanks!
>>
>>
>> Hi Andrii, I just synced it, thank you.
>>
> 
> Thanks, Quentin!
> 
> I got a bunch of new ones with latest bpftool sync, I haven't looked
> into it, but thought I'll mention in case it's something on bpftool's
> Github Makefile side:

[...]

Oh, I haven't observed these on my setup, I'll try to look into it when
I can. What compiler do you use? And do you see the same when compiling
from the kernel repo? The Makefiles should be rather close, in theory.

Quentin
