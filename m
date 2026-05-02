Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D65F2C234A
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737944; cv=none; b=d4ELHema++W+iySBFdWwyqQGnl4Tfa0NY2lLlEXytxb1hXZQCmtgltIbnUK6dEZP1gzo4REnBjkzb0G1jMd7Mu5xF9KWeJvm0TAQyc4wtKPe4MyYJol16jECo18g7M1BZCopfS0Nx+xq9G0WexJwA94vTybDDTMHb2//O3g0PKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737944; c=relaxed/simple;
	bh=1b+K6kk1SBgdgizd3ULtFC4i3NYwCtDXVzftRYYK09w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6BXM6hSgoe9QTnsMwEFEWeA1ZXEVylco7PgULAoII9ERS4U2700ZpuA27dIzNu2Fv1cspGpnydEdAkItnLTwzXxYmS0RCThWTTIwoiw41xI/I3+EWB0bjAorvIruvjPY3LXtwgOLOVaEd6J7QeTIjMO+Y0ipdqvwt4y6oq41Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PXBqGdWB; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PXBqGdWB"
Message-ID: <d8b0f5d4-60b5-4a29-a7d0-72460d8b1a45@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777737939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amUf5asKM0Vjm5j1yB3QLO37BjEdWq9TObsZMgtBTMw=;
	b=PXBqGdWBlu/WiHfK17w+wSx+Ljhzgvi7rmlLqT8KUREpLrC8vdRsS0sBz/UULbRr+J2rae
	CoEiqBqYp+PSLBfN2oJbX2SbLLLDBwUU5b7d7c4plooonFVVDba7uQnY7oYRUbAjZOiZBw
	dV7Ki7HILE/Hee0QG1uPoAoOugDeuF0=
Date: Sat, 2 May 2026 17:05:30 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] tools/headers: Regenerate stddef.h to fix BPF
 selftests
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <8da8ef16055aa452d940668ed5359ce54adc6b0b.1777715500.git.paul.chaignon@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <8da8ef16055aa452d940668ed5359ce54adc6b0b.1777715500.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/2/26 11:12 AM, Paul Chaignon wrote:
> With commit dacbfc167808 ("crypto: af_alg - Annotate struct af_alg_iv
> with __counted_by"), two selftests, test_tag and crypto_sanity, now
> indirectly rely on the __counted_by macro. On systems with commit
> dacbfc167808 in the installed UAPI headers, the selftests build fails
> with:
> 
>   In file included from tools/testing/selftests/bpf/prog_tests/crypto_sanity.c:7:
>   /usr/include/linux/if_alg.h:45:22: error: expected ‘:’, ‘,’, ‘;’, ‘}’ or ‘__attribute__’ before ‘__counted_by’
>      45 |         __u8    iv[] __counted_by(ivlen);
>         |                      ^~~~~~~~~~~~
> 
> This patch fixes it by regenerating stddef.h in tools/include using the
> instructions from commit a778f5d46b62 ("tools/headers: Pull in stddef.h
> to uapi to fix BPF selftests build in CI").
> 
> Fixes: dacbfc167808 ("crypto: af_alg - Annotate struct af_alg_iv with __counted_by")
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

Hi Paul, thank you for fixing this. You beat me to it :)

Can confirm the patch fixes selftests/bpf build on BPF CI:
https://github.com/kernel-patches/vmtest/actions/runs/25255756746/job/74054783017

Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

> ---
> I'm a bit unsure if this should go to bpf or bpf-next, but it currently
> applies cleanly to both.

I think this should go through bpf tree, it's a clean fix.

> 
>  tools/include/uapi/linux/stddef.h | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/uapi/linux/stddef.h b/tools/include/uapi/linux/stddef.h
> index c53cde425406..457498259494 100644
> --- a/tools/include/uapi/linux/stddef.h
> +++ b/tools/include/uapi/linux/stddef.h
> @@ -3,7 +3,6 @@
>  #define _LINUX_STDDEF_H
>  
>  
> -
>  #ifndef __always_inline
>  #define __always_inline __inline__
>  #endif
> @@ -36,6 +35,11 @@
>  		struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME; \
>  	} ATTRS
>  
> +#ifdef __cplusplus
> +/* sizeof(struct{}) is 1 in C++, not 0, can't use C version of the macro. */
> +#define __DECLARE_FLEX_ARRAY(T, member)	\
> +	T member[0]
> +#else
>  /**
>   * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
>   *
> @@ -52,3 +56,23 @@
>  		TYPE NAME[]; \
>  	}
>  #endif
> +
> +#ifndef __counted_by
> +#define __counted_by(m)
> +#endif
> +
> +#ifndef __counted_by_le
> +#define __counted_by_le(m)
> +#endif
> +
> +#ifndef __counted_by_be
> +#define __counted_by_be(m)
> +#endif
> +
> +#ifndef __counted_by_ptr
> +#define __counted_by_ptr(m)
> +#endif
> +
> +#define __kernel_nonstring
> +
> +#endif /* _LINUX_STDDEF_H */

