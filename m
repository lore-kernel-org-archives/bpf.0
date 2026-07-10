Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71B9182D6
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 00:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783641904; cv=none; b=laH6ot0byc69BrxBlshFQKmPULpFpnXy+o/BfUCkAdSGAvVn3ywkZvMqxzs2E1H0TEGfhG5XPcXeddWj4fKT1M7g2IEYOVrNOTBxdVSh2zla5aD6GHmJjo6anacYgaVjQwdYktnL3LNDzFWFEUqVaggOKZ4ypGE4ojn81rLeJ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783641904; c=relaxed/simple;
	bh=awZDdYd8EQCu3Gtf8N0vaTqN9pkdLRlukSDGV1hW8og=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q45lV0D+GHU/1Abqs4vMdM/4vxBjDE8yBfrGxqqPUXwSfRhXoM6AS80Biruo0P/JiEerZ91w7bYJ3ua4DuSOR1gL00EnQwyZxjSfbalFjL64qZtDr29G5QDJmNNUd8w3nAFBtg0RNs6SetHNb2J77K7aG6O/IhBW+BLVGp01zQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdWTUA5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdWTUA5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7B01F000E9;
	Fri, 10 Jul 2026 00:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783641902;
	bh=zNIE9m355WmNP3+WQVhWkCE02XbO0Qcjzrz+kD/6fPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OdWTUA5bMfsm8nIY30rYaaH0tTWLuQQFU1TuUsttCr7oH/YQaa4ThBGiUpWIlIcef
	 lYKOKNMZpishsFWRaJZcelgobmc9aXnniSSO6hq13CNEX32rwVuBCWo84/ix+EJ1MD
	 hxfEUVlb5UC2QCQmaH6mJYeB3dgP+Ff8MiyAzo2kas2+iRPcnaadDzZNbGf1iARBrM
	 UdkzxRxyXMr4LdJ3sjKpnC3z34KWMCzA4qO/LS1z1drLiClWhdjER700i/7msVw0/R
	 +3uclOzgx/HtiUHrya7+UBvHUATn99NdhRGEefIfpzQDt4uYAdqymPP+QM+I6E3rbm
	 ArhrPxM2FWNHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Avoid soft lockup in
 __htab_map_lookup_and_delete_batch()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Sm9zZSBGZXJuYW5kZXogKEFudGhyb3BpYyk=?= <jose.fernandez@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709-b4-htab-batch-resched-v1-1-ad7a6b3b4513@linux.dev>
References: <20260709-b4-htab-batch-resched-v1-1-ad7a6b3b4513@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 00:05:01 +0000
Message-Id: <20260710000502.5D7B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments do not follow BPF subsystem guidelines.
--

--- Patch [1]: [PATCH bpf] bpf: Avoid soft lockup in __htab_map_lookup_and_=
delete_batch() ---
commit a1114e030dd1f8d190db49effffca17e5da09d3f
Author: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

bpf: Avoid soft lockup in __htab_map_lookup_and_delete_batch()

This commit limits the number of consecutive empty buckets visited in
__htab_map_lookup_and_delete_batch() before yielding. It drops locks and
calls cond_resched() to prevent soft lockup watchdogs from firing on
large sparse maps.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1769,6 +1769,11 @@ static int htab_lru_percpu_map_lookup_and_delete_e=
lem(struct bpf_map *map,
>  						 flags);
>  }
> =20
> +/* Max consecutive empty buckets to walk in one RCU +
> + * instrumentation-disabled section before rescheduling.
> + */
> +#define HTAB_BATCH_EMPTY_RESCHED 64

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem comment style? The guidelines specify that the opening /* should
be on its own line, rather than having text on the same line.

[ ... ]

> @@ -1969,11 +1975,19 @@ __htab_map_lookup_and_delete_batch(struct bpf_map=
 *map,
> =20
>  next_batch:
> -	/* If we are not copying data, we can go to next bucket and avoid
> -	 * unlocking the rcu.
> +	/* If we are not copying data, we can go to next bucket and avoid
> +	 * unlocking the rcu. Bound the walk though: after
> +	 * HTAB_BATCH_EMPTY_RESCHED consecutive empty buckets, fully exit
> +	 * the critical section (no locks are held here) and reschedule.
>  	 */

[Severity: Low]
Similarly, could this multi-line comment be updated to place the opening /*
on its own line to match the modern BPF comment style?

>  	if (!bucket_cnt && (batch + 1 < htab->n_buckets)) {
>  		batch++;
> -		goto again_nocopy;
> +		if (++empty_cnt < HTAB_BATCH_EMPTY_RESCHED)
> +			goto again_nocopy;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-b4-htab-ba=
tch-resched-v1-1-ad7a6b3b4513@linux.dev?part=3D1
