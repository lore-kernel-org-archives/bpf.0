Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F838F24C
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368611; cv=pass; b=O7ttaPxBdZqgUNbknes5XGN58xffb7BWmwZue/sO67tiAAXPvf9GVWhOTe1M4bVs9+yljO/36d/SWRiJTrDRXi2qRk52DahnGeA7OK22/W165+4AmDjApC9CdlTZd/oDhmr2HbFVdi4DSdEKj/DOgJA7SD8RDWvgfJt8KIZzwEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368611; c=relaxed/simple;
	bh=bUKFL0mooMpwLXWWi23CY6Fe3FU71zNzPDR47LRd64g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rT6nbrfWySp/IqiLMbUazNfuVYnltkaw+yYH0ARvV/GCGOkB/SrtluclD+wORU9/WE1QAQjzgPFMRBXMTqe4dirpQZ6NFAV5DmDdU20lGjGKv4bfjzbqLi8Tx4c0SlJT5mRPKmF318N6yZchPe4HQZk6HDm+U/j+scBDqG3Yx7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tLVHdknt; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLVHdknt"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-671d60ef9c6so15459899a12.2
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 02:30:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777368605; cv=none;
        d=google.com; s=arc-20240605;
        b=RzJgsmhD09xR26/AUE3CpUM/XqV+8m9ipwfoFSrDu/Iyy7LG7hubEwRpuvBGXdwzvu
         fox3UiuYK/GRd5pZzgtDIwgrEfhkwZ7RuIy5MwXshcbXlRu6llVxRgSTDHiMbAxNq0vr
         4KwZhpUWSVC3KFfADDHpD3ckKO56OkHr1/Irux66nGwxYs+jRivHeJsGS6fMFIY+JKXh
         C30AU8Z/WHC8lvY44Ux70FhQ4MnYWEywEspoSw49BzvMDrlr63plW81uvo65EWY+xiiN
         FmgY/Bryu1YIFpmjFMxwXAZVPZlwIDf2GP9F8rWunyAb7SGviPNb42X8pbConl9nsMtg
         Xd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=padr2h2XEYJ5NHhm6V/pkf1/fnbasfn4pd6o7auN6mA=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=JfRambb7VL8Ridcad5t3+4Zi0oh5VwzBHItQHlVzKEHxJl11QXIcrXoZhR1mGC23sW
         yxIfrC3gL9kpvVfz9H1Rc4Tb1Tc26Jt5lStfMPnpjBDlQU2gmW7kOdCPn/hSXxyUYvEf
         3ELfgRMu6boiiB/mab5XGe9d6O+UGta71YjwQbTU0B7othscoK00o1yDtSiFDsY+3XVe
         fvtmh/wasxkcpc30HuoJiZNrSPvzdhkX0lbocgpgOvSkaRx5AbM6j0agNYeoGuyMKoZs
         vbfBl3Lup/kabk61tZOFabDMUJWVp6G5i0oDJrvSDC6lng8BMwSQlrWsIKA+9GmmLT7/
         J2sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777368605; x=1777973405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=padr2h2XEYJ5NHhm6V/pkf1/fnbasfn4pd6o7auN6mA=;
        b=tLVHdkntGNBtjmKgO6eXDsm6LCoBoeLN2jtrcO2/I2ZAikmVHenVtupwBa+IBHlX1c
         JXoIn0oikhlx4JQBAMI9C6brT2p0YwGOMrtVRz7uf7Yl0CAdFRGIKRmfFdZTmVydj+0I
         4SnrEpzkI55vnlmsTGHVIm0kwWTF3Njkgd1S//pEoASSJN3WV97U9CmfwkzIBKW27MF3
         NeYl2Q2k4cDZHAOQnja0eNtGZ9o8vbtFbZwNWmcBdDlyr24QXbSOdj7sArwOmgLYiJMD
         KVaAdg9HFgC6SiXTvr6H4hRYou3xi0CCYOnJLHrytHh8PqQzGJMzGUyMGfpB4C2d7glQ
         nFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368605; x=1777973405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=padr2h2XEYJ5NHhm6V/pkf1/fnbasfn4pd6o7auN6mA=;
        b=VSOYYPTdlpPNH28YTTq446dqPB9JrsGi8CjJLXaTxe0UyThTrZCAlffmhe/sPIgI3v
         pXwUymJxa9JCIGAPOBIrR12FLMu8PTBdHLn3/SkNL0B1MyRaatpB+2zqEIZhuRTkEVx0
         4mdLRG6+iNIwkluJxcCo6YlmrXX1EC1przyQTO/iV16sMgHQqbaWy6T7nMXqCeNZI//Y
         C9grq6X5Ow3zjf5LJdAdkWEulwZ6EKCKba2NcvI/wskGCGEFLf2sz0NpXy5MwwH0BO/K
         o4/baH68slFupZ/0ZCSYquUYRrrqIeyhsudsSAJ2U0YFvZdhBXsXSdX4cM4BAhRGgxK3
         isiw==
X-Gm-Message-State: AOJu0YwKw3X7P7up5LGLpDbQbaYr2IKmi6dAmSXRA/K+FHWNges3LO3f
	3mzPA71bNyCEmBYXH9pqXT1DBg1Au1m9I6ptljr20xgJilliafUFt+SqAJc5cwxzXz5BUNssh9i
	X3dM8zZO0Gmazoz0iieEhw1T3OIwLCVQeC7DN
X-Gm-Gg: AeBDievXjETfvMIL6DoOz7ydzDRu/Fr1JFZL/ciYbJib6X9lnCydNLmm+EE4dkrvdR1
	uWB5OASFoJ11KLzolQH+t1KTCq9SlC+IOwV5203Q2pV/wj6rvyTY3x6Df3D2HLFoPKbRaQ2CEO3
	VwtcjuqIwLICLUis8O2dXoxwFFpDmV5em7OTSMe0SrE/S+Qv6rwzmWtTw+aUPZCzAp2Vn6nBZ8G
	qo5zRRZCH2ffV15np1Oxw84AkldW1kvq4fX8qAjSHHYrKXDQybM4DhRO7VmTfABS4Wg2veR4epy
	SMFlg2xur8upvjyF
X-Received: by 2002:a05:6402:505b:b0:671:a18b:32b8 with SMTP id
 4fb4d7f45d1cf-679bafe395amr1080072a12.0.1777368604754; Tue, 28 Apr 2026
 02:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427232313.1582588-5-puranjay@kernel.org> <20260428003801.C1302C19425@smtp.kernel.org>
In-Reply-To: <20260428003801.C1302C19425@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 28 Apr 2026 10:29:53 +0100
X-Gm-Features: AVHnY4JIVqiwx6HnJAVFEI_4IC68ew2f0xo2HV5mBdY7wzDillWNC2ZErkFOiCc
Message-ID: <CANk7y0jACz-MiJLtF1HO69kXz7M9fRzqW4BcgnP004M=spATmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] selftests/bpf: Add XDP load-balancer common definitions
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 1:38=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 3 potential issue(s):
> - [Medium] Endianness bug and invalid arithmetic on network-order values =
in IP encapsulation helpers.
> - [Medium] Implicit compiler padding in shared BPF/userspace structures c=
auses cross-architecture ABI breakage.
> - [Low] Missing anonymous union for IPv4/IPv6 addresses in `struct real_d=
efinition`.
> --
>
> commit 27405cc11d849dd578c45222803d3bbd40b0e500
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> selftests/bpf: Add XDP load-balancer common definitions
>
> This commit adds the shared header for the XDP load-balancer benchmark.
> It defines the data structures used by both the BPF program and userspace=
,
> along with encapsulation source-address helpers.
>
> > diff --git a/tools/testing/selftests/bpf/xdp_lb_bench_common.h b/tools/=
testing/selftests/bpf/xdp_lb_bench_common.h
> > new file mode 100644
> > index 000000000000..aed20a963701
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/xdp_lb_bench_common.h
>
> [ ... ]
>
> > +LB_INLINE __be32 create_encap_ipv4_src(__u16 port, __be32 src)
> > +{
> > +     __u32 ip_suffix =3D lb_htons(port);
> > +
> > +     ip_suffix <<=3D 16;
> > +     ip_suffix ^=3D src;
> > +     return (0xFFFF0000 & ip_suffix) | IPIP_V4_PREFIX;
> > +}
>
> Is it safe to perform bitwise operations directly on network-order values
> like this? Since lb_htons() returns a network-order port, left-shifting i=
t
> by 16 and masking with host-order constants like 0xFFFF0000 or combining
> it with IPIP_V4_PREFIX (4268) seems to assume a little-endian architectur=
e.
> Could this generate corrupted packet headers on big-endian systems?

It is safe, everything happens on the same host, this is a benchmark!

>
> > +
> > +LB_INLINE void create_encap_ipv6_src(__u16 port, __be32 src, __be32 *s=
addr)
> > +{
> > +     saddr[0] =3D IPIP_V6_PREFIX1;
> > +     saddr[1] =3D IPIP_V6_PREFIX2;
> > +     saddr[2] =3D IPIP_V6_PREFIX3;
> > +     saddr[3] =3D src ^ port;
> > +}
>
> Will saddr[0] evaluate to the correct prefix on all architectures? Becaus=
e
> IPIP_V6_PREFIX1 is defined as 1, it evaluates to 0100:: on little-endian
> but ::1 on big-endian.
>
> Also, is it intended to XOR the network-order __be32 src with the
> host-order __u16 port without a prior byte-order conversion?
>
> [ ... ]
>
> > +struct real_pos_lru {
> > +     __u32 pos;
> > +     __u64 atime;
> > +};
>
> Could this shared structure cause ABI breakage between 32-bit userspace
> and 64-bit BPF environments? In 64-bit environments, the compiler will
> insert 4 bytes of padding after pos, but 32-bit environments only require
> 4-byte alignment for __u64. Should an explicit padding field be added to
> ensure identical memory layout?
>
> > +
> > +struct real_definition {
> > +     __be32 dst;
> > +     __be32 dstv6[4];
> > +     __u8   flags;
> > +};
>
> This isn't a bug, but earlier structures like flow_key and vip_definition
> use an anonymous union to overlay their IPv4 and IPv6 addresses. Should
> dst and dstv6 be placed in a union here as well to save memory and
> maintain consistency?

No, some scenarios use both.

>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427232313.15=
82588-1-puranjay@kernel.org?part=3D4
