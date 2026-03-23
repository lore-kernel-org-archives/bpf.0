Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C93CCFB8
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294618; cv=none; b=RcHWjNUfSuCuGQH4CEQQzMVyjdIqJhy639T00tcUa8L8eUhqkihMc8VUej40uRpm2CKdnk/4MzUwxqzdcIBl1FhieWiWf5c8EJVaH1EYcczMz7Is5yzvsF8e8BQB8ofiXsr1TjMbNsffVpjbFxBbEtQLny8N7gXebSvDglARnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294618; c=relaxed/simple;
	bh=G9OO2Kv5QeLkbjheI2I74LKjq3DWmT6aVPr5ajNjM4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H3cQjwBms+7oc/P/K5v+71ST3SoK8OEKE+7pVluq5kQ05hMSsbGGFcsBn6km6ByYZByLgydk1EZ5boUNoZPks4z9Nb8e/hoX3yVgPGcNneuvTmunQDMyuhx48Fc29itkCrgv2FIFODbuJK4cLrZjAWjI0KUHKR//zuQe1IGWsPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZfyGPR9; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZfyGPR9"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c0bb213b16so8003772eec.0
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 12:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774294613; x=1774899413; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8XUe9Giyn2Aiul2sBA28hAN4F2Oj8/z3sjfV/nhvfRY=;
        b=lZfyGPR9PiMm5w0twKXxcFywSgWuPAMSM+Lmod5iLh515BNFEG2b6x17/OKvZJTTDT
         qA0mfOeOEZc6tmrkoyp25jqECntmTuz1FktJjhRDOiJGlUVHLN34LkNHYiduLxx5TE8J
         ltygGcZdXN2YfSiXfK0fxwcdNL5tOuJVkKYp8FgiTu/wcmXoYKClMPLKvixdSkQpoLIN
         6qp1q4xGumJyMSZJlugUOYTpCK9VTCGFq7PyW5BdcnYf4vjteR6O8Xke3S7xNzuuoKhF
         Owc5PdDyU5EI7oS2n+Ga+lZJHZKwrBmcAta9I8Dtz1+PsJBCSRpxGZEPr0TE/lLkEeB+
         Ye0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774294613; x=1774899413;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XUe9Giyn2Aiul2sBA28hAN4F2Oj8/z3sjfV/nhvfRY=;
        b=JopA5dKG0qZ4ZGn1vfLkqlmQZb+zP8FPhku+q9K0gTJ7eyiSmrqg+3M8roBcLzcr7j
         vm68MnB4DWyM8EKi8lWDlkKH/N/z4XD4zLD27rrZqbejdSwtcRM2pdjOyXdP/ae+n3nn
         ZXvF5zfEWg1ihI8riCla19/U1SgOUnr5X7P3457BIIbnjt/rl3jC/9ocVcLB5c0ZuqCy
         ts3KVvWXvvs5mSLgBOm9QATJqK6q7nBF6cSQkxXkfQCAfrWc5qH5eXJ7u1258rS8JqWI
         89C9e1PctYoomKIVsOzmx37VF4QMNgOomBY/X2qxYOQNVMWx0n/n2mojACgkxkmY3cXd
         xJZA==
X-Forwarded-Encrypted: i=1; AJvYcCUGcweguhS4l1ItbNU1HZfepdlyKDpQvirUO1tepuw+1KPuqhhK7lOTFB2EnfI7dcz//dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwiiLTf5S5mqNDF1RxgR8BFduPf5AIL0lra0lklN2E9gfKjaTj
	Q6oAw5iQI2vZDtb+gSyogVehyd1o4LWtsjGR97AyC+VtaQMS9ULF9Wqw
X-Gm-Gg: ATEYQzz9Bk7hu9JXLn0W3c65VijNE5jL3Wr2sNEmUL74V+EX0kjqsYP+xmyRAs2eAxh
	W9jhTW560+YIoawIKu89eWno7bURlfkUVfOkpk6UZMmkQZKDm5oVkvi2iXyCfLxVyXPSBUzPb+H
	SBDbjlJUV9svbP2/6E5mac2XgF3IEBL92SXv/b1en7KzC7xZCAzC8/ISwz8u9ODI/HmoNMCjgvJ
	U3ApFXtQ3xbLzFB5GyzFTw1LU+8W4uN8yvAXe2DJxKC3Ic3bhdqIylAA5KAZ3/I4eajqUsabVdh
	O7GyivRvv2bbJcBYZ95o9vJY4T0LYkG9HrgGEonb6oE9cLgFFW4nghbdSGHrE0jTu4sfSdBM4KI
	sxP6bMOyUFGCvVfYzyy9Sw6ocG0M4L25etTOrf12Eu517WGveKPitMbUIa61PGDLKOTWjybvZtR
	XvqnNJArqb01BCdmLcM/84p0x6zzVWVPcpRcMD4S6Idda80OSU6Wl81oKQlLtR9BwyyE9GJ30UM
	iqO4Pc=
X-Received: by 2002:a05:7300:a287:b0:2be:617:2dec with SMTP id 5a478bee46e88-2c109710f75mr5178066eec.17.1774294613439;
        Mon, 23 Mar 2026 12:36:53 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:45ca:895c:22d:457a? ([2620:10d:c090:500::2:8b17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14c99bsm13255302eec.1.2026.03.23.12.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 12:36:51 -0700 (PDT)
Message-ID: <ada028bf2621bd489a09aa41cdd449cb160fbad6.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Support 32-bit scalar spills in
 stacksafe()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com
Date: Mon, 23 Mar 2026 12:36:50 -0700
In-Reply-To: <20260323022410.75444-1-alexei.starovoitov@gmail.com>
References: <20260323022410.75444-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-03-22 at 19:24 -0700, Alexei Starovoitov wrote:

[...]

> @@ -20020,12 +20020,12 @@ static bool is_stack_all_misc(struct bpf_verifi=
er_env *env,
>  }
> =20
>  static struct bpf_reg_state *scalar_reg_for_stack(struct bpf_verifier_en=
v *env,
> -						  struct bpf_stack_state *stack)
> +						  struct bpf_stack_state *stack, int im)
>  {
> -	if (is_spilled_scalar_reg64(stack))
> +	if (is_spilled_scalar_after(stack, im))
>  		return &stack->spilled_ptr;
> =20
> -	if (is_stack_all_misc(env, stack))
> +	if (is_stack_misc_after(env, stack, im))
>  		return &unbound_reg;

unbound_reg has 64-bit bounds set to corresponding 64-bit min/max values.
For a 32-bit spill, suppose that old state has a SPILL and MISC in the slot=
,
while new state has all MISC. This would lead to a
regsafe(old_reg_with_32bit_bounds, &unbound_reg),
which should return false. This is safe but conservative,
maybe add a notion of unbound_reg32 to cover this case?
Idk if this would have final veristat impact.

> =20
>  	return NULL;
> @@ -20043,6 +20043,7 @@ static bool stacksafe(struct bpf_verifier_env *en=
v, struct bpf_func_state *old,
>  	 */
>  	for (i =3D 0; i < old->allocated_stack; i++) {
>  		struct bpf_reg_state *old_reg, *cur_reg;
> +		int im =3D i % BPF_REG_SIZE;
> =20
>  		spi =3D i / BPF_REG_SIZE;
> =20
> @@ -20065,18 +20066,21 @@ static bool stacksafe(struct bpf_verifier_env *=
env, struct bpf_func_state *old,
>  		if (i >=3D cur->allocated_stack)
>  			return false;
> =20
> -		/* 64-bit scalar spill vs all slots MISC and vice versa.
> -		 * Load from all slots MISC produces unbound scalar.
> +		/*
> +		 * 64 and 32-bit scalar spills vs MISC/INVALID slots and vice versa.
> +		 * Load from MISC/INVALID slots produces unbound scalar.
>  		 * Construct a fake register for such stack and call
>  		 * regsafe() to ensure scalar ids are compared.
>  		 */
> -		old_reg =3D scalar_reg_for_stack(env, &old->stack[spi]);
> -		cur_reg =3D scalar_reg_for_stack(env, &cur->stack[spi]);
> -		if (old_reg && cur_reg) {
> -			if (!regsafe(env, old_reg, cur_reg, idmap, exact))
> -				return false;
> -			i +=3D BPF_REG_SIZE - 1;
> -			continue;
> +		if (im =3D=3D 0 || im =3D=3D 4) {
> +			old_reg =3D scalar_reg_for_stack(env, &old->stack[spi], im);
> +			cur_reg =3D scalar_reg_for_stack(env, &cur->stack[spi], im);
> +			if (old_reg && cur_reg) {
> +				if (!regsafe(env, old_reg, cur_reg, idmap, exact))
> +					return false;
> +				i +=3D (im =3D=3D 0 ? BPF_REG_SIZE - 1 : 3);
> +				continue;
> +			}

Did you try generalizing this to 8 and 16-bit cases, is there any veristat =
impact?

>  		}
> =20
>  		/* if old state was safe with misc data in the stack
