Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3F220297C
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 00:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774054249; cv=none; b=TEudASCUUbF9aGgycN9uf+4rj302AziMRsE8kchttxxKnflEyL1aQNkc0hA7NxaRScrT1rcYxLsoPeMTYgbARrz7iQUI20SAh2b8nFaHhMUP1NzxeMDiJarJTUBGiEvS+aPzJ/5LVeOVUM2owRGweEhIZC/2uI8TS+N12Ui2sgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774054249; c=relaxed/simple;
	bh=LaLW/D0aAcUj2dNHzaMxYwfZVjBWJkN5K9kOz5EP/gk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LyjOmrUKl6mfets91VB3lMWLqH84/rC8g80N0qOLgYnu7qDpi1EnnKODyA4ogrYYoPH1zRVY4REYzIlgapEmfP0u8WTUShuf9eNODLA9hhWdFGvgtk5qVF5m+lQGhzVGtQ+amTUFtju0CfR6d2QJM1Tg9u5v1X/vqbkH+WsJ4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwDXkrfk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwDXkrfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E783C4CEF7;
	Sat, 21 Mar 2026 00:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774054248;
	bh=LaLW/D0aAcUj2dNHzaMxYwfZVjBWJkN5K9kOz5EP/gk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=nwDXkrfktIjNH/BZSrzFl46LQL08bOEEwrjAu5PNUrh2OPCLfjM7hLncJftC4ZHx1
	 JlAtuDl7YsfE+ulX/i688rhucWo3yVtz3nTsMv6tz2c7OasvIBQizKsA44u7uVxuJj
	 seVcKurIJEqRu1HBPx+eQa33IGT8T3nJmkQ/yUD9AT1QXDGU7W2O4f1CkFC2X2dkWs
	 cI53yK11wWHCPRwfuEm0gHn4+hB3ttcC2nt8ANFPoVkjYLSzzf+VmzPY2E+LWr46g2
	 h2N82Mwut6nCZn8L84U2LIaTI2edXilJaVpjJclplblbivOQEQRZpPaYml7BWs7A/d
	 gGEmuaSV17+mw==
Message-ID: <ea4b6626-e435-4044-a671-35f5c18e3ce6@kernel.org>
Date: Sat, 21 Mar 2026 00:50:45 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Allow explicitly skip llvm, libbfd
 and libcrypto dependencies
From: Quentin Monnet <qmo@kernel.org>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260312-b4-bpftool_build-v2-1-4c9d57133644@meta.com>
 <ad8a783b-7b8c-46f2-9a3c-953315aafe38@kernel.org>
Content-Language: en-GB
In-Reply-To: <ad8a783b-7b8c-46f2-9a3c-953315aafe38@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-03-17 10:29 UTC+0000 ~ Quentin Monnet <qmo@kernel.org>
> 2026-03-12 17:03 UTC-0700 ~ Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Introduce SKIP_LLVM, SKIP_LIBBFD, and SKIP_CRYPTO build flags that let
>> users build bpftool without these optional dependencies.
>>
>> SKIP_LLVM=1 skips LLVM even when detected. SKIP_LIBBFD=1 prevents the
>> libbfd JIT disassembly fallback when LLVM is absent. Together, they
>> produce a bpftool with no disassembly support.
>>
>> SKIP_CRYPTO=1 excludes sign.c and removes the -lcrypto link dependency.
>> Inline stubs in main.h return errors with a clear message if signing
>> functions are called at runtime.
>>
>> Use BPFTOOL_WITHOUT_CRYPTO (not HAVE_LIBCRYPTO_SUPPORT) as the C
>> define, following the BPFTOOL_WITHOUT_SKELETONS naming convention for
>> bpftool-internal build config, leaving HAVE_LIBCRYPTO_SUPPORT free for
>> proper feature detection in the future.
>>
>> All three flags are propagated through the selftests Makefile to bpftool
>> sub-builds.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> 
> 
> Sorry I'm late for this one, I see Andrii applied it - I just wanted to
> say thank you for this!


Mykyta, Andrii,

Apologies again for missing the review on this series. I'm realising
only now that it goes beyond what we initially discussed: It adds a way
to turn off the optional dependencies related to the disassemblers,
which is what we agreed on, but it also makes libcrypto optional.

There were previous discussions where I pushed back against making
program signing optional in bpftool. It's one thing to have the JIT
disassembler unavailable on a machine; but it's going to be a pain if a
policy requires signed programs on a system, but the bpftool version
available does not support signing. Are you really sure you want to make
it optional? My preference would be to keep program signing a mandatory
feature for bpftool going forward.

Best regards,
Quentin
