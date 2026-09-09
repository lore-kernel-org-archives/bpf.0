Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8255848595E
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989707; cv=pass; b=PrvTr3PsvPBxaB0UQ/oqVGWAq6n9Z2EYcjPkZoUeu4gNG5mg9fJii9tFlGCLgfN2KrXNzB9Onwg1rLj8Siy7GDa2BKZ/zRidPiBhflW90GIo+ov+qZxpgvd4lyIZ3N0NHu3umtz6cW7Uy2uoEhPa8TFUbkPbzIfNiMgxwm0m+LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989707; c=relaxed/simple;
	bh=3oNUmTrYWtNLjHBd0tZgzihnKQzz3N1wdYYyGkA2BrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRNwn+FMmWno5ZRVrhWsw1SMzAMvO9IDmBA32r42l99sHL0sSBhnVNMgPcI4v1lwpKlfLtsroY5hCyiiGSiDFqMDBrYl//Ctex3zt/p5HXkgU2qu7tSvfmW1OgRpiHzrMuiBhKSDzLJUqKW/HRtiFhteso2E8IZqvFHj/9ptZJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=au4AayOt; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="au4AayOt"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c255c58156bso1339607166b.3
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 14:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788989694; cv=none;
        d=google.com; s=arc-20260327;
        b=HKzOXF8h+mR9cLRh8wmF7qaDFidRy6sJTHD8YcBLkHdDQjilifLxmySFQwjIU8Fi0g
         HOGJXzBvPyBVsIF2A3i98/KbFj/TpRwY0PUZCyVQ+ansWbXYE231bQavlE6crRoyr59F
         a1IZxkcWH0j8Kv1aT8TtSda0OHYZogLbAx2JQlQZFUApgG0BUhlrZ2oR/Ea3/TljM7uQ
         N4FHnGuW5jlf6z4vnmceOHMer0euwAsOQsz28EwlcAls+y9bbYDEvWjXxaZLKTfwIWBn
         5Km4m9erq1MiR8j9YJfqShC+75dAbO/Enu345XE8fNR5pG+gCBnsrR6UaILjXp8TxeVk
         802g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v/5kGipgpDimrS6n35sjSMetEnTNyDyUhJUmOMfkSZ0=;
        fh=16gAbFa/Zl8APX1RLLFDOS4Xn21Wb84fbPtMUsBypMU=;
        b=IVvOPehc/rzIjTA82l6fYOzeB+840jXDSYNpSny30HagYwEJTM8VJVgMvgon6yhfwj
         jZ1AMDHYe7JvWxEMcgdaPwIASG5k4KPHDEsbhjrrdN/AnwJODOrGcekbeQ6soD+UIcm5
         gsChdAwIMSmGO3UzD3phicdsCK6cXB/pwkckpjzm2tmTl857HpL52i7mgVgb1nd3KSKK
         JVxs1aGpgB0+oq3lQIs5DiytwcPdgTkmK6YjP+4E2LvXGI8uVkw+zrMbzc30rmCbv8at
         Sm/lMv2fcD88Stai51GkoPxFlnqCbbtg3b4ey2pGomjROn8DW37AS6u5+uW1f04GPsII
         FKxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788989694; x=1789594494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v/5kGipgpDimrS6n35sjSMetEnTNyDyUhJUmOMfkSZ0=;
        b=au4AayOtRxAKx7VLLvNXC1qGB8insGW0x1xoVE721TOiaMX9R1tFikI6fcGzfjzrPO
         AGAVwVlT1RAxfmUDqjEDkHtNicvREcnCYRxfHmlbIQpCT6432tED7oOaq8qq/kBD7mMm
         eZWo1im8Buzkg/ni94bV4G6+XTJU3zBnBkLbyofy/k/9DpXF6ENJEIQzfD+/hDKrprKt
         vd7COyIZS+kEuQuJF1O0uYaN3QCEsfYClsM7avH0TL3GPfkJuSxNDRUAkYI7SLh86DEx
         I1GCGfpVSIt0Orwx/m8XuIsO8IHQFa76UMG8dbGXcnvL1zUgMRpa587ZHFmQeAahvhbE
         ftyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788989694; x=1789594494;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v/5kGipgpDimrS6n35sjSMetEnTNyDyUhJUmOMfkSZ0=;
        b=HXMWiD4Rs4+LCHOUf2m5C9LM4hpTkIBXL2AaOYoyvo8ApXgqDFyiJEnBZJIbAHLHkE
         SzK5iozT16hQ2/th8nbdBAv5sCaj+nX1dUnrJJh6xsLkt5BR4G+GUHEi49YueTFBCUkD
         VzQ8WNO5TKZfJrRw/xDAnvdDhPUNkei6vdUf0upBTsraPhrsEmYun0jNYS2TswSV65O9
         vlv91S7n5kzAO4xlIngVkoHCCoJWeJ3rpq0pl3aA63THNgyxTEKusT1QSMsfec4sgLXa
         pMJJxh7VZoXYrrAlN9t4pnejrrG8LX6jVkAUBp3euxoyJ16cteRSHgO/4YWaU5rNfJST
         pkzw==
X-Forwarded-Encrypted: i=1; AKwUvByyd55mYfr91ZkZCIgRE11t2W92zT8bWRAb99AoFKQTVZmCZZXZTeqAdsj1Crhoa0wkjlY=@vger.kernel.org
X-Gm-Message-State: AFuF++ngvC2HBYS3sqHwZUyCHTPfIFhmdlTl5G3yWu9NzD2Nw5j4v7il
	26g+M7LRVo0o8Pi3l2KMgnNd7bEsuvpEUAlxyzmx6ugh5/r1YPJ64Die6XyAuxrizPS5cS6y3G+
	FIC7pGXiFKIz9AmPbIoTxQJczYHn+vwDwc9dlB2cf
X-Gm-Gg: AYBFou2T9SL32VHS6O4aue0JH+SzepiYUYmeMKkzR8NDqaCv9dyAwUuuPbrocL5+vmT
	55p65mch8AzYysnIS8LB+PbfNvoL4+YMP4bUM9Si5KGabdtbU9BGIbRwjfGDFzeGKMy4Llie/EV
	/daWoBzrOC16wCfnjXUP5q0iYO9slSo26geGL7vhDfSmeMTG+y+SYQ8O93DLgvMzLFS8PM8PYCf
	jgNIwx3xVZh9+y58wjb46FuKggrOEgcAUZAXFlAolmDnXJNvH+34PeV5H2C01iug09pLBnRZ/mn
	17kMxQWYSRGAf6VsR/VToPJ0mPko+NhPB90Rhd0yAemKpLghxiLTZ/LqAh5bjS1XQfLHAAL3vlS
	GFt287vZ911g=
X-Received: by 2002:a05:6402:42c6:b0:6a7:fb24:264e with SMTP id
 4fb4d7f45d1cf-6a7fb2427d6mr11476660a12.34.1788989693583; Wed, 09 Sep 2026
 14:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909193719.518517-1-utilityemal77@gmail.com> <20260909193719.518517-5-utilityemal77@gmail.com>
In-Reply-To: <20260909193719.518517-5-utilityemal77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Sep 2026 17:34:31 -0400
X-Gm-Features: AcwNN1VsK6p9PaFEMp2PujAdfTIJTXAYr2yXrUJqn7w6sJuHfrRDFgEKLUlYFeg
Message-ID: <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, matt@bobrowski.net, mic@digikod.net, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	casey@schaufler-ca.com, gnoack@google.com, jack@suse.cz, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, eddyz87@gmail.com, 
	memxor@gmail.com, jolsa@kernel.org, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:37=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
>
> Add security/bpf_lsm_kfuncs.c, the home of the kfuncs exposing LSM
> policy objects to BPF programs, with the first of them:
>
>   bpf_lsm_policy_release(object)                KF_RELEASE
>
> The kfuncs are the LSM framework's own BPF interface: there is no
> per-LSM kfunc and no intermediate security_*() layer.  Each kfunc
> walks the matching hook's implementation list and calls the one
> registered by the LSM whose lsmid the policy object carries.  Calling
> a kfunc for an LSM that is not active or has no policy object support
> fails at runtime rather than hiding the kfunc at verification time,
> so BPF program loading is independent of the boot-time LSM
> configuration.
>
> A policy object reference is meant to be handed over through a map
> kptr field, so also register a destructor for struct
> lsm_policy_object: map-held references are dropped on map teardown,
> possibly from a context that cannot sleep, which the
> policy_object_put() hook contract accounts for.  For the same reason
> the kfunc is not KF_SLEEPABLE, and the filter adds no per-kfunc rule:
> releasing a reference must be allowed wherever one can be held.  The
> filter itself is needed because BPF_PROG_TYPE_LSM and
> BPF_PROG_TYPE_SYSCALL, the two registered program types, share their
> kfunc lookup buckets with other program types.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>
> Notes:
>     v2->v3:
>         - No change.
>
>  MAINTAINERS               |  1 +
>  security/Makefile         |  2 +-
>  security/bpf_lsm_kfuncs.c | 98 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 100 insertions(+), 1 deletion(-)
>  create mode 100644 security/bpf_lsm_kfuncs.c

While not a new concern, it has been a few months so I want to mention
it again to see where things stand with the BPF crowd: are the BPF
folks still opposed to BPF kfuncs in security/bpf_lsm_kfuncs.c,
similar to fs/bpf_fs_kfuncs.c?

If the answer remains yes, the BPF devs are not able to tolerate
kfuncs under security/, then I'm afraid this patchset is stuck.
However, if the BPF devs are willing to ACK kfuncs in
security/bpf_lsm_kfuncs.c, I'll add this patchset to the review queue
for the LSM tree.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6215fcb07770..ba816d7ee127 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5081,6 +5081,7 @@ F:        kernel/bpf/bpf_lsm.c
>  F:     kernel/bpf/bpf_lsm_proto.c
>  F:     kernel/trace/bpf_trace.c
>  F:     security/bpf/
> +F:     security/bpf_lsm_kfuncs.c

We would need the maintenence of security/bpf_lsm_kfuncs.c to fall to
the LSM framework, just as the maintenence of bpf_fs_funcs.c falls to
the VFS.

  % ./scripts/get_maintainer.pl -f fs/bpf_fs_kfuncs.c
  Alexander Viro
  Christian Brauner
  Jan Kara
  linux-fsdevel@vger
  linux-kernel@vger

--=20
paul-moore.com
