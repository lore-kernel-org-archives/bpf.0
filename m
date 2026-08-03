Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659733A5452
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786792; cv=none; b=FEeRny0Exp+2xYTYGfU6gfT9WulNxcWoe9QCib+eFnxYtw46AmRKEJGJwZ+0T56802AZnUyJDtp1uIabs+Ly7+POs2/riwWjh8ihaoWJK77BPfJfItizrxoBYusl7b2fU7GRbCuDRXu7bMswnVB/gqOGv8w72y5S68WoyEmhLzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786792; c=relaxed/simple;
	bh=VB/7YO/wvH7apKS7GgLwE0kRBZiD4TH53uTfwAAdU3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwwlOX8ltkuOS6JhOAVLTOspWGk8FJIrG7dwk5lZslEZ1LC2qWDaxvCmKMeuskzN6YpD7WsqelwNUq14UCDWX5DX8aYSp9N7IAIQ03AihAQleML8rJppvXFbugYyKC34IB51o/1iR/W9VRxJorya/ypt8Qar+Mur4aeZW0EE3t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pp8BKPxx; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pp8BKPxx"
Message-ID: <959ebb50-910b-4ca4-8134-855cebe4521e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785786788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WwsVnWaNi3zo//bU7GG6JuXDE9Qayk2OrSVDlvD5uY4=;
	b=Pp8BKPxxU7UK248yIEN0i5pztwmj3RNwLcrBFgouQ6AaviW+eew08Eug3h3uCv2zVq7oGd
	FMClCLKbBuG/t0e1yHG57noke3xeSai8g5u9H9q3LO6mlLc1HB03m1B/PG5zMZvCMj9MIC
	UAMxhXvFDlhmGL7NBlZ/2upD1efu+HM=
Date: Mon, 3 Aug 2026 12:52:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bpf-next 4/4] selftests/bpf: vmtest.sh: preserve command quoting
 when running in the VM
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 eddyz87@gmail.com, andrii@kernel.org, ihor.solodrai@linux.dev
Cc: linux-kernel@vger.kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com
References: <20260803170251.1898102-5-vineet.gupta@linux.dev>
 <6d96174316041032ba75e8b9901245772bd4aad2873b795fd71df038bf909763@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <6d96174316041032ba75e8b9901245772bd4aad2873b795fd71df038bf909763@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/3/26 11:31 AM, bot+bpf-ci@kernel.org wrote:
>>      Note this makes the trailing command strictly an argv rather than a shell
>>      snippet: passing it pre-quoted as one word, e.g.
>>
>>              vmtest.sh -- "./test_progs -t foo"
>>
>>      no longer works, and neither does embedding guest-side shell syntax such
>>      as ';' or a redirection. Neither form is documented - usage() and
>>      README.rst both show the command unquoted - and 'sh -c ...' still works.
> Is the claim about README.rst accurate?

You are right, it is not.

>   Looking at
> tools/testing/selftests/bpf/README.rst lines 106-115, there is a
> documented vmtest.sh invocation whose trailing command is explicitly
> quoted:
>
>    $ PLATFORM=riscv64 CROSS_COMPILE=riscv64-linux-gnu- \
>      tools/testing/selftests/bpf/vmtest.sh \
>      -l <path of local rootfs image> -- \
>      ./test_progs -d \
>          \"$(cat tools/testing/selftests/bpf/DENYLIST.riscv64 | ... | tr -s '\n' ',' )\"
>
> The `\"` are escaped in the user's host shell, so vmtest.sh's main()
> receives argv[3] as the literal 10-character string `",exceptions,"`
> including the double quotes.
>
> Under the old `command="$@"`, the guest bash's second parse of the init
> script performed quote removal on those literal quotes, so test_progs
> received `-d ,exceptions,`. That is exactly what the `\"` in the recipe
> are for: they survive the host and are consumed by the guest.
>
> With `command=$(printf '%q ' "$@")` the quotes are escaped
> (`\",exceptions,\"`) and reach the binary verbatim, so test_progs now
> receives `-d ",exceptions,"`.
>
> Downstream that argument goes to parse_arg() ARG_TEST_NAME_GLOB_DENYLIST
> -> parse_test_list() (tools/testing/selftests/bpf/testing_helpers.c),
> which strtok_r()s on ',' and hands each field to insert_test() with
> is_glob_pattern=true. So the filter list becomes three globs instead of
> one: ["] [exceptions] ["], two of which can never match a test name in
> glob_match() (test_progs.c).
>
> For DENYLIST.riscv64 as it stands today the damage is confined to those
> two junk filters, because the file's first line is a comment and
> therefore reduces to an empty leading field.
>
> The same recipe applied to a denylist file whose first line is a real
> entry silently drops that entry. With DENYLIST.asan-shaped input:
>
>    OLD guest -> test_progs -d [*arena*,task_local_data,uprobe_multi_test,]
>      filters: [*arena*] [task_local_data] [uprobe_multi_test]
>    NEW guest -> test_progs -d ["*arena*,task_local_data,uprobe_multi_test,"]
>      filters: ["*arena*] [task_local_data] [uprobe_multi_test] ["]
>
> `"*arena*` matches nothing, so the *arena* tests are no longer denied
> and run anyway, a silent loss of denylist coverage rather than an error.

This is a really good catch. Indeed arena never matches.

> Should the commit message be corrected to acknowledge that README.rst
> does document a quoted invocation that breaks with this change, and
> should README.rst lines 109-115 be updated in the same patch to remove
> the now-harmful `\"`?

v2 drops the backslash, fixes README.rst and also updates the changelog 
accordingly.

Thx,
-Vineet

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30836252778

