Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCF59463
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 00:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780358767; cv=none; b=gvpc7VWETtzAvngqv+NBRwd2J5yQMUhrzZFCMrbeovcxCUsWaFAiKNTJAP4bDwaZlxFZwM4O8UKSX4ZM0P14+izmsQXzh/QCHahsJiB1DrSsyS/HqeU7BqXSfdzm1Hil8ukBK8jw5xc7JPbqDc+Yyy3H7XRth0Hs63vr+VEi/rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780358767; c=relaxed/simple;
	bh=PweQGBIL1pYRzmfVucCxMwWekb4ZzoEYQDjetUU2SMg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ATjjllBopXBJmOVQFIqCTXP54WG6IXkFPoOswLjFQf9duXv6Vl7QsUObkZ6R83vpQby054TKIovJfSyBhlXHf3mGg3rWNPN1iSFd1QUyHqWVgwl5taIzTCNRQb/6v4y+oqACsWHeo4oBXYlAxuHH6ytemtytQyjvaw9dWYidlMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=EOJiyuUR; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="EOJiyuUR"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1363fe80fe8so12855843c88.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 17:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780358765; x=1780963565; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci20U7/CwI1HlqFELtTDo4S/28rEdlOYWeys8HmbRS4=;
        b=EOJiyuURkGgDhSADsUe9v4My4BRaODaX19GU52T62zC/YV3/kiv36cP2DwHCQ/jRkx
         kjRpjyVeC4jUtLEYok3jlIHjNgh5KQir9DqycclxlhgzT9zJDh8XoDAW2qBP6XKKxwGf
         pPjgjpPkuSOWs7Y04eiTRNgB6nsI13RUXbeUd9orxTDkaX/cH+FZArk+JI3iHq+W4Ptt
         iYG+pKVxIsbHcc0O3NVlD5WyniYyaf80+6Xkc4wayr40tnuLq4bA3c0Tk/6Gc6qMVsGl
         ES7evUBVP+drFTRHPyZ7RAevgDU8MaVnnMkQeCilxXXz8kmbSu73uEWlfy83Z226xgEe
         2TTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780358765; x=1780963565;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ci20U7/CwI1HlqFELtTDo4S/28rEdlOYWeys8HmbRS4=;
        b=foc07RbmLZlHSggOes7TuMA1i1bkHXq811WnRoi/r4ovbuYeRo4ur7jvf2AFycksAB
         ISGeiql0aZii2JcUtUyOY0aqd9ecGg5QGOLa7bdLQ4yyOntEQaXsuYXxeKSpqtMjTN+3
         Qy+ha1NxzPAgB7+s6LftHO1CwF2FogRMixmF1r/9i3GeXj/tN5CwGY+mGRDagFTmmAtR
         LzcwspRfeiWCFBmyxOknoNNk/lfC/vvOcAfVw61ln11MoeB/vBZoRZUIMB7kG+ldUzx9
         BuAnyx4w+ozMus3VM79Uy6e4/RyVbbvhMjbEJQbbz0f1DdZAHSXXPx78QsFZU4FnJBVB
         zwyg==
X-Forwarded-Encrypted: i=1; AFNElJ9lfo4BoYiwLQ4HvEvtEBVm/Kij61W4m/y99/nqCClDocuZ9DBK7eKIDoi3onu1Yf5oGyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTfwa5RIqrQnJmsGvJSk9cWHZP2djS50Qr9bPcqsKI47FlEIwL
	z5YIkKpiBM6eFSAgbsgcZGaNBrOgKlScNCcwJ01Xvhrre1qt2ZQBAoS2CSNZZIumFnc=
X-Gm-Gg: Acq92OFwLhKkO5nSxxiDbB6Ah14nd+DopOZQh/CrhvhJa5v9DWiJEIxgTu25SFyFAKW
	ARwrdWQLg3OA4soRKYkpg8RXWrmyDv+GnzTrvH9o73kz82icsT2glfn3kAfHaPfj/TzLIw8AsoF
	X1mjZISJWm/HetWPPswPGc17EoETtOuw9OCQsnEWIHs2cnAEGZAQdhLTIWTyVvObxyADaJcu5ga
	ZHrftvBrirxdcn2qdotli26hPQqqu7Ot90S/xj/AV4uF49lGDF6xq2jffmlztDA27uCnScWD+0/
	p0gPUa5RI9SuW8Vh321oSuIpml7KtP23+qWzP3gONBFdOmjchYErjjkuFYmYbvRvH/TNG9h6ul3
	3kH77jmKxN69Iq7zCd6fHU0TetRLPnFVfRCjB3ot6+omW/1hFWHnd2qaoNYHeqQ0ZLLQiWDwyEo
	x3OL3ZJKjOQmYJADF5sGtrfyqiCY5fNynyEw==
X-Received: by 2002:a05:7022:68a0:b0:137:ea56:358 with SMTP id a92af1059eb24-137ea56089amr1610145c88.30.1780358764521;
        Mon, 01 Jun 2026 17:06:04 -0700 (PDT)
Received: from localhost ([163.114.132.129])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b2d04287sm10279590c88.0.2026.06.01.17.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 17:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 20:06:00 -0400
Message-Id: <DIY4IBKVGHDL.2CV4GP5GI4UQD@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <song@kernel.org>, <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next v2 3/5] bpf: Allow subprogs to return arena
 pointers
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260530002259.4505-1-emil@etsalapatis.com>
 <20260530002259.4505-4-emil@etsalapatis.com>
 <cba7e9dcfca6fd091d831d24eff2cca66e5217e9.camel@gmail.com>
In-Reply-To: <cba7e9dcfca6fd091d831d24eff2cca66e5217e9.camel@gmail.com>

On Mon Jun 1, 2026 at 3:01 PM EDT, Eduard Zingerman wrote:
> On Fri, 2026-05-29 at 20:22 -0400, Emil Tsalapatis wrote:
>> BPF subprogs currently only return void or scalar values. However,
>> it is also safe to return arena pointers between subprogs in the same
>> BPF program: Arena pointers are guaranteed to be safe for both programs
>> at any point. Expand the verifier to permit returning an arena pointer
>> to the caller.
>>=20
>> The main subprog is still not allowed to return an arena pointer because
>> arena pointers are internal to the BPF program, and the return values
>> permitted for each main subprog depend on the program type anyway.
>>=20
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index c6a930aca67e..7a8101879f84 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7880,6 +7880,36 @@ static int btf_scan_type_tags(struct bpf_verifier=
_env *env,
>>  	return 0;
>>  }
>> =20
>> +/* Check whether the type is a valid return type. */
>> +static int btf_validate_return_type(struct bpf_verifier_env *env, struc=
t btf *btf,
>> +		const struct btf_type *t, int subprog)
>> +{
>> +	u32 tags =3D 0;
>> +	int err;
>> +
>> +	err =3D btf_scan_type_tags(env, btf, t->type, &tags);
>> +	if (err)
>> +		return err;
>> +	t =3D btf_type_by_id(btf, t->type);
>> +
>> +	while (btf_type_is_modifier(t))
>> +		t =3D btf_type_by_id(btf, t->type);
>
> Nit: btf_type_skip_modifiers().
>
>> +
>> +	/*
>> +	 * We allow all subprogs except for the main one to return any kind of=
 arena pointer.
>> +	 * General arena variables are not allowed, since it makes no sense to=
 return by value
>> +	 * a variable that's on the heap in the first place.
>> +	 */
>> +	if (subprog && (tags & ARG_TAG_ARENA) && btf_type_is_ptr(t))
>> +		return 0;
>> +
>> +	/* We always accept void or scalars. */
>> +	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
>> +		return 0;
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
>>  /* Process BTF of a function to produce high-level expectation of funct=
ion
>>   * arguments (like ARG_PTR_TO_CTX, or ARG_PTR_TO_MEM, etc). This inform=
ation
>>   * is cached in subprog info for reuse.
>> @@ -7963,17 +7993,15 @@ int btf_prepare_func_args(struct bpf_verifier_en=
v *env, int subprog)
>>  			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
>>  		return -EINVAL;
>>  	}
>> -	/* check that function is void or returns int, exception cb also requi=
res this */
>> -	t =3D btf_type_by_id(btf, t->type);
>> -	while (btf_type_is_modifier(t))
>> -		t =3D btf_type_by_id(btf, t->type);
>> -	if (!btf_type_is_void(t) && !btf_type_is_int(t) && !btf_is_any_enum(t)=
) {
>> -		if (!is_global)
>> -			return -EINVAL;
>> -		bpf_log(log,
>> -			"Global function %s() return value not void or scalar. "
>> -			"Only those are supported.\n",
>> -			tname);
>> +
>> +	err =3D btf_validate_return_type(env, btf, t, subprog);
>> +	if (err) {
>> +		if (is_global) {
>
> I understand that this is how it was implemented previously,
> but do we report a sane error if non-global function returns
> non-void/int/enum?
>

TL;DR for non-statics we consider the signature buggy and stop using it,
which seems to only matter for tracing/ext programs, and even there it
doesn't always make them fail.

I looked into this a bit, we are reporting -EOPNOTSUPP on all error paths t=
hat ends
up marking the subprog's BTF as unreliable. This prevents the function
from being EXT'ed, and forces the JIT to spill more registers in the
trampoline for fentry programs (while also loses all type info about
them). I don't think we need to add anything more for the time being on
the handling.


>> +			bpf_log(log,
>> +				"Global function %s() return value not void or scalar. "
>> +				"Only those are supported.\n",
>> +				tname);
>> +		}
>>  		return -EINVAL;
>
> Nit: 'return err'?
>
>>  	}
>> =20
>
> [...]

