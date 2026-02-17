Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AEC2D0C9D
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771369083; cv=none; b=uSbj4p+OCIhdJARUmzJWLP5HMeDt0Oyv3of+Oyyeu+xioblFL0c0C/4hsTARIIy/7kUAkSGVqapMBH6xD9rg2y5JP7H17/gaKhVGEV7CzKcjU/CoBTmneI+7p4L2FZfhdNo8w+hNcNWjFDv1Fc3WRjiHd5KdRWTJDgr5J3KzTxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771369083; c=relaxed/simple;
	bh=9XrtBsod0I/3fBhcyEq8mH3xVwvu4zQF14+8RTeoPOY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=smScctgOzThUQsmWSrcs7qVkP3aK2ljvIy5ZK0COAlI/ShuxYGW29dUxsir4Pux3rR06ZFSM3FaX3QARrWUXKUMcPBU5p3XGhsNW4R91PRjbctpLbAesecWvoZz2fb1xuuUmF9lVD+O600RpynoLHtCadSpFBx43B+5vt6tIDrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jR66r0Ug; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jR66r0Ug"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b740872a01so10340545eec.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 14:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771369082; x=1771973882; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QBVt90Nt5jqou80A9zdI53ouVfTUp0C4JYiSzNZSvnc=;
        b=jR66r0UgzuO0fqcILDUnyYB3BtZdWEvK6Ys8zFPpChxKMLQ83UU3pmYvQHSkVylCPy
         s0BPB73Z1b7Ate1558iNkIgWKjRYEGUUCIE8luXGn4QnhPM76OizZfkVRkjc3YwkigX8
         YwXLfhODWF5H4uK6bzo39uL3KiwEYX5QahSdmlL243zt+KMvhKHXsbs/1dPujiTjfaIf
         MlKSldIpkI6fNqVXEMoeTg0FxklrS5KTRKxfE4LbOzB0eeXTfOlWB6/U67xAFI+BIRrz
         zeHiHBJfPnhsVvcH6MxRx4uzT1UHeUV3NUswJv/3Sosc4Np4s5aYYG28VaG6ZEp2G948
         UBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771369082; x=1771973882;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBVt90Nt5jqou80A9zdI53ouVfTUp0C4JYiSzNZSvnc=;
        b=qGPQd86HaIK1dHE42fentdZDuA+HJSG6drcG7SWIiRB7zKi/802TSCzs4Q474Au5fF
         w3qZgp+QZsB/tO8Xet4aBB+pjSZkuauWFrjarF1oK6rP91NXjtcOSASgG7sjz075vgSG
         9b6kUF4TAFe+X6pJd1Fc5wTEGkdF/g8AzebrsNnnSTBKY/9PXITTQ2l4S504ZxK7Ui9l
         M5j6Qjdc+gbMJgKcwrxBZ3YalnPYsJwN7vtjpchrFsVfyqmvAagHZT+0pchbz8AzoHOh
         oP4VGP7HNckEiv3BBDzH2sa3lNlTXVYAE5EIAk1urSwE0zEEgY4dzrucQoMMCdALURA1
         Zuqg==
X-Forwarded-Encrypted: i=1; AJvYcCWd5CPNchOB/rHJWiyQSX8FmrozNIwjc26u02pSMCW5s4v9WsCnWg8uq/VUiFatuaObfnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz/1JqbYxHc+/SpsD2wc6mtSUw0dDd/NktrOT6bH/cybmEzVfO
	yTN4E76hAizzQ5M71moSLpfES7FCS/SeK+vElF4LG17S7gLK/rz1Ehkz
X-Gm-Gg: AZuq6aLJJzGKU81m9pfVZnOAvHs9mKhE32670fxw2jzpuP/nx3pCSabE0mxR5xPtOKC
	1ffXo0jbX2Sk8Sp8DQfGuBhvqUFDghupltABdU/Hnsf0svXGQyJdIMYG/3RbB6Ski4Hru9GVtvg
	DoYgnMY6yXEgzdustwCjqvGcpGxGDDrJSmLbcQV/+ep0v+SB1vvJfVHeLE6ssnL2pSz0NWrNFvk
	K6tzfpzVjYDwqeJ+tYjXQ8nLMHPGzRVPk6kMIkeBsjIbtsuHKpWZkWT7P++sCB/q+LPYrQp/Diz
	j4LnUh30ifJkbXnCAZMcVwn9/QCy7cL8vVRq5D9lnLL7T0eY8ukMLrRFXjulRwvsntpwyonWBeb
	stOZSJweHGdWljt5dgY0clNR2o0Z8PJ3vUA/yqJoy43JdIxkHmcFNvUeaVV+IXkYyLw+nDhSHcj
	1/wrLaWhX5Zgqrr9zvGZGGh8jBv76r+R0k7aDr27XY75YYPs3ULFJ/xesrTYYAJOyM/llHs6ABp
	SYiX/gL3qzxgqTHbw==
X-Received: by 2002:a05:693c:2d88:b0:2ba:7783:d1cd with SMTP id 5a478bee46e88-2bd5004bc7cmr83017eec.12.1771369081669;
        Tue, 17 Feb 2026 14:58:01 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:ea8a:2651:c8f:99eb? ([2620:10d:c090:500::3:3a6d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb658fb9sm15805045eec.20.2026.02.17.14.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 14:58:01 -0800 (PST)
Message-ID: <12705b3d58569685048804c33e90755c17667cbf.camel@gmail.com>
Subject: Re: [PATCH bpf 2/4] bpf: Improve bounds when tnum has a single
 possible value
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Harishankar
 Vishwanathan <harishankar.vishwanathan@gmail.com>, Srinivas Narayana
 <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Tue, 17 Feb 2026 14:57:59 -0800
In-Reply-To: <5299e75f8807c7c49ec048e821f25a6dfef2c6cc.1771316309.git.paul.chaignon@gmail.com>
References: <cover.1771316309.git.paul.chaignon@gmail.com>
	 <5299e75f8807c7c49ec048e821f25a6dfef2c6cc.1771316309.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-17 at 10:01 +0100, Paul Chaignon wrote:

[...]

> This patch uses the tnum_step helper introduced in the previous patch to
> detect the above situation. In particular, three cases are now detected
> in the bounds refinement:
>
> 1. The u64 range and the tnum only overlap in umin.
>    u64:  ---[xxxxxx]-----
>    tnum: --xx----------x-
>
> 2. The u64 range and the tnum only overlap in the maximum value
>    represented by the tnum, called tmax.
>    u64:  ---[xxxxxx]-----
>    tnum: xx-----x--------
>
> 3. The u64 range and the tnum only overlap
>    u64:  ---[xxxxxx]-----
>    tnum: xx----x-------x-

Nit: please put these diagrams in the source code.

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index dbaafb64d3bd..c4478c874616 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2379,6 +2379,8 @@ static void __update_reg32_bounds(struct bpf_reg_st=
ate *reg)
>
>  static void __update_reg64_bounds(struct bpf_reg_state *reg)
>  {
> +	u64 tnum_next;
> +
>  	/* min signed is max(sign bit) | min(other bits) */
>  	reg->smin_value =3D max_t(s64, reg->smin_value,
>  				reg->var_off.value | (reg->var_off.mask & S64_MIN));
> @@ -2388,6 +2390,20 @@ static void __update_reg64_bounds(struct bpf_reg_s=
tate *reg)
>  	reg->umin_value =3D max(reg->umin_value, reg->var_off.value);
>  	reg->umax_value =3D min(reg->umax_value,
>  			      reg->var_off.value | reg->var_off.mask);
> +
> +	/* Check if u64 and tnum overlap in a single value */
> +	tnum_next =3D tnum_step(reg->var_off, reg->umin_value);
> +	if ((reg->umin_value & ~reg->var_off.mask) =3D=3D reg->var_off.value) {
> +		/* The only overlap is umin */
> +		if (tnum_next > reg->umax_value)
> +			___mark_reg_known(reg, reg->umin_value);
> +	} else if (tnum_next =3D=3D (reg->var_off.value | reg->var_off.mask)) {
> +		/* The only overlap is tmax */
> +		___mark_reg_known(reg, tnum_next);
> +	} else if (tnum_next <=3D reg->umax_value &&
> +		   tnum_step(reg->var_off, tnum_next) > reg->umax_value) {
> +		___mark_reg_known(reg, tnum_next);
> +	}
>  }

I think this hunk should be rewritten as follows:

        tnum_next =3D tnum_step(reg->var_off, reg->umin_value);
        tnum_max =3D reg->var_off.value | reg->var_off.mask;
        tnum_min =3D reg->var_off.value;
        if (tnum_next > reg->umax_value) {
                /* The only overlap is umin */
                ___mark_reg_known(reg, tnum_min);
        } else if (tnum_min < reg->umin_value && tnum_next =3D=3D tnum_max)=
 {
                /* The only overlap is tmax */
                ___mark_reg_known(reg, tnum_next);
        } else if (tnum_next <=3D reg->umax_value &&
                   tnum_step(reg->var_off, tnum_next) > reg->umax_value) {
                ___mark_reg_known(reg, tnum_next);
        }

- At-least to me, it easier to understand this way.
- There is no need to gate the condition `tnum_next > reg->umax_value`,
  if next tnum overshoots the reg->umax_value then only tnum_min is left.
- Accidentally, it fixes the scx_cosmos regression
  (probably, because first condition is relaxed).

Wdyt?
