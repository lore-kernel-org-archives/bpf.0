Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45868433E64
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004276; cv=none; b=IV5NilLC+gcPB6PhcI4cwhj//+u7TcvpGE+AnX0LZmoZJYH7FBRD1y3blgMNdNOv90vuzXq/jcMzE1Z76S69NTF9q2FLr5jk2KKHLsSd7sx25T80xOvkvr7AnYgLF3LCjXr6+MPw1ZtV3SzaDDlu81yLkW4WLETk4eAoisSOG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004276; c=relaxed/simple;
	bh=6jFT3aFEGclYvfyW6Kgs0L4KXmUv4KAVfo71dv1+F90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1AIMDp+WoKYJfxkEF3u8OyMFozbBzvxoEVjxmBu+KqvrdQ0qTsbqBjKNlOPEA833cehpBiiA/vZCtDE4Gjlk2PYKq/aO6BzmDR08xcLrJXuEFiqop0RKPOWICJTLcnPw7HwADytT0Txgsyb2HjAbKNXuJC1n8kOBqNVhN8mr34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmleBshe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmleBshe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407B41F000E9;
	Thu,  2 Jul 2026 14:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783004274;
	bh=XgCjVLRpDU+gyYRJXLVdG+bY+AIFRkg7vGO6oIn91Rc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FmleBshe4VFyogbv16t5AL7ZdNJ/hzQOlMILnqCgDqVJCZZQvkelStLFyEIaDseVX
	 U36JEOwmmwCMUqRQjsSHhi3U934GlrluyRd5UYz6EbJNkjjHEMdze0VHIpgCSHN9I6
	 w0GKoH1fT8tpCEva9QXlspm+PRCK9uxxPlaV0pVcptsafSyN0NEOdK85+usTF5fOqQ
	 Mclz+UAXZxlY6rjgSCdNIWviGEXD1ytIYFB7hry6x7rCJngV/RjRrEerrXHOX/gLBi
	 Uz7hi1aiuNYKtGxB0yPyU4nH21qm9qedC/LmXE/xXquIEfzbtjKThpL2qmx23Tj+wM
	 KZfXIKz5jlw8Q==
Message-ID: <6a8fbf80-5672-4691-aa60-8f8b3b75aa96@kernel.org>
Date: Thu, 2 Jul 2026 15:57:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Strip all -Wformat* flags from
 bootstrap libbpf build
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 kernel-team@meta.com
References: <20260630205418.3483969-1-andrii@kernel.org>
 <77ea35c8-2a06-41f0-b808-9743dbd3ea51@kernel.org>
 <CAEf4BzaDjuLTsoTFXpPMp33KbKHvXkDv0Gwf2T=JVQBqGgZ+5A@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAEf4BzaDjuLTsoTFXpPMp33KbKHvXkDv0Gwf2T=JVQBqGgZ+5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-07-01 11:15 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Wed, Jul 1, 2026 at 5:54 AM Quentin Monnet <qmo@kernel.org> wrote:
>>
>> 2026-06-30 13:54 UTC-0700 ~ Andrii Nakryiko <andrii@kernel.org>
>>> Commit 9080b97689db ("bpftool: Pass host flags to bootstrap libbpf")
>>> started building the bootstrap libbpf with HOST_CFLAGS, stripping the
>>> warning options that are unsuitable for that build by filtering out
>>> -W -Wall -Wextra -Wformat -Wformat-signedness.
>>>
>>> HOST_CFLAGS inherits EXTRA_WARNINGS, which includes -Wformat-security
>>> and -Wformat-y2k. The filter drops -Wall and -Wformat (the latter being
>>> what actually enables -Wformat), but leaves those two -Wformat-* children
>>> in LIBBPF_BOOTSTRAP_CFLAGS. Building the bootstrap libbpf with it then
>>> warns:
>>>
>>>   cc1: warning: '-Wformat-y2k' ignored without '-Wformat'
>>>   cc1: warning: '-Wformat-security' ignored without '-Wformat'
>>>
>>> The warning is easy to miss in an in-tree build: tools/lib/bpf/Makefile
>>> re-adds -Wall via "override CFLAGS += -Wall", which re-enables -Wformat
>>> for the libbpf objects, so only libbpf's feature-detection probe (which
>>> uses the passed CFLAGS verbatim) leaks the two warnings. The standalone
>>> libbpf Makefile (github.com/libbpf/libbpf, used by the bpftool mirror)
>>> instead uses "CFLAGS ?= ... -Wall", which the passed-in CFLAGS overrides,
>>> so -Wall is never re-added and every bootstrap object warns.
>>>
>>> Use a -Wformat% wildcard in the filter-out so the orphaned children are
>>> removed together with the parent.
>>>
>>> Fixes: 9080b97689db ("bpftool: Pass host flags to bootstrap libbpf")
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>
>>
>> Looks good, thank you.
>>
>> Acked-by: Quentin Monnet <qmo@kernel.org>
> 
> thanks, applied to bpf-next, please do another bpftool sync when you
> get a chance


Done now, it should be all sorted in the GitHub mirror. Thanks!

Quentin
