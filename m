Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E43B3BED4A
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775734158; cv=none; b=nz27G4QA5xvrBiSUyCS45MZ98MWU/QS4iMzUJt+/+b32H6RvVBYNY/wpKt1E12SmimFneZRZrl5GlgLNaVBSGMw1aE8jQhzXfzj8RBrL+KPZDdf42VEuB6Zfd29YEcOnY3fFVp0kc/PdCoi2srQo9zKz3p3iDYFBZXCBBCY2p+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775734158; c=relaxed/simple;
	bh=+mAuVhclk7/79jHnw5cx20QkLJGt0qzs190F78JpAYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F07XI4k2ki8vj/p/hvbzYLqMItusVOliIW/zajJd1onosTqiuTRXGEh/ye7ylxDwXKtsfwfy1sjHMfd+9KMB7mbVpxIJh4YEifoAj3DOhv9uvcQe8ciUAfFyHM9bQyMZD3vEuyYFcmn+XhhITSU5og98up+ROc/yXf5exqNextk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YKYSvdNP; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YKYSvdNP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775734153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bX9UNH9nppVP6n/cB7hjsiwZXPi5JOvS+eugnkyUXao=;
	b=YKYSvdNPwqF0I/tcBgCvVlJyENCg8xn8864YiPcXKQxp5KPJAAv/dto4GxeHfeK+nWzr61
	aRs1EYDyPewSS5gGxgNjmiwjQf/jJf4vt5M6r7Z/sxmmGxeNzXEpxdzX5DAC2k4FBO0ckN
	+yPn1uoLO0WWyMVVoB3+2yKk12Mf3Kk=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, shuah@kernel.org,
 emil@etsalapatis.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v2 1/3] bpf: add missing fsession to the verifier log
Date: Thu, 09 Apr 2026 19:28:55 +0800
Message-ID: <5090408.31r3eYUQgx@7940hx>
In-Reply-To: <adZWStMinOeunjSH@krava>
References:
 <20260408062109.386083-1-dongml2@chinatelecom.cn>
 <20260408062109.386083-2-dongml2@chinatelecom.cn> <adZWStMinOeunjSH@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/4/8 21:21 Jiri Olsa <olsajiri@gmail.com> write:
> On Wed, Apr 08, 2026 at 02:21:07PM +0800, Menglong Dong wrote:
> > The fsession attach type is missed in the verifier log in
> > check_get_func_ip(), bpf_check_attach_target() and check_attach_btf_id().
> > Update them to make the verifier log proper. Meanwhile, update the
> > corresponding selftests.
> > 
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Acked-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> > v2:
> > - add a missing FSESSION in bpf_check_attach_target()
> > ---
> >  kernel/bpf/verifier.c                               | 10 +++++-----
> >  tools/testing/selftests/bpf/prog_tests/exceptions.c |  8 ++++----
> >  tools/testing/selftests/bpf/verifier/sleepable.c    |  2 +-
> >  3 files changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 594260c1f382..beb660b4c3ec 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11757,7 +11757,7 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
> >  
> >  	if (type == BPF_PROG_TYPE_TRACING) {
> >  		if (!bpf_prog_has_trampoline(env->prog)) {
> > -			verbose(env, "func %s#%d supported only for fentry/fexit/fmod_ret programs\n",
> > +			verbose(env, "func %s#%d supported only for fentry/fexit/fsession/fmod_ret programs\n",
> >  				func_id_name(func_id), func_id);
> >  			return -ENOTSUPP;
> >  		}
> > @@ -25561,7 +25561,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >  	btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
> >  	if (!btf) {
> >  		bpf_log(log,
> > -			"FENTRY/FEXIT program can only be attached to another program annotated with BTF\n");
> > +			"FENTRY/FEXIT/FSESSION program can only be attached to another program annotated with BTF\n");
> 
> I wonder this should say 'Tracing program...' instead,
> we have other tracing types not covered in this error
> 
> jirka
> 
> >  		return -EINVAL;
> >  	}
> >  	t = btf_type_by_id(btf, btf_id);
> > @@ -25597,7 +25597,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >  		if (aux->func && aux->func[subprog]->aux->exception_cb) {
> >  			bpf_log(log,
> >  				"%s programs cannot attach to exception callback\n",
> > -				prog_extension ? "Extension" : "FENTRY/FEXIT");
> > +				prog_extension ? "Extension" : "FENTRY/FEXIT/FSESSION");

I guess that we'd better use "Tracing" instead of "FENTRY/FEXIT/FSESSION"
here too?

> >  			return -EINVAL;
> >  		}
[...]
> 
> 




