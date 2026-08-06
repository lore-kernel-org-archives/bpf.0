Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18F53E44F9
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050752; cv=none; b=FyUll3YI2GbGIy45YAp1OnW2/dFf5pIyK6UZ/qym4sab50xOrJg82lw2/P8ux52f491UWSLa2wwDBN+yadpbSyF0WlyDt3scINBp+xy9lOYA+PzVGkY4cQpr9J29wH9Omup3Zm5AWTpdf7FAMJzLPgZ8ByaRG7/lyz06t05vT4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050752; c=relaxed/simple;
	bh=EVqqjgxitk7nA8Yt0CJqgu1UG0GrI/g9AGl76DLy0Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMOkMD4ZtmBc/zAwd24ZjTK+Pq8DkOo3Fc8NBzg9bGY2j0Fdln2XKvOdnD5EPY6EE5nQwPGwqe1K4O3alP9XcRDyZndbdGcLIZQkxTpwGq39dA4RT2GzuRtUXAF5JV37dzKPoTWfQjeHhZNh9n7XKRIVmf43L+FCItmW50q9RUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sHdG6Kq9; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sHdG6Kq9"
Message-ID: <daee8e4f-c8e2-4187-9167-85d3be20fc47@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786050739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eGP0fJxkFCWgp7PTBweMOXOEbYCb357C9EXHOe/Ercw=;
	b=sHdG6Kq9qkqSXExjSxwCIn6gRoJ1A/lQxKr/DjF0q0yPYL5Zi5/PPEm4NEnI9rKwvuQL5a
	8fb858YpXfrraX/Kthrlq9ppDTKDwuTLzBd/O92Z5NfmLj2O5H0EsZW7MdWXuzAFGf+uGW
	9hEIMxMscTWMxS0uU8fjohcp7mMyA9c=
Date: Thu, 6 Aug 2026 14:12:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 6/6] docs, resolve_btfids: Document kfunc BTF
 annotation emission
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
 <20260805230648.2354989-7-ihor.solodrai@linux.dev>
 <20260805231628.D5F391F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260805231628.D5F391F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/5/26 4:16 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The minimum required pahole version in the changes.rst table was not reverted to 1.22 after its dependency on 1.26 was removed.
> --
> 
> --- Patch [6]: [PATCH bpf-next v2 6/6] docs, resolve_btfids: Document kfunc BTF annotation emission ---
> commit b5222d5ea4c3ea695d12ac70fc23f3fbadabd591
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> docs, resolve_btfids: Document kfunc BTF annotation emission
> 
> This commit updates documentation and comments to clarify that resolve_btfids
> now emits BTF annotations for kfuncs instead of pahole. It modifies
> changes.rst to reflect that a specific pahole version is no longer required
> for these annotations.
> 
>> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
>> index 1ca8c5f73ad00..6d1dbe4abf0f0 100644
>> --- a/Documentation/process/changes.rst
>> +++ b/Documentation/process/changes.rst
> [ ... ]
>> @@ -147,10 +147,9 @@ Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selected, the build system
>>  generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later from kernel
>>  modules as well.  This requires pahole v1.22 or later.
>>  
>> -Since Linux 7.0, kfuncs annotated with KF_IMPLICIT_ARGS require pahole v1.26
>> -or later.  Without it, such kfuncs will have incorrect BTF prototypes in
>> -vmlinux, causing BPF programs to fail to load with a "func_proto incompatible
>> -with vmlinux" error.  Many sched_ext kfuncs are affected.
>> +Kfunc BTF annotations (the bpf_kfunc and bpf_fastcall decl tags and the arena
>> +address_space(1) type attribute) are emitted in-tree by resolve_btfids from the
>> +BTF_KFUNCS sets, so they no longer depend on a specific pahole version.
>>  
>>  It is found in the 'dwarves' or 'pahole' distro packages or from
>>  https://fedorapeople.org/~acme/dwarves/.
> 
> [Severity: Medium]
> Since this removes the dependency on pahole 1.26, should the minimum
> required version in the "Current Minimal Requirements" table earlier in
> this file be reverted to 1.22?

That's a good question. I'd like to check what pahole version is
actually minimal with this series.

But this is not a blocker for the series.


> 
> The table currently still lists 1.26:
> 
> Documentation/process/changes.rst:
>     openssl & libcrypto    1.0.0            openssl version
>     pahole                 1.26             pahole --version
>     pcmciautils            004              pccardctl -V
> 

