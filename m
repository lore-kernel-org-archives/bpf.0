Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641630;
	b=rZ1+n1Gvu0Xx7SBxcNf2t6ceJ0882vv8iV+Zs2Ptguid04pbzW8RMqyzCoEpfovvaDhe
	 Z55oHvIgxOsn2MkUOrFLqR2v/+m388Cf0wFoA4+bRfzdZt9My628NTzFZFOdoHxfKUnXo
	 Sq6R7i3cZ7e1856mslA5RFyZNrnjIOCCwWFA53MC4pTRi3sAAXmYQz2vzaqLvL1pvDbLj
	 PNwBSvp2cQ796aweMMLFi91NyHaDyBvbE8or3pQAv8ZMAxxoRNWDrlvwKnqb+wKEONM50
	 wLQIEFprC0GlwWBEpR6M2rxFQ7JZx392nPM4fov0M7F1kBDnttTofeoJQ+meI4itIhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641630;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Wxx3Kjx0mJf9XBZaE4kosblbKxUtIvOwdqTEc04mHgY=;
	b=woBqb458Fl+/ulVD+sSmbWSN+x9EGfKKhPafLZeg9c1lTrF1ivi8UrOjyHMlNuul9Yzd
	 17El+e561CeG+NShP35sZ/ajzEXEMFi8SEhl9aAi0e9xMyp6DGp6iMVdkAY7hT2ScNlO+
	 GdwIrIR9gKom7shntgiMO0wZAUP4PfrEXNNqyD5oYeFxx7yx9dPE+frD9flWArKkeDGMM
	 cW6bgSwaoJ2vl7gqmce4gv5UH5fwMzc6kmiSvNdnQjMRkGBY2zrNVTE+vp6K62lsXl5d0
	 nWofdw9xQRFixEpEosipbX3Alui50HmSzgOMLSmf3K75gXA7YTQnIFWiXGMkpIcqjbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUbQdfO+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D10606A338
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUbQdfO+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0A71F00A17;
	Mon,  2 Nov 2026 17:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793641629;
	bh=Wxx3Kjx0mJf9XBZaE4kosblbKxUtIvOwdqTEc04mHgY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hUbQdfO+3zc74QUm9xlAG4suIAv9Pz8s2yHKHAlFg69YmQcu2VLcOJT6VTvWi4W2g
	 jjw3wOGJiXsGMGsZhuUHPLsMS4gCrwy8vefAOOyCJKT8YCQvlzgoEjsj792x73EgNn
	 3HXh1TM9PyIQCWFQLphaPHSqvLt2KjoX4ZufoblsdDl1UNFUKgeQDs+n5Jhc+SPFJ+
	 43QgFtJncqsUQ0m64lTXqJzEEtHKk03cmC6yeZ9/X+0d7NwaLv6driL06wtf7fDu6O
	 jYzlEJoP+Vhv0XEVCwyp/UT+wrvUeJ2TL5B37V7jJZEEnrrvYFjSd/3p3Lt5dBBcfx
	 cHYcbeaWjrlmA==
Message-ID: <b32cb1d9-3ab7-4c2b-b18c-c8d1989637fd@kernel.org>
Date: Mon, 2 Nov 2026 17:47:05 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: resolve_btfids segmentation fault with
 CONFIG_DEBUG_INFO_BTF_INLINE
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
References: <20261031040305.GA2789538@ax162>
 <DMJB936DLIAX.3166HNLTM50U4@gmail.com>
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <DMJB936DLIAX.3166HNLTM50U4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/26 8:36 PM, Alexei Starovoitov wrote:
> Thanks for the report.
> 
> It's a use-after-free in libbpf that resolve_btfids --inline runs into
> on a module whose BTF has no strings of its own.
> 
> With the patch below that module builds and ASAN is quiet. The output of
> resolve_btfids for vmlinux and for the modules of my other test builds
> is the same byte for byte with and without the patch.
> 
> Please give it a try.
> 
> [PATCH bpf] libbpf: Fix use-after-free in btf__add_type()
> 
> For every string btf_rewrite_str() does:
> 
>   off = btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));
> 
> When the string belongs to the base, the pointer goes into the raw data
> of the base. btf__add_str() looks the string up in the base first,
> btf__find_str() calls btf_ensure_modifiable() on the base, and that
> frees the raw data. Then strset__find_str() reads the freed string.
> 
> Make all the bases of dst modifiable before the pointer is taken. 
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Thanks for the report and the proposed fix! I've reproduced the
failure with Nathan's config + latest LLVM 24, and can confirm
that the suggested fix works. So feel free to add

Tested-by: Alan Maguire <almagui@kernel.org>

I'll try and come up with a test that exercises the failure path.
Thanks again!

> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index d2ff6f5d6d..95c31803e7 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -2222,6 +2222,7 @@ struct btf_pipe {
>  
>  static int btf_rewrite_str(struct btf_pipe *p, __u32 *str_off)
>  {
> +	struct btf *base;
>  	long mapped_off;
>  	int off, err;
>  
> @@ -2234,6 +2235,19 @@ static int btf_rewrite_str(struct btf_pipe *p, __u32 *str_off)
>  		return 0;
>  	}
>  
> +	/*
> +	 * btf__add_str() first looks the string up in the base BTFs of dst,
> +	 * which makes each of them modifiable and frees its raw data. If src
> +	 * shares a base with dst and the string lives in that base, the
> +	 * pointer taken below would be left dangling. So make the bases
> +	 * modifiable before the pointer is taken.
> +	 */
> +	for (base = p->dst->base_btf; base; base = base->base_btf) {
> +		err = btf_ensure_modifiable(base);
> +		if (err)
> +			return err;
> +	}
> +
>  	off = btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));
>  	if (off < 0)
>  		return off;

