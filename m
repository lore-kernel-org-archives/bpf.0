Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792928316;
	b=CH6r+qP02wB3GWONXvyzvVwWHfbwHxzadH/8xV4nzkr2J9Q8GAnVUF0fgGW6d4SWIjPz
	 vobOeFWWiXgixpjbHMct2u3TM6C2SOvAWjB7a73A62TJvaMmVsa8uDqnkX7llGd2pp2H1
	 9OpppkMJb2+Gp3mD16MJ4bKRl0FGB3STNVg/gE8GIRwkXKlY/J7vkSbGam8ewaOfG6x3J
	 L1R2S6diWm4zVnHkFrhayshfzq4u5VNuu2DC+DkuMPVV2mGSyfNeIXopSFTkKgey7UGal
	 C0UDG3oWCH4IxlJHh9enOzMv6BW3fnEvgMQUJEuqORfV1uywZ5/ragjTzl+lJ5HWAOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792928316;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5gffO8dUYNaYaBcr6gccrSu8nehMwJhPRtf8K+sOayk=;
	b=4V3zGdYywYfpbw2fqCRZf8N0F1Xc/FjcCFVHzrOera0LiWR5sAPvqwxwh9RJxL/9rIDu
	 idVRUpgWU2BWf5JXHmo49PpRlTok2nm8thJdGNOLoZmu7fF/iVR1wNSLRa9jodqLfFEvH
	 6EaiuWYD49VR6NURgJlfQnP6n2n2FzRVEi9tbdKrgZoVErelMC50ubpnleNM8BNdJz0O3
	 b49USsGCB51gMGLg84nl3nFgxmv9e7foPNyqABQsDGkBY3VcbCWUiH8ZEfCAKbFfp7eU0
	 MCWj9KZeLIjiiQTAQpqsEiQ5ugw0/Rd32oSoZt4iN0EH0qaSvrDr+zhVOOIR5IGdBnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fopzLHoh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45B8606A31A
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fopzLHoh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596641F01825;
	Sun, 25 Oct 2026 11:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792928315;
	bh=5gffO8dUYNaYaBcr6gccrSu8nehMwJhPRtf8K+sOayk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fopzLHoheOQ1SHB0CYsGsSnf3DSLDTu2BQWj9btooybOYr2MWk322hFbxMolzAcvx
	 4vn2PptmwsMnQn5zN9EtZANk5BD9ip/vhQLDhB8Is6AjHX/J3z0Oald6y5E3Q/IMLg
	 jNNkOn6KDtYnbV7ZDpYuR24PWey5ocVTyfz+j10rZpgQsex4Tt2z+s5pqrDREM+LVS
	 Ntf0/cKiGuB3DKnBkc1bWIyQ4v5TNvFuKje/GrjW3Gnz8V79wWMoVbIhE2blnTIkHn
	 n1CDFM74rkx59J9h3f8VwyNLkzmPBUNDoj2W8p7uj+tg1zepEHVXrgZdMP21d6ht7i
	 DxhIENmONggqg==
Message-ID: <sashiko-outbox-184195@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 1/2] bpf: Keep recursion-checked trampoline
 programs non-preemptible on !PREEMPT_RT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mike Bazov" <mikeba@sentinelone.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261025-b4-bpf-trampoline-preempt-v1-1-198dcdc0c6ac@sentinelone.com>
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
 <20261025-b4-bpf-trampoline-preempt-v1-1-198dcdc0c6ac@sentinelone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 11:38:34 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment style violation in __bpf_prog_enter_recur()
--

commit 264a83620cb7c053d29054a8d674730e0e75ac83
Author: Mike Bazov <mikeba@sentinelone.com>

bpf: Keep recursion-checked trampoline programs non-preemptible on !PREEMPT=
_RT

This commit disables preemption in __bpf_prog_enter_recur() and
__bpf_prog_exit_recur() when CONFIG_PREEMPT_RT is disabled so that
per-CPU recursion tracking and per-CPU private stacks are not shared
across preempted tasks on the same CPU.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index bf4cb3dd444d6..632c104112b2e 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -1339,7 +1339,15 @@ static __always_inline u64 notrace bpf_prog_start_=
time(void)
>  static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct =
bpf_tramp_run_ctx *run_ctx)
>  	__acquires(RCU)
>  {
> -	rcu_read_lock_dont_migrate();
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		rcu_read_lock_dont_migrate();
> +	} else {
> +		/* prog->active and the private stack are per-CPU: don't let
> +		 * another task run on this CPU while we hold them.
> +		 */

[Severity: Low]
This isn't a bug, but in __bpf_prog_enter_recur() in
kernel/bpf/trampoline.c, could this multi-line comment place the opening
/* on its own line to follow the BPF subsystem comment style?

		/*
		 * prog->active and the private stack are per-CPU: don't let
		 * another task run on this CPU while we hold them.
		 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025-b4-bpf-tra=
mpoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com?part=3D1
