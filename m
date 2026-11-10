Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315562;
	b=lLuQjvSVL1NxSjxObuS1WVzSMdm/6rdk2whSJ1WeBFt99zfspzdHIgxS2SsFybXhI08s
	 e7Yy7X7qS9cXpiJLXNibYbTogEBygspujXIMT6iQW7zV5bJIT7xyf80AYHzosL4l6e56k
	 5d6ShQUjOa/aCcCbD8dyQULAAym64gP7BAo175MfNokvFvMp5jtGw988wYHB70RkMHGEj
	 ySzcyZAa8hcCi0Gfh4Q+7nuOWsZNQ17X69ud4vWh0G9miNC8UsPt2E9XxDZOuAEQccz/Y
	 MvyItyOBUSNvnZgXABB0XoxhsnZFYH5Jcjbxc3Sta9XmdUsAkHakW2NTDGw2+xtvLQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315562;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SdPGvMQkLBdL+5h8W1zif0+nxivxkxEgV80Gq0TGRzw=;
	b=nM+ELkL+lt4BoP5elwJoKX4kUvEKNhV5qmHyUVxSu11NiF6lhfktam1DO7LqydCEzpuM
	 S+Z698uOsQrJvtNvTkzsNrbUNRUQt+wcNkW8PJfbLQ5IHUa5k+k9E3zMF9HNxwdCUjhNl
	 LOrmSMwnJDZ7tZew+4oIMnd7AlEptBMyIpdZ2MUdP1vb4PUIQQpWi9YcYvkx4qmV4sfqb
	 PngutKFayEDvzPvYMjo3ONrGjSuS/A8B7s3fU18FEM+exIBm2VE1H0ik2qqoYXhtCF05e
	 D/eRjEIATWgjooc6IK37alJAAL2Avf1skawhcH5iBeWkBWJhk0DugRJ0x7d9b0khn8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjmckKbv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1DA606D5CC;
	Tue, 10 Nov 2026 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjmckKbv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627491F0089F;
	Tue, 10 Nov 2026 12:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315561;
	bh=SdPGvMQkLBdL+5h8W1zif0+nxivxkxEgV80Gq0TGRzw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mjmckKbvLG1N3XZ3Ot11MNwSiVERdxtjqq4KIKRGHx6wvEXnzt4NpE6/5jxuAOS+o
	 CThDq7T+G6E7xxDIJLb9OwjC6DSEdyHbC9aYy6gXpNUBJNkGZb0lXFV4lCs+z/N691
	 VAWdo3h32DtKfAzwKbtnaR4PwtnJ1Nc68wtqCBR88N5hGsl8pEC8YMlQDfZEi4VkzS
	 dq4U8MQGsqxdGG9jZIZftSJGzDpfDSC4knNJsNPrTVpHoUjpyeHCm7u+1I5nGt5MkB
	 +WSzKeUBoNkd5MrowNUCsu7MV3ZLxmJbLmkO4YMowaDzuYXXUTCrXldfWlaLo6q9jN
	 sekjRneg0Okvw==
Message-ID: <sashiko-outbox-207063@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] tools/sched_ext: scx_pair: Don't abort when the
 dispatching cgroup goes away
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20261110125001.4167503-4-cui.tao@linux.dev>
References: <20261110125001.4167503-1-cui.tao@linux.dev>
 <20261110125001.4167503-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 12:59:20 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] sched_ext: scx_pair: leaked active_mask bit in try_dispatch()
  stalls pair
--

commit 0bc135e247824dc3899acf0f6cf608c43ee6328b
Author: Tao Cui <cuitao@kylinos.cn>

tools/sched_ext: scx_pair: Don't abort when the dispatching cgroup goes away

This commit changes try_dispatch() in scx_pair to mark the CPU pair as
draining and return instead of calling scx_bpf_error() when looking up the
current cgroup ID in cgrp_q_idx_hash fails.

> diff --git a/tools/sched_ext/scx_pair.bpf.c b/tools/sched_ext/scx_pair.bp=
f.c
> index 0d61b7b812db6..d38d3a078adee 100644
> --- a/tools/sched_ext/scx_pair.bpf.c
> +++ b/tools/sched_ext/scx_pair.bpf.c
> @@ -478,8 +478,16 @@ static int try_dispatch(s32 cpu)
>  	/* again, it'd be better to do all these with the lock held, oh well */
>  	vptr =3D bpf_map_lookup_elem(&cgrp_q_idx_hash, &cgid);
>  	if (!vptr) {
> -		scx_bpf_error("failed to lookup q_idx for cgroup[%llu]", cgid);
> -		return -ENOENT;
> +		/*
> +		 * @cgid can disappear from under us: pair_cgroup_exit()
> +		 * drops the hash entry when the cgroup is going away.
> +		 * Mark the pair as drained and let the next dispatch
> +		 * expire it instead of taking the whole scheduler down.
> +		 */
> +		bpf_spin_lock(&pairc->lock);
> +		pairc->draining =3D true;
> +		bpf_spin_unlock(&pairc->lock);
> +		goto out_maybe_kick;
>  	}

[Severity: Medium]
Does this path need to clear in_pair_mask from pairc->active_mask and return
-EAGAIN, like the empty-cgroup path just below?

Before dropping pairc->lock to look up cgid in cgrp_q_idx_hash,
try_dispatch() sets pairc->active_mask |=3D in_pair_mask.  Jumping to
out_maybe_kick returns 0 without dispatching a task, so pair_dispatch() sto=
ps
retrying and the current CPU goes idle with its bit still set in
pairc->active_mask.  When the sibling CPU enters try_dispatch() and sees
pairc->draining set, it checks pairc->active_mask, assumes this idle CPU is
still running a task from the old cgroup, and bails out without switching to
the next cgroup in top_q, stalling the pair.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110125001.4167=
503-1-cui.tao@linux.dev?part=3D3
