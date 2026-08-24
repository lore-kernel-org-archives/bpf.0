Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C169146D2B9;
	Mon, 24 Aug 2026 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590951; cv=none; b=AWNY0V+NA4tz4B8RV+WScnTXzlpSYHBNqeQoI4wC0byWe/V11wZPyntzfExPq0EABj7V8iJiEyN3DsCByFlRHRg9BkfzSMPfkGZjPlCX9dXWtx1bSU+0WxyDU1naUP5zOlngFyWSGrRms6OPiCnaToSKwojAn8YX3oxA8ELck1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590951; c=relaxed/simple;
	bh=+pl9p8VBgJy5SsSi49ocmYBGgT+u3t+hVtJxVZzLUwE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CTMWX+v59RQp72AC3Uog8jKDDvSGvm9y2GNPPsrWlXui4MKNyQ5un6fTZXurmZf+2V+iNjbMK71Mqey9SIpUT2z977p8DtDGxhVhr6QPAucmrnCzxhPUNMq0HRVTg5JtLkKpyPCm1XwZsvnhe8Wo59Ylh6+mw35Df69NirAmrIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atk2v2bo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atk2v2bo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058AF1F00A3A;
	Mon, 24 Aug 2026 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590949;
	bh=qQ2bQOrbTsaJhvYOE3sPxtUiRh+bM2NAzCmvJRNhg2E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=atk2v2boXCqeIf5Byg0tMupiBW9ZOEYXubMkwsfR5oWtnFfNi8VBZBFcjb3LxBRTI
	 tLvR8JpBo8kdhOFr97hf4IzmfErlZXVx//L6stpp+5fw/wjf5yLnvZ8jlTtbdXiz1k
	 XPmdydCoAIMbuFouXWoj+VatbjK3IOJcUyvh0dgSyL4OIjr3H/AoaXpvjIXsfycxRH
	 TlsPMvt7PhGp8QaLsqkSMVjQfWGqMZisrasmo3Y2BTAtrbT4NPO9hn0g6ywI+s2aiS
	 NkxkcIkKLbxmjdTpV5nhIws4Nyw0DVODWj//a9IE0hfjGntyOdtPBcg/xfcAs0tKMK
	 IXK8pFB2tQa4Q==
Content-Type: multipart/mixed; boundary="===============4786653597931673110=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <58f6ac1ad1722df4b1b011d30d194e31d7ccc8d86ed5a93a039fe958f7383ca3@mail.kernel.org>
In-Reply-To: <20260824160523.3907021-9-usama.anjum@arm.com>
References: <20260824160523.3907021-9-usama.anjum@arm.com>
Subject: Re: [PATCH 7/7] bpf: Batch TCO handling in string kfuncs
From: bot+bpf-ci@kernel.org
To: usama.anjum@arm.com,catalin.marinas@arm.com,will@kernel.org,mark.rutland@arm.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,akpm@linux-foundation.org,david@kernel.org,ljs@kernel.org,liam@infradead.org,vbabka@kernel.org,rppt@kernel.org,surenb@google.com,mhocko@suse.com,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org
Cc: usama.anjum@arm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 17:02:29 +0000 (UTC)

--===============4786653597931673110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 582a0a0c5c8589832f42bc3de95bce3c2fba5778
> Author: Muhammad Usama Anjum <usama.anjum@arm.com>
>
>     bpf: Batch TCO handling in string kfuncs
>
>     BPF string kfuncs cannot rely on NUL termination, so they scan memory with
>     kernel nofault loads. With Hardware Tag-Based KASAN in asynchronous or
>     asymmetric mode, every arm64 load sets and clears PSTATE.TCO.
>
>     Use bare loads and hold one nofault region across each string operation.
>     The scope guard restores TCO before page faults are enabled again on every
>     exit, including an access fault.
>
>     A character comparison performs two nofault loads. For N compared
>     characters, the number of dynamic MSR TCO executions therefore falls from
>     4N to 2.
>
>     Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

This isn't a bug, but would it be worth scoping the statement to kernel
nofault accesses rather than "every arm64 load"? The TCO set/clear
happens in __get_kernel_nofault()/__put_kernel_nofault() and
load_unaligned_zeropad(), not ordinary loads. Also, the 4N-to-2 figure
applies to the two-load-per-character comparison helpers like
__bpf_strncasecmp and __bpf_strnstr, while six of the eight converted
functions (bpf_strnchr, bpf_strchrnul, bpf_strrchr, bpf_strnlen,
bpf_strspn, bpf_strcspn) perform one load per character and so go from
2N to 2. The sibling patch 022e4f83d5cb spells out its per-shape figures
in a small table.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 3574a9a5721e..f8c557161584 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -4014,12 +4020,13 @@ __bpf_kfunc int bpf_strspn(const char *s__ign, const char *accept__ign)
>  	}
>
>  	guard(pagefault)();
> +	guard(__kernel_nofault_bare)();
>  	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> -		__get_kernel_nofault(&cs, s__ign, char, err_out);
> +		__get_kernel_nofault_bare(&cs, s__ign, char, err_out);
>  		if (cs == '\0')
>  			return i;
>  		for (j = 0; j < XATTR_SIZE_MAX; j++) {
> -			__get_kernel_nofault(&ca, accept__ign + j, char, err_out);
> +			__get_kernel_nofault_bare(&ca, accept__ign + j, char, err_out);
>  			if (cs == ca || ca == '\0')
>  				break;
>  		}
> @@ -4027,7 +4034,7 @@ __bpf_kfunc int bpf_strspn(const char *s__ign, const char *accept__ign)
>  	return -E2BIG;
>
>  err_out:
>  	return -EFAULT;
>  }

A subsystem pattern flags this as potentially concerning: eight
functions in this patch now contain both scope guards (guard(pagefault)()
and the newly added guard(__kernel_nofault_bare)()) and goto-based error
exit to the err_out: label. The __get_kernel_nofault_bare macro expands
to 'goto err_label' on an access fault, so bpf_strspn (shown above),
bpf_strcspn, __bpf_strnstr, and the five single-loop helpers all mix
goto and guard() cleanup in the same function. The subsystem guide
directly flags this combination.

My own reading is that this is probably unavoidable. The err_out: label
is an error-return label, not a cleanup label - its entire body is
'return -EFAULT;'. No resource is released there; both the page-fault
state and the TCO override are released by the guards' destructors,
which run on that return because err_out: sits in the same block as the
guard variables. The goto does not leave the scope, so the cleanups fire
at the return, not at the goto. The goto is imposed by the
__get_kernel_nofault*() API, which is inherently label-based. The same
mixing already existed before this patch (guard(pagefault)() plus
err_out: were introduced earlier in the series), and the sibling
conversion in mm/maccess.c (022e4f83d5cb) uses the identical shape.

Does this concern you, or is the pattern acceptable here given the
constraints of the nofault API?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32751368606
--===============4786653597931673110==--
