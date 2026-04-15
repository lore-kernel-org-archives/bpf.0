Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A79212566
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277852; cv=none; b=FAIf/Xa7sFfoSoH9Pm3TmWwoMU3jtpnJrqb9V0ZoSlSY7psWua8kUbOwm9yT+HVawajpqGJNBhEH4daYo/an71TwL9v+/veHEL+lCOWsPhrzw2k15JwToB2QyzMsMEfRVeIf0zvk82By2025NBOF20J2MuZx4/5EOykXJg618Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277852; c=relaxed/simple;
	bh=BVUA7N2yaeCQv6TbIR9RaYMc7eBqBCpeEQlxFB7Rkak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ploTGIW2P9kEHI6kO3lD+YQKgr+gaZt2JPRoHYnGTp+p5XUT8ypqU/U/zv6ADMyxIbGH6hUmh8O6XWArsiri8WEvD9N1NNhYxt6t9SQasXgTuy9cAMOwhODhHl9m0+3rFDfnDSDpuCXHv42WInL4PF9wTYhvW18GJl5u8K99kJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8yg108p; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8yg108p"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2de831d2b20so1909315eec.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 11:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776277851; x=1776882651; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NKK54Iv6FoJSV+Ee9e/EOm1dSYdLDZIIeDygmYMlKIM=;
        b=B8yg108pH0WfcEOPEq7NYPywbgNyIA451eXFL38Iq7Fr+iq5UjwpU4bJc0mKM2vKl2
         n/OAM+Csdj7N6/9CdxDMsaTR7h/Y/hPUZjGVsJRfsded3vt6Sz1ntKmVKFxmaWeJYCpz
         vkAxtmpMWW1361b8A6JVWcflGb0qyCVgTuBae0Kr9MdnSbKjkUa2rOgCFo7EVj0rtFYe
         8HDaxxzY7jIO3wmdqF/GFquzMgbGLSViD98iXSRRLYq2rFwQ/dM/begJnYfdcmzHY6sO
         em9Hc4gmVxoNkE14rylG5bzGLUrzil7Jw9GKz/XoZu0J/tZ4+15gFkV+ZhPq3G1dNptb
         jRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776277851; x=1776882651;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKK54Iv6FoJSV+Ee9e/EOm1dSYdLDZIIeDygmYMlKIM=;
        b=nTxip6nv/F0JKsRELZQ3KrTCipFKe6O+YJuMmdreDBoPVVkanoBxgc4Ey2FPNROIdI
         wCwgqIqWBm52gCNk7uWSFxbbd7ZvqKZiG/pZ4pLBjnwRIDuUiR3h/T4qCt31oZ2xvBLM
         K0KSZlOc01WeIH3NZuMaoTbD9Gb4P8NPPO2b24FJ/H1Je1o55RequTpe+y9+PJXN+uNg
         PtKO+YxSW3YnXDCzyZbeiJFo6+yYL3WM70MZ17TcgbA4uJdvybqDykY9NMFi3fK9PE5z
         fc/WU/xEgD75ZGFo+rtneErEnODpG4M0vRbL9RMIpv97wyHmg7KZAQuHmuKTWxi5V3l5
         BoJg==
X-Gm-Message-State: AOJu0YzW6hKYDPHfiSiyQHIb5FWdCPUAqLCUVvII4rqKJlk0bIzuARll
	8cjzqApuSGaGXXjebLKVibtIwr7v8+3nDtdzLoCgfSnMhNF4kPlAdyVL08UPX6wQ
X-Gm-Gg: AeBDies3b5hvPu9OAptQAgj/uy9Ed7tAG6aG8EmPW+sGIhHlq9oexabhoixjaqPOfqU
	M1l+mlIY+mRV8hmByLuoc8gbAMsFqOy34FosDWSksJsiJ3aK+mgBbibxcm/KKtCP/ndKlYrqciz
	ixO6Y4u2Cha/EeZJaT1HVbxHOHD26bZCBQcIayW1WqleGNAmaEEOPiFCrzevpoBSr9S95JQWgSZ
	bVPC+iClBvKNgYm/gCDorWq4L0uGW/1jmZFXcX5y3SLBOzRaNkkAqcMGHLNUTFvLrnrdeeHlEZn
	dfiOEYZLiSMJSa208H6FulybHSTtgd6aiXet2VND9Ky8+g37SfEpyYFsz5Dyu217gg6Qt59K9tH
	le8bZO1bNdRGchTDRLGThLVJPj4515eu5UmqMtwOgd6Q67fq03czrR70kmhVkXDWMuQoFX0btrC
	xbsVBMIIkJ7i1VXPBarEWX2CmixKmnTyi7MHnfQLmsv78cEkQbZFD7duGHrb2I6XkWfLdrY79QX
	s6GrQ==
X-Received: by 2002:a05:693c:2c8d:b0:2d1:93b8:bc81 with SMTP id 5a478bee46e88-2d5893632cfmr12879890eec.31.1776277850477;
        Wed, 15 Apr 2026 11:30:50 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:21dc:2944:7f23:f4d7? ([2620:10d:c090:500::cdb0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c606222sm4742024eec.8.2026.04.15.11.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:30:50 -0700 (PDT)
Message-ID: <7178d2fa2b2bd6d9e33b72985d20141ad15bfa81.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: copy BPF token from main program
 to subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Wed, 15 Apr 2026 11:30:49 -0700
In-Reply-To: <20260415010834.C7DA5C19425@smtp.kernel.org>
References: <20260414-subprog-token-fix-v2-1-59146c31f6f1@gmail.com>
	 <20260415010834.C7DA5C19425@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-15 at 01:08 +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] BPF token capability delegation is ignored for JIT blinding beca=
use blinding_requested is evaluated before the token is attached.
> --
>=20
> commit 6cda306e3c0e6ae78f183769fc6ebeb4369f35c3
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> bpf: copy BPF token from main program to subprograms
>=20
> This patch fixes an issue where bpf_jit_subprogs() omits copying the BPF
> token to subprograms' aux data. By copying prog->aux->token, subprograms
> inherit the same capability delegation as the main program, allowing
> bpf_prog_kallsyms_add() to succeed for token-loaded subprograms.
>=20
> > diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> > --- a/kernel/bpf/fixups.c
> > +++ b/kernel/bpf/fixups.c
> > @@ -1110,6 +1110,7 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env=
)
> >  		func[i]->aux->exception_cb =3D env->subprog_info[i].is_exception_cb;
> >  		func[i]->aux->changes_pkt_data =3D env->subprog_info[i].changes_pkt_=
data;
> >  		func[i]->aux->might_sleep =3D env->subprog_info[i].might_sleep;
> > +		func[i]->aux->token =3D prog->aux->token;
>=20
> While this ensures the token is propagated for bpf_prog_kallsyms_add(), d=
oes
> the token delegation still fail for JIT blinding?
>=20
> Looking at bpf_prog_alloc(), it sets:
>     fp->blinding_requested =3D bpf_jit_blinding_enabled(fp);
>=20
> And bpf_jit_blinding_enabled() calls bpf_token_capable(prog->aux->token,
> CAP_BPF) to bypass JIT hardening for privileged users.
>=20
> However, at the time of bpf_prog_alloc(), prog->aux->token is uncondition=
ally
> NULL, as it gets assigned later in bpf_prog_load(). As a result,
> bpf_token_capable() falls back to checking the current process's global
> capabilities.
>=20
> If an unprivileged user provides a valid BPF token granting CAP_BPF, the =
check
> fails, and blinding_requested is set to true. This state is then copied t=
o
> all subprograms in bpf_jit_subprogs():
>     func[i]->blinding_requested =3D prog->blinding_requested;
>=20
> Are token holders incorrectly forced into JIT hardening due to this seque=
nce,
> disabling direct tail-call optimizations?
>=20
> >  		if (!i)
> >  			func[i]->aux->exception_boundary =3D env->seen_exception;

I think this analysis is a dud. The token is correctly set for the main pro=
gram
and then is propagated to the subprograms.
