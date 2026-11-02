Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645787;
	b=jXsJIe4bU0EREkbb8EhifoEJWsTdN5UwJm32QvI9Ha5n4QIm1QbIjgFneDGf9yq0TdZV
	 KWu8ilx6GOZ45OqP6I44wlUE52i6oMJ97nv84M4/m/jUhbry4GgjBNdoza+qM7mDd7+MP
	 r8MfbFtRCFF15ira3lgoKI/dM0UUlgOEk5FiW/jggG4BAnvqj+XJk4iDci743JrUBgoIA
	 O79C4ojry+Q3RhuOSkv6eN/oLcHYFqRHfRVbiyLaAtlxBEvaWDroIHnBMG3IrRL8K/+EO
	 YF6hCmXGfvSYag8w4aAHF2aweALmF9Ifg4tmDSdHlMsHvT1SK2+s1SzFqtbzjvD823Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645787;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZX4k6fkZrVQQn6jS19mXwG/IPZoY3/VLudiPBAdYq7Q=;
	b=oRn53PS6cQgQBSwYVtdSNC/1qDTf+7mzAwNGfKYYx24J8UWB0Y21/uylznARjhAdg6qK
	 DrfN98aTMNpaJNLi44C+xvo20q4nmjyTRWkSwm4fOxEMq2lgt2lEPEdccmN3tnrGwd6pF
	 LskK70T5pubvkHhlrBK4Th5iFWqWNSCjTG/oOpHEkLXlJjMxvrgTfjCWA1Q6SfgbihuMG
	 BWn+2w9Qfo98dN0cmnb1Tk1zDb5hP6B8RZNDocVr/4IgkcLiAROHZJGsNd1cHZmj0KmWP
	 TQdqchiN/9Oo6eoj2rBLlF31cqAolKZnL5IGwRIz0WePR7evgK6buCi9pLLMbEh7jPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wf9KLsKc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9B9606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wf9KLsKc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE761F00A17;
	Mon,  2 Nov 2026 18:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793645786;
	bh=ZX4k6fkZrVQQn6jS19mXwG/IPZoY3/VLudiPBAdYq7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wf9KLsKccjqDRnXd+4gKWedjKAJdW2/JlII7e6vk+QfdzN4rKEB01BfhMfj7nwB3K
	 dw1uDExC1MvUhMf4qww55iUwWJMZq9QU7AnR8rV7d5PFS14O9Wfpd18CE9Fk4JqGzu
	 h4T1OHIbN25ofbXXPo6nj2qTpEYoVrJCCxvhYI+5AczeeMvOb4jlCOQ3CZch4/LGf7
	 IV5t5c85nsV5EEgYueGdSGzByCKyQcNipNsiNury7RweUyDp8R4uxDsArl/CR3P4Fq
	 eqxj8TGPddwZnHNlHLXb2YCZy5RMSH2jvJqdHdT5vaZ3zxZjGsvsxAQRjpYMnCIC5S
	 nekgs8crJC2sw==
Date: Mon, 2 Nov 2026 11:56:22 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alan Maguire <almagui@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org
Subject: Re: resolve_btfids segmentation fault with
 CONFIG_DEBUG_INFO_BTF_INLINE
Message-ID: <20261102185622.GB1177738@ax162>
References: <20261031040305.GA2789538@ax162>
 <DMJB936DLIAX.3166HNLTM50U4@gmail.com>
 <b32cb1d9-3ab7-4c2b-b18c-c8d1989637fd@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b32cb1d9-3ab7-4c2b-b18c-c8d1989637fd@kernel.org>

On Mon, Nov 02, 2026 at 05:47:05PM +0000, Alan Maguire wrote:
> On 10/31/26 8:36 PM, Alexei Starovoitov wrote:
> > Thanks for the report.
> > 
> > It's a use-after-free in libbpf that resolve_btfids --inline runs into
> > on a module whose BTF has no strings of its own.
> > 
> > With the patch below that module builds and ASAN is quiet. The output of
> > resolve_btfids for vmlinux and for the modules of my other test builds
> > is the same byte for byte with and without the patch.
> > 
> > Please give it a try.
> > 
> > [PATCH bpf] libbpf: Fix use-after-free in btf__add_type()
> > 
> > For every string btf_rewrite_str() does:
> > 
> >   off = btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));
> > 
> > When the string belongs to the base, the pointer goes into the raw data
> > of the base. btf__add_str() looks the string up in the base first,
> > btf__find_str() calls btf_ensure_modifiable() on the base, and that
> > frees the raw data. Then strset__find_str() reads the freed string.
> > 
> > Make all the bases of dst modifiable before the pointer is taken. 
> > 
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> 
> Thanks for the report and the proposed fix! I've reproduced the
> failure with Nathan's config + latest LLVM 24, and can confirm
> that the suggested fix works. So feel free to add
> 
> Tested-by: Alan Maguire <almagui@kernel.org>

Can confirm. Please include:

Tested-by: Nathan Chancellor <nathan@kernel.org>

Thanks a lot for the quick fix!

-- 
Cheers,
Nathan
