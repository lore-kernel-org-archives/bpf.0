Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5573A5E97;
	Thu, 23 Jul 2026 05:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785157; cv=none; b=lLaadIT4UX7kB4cG7fOCRLb09Q4Uk7bIKbb4pNgCrkRA67tL3V+iCP6EI1DhiScfWqUUtLzEzTcqLYw6uckTOJaX0uB5kmHX8N0kVATGmL4YUZsotUbXJ+yEQt1uSeVjmXz9HSV/6bFpMYKlwQ7yHhLPg5dHzbwmjY2TsIGi9dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785157; c=relaxed/simple;
	bh=Q0FqA9yN0GrgE2FgUfLGEy7t+0X7rELu2TIL1Fv0E0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sq3NthcwMVqLEcy7wdsvlKLzhYcuCww7qoUiDBQLLmWBelRdZ17b97iDTcjI/D70mBeSgJ8+61NhJ7jxPXnE+7RxxPqlYLkkmBv0d6blU2C5eF/DqLYbkpsr9tzo2GT6AyH7cIbsUCsp92jJEaRTifVtWn+2tNHFhIkgNHTKR6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq/oVMjN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq/oVMjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C241F000E9;
	Thu, 23 Jul 2026 05:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784785156;
	bh=UG4IuQG8s5OGsI4Bd5jYurMqNTknGwhMSic/RGI0A9E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Xq/oVMjNFFjMxst0Q5XnhynLHVDn6XCce+5kwq7vuUrjnKYRP6aSJD4onLWvNMiJC
	 13qRFqMpenSz5Dp1EGLT/0Tm+d/BQQKB2pF6zqmxsdxOG7RMotpP9glTABzGPCluMv
	 dgKwD4zLnQ9rprhWzDxAyq3yeCkbpexLsQEJng89RTEU1cCuqp+FHlkSBJzF/M0J+m
	 I9EWarFkuZDDPHOsviqgZGhJBCJ5DNe+EAbl5G+am251OnM1kBPdJfbV2XprX9lSwx
	 JWfaXl1R5vGOVBk6fOCmEIPjODyyko8HIsg81+Gmi+h2esffgiHg2fjmOhBsjtyx1S
	 WBoRHWyK6p9Gg==
Message-ID: <1c7ce106-c5b0-4689-8c24-b32a0966eb02@kernel.org>
Date: Thu, 23 Jul 2026 14:39:08 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab/for-next v4 5/8] mm/slab: allow kfree_rcu_sheaf() on
 PREEMPT_RT
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, vbabka@kernel.org, hao.li@linux.dev
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-5-964e03c41a4e@kernel.org>
 <20260720125637.129D01F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260720125637.129D01F00A3A@smtp.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wy0ijbG9AhwUrGLCuN11PMQS"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wy0ijbG9AhwUrGLCuN11PMQS
Content-Type: multipart/mixed; boundary="------------Dtl2WEb9uez8Q01hcYj3noLx";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, vbabka@kernel.org, hao.li@linux.dev
Message-ID: <1c7ce106-c5b0-4689-8c24-b32a0966eb02@kernel.org>
Subject: Re: [PATCH slab/for-next v4 5/8] mm/slab: allow kfree_rcu_sheaf() on
 PREEMPT_RT
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-5-964e03c41a4e@kernel.org>
 <20260720125637.129D01F00A3A@smtp.kernel.org>
In-Reply-To: <20260720125637.129D01F00A3A@smtp.kernel.org>

--------------Dtl2WEb9uez8Q01hcYj3noLx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/20/26 9:56 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential is=
sue(s) to consider:
>=20
> New issues:
> - [High] Calling `local_trylock()` inside `kvfree_call_rcu()` on PREEMP=
T_RT violates lockdep wait-type nesting rules and is unsafe in hardirq/NM=
I context.
>=20
> Pre-existing issues:
> - [High] Preexisting bug: Using GFP_NOWAIT in __kfree_rcu_sheaf() can c=
ause lock recursion deadlocks when called under scheduler locks.
> --
>=20
> --- Patch [5]: [PATCH slab/for-next v4 5/8] mm/slab: allow kfree_rcu_sh=
eaf() on PREEMPT_RT ---
> commit 9ccf08cd866ca28e999f59be7998db3bfc32fb7a
> Author: Harry Yoo (Oracle) <harry@kernel.org>
> Subject: mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT
>=20
> This patch allows kfree_rcu_sheaf() to be used on PREEMPT_RT by setting=

> SLAB_FREE_NOLOCK when PREEMPT_RT is enabled. It relaxes the limitation
> in kvfree_call_rcu() and skips the lockdep wait-type override map on
> PREEMPT_RT to avoid suppressing valid warnings.
>=20
> Link: https://lore.kernel.org/linux-mm/6811cc17-8ee4-48c8-8cbf-6bf4d9f9=
8162@kernel.org [1]
> Link: https://lore.kernel.org/linux-mm/40591888-3a87-433e-b3d2-cda1cab5=
43be@kernel.org [2]
>=20
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 8afa6b47b1f2b..deac315d0f23e 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
> [ ... ]
>> @@ -6080,10 +6081,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, v=
oid *obj, unsigned int free_flags)
>>  	struct slab_sheaf *rcu_sheaf;
>>  	bool allow_spin =3D free_flags_allow_spinning(free_flags);
>> =20
>> -	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT)))
>> -		return false;
>> +	VM_WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT) && allow_spin);
>> =20
>> -	lock_map_acquire_try(&kfree_rcu_sheaf_map);
>> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>> +		lock_map_acquire_try(&kfree_rcu_sheaf_map);
>> =20
>>  	if (!local_trylock(&s->cpu_sheaves->lock))
>              ^^^^^^^^^^^^^
> [Severity: High]
> This is a pre-existing issue, but since we are enabling this path for
> PREEMPT_RT, does the use of GFP_NOWAIT later in this function cause
> lock recursion deadlocks?
>=20
> When the fast path fails, __kfree_rcu_sheaf() calls:
>=20
>     empty =3D alloc_empty_sheaf(s, GFP_NOWAIT, alloc_flags);
>=20
> GFP_NOWAIT includes __GFP_KSWAPD_RECLAIM, which invokes wakeup_kswapd()=
=2E
> The wake-up path enters the scheduler via try_to_wake_up() and attempts=
 to
> acquire scheduler locks like pi_lock and the runqueue lock.

This indeed looks like a real issue as kfree_rcu() can be called under
scheduler locks, but not sure how it's been undiscovered for this long?

> If kvfree_call_rcu() was called while the CPU already holds these sched=
uler
> locks, will this wake-up attempt cause a lock recursion self-deadlock?
>=20

--=20
Cheers,
Harry / Hyeonggon

--------------Dtl2WEb9uez8Q01hcYj3noLx--

--------------wy0ijbG9AhwUrGLCuN11PMQS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCamGo/AAKCRCGXBN6rc5S
1o0lAQCK2eCjHlRuDu0zE5pEWK7ZgEWFNUs05X72Eo/GpakHyAEA/l/TGwpb8ylP
eEjf77xAvj55R+dksqmH80fDAEaIEAg=
=kdl3
-----END PGP SIGNATURE-----

--------------wy0ijbG9AhwUrGLCuN11PMQS--
