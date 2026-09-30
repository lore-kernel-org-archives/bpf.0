Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96E3BFAD0;
	Wed, 30 Sep 2026 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751378; cv=none; b=burm8fbiE49Ow8mfeupFG8bQPA0SnVPxYSsmSqKwZEVzVRr++u9oXE+XLjC4/Cpt5PVxNmmTvkOMIrfuKVlVAFbf9SBXcaN7DO/w5koY+E8RAQsvW6WI6t8OICnq6v0guwC963tGth1xB2Gnr4HYYvCE7+NzkXqlRWi/NWTWfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751378; c=relaxed/simple;
	bh=O/FCAtcOOSix3cqXXADIQePkBxdLdFb+SvJpifZUruk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srJxm6ihbkz4rLw9eA0JHpA8vUUcjMeuesi4GjStTRiopfHwPrsgjs2iCGQbGL+SgYmu+m4p9h8M5K07iy5bblgcu/MiKgc5iCYA2AM5mvDnJWItIIdAH916cqqxpyWiHEZdvSkHSTO3vhSEd74MYXN0Ziwu7bPpXR+Br7a9FOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtY28J/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtY28J/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337AA1F000FF;
	Wed, 30 Sep 2026 06:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751373;
	bh=xhqf939hx9m7+7epv447bweVCAzfzE7EVLV/ztuw/nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PtY28J/rIPXLmEZHNTtCCQtYpPEj0sG/nFQmG1JgSXZLww8iVWCZmurgdq5CKIgVj
	 mXVlqHY6JyDU2p/L4E+mTpcOe9rLlV9RlUbxd8VcJX9P/eVuqOZcQvy0YbJX+wpcqE
	 nvzW2vo2esbjbANxvasUZmwLeBCS6XbiWMyUUxIKcnWZ6JS0AoapN/fc8mO6I85BOI
	 F8Katp6WIcl1Le0TXLR8eMexSKIM3NGyCk09QyG+giIoFTbJKawHZWmV+u7EK/bACZ
	 5pL4Trrv+wc4AJlI9AkbCE4PomhqXD4YIRNdl6fbf1XCyZWah2AwT8t14fPUq+m5ai
	 pQkBxi5/FSdFA==
Date: Tue, 29 Sep 2026 23:56:12 -0700
From: Kees Cook <kees@kernel.org>
To: jim.cromie@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v7 3/3] kallsyms: Unroll 24-bit sequence reconstruction
 in get_symbol_seq()
Message-ID: <202609292329.87EE58BCF8@keescook>
References: <20260929-ksyms-tune-v7-0-be568ceef41e@gmail.com>
 <20260929-ksyms-tune-v7-3-be568ceef41e@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-ksyms-tune-v7-3-be568ceef41e@gmail.com>

On Tue, Sep 29, 2026 at 12:07:32PM -0600, Jim Cromie via B4 Relay wrote:
> Mark get_symbol_seq() as static inline and unroll the 3-byte extraction
> into direct byte shifts: (p[0] << 16) | (p[1] << 8) | p[2]. This
> eliminates loop induction variable maintenance and allows the compiler
> to generate direct loads and constant shifts.

So... did you actually see any difference in the output binary? This is
such a small loop I'd expect every compiler to both inline and unroll
it already. *time passes* I've checked; I was mostly right. :)

It's already inlined and unrolled by the compilers, but GCC weirdly
didn't see through the array math:

  At -O2 GCC (and Clang, mostly the same) on x86_64:

  before                                  after
  lea    (%rax,%rax,2),%eax               lea    (%rax,%rax,2),%edx
  mov    %rax,%rdx                        movslq %edx,%rdx
  movzbl seqs(%rax),%eax                  movzbl seqs(%rdx),%eax
  lea    0x1(%rdx),%ecx                   movzbl seqs+2(%rdx),%ecx
  add    $0x2,%edx                        movzbl seqs+1(%rdx),%edx
  movzbl seqs(%rcx),%ecx                  shl    $0x10,%eax
  shl    $0x8,%eax                        shl    $0x8,%edx
  movzbl seqs(%rdx),%edx                  or     %ecx,%eax
  or     %ecx,%eax                        or     %edx,%eax
  shl    $0x8,%eax
  or     %edx,%eax

So it's actually the loss of the "+ i" part that does it.

> -static unsigned int get_symbol_seq(int index)
> +static inline unsigned int get_symbol_seq(int index)
>  {
> -	unsigned int i, seq = 0;
> +	const u8 *p = &kallsyms_seqs_of_names[3 * index];
>  
> -	for (i = 0; i < 3; i++)
> -		seq = (seq << 8) | kallsyms_seqs_of_names[3 * index + i];
> -
> -	return seq;
> +	return (p[0] << 16) | (p[1] << 8) | p[2];
>  }

I'm on the fence about readability, but I think it's improved.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
