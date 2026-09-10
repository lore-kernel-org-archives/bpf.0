Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996052D8796
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074140; cv=none; b=KOm1glZJ6JWsyTrqswMXL/h5ES2XZTs18mOl1FzaybWcjmI66og/l6YSj7u948qJd6Ud+eF9D0wZwSVXvNTmh0tynesTnk8BdMLi4zDIaCVXHr52IhceMCUdyXLyEmkvJHEGHZ+sRLX3BjYTPIAhlFuWFSN4vSx6veWVXR5wJF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074140; c=relaxed/simple;
	bh=+YgaONe7Pu1WW6T8fiAHNeBdaWk+HAqszbvotft6YBc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oPSsYZtaubbypeekWlHzLmCgnC2/AVzCwf1vJga5PVMCsihe65g5ZtAXvUl5bF2PVJFXrw0+5gfiqwrcDota4OskNElDo1KggVw67NVURsaJnPQiMP76YFXfzTV7G/D0AhLH2EXi4joCuvjhVGr6QPzuOl1gNjJQGdHWMo4pmIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7y0PJf2; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7y0PJf2"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6b1b766bf01so201791eaf.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789074138; x=1789678938; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PcuSDQa6B7Oy9lzcHJBFK26P50+tDJCpxifoH546zv4=;
        b=S7y0PJf20FVaXhuA42uf8yL0pwnu6vWHJ8r+M26nzX0fE3mjnL+0Dws108f8zEhc4B
         nyscq75FMmqYrqM8jeavDb1VOSunBklGnflflanOveZCq8an/5ujE12hwI/OQ5opIXl5
         Liip6LGhTEjH0ixll1271kxtiws0PFdCmENFahSLeE4Nabe4dddj5lTtDUPgLg03KgY3
         g1FSxMSdX/5xl0WlmEFhcnEuw6rpRKsE7Hd4KvM1Zqg22SwZ5dpM5+aA3LMvMisKh2Dd
         5/99AsoqBpo46mhjqpuiDJGIfhp3Fdv7j2Rajm+5rO444H2/7vfFPM3NeDwZvpyxvE4f
         DUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074138; x=1789678938;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PcuSDQa6B7Oy9lzcHJBFK26P50+tDJCpxifoH546zv4=;
        b=fRd2L26xZ2C7i3zMPoIrkID/yamuOWX1BO1fWcWY/4NTNcBXe0Gf/pYqsXmViyBtn1
         4rc6se5nFdYjIB1SfaAHYCBhXX82HF76hLhacb8DnMxOTon1qmkoqZ0vUep3hJmkjkOr
         o2Lf8K0FpKBEwwKngz539NrqsLitO8h32IbVQ+xmDNxmeit9F/qgld3+Ptk0NZfSAJS5
         y2Uq28vpGrjiPmSroswj//Y/TlQxpifQN5B2IkVf7K1UAo1WxMCBaPaZFljAc2Y3g2RC
         cQVUC0RCdQSnLLVOpO10xnN4yPFjOS/RwQt1Kh+xKEm8SRDUlf+TWjg4m/EZrWWf/mzU
         G+mA==
X-Forwarded-Encrypted: i=1; AKwUvBxLITFJj6Rz6SufU6O1UQ6GPHnFdXzqwfYtvSyYWgxf+Y7f4ePovr7JukrjepV6iX2gIiY=@vger.kernel.org
X-Gm-Message-State: AFuF++muNHSq/5CWbX+yjpieVA+7Y/auk04lkuusOIbYT1kpQpx+EU+T
	7sCh+SBS7LLgGdqR+IF/Cpx/AEdLEDiqotqJDbbnJhTIkwvOCv4pCO/r
X-Gm-Gg: AYBFou1iG9sgpD/U7YloyBVsYAjLGBNL8ncKjkRbp7seb98pq9SOOWUEfK0YVpIhuIz
	vqIk7AjJ4CWw1hPh/vDaoqc66snFJ+3m2Yl9O9T0Iq1jcFQeI5JxNjg+lR2198WgQgwh4Qsp6xx
	+BMzrVXgvaHMZflkPfddX4oOE+MLwBA43xBIKbc0BhTtcXTpG34EOTcIpnFiK3RYDDqUdrUmlNV
	giPCgZLiIS9KnSMu1dJgCN704FuTkDIbtV2HQy7SUGCG+IevrkU4cohJkQfwd/4dm/bg4s5JYxp
	paO98qOuYrx+DDa0K4NP6/D0lXkkzU/PXFEyW0loXgxQbx4L47PnIgrtaSf9FBI68jKwk9bseB6
	2XZxhJas6k2rMUXnfJoPkJYVjzeBDN4DwjonOvTXS17jL5ePuPGYTlVBnDA9xB1S7lhomAhxU7x
	3S3ExHn6K8KOvsrD8KSBT1ZhZ1dRa8OpJ26q+wtAkNQIIHxKtdNCmCBirGd+txqw5e3Y0TYQS/7
	6PkC0SmB0RPS/5qXbbs6pwh6JjbdwTqOD7wAXGduUI/XRpoQYdqoj4oqA==
X-Received: by 2002:a05:6820:c0d1:10b0:6b7:8396:f3c3 with SMTP id 006d021491bc7-6c0bbce6f47mr420295eaf.37.1789074138340;
        Thu, 10 Sep 2026 14:02:18 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a3ce:533a:7492:3ff3? ([2620:10d:c090:500::4:d279])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f0feaasm711470eec.21.2026.09.10.14.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:02:17 -0700 (PDT)
Message-ID: <0157b1eca803919afa59ae658f186aa0509a239a.camel@gmail.com>
Subject: Re: [PATCH bpf 3/6] bpf: Cache the jump table of a subprogram
 during CFG discovery
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: memxor@gmail.com, a.s.protopopov@gmail.com, info@starlabs.sg, 
	bpf@vger.kernel.org
Date: Thu, 10 Sep 2026 14:02:15 -0700
In-Reply-To: <20260909204035.24289-3-daniel@iogearbox.net>
References: <20260909204035.24289-1-daniel@iogearbox.net>
	 <20260909204035.24289-3-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-09 at 22:40 +0200, Daniel Borkmann wrote:

...

> @@ -347,16 +356,33 @@ create_jt(int t, struct bpf_verifier_env *env)
>  	struct bpf_subprog_info *subprog;
>  	int subprog_start, subprog_end;
>  	struct bpf_iarray *jt;
> -	int i;
> +	int i, err;
> +
> +	if (!env->cfg.subprog_jts_ready) {
> +		err =3D compute_subprog_jts(env);
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> =20
>  	subprog =3D bpf_find_containing_subprog(env, t);
>  	subprog_start =3D subprog->start;
>  	subprog_end =3D (subprog + 1)->start;
> -	jt =3D jt_from_subprog(env, subprog_start, subprog_end);
> -	if (IS_ERR(jt))
> -		return jt;
> =20
> -	/* Check that the every element of the jump table fits within the given=
 subprogram */
> +	if (!subprog->jt) {
> +		verbose(env, "no jump tables found for subprog starting at %u\n", subp=
rog_start);
> +		bpf_diag_program_structure(
> +			env, subprog_start, "missing jump table",
> +			"Make sure subprograms containing gotox instructions are accompanied =
by jump tables referencing these subprograms.",
> +			"No jump table was found for the subprogram that starts at instructio=
n %u.",
> +			subprog_start);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	jt =3D bpf_iarray_realloc(NULL, subprog->jt->cnt);
> +	if (!jt)
> +		return ERR_PTR(-ENOMEM);
> +	memcpy(jt->items, subprog->jt->items, subprog->jt->cnt << 2);

What would it take to change the logic such that insn_aux_data no
longer owns the memory? (Thus making the copy unnecessary).

> +
>  	for (i =3D 0; i < jt->cnt; i++) {
>  		if (jt->items[i] < subprog_start || jt->items[i] >=3D subprog_end) {
>  			verbose(env, "jump table for insn %d points outside of the subprog [%=
u,%u]\n",

...
