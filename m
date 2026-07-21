Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B89D3F825C
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654654; cv=none; b=Va4ay/bVf6v8ssrj86hWGbLPfzXIYN3J5/CgFXM9YykL7kSMEULNkO6q3+TBiw3OMfZZRVFkyvwMk8tWCCJ4wBv03mvnijEvSnRWV0kCcdFFPg3rNRHRORmT037lVQsbOpS6nZQNvknOor+3OwTfaEw+tD1+TUbedvyDogFrSJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654654; c=relaxed/simple;
	bh=3aib/mJy7dWcb7PQMt/jFgSo4y+WB1x21Rs1eesUuQE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xqr0zS2gS8k644i/ChzZb+IwEPCDrb/OwGIkJOm3Ak1iBMmZhGqLYMmdmg+f9ma6XsMR0uRv8QRx646azvD9yK+TBnqlZQUAFP0ZHJ+07FpxuC86b7lVQvAdSCQkVpqsVyoIpmjV7Bryv0DkIQOl/VvRwv8iODCxaH+9yhfQDpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J0h3YynE; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J0h3YynE"
Message-ID: <7c79eb26-0986-41c8-a5f9-5911a2e71175@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784654649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4F+iZhFV6VPB9ZUQh4/hKSJwpjYLP4RW3rsSYNMA+yo=;
	b=J0h3YynECLow0Nnsp03fdyDTS34Y59J51xWwDr2kgqKZ+bKjF8x6FCbBrrZ+jMk0bOw0sl
	4Mnp7MxCx4Pw1IVloH58zet5ib5GPDifhdDNflFMbMXGBmu4g9/DbXHuKBXZrjb6eb8HFg
	x10FPUADk/mxFAuq3c77N0sGAoYLr34=
Date: Tue, 21 Jul 2026 10:23:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 0/5] x86/cpu: Refactor identify_cpu()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, "H . Peter Anvin"
 <hpa@zytor.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 bpf@vger.kernel.org, kernel-team@meta.com, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260704002046.3859585-1-ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20260704002046.3859585-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/3/26 5:20 PM, Ihor Solodrai wrote:
> This series refactors identify_cpu() machinery on x86 and then
> implements a fix for a bug when cpu capabilities are temporarily
> cleared within an interruptable window. For more details and
> discussion see the relevant bug report [1].
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> [1] https://lore.kernel.org/bpf/20260610175651.647515-1-ihor.solodrai@linux.dev/
> 
> Ihor Solodrai (5):
>   x86/cpu: Factor init_cpu_info() out of identify_cpu()
>   x86/cpu: Inline generic_identify() into identify_cpu()
>   x86/cpu: Introduce identify_cpu_32() helper
>   x86/cpu: Set X86_BUG_ESPFIX in identify_cpu_32()
>   x86/cpu: Don't reset boot CPU cpuinfo in identify_cpu()

Hi Boris, everyone.

Bumping the thread as it's been a couple of weeks.

Please take a look when you get a chance. Thanks!

> 
>  arch/x86/kernel/cpu/common.c | 114 +++++++++++++++++++----------------
>  1 file changed, 61 insertions(+), 53 deletions(-)
> 

