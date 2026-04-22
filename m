Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A4839B484
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776894399; cv=none; b=sZVrRlrVu7x1ROO9ZTpaF5GSxEmA2jsde4XczkxXQ48VIgM3nBswwrtuwFFRjQTDRlwYYI8PH6u0wm68f1WCEZYKjuJEqmnTc0D8wZh83P2+QfI3CfML0Xkp5T42NmKxihIQDGbVhgmWq0tsOI14jvdfO92pipfO2G2yIHFOlMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776894399; c=relaxed/simple;
	bh=LXWQ/zZQDB6esYihcq2rAbd9DbZBVCewYrXWURJ5WH4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TWHl6wt1bSOaabYuWNjaIVk+nNmUcwHiRlrKnJjDsK9A2DmzXcm5flpgHl6wLYZrQzRKM+b2ucEdiTZ+FNRWceQET7fXzWYTymYXnJxxkVhgIi1E0OLQw0BOb2NZnKg9kJDWeFqUciyEXgfjUJz/FzF2H9KI5KL9dZcPBeCIn4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvwzmaEB; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvwzmaEB"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c8ccc7755so5316352c88.0
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 14:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776894390; x=1777499190; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Ad2LzfHEjcYKktkgeY/57KxF86FA1ViCeeANnpbQLY=;
        b=UvwzmaEBSSn7ZdPhMuaqFXVXa+UEbGh/8NPI7BGBtqn+pvi3gxZPAiuKZkRpPDi8t1
         yC6EEOVBe7lHQ7UcfphG0Me1yrEI5PeZK/h5DBgm6YSse08io3+DQJOT2tzW8HTIj39t
         bPdLjyhT5pab1aeBmDAx8V983ryPwj+t94nxpuQqq1GClwCqbRwzA8bArvXyLShKPwBw
         3qiR0jQ3QM757cQyewIgMWweoCD10JDicnyHbjjVqpuW11/diANo/kMVK3yxN9OVrR+y
         JFA7gsIYJ6zlPYgbuBAyQp7JEgaRPETcdfiMtyFDT8rkmFC6V4jPGZoY97pQkIJte4m1
         +Ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776894390; x=1777499190;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ad2LzfHEjcYKktkgeY/57KxF86FA1ViCeeANnpbQLY=;
        b=Nfkr5VD8iPvef94OX3SpZ1YaTIRBpo1STb8KXMLhgWFkw7y+qCJV2CX4vKBmsA8rc/
         gZma6bIfwtnpKOxuxnEY/JCo4fBibIrPLMpvbnmczgtiIR7SnsqOoEJm0dT7733rVbDo
         TOEgSryZmRDuxbOxp+9ToQyE0bVoAivhEEAkFqeCJa0jCO1+D0DQ36xyxGyDN4S7GN3V
         3BmzFJemlN+s3IhwoeaJI8IWdJZfCkOxUzSy8ahn/5iuepIjEwwx8xWNDVK9nVq1i7Mi
         nEGeOunfb/6Qp/9vCse7jdPc7K8FJt1PaLXj+eK3+1uhqZ7GwTa41rcvn5VtH8/O9Sqj
         CjrA==
X-Forwarded-Encrypted: i=1; AFNElJ+6PY3/UYh53ryGmEDZV57KRAcXM0U1SgpsM183XB+4GG/iNr5cwtnKD3mKhjdx9W6f8io=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNemq2sUSyO+7SPYJkh0cAaEPxncwen9B2fGmgWzs43oz9pTjR
	E2QhhiboEfVyiC0Z30fUzVh1ryM2aMBPIsriZJK+jQKuthTD2F59GWjY
X-Gm-Gg: AeBDiet2S8d6YqnoHK7Qebwm6fRiCOZRXRG5mN9+DzIUUsDWVSaPvqp47RQoZRuflKv
	Lry10rraUvuwXae3vS7LxHdbTCEapk0UBHk9LtV9yuJnOUlVqqPhuJLPuCFTOyOgCJM/jwLBoz7
	23i8EOEteZgTjhCusD6ovN5wsLvF7SkzB0wHTdE79l/iBff7Eq3UO/bNZFO0YRH3CdY8DAC0jtm
	ieK2VUrIKrNwp0M2j8UnhnDNPSOo9NgjMUm8eVdhH/SvUp2+pGM4jq+x1ViMTJrF6PaBkEccDc7
	FuQhyJ7QGerOCkIgE67BWNO6m0Jzfb5SDTPF3G4u3gE7LIDiJ6NJCy88Foqj45aTcS5xFmQB7SV
	TQfXZY1pbz67SWa+vvXjEBRmLf/U9icxuehQmD/lISV8J1u9C07BtRmPJvROegbXOXQSyk5w5Np
	1mlOuen6a4KI6oEtxkGv4ODtTnYX9/PTEHgzbmg/R8Owf732gfyNv5pfa2YXaFiEb73i7LkCSoa
	nHsPNdZYN9hXv2chNoB
X-Received: by 2002:a05:7022:b87:b0:128:d375:f1d4 with SMTP id a92af1059eb24-12c73f98f83mr12823895c88.28.1776894389872;
        Wed, 22 Apr 2026 14:46:29 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1053:1d3b:d6cb:4350? ([2620:10d:c090:500::2:bea8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12dbaab165bsm5640680c88.6.2026.04.22.14.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:46:29 -0700 (PDT)
Message-ID: <9237d7b35463c79863488e3f2180239aab679049.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Assign reg->id when getting
 referenced kptr from ctx
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Wed, 22 Apr 2026 14:46:27 -0700
In-Reply-To: <20260421221016.2967924-3-ameryhung@gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
	 <20260421221016.2967924-3-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-04-21 at 15:10 -0700, Amery Hung wrote:
> Assign reg->id when getting referenced kptr from read program context
> to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
> referenced skb in qdisc programs using a new field reg->parent_id in
> a later patch.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/verifier.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 41e4ea41c72e..93003a2a96b0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6448,8 +6448,6 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
>  			} else {
>  				mark_reg_known_zero(env, regs,
>  						    value_regno);
> -				if (type_may_be_null(info.reg_type))
> -					regs[value_regno].id =3D ++env->id_gen;
>  				/* A load of ctx field could have different
>  				 * actual load size with the one encoded in the
>  				 * insn. When the dst is PTR, it is for sure not
> @@ -6459,8 +6457,11 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
>  				if (base_type(info.reg_type) =3D=3D PTR_TO_BTF_ID) {
>  					regs[value_regno].btf =3D info.btf;
>  					regs[value_regno].btf_id =3D info.btf_id;
> +					regs[value_regno].id =3D info.ref_obj_id;
>  					regs[value_regno].ref_obj_id =3D info.ref_obj_id;
>  				}

Hi Amery,

Could you please help me double-check my understanding of this change?

It adds a new behavior, if struct_ops method parameter is annotated
with __ref, then if a field is read from such struct_ops context
the destination register would now have it's .id =3D=3D ref_obj_id
allocated for the parameter at the beginning of do_check().
E.g. for `rB =3D *(T *)(rA + off)`, if `rA` is a pointer to struct_ops
context and parameter corresponding to `off` has `__ref` annotation
the `rB.id` will be assigned, contrary to old behavior, when it remained 0.

This change in behavior, however, becomes visible only after the
changes to release_reference() later in the series.
There the `rB.id` is used to initiate `mark_reg_invalid(env, reg)` for
the `rB`.

Are the above observations correct?

> +				if (type_may_be_null(info.reg_type) && !regs[value_regno].id)
> +					regs[value_regno].id =3D ++env->id_gen;
>  			}
>  			regs[value_regno].type =3D info.reg_type;
>  		}
