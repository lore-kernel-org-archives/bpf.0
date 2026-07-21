Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD33946A5F6;
	Tue, 21 Jul 2026 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649076; cv=none; b=PydCmfZqT71k8OTpU1K8wdMp9zfJrYjHYUAVRdxjb6tDi3b0OTQOXx/gZOSdL6XeAFsyKWI28vXjahmW68mLTMry5Lf0ETEhWLOtwIc7bX8bQ1DURVNTz5wWlgnvIkTQRgt2g3GQFfEayhXB4GSGkmf8lXJS6IZSn6P+1DATZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649076; c=relaxed/simple;
	bh=DVPyHW0XwrfN/ARz9I7vSKy6YcRnUybiuVJGoprGeho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHTgTGFT1VDABOMRUC2zbzWHCNm4mBM+QaYD6IVuzgMXjk88NjcWRs7jBWBSu8w1UDptdlvnYEAfbZvhjUE0BtQsdUYRzJZ5aBpJz2vdr+D2JNsUIRQ1LphspuiDHcdXR70gGUYRk2jg14wrvGDDPSUFS8Tp6Tq2ll0uax+azFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngGJQP+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngGJQP+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9EF1F00A3A;
	Tue, 21 Jul 2026 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784649075;
	bh=xPFgpqelm3KzhlklrUXgk07r+xZpxddeLaIASOgV/7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ngGJQP+gd2aG+7zUPTDalZeMxxDHcVLT2J5AY1NxzsORGCaLoh835G9fT+g6bXpap
	 7myDCluJigrw1aXQxcdI9NDJUp/e8nCAC9bw+4daFojNeAAcEon6p8GsZxNhSr1mjJ
	 HLcuwZaUflp4EcQCu7TUA2DhnZux46dI6OUVGb/1Qam7IANslxaRvINejsgffvoMd0
	 txwo3cAfq7PNgVt30kGiNsC6ZaMa8xE17w2iVILAj3Ulymw6ALCjVvIekBFdJ7aPH1
	 7SXIL59rfVudGsdNOsihaJRvvH4/CQFvpsjVjxYZfsVrDVnkcRXkZO2UmbKUSqcq7Q
	 OFsXaolEGUe5w==
Date: Tue, 21 Jul 2026 17:51:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v2 16/21] binfmt_elf: consume a stashed PT_INTERP
 substitute
Message-ID: <20260721-hemmschwelle-relation-abspielen-d343249b9b79@brauner>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-16-e57866e4ae0f@kernel.org>
 <20260721143858.EBE431F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721143858.EBE431F00A3A@smtp.kernel.org>

On Tue, Jul 21, 2026 at 02:38:58PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] `load_elf_binary` consumes `bprm->loader` but can later return `-ENOEXEC`, defeating the `begin_new_exec` safety net for fallback formats.
> --
> 
> --- Patch [16]: [PATCH v2 16/21] binfmt_elf: consume a stashed PT_INTERP substitute ---
> commit 1d03dfaf1de4f305ec2f86af4a17c4c21f4a7858
> Author: Christian Brauner <brauner@kernel.org>
> 
> binfmt_elf: consume a stashed PT_INTERP substitute
> 
> When a binfmt_misc loader entry stashes bprm->loader, use it instead of
> opening the path named in PT_INTERP. A binary without PT_INTERP drops
> the override and is loaded natively.
> 
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> [ ... ]
> > @@ -932,6 +932,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  		goto out_free_ph;
> >  	}
> >  
> > +	/* No PT_INTERP to substitute for: the override does not apply. */
> > +	bprm_drop_loader(bprm);
> > +
> >  	elf_ppnt = elf_phdata;
> 
> [Severity: Medium]
> If load_elf_binary() consumes bprm->loader here (or earlier in
> bprm_open_interpreter()) but later returns -ENOEXEC, does this defeat the
> safety net for fallback formats?
> 
> For example, if parse_elf_properties() fails later in the function:
> 
> 	retval = parse_elf_properties(interpreter ?: bprm->file,
> 				      elf_property_phdata, &arch_state);
> 	if (retval)
> 		goto out_free_dentry;
> 
> If this returns -ENOEXEC, load_elf_binary() will exit after the loader has
> been consumed (bprm->loader is now NULL).
> 
> Would this allow search_binary_handler() to fall back to the next format
> (like binfmt_elf_fdpic) which could then successfully execute the file
> natively, bypassing the intended loader override?

If there's no PT_INTERP for the binary we have no business with it and
hence elf fdpic doesn't.
