Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8BE34CFCF
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478028; cv=none; b=mteO07VH5Ont5FDI+RY+NBiFGWqxsjL8nYT9+olEUPFhmuXi4aOmp1WdVmdCGnXt0a7ZcHPBQX/vaKheDcTgkZS9YE9IDFSsXguiwpEump34pLWu/QtC9BPbPPKQFKkit+rc2dKOZNX41z7mAKk0zdA5SK6lf3mGLuZWoSypmzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478028; c=relaxed/simple;
	bh=eVx1TolgAGWFBedQA7EDI6P6A+a2g3ZNcyQ9mIxFl0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX7Kcwhhjk+awcAej3HQwQaumsDIkzv9zYvBRr02Rp9rwCXOsVQuHrg/wu4DGCN9wABLM7AComCXTejm8HkO4X25Eb31jTMU+JPLZnOey4AQcwmJsaS/OILOiCiA29hIm0EU6UGK9jQkjGW3BdnJzD3k1LEPzO4D3lC8vumOJs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KB3R/TTD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB3R/TTD"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so6525035e9.0
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 08:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777478024; x=1778082824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x3d45FYs/u15o3gONdNkXWFSDj83L1ojAg9+bYGvTgM=;
        b=KB3R/TTDV4D4fTucT/jeVAhiyekQAZxvsmq5AJenm784Z7JPjX8Ngnr4fHNE1KoSwX
         vfdWfgjxQEROjrIjc/gumGRvSDJ/8y8I89N3QNJRw0FEDnPw4st8Auwr+zQBDPPppybi
         E2Mh+uLcPzC8fh/6VRfKZxYTPWvNB9Y6kVABMkcwDxF9tV2tsPf8bF0YOzBSinCtwJzM
         iCEGl2RVbFyBCMnqhBXebXMbTgUnSYMvGF1+KwXJJHOq+JED+PY5ML1VDgO8dzlGmDiL
         3el9kpBnHtN8nbeoroksIo30k224/tNKWWbGk3HHvt3/hA/MRVAtJqm46n307lmLEtAE
         NS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777478024; x=1778082824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3d45FYs/u15o3gONdNkXWFSDj83L1ojAg9+bYGvTgM=;
        b=Qlwd9NktBPwfN8nWZoox463lU5opFNg9DC7nwXy1GlNkx8FjGeqM4rdi5GWCmOVRBD
         GniUeCBlUihKzm0NtOTLb/65qkBFOHkcVAlTKpOjHZiNwzBxG7970BOJkxXRRA8KwJV9
         jUSqZrNaEz/T7l/MhBH9ivmIlElcxjEoxs9sj/UWWzTNNZYWmsEkBrqj+QlFCAHMhfSX
         0TaV/e33vvIh453K+ghcArxQ3OWZB4C95aGhgmcF2xtMJ8zTQ0DAZPhQp6L4A8DNNgoE
         VZftLOkBdqLgdNafxSSGjQGcQeSD4xLgNn+3DPGNfOvtXPJw4l5kCbcG/y+JvBSOMEQT
         MsEw==
X-Forwarded-Encrypted: i=1; AFNElJ8Y1+9qKPWhnsp5+lB8W8XO4v0EuXG2/2sgzrHGY7MI4R9+DCeXiojCZWXQJ/Qep8lt+s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuFzqCtjWjv5n2LchgkHTD3fnCl6F8nI1peRCqWrbtjE5glQRr
	lWOU8EmUfSnzBePazAAT0T0E0trQuHZ5xPVr2U9WDdQUcWRWRsQXIfc/
X-Gm-Gg: AeBDieva9l5MXY8UuhOAJCfG20Q3cpRBRKITuL7x3VsbMFq1QK217ml0kVGPT8HAlcW
	zqT9W0Cjq66WuNj6g/fvyp9sETL7AmJk+ji0V9nwOVHfIlcpYgXvkV+MQou9TdBmKhBg40AI9oQ
	i8R5907H1tF0Q9DeiRkNrCJki9nv/rQdFx0ukjloeu5d+3iTSEpbGDuRLS+MO8IhhHmpReTiXq9
	VRfQ8nW0aci2CZ64K+LYHm/3/EAtKoAOzB85KxGDLL97sQS+uJCrblZzLJhmcDTvt4F3aGBsSgW
	tIBebCsuYZUaOgn6fDRfMW1/lZH1N92XPfjnKfT1KFlSDcSn5+dp3fcJ6vU+4z1De11ckSDyVVH
	Ml3QetUQU7Q+elLJ5AvUxw3S+qcspdoyhP97uyKIw1jB8lQBjm7vqqfK7/K33ptKjpNo44hvDyW
	6OB/dWWoAH1xflALgbQcs7ar3yXag13GItQ8KAibpQo36dq2eAVYeYcSqyAyMeBILIxNCumUTnq
	WvWRoLrNo5mNyw0JHD8i75xYim8BUCppyZAH7WcfHkel6QbevLL1XvQ/Qsaxel9vZjag2f+Qkrj
	5/4IUtsOObJkf0yJ3xnqiuF4D6dhv+vAWAgRY9ueKCKk7hU96bMkZw==
X-Received: by 2002:a05:600c:a10d:b0:489:1abb:5559 with SMTP id 5b1f17b1804b1-48a7bf9956fmr42135605e9.5.1777478022928;
        Wed, 29 Apr 2026 08:53:42 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00fb2d91b6f941d667.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:fb2d:91b6:f941:d667])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a824f9f0dsm383695e9.15.2026.04.29.08.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:53:42 -0700 (PDT)
Date: Wed, 29 Apr 2026 17:53:40 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: sashiko@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Print breakdown of insns processed by
 subprogs
Message-ID: <afIphKy2138OC5GR@mail.gmail.com>
References: <5c3514dbc879f22ba3f9eff8a2c730e13bd0572c.1777388107.git.paul.chaignon@gmail.com>
 <20260428230844.EFA64C2BCAF@smtp.kernel.org>
 <DI56ZVH6HKDK.1L8J5HPA37J09@gmail.com>
 <DI578ZDDKR6K.QH52KXPV1CLN@gmail.com>
 <afIPMllq5VI-bJLY@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afIPMllq5VI-bJLY@mail.gmail.com>

On Wed, Apr 29, 2026 at 04:01:25PM +0200, Paul Chaignon wrote:
> On Wed, Apr 29, 2026 at 02:07:33AM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Wed Apr 29, 2026 at 1:55 AM CEST, Kumar Kartikeya Dwivedi wrote:
> > > On Wed Apr 29, 2026 at 1:08 AM CEST, sashiko-bot wrote:
> > >> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > >> - [High] Out-of-bounds read in `bpf_subprog_is_global()` when printing verification stats for programs with hidden subprograms.
> > >> --
> > >>
> > >> commit 08128f883e58301e0f97b1d4a94656be63b8f790
> > >> Author: Paul Chaignon <paul.chaignon@gmail.com>
> > >>
> > >> bpf: Print breakdown of insns processed by subprogs
> > >>
> > >> This patch tracks the number of instructions processed by each global
> > >> function (subprog) during BPF verification. It then reports this
> > >> breakdown in the verifier logs under BPF_LOG_STATS.
> > >>
> > >>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > >>> index 03f9e16c2abe..b48389b48eb6 100644
> > >>> --- a/kernel/bpf/verifier.c
> > >>> +++ b/kernel/bpf/verifier.c
> > >>
> > >> [ ... ]
> > >>
> > >>> @@ -18288,6 +18295,13 @@ static void print_verification_stats(struct bpf_verifier_env *env)
> > >>>  				verbose(env, "+");
> > >>>  		}
> > >>>  		verbose(env, "\n");
> > >>> +		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
> > >>> +		for (i = 1; i < env->subprog_cnt; i++) {
> > >>> +			if (!bpf_subprog_is_global(env, i))
> > >>
> > >> Could this introduce a regression due to an out-of-bounds read on the
> > >> func_info_aux array if there are hidden subprograms?
> > >>
> > >> At load time, if BTF is present, env->prog->aux->func_info_aux is allocated
> > >> with exactly func_info_cnt elements, and env->subprog_cnt initially matches
> > >> func_info_cnt.
> > >>
> > >> During verification, if a feature like bpf_throw is used without an explicit
> > >> callback, add_hidden_subprog() is called which increments env->subprog_cnt
> > >> but does not resize the func_info_aux array.
> > >>
> > >> Since this loop iterates up to the updated env->subprog_cnt, when i reaches
> > >> the index of a hidden subprogram, bpf_subprog_is_global() will access
> > >> aux[i].linkage where i >= func_info_cnt:
> > >>
> > >> kernel/bpf/verifier.c:bpf_subprog_is_global() {
> > >> 	struct bpf_func_info_aux *aux = env->prog->aux->func_info_aux;
> > >>
> > >> 	return aux && aux[subprog].linkage == BTF_FUNC_GLOBAL;
> > >> }
> > >>
> > >> Is it possible to skip hidden subprograms here, or limit the check to
> > >> func_info_cnt?
> > >
> > > Don't see it happening, since hidden subprogs never get verified, so we won't
> > > invoke bpf_subprog_is_global() with such a subprog index.
> > 
> > Ah, no, stupid me. We get here after fixing up and adding the hidden subprog. So
> > we can still do OOB since subprog_cnt includes the hidden_subprog_cnt. How about
> > the following as a fix? I checked over other places where we iterate over all of
> > the subprogs and those look fine, so instead of changing bpf_subprog_is_global()
> > we can adjust this function to only consider real subprogs. Didn't compile test.
> 
> That's a nice find! I also doubted it initially as we have that pattern
> everywhere.
> 
> It looks like this would be a fix for commit 335d1c5b5452 ("bpf:
> Implement support for adding hidden subprogs") (or technically, the next
> commit as 335d1c5b5452 didn't have any user). So maybe I can resend as a
> first patch (with you as a co-author) and the following diff (took the
> opportunity to simplify the logic on the assumption that we always have
> the main "subprog").

Just saw that subprog_info is statically allocated (contrary to
func_info_aux) so we wouldn't get an OOB on the existing code, just
some garbage "+0" on the stack depths.

> 
> Not sure if it would need to be sent to bpf instead of bpf-next. Maybe
> keep the patchset on bpf-next, but add "Cc: stable@vger.kernel.org"?

[...]

