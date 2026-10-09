Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8B5478E49
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531549; cv=none; b=BveHWgkLrrJzsosOMsjKIkxi3j3ypZHQWKoROHvLYyJCXz9FeGQHBN6K9xG8F/ZCogiMjg0zQOeVGlD9QNrfkgsHMXELbNj+lq1+adKrRaTD2Keg1U1OScAbA4tatAu7iWLgrfob+4c70LNhJxHU0zFvhzRmIWpowA3yEUVV1nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531549; c=relaxed/simple;
	bh=75gYT7s2UZ9FC1DCawQnEq6vEfWx8UCP3g9f6w5NjyM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OkbpuUfl32109BiA8oesicaIV13cgosvLsNJldXhooGZzIXvILaiXKuODHB9rqoWDAo66j2j/cTm1x5Y7NmbsPl2G4FHrk0mATYXcIpRej4n5DNDxP2SSOgZUFNOGA/kSWUD3z+ldtCLlgsisL7imDp8SgxkmeOA3zoLHxhyagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HM8ZRbyu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HM8ZRbyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2281F000FF;
	Fri,  9 Oct 2026 07:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791531548;
	bh=1tqZpVZYJ7i/1hgC9P1EQI10FlsWvC9kRmDlutsirnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HM8ZRbyuWqQajNTmUVQ7VOPhSIIC9eyd/IJy6om3/KT3tp7vEhT6ImrPXcc+etRYG
	 3lwi8joWbX15mGJA87iDbIZTxFM6g+7tZqkBztYJZlKF5lOH/PLho4rkyoAG0N7b8e
	 +CDwRAt9E24GqBOrMP08IjVwor4qzEkN62+NgLXFPmK9xJp93PFWL3SZCvlFh5Eu47
	 w4DjSFVcdatz6g1JbShmTOCO4Weqx3PdX4HZ37P4ZaSkdoWF/j3a44XoLqyAa2zoY/
	 VdmzfmEHI+VNA0RqVGcpWkOcEoieYvNX6ZX/eHzHCLy7Z2wfc1yTHAjxetSz4reqDg
	 NKTARZl+Kbl1g==
Message-ID: <sashiko-outbox-165022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Propagate precision for outgoing stack
 arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jan-Gerd Tenberge" <janten@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009072752.21037-1-janten@gmail.com>
References: <20261009072752.21037-1-janten@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 07:39:07 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: mark_all_scalars_imprecise() omits stack arguments, causing=
 state explosion
--

commit 6af07cea664bce39c3788fcfdd7a5a9e4adbc1e1
Author: Jan-Gerd Tenberge <janten@gmail.com>
Subject: bpf: Propagate precision for outgoing stack arguments

BPF subprogram arguments beyond r1-r5 are kept separately in stack_arg_regs.
This commit includes precise outgoing stack arguments in the backtracking s=
eed
used by propagate_precision(), and marks them precise in the fallback path
as well. This prevents the verifier from missing value-dependent safety che=
cks.

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 18bf7b660c2f6..c62bc9fe2e325 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -1063,6 +1063,20 @@ static int propagate_precision(struct bpf_verifier=
_env *env,
>  			bpf_bt_set_frame_slot(&env->bt, fr, i);
>  			first =3D false;
>  		}
> +
> +		bpf_for_each_spilled_stack_arg(i, state, state_reg) {
> +			if (!state_reg || state_reg->type !=3D SCALAR_VALUE ||
> +			    !state_reg->precise)
> +				continue;
> +			if (env->log.level & BPF_LOG_LEVEL2) {
> +				if (first)
> +					verbose(env, "frame %d: propagating sa%d", fr, i);
> +				else
> +					verbose(env, ",sa%d", i);
> +			}
> +			bt_set_frame_stack_arg_slot(&env->bt, fr, i);
> +			first =3D false;
> +		}
>  		if (!first && (env->log.level & BPF_LOG_LEVEL2))
>  			verbose(env, "\n");
>  	}

[Severity: Medium]
Does this patch also need to update mark_all_scalars_imprecise() in this
same file?

When a state is added to the explored states cache, mark_all_scalars_imprec=
ise()
clears precision marks to ensure maximum pruning efficiency. It currently
iterates over standard registers and stack slots, but misses stack_arg_regs:

kernel/bpf/states.c:mark_all_scalars_imprecise() {
    ...
		for (j =3D 0; j < bpf_stack_nr_slots(func); j++) {
			struct bpf_stack_state *ss =3D bpf_stack_slot(func, j);

			if (!bpf_is_spilled_reg(ss))
				continue;
			reg =3D &ss->spilled_ptr;
			if (reg->type !=3D SCALAR_VALUE)
				continue;
			reg->precise =3D false;
		}
    ...
}

Because this patch allows stack arguments to be marked precise, wouldn't any
precise stack argument enter the cache with precise =3D true?=20

When a later verification path compares against this cached state via
regsafe(), the old stack argument having precise =3D true would enforce tig=
ht
bounds checks or an exact memory match.

Could this cause state explosion by preventing pruning for any state with
different scalar values?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009072752.2103=
7-1-janten@gmail.com?part=3D1
