Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F155646AA60;
	Tue, 21 Jul 2026 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647872; cv=none; b=Sm3aQpKbkHIA2cP+A2ur0zdCI4tNgx2LpB1toSQRI6X9zO9QIosDfwcH4/eFYqzZe0naWW/NVyzyHaAbmxE/1qRWmfsb//5DxUWb9TsKHPpgxAsuBrU2qUzMrePybfUEaVHCh7uiuKHgIJol8mMp3qxk+7Nk1N9f4hboqLeZu1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647872; c=relaxed/simple;
	bh=vq6J+uiJzFQn5tiWlH/NkvUcMq5vwDrl8YcKF7ngaNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFhfyzGjoiWnDEcO38q650XpMnxQu/4h4xIHxgJ4rkMz+4vJ+3Ez27gXMhIJs0Ex/WFrCG3f2aVWtEiD4uhz9XdPfYhdgezug6aFs6Ph2fG5LJgLVaDYnqNOXoF4SSnBeSfDrZEz6VxxE/daloN9mvp5DvvZXYorrHv8cw3ZxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oByBuxVw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oByBuxVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34361F00ACF;
	Tue, 21 Jul 2026 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784647870;
	bh=TDoSBQJ2wxUWTX7HL0AV+Y8+YMEVzuUM9wOHnKpBXWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oByBuxVwWdFM21jYK0QWFGX+H/YJQ2AkLrTHhKUTFrluFBSCbWBqXu74SOu6+hJFV
	 PBuLluYj1zYiNGbi0AW2QQR179qWyezzDeWGB6Cp0OVuFr42hxm7t9k3lU6ipQGQmm
	 +D9GDr2pYIutBQd1BC5vUe1rBC3SygLsSpGfGBMkYxI0/0v2JAQ241JuvuKlKNN2C1
	 D64YtdO/K9dex8HUPe7966ZLnl284PovPNVjOzFdGL+hu/f1jZO7bi5iumeIKXBkZR
	 qW4Ht29diRwxFkqDmJcy/WyyFjhrd68JdeHK4YrySaq9Rhu5vGwXgUADZQ8UiXE4ba
	 H6wqSHv7/mldg==
Date: Tue, 21 Jul 2026 17:31:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v2 11/21] binfmt_misc: add a static transparent flag 'T'
Message-ID: <20260721-visier-dschungel-empfehlen-14d93d806fc1@brauner>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-11-e57866e4ae0f@kernel.org>
 <20260721143934.E2A5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721143934.E2A5E1F000E9@smtp.kernel.org>

On Tue, Jul 21, 2026 at 02:39:34PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Unprivileged users can spoof `/proc/pid/exe` of arbitrary system binaries to bypass path-based security mechanisms (like Polkit) using the new `T` (transparent) flag in a user namespace `binfmt_misc` mount.
> --
> 
> --- Patch [11]: [PATCH v2 11/21] binfmt_misc: add a static transparent flag 'T' ---
> commit b5f0e2f272e45d606e37bd2e4e198bd848f87a56
> Author: Christian Brauner <brauner@kernel.org>
> Subject: binfmt_misc: add a static transparent flag 'T'
> 
> This commit adds a 'T' flag to binfmt_misc registrations to allow
> transparent dispatch. The matched binary keeps its argument vector and is
> sent to the interpreter through AT_EXECFD, with the process identity set
> to the binary's identity rather than the interpreter's.
> 
> > diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> > index e5a17ca935cad..71833b976131b 100644
> > --- a/fs/binfmt_misc.c
> > +++ b/fs/binfmt_misc.c
> [ ... ]
> > @@ -764,6 +765,11 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
> >  	if (test_bit(MISC_FMT_BPF_BIT, &e->flags) && p != flags)
> >  		return ERR_PTR(-EINVAL);
> >  
> > +	/* Transparency preserves the whole argv, argv[0] included. */
> > +	if ((e->flags & MISC_FMT_TRANSPARENT) &&
> > +	    (e->flags & MISC_FMT_PRESERVE_ARGV0))
> > +		return ERR_PTR(-EINVAL);
> > +
> 
> [Severity: Critical]
> Does this code allow an unprivileged user to spoof /proc/pid/exe for arbitrary
> system binaries?
> 
> Since binfmt_misc supports unprivileged user namespace mounts, could a local
> user mount it and register a handler using the new 'T' flag to match a
> privileged system binary?
> 
> If the 'C' flag is omitted, the execution wouldn't fail suid checks and the
> interpreter would run with unprivileged credentials. However, the transparent
> flag unconditionally sets BINPRM_FLAGS_TRANSPARENT_INTERP in load_misc_binary(),
> which later triggers execution paths where the privileged system binary becomes
> the identity file:
> 
> fs/exec.c:bprm_identity_file() {
>     ...
>     if (bprm->interp_flags & BINPRM_FLAGS_TRANSPARENT_INTERP)
>         return bprm->executable;
>     ...
> }
> 
> fs/exec.c:begin_new_exec() {
>     ...
>     retval = set_mm_exe_file(bprm->mm, bprm_identity_file(bprm));
>     ...
> }
> 
> Could this bypass path-based authorization checks in system services like Polkit
> by masquerading the unprivileged interpreter as a trusted system binary,
> essentially circumventing the capable(CAP_SYS_RESOURCE) check normally required
> to change mm->exe_file?

/proc/self/exe is trivially fakeable by using PR_SET_MM_MAP which is
available in user namespaces. CRIU is building on that.
