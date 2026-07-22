Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CD4372EFA
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732657; cv=none; b=omQjP3f7C8w+YRUuOGk3TAhJZAJUvf5COnH1s9nkN/jKMnR6cknT9Lg/ScPr7Y25hCvzNbbk9UcElLRXjOXpFIpWmSHt64Up41aFc2ZcmNMJbPku3w0J1z7HMl9UWma+C5vBrHK9w4SdbykYSAx0duotPhPhsMk1L8Vm1vETsyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732657; c=relaxed/simple;
	bh=Kpsdk6gvbVMJyy79FrelzGVd3KJuToBjykzbNKyM2JY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLJmwEerL2m56eqCCTrsqUxd212Taewl2+QV0NyOL/1cdwVDTp5SI1QV8/9Y+FhqF1mPxURAvNYF7z+dfpsd2E73K4nnwG6fdVK8lxhTujLgL9tx2IjiqQ6I/BFbfBYA1S+jPURBFrhQMN6Hgfmq0OOyuPA2zLtlyB4dLQVH7s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFTU3VEK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFTU3VEK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFFC1F00ACA
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784732656;
	bh=Kpsdk6gvbVMJyy79FrelzGVd3KJuToBjykzbNKyM2JY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PFTU3VEKrv+SYyAR45atDrBmvqFoWP3zEhSEJVplKbc7y71g+22qp0IohTUzLodcM
	 boQuGL5/c3RPxBSTwI970kLXPRHFunmgx9Zrwu1iHug8zIbzsj44jBd0F+ahicEJ/Z
	 tfK2/mUhekkT7MHJK6kOJjc5sQsZw7Kxx2QuG9f+z35nZvC/QNVsYdCsiTNtmZjy1V
	 +chXWAw7J+/bx0Jz8PvnY9hxHXjygd+KtL2KJkrVjtzp+E38CWrhlY2iGlGArqG6w0
	 CYqghy4K+ZttQJJjQEOMAUwSXs0bVun1JtRMzTfjasw8S68jO5vhFmIE8UJc2L8Va8
	 BSGuVqmsU7fRg==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-930f72317a6so69883585a.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 08:04:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqMjkvvR4WAj1cnnqi18jbHs/Kij10zQUTuiJYvVR+4xrwVIsYQCNU7CQJrUFr5st7tQbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNcAlQuebb4O+uB1+8bZJS2/eJVVDj0pGScAgf+X+NTXNyPf58
	e/3KSWtUGu2GM99J0c5UoSj+znGxGg3WPKmgqjnY8vGvUEcXTbrt3mz27CE1NOt5M7On/OG3OWH
	h/ZWQ9dPbckuqRGyrEI6Wg+RAHh8clnE=
X-Received: by 2002:a05:620a:4109:b0:915:7fe4:cac5 with SMTP id
 af79cd13be357-930b41e2989mr2185781185a.49.1784732655635; Wed, 22 Jul 2026
 08:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
 <CAPhsuW5pRMtpa5Q0Y=zO5=2HSj4xOX+i5Vp+g2a6RDvmkeHKFw@mail.gmail.com>
 <alnOkjf8rq3dUGmg@kernel.org> <CAPhsuW7xvJM6PPGwkeZJhi+a-emuuX09uxKom29mns5-iwOYXw@mail.gmail.com>
 <aln1_kGygUqdtlAt@kernel.org> <CAPhsuW4dt6YdNnce4wfJkVuuP339sh=0wCGwBG2_Nc2BYu4CSQ@mail.gmail.com>
 <alyXjynKnIp7X-3b@kernel.org> <CAPhsuW6+6zcSRGUAtp=3e4a8at3yuRP8Xijb-4LBHtQ8Li6wrQ@mail.gmail.com>
 <amB52yECfXNgbeY4@kernel.org>
In-Reply-To: <amB52yECfXNgbeY4@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 22 Jul 2026 08:04:04 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6St=y8ekEVmQke6jPeyNC8MqhW9oG1wDJOwWmPbFZzWQ@mail.gmail.com>
X-Gm-Features: AUfX_myWueyfpxy-fZ1uZaEg5UzIFbIq39Hz7-XZvrLw7XZ7ItncKWDyDlpLtoY
Message-ID: <CAPhsuW6St=y8ekEVmQke6jPeyNC8MqhW9oG1wDJOwWmPbFZzWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/5] bpf, x86: enable EXECMEM_ROX_CACHE for
 BPF allocations
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	"H. Peter Anvin" <hpa@zytor.com>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 1:06=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, Jul 21, 2026 at 10:59:06AM -0700, Song Liu wrote:
> > On Sun, Jul 19, 2026 at 2:23=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > > > >
> > > > > Since commit c82be0be9576 ("mm: vmalloc: don't account for number=
 of nodes
> > > > > for HUGE_VMAP allocations") vmalloc_huge() is fine with PMD_SIZE =
regardless
> > > > > of number of nodes.
> > > >
> > > > Before execmem can handle sub page allocations, how about we
> > > > send allocations that are bigger than page size directly to execmem=
,
> > > > and let bpf_prog_pack handle sub page allocations. Then,
> > > > BPF_PROG_PACK_SIZE will be PAGE_SIZE. This should be a net
> > > > win for x86_64. Other archs will be the same. WDYT?
> > >
> > > Makes perfect sense to me for x86.
> >
> > Can we include this change to this patch set? This will make this
> > change a meaningful step towards migrating to EXECMEM.
>
> I'd prefer to leave this as a separate followup.
>
> The decision whether to use EXECMEM_ROX_CACHE is made at runtime, which
> means that BPF_PROG_PACK_SIZE should become a variable, that variable nee=
ds
> initialization at some point during boot and that in turn requires a new
> helper in execmem that will say if EXECMEM_CACHE_ROX is enabled.

Hmm... deciding whether to use EXECMEM_ROX_CACHE at runtime seems
weird. Can we enable it all the time and decide how much memory it reserves
at runtime?

Given this constraint, we can probably ship this now and do the rest in a
follow up set.

For the set
Acked-by: Song Liu <song@kernel.org>

> > > On architectures that support large mappings in the direct map and do=
 not
> > > support EXECMEM_CACHE_ROX this will increase direct map fragmentation=
.
> >
> > Architectures that support bpf_prog_pack can benefit from
> > EXECMEM_CACHE_ROX. What does it take to also enable
> > EXECMEM_CACHE_ROX for them?
[...]
