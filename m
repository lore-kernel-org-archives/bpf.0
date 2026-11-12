Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483115;
	b=GyVDbtJqsRsdq/1e3Fi5/jiN4Kdom2nZhie432lYTRStvCaboTZVR/n5CwULGc6D4eqt
	 wb5K1kJnvilF7+Vox4sbaKcrUs67fb+dwhs2KJ9dhaVYr0xqXoKRwN0KMy8FRFFz6Yzbg
	 TJlCdSPFX2YDGoJMSNLsJph2PhjGmMWcB+fKosWQRsSG1F0puiGpadEjbxQ1KSdzDcsvP
	 B55KIEqmGvewD3G5VukT8zjwrqEg6naGvS9ATOauq8Xae4aPGRooakTjZcEGegPYXHhmb
	 ayRnQNNzWcg6qk2gmwR+BV2JI2tOLvRa7Av6YsMjxyh7Ad8Jn/FQKzTV5IsCJ5t//eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483115;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=RcotuArfsvbkeksjSM7B/SH7oTNsE9adGBwe+em9i5w=;
	b=N3Rj2ZXyQcINPARO8xBV69S/osri4DTQM+SzmMKmLLGdK6Xn/ia0y/fKlD9UA7CTRxYy
	 bIPVBcvwIqycWp1rMU+QLlkSk2lUqfjGdwq20sZylztH0BCu5AzpULJmNbH8VOTbhUel2
	 OGZvM+MGkQk4osajowXXQG5j0JeOQ4NvYcF4oO2FnY/3CQNrNXHJhnJxPYtQvbEvVUXP4
	 flY+SHwqffn4J0UlrCPPcXkbCdty7f3GGkXnh1WcJdvTjhFITqIEwRfx0DB9f/5LtrA39
	 Tircv4DnmL0wYjJvuCvSuB8AY+moTcyzsy0qlwJrp7zqhSnrcBHBR8MOzjlasn6+mtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eb92iPgE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D266606A321;
	Thu, 12 Nov 2026 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eb92iPgE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C601F00A05;
	Thu, 12 Nov 2026 11:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483115;
	bh=RcotuArfsvbkeksjSM7B/SH7oTNsE9adGBwe+em9i5w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Eb92iPgE6cf3O27OesLFsHUem9A+wHqp87UvYoPyh7jTG2f3W39H69wIymc31TWhE
	 cdB3poWheLGniGstz1JynrlUju3wR6EZgmqOKccM/mumxX8WABi1xl1ResllZdY88D
	 VYRnuTwV1xvuuKFxT2Trlq3cb3VmiCCzOHNWacyZ2ICL3auyvJXRecUGspotYj1WC4
	 PlRGYnX+F5UueWhce2PSAB0gh0F3xREq/QKvIIkwHncRUQKylRvO7kw0SBpI0ikpA1
	 W4NTHM2LSOd1WbuMN+dGoez+y4rHBEPzi/BHK6J5vDa09J8LLtzjY/CA3oBR0I/ikq
	 /wq8hRHIhyrqQ==
Content-Type: multipart/mixed; boundary="===============8043813505677554832=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b24ca383df1298651bedfb7ef22dd605f2cdcf822369782d46fa0f3598eaebf2@mail.kernel.org>
In-Reply-To: <20261112105620.57520-1-shlomojune6@gmail.com>
References: <20261112105620.57520-1-shlomojune6@gmail.com>
Subject: Re: [PATCH] bpf: Reject offloaded maps as map-in-map inner maps
From: bot+bpf-ci@kernel.org
To: shlomojune6@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,kuba@kernel.org,qmo@kernel.org,shlomojune6@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 12 Nov 2026 11:31:53 +0000 (UTC)

--===============8043813505677554832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Reject offloaded maps as map-in-map inner maps

TL;DR: Nit only: the comment in bpf_map_meta_equal() saying ops need no
comparison now contradicts the new ops check in bpf_map_fd_get_ptr(); suggests
updating it or moving the check there.

> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c

[ ... ]

> @@ -110,7 +112,8 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
>  		return ERR_PTR(-ENOTSUPP);
>  
>  	inner_map_meta = map->inner_map_meta;
> -	if (inner_map_meta->ops->map_meta_equal(inner_map_meta, inner_map)) {
> +	if (inner_map_meta->ops == inner_map->ops &&
> +	    inner_map_meta->ops->map_meta_equal(inner_map_meta, inner_map)) {

This isn't a bug, but the comment in bpf_map_meta_equal() still says:

	/* No need to compare ops because it is covered by map_type */

Offloaded maps share map_type with software maps but use
bpf_map_offload_ops, so that comment now contradicts the new ops check
here.  Could it be updated or dropped?

Another option is to move the ops comparison into bpf_map_meta_equal(),
which array_map_meta_equal() and xsk_map_meta_equal() also call, and
replace the comment there.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43208166255
--===============8043813505677554832==--
