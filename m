Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAE5361DCD
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775627599; cv=none; b=SWPlqW13N3gEP9TvH6tOvT6gf3mkAhmj5JWpGv2HiFcfJ2TRqh9NNaYWjSmPuoKe17LArVO2bhuUjvddU5E8mSJ3Il+t3EbQXf7uETbHmiE9XJaAMAgDTRbGlV+eY3twr4SISznfw5E8a2v9b9kBCx3wsnGInKPs+DXG7DlZSjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775627599; c=relaxed/simple;
	bh=2O0JlSSvV2vpCSIH+pMQRc8zt5p8brJgyBBIvVPB+PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNZA1fjgX5Kn2q2kB0/ZE7QoZd24SM+ynIy7aVW4ee2C5GA+U05KNNxRzdjJxr37vO/6Ni3LdnF/rvtBw9kIe20tTsi+/dV8WLsEn1i3mx88Wr8e4wZMsmig4atm4dHNHEB4V5OBP9ZZvGSMZZuKiuwiYDba8M+UtKr23vo5KGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LwC4+tDY; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LwC4+tDY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775627586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1GwFq4CXsNlts6RLLjMvnSY7coWZ8/t9Vuaq+ZX8NTA=;
	b=LwC4+tDYXm1I+uL86v2xFpDRXDpPhNI4cVb25E8N3gaMbdFVw0Km6d9xSj9crVRDvOb3dq
	LIgODrHKdDKyV5pmiHrE9J0XVyWExyHmuhOEuIAOdzpfieT5tODab2scvC6rhjuE7HqMQz
	Ukju/OJcT55caOlZFIWNfTXqUQv4gr4=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 emil@etsalapatis.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next 1/3] bpf: add missing fsession to the verifier log
Date: Wed, 08 Apr 2026 13:52:49 +0800
Message-ID: <5980838.DvuYhMxLoT@7940hx>
In-Reply-To:
 <772063b0c36262d2bee020fb590eca02ef6bfbfbecebf3a88be540b373c6ed4d@mail.kernel.org>
References:
 <20260408031416.266229-2-dongml2@chinatelecom.cn>
 <772063b0c36262d2bee020fb590eca02ef6bfbfbecebf3a88be540b373c6ed4d@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/4/8 12:55 bot+bpf-ci@kernel.org write:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
> > index 84ab73e08b0e6..94a62fcd4543d 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
> > @@ -128,7 +128,7 @@ static void test_exceptions_success(void)
> >  			       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
> >  			       "exception_cb_mod"), "set_attach_target"))
> >  			goto done;
> > -	}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
> > +	}), "FENTRY/FEXIT/FSESSION programs cannot attach to exception callback", 0);
> 
> These four selftest locations now expect the string
> "FENTRY/FEXIT/FSESSION programs cannot attach to exception callback",
> but the verifier message they match against was not updated. In
> bpf_check_attach_target() the format string still reads:
> 
>     prog_extension ? "Extension" : "FENTRY/FEXIT");

You are right, I missed this part. I'll update it in the V2.

Thanks!
Menglong Dong

> 
> so the kernel produces "FENTRY/FEXIT programs cannot attach to
> exception callback". The RUN_EXT macro uses strstr() to match the
> expected string against the kernel log buffer, and since
> "FENTRY/FEXIT/FSESSION" is not a substring of "FENTRY/FEXIT programs",
> strstr() returns NULL and the ASSERT_OK_PTR fails.
> 
> Should the verifier message also be updated to include FSESSION, to
> match the selftest expectation? As it stands these four subtests will
> fail.
> 
> > [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24117471086




