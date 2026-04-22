Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5030328B7A
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 21:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776892893; cv=pass; b=e6rdlYuYZp3wd8hjqOwLCT9NqNy94dEDwvho30eZENSlmnl6n61XWn81Ow9kohat51dmc1zREGzJCsqZmaLyPTwVnn52YMBw0FoosTMi/i+K2yNDzTQKYGCH5KVGRE9xtXI3ZGcoDPeDIIdwlto9HpuT5iDY5qnoLWy6rU4w8cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776892893; c=relaxed/simple;
	bh=9zguB9XlBxZ6vFmLEIJe1T+7HqRL81DEg3F1nGal+lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ap+bhIynOIByt0S+o+H7771LBjim4KSOCEqVLWmkp6RvtwpiEJi05ytRf032RTPypbmMm0c7tdTPXyt8uZrSYFaOwbz4bBWvD81ORixk5FsIOyGJXhFjVs9wdoRQjMIYoDXjAvMSn7vO2EU6wgbjOHMsFYR/9Ay4MlDk6TWApDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/+nCvji; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/+nCvji"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso33747515e9.1
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 14:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776892890; cv=none;
        d=google.com; s=arc-20240605;
        b=AZdKsNwBzmdl19PnsTz90OeFe5nTmt50MFBItjqbYFakgkML8dFmFe6XDB5z1I/NHX
         uDn+Xmf7/tBi5bunNvHlpJleBia5mrUUWNQAPakUJ2s926fO8kSb85wIMr5vj8usnP/z
         VWJRkzxAff/ntK3WO6bvBDaTuq+YEch1ZoRGHHIz+8AukYfRx+IAnKGfoTTB1U0fJy3Y
         wpGTk7WWMgAvf4BNvr9aZHicAvA5WftOoTCnsq+7hB+y7Fz9mNG3j0t7v78y0wicnuL6
         kdkJFNp+rQMf/XSsDu+1CIcDsAT8CbkK1P6yFZP+iJsEbxTD5/+AqjyRCoaWRD3kqJtR
         vwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NZuBKfQ2MgYFhVF7PmHxZk/nfgb4kJA+rMrnGSvhZOs=;
        fh=TGKH9mD8wBw6dzqUmkN32u3sLRXs0+cF+AICTv6RX9E=;
        b=eWC/6LJl8DTBMCUgItclaCgTmP5gHPx6r6kDsNUJoLCOoGviwhMWo+hzsNztvzmMdA
         OOEDis9tC0vPA2izwgEsg6nvs7hqsYtnYsW+sYDS+8qtFrupsqota1G/iyhruxQvXLsH
         q/GUEG442sfvKnP+Ln9usl2LTpHuYlj4GgJotwox/323T73FdZ2esu23dVzd4g3NtHGw
         DiDx5svgiGulwBexQF6kpZMTA6+Qd041Pkrr3ToEcg0cY4T7/3xDdcts+gIWqFYMW2B+
         HBYDaZ5dOP2g8t6H7Is4VfZq1XFnPRtV+4bLqoYD8rABMtu21xR/NpG6JA9PngOfb8V9
         +T+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776892890; x=1777497690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZuBKfQ2MgYFhVF7PmHxZk/nfgb4kJA+rMrnGSvhZOs=;
        b=o/+nCvjibiiD/2Gf006phWN/GEl/Ug1+VSvj/Wzal2BvpUFCQl98dMvKP7yHSi6UwA
         7dFOPCRojepDj4uieYG9n3T25XlbuSSlzk+4MV3gX4bMJzXIResjp0IoPqz1ZGtfbKW+
         mRLw4Lj531+xK0L7LPNq3889wROB5dMASZZKyMXnDYRvvPWhD2Km2HgWegF/MQURLCf2
         rwfvEA/U4AaNPkW5BvikSCAN6L2mHM5wXyNmFDpcVgbVWPyKGICnVUNHGsOGZGywX1rF
         XnbolghlDJ7qYaY88kV9UL1JrQ4orTDtcxEbc5tFLu6q9pmfm1+Vh64NTd0PpEnN0zBs
         ++3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776892890; x=1777497690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZuBKfQ2MgYFhVF7PmHxZk/nfgb4kJA+rMrnGSvhZOs=;
        b=Qm8ABM2AsHsU5KTcs2JeIPSY7tMtVaHZ7aBtFBcMk59kvKHkvajcSHZa/1pmxHHNOR
         kwofqyyZmDt4kUQeWseeI/SPRb8U33hxB4D7l/xS3RIknImolh8MSBQrk/m3PBHyj3/p
         baoaQ8AV6foE9rvBCaaRxTyqcTR5LKqUu10jCFP7AYfji4xwJoiIczz9Bz3ok92/Jde+
         IIXumrMLUfdvHIJpfadUlk/KrEXEyagPtUeXh6MxmH51iXlNnBo8vtUrp8Y2X7nCo55W
         hOogQP7OhVzVeoSbtUYpT72znJY7cWrvs7EUdG2nGRt5e8Wk0enLXIUDFha0TLnxTq5B
         ER9A==
X-Forwarded-Encrypted: i=1; AFNElJ9xYrV//Fk2NNj7kaYE/DFQqBaGP60H2r5RKRZihId7fa2TWpdywFs1NXaxXFntjCvPm3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhKBKh/mXorqiauJT+Pnzk2IQD0nOHPVEstxkUdL7t+/IjMm/O
	OMexq3D//EgHt73hPLYwF4ePy3OExD9yAlarN4Mf6Ztt+G2jXwtJWfKolGd1SYEi6EXFBqPtjiz
	TzK9EVgKTOlIBEzgsh/hkk/2aY73/9Rg=
X-Gm-Gg: AeBDies6Azzg91ep9Bt1GpzDAFVmaP0aNH2SLimY2h4WGeX7W9Dyncof2GLw7bLigP4
	FeD27H2K0Z33R7DFThclF4WXPwijCtBClfBS/3E9xYhu/ycfieUo+7AnOhpq/kNz0xKrgyY1R0g
	otqWsDcLy/1uCuDKk655PLLCXkh+rafF3lQ4fUTi7CM68B5M4PllQUAhKCIDLYIPxe/9VYtDmUM
	2HGr0mzhKfLSoABLketGlUkoCOPSITTuDdHPZZ7XHKGmUb9c0I5u4vxwKnmg3fauzwibvIZX5Kp
	BZCfZUBf8r3JDSEjTmbA5Y4+HJ5NX/jcXJwO8Jtubf+kHcwmxvfSKHGtBxCk8zogXVSeS6ZNHgT
	ORAS2VGPaN7qEv1bwT6FlJDeUQSgUcWfTmkOX
X-Received: by 2002:a05:600c:8b8c:b0:489:1d74:56d with SMTP id
 5b1f17b1804b1-4891d7406famr223100405e9.29.1776892889976; Wed, 22 Apr 2026
 14:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422183757.15069-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20260422183757.15069-1-suchitkarunakaran@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Apr 2026 14:21:18 -0700
X-Gm-Features: AQROBzBKSX92AyAmrbDljEpz9q61ZOj6nh6Etsr8XmHktjELlJWEXlMnmFrN-Mw
Message-ID: <CAADnVQ+=iEmyf-=T=V0oW2aK+dgx4S0CbAAPi4pSg=DnaHNFoA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: replace bpf_probe_read_kernel with direct access
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 11:38=E2=80=AFAM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> Use direct field access instead of bpf_probe_read_kernel() for
> nlk->groups[0] and inode->i_ino, and clean up related code.
>
> Removes obsolete FIXME comments and unused variable.
>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  .../testing/selftests/bpf/progs/bpf_iter_netlink.c  | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c b/tools=
/testing/selftests/bpf/progs/bpf_iter_netlink.c
> index 00b2ceae81fb..5930bf8899d2 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
> @@ -17,7 +17,6 @@ int dump_netlink(struct bpf_iter__netlink *ctx)
>         struct seq_file *seq =3D ctx->meta->seq;
>         struct netlink_sock *nlk =3D ctx->sk;
>         unsigned long group, ino;
> -       struct inode *inode;
>         struct socket *sk;
>         struct sock *s;
>
> @@ -35,10 +34,7 @@ int dump_netlink(struct bpf_iter__netlink *ctx)
>         if (!nlk->groups)  {
>                 group =3D 0;
>         } else {
> -               /* FIXME: temporary use bpf_probe_read_kernel here, needs
> -                * verifier support to do direct access.
> -                */
> -               bpf_probe_read_kernel(&group, sizeof(group), &nlk->groups=
[0]);

Please stop sending patches to remove TODO and FIXME.

pw-bot: cr
