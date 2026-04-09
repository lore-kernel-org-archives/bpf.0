Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC0736DA07
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 02:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702620; cv=none; b=b4Q/S8OCOUqTY/SdMhAIspcjYD96ZgEjL4Ii1/qLGJN0P0fRcMgn4syS8gI3yTLiqTZ1TDgDmBbGau+r9lQUcOvnYmUKJEe+FxE7hGWpSPj1jh5u5FePnxHkkTBPmc4KEs20nIuFDQncLn8R1KmlHHAFvKZMUACymTUGqWMzHtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702620; c=relaxed/simple;
	bh=qirgBVL+p+N6eq5e0Gc5EJUeSwYBwsN3jKlovD7OAeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDjkWDwZGeFBnoWexjlRIQJMS+CGjga0xwuPEn9eLtZqtdt0QTL9gAPfRRsK0qa1WTPFHzGXG7jUZwh/82ccqb3JfCtYqh12xtCmYm0Nr/DSJS0yvHxP8imdpQbaHyzxFrmZvsGESDlGquLgu6pydjcFhmiL4W/+1MRKAcNS5VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sLms5hza; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sLms5hza"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775702607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyEtmpE0az8EkLm4x9vmex76Yp3gInv6feCZaEzxgeI=;
	b=sLms5hzalZdMOMJulJjgVHkmZCiUMWPVy3CPJ7BSDlu++qLoW5sGddJmLv4FyH3HD1yj/T
	OevvAULPGnCswumaa/zXlVVEvKYvJ8UFskMGh+0rSBmzcjDtca47+qNDny25U4OLRSp/ri
	DPSn2fuFr9wLDTIuu+LFxvKtBXrtr+I=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, shuah@kernel.org,
 emil@etsalapatis.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v2 1/3] bpf: add missing fsession to the verifier log
Date: Thu, 09 Apr 2026 10:43:10 +0800
Message-ID: <2825401.mvXUDI8C0e@7940hx>
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

Yeah, it make sense. I'll update it in V3.

Thanks!
Menglong Dong

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
> >  			return -EINVAL;
> >  		}
> >  		conservative = aux->func_info_aux[subprog].unreliable;
> > @@ -25686,7 +25686,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >  	case BPF_TRACE_RAW_TP:
> >  		if (tgt_prog) {
> >  			bpf_log(log,
> > -				"Only FENTRY/FEXIT progs are attachable to another BPF prog\n");
> > +				"Only FENTRY/FEXIT/FSESSION progs are attachable to another BPF prog\n");
> >  			return -EINVAL;
> >  		}
> >  		if (!btf_type_is_typedef(t)) {
> > @@ -25952,7 +25952,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
> >  	}
> >  
> >  	if (prog->sleepable && !can_be_sleepable(prog)) {
> > -		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
> > +		verbose(env, "Only fentry/fexit/fsession/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
> >  		return -EINVAL;
> >  	}
> >  
> > diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
> > index 84ab73e08b0e..94a62fcd4543 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
> > @@ -128,7 +128,7 @@ static void test_exceptions_success(void)
> >  				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
> >  				       "exception_cb_mod"), "set_attach_target"))
> >  				goto done;
> > -		}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
> > +		}), "FENTRY/FEXIT/FSESSION programs cannot attach to exception callback", 0);
> >  
> >  	if (test__start_subtest("throwing fentry -> exception_cb"))
> >  		RUN_EXT(-EINVAL, true, ({
> > @@ -138,7 +138,7 @@ static void test_exceptions_success(void)
> >  				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
> >  				       "exception_cb_mod"), "set_attach_target"))
> >  				goto done;
> > -		}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
> > +		}), "FENTRY/FEXIT/FSESSION programs cannot attach to exception callback", 0);
> >  
> >  	if (test__start_subtest("non-throwing fexit -> exception_cb"))
> >  		RUN_EXT(-EINVAL, true, ({
> > @@ -148,7 +148,7 @@ static void test_exceptions_success(void)
> >  				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
> >  				       "exception_cb_mod"), "set_attach_target"))
> >  				goto done;
> > -		}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
> > +		}), "FENTRY/FEXIT/FSESSION programs cannot attach to exception callback", 0);
> >  
> >  	if (test__start_subtest("throwing fexit -> exception_cb"))
> >  		RUN_EXT(-EINVAL, true, ({
> > @@ -158,7 +158,7 @@ static void test_exceptions_success(void)
> >  				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
> >  				       "exception_cb_mod"), "set_attach_target"))
> >  				goto done;
> > -		}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
> > +		}), "FENTRY/FEXIT/FSESSION programs cannot attach to exception callback", 0);
> >  
> >  	if (test__start_subtest("throwing extension (with custom cb) -> exception_cb"))
> >  		RUN_EXT(-EINVAL, true, ({
> > diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
> > index 1f0d2bdc673f..c2b7f5ebf168 100644
> > --- a/tools/testing/selftests/bpf/verifier/sleepable.c
> > +++ b/tools/testing/selftests/bpf/verifier/sleepable.c
> > @@ -85,7 +85,7 @@
> >  	.expected_attach_type = BPF_TRACE_RAW_TP,
> >  	.kfunc = "sched_switch",
> >  	.result = REJECT,
> > -	.errstr = "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
> > +	.errstr = "Only fentry/fexit/fsession/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
> >  	.flags = BPF_F_SLEEPABLE,
> >  	.runs = -1,
> >  },
> > -- 
> > 2.53.0
> > 
> 
> 




