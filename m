Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B05821C16A
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 00:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434921; cv=pass; b=kq6UV7zYESuY1uv2m4/7nCyVOdsnyPA8m8lzs9HKSCiWyrd/tJZJiXX+Xf37yIX8ymRZWCyuxvpvq2oO3SwAxeUy+Ik/3RcNl2vi2UVdgCWShA94ClbbtCoMQThGuTqwij8ABmk73B0eSLtgnOShTHCvinw74dyR762O7bOw2tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434921; c=relaxed/simple;
	bh=yXAvvuEZOGffk+WYRf60Aeg2AVFN7LYmasurNyGDKxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cvzpqaodswk9FfQ2AFIW8iNAFnRDURW7LI/6daI/WibUwYaZXHWcOrIQ64f5gXnwuxqysqo7qPSleKEa5Q4V8Fua5SJdxw06Ox0hWOcHJRACqmvnXi98aQ3HOvps5ZtZv/UtXZJSCrATLNRBf6Wwz99pIIGCXZcpa/nWzrJrzKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZSnsNas; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZSnsNas"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c85a2c012e5so178448a12.1
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 17:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782434919; cv=none;
        d=google.com; s=arc-20260327;
        b=oCrdWvB5bQTXLjCHwCZ5hfr571boX/3PddKX8hoEzNjzNKBV8hTrDCBgG4kueKFt9Q
         G9R1LYAEe9b9fm2+a4vfNhVJHxKulo5r2tguV51ynzpFaBb2/oa/xfDNNRAsP9FB8SKu
         PoG8JdZddbrF2Ap0UM2oWcyxG6khpuKzoxX9vn+AvWSs3SJtSa7AhN1b09W5Oc8C5A5v
         6F4PwtAROBjdASsqgFvB/X18KoABwHNB0i6ciOLcjmrBvalJYVItCzPkWpXJ6nxvyqIU
         diybUX+2AH/zJgRtIGxiGJUL+HfB8jxcYqcgYOMfVfA6QKwSwSVRVrpc9rssBFJbvf6b
         56AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V6xq5VzG65VCEADs41H1uwnAG6kWl4tzWEHNj4tAmMM=;
        fh=PAUabREYCLyOdFd2D2nS5lrBtrhx6aN6L3vJ3iBHm8k=;
        b=q98FLo8lahIk/w1U+g9ofhRsigEKqRbEgeUb0Lkq1qxjRLcG6bjbSje7xVacmE2nr0
         pmiTm2ZXWPplaxi6WWNGu1+9Ov4kDXoshlydSY6JWsW7G9yVWEV1R4klKIcjJyemNBE7
         ZnTu+Aj8YTBvxWOfUk6djkk6yXQdJ01jpkKx8GfuTFUAvQ7qEGEITdlDmA8IwZV9qcjj
         9Z7VHmFCin345f3hvJuFysDeaNc4oVwIEMp82gIqv0pAmKnaYHMA5s4nE0MdQpCpZ9vX
         keat6D4VaWyROpFUs4R0wIHBugvASK8H1WFDzRoDHEMsro5y4M6TdbLEUVQuilWKylyg
         6QFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782434919; x=1783039719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6xq5VzG65VCEADs41H1uwnAG6kWl4tzWEHNj4tAmMM=;
        b=RZSnsNas2s8+pStZUlsUh3zhKAIn4nTJHPpyFwjX8qdJNgbw3GmvFYYG2v6hkLgHXR
         Y1HEaNI4/jj8ns4CVwmiFODJtr/1Aj40f4gthkZP6zokOrDSabBIGPRrNBwQHpchseBF
         XFZ6dAURCwDTMOdgy9Jv8ckW88XrxgspI62f5iBJ0VqFm5pum8bwEmjzsif9R8P76Cah
         eVvfjLV/kso6LRHSZFmXmnJvwlEtVJteVKorqu4O6XohBHy54qOyMLdBlzZ2ABjgomzL
         ZzmkEnlvRHL9dIMq7n3+S2dgqq4jD6oqNDPbYg0mpYJNL8LDOSNNvDcXX/KXw9e2ath8
         3V2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782434919; x=1783039719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V6xq5VzG65VCEADs41H1uwnAG6kWl4tzWEHNj4tAmMM=;
        b=Ys4qz3oyLpnlqG9OeiYUIPFHt7yKU+HGTWoAXvAb0aFtxQX8n2WRRih3pzFVZq8ktY
         5ie6UUQKRrvBxtJY821Q4QEOrobme8ezcAdOkv2R5gWw5EWeUIku9j3BzGLwapgWQvTa
         ZXdkUEJm3ngzzHK848z8eu511ux3mNzvkUXEdPjklZWvuocJd3yc9dgOPZqVvSZJlsmi
         GjBF6fZjY0ZXJj23N8D8j0imgV/jT+gggGUKDLqfvhx6y5MY1D3bZzTe10imiTGQbuiM
         /AQf8gUAQS8bE2HVHKJrmITEWhxE06loZgD0UMGEZvhBlFEp7kkmJwWH1N61RfxgRO1H
         ArAg==
X-Forwarded-Encrypted: i=1; AFNElJ8yJn3Yo+8BjohJCG3169LkgPxXOLN70gYDKKd5jTmvdbrYb2YXHJQ44yCBt32srD+1EuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOePnqi3iy8XC42s7Hl2+IxkFKfaYCTZ9fNUw7OaSTrviUHXdX
	Ri2Z2JL73FERaxo5sK9S/j0hSzR97Sxyi0NjxO0COfFKqWTjXw/MHs00faVXezy2bKCgjyQ8N/X
	7K2JB8++vwUPAk3Q13E4QBbzUwW4W9VM=
X-Gm-Gg: AfdE7clC5GEDB3+Q/rqTl33iEVGrDJkt4zb75K/SLXe0roDiHOXcOwEYHIaYt73bk7B
	tkTIL1NyOyHO7p+4GnRMVNum8AP+JXsHV1IFTA91pASXdnqtX8aGhKYIyv6FDkyhVDlfM50vh1y
	/9PqdDuK1qZpJfw3X3SpP3ivDi15LF9GsJTzHMHGxg9IqMKqcbKwfyMlBLDcau+1I9uM+slwx7f
	aQ0EjbU05zw1nFvOdwmMlpzapqrbfRijfghF5v7n/KRtqoE1NQIkFlq5Ocj3R4qz0kGAxJQY2NY
	n/XJMSQDRfWX9bGyEQfdT5WkOVi9HJbtmYrQ93zvk7TWBHsixNGsA5wEdZMJ25pOopsIbaBEOW1
	o4WO6P7yRAOSe9kn8IuImXiQ=
X-Received: by 2002:a05:6a21:338a:b0:3b4:87c0:d7f with SMTP id
 adf61e73a8af0-3bd4af2d2bbmr5935549637.32.1782434919049; Thu, 25 Jun 2026
 17:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623014027.402820-1-sun.jian.kdev@gmail.com>
 <20260623015325.2F2D31F000E9@smtp.kernel.org> <CABFUUZFH=qx7e7mT=GSepdk_XUGhPtJEzuFf-qjUUMLRaEv0kQ@mail.gmail.com>
In-Reply-To: <CABFUUZFH=qx7e7mT=GSepdk_XUGhPtJEzuFf-qjUUMLRaEv0kQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Jun 2026 17:48:27 -0700
X-Gm-Features: AVVi8CdrMggxg9K8_Wp0nhKye4DvDA4aL09na_EX3GyosjcqJ1jMva3U1mf7J0w
Message-ID: <CAADnVQKCk9vfi6Lc-RZj6KEpf6Yxm50=V5DWfTqfeYrSsGXDaA@mail.gmail.com>
Subject: Re: [PATCH bpf v4] selftests/bpf: Cover partial copy of non-linear
 test_run output
To: sun jian <sun.jian.kdev@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 7:06=E2=80=AFPM sun jian <sun.jian.kdev@gmail.com> =
wrote:
>
> On Tue, Jun 23, 2026 at 9:53=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] The newly added selftests `test_skb_nonlinear_data_out_partial=
` and `test_xdp_nonlinear_data_out_partial` will unconditionally fail due t=
o an unaddressed arithmetic bug in the kernel's `bpf_test_finish` function,=
 breaking the selftest suite.
> > --
> >
> > commit 99284be8e441ba5ead251137597e96ebcee998f4
> > Author: Sun Jian <sun.jian.kdev@gmail.com>
> >
> > selftests/bpf: Cover partial copy of non-linear test_run output
> >
> > This commit adds selftests to cover the partial copy of non-linear test=
_run
> > output for both TC and XDP programs. It uses a 9000-byte packet with a =
64-byte
> > linear data area and a 100-byte output buffer.
> >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b=
/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > > index 01f1d1b6715a6..beb6fa78fd949 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> >
> > [ ... ]
> >
> > > @@ -20,6 +24,69 @@ static void check_run_cnt(int prog_fd, __u64 run_c=
nt)
> > >             "incorrect number of repetitions, want %llu have %llu\n",=
 run_cnt, info.run_cnt);
> > >  }
> > >
> > > +static void init_pkt(__u8 *pkt, size_t len)
> > > +{
> > > +     size_t i;
> > > +
> > > +     for (i =3D 0; i < len; i++)
> > > +             pkt[i] =3D i & 0xff;
> > > +}
> > > +
> > > +static void test_skb_nonlinear_data_out_partial(struct test_pkt_acce=
ss *skel)
> > > +{
> > > +     LIBBPF_OPTS(bpf_test_run_opts, topts);
> > > +     __u8 pkt[NONLINEAR_PKT_LEN];
> > > +     __u8 out[SHORT_OUT_LEN] =3D {};
> > > +     struct __sk_buff skb =3D {};
> > > +     int prog_fd, err;
> > > +
> > > +     init_pkt(pkt, sizeof(pkt));
> > > +
> > > +     skb.data_end =3D NONLINEAR_LINEAR_DATA_LEN;
> > > +
> > > +     topts.data_in =3D pkt;
> > > +     topts.data_size_in =3D sizeof(pkt);
> > > +     topts.data_out =3D out;
> > > +     topts.data_size_out =3D sizeof(out);
> > > +     topts.ctx_in =3D &skb;
> > > +     topts.ctx_size_in =3D sizeof(skb);
> > > +
> > > +     prog_fd =3D bpf_program__fd(skel->progs.tc_pass_prog);
> > > +     err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> > > +
> > > +     ASSERT_EQ(err, -ENOSPC, "skb_partial_err");
> > > +     ASSERT_EQ(topts.data_size_out, sizeof(pkt), "skb_partial_size")=
;
> > > +     ASSERT_OK(memcmp(out, pkt, sizeof(out)), "skb_partial_data");
> >
> > [Severity: High]
> > Will these assertions fail unconditionally due to an existing arithmeti=
c
> > bug in the kernel?
> >
> > In net/bpf/test_run.c:bpf_test_finish(), the length is calculated as:
> >
> >     int len =3D sinfo ? copy_size - frag_size : copy_size;
> >
> >     if (len < 0) {
> >         err =3D -ENOSPC;
> >         goto out;
> >     }
> >
>
> This looks like a false positive based on the old bpf_test_finish()
> implementation.
>
> The fix patch has already been applied to bpf/master as:
>
> b5f3534268e3 ("bpf: Fix partial copy of non-linear test_run output")
>
> That commit removes the old copy_size - frag_size calculation and compute=
s
> the linear copy length from the packet layout instead:
>
> head_len =3D size - frag_size
> len =3D min(copy_size, head_len)
>
> This v4 only resends the remaining selftest patch on top of current
> bpf/master, where the fix is already present.
>
> I also verified the tests on current bpf/master:
>
> ./test_progs -t prog_run_opts -v
> ./test_progs -t skb_load_bytes -v
> ./test_progs -t xdp_pull_data -v
>
> All passed.

Thank you for testing, but I don't think we need a selftest
for every condition in the kernel.

pw-bot: cr
