Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9733A715;
	Sat, 11 Jul 2026 06:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783751284; cv=none; b=YMulrU4zWT/Uo+gXQekDeP2O114pCHaqZHunI+B6VOZYyGKnlljZAkJB/Uk4o9CYO49GN4DzOeHw9NQhFRNDSwArEbbeqyWbHdzzQ/15w/OlHqScotl/RGqdUYqniVIgG5KooXqpMkS7JqnAt/RPCuZQZ+kWhkMNOTB9/gVYT8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783751284; c=relaxed/simple;
	bh=wBgF9f53niiXHitiTG4+BLtEK3okzh7VXJT3GqpiMfk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kG/7x24oHMp1GXWUyvrPSrc9tMa7/W2I6RUxD+5dux5XAcbx7VgQeVTQDjqOopceL+rgV9cNDhSWWRmIk11fVgasJ6w/EWnHdS3/HuVCM6xyTtQ3dDl7DHGIUj93IQX/NCTHwqxTNlGzis3iEDk5m62G27RTJJAf8vC//BNVH7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQdlAjgJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQdlAjgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D431F000E9;
	Sat, 11 Jul 2026 06:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783751282;
	bh=ruXd2yAywBRG6OxMj7P3qVx1jzc+diGMP9kFtDEf83U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eQdlAjgJZaL9SIVczskq23J+LHyAgX0eqH5Z+3OnZ4tqJj0YtNxDNfN9v0rqNlI+z
	 scud2NWRDTcTkhi078oHofGYoeUyUthI6YADigWFs+uBQqH+YSeY/DrMG1/rx/vmoD
	 o3aqon8YTmq5dRG0f7KG18pHFdkGDfTJJbynieOO++nsWSWt4hiG72lJSaBk3qdbo+
	 d4XV4jXIcGhwHdl2E/P7S6l7tg9EVA5hfi7MDOuOIwuANdr8uVuFzsUS0INwN18lF9
	 0f1+FJDX78ndNkPScr+nDw1on9sU88bHDGGP+YJRhVQkZvBVPbmBuv+gP7Ro/txCUB
	 yfl7ewazKKd8Q==
Content-Type: multipart/mixed; boundary="===============3233477213634065140=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8cb15a4684938f4f0766c752a8cedaffde40f0abed7cb3e5247b390e3a68c84a@mail.kernel.org>
In-Reply-To: <329e83120f0d88c2e5dc9d7bb2c0d38988959d32.1783775928.git.xukuohai@huaweicloud.com>
References: <329e83120f0d88c2e5dc9d7bb2c0d38988959d32.1783775928.git.xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Remove unnecessary dup/restore subprog_starts and prog clone
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,emil@etsalapatis.com,yonghong.song@linux.dev,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 11 Jul 2026 06:28:02 +0000 (UTC)

--===============3233477213634065140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 25148865f9c76..232c02031fecb 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h

[ ... ]

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 37f22eb418540..80c8beb45ea04 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -1309,13 +1309,13 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
>  	return 0;
>
>  out_jit_err:
> -	if (blinded) {
> +	if (cloned) {
>  		bpf_jit_prog_release_other(orig_prog, prog);
> -		/* roll back to the clean original prog */
> +		/* roll back to the clean  original prog */
>  		prog = env->prog = orig_prog;

This isn't a bug, but does the comment need the extra space between
'clean' and 'original'?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29141596379
--===============3233477213634065140==--
