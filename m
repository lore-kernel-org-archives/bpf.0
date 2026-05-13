Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6315D3890F7
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714632; cv=none; b=jR4K3GeM/7KBnT8yClVtmyRBcBkwELWqWEXjXc2QUDgpqV+ajOCFAsXLBXbrYyh7aCfHIW5TMmmXEFYfP06yil+zs7aUaV5g2hUlwcCZ805kpFN459mQ4HyUXwrOGQxjBMFamWvN8VwbGyc7IN5TnYOPQleo9XrDq7DPfFE8NQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714632; c=relaxed/simple;
	bh=4I22Bdw5feozE1w3IkUCauRaA4BWSUlskbxtRRDl0yY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AUpW+l/QQIltI0NTuz5BHXUg1/sLD5Ra1Cnf3+eCc/mp5jL62nsd4aShpeb0hP7ucCV2P0otD3iLOxjo5I+Pmk9PrKyICYd4oIbZ9r1hFTA9k6d6qVcbaX+ErTGymFISYe45Jr7f3f4r2hRzY97mInX4qtTBwQq54Oq/1WOSPlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0H0nu18; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0H0nu18"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1334825de43so2939430c88.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 16:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778714630; x=1779319430; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=11doEEY+kOTChPueO2pp1ReKbp1yZ6d6L7Lsv6EFxGQ=;
        b=b0H0nu18X2gnl+m9lDLxjAV/LC4ISc0DW9BCO0U9r72D/qjeP+Pj9JrW5TUsP4oujK
         sV28f76y6qh4GLhedszlxFpePaUykBJaMpyJsUFXxLfWhgArvK7U2XHqh9c+SRKMbHwY
         f90lDmFikj/nRvwYKrDbXnln1C79VzmhjaqG5xLIo+Q2oMmcWE4CKYuiYa+SiP6NoXVA
         vJsbRRi6mHAz9/qgr8+XKYNbUNryWPN25CxeaEHxCGmu49K3kCHzPKR74DrbzbWXczL8
         RMyIXw4LVdhzSmkGh1GsIX3D5sT76mcl1IVCia9vOiqT2jX2DJKM+X9RuuexlsPM2O5U
         5boA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778714630; x=1779319430;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11doEEY+kOTChPueO2pp1ReKbp1yZ6d6L7Lsv6EFxGQ=;
        b=rEp+5sBR7kg5B7O+ShR9xipROnVGuSPgfn4fiQOTmp+VSkbm/5xWgIMgGOF0Ilt3dp
         yg5jJP6EVlarLqqjZZJ5ocnaXaxgxSYUhr5Or4gjVtya1PRTLiLOY93jPddBIiRVuHij
         YPX1LiLK2/HcI+Hpf+zCNCMn9PE6G7PyW5INdz5WC+lFjtuN6qiDx6wOUtSAx/FlvwDm
         7wwx4qdxMVcmxCypa2IY9WDXKC0RfUmbUWNoGQE0EcWKknPi/F4L8RIjOyPkp29WZT/G
         HFIm5gBk7JqpM4lPZQNXJnntOhLU8lUvwglfgLkZQUzEilNgjHbFsdOfjP4rIWtT2YpM
         0yQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/9GQzenoUtca3UTKjy/jqr/6q57s8qOPrD6cirBl7s16MjYJncAtsqEpPlx9NLJqATEIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8PHCpLY/TU9g/UQJcE8XtQor+UW3XlhbYp/2M7mh4AN6Cp+Y9
	H9IO6PDu4rtu2rGKVACwEmVFRmRNFKDd4C7DmeVTIGO4YkNO7pbejQGk
X-Gm-Gg: Acq92OGMQ6HcQ3iyyDbdSY8kR1xu/a/wPcpv918WmNia/pLFMk7lMYeUMrIfo3fMDgm
	7MfCPHKzmQwWxcf7jd3Dt7/W03XmiCBQ4E3gkCeyD4R36hTc0n0o/EAUFLcPQxx2G+3ncTs6cP+
	9VlgRSVH8OcAyvdEHoH1+29EMD2IsO29voevH4jx1/r/sfifHpus+Gc1jR+MIBn3kT3NbJYTb+d
	kJRLEBlQp3uylYVZjuQFCCqXDcpXeEKCykNODi5T0xE3nhhD0hFY7bt/BEU8EHx724Z5vL6JGsu
	vOztrIhgFRnSyWWXW2tYhjdj1A4DzljygCpDhOWSfCmpYLQFXJghBXyHw6notJYs+4NXzZVzqEA
	EllM7zvOQQlKJZdQKJWjBAa6eCaipAK21wCCLa2Aviw1ia3p/GpebcTFe8EvGe4fKcDRFJFaSnh
	fMHu1Nv8+r1qoV/UHbEluoY5mtz+0eY0G4h7tRMzlvgqcqsBSPxJAqQ1VDmHIeM7MJ9GW0vGiuV
	nrZEP0=
X-Received: by 2002:a05:7022:785:b0:12d:b2e9:b20f with SMTP id a92af1059eb24-1343699ec42mr3444812c88.21.1778714630427;
        Wed, 13 May 2026 16:23:50 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5152:641f:f5ef:6c7b? ([2620:10d:c090:500::2:8a9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33aac9sm1132923c88.14.2026.05.13.16.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:23:50 -0700 (PDT)
Message-ID: <fe8bedbcf7a9c0b3af7c92351a694784804f7e82.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] veristat: Report max stack depth
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 13 May 2026 16:23:48 -0700
In-Reply-To: <a27ed8f336669152c4b1b05e920aee4438e3e2b3.1778700777.git.paul.chaignon@gmail.com>
References: <cover.1778700777.git.paul.chaignon@gmail.com>
	 <a27ed8f336669152c4b1b05e920aee4438e3e2b3.1778700777.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-13 at 21:35 +0200, Paul Chaignon wrote:

[...]

> @@ -834,6 +835,7 @@ static struct stat_def {
>  	[SIZE] =3D { "Program size", {"prog_size"}, },
>  	[JITED_SIZE] =3D { "Jited size", {"prog_size_jited"}, },
>  	[STACK] =3D {"Stack depth", {"stack_depth", "stack"}, },
> +	[MAX_STACK] =3D {"Max stack depth", {"max_stack_depth"}, },
>  	[PROG_TYPE] =3D { "Program type", {"prog_type"}, },
>  	[ATTACH_TYPE] =3D { "Attach type", {"attach_type", }, },
>  	[MEMORY_PEAK] =3D { "Peak memory (MiB)", {"mem_peak", }, },
> @@ -1023,7 +1025,7 @@ static int parse_verif_log(char * const buf, size_t=
 buf_sz, struct verif_stats *
>  				&s->stats[MARK_READ_MAX_LEN]))
>  			continue;
> =20
> -		if (1 =3D=3D sscanf(cur, "stack depth %511s", stack))
> +		if (2 =3D=3D sscanf(cur, "stack depth %511s max %ld", stack, &s->stats=
[MAX_STACK]))
>  			continue;
>  	}
>  	while ((token =3D strtok_r(cnt++ ? NULL : stack, "+", &state))) {

Thinking about it some more I think that the meaning of the
STACK/"Stack depth" metric should swapped for max stack depth.

[...]
