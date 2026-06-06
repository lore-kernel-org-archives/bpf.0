Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE0F3AD50F
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780750596; cv=none; b=Q4RGJW9yHLe31fHYK8FHSc5ybiYO6xt1q8IeJ2APhdKlOfcygpyh+VuNn3jj/uV7KrW+C+00mvqWoUmlm/Z31owfjGJ6KT9hK4xg8PPICg43U/oHR0ienx4l3ulivhjwdNt5VyF1yktVCdyG6Y2QUUr5lVSwotiLk26RkQj0GZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780750596; c=relaxed/simple;
	bh=jCx8NuK0n5z0GSPVene36nZpDB9Hdrr47w4QEnNhr70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OliONxH7GVNeYKkLtY2hZCdOTIY3RFcDW6TWPexv1kVDQemCWjspQUGPeFMFH5sKerWwdVtie3ctfPjB36sFV+nA1bU91/WUNhfuaCOVmg+WiU54hG2N7Z3YFxyRgWqH3pdjUW1fQnZIniyCAAGx5vvQp7PtWQteGWR9k6uOrQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLEPao6P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLEPao6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE791F00893;
	Sat,  6 Jun 2026 12:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780750595;
	bh=QoDapoxO4kHCZKUrsmOjMMXx03oVkPQ2pmbhEmGGFRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jLEPao6PzzyAz/e5GA9ihJGQpfRkSLBkZWAhesohzbbirdPQfFsAEwHJYrZzclx2Q
	 3M1VsLV/lIyeEzJrtYxQ4287itsW6z0Ti9RIS9zHZSmYHDzGWtvLJMLUwCEJ1LzNel
	 9FC9G1yw0KjOkS0G0lTaLbioirn+/hpR3r8z8//5vhPzlaMdPyZiQHJ+2uoOh+gaEj
	 RuFmhO2HbOKYvRlbOXd0VB0a6UeWg7OOYTCvLhFTNQWtWlvepnG7ciz1JA0pNE8WOA
	 AVW/epf3pV3zQEffyzOVxcqCvXukgQb1bnHW2bP6IKU0ySbAZChxUYdGqXgrREAYsn
	 jWqTryoQ0om+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv8 bpf-next 04/29] bpf: Use mutex lock pool for bpf
 trampolines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260606123955.345967-5-jolsa@kernel.org>
References: <20260606123955.345967-5-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:56:34 +0000
Message-Id: <20260606125635.3AE791F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Spurious `-EAGAIN` failures in unrelated ftrace, kprobe, and livep=
atch registrations due to hash collisions in the shared trampoline lock poo=
l.
--

commit 618668a1ad7a4e1838f3d78fb1f6af04ade24704
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Use mutex lock pool for bpf trampolines

This commit replaces the per-trampoline mutex with a 32-bucket mutex lock p=
ool
to avoid lockdep warnings when locking all trampolines simultaneously during
tracing_multi link attachments.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index a4298a25d4bae..c0b4732627bef 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -99,12 +128,12 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_o=
ps *ops, unsigned long ip,
>  	 *   cleanup_direct_functions_after_ipmodify
>  	 *
>  	 * In both cases, direct_mutex is already locked. Use
> -	 * mutex_trylock(&tr->mutex) to avoid deadlock in race condition
> -	 * (something else is making changes to this same trampoline).
> +	 * mutex_trylock(select_trampoline_lock(tr)) to avoid deadlock in race =
condition
> +	 * (something else holds the same pool lock).
>  	 */
> -	if (!mutex_trylock(&tr->mutex)) {
> -		/* sleep 1 ms to make sure whatever holding tr->mutex makes
> -		 * some progress.
> +	if (!mutex_trylock(select_trampoline_lock(tr))) {

[Severity: High]
Does this change introduce spurious -EAGAIN failures for unrelated tracing
registrations due to hash collisions?

With the move to a 32-bucket lock pool, if one thread holds a pool lock dur=
ing
a BPF update, and another thread concurrently registers an ftrace op (like
attaching a kprobe or livepatch) on an unrelated function whose trampoline
hashes to the same bucket, the mutex_trylock() will fail and return -EAGAIN.

Since callers like register_kprobe() do not loop on -EAGAIN, could this cau=
se
unrelated observability tools to fail their attachments unexpectedly?

> +		/* sleep 1 ms to make sure whatever holding select_trampoline_lock(tr)
> +		 * makes some progress.
>  		 */
>  		msleep(1);
>  		return -EAGAIN;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606123955.3459=
67-5-jolsa@kernel.org?part=3D1
