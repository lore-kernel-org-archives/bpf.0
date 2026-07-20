Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ACE379ED6;
	Mon, 20 Jul 2026 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547039; cv=none; b=R+PgwQXuCtid4gTyKC1gD1dZz56hwTS4vR0PVjcBu4Q8bAUjEz4YT8gDHcInreBM6jvPzb6UzumHFozhEdowJy0s0oF5VaDfC5gr89AkUFNBnW4ar83sClqCF1PaU06rI8uYwgxSxJfbijDEVHl2kMm8nSqgTTxRwroTWpuF42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547039; c=relaxed/simple;
	bh=FHiPHG6GMQXKp7yaGIbgNN9Q9g7WtNOkhFqkDZ29cvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=by+GCmo+Rpfvtf9ekjluLkownMFFmWPMBFoC3lkG64O16EyeHD7Y6GST07+7M/WaVuI902UBkOhUh96eKq7gJtOHmw9iPRVtACudCUszkvFMIoyHDWFF8g2YGRp/y1Q2fFrtPhRZCOxt7KJKOPcpWZLqe3sMLbv/Iy1r7XXFrMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEYFe7HA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEYFe7HA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BE11F00A3A;
	Mon, 20 Jul 2026 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784547034;
	bh=WyW+r9sksJgBpMD36RNeUsaevoVTkZP5hzcwgxCVcTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FEYFe7HADDb4RfPdoBf7ETujzDEJc+IcdanVnI5HWqCmlDS4ikopPqxjKjT1tMt/r
	 6J4bVEtTIz5SCof4YUi/sIE22h4bVYYF/oFi3iAKKYJ0gCTy9YP4XOTAgQTOjOLkhX
	 FWxfA0p9W4xHJJGSOWi+UWExUQPP9RQAJ/uwJw2g1Wq6/xYFPkjfzhYp3w+GyQOXLD
	 U38jJDNPRzxQ+qi/dqLrGDq872AT2O0K9rXG8Mek33MsOPKLHUxC6jYfn04IXhBuKy
	 B+mVm2q+8W0JRPtIUKpU2mKhHoCoNQcbX+vu6THWgmLd842/w+2bFNBUQQFLftEf3V
	 NNUOSprlalXjQ==
Date: Mon, 20 Jul 2026 13:30:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH 01/21] exec: do not act on a stale execfd request without
 an executable
Message-ID: <20260720-fanblock-authentisch-typisch-6c69318d3ac5@brauner>
References: <20260720-work-bpf-binfmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org>
 <20260720-work-bpf-binfmt_misc-ptinterp-v1-1-ddb76c9a508e@kernel.org>
 <20260720100022.9212B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720100022.9212B1F00A3A@smtp.kernel.org>

On Mon, Jul 20, 2026 at 10:00:22AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the patch fails to fix it completely. It fails to clear leaked `have_execfd` and `execfd_creds` flags if the fallback format uses an interpreter (e.g., `binfmt_script`), potentially allowing setuid script execution.
> --
> 
> --- Patch [1]: [PATCH 01/21] exec: do not act on a stale execfd request without an executable ---
> commit 9dcfa7daaba6407f79aa884e4fa9f0bc5d755870
> Author: Christian Brauner <brauner@kernel.org>
> 
> exec: do not act on a stale execfd request without an executable
> 
> This commit addresses an issue where binfmt_misc leaves bprm->have_execfd
> and bprm->execfd_creds set when it fails to open an interpreter. It clears
> these flags in begin_new_exec() if bprm->executable is NULL to prevent a
> subsequent NULL pointer dereference.
> 
> > diff --git a/fs/exec.c b/fs/exec.c
> > index c698aabe9abd0..2f50aa0398278 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1112,6 +1112,12 @@ int begin_new_exec(struct linux_binprm * bprm)
> >  	struct task_struct *me = current;
> >  	int retval;
> >  
> > +	/* A declined execfd request has no executable for a later format. */
> > +	if (!bprm->executable) {
> > +		bprm->have_execfd = 0;
> > +		bprm->execfd_creds = 0;
> > +	}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this check completely
> resolve the leaked flags issue?
> 
> If load_misc_binary() leaks the have_execfd flag and the kernel falls back to
> binfmt_script, it looks like exec_binprm() might unconditionally consume the
> leaked flag and set bprm->executable to the script:
> 
> fs/exec.c:exec_binprm() {
>     ...
>     if (unlikely(bprm->have_execfd)) {
>         if (bprm->executable) {
>             fput(exec);
>             return -ENOEXEC;
>         }
>         bprm->executable = exec;
>     } else
>     ...
> }
> 
> In the case of a setuid script with a statically linked interpreter (like
> #!/sbin/busybox.static sh), would this cause begin_new_exec() to see a
> non-NULL bprm->executable?
> 
> If so, would it bypass this cleanup and compute credentials from the script
> rather than the interpreter, potentially honoring the setuid bit on the script?

This is the same finding I had basically. It means we need to clear this
where the flags are set. That needs to be backported to a lot of older
kernels so we need it right at the beginning of everything that is in
vfs-7.3.binfmt... I'll send that as a standalone fix in a bit.
