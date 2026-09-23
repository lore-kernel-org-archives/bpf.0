Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83048097E
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790205032; cv=none; b=Q4XG3rre95sjdd4F0MP2bYJv2VE1fPaULHGzM1sCnGlDeNoAme9wqCaiGYv9H9P5lv1oNMG78YXIaam04JjOcLHxdUfYX01A+Jy/yPL0X6anIFtKs6qrFlQ7lb69gBZ1Ea8Bm1TXRFxVpqwsFSk51QfHRQpVtXxU+1tqeeidiQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790205032; c=relaxed/simple;
	bh=3NLn+OwZYpU6YUpRVwt7i3swJelfOUsu38cF+3/AWso=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=puUyV8ucsfzucxTHS3IU4SZEb/WgAsOadqRMtGzVfXBPYrc75WKeD7luwBKWlYze98O8lduPXtlEdThVxvxel7C1SW4qyHCFV1Jb5L9PXyCFD6A0Y5YBTgbu99KHNj7oD+/AmDr6tfcHiQ7YNPmxgmpDcNk30BwvJRf5jsBeWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJZXFiGp; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJZXFiGp"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd04edb5so2534914c88.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 16:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790205030; x=1790809830; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NgaLVtz0Js5HxxTJnEsxeclN7ItX+SGAGboQhEwrbCA=;
        b=CJZXFiGpIB8EqzAglPd/I7n4k7PHEjbvEMD5NipWOF7iafx+s07xRfLHViOQF60dIq
         zZUXuOvwlclJ5GFmAz/sHed5h1dQgUEerHT6MuuZsTtoXE05zKcy96kIwbZYbBEXbNTT
         e6vBv04M9TCBVP65JpJfVG6c5K5RDMO7bjUgucmdRANrqWE7XOEDAfePGdkcVogKTIqF
         Re01KqSsO/5Iq9/+d3zqaRUNXXZWWVs0mSZe2+A3yByYfaMbslCcLDzYQ5lZfmZqM5Jr
         Hz8fRgInqg1q8yPwoaam5j/RPLRq0HMri7hMw834Jbigp4u/9wsvg1I29cO9H7bxWJ39
         6KWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790205030; x=1790809830;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgaLVtz0Js5HxxTJnEsxeclN7ItX+SGAGboQhEwrbCA=;
        b=gkHHVp+GDAO25HGOTDYIlF2fRgCSu/eVoz/jBJmNGBa8LAXsegYxn5sX0EOwGTxScN
         oKowSL2QnS0074myRvE59jEq9h4uC5OJmDwlCzgAedMbEqpzVPrLZIr7zYRUKpPQhO2u
         XKUiDVQT2gAho2Uoj4zR4C39/UziDkVWM3Aky4SGWDkjYBcCrouIs68W16uVQL+t6arJ
         szGU3UiSdJtdwBeoP0DsFRUzl4AkbuODAVC55rdSNGAUmQBGLwM+B85FnRmZ8JuxkKsI
         x6rEk4dZ1f/Ilz59vSWPbM6n08tYRG5OtHsL0Qd0xwD9Z/tn2SZKPyicia9Z7tUlU5ox
         VC7A==
X-Forwarded-Encrypted: i=1; AKwUvBzfR5WUzttVVXdHC89QVooH5ZJB4a1m6dP9bvmg/LUi1yivV6mSjiGC6wDD24p7ToEmSUA=@vger.kernel.org
X-Gm-Message-State: AFuF++nRawfwk2885ZHhyx6jig7PvKl2Y0Yeq1mv/UlTJqpR30YBY1C0
	c+uO6DhpX7Q6wjC73NHGeKg4FdekI8/h5vbEr9/qHYTsEYDe5EKmgJdt
X-Gm-Gg: AYBFou3HI8q+vNgtSfIstkgcTZNWgY6vq1PomBDxcKPJvJ/JJiFwnIEuYrR8h3JFyDT
	paQU5rurhY2IoiEftkw0IgG4Km11c31N0OTetqop0Ce6KuGfT49s5nJ6qO0W6TppWnaxv8+RSed
	moyZJrvxjMVWmdio9k7O9YntK9GRjMhQWMk2nixNDbDCrmdDeqh/DVFJ/qI5Vd3Iv9jigFrodbN
	ZLU0Cm1LZ2YDyMlVm2EIfJQuoI9eOwid8K2ULnLOrZ20FL+mB9hMmmB+d+eixn0dLberyLfMapt
	RsHzdlFeiIQvEuEYfqFtVfLwCXFcUyp186pEqzVJCzActA8OYLcF3nnQOfjrzg3QKvv5lHZGsJT
	YcGM50uvlWUQueycUDlks4ljxhoZ523g6RW0rQSxtkkE0xgAZgUt9ZXZL+QVSXPiHm03MrCrldK
	SDYkClxTQLpnDuaEd99tkBfeDttQ/3aZQ/fgt8SaXAbiaJSOjpLn/QxWkAEyBB+ZODCOxas+d9u
	2jHiYNyFp+p6IiHn6LTy3DuxvnxDSwF/YZmMdYWsSC4LcgzmmTTNXao3Q==
X-Received: by 2002:a05:701b:280f:b0:143:7330:7fbc with SMTP id a92af1059eb24-14503fb7d58mr366727c88.21.1790205029911;
        Wed, 23 Sep 2026 16:10:29 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:179a:a128:9d0d:40be? ([2620:10d:c090:500::5:48f8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f982089fsm8534040c88.5.2026.09.23.16.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:10:29 -0700 (PDT)
Message-ID: <7917b7dbfbc2d206b0b4c22d2352f5b4700125f0.camel@gmail.com>
Subject: Re: [PATCH bpf-next 04/17] bpf: Prepare static analysis passes for
 callx instruction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, 
	a.s.protopopov@gmail.com
Date: Wed, 23 Sep 2026 16:10:27 -0700
In-Reply-To: <20260922011323.1298619-5-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
	 <20260922011323.1298619-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 01:13 +0000, Alexei Starovoitov wrote:

...

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 44ecdc5b4ec2..5aa2f68d92b3 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

...

> @@ -394,7 +407,7 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *en=
v, u32 frameno, u32 half_sp
>  		/* Get callsite from verifier state, not from instance callchain */
>  		callsite =3D q->callsites[i];
> =20
> -		alive =3D bpf_calls_callback(env, callsite)
> +		alive =3D callee_stack_access_at_callsite(env, callsite)
>  			? is_live_before(instance, callsite, rel, half_spi)
>  			: is_live_before(instance, callsite + 1, rel, half_spi);
>  		if (alive)

I don't understand this change.
The original reasoning is that callback calling function can call the
callback many times and the callback might access stack slots from
outer frames. Hence is_live_before(... callsite ...).
callx only calls target once.

The rest lgtm.

...

> @@ -1533,7 +1554,8 @@ static void print_subprog_arg_access(struct bpf_ver=
ifier_env *env,
>  		bool has_extra =3D false;
>  		u8 cls =3D BPF_CLASS(insns[idx].code);
>  		bool is_ldx_stx_call =3D cls =3D=3D BPF_LDX || cls =3D=3D BPF_STX ||
> -				       insns[idx].code =3D=3D (BPF_JMP | BPF_CALL);
> +				       insns[idx].code =3D=3D (BPF_JMP | BPF_CALL) ||
> +				       bpf_is_callx(&insns[idx]);

Nit: it was BPF_OP(.code) =3D=3D BPF_CALL in the other hunk

> =20
>  		verbose(env, "%3d: ", idx);
>  		bpf_verbose_insn(env, &insns[idx]);

...
