Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FC03AE6E6
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354317; cv=none; b=Tsw9qFJqHJbfDf/TIzJv61XBKZ3deFIAjffdKQ+C9m7N+g2lrHFeQujI+i5a+rBVm6Z6cqqSxcBLtNk/1Q5MZbIoxozFJYDSDLilvA4LRLD+7y2cwVWTEEej02DHmGCqumfaO6khTltx+OqDDtk6Hb2RjiWvDWcemiFng6i9Wak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354317; c=relaxed/simple;
	bh=ODm1JlKjjV1Rfdlzubm/+kPpDVjn2IfzQi+Cj+tn+sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJ1zYmW+kLuY2u/FEHeOtc5dV2JmBt6kkllUT2JU8pBS6NgCKvBlQqj7fBPRoy08a6qRcNTKgz5XT80SmITqyCl4w64G/QTnq9ZsLXXYHS78KdyAjPJJSC+t08Bf0wQPJ9FB+XAgjnipN0y51DWqkwah2vsqJCBoHH7M/14oNCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RORPLYqB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RORPLYqB"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso907655f8f.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783354314; x=1783959114; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pTCA1dS/7nwR/DMXGXhTJ+UNx1CjomsCt2mPEMxYtNc=;
        b=RORPLYqBjEnXRDK8v9jx7eE51XyEQ84Osx0yFYEikQENTbnJ/BiaUOp3DDbO7eeRs1
         IiIAGkl5TyGvpUDbmmBVQiH2X9K6JFbb/ctaJvBu/IqrJVdtfPgJwj2uhnkmTQkWyzA2
         lf1KU7HbQuQw4Xit4ZMBUxZLfhBP7dx+Dbwfo2QApMO16oR29vqxMJ0fcJdzpd077Erg
         oUAuoWVbbILGK+kdf9aCHa7GVbi7peM1M0iQZY4hNgbxkmxkswFg8XkmiSkMMFXH2g3p
         IvbC0rtZ92N2jxA/lIqRS+hOPJu2+cQUeGs9XAmeRgz6sixGmrFiULD3Qe8nC2tv/O46
         wnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783354314; x=1783959114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTCA1dS/7nwR/DMXGXhTJ+UNx1CjomsCt2mPEMxYtNc=;
        b=Zuo3P0EKz4LRV+sjCbzW0zQymDJhgyDYi0AX/Hgo2wFKXxr14rpdTygFYkd/fzbLEH
         kUd9312OhwxYoKZhhaAUNrK5Iuad4TRIBG7cuBMffTAn75OZQ234WZ2pvOdTq0otMwZC
         g/v6tL7ZeVOgR2DRnssvS3vcRXP7QKKve3fvlLqQEs/PLpaubEOXg98yj6Q9YAVQ+FtE
         CSR2Md3jIrrdbSkd8lS0AompxbtEvunmR0rR1DGhBHDqQvEGo3cuzKckLBRQU2tKpGaF
         62mkvkfnfLO7URr9xMaxwilT3AVIznE49vjZfeY4Ieg4/AG5B/rw2O84D5Rf6edyW19f
         vaqA==
X-Gm-Message-State: AOJu0Yw302rgUpakA+Bsm9S003IkIUUjZMrmNn79mOmMdSIUR2lc2u3x
	2XTUrqMm1wujQsqz8gKAWVhBjIpNXyEoZvlU5O6cxmHwwuC4nmSR0v/8fJCDm/OvcBggFQ==
X-Gm-Gg: AfdE7clSytcwLtQ/ucpIVqD3+RvsygrAcoXS51C+ra7qQp5Sjh2/RkVyTX2T6oczSWX
	8B1IiXfrhtSxoSDsZlkvI5EjIz/LAlGb95M4Tl+EZEveUzjscH62RkCHk0fCtwngoIYbtfg5Fyg
	JlVleI3QqLwvX/SSAggu4nQL6ZJyTkHFsVazqTdz+E21sgdtgz+WYG8AuOTJAAX5IABB5x4vIL/
	iFMcLwnfXL+zJx8O4Dx7rp7OE0TqBz9Dgxx/VLcHvCvUnsy1WQNYkQbtArVjTpvFE8AzVcAIxyO
	Fz0weY/5sZSX1Sh7tZ6f6BURgPa42ppcoN4KCyoqPi8Ig6YfnLBAsU4k+AlLwaKHLqZpVIuQhQR
	OpYYPzje7S1Pw4HymgPrf9JQeYg/EZUbcQBD+D1Ls9OxDNSRrtLimfdaQ88mGQ6u8E4vNANp6RY
	WsFtO2pqb/MCxIA77fMZK/I8XKCFChmjFsG91mRAKb4sn4
X-Received: by 2002:a05:6000:1448:b0:478:77c1:787c with SMTP id ffacd0b85a97d-47de66bcf43mr1189772f8f.56.1783354314076;
        Mon, 06 Jul 2026 09:11:54 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm26422569f8f.5.2026.07.06.09.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:11:53 -0700 (PDT)
Date: Mon, 6 Jul 2026 18:11:50 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/6] selftests/bpf: Add ksock kfunc test
Message-ID: <akvTxp38m3bqvJTA@gmail.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
 <20260706093525.13030-4-mahe.tardy@gmail.com>
 <20260706101040.DEDBB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260706101040.DEDBB1F000E9@smtp.kernel.org>

On Mon, Jul 06, 2026 at 10:10:40AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Dead code and flawed insert logic in `ksock_ctx_insert()` due to unconditional map element overwriting.
> - [Low] Unnecessary manual validation of BPF program FDs after successful skeleton load.
> --
> 
> commit 559d17f26b2fc7936f58b27cbc4a4f83dacd3a73
> Author: Mahe Tardy <mahe.tardy@gmail.com>
> 
> selftests/bpf: Add ksock kfunc test
>     
> Add a selftest that exercises the ksock kfuncs end-to-end. One sycall
> bpf setup program creates a ksock context and connect the socket.
> Another syscall bpf program lookup the context and send test data.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
> > new file mode 100644
> > index 0000000000000..085ddb59067e8
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
> 
> [ ... ]
> 
> > +static bool ksock_setup_ctx(struct ksock_basic *skel)
> > +{
> > +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> > +	int err, pfd;
> > +
> > +	skel->bss->ipv4_remote = inet_addr(LOOPBACK_IP);
> > +	skel->bss->remote_port = RECV_PORT;
> > +
> > +	pfd = bpf_program__fd(skel->progs.ksock_setup);
> > +	if (!ASSERT_OK_FD(pfd, "ksock_setup fd"))
> > +		return false;
> 
> [Severity: Low]
> This isn't a bug, but is it necessary to manually validate the program
> file descriptor here?
> 
> According to the BPF subsystem selftest guidelines, after a successful
> skeleton load, skeleton-generated program and map FDs are guaranteed to be
> valid. Since this is called after a successful skeleton load, the
> ASSERT_OK_FD check might be redundant.

Sure, can be removed.

> 
> > +
> > +	err = bpf_prog_test_run_opts(pfd, &opts);
> > +	if (!ASSERT_OK(err, "ksock_setup run"))
> > +		return false;
> 
> [ ... ]
> 
> > +void test_ksock_basic(void)
> > +{
> > +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> > +	struct ksock_test_env env;
> > +	struct ksock_basic *skel;
> > +	int err, pfd;
> > +
> > +	skel = ksock_basic__open();
> > +	if (!ASSERT_OK_PTR(skel, "skel open"))
> > +		return;
> > +
> > +	err = ksock_basic__load(skel);
> > +	if (!ASSERT_OK(err, "skel load")) {
> > +		ksock_basic__destroy(skel);
> > +		return;
> > +	}
> > +
> > +	if (!ksock_test_env_setup(&env, NS_TEST))
> > +		goto fail;
> > +
> > +	/* Step 1: Run the setup SYSCALL prog to create ksock */
> > +	if (!ksock_setup_ctx(skel))
> > +		goto fail;
> > +
> > +	/* Step 2: Run the send SYSCALL prog */
> > +	pfd = bpf_program__fd(skel->progs.ksock_send);
> > +	if (!ASSERT_OK_FD(pfd, "ksock_send fd"))
> > +		goto fail;
> 
> [Severity: Low]
> This isn't a bug, but similarly to the check in ksock_setup_ctx, is this
> ASSERT_OK_FD necessary since the skeleton is already successfully loaded?

Dito.

> 
> > +
> > +	err = bpf_prog_test_run_opts(pfd, &opts);
> > +	if (!ASSERT_OK(err, "ksock_send run"))
> > +		goto fail;
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/ksock_common.h b/tools/testing/selftests/bpf/progs/ksock_common.h
> > new file mode 100644
> > index 0000000000000..87d92372d28dc
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/ksock_common.h
> 
> [ ... ]
> 
> > +static inline int ksock_ctx_insert(struct bpf_ksock *ctx)
> > +{
> > +	struct __ksock_ctx_value local, *v;
> > +	struct bpf_ksock *old;
> > +	u32 key = 0;
> > +	int err;
> > +
> > +	local.ctx = NULL;
> > +	err = bpf_map_update_elem(&__ksock_ctx_map, &key, &local, 0);
> 
> [Severity: Medium]
> Will this unconditional bpf_map_update_elem call defeat the intended
> collision detection logic below?
> 
> Because __ksock_ctx_map is a BPF_MAP_TYPE_ARRAY map, calling
> bpf_map_update_elem with a zero-initialized value (local.ctx = NULL)
> will clear the existing entry and implicitly free any pre-existing kptr.
> 
> Consequently, the subsequent bpf_kptr_xchg will always see a NULL pointer,
> making the if (old) check dead code and causing the function to silently
> overwrite existing entries instead of returning -EEXIST.
> 
> Could the logic be adjusted to perform the lookup and exchange without
> overwriting the element first?

So this is not erasing the content since local.ctx is a kptr, so the
feedback is kinda wrong, it will be ignored by the map_update part. It
was copied from crypto_common.h but is kinda doing nothing so could be
simplified to only lookup & kptr_xchg.

> 
> > +	if (err) {
> > +		bpf_ksock_release(ctx);
> > +		return err;
> > +	}
> > +
> > +	v = bpf_map_lookup_elem(&__ksock_ctx_map, &key);
> > +	if (!v) {
> > +		bpf_ksock_release(ctx);
> > +		return -ENOENT;
> > +	}
> > +
> > +	old = bpf_kptr_xchg(&v->ctx, ctx);
> > +	if (old) {
> > +		bpf_ksock_release(old);
> > +		return -EEXIST;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706093525.13030-1-mahe.tardy@gmail.com?part=3
