Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2733A7823
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938848; cv=none; b=qm28BUEGMyp6s7jpOE4tL52jESZvOv3yoUuGeqbnFaI/MjAEHb+s0b1l7QMWPEX4mRKtjQ8gu2S32HT9Gu9MGuYXp6OJLCaGyQnVZfbLhyt+UjdaMGeqLrkoZzg8cZcAaDlcgfDsE1+kSG7USXxjYeIs5gS1qb69XLYnF+mxJVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938848; c=relaxed/simple;
	bh=SGry9sh68kwELDKIdJIRRmG29w6MHwsJc9F33zh8doQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amfLWUsOkKAGJJuFvx+/w51WJ61RFxPkHvRApiIyVJVd2Uio3YaBuDepEDQ2qEuxtbKF9eEuityiiQq/z5YPtgao0R/1TWvBTwsdHNJeIRzlzCwfZsMO1QEWcCOYH1M565NI2NICG0iEBF5EBZr2IID1h5oe0dwTWWedsAvgiXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tK66K6ie; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tK66K6ie"
Message-ID: <5364d5ec-f30c-40d6-9a99-c251fec3868c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768938829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUGtXQFZZ4O5fl2DGSy010+08iBrE+9BMYtw/44nDN8=;
	b=tK66K6ieZW/6AujEvyXa7Fb5DjfKqaHcN7mWRzk9XVYfBw5U03m0upAbyWalvExZMDNdJ7
	yynJ6VazMS9wdVDiTeayNZEUMoXhhNuKDo8tP+kB5Nkgehq31elNQlwElPB1EwfxaGg9tr
	pFhOqdrz5CKiTzUOZTROAEjuBP+AQHs=
Date: Tue, 20 Jan 2026 11:53:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] scripts/gen-btf.sh: fix shebang for NixOS
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Gary Guo <gary@garyguo.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260120182034.3647092-1-gary@kernel.org>
 <b53ee085-d9d2-4365-a5bc-d61e2bce97f8@linux.dev>
 <DFTNNQLGB1CS.2HDOGB99S9ACP@garyguo.net>
 <ea83b91a-796c-4329-bcf5-2c49efa897fc@t-8ch.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <ea83b91a-796c-4329-bcf5-2c49efa897fc@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/20/26 11:38 AM, Thomas Weißschuh wrote:
> On 2026-01-20 19:15:11+0000, Gary Guo wrote:
>> On Tue Jan 20, 2026 at 6:59 PM GMT, Ihor Solodrai wrote:
>>> On 1/20/26 10:20 AM, Gary Guo wrote:
>>>> From: Gary Guo <gary@garyguo.net>
>>>>
>>>> NixOS only puts /usr/bin/env and /bin/sh at the standard location as
>>>> required by POSIX, but not other shells. Other program that kernel build
>>>> depends on is supplied via PATH, so shebang needs to use /usr/bin/env to
>>>> find them.
>>>>
>>>> This has been done to a few other scripts already, e.g.
>>>> gen_test_kallsyms.sh or decode_stacktrace.sh.
>>>>
>>>> Fixes: 522397d05e7d ("resolve_btfids: Change in-place update with raw binary output")
>>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>>> ---
>>>>  scripts/gen-btf.sh | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
>>>> index be21ccee3487..4cd3159f2ddb 100755
>>>> --- a/scripts/gen-btf.sh
>>>> +++ b/scripts/gen-btf.sh
>>>> @@ -1,4 +1,4 @@
>>>> -#!/bin/bash
>>>> +#!/usr/bin/env bash
>>>>  # SPDX-License-Identifier: GPL-2.0
>>>>  # Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
>>>>  #
>>>>
>>>> base-commit: 053966c344dbd346e71305f530e91ea77916189f
>>>
>>> Hi Gary, thanks for the patch.
>>>
>>> I'm guessing this came up because gen-btf.sh is part of the vmlinux
>>> build, and link-vmlinux.sh has #!/bin/sh (not bash).
>>
>> My typical experience is that when I see an error about /bin/bash not found, I
>> just use "bash <script path>" instead without putting much think into it.
>>
>> gen-btf.sh is part of build so I don't get to invoke the script directly, hence
>> the patch.
> 
> For the build we have $(CONFIG_SHELL) to stick before the script.
> It is only 'sh', but it is the well-known variable users know to
> override. IMO all script invocations should use this mechanism.

There are two places where gen-btf.sh is invoked.

In link-vmlinux.sh:

	if ! ${srctree}/scripts/gen-btf.sh .tmp_vmlinux1; then
		echo >&2 "Failed to generate BTF for vmlinux"
		echo >&2 "Try to disable CONFIG_DEBUG_INFO_BTF"
		exit 1
	fi

And in Makefile.modfinal:

quiet_cmd_btf_ko = BTF [M] $@
      cmd_btf_ko = 							\
	if [ ! -f $(objtree)/vmlinux ]; then				\
		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
	else	\
		$(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlinux $@; \
	fi;

So it's trivial to put $(CONFIG_SHELL) in front of it. But then it
must be migrated to #!/bin/sh, right?


> 
> 
> Thomas

