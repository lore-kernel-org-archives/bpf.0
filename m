Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9566A355020
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701542; cv=none; b=Of4GeFg0e9Q9iU73te6yNb9UiFsahxm7CgIhqdnClhKPYkmHvKKF8JElNYrtSByJjZfBa1WyrUdnbicqjR/TbG3hjecRw30y8n2cJDNJFC8Q5wdcbLbZ5SEYm5zSD8oT+sqNiemNKtvr7S5oYI6EHWenklmmrVxPyN/POZL5AW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701542; c=relaxed/simple;
	bh=nXKKpVU0EaOuK0WL/FjvLMBDolhz9xqKdL1OufHkpxs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BpXHJMvUJraP8QFfNyJqyvmJ+Lun+w6/fItONAxNP3WHeFfBcHvjDZci4eGiyFb43Ia4313+Wof92awD4V8BnQUrBvK+ZDhjLHrD0gjVdAzKm7CUI0dqVXomcjow+XGettcLgd9Yotl16aNp7mhCxkSskd4CO6yr5oENMDQaTv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNQFh/t9; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNQFh/t9"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12732e6a123so537385c88.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 15:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773701540; x=1774306340; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZgmlfZZe7YWlllpAdANad5O+7C+v/m6YJ647o+2yW2k=;
        b=lNQFh/t9M0HY6QqhfPcLcKuzvXO7lvZEe+5ZEj+m7mmmalpWApEQOQXq4fVlR0xKSt
         GdfVfHnhaGE1DkEAPfw67s/UShMFxGHYivqhFwBbv4kiv82wgE9m9CQ3EBkCiIolzfvW
         VvafzTUZDTC0jaSSeB3okYi8HaX08jSIb5MGON/xxgL+EA24JVPNpkckLaRwUOo1bQyI
         VFRPQbQTjJEKHB+j6yALd/ELHrqWPcDbllGbnk+/yFxB4Gqn0ji8I3z0q1+kdbHTCT4q
         p1SL58UzGWf09KdZuUpctIsIdjuYQe2cFlgHu7Y36oz2Q0AgNvKxMJZLaN8ZnCEvO5lZ
         mhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773701540; x=1774306340;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgmlfZZe7YWlllpAdANad5O+7C+v/m6YJ647o+2yW2k=;
        b=pRIzhRC9QUxfEZW8XC4v1XiFRJuqquX06nmv4fWIU/rBGlECGPvl4yEmk1gjjvF/uB
         CdpbvXFosZw85/Xt9I2T56HAGOErDSYGTgL/+47U3GrtuScWiCV4gvAQe/EkXKVNwEck
         4P2EZDMvNgCr1LbAtOmkjlWjhfcsLOyakRZ416yqbfIYmGgeBbC9YFJD+OIAAN9OhJiL
         VfzJuA+VBwCS3eV2OnTzzSAACUiWTyCum6l3u1L3FNkpd1Xwo3KNr+n3QBHedHWJ9vce
         i3YwliM6k4tbiFy9UdaZ7DeAtrKmpN5Zi4ikCwas1tU+qYJkl9UdYD46Ghys/KJgddMn
         CC0A==
X-Forwarded-Encrypted: i=1; AJvYcCWdHyB8GFXRP7LdJH6LNC8n9SuQw/aV6ch4MokZ3zO54S0XKNGKLRrE7pkrksj2MfSI/M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+lxVOOeJhnj2fQdt3g3pZnYJfVhDJM795FC/ruVNPBa3US45
	r/etUtv1aNVXRYSs8JSm085x5+VFbEvhGtJCyra1zL6+CBLZKGbLsz4B
X-Gm-Gg: ATEYQzw+evNlrU9WX6n+xfjboAhtW2Zk6HjygYem+n5UGczSFC4wd1i94UIpiYreLhD
	PLuNawoptShUzR3xkMploP/jiWE5cv/JPCsoEnPGhcbGoTtvJynKzIMyZNI6rcA82un7GEsvKd1
	v83f52s2T5cqbfDOhZLLE02q7CgsPtGn97tECT+iehy/vShnFPUuCP/WOmZQr64fpDEhLq0lf96
	82jx8eZmPXvOFh7nabt1YD7Zs8HEZteW8kJE8UX5f0Q1bsvdVBmSr2JcVgT34cylZ37NdNSSJGh
	oPqS79YSmOBxhhVK3zzt05qNCMk8kyRb5GFrnO9ZqhedgAtSHIBwchx8dvsUNiTenL80nFbY+FJ
	uPee9EruLNMk57c1c2b4M9SY7AIOH1Kwd+CYSAHoSghxGcocrwhWC1KxJdxWFwu6l7klvhWWcFs
	SovLFOvz+EjrOuO4A9v1mnFLuiATCCyRVtCg1RKBzPcnLcGb3bgCjI5VS90M4=
X-Received: by 2002:a05:7022:7a4:b0:11e:f6ef:4988 with SMTP id a92af1059eb24-128f3df7206mr7239752c88.36.1773701539661;
        Mon, 16 Mar 2026 15:52:19 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::7bc? ([2620:10d:c090:600::76f6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f63baa3dsm16688566c88.15.2026.03.16.15.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:52:19 -0700 (PDT)
Message-ID: <9c6173d7de643bceb8bd35eec185155d4172b123.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 03/11] bpf: Unify dynptr handling in the
 verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kernel-team@meta.com
Date: Mon, 16 Mar 2026 15:52:17 -0700
In-Reply-To: <20260307064439.3247440-4-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
	 <20260307064439.3247440-4-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-06 at 22:44 -0800, Amery Hung wrote:
> Simplify dynptr checking for helper and kfunc by unifying it. Remember
> initialized dynptr in process_dynptr_func() so that we can easily
> retrieve the information for verification later.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -8825,6 +8821,20 @@ static int process_dynptr_func(struct bpf_verifier=
_env *env, int regno, int insn
>  		}
> =20
>  		err =3D mark_dynptr_read(env, reg);
> +
> +		if (initialized_dynptr) {
> +			struct bpf_func_state *state =3D func(env, reg);
> +			int spi;
> +
> +			if (reg->type !=3D CONST_PTR_TO_DYNPTR) {
> +				spi =3D dynptr_get_spi(env, reg);
> +				reg =3D &state->stack[spi].spilled_ptr;
> +			}
> +
> +			initialized_dynptr->id =3D reg->id;
> +			initialized_dynptr->type =3D reg->dynptr.type;
> +			initialized_dynptr->ref_obj_id =3D reg->ref_obj_id;
> +		}

Nit: Maybe fill `initialized_dynptr` unconditionally (regardless of
     MEM_UNINIT check above I mean)?
     Remembering under which conditions it is filled might be a bit
     cumbersome when working with this function in the future.

[...]
