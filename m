Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B963D4121
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740618; cv=none; b=VX/j6/nZ3x7fgfiv4UAmFLf5MJVbseKJM94nnY4g/thLIRY/NoolhhcYlcqaHcF5qvvmHpgFiN7WjDD97R3xyCdS0+cs+QMA/RTm94FMTzSpK2fuYZjbF0GD8BNsGflbf2EHWzLm6f2sAMCGZr1FHNO+d7QZlmt9N6B9wx98aIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740618; c=relaxed/simple;
	bh=FJ/D4q23EFv6mDXNXcni7J38bIM5TIPQlv22/kkJCWc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMAKwV6ZbI7UtYlIlRgQEcUw8K1i/fOaFCP6S1zQU/eugGkrdoCfCwrVcyvm3vbLRKCOGLDB6jsEg7/qVCtcY0DH6h4buYlYAgo5hjAtRv6kUrBQOPovd2Dvu2qxhJK05lWCMFdQk5I0XUQ/kdH4v+Z3P9l6XNYWngKI67JCIP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHHUYkLw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHHUYkLw"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d17bb1c1dso711580f8f.2
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 06:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775740613; x=1776345413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sEfIeWMKEQinR24XF9uKTH7B8WIhwrpXr7IybuBO0ac=;
        b=aHHUYkLwVOd69YrQ76wrp6NCP/4uRzYaRgPUhfEZtpdDB8pkt8Y3P2yzG/iSy3h09z
         l+celceRc4YhZM4QriRzvQyaTcl0RcolPX7lApz6YvZKu1K2kx+oev8PGQvA3UYFHR6r
         v8Hxo5hq228XQgQ/57ujjgKL0HAU8Rnefz/8vnW2p8Cs2pijlrFq73hZh+L0nR/IKVBJ
         JEFRZcspYD6cWWaYD2cSYj2pHnk83kbXrfaIQUPz5wK/BzH0FGwGOKdXqyO5mBK3jnAs
         7zz+oo7BX3pj6b7fC0fFbnEKOCKwQ8xgN+vBPrrSvcFD8PRKv8jmwkzHZZg7C2c/L+pH
         RRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775740613; x=1776345413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEfIeWMKEQinR24XF9uKTH7B8WIhwrpXr7IybuBO0ac=;
        b=XpnSY1Yp8Mwn/IB/ydVTJRkAieIe/kcfljPHVbQVTx7wogTrEd74LQmm2r7TLsr3T3
         Zpzv0DJGrT5n7n1af0wYVcJN5ap6i4J3WaTY0QxoO8trQwUG9jDoUQYDvO8g56bb2WRk
         vKq6rts0dVLap5B2PY2wFTV1EazRfJoSJysbi/LvDQK6wxYaxiLZNdSCqRjWAdvWKrpC
         BGG3bGeCVIsplTFkEVTn1bJfkhfDF95C7wgeQENc3l2pf1MoSJWZ4Hx5P/Kkwa0uRgQ3
         nkQMyJBSk1DzDgD0ymgd2QQJxLGI+FbKeVejRNRkBaFwqqgmopUhgHb3maRSnj4Jy6wA
         zobg==
X-Forwarded-Encrypted: i=1; AJvYcCWgkbbpisjY6I4DX0YCKgIW3t1UAsZ4BkNWSaYpKU7SAdyT+/w5XnGJP/hNElt2VfU56So=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgI+Mmh9OFnVBUlttSXkwa+UfERh44joZyGlKDEubf42BjRnJ2
	WMXL795aOrISrRM2U9xbc/ZusPemvAIhAIry9kgmEQuxR3MRQaHtTlug
X-Gm-Gg: AeBDietl9YVCOKEzvfhmwE6FFLpqT35nFw8x7kOKjEJu1GeqC7AM6wZEoH8AbgIB81A
	P1ulWSjEmd0eczPTe6Zf5QwrMcR0JsB5seM1BORUglPGn2p0GOptALhdkl3XcoMmIfUdutpPy6U
	TRxPtv1T7JU84qtL0ZTe2z2X0cSxcyZexg7yTXfga3rBJbRjz1yVQhqdhheu1Xd/firz5fvvXDt
	6S4CfcILQFjk03DizkVFArQ9OyA9qJs1jhV5cXgVjU1RbzldYK/1vC3Hv8+vWfIghxKKtq0bgvK
	u+vueC3uOhXgBcO3rUd92GmGuntQUNP84yQ84xosyhxECo2DE27wNF40Ad86ewFftEl/IBrNcd0
	7c9JY2VqIvliqDPMScC9ayPcQIW9oSiuH3mDcF85HZ1k4dJ0hGA8vkSOCiua5QoL14+KV3N5VNa
	OdCFvOiiTnHrEa/A0=
X-Received: by 2002:a05:6000:1acf:b0:43d:20e9:b0e1 with SMTP id ffacd0b85a97d-43d29280e6dmr35116020f8f.7.1775740612569;
        Thu, 09 Apr 2026 06:16:52 -0700 (PDT)
Received: from krava ([2a00:102a:403a:e361:61e0:606e:5b16:ccaf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d282esm67310305f8f.18.2026.04.09.06.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:16:52 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 9 Apr 2026 15:16:46 +0200
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, shuah@kernel.org,
	emil@etsalapatis.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] bpf: add missing fsession to the
 verifier log
Message-ID: <ademvg2HQT3AZRh1@krava>
References: <20260408062109.386083-1-dongml2@chinatelecom.cn>
 <20260408062109.386083-2-dongml2@chinatelecom.cn>
 <adZWStMinOeunjSH@krava>
 <5090408.31r3eYUQgx@7940hx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5090408.31r3eYUQgx@7940hx>

On Thu, Apr 09, 2026 at 07:28:55PM +0800, Menglong Dong wrote:
> On 2026/4/8 21:21 Jiri Olsa <olsajiri@gmail.com> write:
> > On Wed, Apr 08, 2026 at 02:21:07PM +0800, Menglong Dong wrote:
> > > The fsession attach type is missed in the verifier log in
> > > check_get_func_ip(), bpf_check_attach_target() and check_attach_btf_id().
> > > Update them to make the verifier log proper. Meanwhile, update the
> > > corresponding selftests.
> > > 
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > Acked-by: Leon Hwang <leon.hwang@linux.dev>
> > > ---
> > > v2:
> > > - add a missing FSESSION in bpf_check_attach_target()
> > > ---
> > >  kernel/bpf/verifier.c                               | 10 +++++-----
> > >  tools/testing/selftests/bpf/prog_tests/exceptions.c |  8 ++++----
> > >  tools/testing/selftests/bpf/verifier/sleepable.c    |  2 +-
> > >  3 files changed, 10 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 594260c1f382..beb660b4c3ec 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -11757,7 +11757,7 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
> > >  
> > >  	if (type == BPF_PROG_TYPE_TRACING) {
> > >  		if (!bpf_prog_has_trampoline(env->prog)) {
> > > -			verbose(env, "func %s#%d supported only for fentry/fexit/fmod_ret programs\n",
> > > +			verbose(env, "func %s#%d supported only for fentry/fexit/fsession/fmod_ret programs\n",
> > >  				func_id_name(func_id), func_id);
> > >  			return -ENOTSUPP;
> > >  		}
> > > @@ -25561,7 +25561,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> > >  	btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
> > >  	if (!btf) {
> > >  		bpf_log(log,
> > > -			"FENTRY/FEXIT program can only be attached to another program annotated with BTF\n");
> > > +			"FENTRY/FEXIT/FSESSION program can only be attached to another program annotated with BTF\n");
> > 
> > I wonder this should say 'Tracing program...' instead,
> > we have other tracing types not covered in this error
> > 
> > jirka
> > 
> > >  		return -EINVAL;
> > >  	}
> > >  	t = btf_type_by_id(btf, btf_id);
> > > @@ -25597,7 +25597,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> > >  		if (aux->func && aux->func[subprog]->aux->exception_cb) {
> > >  			bpf_log(log,
> > >  				"%s programs cannot attach to exception callback\n",
> > > -				prog_extension ? "Extension" : "FENTRY/FEXIT");
> > > +				prog_extension ? "Extension" : "FENTRY/FEXIT/FSESSION");
> 
> I guess that we'd better use "Tracing" instead of "FENTRY/FEXIT/FSESSION"
> here too?

ah right lgtm

jirka
