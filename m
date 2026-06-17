Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4989B33F8C1
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781725688; cv=none; b=IiL96rTOdZ51I39ZeJFkRfOJW8Y11rmf1LHJvg5758CdXfEs2/cgVXcgnXGmN63bUlt9sOfy53YGpbooYTKl+HNkedRLhZLbu5phgxKQApnRrPe6iwWoHAZKN1HImVNEeeu5zwdbtos7a9BocTLN52NQPYwzHEaUWB4aevodC1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781725688; c=relaxed/simple;
	bh=y8KRxlDydnlMB4bwe8rA8Q24TwjQ3h3dXz9QHSatshI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PHIcuDIxI+Ts145hq3GC+GTLWp3/l14VLy79h5tRBhLJstQoYGwGEfzjh5Hz5LfwIk/YKzGL8INPLbZaKc3o3lmZZTvh+HkBgEeElSCcgu4O1AieYLMYb5vHxA9AqdOvaoJxE7DlspZZ+CXS/mVFwa9NptpGtsQtWWax5g5mwyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=xiDvOEcV; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="xiDvOEcV"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30beab3af9eso465258eec.1
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781725686; x=1782330486; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvTFCUrAoOsfyHTDvUm1jrIbxnzSI3LZ0klwZ9TVDcQ=;
        b=xiDvOEcV+6F840UNP2zKOmtsqTNFTt9unV11MwI/pheJydIgEcypNMebLsObyk4Y6a
         z6FNgI9lSJY/3rBW8Hg4DwKOyR7t9CIsDp7caA9P5i8SENhEEAj38EgUPLg559kMN6sz
         3tphZzQYKa43AixN2KG0pM/1NWKjmwKHu7wnnfRLZtXPgUZ+wXOeuJxdkCcqCNwO3jmG
         OouWs8kEHVBtj10pC/3J+XoqSQEdbCMzCPCyhSdXZNDX7g+y0V9IN3KEJRQNAwoMBanD
         ucLLUs2XhGXFmuWazgw9+uVFX3sDO0/1KLmNEYx//7OZk4J14lCxISDM2XE0nnZzmHoz
         LLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781725686; x=1782330486;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvTFCUrAoOsfyHTDvUm1jrIbxnzSI3LZ0klwZ9TVDcQ=;
        b=RdfmB8RoN7Kk7gf444plNEORDMefTbaGxrIfRBD/3T563BEHoGTa8l1c+L2qqaT/3O
         xBgocgDvnEHRp9uUMBw6AfnAPKT5FJiQ/YkM4wiuDXZIqViWyCJTXXnluuXm2M4e1tmp
         tAThlG9DF6+iCCv2+mP1qdD7RjED6WThkeJF11qvDwhf3SpSmLAUMU4cyO4GGZ4grj00
         Zlflwlc6SMdQTEniws10pCnmV45ZOrCZUE4follk0y2UDW+jG/rlHc3wfLxPNLiW3DCX
         u0znSH9k3tvOCqpHM9C83nMVToHdbqgmgUyxT2KSB5OmxuIHkaH1+1jQaWOSEyda7z2h
         F1GA==
X-Forwarded-Encrypted: i=1; AFNElJ/TxswQapBqCy+VGp6NIiBt5IDlRHA1TMyrHlExdKbTBcGUNrtaJrrmNFlgUTVZdR1XFxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQSN7kV3UhWnP6LOZdXFlTdMzKRMhA9Qw8J5MU2gnI5GtCroh
	t9uLubjAG4E23ElJYuMeywY1wig1VqEpS4GArOryaQgKj1i0Y0sHWhId+HL2OfrG4h0=
X-Gm-Gg: AfdE7clPLX3mnNMFSobIAeAW6HpgGz5BwP2spdQH1LD9zV6MHGXGWzi62bIicu2R89X
	d2nSCBqagCsTmPglOaQY3dLKFXx+Ikek38EHM6AoO8MSqqCI13sX4+nIiHw9FUv93HirbPKYJm+
	qSHEcLQAB1lboNGnuGgMoarU0+T2RsWkXAUIB06brKsL91CoaXyZ1fssfWBg9LOv+ZwxXSW8sJO
	csUqY1qGFEiFGLiVHaRS3nLguokeFM7SaUHkfvxicEqo4hYUH/yfVxhEhIvpdj1PyEuGxtia/g9
	jRm4nuhS/OJpcm7Bu9V3BEgvzgxiqMSd0Pibfv8Mrlg5D4N22OyPdMvc7ambXxf64u9G+2VdU2D
	oKAOSi38H7fRmH43psCsNwMVzX/DDci+ushYahjmNnJH06Zy+NkN7ReyKfK+hHIs0Aw8Hag==
X-Received: by 2002:a05:693c:2d8d:b0:304:d14b:b706 with SMTP id 5a478bee46e88-30bca08297fmr3459406eec.27.1781725686243;
        Wed, 17 Jun 2026 12:48:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::4852])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e4898c0sm24671774eec.3.2026.06.17.12.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 12:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 15:48:03 -0400
Message-Id: <DJBL1JEE322B.28EZ7GUNTJP99@etsalapatis.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] bpf: Use common error handling code in
 bpf_is_state_visited()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Markus Elfring" <Markus.Elfring@web.de>, <bpf@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Jiri Olsa" <jolsa@kernel.org>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <d6622225-c765-4d9f-9501-1021df4687a4@web.de>
In-Reply-To: <d6622225-c765-4d9f-9501-1021df4687a4@web.de>

On Wed Jun 17, 2026 at 3:30 PM EDT, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 17 Jun 2026 21:15:08 +0200
>
> Use an additional label so that a bit of exception handling can be better
> reused at the end of this function implementation.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Can you resend with [PATCH bpf-next] in the title? Right now it's not
celar which tree this is targeting so Patchwork is treating this as
a netdev patch.

> ---
>  kernel/bpf/states.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 5945956a7573..09f87e2bb1e6 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -1566,21 +1566,16 @@ int bpf_is_state_visited(struct bpf_verifier_env =
*env, int insn_idx)
>  	/* add new state to the head of linked list */
>  	new =3D &new_sl->state;
>  	err =3D bpf_copy_verifier_state(new, cur);
> -	if (err) {
> -		bpf_free_verifier_state(new, false);
> -		kfree(new_sl);
> -		return err;
> -	}
> +	if (err)
> +		goto free_verifier_state;
> +
>  	new->insn_idx =3D insn_idx;
>  	verifier_bug_if(new->branches !=3D 1, env,
>  			"%s:branches_to_explore=3D%d insn %d",
>  			__func__, new->branches, insn_idx);
>  	err =3D maybe_enter_scc(env, new);
> -	if (err) {
> -		bpf_free_verifier_state(new, false);
> -		kfree(new_sl);
> -		return err;
> -	}
> +	if (err)
> +		goto free_verifier_state;
> =20
>  	cur->parent =3D new;
>  	cur->first_insn_idx =3D insn_idx;
> @@ -1588,4 +1583,9 @@ int bpf_is_state_visited(struct bpf_verifier_env *e=
nv, int insn_idx)
>  	bpf_clear_jmp_history(cur);
>  	list_add(&new_sl->node, head);
>  	return 0;
> +
> +free_verifier_state:
> +	bpf_free_verifier_state(new, false);
> +	kfree(new_sl);
> +	return err;
>  }

