Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877446AA86;
	Tue, 21 Jul 2026 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648262; cv=none; b=pucsKjHLWvRbdoGRJdLhyYpxYhVUKEzRH9OfdMKwVqSHnhQtYQHjHhVMda01aDSM3X1rr4sT4N+6NmbnlVvyc8q8zSu7TpQKB+M1z+ivB6433RQwMCWibZHMCKJ1tyeB7pniRMYZ9Fk1cL16QjGeyAdOlbpU8/H+/dV7YRrflr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648262; c=relaxed/simple;
	bh=6eWBfjwnpseKALvRNrOHQSjKGhnELangV7UJTr7ArNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDGEGVM6ZFDxRWTym7FV9iqu4jYr68BDeu+CRxKCFcsAu7LEwDm5YvrIGsUleUkT/57KztC93bLPHN139Hng8s3P72aVauX84EvQgYa57Y0pL+vk/kalaSpDMXCtX393VANhQNDjoRZjFlLX/+cz4s0FT7bXW/AMmLordiSWg8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9bdSDCd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9bdSDCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870681F00A3A;
	Tue, 21 Jul 2026 15:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784648261;
	bh=BUyW6P4rgeUeKw1YyA+UKUY5wsNIHnXkCbTU8P+KC4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L9bdSDCdvnZ6lIdfqFqFclVQaogAxYfIgxVBy4sDXhdxXYXEVb7n66OFfHB9hjaSQ
	 YRjQy+UdWU2lkPjjUBzPRBqu+/oGcqQCtsTXr2WhQFhspSSjpwwpbsrZxZ0e+55bU9
	 rdcFsmN69FpqLp7NGRlYrvjbafQKXBR+xGNGbyKC/Naph/kppFupKva6hkJ193BTLy
	 cmqbxbjZKRtQ/KcfB/NQadO+MolPacunf3w6Dg0/N6b7zofvUTDlrR2JBbbJlVO1R7
	 VpYkURB5+8xqf89H3Ptv2nRyqCAVGUpCmRhdLXB+PCqt26KTTPt8lZdcZvMuhP5USO
	 h8lRRDRDpVipw==
Date: Tue, 21 Jul 2026 17:37:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v2 14/21] binfmt_misc: document the transparent identity
 contract
Message-ID: <20260721-administration-chorprobe-anmeldung-07c360b9d3f2@brauner>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-14-e57866e4ae0f@kernel.org>
 <20260721142621.5EE4B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721142621.5EE4B1F000E9@smtp.kernel.org>

On Tue, Jul 21, 2026 at 02:26:20PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Documentation incorrectly claims PR_SET_MM_MAP requires privileges to retarget auxv and memory markers.
> --
> 
> --- Patch [14]: [PATCH v2 14/21] binfmt_misc: document the transparent identity contract ---
> commit ca9e0f57f6063d4c7be0eda47389dcf9a21a1409
> Author: Christian Brauner <brauner@kernel.org>
> 
> binfmt_misc: document the transparent identity contract
> 
> This commit documents the transparent interpreter contract for binfmt_misc,
> describing how arguments are preserved, how the binary is passed via
> AT_EXECFD, and the roles of the interpreter and program during loading.
> 
> > diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
> > index 81b78e315fad8..ea1c1c0676c88 100644
> > --- a/Documentation/admin-guide/binfmt-misc.rst
> > +++ b/Documentation/admin-guide/binfmt-misc.rst
> 
> [ ... ]
> 
> > @@ -223,6 +223,36 @@ binfmt_misc instances themselves are looked up. The entry keeps the handler
> > +code/data statistics markers via one ``PR_SET_MM_MAP`` which completes
> > +what attaching debuggers observe. The prctl is privileged - it takes
> > +``CONFIG_CHECKPOINT_RESTORE`` plus ``CAP_CHECKPOINT_RESTORE`` or
> > +``CAP_SYS_ADMIN`` in the caller's user namespace - so a loader running
> > +without these leaves the aux vector and the markers as the kernel set
> > +them. What remains visibly different from a direct
> 
> [Severity: Medium]
> Is this documentation accurate regarding the privilege requirements for
> PR_SET_MM_MAP?
> 
> Looking at prctl_set_mm_map(), the checkpoint_restore_ns_capable() check is
> explicitly skipped if the provided prctl_map.exe_fd is -1. 
> 
> Because a transparent interpreter already has /proc/pid/exe correctly labeled
> by the kernel, the loader shouldn't need to change the exe_fd.
> 
> Doesn't this mean a loader can successfully retarget the auxv and memory 
> markers completely unprivileged by simply passing exe_fd = -1?

This is correct. Not sure how this escaped me and my automated review.
Thanks. I'll fold that fix in.
