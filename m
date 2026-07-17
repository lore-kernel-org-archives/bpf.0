Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414263BBA01;
	Fri, 17 Jul 2026 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270510; cv=none; b=QUHd1cx1GbXIyLkdUGv76ULak1CQ4nvXHRGr6x3eIgzfmZ4F++6HrnWAgCjBDT9VFwpRUPopIW059ye7+956D2NdLJoh1WvUvzRXXrOHeFthBPJTcPSc5CfynPlsjyJ0XXvoIQPmuCLAL7TszqzhdW/zdZp92qmj9GsVcc9KEJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270510; c=relaxed/simple;
	bh=9xNXfCWLAqBC3ulkM3qh8DF1At54FXqC7nm+D7oeF1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s16gEM4qQudJzJD/2/1hHAWP0AzpjedhefgNRO0S7cnz+6uzmPyf6ZLmsKCSSMgL3pPBmFqGYUYDGN0Ad6lKJWvCRLmzjW2ditMQMRx9rYc4QASmbjOONDWv9Zt8svMDJsrBUV2Kd9TUGZ1GCrsfjr5fj/Syo0kvD6WhwB59Svk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHo1a2H+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHo1a2H+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1977F1F000E9;
	Fri, 17 Jul 2026 06:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784270492;
	bh=AR2WUaN40b69ENQDLvIRE6Dl8TK13zKRTQBCCA7YVzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gHo1a2H+KPUsPmhnfncydM3Jwsco/Jy9B9SXBilHDUf9sNcHkRymfwq1ogY+RfaFO
	 /a7YHnFvLwpjBZ6d+fAWhs03JyFmtn0uOiFyKhxh/rMGCKJqct4uhKK/B4jbrStFhJ
	 djpP+mvWHwPvoigPgmPmAr55dWfTSt92Rw/9ry6OhBUJCHl7GxZDoBqwGTnUm+g2Pz
	 eJrH//2jmyAJ4OHcWAbZlc/y9rQl+3yTrzYRSx5OoQcMwN0wEbm9YOZp088DQDxult
	 OWVX7u2PWNvCVg+aDWzM4AJvSj/EH3+54+p/lzOmrKJOEuVkaItzA67xpeZWJo3Mez
	 XNr83eADZH4Ow==
Date: Fri, 17 Jul 2026 09:41:22 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH bpf-next v3 0/5] bpf, x86: enable EXECMEM_ROX_CACHE for
 BPF allocations
Message-ID: <alnOkjf8rq3dUGmg@kernel.org>
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
 <CAPhsuW5pRMtpa5Q0Y=zO5=2HSj4xOX+i5Vp+g2a6RDvmkeHKFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5pRMtpa5Q0Y=zO5=2HSj4xOX+i5Vp+g2a6RDvmkeHKFw@mail.gmail.com>

On Thu, Jul 16, 2026 at 05:00:11PM -0700, Song Liu wrote:
> On Thu, Jul 16, 2026 at 12:51 AM Mike Rapoport (Microsoft)
> <rppt@kernel.org> wrote:
> >
> > Hi,
> >
> > BPF allocations of executable memory on x86 are essentially read-only. Most
> > paths that call bpf_jit_alloc_exec() immediately make it ROX with
> > set_memory_rox().
> >
> > The code generation, at least on x86, uses separately allocated writable
> > buffers and then updates the actual text memory with text_poke().
> >
> > These patches do several small adjustments to how BPF allocates executable
> > memory and enable EXECMEM_ROX_CACHE for BPF allocations on x86.
> 
> After this set, we are still using bpf_prog_pack_alloc() from x86 code. I think
> the goal is to eventually remove bpf_prog_pack_alloc(). What's our plan for
> the next steps (toward removing bpf_prog_pack_alloc)?

"It works, don't touch"? ;-)

We can add another layer for sub-page allocations to execmem.

Since BPF is the only user the easiest would be just to move prog_pack
logic from BPF to execmem and call it a day.

Another option is to add a slab-like layer for sub-page allocations to
execmem. This is more complex but it would allow to get rid of the rigid
BPF_PROG_CHUNK_SIZE.

Maybe it would be also possible to teach SLUB to use execmem_alloc()
instead of alloc_pages() but that's surely the most far fetched one :)

And since we are talking about bpf_prog_pack_alloc(), why
BPF_PROG_PACK_SIZE accounts for num_possible_nodes():

#define BPF_PROG_PACK_SIZE (SZ_2M * num_possible_nodes())

Is it an elaborate choice or it was picked to work around older
vmalloc_huge() limitations?
 
> Thanks,
> Song

-- 
Sincerely yours,
Mike.
