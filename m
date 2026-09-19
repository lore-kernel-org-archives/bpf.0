Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6361FFC59
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789815736; cv=pass; b=d4pL78gydukLHyDkLr0u97Xgs76Zx84CAoV4fofyuyOyxyGxh4CUXe/TbPiVFrvV3FIOeQCnuoPn1h5OuSLJqFmypUJRhR8sLYJoUcSZL6o6OyXUGpaLTLf1B9ZyM1LqWxyr2dv2JtBf/VbGfirrqjHV1hIGIC8MUc/LSzdeoL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789815736; c=relaxed/simple;
	bh=bByw82JDW+jqybuuMhYcN7brXCJg3RksqvUBCfrdXss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQZ1OPay9/Rk6Vz7onrKh+tPJPyxXwz/jacksays8Njsrqp2bC5evbKQsi/yMjNNPRLnXMiAUcQFqrBJSxoN8XN+nLVG64KMcO/W4c6RVEnC+eITW1ZmKaGySR4oGn+qsjifqzOKGnmHmwkUOwAqkL3STNwb0naiMG4PD+2wNQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAbB2LNd; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAbB2LNd"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a9ac6aa620so3321263a12.1
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 04:02:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789815733; cv=none;
        d=google.com; s=arc-20260327;
        b=OPY5PudZQbwoTsUSPK3wt0Cdk5ceUWc33RgWuTqfKGLaulO9YG1G2eQJL2Gp8k0IM2
         qix93xSTrMuH/mQBRyyq60ilAQdQxuhwANchWAarrJTDEZi4Yhqov+YE8E9lOOF7gE0B
         /y6YaLKJYNJktolEJ2Q96LOc9FcfBJaEJuOkdRwrIQfTmj26rUwapmjWSzh/s3KjEWWQ
         Y7ofwVtUxmapq9FIxhw0/H0Et5Jh22iWnnJuuYJAfME8xc1lL7YF0iadsSOH4dqWnO+N
         RBugdOyWIUwsph5eHxzcjtdb2A2QPMO6tNz+gPi+AbpzKwxgUpqMMSaFNFiM9V82UTG1
         5RNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2cpsEklAU6BWvkOWc7YHFf1b2b5F1Jin2qoj1wfdPzo=;
        fh=QgrW4P46dsqB6omycbG2kFGo2OHcPfg5+s7IV8ZIXdU=;
        b=DI7XkP2oYGtw6wJKx9z2IbY7Vh2PYWbIvaq8rgGWGu0iKflNburdtlRi6aI49iu260
         K5dP4mIkau1NKnT2SDcsSKH7M1hFOsMTChDhrhoWs406L7id3RMZnN6zxvgpIyFLmxvq
         rKtuLVXwAH7WlZQv3z317VjKrDK45zT8FH3uYnZW/pDjhFVQfeO+aKsbZ2+cgqEH5sU0
         Z0TYKTIQxpnIIqpb5BmU8mD5T82yCXo/8pl05LtSr3FK4VKZsy09YteP9OfkfQmkpl8t
         F466S7CgL9D0cJvc3HzavdeGFsIhOoyb5tOnmRU7OEZ5BE2m3RSZpB0/BuxfApjaZDq7
         Y0FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789815733; x=1790420533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2cpsEklAU6BWvkOWc7YHFf1b2b5F1Jin2qoj1wfdPzo=;
        b=LAbB2LNdX2ZXU95IudQkd50Et/wrIRK3vWTqrdvl6aJbMlY73Zip5VxDj+5MHHbIeB
         o3k8aPzxr6PxfSTLdkO64Hb6Githl8YyUmdVfbH/rosHNPivY04s7QnO9Ym7CdmcVZao
         lda7r/3UndP/cOU//mPBdBiXaZZ8Kse503u4xG0cuU+Elb9aH8ElhtbSboBnrX5BeG9T
         A5CiwMUKiCsPtvHZMtOKviOiy7pvoRYOXMxEZb4WPuceg7P8lMok/cjmEfGMBJENyQZI
         6K4sEUD0E6IPuazC8Zuni+CDE5F3N/e4mQhp47yjKR59TDf8r1dtPbsS2TckgOjhndAn
         m76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789815733; x=1790420533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cpsEklAU6BWvkOWc7YHFf1b2b5F1Jin2qoj1wfdPzo=;
        b=IBJiO6I9z7l/QSYWomdQGN2BOeBY9Oe1NmTXOm7GYDP7WS/fQ1druqAuV9hpqq3g3s
         rPI6QjkfvPlD1QDw9zJLKaWT/WyOxAgf6qhcEI5f6+ZOJMcUnBDD9hdKwVhYamLZMbsY
         rj5628CTtykKsrWgq5t0+GQzgxd/fk5ng0xW6NWzDp1vL6swNkpOOn6dC5jWsXrSbV5q
         ZYTkpMcwt7uBRcrFdfB+Ig/uU4gJqlnQ998PA2XiirtH8kDDcrjukPO6V2nm7pGmQJvI
         JbpSZVgh1MCUEi4CjxzUhAfXN7A2OzuXI4DY/e/WBcYKRI0+ORAqfMzrSV34klSGOTH4
         lvWw==
X-Forwarded-Encrypted: i=1; AKwUvBwwkuxeQDcBDnL2elVTmTE7HXAWPpyWJsEQPD8fO6BCNqwtOSkSt593xbFTi8iCFcpk+UE=@vger.kernel.org
X-Gm-Message-State: AFuF++mAQHlTaeG+uoL27hdrAsSzVnpqp8OmNr4EH0+eWM1T20DVvIn0
	mjnR/7bHSBCWOiGhfsh932YwzR6EuhWfS076LmTMRYpew2TU2Gg5AjZS3OCdIaKPT2YdGikfuGS
	hyqWsjbilyFHLNDWVm9huyK5GjS7Jb88=
X-Gm-Gg: AYBFou3wGyYriZdSI9xKigbV8pf5qnYsF+nZDDiCxLZRHIyss2pZUZWLSu+99Oh3O5H
	KiBdLypcfmitb6K+US6IER6Opa0CR7qCwyenDYRO2LTiJKB4r1ihVoaISUGfg+G6hieW7+JqHxz
	Lu7LpTEUoVhtrH2zLtrvTwaBjBZv5vQYdOnO/COQxKA80P6DE6d83yvxzqETSnTrnLnbX29I6xH
	kSW4DvaKRMZlAh1mM/ZygkaDsFzUEDY2bdDZ3WkKBPEQv2B/HtsPPvD7HGwwY9ixdESkoVgxlOD
	DTtuvgnmXhkZrre+Zspnr1xxfUsyLknXBP83ZblLmcrLCz4LHKFrGN0OM3IIWLQ2qRj38gQSIaB
	1dnSysHPXGflAYYX2UoLn/N4=
X-Received: by 2002:a17:907:3ea4:b0:c29:6bf0:eb5e with SMTP id
 a640c23a62f3a-c29f5228faemr859476166b.2.1789815732565; Sat, 19 Sep 2026
 04:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917161335.1020405-2-bestswngs@gmail.com> <aqwjutKiee-W4k1T@devvm7509.cco0.facebook.com>
In-Reply-To: <aqwjutKiee-W4k1T@devvm7509.cco0.facebook.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Sat, 19 Sep 2026 19:01:35 +0800
X-Gm-Features: AcwNN1UE85QfdP_kbjc-baoQeq67vzozL6doVAA_AiHVQ5JgKm4qrrP1ao7fCOs
Message-ID: <CANgPUi3zTjaK5W3mp1-xoLoQmRmqvwMaG_68cNXN0gHmvp02GQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: reject dev-bound-only programs on other devices
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, xmei5@asu.edu, 
	stable@vger.kernel.org, co+ac0a8c41de69121d@bugs.sh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <sdf.kernel@gmail.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=881=
8=E6=97=A5=E5=91=A8=E4=BA=94 01:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On 09/18, bestswngs@gmail.com wrote:
> > From: Weiming Shi <bestswngs@gmail.com>
> >
> > __bpf_offload_dev_match() falls back to comparing offdev pointers after=
 an
> > exact netdev mismatch.  Bound-only programs normally have NULL offdevs,=
 so
> > unrelated netdevs compare equal; one loaded on an offload-registered ne=
tdev
> > can instead inherit a real offdev and match a sibling port.  An attacke=
r
> > can use bpf(BPF_LINK_CREATE) with a different target ifindex to run
> > metadata kfuncs specialized for the bound driver on the target driver's
> > xdp_buff.  Running a veth-bound program on tun reads beyond tun's bare
> > stack xdp_buff as a veth_xdp_buff.
> >
> >   Oops: general protection fault, probably for non-canonical address
> >   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017=
]
> >   RIP: 0010:veth_xdp_rx_timestamp (drivers/net/veth.c:1673)
> >   Call Trace:
> >    ...
> >    tun_build_skb (drivers/net/tun.c:1739)
> >    tun_get_user (drivers/net/tun.c:1856)
> >    tun_chr_write_iter (drivers/net/tun.c:2091)
> >    vfs_write (fs/read_write.c:595 fs/read_write.c:687)
> >    ksys_write (fs/read_write.c:739)
> >    do_syscall_64 (arch/x86/entry/syscall_64.c:84)
> >    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >   Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Restrict non-offloaded programs to exact netdev matches and retain the
> > shared-offdev fallback only for genuinely offloaded multi-port programs=
.
>
> Any chance you can also add a testcase for this under
> tools/testing/selftests/net/bpf_offload.py?
>
> > Cc: stable@vger.kernel.org
> > Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
> > Reported-by: <co+ac0a8c41de69121d@bugs.sh>
> > Assisted-by: LLM
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >  kernel/bpf/offload.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > index 0d6f55695..8c91d00d4 100644
> > --- a/kernel/bpf/offload.c
> > +++ b/kernel/bpf/offload.c
> > @@ -698,11 +698,14 @@ static bool __bpf_offload_dev_match(struct bpf_pr=
og *prog,
> >               return false;
> >       if (offload->netdev =3D=3D netdev)
> >               return true;
> > +     if (!bpf_prog_is_offloaded(prog->aux))
> > +             return false;
> >
> >       ondev1 =3D bpf_offload_find_netdev(offload->netdev);
> >       ondev2 =3D bpf_offload_find_netdev(netdev);
>
> [..]
>
> > -     return ondev1 && ondev2 && ondev1->offdev =3D=3D ondev2->offdev;
> > +     return ondev1 && ondev2 && ondev1->offdev &&
> > +            ondev1->offdev =3D=3D ondev2->offdev;
> >  }
> >
> >  bool bpf_offload_dev_match(struct bpf_prog *prog, struct net_device *n=
etdev)
>
> Why also have a null check here? Why doing !bpf_prog_is_offloaded above i=
s not
> enough?

Hi,

v2 and self test sent. Thanks.
