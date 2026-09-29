Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531A3546F2;
	Tue, 29 Sep 2026 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643808; cv=none; b=JdmQXDmxT8562TwBfvlcq20bCvrS3xu3PaTVaG/b8QQ46GiP8LYbjrnUf9x/XpSFXQ/dDPk2EWfKbVWXV6OK9KdFHJlqPynwxhfksaXxvmR6uLAzUAQKLxGsgUOcIFA6ZW0qGgsnt8qxoctOISoMaRhTY+12DDqCLBG0uvxSM7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643808; c=relaxed/simple;
	bh=LL6dSZeOQ9h74oHNbGa88IbrilPuxUoI1y5iCvk6PhI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FafnLds1FY/lWsbdz4CdEI35++6uoa2fJwk8X5QMmcNIQpHkDTzamYwHum1GigUbhFu25t2ctVHA1SAq3xrBjr+cq+GHwOhl712gW77oH5WV0mRtV5b0/AuQlsAgo1cToulndwWpMGT8PaiX2xvN/Z213hLmt9lwxs9YjLjpOIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW7bXA0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW7bXA0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024281F000FF;
	Tue, 29 Sep 2026 01:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790643807;
	bh=FKTbuQt+m0S7i69FMtF1KR+T276WXOuDZdW+MynHKy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JW7bXA0V/8Nxuvudlp1tftJow9kcwE1kohZQ1t+haAC7HJC48UDeUlPd98OrL/OKm
	 z0rSwiN8IlnbPvlAv6jKl94mIfFxGHm90nQo2uaJ9BPuf0nUEqJikzqfJo0AY40ZU6
	 YdGjh6xmuVVlkBUV4SQWicRnVa7b5Wh88jlsr3o3gbzO2C1NT30DhhLbf4actyAuRq
	 weRs4GdaxKqIOTqWQJAGeuj/M4+wpuz9CHlixnm9YrZjQ0YNjFMYfkiPgMoFcQbVgP
	 +1rOa6R+MllLqxOSLkswS037tUNklo6rKdKoaaE+2LD/ump3tna5ULP0ZnPIlVSjQW
	 LURvPpjce9cuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260929005411.4105448-2-vineet.gupta@linux.dev>
References: <20260929005411.4105448-1-vineet.gupta@linux.dev>
 <20260929005411.4105448-2-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 01:03:26 +0000
Message-Id: <20260929010327.024281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] cleanup: mixing goto-based error handling and scope-based cleanup
--

commit a6de528fef00ef67da15965a7a8b3944fa92b053
Author: Vineet Gupta <vineet.gupta@linux.dev>
Subject: tracing: fgraph: allocate shadow stacks inline with GFP_NOWAIT

This commit aims to resolve performance regressions with ftrace graph traci=
ng
when there are a large number of tasks. It replaces the pre-allocated batch
approach with inline allocation using GFP_NOWAIT, avoiding repeated sweeps =
of
the task list. Additionally, it transitions the RCU read-side section to use
scoped_guard(rcu) instead of manual rcu_read_lock and rcu_read_unlock calls.

> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 40d373d65f9b9..1c5ccc3f80d53 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
[ ... ]
> @@ -1057,26 +1056,37 @@ static int alloc_retstack_tasklist(unsigned long =
**ret_stack_list)
>  		}
>  	}
> =20
> -	rcu_read_lock();
> -	for_each_process_thread(g, t) {
> -		if (start =3D=3D end) {
> -			ret =3D -EAGAIN;
> -			goto unlock;
> -		}
> +	scoped_guard (rcu) {

[Severity: Low]
Does this mix goto-based error handling and scope-based cleanup within the =
same
function?

Looking at alloc_retstack_tasklist(), the function retains the legacy goto =
free
path in the initial pre-allocation loop (just before this block), while
introducing scoped_guard(rcu) here.

The cleanup subsystem guidelines recommend that for a given routine, we sho=
uld
convert all resources that need a goto cleanup to scope-based cleanup, or
convert none of them. Mixing these paradigms creates confusing ownership
semantics and is highly prone to double-free or resource leak regressions u=
pon
future modifications.

Could we either convert the ret_stack_list array cleanup to use scope-based
helpers, or stick to the manual rcu_read_lock() and rcu_read_unlock() here =
to
keep the error handling style consistent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929005411.4105=
448-2-vineet.gupta@linux.dev?part=3D1
