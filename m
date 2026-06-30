Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352C382F0C
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849702; cv=none; b=PnzfrPtvRfXJlUY4R88WS/v0xaCxfP1WxH8w7yV9OI4stSUzYMOAH8ri2F0jqGnKChH5Q2arE7unRsClo1p/Re1KW3YDfruL1IygKwYA0iC4J97FkMjXr7RbjShrD0HO1Po1KZXkNMCq6esKtItKv+YbCfySacE6XJcIPm7nJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849702; c=relaxed/simple;
	bh=z+jGbOpfpf8QLKc519XpubXZV77N1XJM/4t8nMnZHgg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kEsM0gqsep/Upyk3tp24/G9gmvjRCr1VB27m97MSbv2sYDnE6B3+YjfuCv26XIpXXCiiowJ4aKdA2RjaBCpS7uTQP9yK8hyDHXY6PT0kI5Gn3mrldfYOGejyOPFlmtsZgbRFVIq+JyrF+LZlXKFFayIifOHb9tGTV4z/ttPCz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKKBT7g4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKKBT7g4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207C51F000E9;
	Tue, 30 Jun 2026 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782849701;
	bh=fSdhBPsF8cZabrhMEEsqt5HsYKpTF84FzUhrGFLAHNU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=BKKBT7g46lRbtt9i9fwoo+bG/5VmnJjO/yhUgRv+yF4m5JQm0GYEG4g2vJYPiJHrP
	 nwH1S9+XOTY1eaBLMYvTrTGclHyk6ZGHYKM4QTxXugkczim8hnI/AHp5/kGYc0IkfU
	 R45s8zX2sAYqS+sKACsSyhjOICnovnXfgk5273SNsX4aSO5WhEjaPSk9aTgyUVP9LX
	 Hk23Y8hI6QmWu627nN3mQ8SE5/9ThVoFM1qnRxU9yJjzbsyvUxOtVoAIC56h3bBLMC
	 8Mxjn1RVvF/q6MWCTQDcieOvLxfYfGx376KbUiLCSUjMp3lujs95oHECf//YSFvIli
	 h4dIRpM3sRI/A==
Message-ID: <da07a0af-fbcf-4936-8194-1dc2d58bdf59@kernel.org>
Date: Tue, 30 Jun 2026 21:01:38 +0100
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
Content-Language: en-GB
In-Reply-To: <CAEf4BzbUEi4zZxEBggHzbYRaSMtQ6wWJSjHhqfvE-omvGadApw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-06-30 11:32 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Fri, Jun 26, 2026 at 6:30 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
>>
>> Hello:
>>
>> This patch was applied to bpf/bpf-next.git (master)
>> by Alexei Starovoitov <ast@kernel.org>:
>>
>> On Wed, 24 Jun 2026 13:49:46 -0700 you wrote:
>>> Building libbpf with -Wall (as happens via bpftool's bootstrap build)
>>> surfaces ~120 -Wformat warnings where pr_warn/pr_debug format specifiers
>>> don't match their argument types: %d for __u32/Elf64_Word, %u for signed
>>> ints, %zd for size_t, %ld for unsigned long, and %x/%lx/%llx applied to
>>> signed values.
>>>
>>> Match each specifier to its argument's type where a correctly-signed
>>> specifier exists (%d<->%u, %ld->%lu, %zd->%zu). For hex conversions,
>>> which have no signed form, cast the argument instead (%x->(unsigned),
>>> %lx->(unsigned long), %llx->(unsigned long long)). No functional change.
>>>
>>> [...]
>>
>> Here is the summary with links:
>>   - [bpf-next] libbpf: fix -Wformat warnings from format/argument type mismatches
>>     https://git.kernel.org/bpf/bpf-next/c/df3153758ddb
>>
> 
> Quentin,
> 
> I synced these changes to libbpf's Github mirror. Can you please
> update bpftool mirror's libbpf reference to include this change, so
> that I can fix these noisy warnings for wprof? Thanks!


Hi Andrii, I just synced it, thank you.

Quentin
