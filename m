Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A84A3D47C2;
	Thu, 20 Aug 2026 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213508; cv=none; b=HYhabD6/OokGj5GA5KOVP4qiXYKqGy2Z3281sCA1i/XdXkVian0waD9C8M8hZ7ftWQ7gdNAAwceyae5jUzYc3WjbMYMJmZvhXJW+WXAzar7ot8u/Z5BnrkJdX6GntHV3MqPHjYJUVNkVRnfGRq2bgXSuCC7mRLl8N6ZZ+avYp2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213508; c=relaxed/simple;
	bh=WJLtEOGwnrvi6Hw7XyWAsbWQkfjSr6eQJVdLsvGHgKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBBZThClA4Q14RFzw1VSdWkNvybSfpamqmB/G86tXhpO49sAJwOtAguzIeRZoKERA51OAzF/phvC8/d7osR8nUpHWB4OtHcLf7/KgDkP7oqGtSpfEV1FkCN3iHjwaVVC/aLdCPjyhyhKrARNUoWg+Sq+el4IZjl25J0NAcg6sEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2qgZB7Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2qgZB7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A461F000E9;
	Thu, 20 Aug 2026 08:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787213506;
	bh=9x3SLigUrIihsNZGqSKWFgdPEUQCnSPmfI5nV3en+T4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l2qgZB7ZMzhENHsglcEY4hOoLDSklMF9CWsvLqSSOycKIyV+fF9INnOGRIm9Wn7dH
	 l0coRo4TqLbpyIpKVKkh1JXVuKSlpsXUhqH7PoKCzFzZ8Fan8DRTs8vMWtEYw6diyc
	 Q4xp24q0wb8lUIq5SH+CqTWzXYDXU36uPqsHVA0e3eV7z4aIZ6zulv9FeEcetkXwky
	 FbcAtAGmyA7C8qAVVf02Dskq15Irekje7eyYd8keB3SnC7y+GKQn9BQLsmzXMzu0z6
	 cDXNZFUvko29Ie367rljGwyZemxfFBYKCRTmuj+0vf9VsMXKvXanmXDP2yMdwFdkqT
	 nELti+LSpUnZg==
Date: Wed, 19 Aug 2026 22:11:45 -1000
From: Tejun Heo <tj@kernel.org>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com,
	bpf@vger.kernel.org, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, emil@etsalapatis.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next] bpf: sched_ext: Mark ops argument container
 pointer fields as trusted
Message-ID: <aoa2wQABalEFo5FT@slm.duckdns.org>
References: <95d7ccc17681aa3a4a2eeb1b073f00f7@kernel.org>
 <758be5cbbea1b61eeaad2454d28f13a1acb1f3d0d50893b7707d9afdcea131e7@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <758be5cbbea1b61eeaad2454d28f13a1acb1f3d0d50893b7707d9afdcea131e7@mail.kernel.org>

On Thu, Aug 20, 2026 at 06:16:48AM +0000, bot+bpf-ci@kernel.org wrote:
> >     bpf: sched_ext: Mark ops argument container pointer fields as trusted
> >
> >     Walking an unannotated pointer field of a trusted struct yields a bare
> >     PTR_TO_BTF_ID in non-sleepable programs, which kfuncs and helpers accept,
> >     but PTR_UNTRUSTED in sleepable programs, which they reject. This gets in the
> >     way of making ops.init_task() sleepable, which schedulers want for
> >     allocations. For example, passing args->cgroup into bpf_cgrp_storage_get()
> >     then fails verification and the only recourse is round-tripping through the
> >     cgroup ID with bpf_cgroup_from_id().
> >
> >     The pointer fields in the sched_ext ops argument containers are all pinned
> >     by the callers for the duration of the ops calls and are never NULL. Add
> >     them to the verifier's trusted-fields whitelist so that they are PTR_TRUSTED
> >     in both sleepable and non-sleepable programs.
> >
> >     Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> This looks like a bug fix for verification failures in sleepable programs.
> Should this include:
> 
>   Fixes: 8195136669661 ("sched_ext: Add cgroup support")

Nothing has been using it, so not strictly necessary but yeah I don't see
why not.

Thanks.

-- 
tejun
