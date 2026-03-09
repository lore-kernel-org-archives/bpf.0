Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE5C2EA
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773088446; cv=none; b=CcJkMrbYp5rrAsvdprf7XDgtXFZRu008AmSzSaXV7da81fXPILfdknyq02LY2W9FzoSmXkdvi9ibFzhKx/5IQN1EIPggUc2JiftgD1z3DHRCbCeYcTACkTOq58J14OH04A2PuiIDt+N1KjBmeiVAN/1eyifM994JxRMV0yI8pxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773088446; c=relaxed/simple;
	bh=3/48DpGpuVgHfkIni0tyHrV7eZrsIKRpAziMmE6eDB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kP7eT+ACovegPJ9gLZIDV5KKLt889OC5qlscj8+YI+VjHfA1KzsiGcmPD14dkWCnt2NOnIsWXGtNQ+Qkq4gAIwT54IGsAoGpeMPm4r8JgHm0dsyci1eXTF2yChoWkXjPn3spWxsANqjq5kV//j9rC9BTCypBcgtrY02T3No/QIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwZFui2U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwZFui2U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3430BC2BC87;
	Mon,  9 Mar 2026 20:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773088445;
	bh=3/48DpGpuVgHfkIni0tyHrV7eZrsIKRpAziMmE6eDB0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BwZFui2Ub9b6z5IUhDm9FSmrZtUqVBpKzeS/jSvwdvoNDC85vWRNUsRibsS0VEpka
	 XvxivTPP4MOckgOUEzG/FRjBMpLwD2hMrvcJvmIlLD+x1V+qeCLnM98PiigNQEhujo
	 IMsJRpaBRtSVzpj2wVgRyZo/JrA4KOfoXzjBj7fnMMrUBLKOI6qjYnDHHz4Yno6j6e
	 Iolopg4cEQvwbFl90knpwN9N4OrDBvm9dEJa8lUhCTwmHRuTw6m7okXTpkK4ZJgmeT
	 0x8JHoHvS58pNjcBTowgygJKiTVBwc/T/es9+Ab7YmGrOyiWUP7jcxanFIeCw0eext
	 bAfjgEbm6J5gw==
Message-ID: <e1918475-8028-45a6-a669-dc9031f73c2f@kernel.org>
Date: Mon, 9 Mar 2026 20:34:03 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Need update to libbpf/bpftool for bpf_stream_vprintk() removal
 (kernel sha 0cecd492f516)
To: Calvin Owens <calvin@wbinvd.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org
References: <aa8KBN1kQnng3yma@mozart.vkv.me>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <aa8KBN1kQnng3yma@mozart.vkv.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-03-09 10:57 UTC-0700 ~ Calvin Owens <calvin@wbinvd.org>
> Hi Andrii,
> 
> Your libbpf github sync at [1] happened just before [2] was merged...
> would you mind syncing that bpf_helpers.h change into libbpf/bpftool?
> 
>     In file included from skeleton/profiler.bpf.c:4:
>     libbpf/include/bpf/bpf_helpers.h:318:12: error: conflicting types for 'bpf_stream_vprintk'
>          318 | extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
>              |            ^
>     ./vmlinux.h:128001:12: note: previous declaration is here
>       128001 | extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args, u32 len__sz) __weak __ksym;


Hi, where did you observe that, please? I don't see it when compiling
bpftool from the main branch of the GitHub repo.


> I'm happy to send patches if I can help, but I'm guessing this is one of
> those things that is easier to just do yourself with commit access...
> 
> Cheers,
> Calvin
> 
> [2] https://github.com/libbpf/libbpf/commit/6ddc03d4fe0535ac0fb6c8525db31ac88a018ddd
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0cecd492f516


I take care of bpftool, my ideal workflow is to sync after libbpf has
been updated. Andrii, if you have a moment to do a libbpf sync, I'm
happy to follow up with bpftool.

Quentin
