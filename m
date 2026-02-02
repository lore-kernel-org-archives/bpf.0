Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CFB2EC086
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770056888; cv=none; b=o3/Tw1c03KwXHIzmm5yFtBcYsCa/khyHPoZkRqveYznobJ3AKTL7xU7+kdOmHT+pplCOMroq14p/S4lBr60YokF0pEvw6Uz48NAnrAZz2ZIq0+HDtn3POyO2ihZfiiBNCo1y4kLUkFk2trFLsXbxalmXjtDzXLdj8ikFZuq+NT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770056888; c=relaxed/simple;
	bh=CHRJyUZDAYE+jZjKpTWORulabqZCYYMJnpAqN82lRrw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lyoXa1gDgzR4EWwIo7eaJBRAikLZUx92lyqy2/hQEuJ5x4oCDH7PSC4C4pR3JuaQJuEW/1KUWdH1g22peuRzo6J3UDP2dgQjSGT2t/Oo2/VcplJO5AytDWjrgVo0kESf5I3AKmRUcBEf7Dl6Ltzccxebfcnu+CGQw6lDi55HGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFu/G2yI; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFu/G2yI"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b7da62b487so5873012eec.1
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 10:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770056886; x=1770661686; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q9t4xIBZDLaKJgUn7kEtWwL7KUSubnre6cUBAi8Pg+U=;
        b=GFu/G2yIKBejEeldOCKWbOUJIUKHyG1zwZRvsl2c7l+vNrEBLbSZl/fDFtw8/t59wA
         80pt91jnNSekeDqntK9K82+TuSByhlPTjqLfg88Nc/AQ+uu/DHIeeDwFCYB9NWeq5FAH
         Y+h0dtZS1TPth09yk156jGvLmpCdVEaVIhlePKb8rj+PNs8/UESPgjtaRPAjpDfjcJ2H
         mmFxdA8C9eegwtniHwaP3sPC5WPIn0OkkKmPNjzLWqve0q80eC++hkDJszbFTOYlo2Yf
         xAvSdhT4pgrXG4A3v77t4KSHAICGwsTklXzVnxci1O1QulUQwdTkd9TrY26deOd9zzsX
         wulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770056886; x=1770661686;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q9t4xIBZDLaKJgUn7kEtWwL7KUSubnre6cUBAi8Pg+U=;
        b=CjTXSosr/iI4LBDPmQyti1bMALdWHRZDhu5MaTFR3TcqUyrsHA6L3hw48K0RJAWXLk
         zE0RthZm4WfGVoQOd2SCd+tKgdZy6oCL+IP5l0whV0JuGu15IEwIJKOYeqRhAcIHj6bm
         kC3r8rftKJ/66YA1e8jX8wap6gEF+I1+OqLAmzjG0UmPX2HE2+EPq1reCoDh1GAYcK50
         fOqLWWpQDP9bSxpnAnrhCjcpkcUAamB+2FZlsWdB80UskaRz3jeupmE8stcUkw9xZqnW
         3MtOJexqajGOrhghbZrEXgwOLhN8dH5rm5wRkvL6NIXhVDXksrxoC6CJ0lpZ0CvMGfu4
         Y3kA==
X-Forwarded-Encrypted: i=1; AJvYcCWztotl24fvdfR3uPB2refjUbQeWl4LrsIiugrLYIkSEOO0W080/GShN4OS3DvCRw+1ovo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAAHU2b/I6mKS15vPly5xoapj3WrH7125Lagrs5Cx/D9LyTyAA
	qYtGtAHd0MT5WngBHCsd8vwz0mQT+Pm+oj495t70AwdQWAGps2Y8iITS
X-Gm-Gg: AZuq6aLrpXNuu+YvTeRw9Yo39Xm/StP/gh4QGMptICsOgjUe6kzLGKWiuEDMjPASeiX
	2bHUjG0iDCH5WtQytkzupTJ8wwNmr02bkWFWEr0EanmcAwtPjvSyDODQIoid88reVxWcdB3Ls0T
	So7QMysvRnUj58T3E2DZX3BQxVSCaBhkgO9ovFAh7j0xNnBxR3kstAZllSVBRveoZC+tsl9R0be
	yWOJmw75hO5aeWe0Evq2fYGqSeiETiqJZrS1fDDhahNO18gPqONh0QofcmZEtJB88I27qRj9aQs
	AqVFcVsFi2P8o9dJKhiJWQfGoQ8vgKsAKvtvL5W9Waz9JjLlJo8dDznjhozXuQJws/uMr+3ItlY
	1vuA80Inf+hs8dd9rmWs4xxDeMBO0Q5JcbS8cVAMh7Dp8XCwMxZatJY5QzH33T/qlSWMlAr9Noy
	iy05ZxNOOi93FiKuI9MbYiaFGDt4LAhRTftHCtcF8Dr7kha5yxGtKLz17E8x0saEjs4w==
X-Received: by 2002:a05:7301:e24:b0:2b7:a2d6:b309 with SMTP id 5a478bee46e88-2b7c894555amr6778770eec.39.1770056885783;
        Mon, 02 Feb 2026 10:28:05 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:eca2:6a75:cc8b:c3? ([2620:10d:c090:500::3:5713])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7eddf72e3sm6941230eec.28.2026.02.02.10.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:28:05 -0800 (PST)
Message-ID: <da221c2e990da771e228463905dd527348d93f94.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: verifier: Clear singular ids for
 scalars
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>
Date: Mon, 02 Feb 2026 10:28:03 -0800
In-Reply-To: <20260202104414.3103323-3-puranjay@kernel.org>
References: <20260202104414.3103323-1-puranjay@kernel.org>
	 <20260202104414.3103323-3-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-02 at 02:44 -0800, Puranjay Mohan wrote:
> Verifier assigns ids to scalar registers/stack slots when they are
> linked through a mov or stack spill/fill instruction. These ids are
> later used to progagate newly found bounds to from one register to all
> registers that share the same id. The verifier also compares the ids of
> these registers in current state and cached state when making pruning
> decisions.
>=20
> When an ID becomes singular (i.e., only a single register or stack slot
> has that ID), it can no longer participate in bounds propagation. During
> comparisons between current and cached states for pruning decisions,
> however, such stale IDs can prevent pruning of otherwise equivalent
> states.
>=20
> Find and clear all singular ids before caching a state in
> is_state_visited(). struct bpf_idset which is currently unused has been
> repurposed for this use case.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

It would be helpful if commit message described scenario that fails
with current machinery.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> ---
>  include/linux/bpf_verifier.h |  7 +++-
>  kernel/bpf/verifier.c        | 75 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 8355b585cd18..746025df82c8 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -697,8 +697,11 @@ struct bpf_idmap {
>  };
> =20
>  struct bpf_idset {
> -	u32 count;
> -	u32 ids[BPF_ID_MAP_SIZE];
> +	u32 num_ids;
> +	struct {
> +		u32 id;
> +		u32 cnt;
> +	} entries[BPF_ID_MAP_SIZE];
>  };
> =20
>  /* see verifier.c:compute_scc_callchain() */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 17b499956156..9324d96aae92 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19461,6 +19461,78 @@ static void clean_verifier_state(struct bpf_veri=
fier_env *env,
>   * doesn't meant that the states are DONE. The verifier has to compare
>   * the callsites
>   */
> +
> +/* Find id in idset and increment its count, or add new entry */
> +static void idset_cnt_inc(struct bpf_idset *idset, u32 id)
> +{
> +	u32 i;
> +
> +	for (i =3D 0; i < idset->num_ids; i++) {
> +		if (idset->entries[i].id =3D=3D id) {
> +			idset->entries[i].cnt++;
> +			return;
> +		}
> +	}
> +	/* New id */
> +	if (idset->num_ids < BPF_ID_MAP_SIZE) {
> +		idset->entries[idset->num_ids].id =3D id;
> +		idset->entries[idset->num_ids].cnt =3D 1;
> +		idset->num_ids++;
> +	}
> +}
> +
> +/* Find id in idset and return its count, or 0 if not found */
> +static u32 idset_cnt_get(struct bpf_idset *idset, u32 id)
> +{
> +	u32 i;
> +
> +	for (i =3D 0; i < idset->num_ids; i++) {
> +		if (idset->entries[i].id =3D=3D id)
> +			return idset->entries[i].cnt;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Clear singular scalar ids in a state.
> + * A register with a non-zero id is called singular if no other register=
 shares
> + * the same base id. Such registers can be treated as independent (id=3D=
0).
> + *
> + * Uses two passes to achieve O(N) complexity:
> + * 1. First pass: count occurrences of each unique id
> + * 2. Second pass: clear ids with count =3D=3D 1 (singular)
> + */

Nit: please remove the "Uses ..." part from the comment.

> +static void clear_singular_ids(struct bpf_verifier_env *env,
> +			       struct bpf_verifier_state *st)
> +{
> +	struct bpf_idset *idset =3D &env->idset_scratch;
> +	struct bpf_func_state *func;
> +	struct bpf_reg_state *reg;
> +
> +	idset->num_ids =3D 0;
> +
> +	/* First pass: count occurrences of each unique id */
> +	bpf_for_each_reg_in_vstate(st, func, reg, ({
> +		if (reg->type !=3D SCALAR_VALUE)
> +			continue;
> +		if (!reg->id)
> +			continue;
> +		idset_cnt_inc(idset, reg->id & ~BPF_ADD_CONST);
> +	}));
> +
> +	/* Second pass: clear singular ids (count =3D=3D 1) */

Nit: pass comments anre not really necessary.

> +	bpf_for_each_reg_in_vstate(st, func, reg, ({
> +		if (reg->type !=3D SCALAR_VALUE)
> +			continue;
> +		if (!reg->id)
> +			continue;
> +		if (idset_cnt_get(idset, reg->id & ~BPF_ADD_CONST) =3D=3D 1) {
> +			reg->id =3D 0;
> +			reg->off =3D 0;
> +		}
> +	}));
> +}
> +
>  static void clean_live_states(struct bpf_verifier_env *env, int insn,
>  			      struct bpf_verifier_state *cur)
>  {
> @@ -20459,6 +20531,9 @@ static int is_state_visited(struct bpf_verifier_e=
nv *env, int insn_idx)
>  	if (env->bpf_capable)
>  		mark_all_scalars_imprecise(env, cur);
> =20
> +	/* find singular ids and clear them */

Nit: This states the obvious. A more interesting point to note would be
     that it is done before the state is copied to affect both current
     and the copy. But I'd drop the comment altogether.

> +	clear_singular_ids(env, cur);
> +
>  	/* add new state to the head of linked list */
>  	new =3D &new_sl->state;
>  	err =3D copy_verifier_state(new, cur);
