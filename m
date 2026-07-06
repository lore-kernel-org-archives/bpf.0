Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108AF3AC0F8
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352583; cv=none; b=JOFhFM9M+nCLcDAEe6ahXTLaqg813EZ5EpjN+qEh54M2DDT6gFFxcocePGbPdqahRnhwtSBdI7kLHmcXIfrLO7xpPgu4GhJEBk/GzT6vp8KKKXJayWQKHIag5zJ5p1xU7uFT9PM0blVYycMYDVRhBuZSi7Db4hN523pqrlAyhZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352583; c=relaxed/simple;
	bh=q0XhXu+Jj2Eg7U1xn2xyi7qY1cKp8f2BE3mlRnhVMfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhHUFdh9DtRztzWEEZ7dzyUScDU79sAAPRAePuRovbdANSQZ8b5tSg0XqQR1pgwxCvtPMMgByiGCzQIk6QQ3H9PgwUmCnvNag5IQkDr3c3F+2ICvHL6Y5P8L+LCKRmYOqVEyDMccLEY0zCFjT2T5e9TaWJ4MtKEx9xeS3fKCepI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEwteUEg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEwteUEg"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-472326ca506so2115098f8f.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 08:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783352580; x=1783957380; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+74TScEtXC8EWHN2LGNuN8gZZcygL9VaFHqI167VTSU=;
        b=KEwteUEgUYOlyMvko9NJEP0IWEiAJ0+6VjMhPGs3+GbLAkViw82sjo/aYlK457ogYr
         oDI5q9OjVESzTlKlMGWkPYnaON0lox+vEgXLQCjkS54ubyv0iDH3FnufONUkvWcMqWcp
         sec/YCcf7v+5dRxwTKkyNUYMfyVGu8yu32gVZmmAG2Vm+yor92uJfbl7S8IpmW1kOFNN
         DB2qortK+8wsKt+0uo505fR0FP/xvcZG6ZNnaMVrASXKd6pkcGyZimY/83W6c+frCqVf
         hpWcS9SwFQnO2zura837GdQH4PAMKcbGbD2us5dXGQ22fb4pVu1CPEGVmktmD06Z2gv3
         EhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352580; x=1783957380;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+74TScEtXC8EWHN2LGNuN8gZZcygL9VaFHqI167VTSU=;
        b=YgT8eH2OZ+eyByKcaPQztQdqkG/p6GcgzvjbjNokysjaWjiFEge4w1lM6evCtGuqQT
         owOs+UhHrASBBZq51jtmna0k/XkCJEmKQF3HvQiezQjoRQbMoka/A63mqgYQjzJLokAH
         WoyyoU/Os7EDm/UDCqIneBLkjIJM3Iw5NxdOpDZKwHBY9D2WNjcHcqQfFpH55nDtz6c1
         owiEgj8CXinEYG4kpuzUHlpCNLy0p1IvL+dyBHduPkWV9awrAO07rw8cScRY8J8wIoOQ
         1PY468OQAX6rvdKuxTK2EFeYGKW2/NXRNk6xPfONWx1BL+eOx9XG7SxqrHPzro5ml37p
         P7OA==
X-Gm-Message-State: AOJu0YwWBaWSduLFeWf1wlMXjlvoou4rkpLN7jeRZyAlfjYP715nFw1S
	WO3NvmT0Kso49h5ru9wJZTRxe4wAPXdgwjxLIJCuF53D6NXoH5mQgJXvc7J+krJoGNH+xw==
X-Gm-Gg: AfdE7ckDjenM4Ic7LY2/pjd+WuE8UCDmZLxnI3O1ofSz5IUk/6nu1laUeuwqKGlfZeI
	4FWXWm8GaxB8tNgkM8JOT6ywg2N8SyGOHUkd5GIiSx9ESnFDanskIX0UdrUOgxyeKKhvA06K731
	/lhnDYwv3nb1DCVRJ8EJOcgdN9IFOGHxL0OiR2fMDxPzqUisajq4pJ79135/lU239ERrmlFg22E
	T1hEM21gAwo9gnfGJZa+4OFUGQxbmOEJB51/kQ6adXBWdauZHNoRRn27kCSLanQyF5zkXPHUxZ/
	p1C/fCfWFW4OwmM8E4xjUQqLCKMvGsNOZHU7lK/kgJHbAk8BEHvmxLU6yVNqKRft4/SslroDxPw
	YHR1QnUa/nNilyQBSYCNquMppGFrUGv2mzUD/Bqqw8JAYHEcuotrMuhtcX0qHbagYaluKCK0dfQ
	6lIFU00JoghR4VflA5NS/ss3dvHQMphiAjhkuF800mX0W7
X-Received: by 2002:a05:6000:461e:b0:47d:df96:c9f4 with SMTP id ffacd0b85a97d-47de6667871mr1068251f8f.10.1783352580139;
        Mon, 06 Jul 2026 08:43:00 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9b4d850dsm26893633f8f.0.2026.07.06.08.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:42:59 -0700 (PDT)
Date: Mon, 6 Jul 2026 17:42:57 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Message-ID: <akvNAV2PmZNJPR0x@gmail.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
 <20260706093525.13030-3-mahe.tardy@gmail.com>
 <20260706100142.6233C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260706100142.6233C1F000E9@smtp.kernel.org>

On Mon, Jul 06, 2026 at 10:01:41AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing rollback of pernet subsystem on initialization error paths in `bpf_ksock_kfunc_init`.
> --
> 
> commit c26355c87f06c9eb5cc9cceccb20cfce50aa1e1e
> Author: Mahe Tardy <mahe.tardy@gmail.com>
> 
> bpf: Add ksock kfuncs
> 
> This commit introduces BPF kfuncs to allow BPF LSM and SYSCALL programs to
> create and use sockets for sending data. It adds several lifecycle and usage
> kfuncs for kernel sockets, limits socket creation via a per-namespace sysctl,
> and registers the necessary BTF kfuncs.
> 
> > diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> > new file mode 100644
> > index 0000000000000..8bde734bc917d
> > --- /dev/null
> > +++ b/net/core/bpf_ksock.c
> 
> [ ... ]
> 
> > +static int __init bpf_ksock_kfunc_init(void)
> > +{
> > +	int ret;
> > +	const struct btf_id_dtor_kfunc bpf_ksock_dtors[] = {
> > +		{
> > +			.btf_id = bpf_ksock_dtor_ids[0],
> > +			.kfunc_btf_id = bpf_ksock_dtor_ids[1],
> > +		},
> > +	};
> > +
> > +	ret = register_pernet_subsys(&bpf_ksock_net_ops);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> > +					&ksock_init_kfunc_set);
> > +	if (ret) {
> > +		unregister_pernet_subsys(&bpf_ksock_net_ops);
> > +		return ret;
> > +	}
> > +
> > +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> > +					&ksock_kfunc_set);
> > +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
> > +					       &ksock_kfunc_set);
> > +	return ret = ret ?: register_btf_id_dtor_kfuncs(bpf_ksock_dtors,
> > +						 ARRAY_SIZE(bpf_ksock_dtors),
> > +						 THIS_MODULE);
> 
> [Severity: Medium]
> If the later register_btf_kfunc_id_set() or register_btf_id_dtor_kfuncs()
> calls fail in bpf_ksock_kfunc_init(), does this leak the pernet operations
> registration?
> 
> The earlier error path for BPF_PROG_TYPE_SYSCALL registration properly
> calls unregister_pernet_subsys(&bpf_ksock_net_ops). If these subsequent
> registrations fail, the function returns the error directly without cleaning
> up the pernet subsystem.

Since there's no way of unregistering kfuncs for a certain prog type if
one step fails, I took the decision to unregister the per net ns count
if the first fails. Not sure how important this is and if there's a
cleaner way of doing this?

The last return line could be adjusted as mentioned in a separate thread
on the same message.

> 
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706093525.13030-1-mahe.tardy@gmail.com?part=2
