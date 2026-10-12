Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3EE494A1E
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816547; cv=none; b=C/loXx+iOmldTeFux3ucKvllH/0jKyuRW5kyFYaUIRQj6iSH+dQ6GQWHJ5SV/6Ekj0I4r2SjAKiuzt9Uqjh2JLdp3+fMatgSktmoxzkZA44pIw0ylaLzyMEZFr02XwVji2xUSUwkTdEOkNmlAGM+VMDIVX5XersmmPyHGBjvcN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816547; c=relaxed/simple;
	bh=eADnhZDWkTbz8AGKH1NPbboRiqg1OT9+LC8OuuKghTk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PXU4XxVMD8Y3bf60zCFgqXb+gyPEzPMzhaHshqgyGnA3mq4U2einS1lNHItx3BPqpWW8L1HxciGOfDweoUh7npTQj4ilc/YqXKbz1x6KRWhymMuXRhvsg+3pJuadJojOmHzyMRU7MmIVpx+6aDxkhiE7UFzW4VWZXRSHh+i6SmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcBBkWoh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcBBkWoh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216471F0089B;
	Mon, 12 Oct 2026 14:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791816546;
	bh=B+P82q+ZZVPRSXb6XV/BYi/8Gb1YRWiV0IYtdIQm5HQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UcBBkWohRE+SU9+yxdD8LWqLt6ComoETUzrqm9k23geiFS0tmQtmhfZuj3C8a7yOV
	 ENUS3lI78kz5yYeko+287UjLBLzNHCdQAHsxcXgRGyCF2wPxeJyVjxCVrV/HCySPqw
	 iPN3AOEBgHE5Dy2hq7jjMxeGqJarALVGsrx2eVMoNjCAxEvajkV/bTGGKZ7LmWo8vF
	 MPED30wEsdwX3v21zVIVouxcNv8Y/k3I2RNPUYG8U49lIGovn6HBGfC+6/wIE2lhk6
	 rspoOmcYde1+wGbYkjP9Qsc8xkRy1y+VGgaG2RFdGMo7qrJk9GUFN3fQcaRcesto2B
	 1Sz3hWP44qccw==
Content-Type: multipart/mixed; boundary="===============4423898497074166595=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <63ca127f55b999fe7fb4215a1a2d211c1af0d121cb473eaa246dea840d161729@mail.kernel.org>
In-Reply-To: <20261012140640.2932195-2-alan.maguire@oracle.com>
References: <20261012140640.2932195-2-alan.maguire@oracle.com>
Subject: Re: [PATCH bpf-next 1/3] btf: Fix size/vlen validation for BTF_KIND_LOC_PARAM
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,jolsa@kernel.org
Cc: ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,puranjay@kernel.org,yatsenko@meta.com,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 12 Oct 2026 14:49:04 +0000 (UTC)

--===============4423898497074166595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> btf: Fix size/vlen validation for BTF_KIND_LOC_PARAM

TL;DR: Nit only, not a bug: the new "vlen < 1", "!size" and "vlen > 2" checks
in btf_loc_param_check_meta()'s CONST case look redundant with earlier checks
and could be dropped.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -4827,12 +4827,12 @@ static s32 btf_loc_param_check_meta(struct btf_verifier_env *env,
>  	case BTF_LOC_PARAM_CONST | BTF_LOC_PARAM_SIGNED:
>  	case BTF_LOC_PARAM_CONST | BTF_LOC_PARAM_ADDR:
>  	case BTF_LOC_PARAM_CONST | BTF_LOC_PARAM_ADDR | BTF_LOC_PARAM_SIGNED:
> -		if (vlen > 2)
> +		if (vlen < 1 || vlen > 2)
>  			goto invalid_vlen;
> -		/* Ensure size/vlen are consistent */
> -		if (size > sizeof(__u32) && vlen != 2)
> +		if (!size || size > sizeof(__u64))
>  			goto invalid_vlen;
> -		if (size > sizeof(__u64))
> +		/* Ensure size/vlen are consistent */
> +		if (vlen != (size > sizeof(__u32) ? 2 : 1))
>  			goto invalid_vlen;
>  		break;
>  	case BTF_LOC_PARAM_REG:

This isn't a bug, but are the new "vlen < 1" and "!size" terms reachable?

btf_loc_param_check_meta() already rejects "!size || size > 16" as an
unexpected size, and rejects "vlen < 1" with "All LOC_PARAMs have vlen of at
least 1", before reaching this switch.

The final check, "vlen != (size > sizeof(__u32) ? 2 : 1)", also already
limits vlen to exactly 1 or 2, so the "vlen < 1 || vlen > 2" test looks
redundant with it.

Since !size and vlen < 1 are already rejected before the switch, and the
vlen != (size > 4 ? 2 : 1) test already limits vlen to 1 or 2, could the
CONST case just be the "size > sizeof(__u64)" check plus the consistency
check?  The neighbouring BTF_LOC_PARAM_REG case only tests "vlen > 2" and
relies on the checks before the switch.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38263660345
--===============4423898497074166595==--
