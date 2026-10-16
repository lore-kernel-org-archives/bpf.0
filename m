Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC57D3BE17E;
	Fri, 16 Oct 2026 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142331; cv=none; b=Fme7GK7M08HkphvN7XM8aVPLdZq6DKCH/sMuzp6CBi7BrO0uTllWNBXLmEoemlgDod/77AoMfJncyTpoe7fmEoHLLVVsxi4KAqfYPX5UOVPe4zX3U7OHa+BINp/u48fDQRQPSuwYSwNQmOiVEFgnwDz7ZoInLlWUwpN+jkF9F6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142331; c=relaxed/simple;
	bh=LpcnSE0E+7ybEGxdq6lj0tZQcudIz5g+B8Aya3Z++xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMnJYuOOVdTyHPba/+BHoIX8hvI2OWpNbfiGwEYHUYGwuJZfQ31dfwNyHf273BxXdeGRktYmxgmPGmtYeBDMQflXXWWNaI/KKbCvpiGr1s49n9hAvX85ckxd6FJQx/V7PU+rqKM6CMfD1gf7YZdtKKJCdlYqy1YkuPvQA9kfevk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hugg/Ish; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hugg/Ish"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A981F000C4;
	Fri, 16 Oct 2026 09:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792142330;
	bh=NbWDxILIwfiHLalvlI7KJfx446gCQIB/Sm6F+YT4cfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hugg/Ish40Lnnw/N9fkNWC988BB4oOQTGY24+sFzpc820WNIb/vVn4IGYunPiwC6F
	 J+MynlRIV+0ITU2Xq1RNMA/prXJz7DCucnneAzJ9n2/XFSXnaVM8gCl80fFNxXP1/W
	 XJYWwjFfNCpHIReZEhd8tqgPBtySlEoyBVDss5Ms5m7RCaG9YWyhddftCzzzHAB9Yu
	 QazlSc5iyoos1/YE/s2WyxdQYI3eXCBoVDkn0EYb4iE5qwwh9hrZi/t/zGK+dPrxh5
	 8ZS5nDU0sABQaaBm+J5Ih0Ih7f7oT17tnzH1sCDxOcunBSyz4Nt3kBpbezRmqlT+tG
	 2E3Toy7qWOzHA==
Message-ID: <3683fce4-8700-4e6b-9a1d-86826348a5dc@kernel.org>
Date: Fri, 16 Oct 2026 10:18:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARC: Strip libgcc debug information when generating BTF
To: Sasha Levin <sashal@kernel.org>, Vineet Gupta <vgupta@kernel.org>,
 linux-snps-arc@lists.infradead.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261015154044.4058618-1-sashal@kernel.org>
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <20261015154044.4058618-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/26 4:40 PM, Sasha Levin wrote:
> ARC links against the compiler's libgcc archive. The ARC GNU 2023.03
> toolchain ships this library with debug information, including complex
> floating-point types in integer arithmetic helpers such as __udivdi3.
> These types reach vmlinux even though the kernel does not use complex
> floating-point arithmetic.
> 
> When floating-point BTF encoding is enabled, pahole rejects those types:
> 
>   Complex, interval and imaginary float types are not supported
>   Error while encoding BTF.
>   FAILED: load BTF from .tmp_vmlinux1.BTF.1: No such file or directory
> 
> KernelCI's upgrade to pahole 1.31 exposed this long-standing problem as
> failed ARC builds. As of 1.32, pahole still rejects these types, and
> older versions will stay in use, so the kernel build has to keep them
> out of vmlinux. Commit f122668ddcce ("ARC: Add eBPF JIT support")
> documented the same failure along with a workaround of disabling
> floating-point BTF encoding, but that also discards supported
> floating-point types from kernel BTF.
> 
> For CONFIG_DEBUG_INFO_BTF, generate a debug-stripped copy of the selected
> libgcc archive in the output tree and link that copy. Preserve the archive
> structure so that only needed helpers are linked, and use the normal
> Kbuild objcopy rule to track input and command changes. The trade-off is
> that vmlinux in BTF-enabled builds no longer carries DWARF for the libgcc
> helpers. Debug information for kernel code, the installed toolchain and
> non-BTF builds stay unchanged.
> 
> Reproduced and tested with ARC GCC 12.2.1 and pahole 1.31 and 1.32 using
> an ARCv2 tinyconfig with BPF_SYSCALL and DWARF4/BTF enabled. Before and
> after vmlinux.o files are identical after stripping debug information.
> 
> Fixes: db16c1fe92d7 ("bpf: Generate BTF_KIND_FLOAT when linking vmlinux")
> Link: https://github.com/kernelci/kernelci-core/commit/e71b8c9f42253180596e734c18965a5aad80c8c5
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Acked-by: Alan Maguire (Oracle) <almagui@kernel.org>

Thanks for the fix Sasha! More complete floating point representations for BTF
should definitely be on the to-do list..

