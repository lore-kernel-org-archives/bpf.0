Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA53175A73;
	Thu,  9 Jul 2026 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601731; cv=none; b=GAJMXRKC0W2e5pEpvqvy32NP1XJnq5N4k/OC6+fWCg77MHUQx5ossoP2c5uqTtuaKlXt0XsOxHK72etLVvQCRQS0XH8oJSK1bWUFdoYhTfQef6wO7lcREsEumgXiA1xOBjlV+k2WmqWOUR6KEx5yWqSP2szRP3OGrUgn0zmjXJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601731; c=relaxed/simple;
	bh=lgmW/9fuiA36TiD3uKsMlmKXfZqkOl52hD77GE42H18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBDs+HafPRIs6D3h0UMb4USZ8F07rS1A0eIfNjjKjqd1Tq0N7L3UTt1kmn+FDyBVZhEp4ddJUaKsJu2pxVwOwwpDYlrDrIxbbJRQ51aoa/cJMLxEiNRc3jq9xDVIX5VjKhxPFTsF27jM8RSerUyKK8DEaEnsab1Lf3Ikj3+WcZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1kYneIo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1kYneIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AC61F000E9;
	Thu,  9 Jul 2026 12:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601730;
	bh=fy+WU+sPrTYSQua5IuDks8DlMF9qDRu6nwaevDw60y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n1kYneIo2IwG1zBn3OrekwgThhMsV1q7/J3uEWhRRLVYQ68D+6fzljE9kxmZrSLAx
	 yHQ/g9nCHjzge4rmKoi2fSvUdI13mc0PC0o+GVX/mTpVQ2CzCXqckZPoWbKAe5s1nj
	 dKrbwI71BIRpGAcVUem9wv20D1M2L7OxujYoVzAi771bDmUooUJUMlIvJF6aosHdmz
	 Zt6O6acpJ1l5evgu4qIldVZlDdo8Y8PisnOqlCF/ntt5+eWX+lAI84rQbtQowEIxNX
	 ro+FESi9MMtU0aAjxu8lHaNDK1KPkXCtobDnCliyFUoDpejDOIN4ErJ9FXzqApe94R
	 dBu3pGVeBYwpw==
Date: Thu, 9 Jul 2026 15:55:21 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH bpf-next 0/5] bpf, x86: enable EXECMEM_ROX_CACHE for BPF
 allocations
Message-ID: <ak-aOUZ1waAIKtpQ@kernel.org>
References: <20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org>
 <ak9V1C-Y3x-KEcTW@kernel.org>
 <b2fb9a37-3810-45a5-97dd-ed500ae8207c@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2fb9a37-3810-45a5-97dd-ed500ae8207c@iogearbox.net>

Hi Daniel,

On Thu, Jul 09, 2026 at 02:12:04PM +0200, Daniel Borkmann wrote:
> Hi Mike,
> 
> On 7/9/26 10:03 AM, Mike Rapoport wrote:
> > Gentle ping
> > 
> > On Fri, Jun 26, 2026 at 09:42:27PM +0300, Mike Rapoport (Microsoft) wrote:
> > > Hi,
> > > 
> > > BPF allocations of executable memory on x86 are essentially read-only. Most
> > > paths that call bpf_jit_alloc_exec() immediately make it ROX with
> > > set_memory_rox().
> > > 
> > > The code generation, at least on x86, uses separately allocated writable
> > > buffers and then updates the actual text memory with text_poke().
> > > 
> > > These patches do several small adjustments to how BPF allocates executable
> > > memory and enable EXECMEM_ROX_CACHE for BPF allocations on x86.
>
> I think there was an open Q from Alexei wrt the sashiko reports [0] and
> whether you could address them. Once done, please resend to bpf list.

Thanks for the link!
I'm not subscribed to bpf@ and it took me a few minutes to realize why I
don't see this in my inbox.
 
> Thanks,
> Daniel
> 
>   [0] https://lore.kernel.org/bpf/20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org/#r

-- 
Sincerely yours,
Mike.
