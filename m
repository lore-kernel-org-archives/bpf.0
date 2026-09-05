Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFFC165F1A
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788641182; cv=none; b=ResZ07mLSPNZp6xeyuFbZYSFT24QhsSJjqcfUs3X4e4Vttnj2y9UcDpSPBy2PRmx0hPk9yt4pfX70EbxtILvp6LxToc/6LruHH6Oc6gGcRb/bEzL+7T/MIwRPyiii2lbxcejj5JuS+ZoL7q34sNpS+i16cU/JhDEZYVWZYV7vsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788641182; c=relaxed/simple;
	bh=bH/up2eC8GchIyDx1vNnN2+uSHqn3ecHIvhf6FI4Nbc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CA2bVONi0ir7ot/SbqADw6X1dh15qfs0R2P2L5PXWoH2ds0NaMQMscos1wZKAXHpJalq9JwAHoC9P+6cFo11ONC4uCAdEhqlqfW+xBYsQxB9NXBC3A9njY2NENJmL42lp13xye4CtBAUwhxoJRcn41Ubi7/3Ox0fo/+oprbJNiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbW2zbSP; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbW2zbSP"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-475920b9ca2so692301fac.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788641180; x=1789245980; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rXsfvGq/E7bt5gl6myfL3gDoy0paTh5wxWE6/NMq0Cw=;
        b=RbW2zbSPaom0sQ3S9zJDogXbp9NVcDL3Zjdv95kGTcIIU4vp7X2/9ckZAqyCQEACfI
         njV4mSxx8CTa0Mapmtg8dNatd+omDrwNzBWujvx5oywCM+/I6US0Uv9sh0+hs1isuzky
         vOvgxQvxfu/hKLJeY4EYjMCOkmuPjhVCzfWkDGphd+dJtVcRk8xsDrNRcMm79+UKrmtM
         /nROfXZyPhE4lf+JQUQR1/oGy+aynowhakNEjULId/IQfgUmdpoq8sDpRrlFXlNVAd07
         gRXWv8IL1b+FRGqEnlPykwUXwgI0pXf3SnGBgdPVU+SELz6q4lwwB3kdeUGTwEC8voCy
         VQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788641180; x=1789245980;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rXsfvGq/E7bt5gl6myfL3gDoy0paTh5wxWE6/NMq0Cw=;
        b=SgDiReBzyZHnGJI2MFp4IzTDpInyvuEumh4sBrD3RFhMrLJ9kvLkYZOhPX8etZnmgR
         oJA3Zf8kEefHdChjt3p1MibEpwYstRWOfjhVCjwbk3M5oDK5WhRxK9i6LW4iZN6i5uyG
         jqPkNMN5w/nFy9YJjdKEOqXhKzuAyww2RMG0M3msoT0ZKoV9UcwYFYN2pH4v170CziOY
         SvF235mx18JpCkh64fMZutge/QJzZlVAXE1Qlp79c82kh4L6ILBYm/CuSnXY9J6O/CRN
         LT2A1wEno5l1ovLUEeuzj7m7ELdYMsGfK/71XxfwCcR7H/dwbUpz+cN2tQCYTdu5ikwT
         qdAw==
X-Forwarded-Encrypted: i=1; AKwUvBzdDfx+hWHqMnE+nXYXLwaNlcvTxUSb6jHb7zihFdZy/W6qDcjl5jv7AdQ2bggHrYXjxYw=@vger.kernel.org
X-Gm-Message-State: AFuF++lKwHqMaaoK/FvYknPRDhWg139Wo1qhJsnaaHCZEtMzUSUhZSnm
	8BH0OeGKAkQpH7+Z75ggkq98CbvuMJSNZs731nBalkM0WD1DOTZ3EwEa
X-Gm-Gg: AYBFou17jktpjwHfPfaf50uZwP9SsGe0Z5wYntfRUZfR1nhezQZBAx6UC4sux4TgCqn
	UpWSO44lYPWcabKkdZYNBP/rpdxU0E3p8B/tVezeznW6BjfEp56kWx+Excoszet+tXv0GFn5Ogz
	/laQcKv0YRKD/Gbi32kGL4u7nRhEtL6bigzGlKmAXDLRVIu5ZN6V9WBHmxLQsqHZ/9glwD8Au4y
	8OsVZcbBJ9zqTb9k44pV32VtIPAb0M+JvetxJ/hgFWouV3YMvMo2puzWsVNcYWIubxZ5lLwU1jF
	5/huBDfR7nmo8KRbWUxwXlyKhxT38LuqjFS6imLt7ErkATuhy/CuCY1YLurMTEhg9VQbholnJNN
	DJcdQCdqreGoqH/RiY8BHJL48naR+DxX2reEmE0i3hPKqmEo1NQUgdPoHt/pHTy96xWm3As1MQR
	vBeEgUOJsMtFoZQx4q8LM4I72wggEj+hy3tzXoELY0Es9nThy+3sM3SYVHBSLk5tr572C5Lj+/a
	2uKXvsJgsNcvE58v0+shyMpz/80jQS7LMZHYubxdX28cO9GBIvhW34=
X-Received: by 2002:a05:6870:21ce:b0:475:a112:1279 with SMTP id 586e51a60fabf-475a1124c2emr7936544fac.38.1788641179813;
        Sat, 05 Sep 2026 13:46:19 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-475543f5ac5sm6372330fac.8.2026.09.05.13.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 13:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Sep 2026 13:46:16 -0700
Message-Id: <DL7ODORZJ7ZO.1E8FPR423HTZM@gmail.com>
Cc: "Nicholas Carlini" <npc@anthropic.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf v2 2/7] bpf: Preserve packet pointer class
 displacement in regsafe()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260905083418.3723623-1-memxor@gmail.com>
 <20260905083418.3723623-3-memxor@gmail.com>
In-Reply-To: <20260905083418.3723623-3-memxor@gmail.com>

On Sat Sep 5, 2026 at 1:34 AM PDT, Kumar Kartikeya Dwivedi wrote:
> regsafe() maps packet pointer IDs between states and checks that each
> current register range is a subset of the corresponding explored
> register range. It does not, however, preserve the displacement between
> registers that share a packet pointer ID.
>
> This is unsound because packet range is shared by ID. A bounds check on
> one class member updates every member, and a later access can consume the
> range through another member. Commit 022ac0750883 ("bpf: use reg->var_off
> instead of reg->off for pointers") folded the fixed pointer offset into
> r64 and removed the old off equality check, so two individually narrower
> registers can prune even when their displacement has changed. The
> explored path can then license an out-of-bounds packet access on the
> pruned path.
>
> Requiring equal r64 bases would prevent the bug, but would also reject a
> safe uniform translation of the whole class. Instead, record the base
> translation seen for the first packet pointer in each ID mapping and
> require every subsequent member to have the same translation. This keeps
> the relative displacement invariant while retaining pruning for uniformly
> translated classes. Packet pointers without an ID remain unaffected.
>
> Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for point=
ers")
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  2 ++
>  kernel/bpf/states.c          | 42 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 36b65797877d..5cf92ce18520 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -854,6 +854,8 @@ struct backtrack_state {
>  struct bpf_id_pair {
>  	u32 old;
>  	u32 cur;
> +	s32 pkt_ptr_delta;
> +	bool pkt_ptr_delta_set;

AI's complain is somewhat valid.
Using extra memory for this narrow case isn't great.

>  };
> =20
>  struct bpf_idmap {
> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 66fb11b6c6a7..2f8f3fe164b0 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -339,6 +339,7 @@ static bool check_ids(u32 old_id, u32 cur_id, struct =
bpf_idmap *idmap)
>  	if (idmap->cnt < BPF_ID_MAP_SIZE) {
>  		map[idmap->cnt].old =3D old_id;
>  		map[idmap->cnt].cur =3D cur_id;
> +		map[idmap->cnt].pkt_ptr_delta_set =3D false;
>  		idmap->cnt++;
>  		return true;
>  	}
> @@ -352,6 +353,43 @@ static bool check_ids(u32 old_id, u32 cur_id, struct=
 bpf_idmap *idmap)
>  	return false;
>  }
> =20
> +static bool check_pkt_ptr_ids(const struct bpf_reg_state *old,
> +			      const struct bpf_reg_state *cur,
> +			      struct bpf_idmap *idmap)
> +{
> +	struct bpf_id_pair *map =3D idmap->map;
> +	s64 delta;
> +	unsigned int i;
> +
> +	if (!check_ids(old->id, cur->id, idmap))
> +		return false;
> +	if (!old->id)
> +		return true;
> +
> +	/*
> +	 * Packet range is shared by all pointers with the same ID. Preserve
> +	 * their relative displacement, while allowing the whole class to move.
> +	 * Packet pointer offsets are bounded by BPF_MAX_VAR_OFF, so the delta
> +	 * between two valid offsets fits in s32.
> +	 */
> +	delta =3D (s64)(cur->r64.base - old->r64.base);

Poking into cnum internals isn't great either.
If we go with this apporach it has be some helper in cnum.c

Let's figure out an alternative fix.

> +	if (delta < S32_MIN || delta > S32_MAX)
> +		return false;
> +
> +	for (i =3D 0; i < idmap->cnt; i++) {
> +		if (map[i].old !=3D old->id)
> +			continue;
> +		if (!map[i].pkt_ptr_delta_set) {
> +			map[i].pkt_ptr_delta =3D delta;
> +			map[i].pkt_ptr_delta_set =3D true;
> +			return true;
> +		}
> +		return map[i].pkt_ptr_delta =3D=3D delta;
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * Compare scalar register IDs for state equivalence.
>   *
> @@ -632,8 +670,8 @@ static bool regsafe(struct bpf_verifier_env *env, str=
uct bpf_reg_state *rold,
>  		} else if (rold->range > rcur->range) {
>  			return false;
>  		}
> -		/* id relations must be preserved */
> -		if (!check_ids(rold->id, rcur->id, idmap))
> +		/* id relations and intra-class displacement must be preserved */
> +		if (!check_pkt_ptr_ids(rold, rcur, idmap))
>  			return false;
>  		/* new val must satisfy old val knowledge */
>  		return range_within(rold, rcur) &&

