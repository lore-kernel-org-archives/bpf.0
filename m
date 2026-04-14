Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD535344DB4
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776149779; cv=pass; b=WFFWwdoXl2Ek7wt95XS0v0nQoT0jPKkRgzrup3diSxjitaBJBtrtZSJWg2J7phHuKaBAas42zAxGaY19WT4TLO76wFeVvtVKffzTYf7g3L0jNHsIBDSDW9Fjq9X4K04ULBwyiI7580oCtzwQGnhAf0nu/wvxxvawjsckOYThM/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776149779; c=relaxed/simple;
	bh=FNovg+WGK0FYe9EApLvLWvjFIrz5hE11TT351953qnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5oUAjwKymN5yX7NL2yWb57K3GKG5ApVGN98hNeDXyBr1TmfkHaPdIp5mt/7W+0mDvO3Kdb11oRX6X00uiB3YXCpukguPO+RJR+kfwEzyNBi1iQaHWVwdTjC5qipH7rQsKwagPjjOy9RH8dGFtBrUZBjochAdgrO1H9iQrD6Z7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFLgDNtU; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFLgDNtU"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651b4d09141so3378569d50.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 23:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776149777; cv=none;
        d=google.com; s=arc-20240605;
        b=MYR4ygnKdh9LdTR87xlQoxduOUgjYlpwqua0Pfjwvh2Mix/izJdi3KMM0KXgnb3f7/
         +teDS8ouMjDbJ/SQ5MFih4TW7+jYofPHN8Ngvq+w2XK5G7d7n09xSYMt+EyEL0iYnQ/z
         X6lU8BDHki4jqHXjK+pnwHcAOgZHClluJkjejifZP3Gthz8E+nnZlaT5gkY/6O36caak
         uU4+ffhTxLbckkS6O8wEK8Ael0ku3U4ohev0gE+KYCImDfkIis8KKJOMcv3ybiQwZwLL
         i2jsIbwNB49k3xC1AGPRl/EaEBnQADAja2VGDAUrcNtrMhfjHbQTjZ1G7AQGnD1lP85P
         hnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DCOz8scOcwkVLDmo5GfYNSIt+ob6A8z0Jj+QUJq0Knw=;
        fh=Emqdds5EqNOJ+YSWcFSc3ksYF3iDQplIEffyrGItPt4=;
        b=jACuzJesu9ezCeQqdw75ZbNTcEpNCf+EWhWNDl5wBC09OmwEBPCg48Wqfbvx/WytIq
         CfWRZl4ngCVXvb00iYV4goGL2dueR/wh5Z1ruWMyjrFrccxMnbKSfmnImmX2TkV1NpQx
         NYhtKQISRv7lA+fCfXWudhJZFqIk4sVqwwJBhhfScpQ9nKRE385AgMaTq9ZqptTvGeJh
         s2RpomZp3fRo9sSKBNVG2IFtSd5umRM0C8HiZMch+9bjQVl6jAD3RFoSz4BcpuN2Nre/
         fHCfUpm6CzEpRrWV/1aegan/7qXc5VJDrmRcMKREAkXRJhFsVKwa+NqAaN5Zv9sJohWu
         OEzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776149777; x=1776754577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCOz8scOcwkVLDmo5GfYNSIt+ob6A8z0Jj+QUJq0Knw=;
        b=cFLgDNtUQYpCD7748zMSc4LAHpdwOuyXBaG3wyr4KAeID2/L7mfbv6ZRkimDR9BFWu
         XXu2eaBEyw1M0IGrtNgSVt/IEyvnaMaBU19vZdiS/CFkkXfoHCa11mo7dTI47l7EVUlD
         0vE6qjLZRkqr7ntrHrFCTYxsNdCcngmgE5AETXAgeeXwg5swoSAlTEVNuIRil6ZmoE4T
         wuLsOaQtZDRoIV+2PA4uR1WWc9J9YPBF0ncNitHr6WltWwChhi42PZVbfzbEnWcVowuq
         s9zER/L08WYce0pyQFNlji7zGjtgzKiijafIaM6ZIy0yz8s2riyr8I8nkcjlwaX8RY+5
         MNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776149777; x=1776754577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DCOz8scOcwkVLDmo5GfYNSIt+ob6A8z0Jj+QUJq0Knw=;
        b=k2pLSM7AYqvzwIu2Xz2wV24WtCjRiw0089v94l+Bd/AbxvC3zot5oJ0icYVCkBeKUx
         sFR0xLUQGrOVM7bquOROAaFBoO9UhouuaB3Sdo44E8a9wpL1wY73RTimTRVg3GZWMYCn
         ChV739HOIGUoMrxXKuh1V7w7mHtleJ64cfTbahdvGarHAEw2020JtOOE809QoSxCE2JN
         oIOzmjy9Gbqd+obNNNEBik/oLcS3KhExLIwxvFvMQNDNn4HAlIPodLni4BmNIFqR3eKq
         3Fwdhqp8gXs4m0fhZKB48wsCpN6T1zlFQghHAtXO8O5I42bGp5+FsOO65biUzV+n6wMh
         /ZbQ==
X-Gm-Message-State: AOJu0YwxRAq2KO7RHZqlTgI78XR3bN/4damDUeAKyzKjIt5gzLuf5P/U
	HV0+j3mmCCjIOdGQdl/fsiuhP5XowbRTFEkFfVTxyQf5Um9SbTBSRPn0tRkuki6z2YC3bxs+Zi3
	ToCKAOiEdmmCFhd86nElum8ggl5ArS9c=
X-Gm-Gg: AeBDievhF6hUNalVdXZ7grwUcQpxlwdXOuVLJ+cGjSAl/HX3neUk7jIa/J3wNv/jCPJ
	wyYcXbZqEbEXdMm6pR0CwOZbCYVSdP2Vtald85Tupu8z0s5XWgJ0uyxqnHaM9pDH8dhVhV0xDu8
	tjtRftrbr+MpAYGjT2i6pRoMDP8UML3ijeWoiL3NhaEl7zPXnHaED7S+rwF1wo3LIfVgXmrL8+8
	xSm7v7r0VoDaXYm3LexfDNwyrtNKH5XGShoTx/0fJm4LcZ530H6bWXLlvtmpgjDBNiS2SycgSfA
	IBdbwZZj54DRkSS3U/s52shWmKp+6b9NX+jNPXSC
X-Received: by 2002:a53:b08d:0:b0:650:1aa5:856e with SMTP id
 956f58d0204a3-65187254a7bmr11021537d50.37.1776149776771; Mon, 13 Apr 2026
 23:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408175217.1011024-1-song@kernel.org> <CALOAHbBpK7YBz2Y8YWL0=0dLz5DLUa003y4b8SMgB+BVjePeOw@mail.gmail.com>
 <CAPhsuW6-YEkJYKiC7M_jBsJWRT38B0AN0Y8x+yWKn9cHoVu=Uw@mail.gmail.com>
In-Reply-To: <CAPhsuW6-YEkJYKiC7M_jBsJWRT38B0AN0Y8x+yWKn9cHoVu=Uw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 14 Apr 2026 14:55:39 +0800
X-Gm-Features: AQROBzDM2dGF10tfxBvk0wEdlOg__8JokLeWTUj_lH1DVJQzlJfdgmN000M02Dc
Message-ID: <CALOAHbC1K=3y-U327GtrJO93f1ra2jxg3mh865DSuEG+VFbMSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add BPF struct_ops + livepatch
 integration test
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, jolsa@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 5:42=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Sun, Apr 12, 2026 at 1:44=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> [...]
> > > +
> > > +/* --- Module init/exit --- */
> > > +
> > > +static int __init test_klp_bpf_init(void)
> > > +{
> > > +       int ret;
> > > +
> > > +       ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> > > +                                       &klp_bpf_kfunc_set);
> > > +       ret =3D ret ?: register_bpf_struct_ops(&bpf_klp_bpf_cmdline_o=
ps,
> > > +                                            klp_bpf_cmdline_ops);
> >
> > Is it possible to integrate this BTF registration directly into
> > klp-build? It appears we might need to extend scripts/livepatch/init.c
> > to provide the necessary support.
>
> Can you try the attached patch and see whether it works?

While your klp-build.patch generates the necessary BTF for the
livepatch, it doesn't actually handle the registration of specific
struct_ops like klp_bpf_cmdline_ops, does it?

Consequently, this struct_ops approach seems to require a hand-written
kernel module rather than a patch-generated one, as we can't trigger
register_bpf_struct_ops() from a .patch file without modifying
scripts/livepatch/init.c.

The primary motivation for staying with the .patch workflow is the
scope: a standard kernel module is restricted to exported symbols,
whereas a patch-generated module grants us access to non-exported
functions. Am I missing any alternative workarounds?

--=20
Regards
Yafang
