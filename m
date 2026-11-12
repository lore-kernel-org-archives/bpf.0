Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492466;
	b=rIdfjdZylQNOTW14BYZDxnJs5lhf+Ovk8stcRpgVDPSMQfytM9zMuNpvT5+VMJ8XPeM2
	 6vUtqHIA4SwcM60v7DEQSYrTIeo/83V7PgRckyc6HvT87NVU7Vonc1kjQTPVi9TOE2taW
	 ysorYU9b41J6iRGIM3Q4oVsf7SdxWGofIRidH+VB9WcIiCvu51vfaENVi7STMhpf/CSoQ
	 Bxu5EoW1Tq++jQxx2rSZYceKwQPdusUbuyrZ0BPMwJ/uJTS19zhUdByoHV0Z/XxEGzotu
	 BjQz2CU1mEsYAUjRgeh+C2fcm/800pF4i+46+3JbzixyM3fza5mGIER7QJ/dcgiDETQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492466;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/lwI9x1mAEArrsKgoIbDXZ2nX7SmRnoFzYv07qQjLks=;
	b=SXMipAsGO7BmF6/modwYttau2/1BI97gdoee9+xuUl+ObcswEtWwz//C7vX+Cify7Ss0
	 bR6LlJKaJBq9Ta/DMyXQxRTOvRIyd123JZQxEgDUGOIkUemdAWW0wgP1tk7YQXt07jSVO
	 6lqYuoZJLTLAk1rdZM76SzRuJmVzvf8SorY+m9FP5fJrF1xwpfgk0plYb6nvF88WQ2K1B
	 RZI5eCX/315SvY6RgDd6vLA3FyW4PBiHQyV7V2H3qI5rmLhyoGE6LxWmvdeL5eoE6MHPV
	 74i6TLt8FKcbfvYQweGrad+hbiM0Y5ZdC0y9+mlQqIsVIk/KdR6Psgi+ZQrr5jmw/kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Szydob4h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410BE606A32A
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Szydob4h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73711F00A05;
	Thu, 12 Nov 2026 14:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492465;
	bh=/lwI9x1mAEArrsKgoIbDXZ2nX7SmRnoFzYv07qQjLks=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Szydob4hLtSMz7wrFmYs53vn0reVrPLOo6gS7igRZXigynt+U7rjbImgO8E8sdnXV
	 AztdXs28dJpA1Uus6lKZhkpd4iXu9h2bZBnMNWHGLvOGx+FDsywbKsYNgRmO5QCmJS
	 330/SR10+mrq5pJNIObsd0f5iRMc5SIU85AGi0Wmd+Wg0haGt8Vxwn2fAe9kCcWXQU
	 7Vnwnz0KV3k1r/N2a52XNJv4jTceDKb3PzJmyXcKulME8jV6rD0hSJxe0RlWaczr7s
	 1nwdZwZZm7Izb1XhQmkoYjOIwG9+py3DbB5JWYGXbrD6GD7yMdbZK+e7LvUtcGojd+
	 inz3MXgjKckVg==
Message-ID: <sashiko-outbox-211267@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: Fix cgroup link update after a failed effective
 array rebuild
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shihuang Liu" <shlomojune6@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261112134942.288831-1-shlomojune6@gmail.com>
References: <20261112134942.288831-1-shlomojune6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:07:45 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] bpf: wrong slot in replace_effective_prog() after override
  OOM detach
- [Low] bpf: multi-line comment above bpf_cgroup_array_item_at()
  violates style
--

commit 417086c03fb15b10d49180c23398c0440bbc2a1b
Author: Shihuang Liu <shlomojune6@gmail.com>

bpf: Fix cgroup link update after a failed effective array rebuild

This commit introduces bpf_cgroup_array_item_at() to skip dummy entries
left by a failed effective array rebuild when looking up a program slot in
bpf_cgroup_array_delete_safe_at() and replace_effective_prog().

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 57a785241d42f..db3f173e83c69 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -403,6 +403,28 @@ static int bpf_cgroup_array_length(struct bpf_prog_a=
rray *array,
>  	return cnt;
>  }
> =20
> +/* Return the entry at logical position @index in an effective program
> + * array.  Dummy entries left behind by a failed rebuild are skipped bec=
ause
> + * they do not correspond to an entry in the program list.
> + */

[Severity: Low]
This isn't a bug, but BPF coding style places the opening /* of a
multi-line comment on its own line.

[ ... ]

> @@ -1175,7 +1193,9 @@ static void replace_effective_prog(struct cgroup *c=
grp,
>  		progs =3D rcu_dereference_protected(
>  				desc->bpf.effective[atype],
>  				lockdep_is_held(&cgroup_mutex));
> -		item =3D &progs->items[pos];
> +		item =3D bpf_cgroup_array_item_at(progs, pos, atype);
> +		if (WARN_ON_ONCE(!item))
> +			continue;
>  		prog_list_replace_item(pl, item);
>  	}
>  }

[Severity: Medium]
Can bpf_cgroup_array_item_at() still resolve the wrong slot in
desc->bpf.effective[atype] when a descendant cgroup overrides an ancestor
BPF_F_ALLOW_OVERRIDE program and then detaches its last program via the
purge_effective_progs() fallback?

In a 3-level hierarchy P -> C -> GC where P has BPF_F_ALLOW_MULTI links,
C has a BPF_F_ALLOW_OVERRIDE program prog_C, and GC has an overriding
program prog_GC, GC's effective array contains [prog_GC, link_P1, ...] and
omits prog_C.  If detaching prog_GC fails to allocate in
update_effective_progs(), __cgroup_bpf_detach() replaces items[0] with a
dummy via purge_effective_progs() and removes prog_GC from
GC->bpf.progs[atype], leaving GC->bpf.effective[atype] as
[dummy, link_P1, ...].

When link_P1 is later updated, effective_prog_pos() sees an empty
GC->bpf.progs[atype] (cnt =3D=3D 0), so it no longer skips C:

kernel/bpf/cgroup.c:effective_prog_pos() {
	...
	do {
		if (cnt > 0 && !(p->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
			continue;
	...
}

effective_prog_pos() counts prog_C at index 0 and returns pos =3D 1 for
link_P1.  bpf_cgroup_array_item_at(progs, 1, atype) then skips items[0]
(dummy) and treats items[1] (link_P1) as index 0, either overwriting the
next link at items[2] or hitting WARN_ON_ONCE(!item).  In either case,
items[1] retains old_prog after __cgroup_bpf_replace() drops its
reference, causing a use-after-free when GC's effective array runs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112134942.2888=
31-1-shlomojune6@gmail.com?part=3D1
