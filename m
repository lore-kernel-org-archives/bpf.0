Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADCC4418E9;
	Thu, 26 Feb 2026 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772146326; cv=none; b=PPcQG7fLwac44V2u/6dGK4Ykk/tFHf0/+qoDr4gG7pXzqlkGR3jw+6Trs87F4JK76zSg1ZLrX5GE5BXD3nJajIVOANBMiIdSSTSZSnnMmJTXx3S25DF61A6wvYSnbXQ0t3ukONlImpQwXQ4i4xCy4siC26zmkx5V6hSAIEui8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772146326; c=relaxed/simple;
	bh=2+gjNqN353ZDwdvuA5hCVDrTsV9/BiJ5JmUBZ7zBKJc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JrXFL5dR88Z3yvtu0H1CEGhWHdF1QLqIuDB6E2nvsbDnr8Pw7ocLWjcMlajYoNS+WEfWytjzzDNyNcQsp64ZT7TK0mFlNTXde30SQrhP3o6Kv29Nh3lbrZm1X//CmsiILVjQqefTxenmWx7mjT90yyNoAS5olWPuz1YVKH2yBkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlC+zjdG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlC+zjdG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A8AC19423;
	Thu, 26 Feb 2026 22:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772146326;
	bh=2+gjNqN353ZDwdvuA5hCVDrTsV9/BiJ5JmUBZ7zBKJc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=qlC+zjdGw0ga8OZLY2A7odZzzvnUdFryRcVETmxLLmuZ2oPvWpTXWM20+q/059k4f
	 uRN8ZXazvLFsSGfaxofwAuiyYgSqHO+Hq2L6c9ZeGVAOuz2j6u2h5zQpWpMloK+Wqt
	 tkksJ+/95IJdmnxBsxspOnlW6A9ulIhOiSOZ5nOjyRtCjJnd5ctS65RUlDlmKu3yu8
	 ytwnl0XxYbq9C22c9zNCZgwS7ArfcpbIrx2QaV4zx8vnN60c2VdkdSxkDQvvwTwVUn
	 Z2yaBD5YG3KJdkQ9g9igIv/rVKgt5as6CovmlTu4a3MlH1EAJfvLQTgNSjcgJ8m+Of
	 13ljTSzRzd2uQ==
Message-ID: <99e7fe4e-72de-4b55-9a9a-ae51718a0e73@kernel.org>
Date: Thu, 26 Feb 2026 22:52:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH RESEND v2] tools build: Use -fzero-init-padding-bits=all
To: Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@arm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, bpf@vger.kernel.org
References: <20260224-tools_build_fix_zero_init-v2-1-b1acc817a01e@arm.com>
 <aaCTC86U9KjnmZmu@google.com>
Content-Language: en-GB
In-Reply-To: <aaCTC86U9KjnmZmu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-02-26 10:38 UTC-0800 ~ Namhyung Kim <namhyung@kernel.org>
> Adding bpftool maintainer.
> 
> On Tue, Feb 24, 2026 at 12:16:40PM +0000, Leo Yan wrote:
>> GCC-15 release claims [1]:
>>
>>   {0} initializer in C or C++ for unions no longer guarantees clearing
>>   of the whole union (except for static storage duration initialization),
>>   it just initializes the first union member to zero. If initialization
>>   of the whole union including padding bits is desirable, use {} (valid
>>   in C23 or C++) or use -fzero-init-padding-bits=unions option to
>>   restore old GCC behavior.
>>
>> As a result, this new behaviour might cause unexpected data when we
>> initialize a union with using the '{ 0 }' initializer.
>>
>> Since commit dce4aab8441d ("kbuild: Use -fzero-init-padding-bits=all"),
>> the kernel has enabled -fzero-init-padding-bits=all to zero padding bits
>> in unions and structures.  This commit applies the same option for tools
>> building.
>>
>> The option is not supported neither by any version older than GCC 15 and
>> is also not supported by LLVM, this patch adds the cc-option function to
>> dynamically detect the compiler option.
>>
>> [1] https://gcc.gnu.org/gcc-15/changes.html
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>


Thank you Namhyung for the Cc.

I built bpftool with the patch, with gcc 13 (which didn't get the flag,
as expected) and gcc 15, and it's fine with both. As far as I can tell,
bpftool does not initialise any union with "{0}" anyway.

One potential concern (I didn't try) could be for cross-compilation:
bpftool's Makefile sets HOST_CFLAGS based on $(CFLAGS), but $(HOSTCC)
and $(CC) could be different versions of gcc, for example. The same
concern could apply to perf with HOSTCFLAGS, by the way?

Best regards,
Quentin


Note: For fellow bpf@ readers, the original thread is at
https://lore.kernel.org/linux-kbuild/aaCTC86U9KjnmZmu@google.com/T/#m700907de1a84c007bfda62981af590ad7aed0f11
