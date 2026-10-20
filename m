Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494508;
	b=aHtJkoklkGVoRjp+uBu2M3GCWKIIgD+ysZv3qJB8xLtgTJVyqJ/rktjNEX87L3MI4EwZ
	 b0Bt/4RabjwhAdmNwBFWjS4Mf6HvA68OfZk9dAjJ9aPQG8psy4ZLV33LgzDI1CrFaZ3UW
	 0WG/OK4rzHehEpqRwJw+XdFPP+03YMerfvYTwWBvKTbld5MZdWx0gYVD4Rn/2xIGK4SdI
	 3Eh33MC1h/mP407cQ1FWlDLsvqWa881p8nm77DOfv4VJJx/zswN33mwdFp4dlgI7euDBw
	 kTbWP+a8cL4fCHX+3yqqPHNuC2/YrAXlW1rcXcHqsrg5my9ZXRsvuI+fsJ+NVisMKfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=l1w3z7wsHrNCpDU9HOuKzDVQA7NKxsTiYS/eUjNMV8Q=;
	b=n8Y57e/2Ytn0rpnBEEeNQhD+2P5tp4joeZpmjdtHU/d0LnNP8ko5AHxt1qX0VuUfcTll
	 JzTVx1s9SHTzPo1//AZwKQgiqBqjyi6WsxtWC7S5VGxrAQ+Cs+cnSSkIr+CQaGf2ZWuXE
	 X9tkZNRyG9E0TcdS//jcsPAOrKfloE/PVTOx99btxG4saiG6Lds8nvEhuv1xvhtKYY2Y3
	 v51oJTv667SUfspEtyIN8kZQTJ0Q52r0tkRMy1HtJXHqIaPjFCAivC0LfGexXAl/Qxxm8
	 ID48ZBI/21c1RI7tW6C6BhQVq0zDl4/wu5+d47AuZxn3VmnsP905zSo1mlwpRymz+AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B5mbK8HO;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20206606A335
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20206606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B5mbK8HO
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so23830265e9.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 04:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792494506; x=1793099306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l1w3z7wsHrNCpDU9HOuKzDVQA7NKxsTiYS/eUjNMV8Q=;
        b=B5mbK8HOWHEzAEgbVkWU4S7v/Fu1/V9AeuFLHABONe267bAmAZ8rNKYCFUCvAdcUIS
         yN/XnGQ5LeJwZUxceQ00R5lbaIiwhgWcwaCzuUx+eU4H4hKdemUi0+iMRPER1F1ib1rC
         DV9MHOY23bjZrP9aNo6nrYGVG2V5XOy3AQoZk6cF8XhZV9Rc6oaEruPqiqa88CgMz658
         HGlRc9p+MMQQz6KVoeIiQcdkGptgJ4kzadgwffW5AaRvFTOkBvmjnLIpAnJwpAAVxElu
         N8oJYdQc1ulwIJqcbo1LzEdydF2tCl9qArHgFkjdatjD3IhlqFeG68uIMKqm5zPD4qDS
         vsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792494506; x=1793099306;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l1w3z7wsHrNCpDU9HOuKzDVQA7NKxsTiYS/eUjNMV8Q=;
        b=y1Hflhk57w7urIw5OZUHGsFmze09VKDJBevM39gevmzMqDDJjP5SiaSwyF3yiNLoOr
         vcEofCCdyTOWndzMGqYUPCvixCEW6Jr558MUuib/++BeLc36aUOU9bD1/p9YLobwbTsx
         /w6WOEUWbSDnX1sY98ItgBNJi22jaCw4p8J5V1ol8lXaFLSsmh1806Su+iL8Qjr1drs+
         TquXpy3IfCDG+0SAFGVIQMSqYq9MSxZhT/aK216RqddrMCXyYJbP0tnjbrUojX5XORMm
         3uNJjvUjdLaydCsGf+H62r08+B4b1etVAXny+waIL6X1CMacLglehi1sExZ2TIm1962L
         7N0Q==
X-Gm-Message-State: AFq9FYLXXY/VSILAUmjdOruJ8+kBkkrMWZs2zQbKrjgZupj8tmTOSTVi
	Qm5DrQAGCxgLCRTfAn0Uyio9FpZrDh3UEDney8qCVtGh5nFU/RS41950
X-Gm-Gg: AYBFou1t6tapnV9wKBPBdz7Y/9Q0nmsH1gk7GrGzb9XwOC/LPsfc6IPfYgw/omeb3fG
	HkrsGLejXCXkXnrpcqTSy1Sl22sfdCo0T275sJNftQ2tkrHtiQZPjm0WyhZ7ETTDktp1Ki5aOcT
	JF9LcreyQF1Ff47wfg0HQ6qNsyWJwnU9D5Y19DZbVMTs4nfyljqLvDZrCvslXHE90EKiRPqSY7C
	n+uViTS/ZX2eaqkn2f5l6uyyvwvuIm1CCx0K7LMeiwHV5TTxGFT1zBRxdU/5ntbekv9V9CDTSs6
	I0uuDRXHJQ8nGrFu61PrYLOLFAKOckxvHguP8S558XnN5e9P1YMtNikonDytdi3dAJ8kdTrQ5m8
	bX4Gv1AtqFhAza1zEDlYSOfGs1bfNpW9HrF1j6uNV0qBluy50925Etu+XFN2E1BygACxv0vV5E/
	Dwv1ili7FwmY8qiQFwzWAb6dy7/HJIj34eYWL2LvpQwKsk9cFDMSYUHjQDHIKeePDanK1LbcmoS
	nkOmH2LcaDXKlqlIb7WUr70kJeHMDot2ObE
X-Received: by 2002:a05:600c:8519:b0:4a1:722a:d2a3 with SMTP id 5b1f17b1804b1-4a1d760d830mr284575105e9.23.1792494506378;
        Tue, 20 Oct 2026 04:08:26 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d43242sm59681765e9.9.2026.10.20.04.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:08:25 -0700 (PDT)
Date: Tue, 20 Oct 2026 13:08:24 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, willemb@google.com,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, horms@kernel.org, liamwisehart@meta.com,
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
	netdev@vger.kernel.org, sdf.kernel@gmail.com,
	yonghong.song@linux.dev, jolsa@kernel.org, kuniyu@google.com,
	memxor@gmail.com, emil@etsalapatis.com, almagui@kernel.org,
	martin.lau@kernel.org, mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 7/8] selftests/bpf: Test forbidden
 bpf_ksock_sendto() LSM attach
Message-ID: <atdLqLm4HEa1C4SS@gmail.com>
References: <20261020102512.518479-8-mahe.tardy@gmail.com>
 <0f730af064fbd00f1b18405237995d4e78b3672fb4ee14eeaa26784aad4b9228@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f730af064fbd00f1b18405237995d4e78b3672fb4ee14eeaa26784aad4b9228@mail.kernel.org>

On Tue, Oct 20, 2026 at 10:52:16AM +0000, bot+bpf-ci@kernel.org wrote:
> > selftests/bpf: Test forbidden bpf_ksock_sendto() LSM attach
> 
> TL;DR:
> - Selftest calls bpf_ksock_sendto() without a prototype until a later patch,
>   so the test may not build or run here (bisectability)
> - Double blank line nit
> 
> > diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
> > --- a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
> > +++ b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
> > @@ -33,7 +33,26 @@ int BPF_PROG(socket_sendmsg_ksock_send, struct socket *sock, struct msghdr *msg,
> >  }
> >
> >  SEC("lsm.s/socket_sendmsg")
> > -__description("bpf_ksock operations other than send are allowed from socket_sendmsg LSM hook")
> > +__description("bpf_ksock_sendto is rejected from socket_sendmsg LSM hook")
> > +__failure __msg("calling kernel function bpf_ksock_sendto is not allowed")
> > +int BPF_PROG(socket_sendmsg_ksock_sendto, struct socket *sock,
> > +	     struct msghdr *msg, int size, int ret)
> > +{
> > +	struct bpf_ksock *ks;
> > +
> > +	ks = ksock_ctx_get();
> > +	if (!ks)
> > +		return ret;
> > +
> > +	bpf_ksock_sendto(ks, send_data, sizeof(send_data), NULL, 0);
> 
> Is there a BPF-side prototype for bpf_ksock_sendto() at this point in the
> series?
> 
> ksock_common.h declares bpf_ksock_create(), bpf_ksock_connect(),
> bpf_ksock_acquire(), bpf_ksock_release() and bpf_ksock_send() with __ksym,
> and this patch only touches progs/ksock_lsm_verifier.c, so nothing declares
> bpf_ksock_sendto().  vmlinux.h carries types only, not function prototypes.
> 
> With a recent clang this should be a call to an undeclared function, which
> is an error.  With an older clang the call would be emitted as an undefined
> external symbol without __ksym/BTF information, and libbpf would fail to
> open or load the object.
> 
> Either way ksock_lsm_verifier.bpf.o, and therefore RUN_TESTS(ksock_lsm_verifier)
> in prog_tests/ksock.c, would not build or run at this commit, which breaks
> bisectability.
> 
> The declaration is only added by the later patch "selftests/bpf: Test ksock
> sendto()" (65327a57ba55), which adds this to ksock_common.h:
> 
>   int bpf_ksock_sendto(struct bpf_ksock *ks, const void *data, u32 data__sz,
>                        const union bpf_ksock_addr *addr__nullable,
>                        u32 addr__sz) __ksym;
> 
> Could that declaration move into this patch, or this patch be reordered after
> that one?

Yeah I re-ordered the last two patches last minute and forgot about
this.

> 
> > +	bpf_ksock_release(ks);
> > +
> > +	return ret;
> > +}
> > +
> > +
> 
> This isn't a bug, but there are two consecutive blank lines here after
> socket_sendmsg_ksock_sendto(), while the other programs in this file are
> separated by a single blank line (checkpatch --strict reports "Please don't
> use multiple blank lines").  Could one of them be dropped?

sure.

> 
> > +SEC("lsm.s/socket_sendmsg")
> > +__description("bpf_ksock acquire and release are allowed from socket_sendmsg LSM hook")
> >  __success
> >  int BPF_PROG(socket_sendmsg_ksock_allowed, struct socket *sock,
> >  	     struct msghdr *msg, int size, int ret)
> 
> [ ... ]
> 
> > @@ -103,6 +122,7 @@ int BPF_PROG(socket_connect_ksock_allowed, struct socket *sock,
> >  		return ret;
> >
> >  	bpf_ksock_send(ks, send_data, sizeof(send_data));
> > +	bpf_ksock_sendto(ks, send_data, sizeof(send_data), NULL, 0);
> 
> This call to bpf_ksock_sendto() has the same missing-prototype problem
> described above.
> 
> >  	bpf_ksock_release(ks);
> >
> >  	return ret;
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39408886865

