Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECE231B82B
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785572796; cv=pass; b=V7UnESWUdouGRDi/53BNyULbqQFNv/EZPwgnCRBTcr9ln+7dxtNwxMCVwZYSp7OQLBmwvn5zu+3PwuGlzPR2UTNeHnMhfy73IU/KZA12N9rFyqcUBiY0xM8om8YQdu4E0oPvUgDGP8fxQr3jlXPNxl8VLk7H4WIxA5FCPRXhKT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785572796; c=relaxed/simple;
	bh=rwbztR+hc2uf4NW6P64LcIx3lFOd0TUXp7tH63qzotM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTvd4PVPquJvFmrr4OxFFSJXlfWOcM0FRRv9KtRDpnMoqcvxaZxOTM8WsACAcy8kflRKTDjBKa78eo+HU88wOnw7ryGgtK5oQf9FkS2h/HuJOt0LGedq2lZxyWUlkY5vQHDBGugcIdwYYV+1oA6VmkQRtCp1ny2q0Jr3/MJUI9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rnGhTGaW; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnGhTGaW"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so2765157a12.2
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 01:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785572793; cv=none;
        d=google.com; s=arc-20260327;
        b=FeoiQC2IvJ282LTaHs0R+qP7C3qc6bRyj9ZwG91TF321mZpgS1xWxBSX8xwRHVfK0s
         M/mViLRIpDhJy9RTtTnZ9dvC/VIB/GSjeJBvSslKmC5lLX16phIisCD1hPNU3LaSRsjm
         vk5i/BtLOIChMdF1BAPMmHSJYAKHLqFpxkBYYHPXPfIEtGhIapJzQBLGsdfWiN0pgeQ9
         pYRlq4ZUx4dvplR9BsjPbRLx3DF/QgF5Lmml85e9Xo5C7YXHhLa2BYJRmQX7lyQ9UbIg
         IZrhlEt3mkyA8XIiNM2ucHOV7UdC8fMP3sD6Rxi7JNMURSvGrS4TtdVpyezlrW/VmvE2
         Y2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v3XtcaEtapzo0C+g3F49Pk9t9Zu0qXoECLQCWK9Pwg4=;
        fh=WTX9IFbhlveKCXOC3oai5WSXhQU9wF9dYI6Ui2imNZk=;
        b=PcqTdjCTxXoa4PpRW72dAbi084PqS1klJ1gHnUzIplZiCI251JqRmM21I2RvwH9dtE
         fU3YbaQ/iFBRoBCYiPfomATqNvg6ZUujATSg5DVaseR2XUYXnuNSrL9BaEUUWwORelnF
         Otu2XYVm5rWDih8UjJQy2AoQBGYa45MRMg8Cz72bjHUKXQkcoj3OzQw5aKZoFsZip1iN
         R4c2YkF8xIZPcQ66S1Xc+OFvO+LPgASTZehNg5EzV0LGBhkBtIf9ZS1F9hm9NciBWy2d
         mRETY3okTgmqXhepWt6Mc/oAA0DqedD6hY3hPY/tTQywLDhkBrVt7ZMuHRhMoConfyG9
         3iZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785572793; x=1786177593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v3XtcaEtapzo0C+g3F49Pk9t9Zu0qXoECLQCWK9Pwg4=;
        b=rnGhTGaWKkq/v3nEBLyvK+2YOZWKUomjW2Voi/ck4gmDmM/7uZVmf9Urs05duP08fl
         0CSlhIVZv9mE4M15CnCBGtUuSLq9xatr1Rkl+CCooMb8rFjXED0PLoUyvOe7QSeNh8PA
         vIfo1O6CwZzIsmnIp5Uof7L7V5LxuiACuqdMK5IzU8N1XIA71RARdBXjdHAGVXa1izj5
         qq2QTplgCf1uVBE5hWIF/rjxj3B10p4zHVHgpSSORD78Worwe+PCZgvRgiJh5TaV8VLu
         jksY1SivSVcaX1WsBXJ3seN09Z2chA3rqZtTy+DwZofOzfn8gC5n0qlFNli/32aGeOF/
         oGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785572793; x=1786177593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v3XtcaEtapzo0C+g3F49Pk9t9Zu0qXoECLQCWK9Pwg4=;
        b=Q/4JieHKfr1uaNin9UMhe0eUtdj8rCXp3uk9wvHST07ZS815vmKC/IWuBCdgU4STur
         NsJ5+w5I/rH2JpvLqfGS1PYZdzo8cWTcxt9XHTsm4VrMKloz9oMINjLFOKWN1+hkWc1R
         LbKUJ/FFp/zAB8P+R7h2YblUYQMebquHd+ptl/B1/XsEFBiPGXRy9ihdaS16SwKNYQpE
         oz5NCiBlY4N4/UxVdsQZBAm8xxfnakgb4Zpc/hw2FhCKCJRlmcUOR3OOIErg8mZYNNGo
         8neLUQMkOfC0YB1IKKOgTrDkiTy1+3Xi6BGfmashXAGRZIP1omieeJrybnWNs00G+G0K
         vBOA==
X-Forwarded-Encrypted: i=1; AHgh+RpqInyLP8nA/D7qBKF5bNkslAr6I2ClVsEC/swKmFM0t44SHHRXdaMw6cyNr2dYVs+VLLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7FvPWoSn97Aeze0La1LOsMTC3gmmkhaeNUA6udSfTDp51Ehnz
	LYRendns8labnSDsDViC4tjJms8gncgRhOwsWv9ZTHy0IHhrm2RAYoA+aa6g4CnfE+Sx11HZqZ+
	Y4LEsiA5aZofByGLriV+zieFdgN7Bdr4=
X-Gm-Gg: AR+sD11kS+BVfNaAKMOKdPjjxY3eKiwxEF92EWitOXa1VtmdzhhLtJRziAzMceURuMX
	xAJTdR05NPS/ur88rI6G2YZBFN6Gtvx5t915fIP8o83TI35Hr68d7Cce++6AhYe+1lfR8N9lxPN
	zBb4tBabnwRApeF3iAHtlxeAdmgIj1cVFbWqkFcyfY2FabT43uU5+86Sz1k4audEBxxFrezsppz
	KG07/1Bvb5BK1Dm0en4MhEsQJtIL966+r3iBElUX8ES099gJ1FcO+tUdTYc8cX1ZsGVx52upVng
	fMJaHLomJOPlk0i5Cc0lgsH2kT7xU8BMTeLKhSP52qjhUw==
X-Received: by 2002:a05:6402:44da:b0:69a:b38d:403c with SMTP id
 4fb4d7f45d1cf-6a0a7c6b782mr1461832a12.7.1785572792620; Sat, 01 Aug 2026
 01:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726070122.2407344-1-zirajs7@gmail.com> <DKBDNFB3WGPZ.GS7M7MY2HNAB@etsalapatis.com>
In-Reply-To: <DKBDNFB3WGPZ.GS7M7MY2HNAB@etsalapatis.com>
From: =?UTF-8?B?7J6E7KSA7ISc?= <zirajs7@gmail.com>
Date: Sat, 1 Aug 2026 17:26:21 +0900
X-Gm-Features: AUfX_my-pYFZ-XPP8zv7R4daRh3IROnR0mixq9YUOBqskq85YnbAh1a2KU5vdAg
Message-ID: <CAB4FuGYv8eUAWzJZB7HbOTktYq-RKB35roAqsT52WxHh_P3VJg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Reject negative optlen in cgroup getsockopt hook
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sechang Lim <rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review.

The reproducer already sets ctx->optlen to a negative value (-11) in
the cgroup BPF program:

/* ctx->optlen =3D -11; */
BPF_MOV64_IMM(BPF_REG_2, -11),
BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_2,
            offsetof(struct bpf_sockopt, optlen)),

https://gist.github.com/ZirAjs/a177ec6d8f2c8ed7d93edca6313a9255

The PASS/FAIL output only checks the behavior before and after applying the
patch. Without the patch, the negative value reaches copy_to_sockptr() and
triggers the warning. With the patch, getsockopt() rejects it with -EFAULT.

Would you prefer that I include the reproducer directly in the patch
submission rather than only linking to the gist?

On Thu, Jul 30, 2026 at 6:36=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Sun Jul 26, 2026 at 3:01 AM EDT, Junseo Lim wrote:
> > A cgroup getsockopt BPF program can shrink ctx->optlen after the
> > kernel getsockopt handler has run. The kernel-buffer variant, used by
> > TCP_ZEROCOPY_RECEIVE, only rejects values larger than the original
> > length.
> >
> > If BPF writes a negative optlen, that value is accepted and propagated
> > back to the TCP getsockopt code. It can then be passed to
> > copy_to_sockptr() as a size_t and trigger the hardened usercopy
> > bytes > INT_MAX warning.
> >
> > Reject negative ctx.optlen in __cgroup_bpf_run_filter_getsockopt_kern()=
,
> > matching the lower-bound validation already present in the sockptr-base=
d
> > getsockopt hook.
> >
> > Fixes: 9cacf81f8161 ("bpf: Remove extra lock_sock for TCP_ZEROCOPY_RECE=
IVE")
> > Signed-off-by: Junseo Lim <zirajs7@gmail.com>
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> It'd be worth resending with a reproducer setting optlen to negative.
>
> > ---
> > Reproducer and warning:
> > https://gist.github.com/ZirAjs/a177ec6d8f2c8ed7d93edca6313a9255
> >
> > Tested by building and booting the patched kernel. The reproducer
> > returns -EFAULT and no longer triggers the hardened usercopy warning.
> >
> >  kernel/bpf/cgroup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index 4355ccb78a9c..c04a244fe2e6 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -2235,7 +2235,7 @@ int __cgroup_bpf_run_filter_getsockopt_kern(struc=
t sock *sk, int level,
> >       if (ret < 0)
> >               return ret;
> >
> > -     if (ctx.optlen > *optlen)
> > +     if (ctx.optlen > *optlen || ctx.optlen < 0)
> >               return -EFAULT;
> >
> >       /* BPF programs can shrink the buffer, export the modifications.
>
