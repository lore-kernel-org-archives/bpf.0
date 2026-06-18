Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A333AF64F
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772292; cv=none; b=GIvCqdWBEQCa4nQpYJgCxuWtQ0Wz8X9TLNB1vavuX6FlJ4zir/32wAc0pWP4sHEjMrYYvFu82blI3QZoly9gU0lc3eyNgVDybExVPnkEJi/OW/jCYLgyKa8yUdD8xSYnVaJLgUaVMCnXe+h+MYdBAcomkA+u0gwtQhBwHaxaaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772292; c=relaxed/simple;
	bh=76A9PLA0Vo4uGvCdzH6m1R2rU33fdxsc/cfE8TrRFNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dfr3OYDzZ9MPn6v/mlzrL9RP3d6IYY0KAXw/A1JF6T4ryf5wUJmxhUyv2cpQ2QulA0vk0TOFgtYdgyhGyUfkQtHn1m7PebkNoUWjBFDwXrRTCy4HJbbLIyLgQjcttWigUY3pLUFdgN1G1No1FCu+iG0kig7LeRanGM1xtqZMeHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhOw7JoC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhOw7JoC"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso4004415e9.1
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781772289; x=1782377089; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BMZN9/XZRkM1cRtvf9YfI3LamYxCsoX5bvp0jYNhRA4=;
        b=rhOw7JoCdlFDxr43Ajxcrwuh2Rhd4S4I1Ll+1dn5dvfztv3CjTkcREYGKCcydkrIIp
         PgqgXXK1hSY6T07tW0y3prQJ7MzigP8P1EHEsu05I14uQXBCNPwCpws3IXIuo5wjMF7U
         CUAlZ8pK9h1iOh97bGCr/gOKxVhjgKgRA9a5gZdo5NJ/oLXEOHBly+GNq0SetASHCTgQ
         /QeWH4vajVClpYpm4owzidy+Y+tVeNZ/f35EBOX5+CRFZ5ZSScIjXw+/5hzeomOh8kWr
         YNKc1OOYLaEnQCAK4ZKdEnxGsH+jug+dk+uYpYCuCSiMgeA0r9Ua2mRJ+FSnjV5WEIOk
         quJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781772289; x=1782377089;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMZN9/XZRkM1cRtvf9YfI3LamYxCsoX5bvp0jYNhRA4=;
        b=cQOjIlCDqeEOrM+EAwWsMyYJ0CtS3N2iImqfDGkI69EBUybtbujvseSp71fHXFSwGf
         +sCDDli90rLUvg71bAlrsuanc/thn49r/ygtXSeqQdXUJ9jjemMIhlPImfIyUmU7yCuL
         SDfg2DcgodNVRUnp+QMLLDvc1h5aqFeLOmdLj9hJdB0cmFPkutcRrLY5jNl9ThGusO+1
         4gsmcX30RILhEJNSLDxVMtLFVT3S8Kvn52KQjb4oFHk6plCvw14P9WubAXe3X3WicdG2
         jXjslu6AYLAeRdPeV2A8/BrqDDA2TVqiyg3bjCbWXnseFXkZk87vvKuzETMJygJXN+p3
         5ZFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yoRW4cyUwGee8+8zGKUF3LLgW9+H03qXbb77UI1sZN0wHH1bXN0A/K6ALQa54n1TfB1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCAmyLmzn6/sizn959/i+HKs8VUGq+euBKKQptc/9usII3+odB
	bVu7+qc3IOBNgAKD3ENxo8skFAzHR/N1ia3HeLDIu1fmNT6OGyU3DwdU
X-Gm-Gg: Acq92OF6RrMFtclLCi8zwoayuhUoGl0tEo5y5F6oVRtYRD2oQsVULRHr2ETcH1/rQee
	3JKEACMw40f1etTBhR6k48wrMp3y0UQ78c1X/JwXXwgpsddeyr4fC7BMgdVuXVl/BKNr/HBE1TW
	iPcnTIpQcM2orO8Sb6f73MTgLxo8XzqvkDXorXI0rzpW8R6F1ZL7hunB3M02YffX7Fql5sN0VHA
	dDctXIO9gY9U//dIS8AOHfhiTHJXJNuwW9n15+AcPOTDDdCR3ft+M/5M9ogSrmOP8vNm7Uzvp66
	8c/sMZGH+kBwdTaBxWY9A6ePDSxOXsUaANdmNfk6ObXJK1vfLalcT157Bcjo4vzkNBcDVYzY6S2
	4n3nxWdXosUVpbyKPJ1Rz2FWcdNN1pWnaXGX8LoD0D+TuiGUmH39gt9oDrxqhMbp5Y+o5qQDdur
	5zunFTxHVcqKq+XLBm8whuCymOVqUp4oBGiMbKtRGJzFdKLiHSu7Og0jZqW2fCCTqYu1HABO/ER
	+dBRPN1SR0hq7oynOczD1jCW7uOU+pmt8f7G9FGowD2Zy5bMKfF+EdgrZbR0rt3WJCr6xjp3yT9
	ePrOvHe9DTyumtUIjxyvwNHCIlKnYJm2
X-Received: by 2002:a05:600c:350a:b0:492:1e36:1fe9 with SMTP id 5b1f17b1804b1-49233430b8amr112747915e9.37.1781772289262;
        Thu, 18 Jun 2026 01:44:49 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e006e99796483dfbc0d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:6e99:7964:83df:bc0d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa96f0esm255321905e9.12.2026.06.18.01.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:44:48 -0700 (PDT)
Date: Thu, 18 Jun 2026 10:44:46 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	toke@redhat.com, lorenzo@kernel.org, martin.lau@kernel.org,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Cover partial copy of
 non-linear test_run output
Message-ID: <ajOv_oOd1zInaW1b@mail.gmail.com>
References: <20260617093557.63880-3-sun.jian.kdev@gmail.com>
 <2dad9b5c184fa101d7cffa1d8f5eea5b5df60f53533d98c68175c9e3ec5ee6ac@mail.kernel.org>
 <CABFUUZFeh18OjQ6EhjD17ZwQKb1aiVNkYKv-hAkVGrHhPpjE4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABFUUZFeh18OjQ6EhjD17ZwQKb1aiVNkYKv-hAkVGrHhPpjE4Q@mail.gmail.com>

On Wed, Jun 17, 2026 at 10:19:52PM +0800, sun jian wrote:
> On Wed, Jun 17, 2026 at 6:31 PM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > > index 01f1d1b6715a..9cc898e6a9f7 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > > @@ -4,6 +4,10 @@
> > >
> > >  #include "test_pkt_access.skel.h"
> > >
> > > +#define NONLINEAR_PKT_LEN 9000
> > > +#define NONLINEAR_LINEAR_DATA_LEN 64
> > > +#define SHORT_OUT_LEN 100
> > > +
> >
> > [ ... ]
> >
> > > @@ -20,6 +24,69 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt)
> > >             "incorrect number of repetitions, want %llu have %llu\n", run_cnt, info.run_cnt);
> > >  }
> > >
> > > +static void init_pkt(__u8 *pkt, size_t len)
> > > +{
> > > +     size_t i;
> > > +
> > > +     for (i = 0; i < len; i++)
> > > +             pkt[i] = i & 0xff;
> > > +}
> >
> > A question was raised on v2 about whether pkt_v4 could be reused by
> > reducing the linear area to ETH_HLEN, rather than introducing a custom
> > init_pkt() with a 9000-byte stack packet.
> >
> > Can't we reuse pkt_v4 here by reducing the linear area to ETH_HLEN?
> > The v3 still adds init_pkt() and the NONLINEAR_PKT_LEN packet, so this
> > doesn't seem to have been picked up.
> >
> > > +
> > > +static void test_skb_nonlinear_data_out_partial(struct test_pkt_access *skel)
> > > +{
> > > +     LIBBPF_OPTS(bpf_test_run_opts, topts);
> > > +     __u8 pkt[NONLINEAR_PKT_LEN];
> > > +     __u8 out[SHORT_OUT_LEN];
> > > +     struct __sk_buff skb = {};
> > > +     int prog_fd, err;
> > > +
> > > +     init_pkt(pkt, sizeof(pkt));
> > > +
> > > +     skb.data_end = NONLINEAR_LINEAR_DATA_LEN;
> > > +
> > > +     topts.data_in = pkt;
> > > +     topts.data_size_in = sizeof(pkt);
> > > +     topts.data_out = out;
> > > +     topts.data_size_out = sizeof(out);
> > > +     topts.ctx_in = &skb;
> > > +     topts.ctx_size_in = sizeof(skb);
> > > +
> > > +     prog_fd = bpf_program__fd(skel->progs.tc_pass_prog);
> >
> > [ ... ]
> >
> > > diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> > > index bce7173152c6..cd284401eebd 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> > > @@ -150,3 +150,15 @@ int test_pkt_access(struct __sk_buff *skb)
> > >
> > >       return TC_ACT_UNSPEC;
> > >  }
> > > +
> > > +SEC("tc")
> > > +int tc_pass_prog(struct __sk_buff *skb)
> > > +{
> > > +     return TC_ACT_OK;
> > > +}
> > > +
> > > +SEC("xdp.frags")
> > > +int xdp_frags_pass_prog(struct xdp_md *ctx)
> > > +{
> > > +     return XDP_PASS;
> > > +}
> >
> > A related suggestion on v2 was that, once pkt_v4 is reused, the existing
> > BPF program could be reused instead of adding new pass-through programs.
> >
> > Could tc_pass_prog and xdp_frags_pass_prog be dropped in favour of the
> > existing program? The v3 still adds both of these, so this point also
> > seems to be open.
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27680511802
> 
> Hi,
> 
> Thanks for checking this.

Hi Sun Jian,

It would help if you could reply inline instead of at the end of the
messages, especially when there are multiple comments. See [1] for an
explanation of how that works.

1: https://kernelnewbies.org/FirstKernelPatch#Responding_inline

> 
> I tried reusing pkt_v4 and the existing TC program, but they do not fit
> the skb case this test is trying to cover.
> 
> For skb test_run, IPv4/IPv6 inputs with a too-short L3 header in the
> linear area are rejected before bpf_test_finish(). With pkt_v4 and a
> linear area of ETH_HLEN, the test fails with -EINVAL before reaching the
> partial copy-out path. If the linear area is increased enough to pass the
> IPv4 check, pkt_v4 is too small to both trigger the old
> copy_size - frag_size path and verify that the copied prefix spans the
> linear data and the first fragment. pkt_v6 has the same issue: after
> making the IPv6 header linear, only 20 bytes remain in frags.
> 
> The existing test_pkt_access program has its own packet-access coverage
> goals and is not just a pass-through carrier. With such a short linear
> area or small packet fixture, it can fail before the test hits the
> bpf_test_finish()'s partial copy-out path. A pass-through TC program is
> therefore a better fit, because it keeps the test focused on the
> bpf_test_finish() copy-out semantics.

If we're keeping tc_pass_prog() then can't we use pkt_v4 and get rid of
init_pkt?

> 
> For XDP, this object does not have an existing xdp.frags pass-through
> program, so the small XDP frags program is needed to cover the other
> caller of the shared bpf_test_finish() path.
> 
> Thanks,
> Sun Jian
