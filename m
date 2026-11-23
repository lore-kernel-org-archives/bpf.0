Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471461;
	b=EYO72h4jL5n7ugNFra2I4dwS/PEMERQFAU+AA+U/pVttCoVTaFKq4HDc0lGaSYp7QLcU
	 lQXNVNGtHWp6MuTUzyyjaFtHhrfoWUEW/2AMX5qJWf9GGcYrPgaYQJRTpkKvvhpIJ9p0G
	 x/rJKE+8sr3k60IRbyYiA6243DSo/uJxzygjiYPWldbWivk6n77ZKa0nF0W5Zcqg4YUo5
	 hUmiJMgLvZLJ2b2w+3vz07YuY6otkoM8cCwdyvg1qYNfYPrK9NeHYyNagjtvZ0Gkk6ogm
	 lirOdHMc9rvPsaw3F3eq48X2DWSc7gt/SY7ZjIyY1L8vpemz5YhmdAFFZYyTJH+yClQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2f3F7pReyCVh5ohj9DIUA9RqsDOv9jV9G6uqHApB7O0=;
	b=zOBis9sU4GX3drSE4CYilzKv2H+fD42NY8/qMhuZXt0NqX3gue4aJOSJTgiFdQwdu5dQ
	 JC2p1gRnBO96fREdbptuRS2ZLvU9D5vv1PXtSkmf/AdOwcYu11VWUhguYXKNX788YN3aB
	 gvpPeua4DrNju1Z+2DldEUnMFS5CJgdeJWh+E3iIVw0vbRk6/zmM2rOyv3+SFM0JybXJx
	 VlBtygG7ANsm96Mt3H7UW2x/JoHe+/2sXkO3vhIqYtzrUytbRHY0yd54sTVF9K8MLfSQN
	 PbAkYDUUa16yrLiNJI8Kpuvf75+RV5MVZDpY83tTU6oMvvVdsJ4AD0L4LxWaTqha8zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wtVnmpzv;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA923606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA923606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wtVnmpzv
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so36316885e9.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 14:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795471459; x=1796076259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2f3F7pReyCVh5ohj9DIUA9RqsDOv9jV9G6uqHApB7O0=;
        b=wtVnmpzvYZCD0GaLZu5xfru9ELcjZM/X3gc10J+KIN5n8p5arnhGlxvdZtuiEyO+SF
         mXICRZeaJ2Yi+kfmmdhQdJJsugjTetjy6sSEz9ogL2VfZiBVbHasEkV22gWyrwSX/9iG
         gXP5KWXVdP09JEupsR0PUyqFKWnmmNcnY1K6WK4XNiptsVNjkbR83Oe++P10kA8oCycU
         syRoavExVO4TMq6Rf94nzquu91XYDe0jrE3mOWRkel5ldFIFYGjyxM9BnJB5iIqlQKty
         ZwnmN8MZDypLgKC1fNGIYoSh2uoC1c1DYQyWGPsAypQxJiD5h5LhoNSwIqSiXUZTNEJA
         rwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471459; x=1796076259;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2f3F7pReyCVh5ohj9DIUA9RqsDOv9jV9G6uqHApB7O0=;
        b=eIf3R8DRFWPbdf8zAivq0QChkPjAwqpN14RAL00FIygMLQYT1M2iG8B7r+nL6EMbw6
         YpE4qZm0uUHdYLZhWaW9eZHd6dklmXjjV3bXmOOYVRx5wKUyeKWq0eOsyk7jHNtT251S
         gBiJYRudhlFGbhfyl0kKOxUKe8OVRYBnqeFEf7+D43lVdgeJ6/EX9kYA6nlV+evX4P3t
         q44OOblxSheuSN54bb3drD77ghgWV8ez2v3VqN3hCvLFcgOtGMSTwLl74B1iPh14qrwm
         7VTppys6hNcTc1uRIV648YLiOXwGTg/iAQmzBF9xhBJf/HA1tNCO7gAnLeI5p7nb5aVg
         2r4g==
X-Forwarded-Encrypted: i=1; AL+hErFt7ZonR3ipltgGxpTr+yGf24m/Bm1W0cESD0up2tQ+sMzbuGyPFB3k3zrdnIHLZ1eOhEE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PQD/cKIR4T8DoR7l7WpEhC6DnOOVy7wHAgMxFQzvYYTMpR4uO
	6jnPENBs2gAj01h3PgDJcLEafF9OgcLIo5JFH6hHtrYtsmFcMeFRptLB
X-Gm-Gg: AZFdTZev9NDuhJxEO0Ze+PuTiKfx3Kr64tqoYPkQm+zjZygETLDaOhINEZX5elcachW
	625t9AICa5OC9LSOkZby7I4VYxICDl1UcffJgPUgZ05wzpxCb6165FnmaXcHcrVihJ04olQzAyf
	0g2cQ7Z6dvDnjkNja357BgJqsV0kBUAFHB4AtHoWKchHg+LUoR56zM4Xln7o+Tk0YMMMTyKYUDA
	Bt38DVBOYLrJg9eYOKxw9pp/ekP0zezttBwW3zMibho8xMTgZt913+0hdwVqRQ/NLKymldPZg5B
	fJER6APQMWJk/CRks456RhBsK70Lb+kyWEqXhC1NTTaaOCLEYPMM4wVxqdB+kbxGh2OmBCl0yF7
	tQqGvGHrRr5hJIltlts8UD5hOFStWODx5IXnRqT5LFSb5jnVLGm6ueGusi9iMS7dZGpVsv6mGTo
	tGJ+iWWHvsXtcFJCKqtpFgWsMbZrwZNpu3FncZTXbc9bJtWPw2rI/8htANIsxi6Mfl+WfHfElw2
	ftdI12uB+2J1NjiGk2JI5j6ewbSUSYb8jXa+fbdRHCq9lVpRye+773FhTxeT3qQMS9NRynmba5E
	PoPWvAVkqFV/Ibga
X-Received: by 2002:a05:600c:1c0e:b0:4a1:ddaa:571e with SMTP id 5b1f17b1804b1-4bb88824f38mr302199135e9.15.1795471458927;
        Mon, 23 Nov 2026 14:04:18 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a1e8bsm324214035e9.9.2026.11.23.14.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:04:18 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 23 Nov 2026 23:04:16 +0100
To: bot+bpf-ci@kernel.org
Cc: leon.hwang@linux.dev, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, emil@etsalapatis.com,
	ihor.solodrai@linux.dev, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org,
	matt@bobrowski.net, shuah@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH bpf-next v3 7/9] selftests/bpf: Test tracing_multi
 link_create logs
Message-ID: <awS4YG9LyfxIbE-m@krava>
References: <20261123152743.19629-8-leon.hwang@linux.dev>
 <d3920bd7ae0cc6a941895e00534e8f8818402a673351894d0bf98639272f7d7e@mail.kernel.org>
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
In-Reply-To: <d3920bd7ae0cc6a941895e00534e8f8818402a673351894d0bf98639272f7d7e@mail.kernel.org>

On Mon, Nov 23, 2026 at 04:04:41PM +0000, bot+bpf-ci@kernel.org wrote:
> > selftests/bpf: Test tracing_multi link_create logs
> 
> TL;DR: Test issue: the migrate_disable denylist subtest's skip may not trigger
> on !CONFIG_SMP kernels, since the function still exists in BTF, so it could
> fail instead of skipping.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_link.c b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
> > --- a/tools/testing/selftests/bpf/prog_tests/tracing_link.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
> [ ... ]
> > +static void test_multi_log_denylist(void)
> > +{
> > +	const char *msg = "Cannot attach to denylist btf id %u.\n";
> > +	const char *target = "migrate_disable";
> > +	struct btf *btf;
> > +
> > +	btf = btf__load_vmlinux_btf();
> > +	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> > +		return;
> > +
> > +	/* migrate_disable is only in the denylist on SMP kernels. */
> > +	if (btf__find_by_name_kind(btf, target, BTF_KIND_FUNC) == -ENOENT)
> > +		test__skip();
> > +	else
> > +		test_multi_log_target(btf, "fentry", target, -EINVAL, msg);
> 
> Is this skip reachable on a !CONFIG_SMP kernel?
> 
> kernel/sched/core.c always builds an out-of-line, exported
> migrate_disable() with no CONFIG_SMP guard:
> 
>     void migrate_disable(void)
>     {
>             __migrate_disable();
>     }
>     EXPORT_SYMBOL_GPL(migrate_disable);
> 
> while the denylist in kernel/bpf/verifier.c adds it only under
> CONFIG_SMP:
> 
>     BTF_SET_START(btf_id_deny)
>     BTF_ID_UNUSED
>     #ifdef CONFIG_SMP
>     BTF_ID(func, ___migrate_enable)
>     BTF_ID(func, migrate_disable)
>     BTF_ID(func, migrate_enable)
>     #endif
> 
> So btf__find_by_name_kind() should find migrate_disable even when
> CONFIG_SMP=n, and test__skip() would never run.
> 
> On such an x86_64 kernel, bpf_check_attach_btf_id_multi() would not deny
> the id, the link would be created, and the subtest would fail at
> ASSERT_LT(fd, 0, "bpf_link_create") instead of skipping.
> 
> Should the skip check the kernel's SMP configuration directly, for
> example through a __kconfig extern, or should the comment and skip be
> dropped?

I don't think we care, but if we do perhaps we could use __rcu_read_lock instead

jirka
