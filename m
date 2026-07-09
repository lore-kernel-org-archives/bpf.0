Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41B14499B2
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627279; cv=pass; b=DuHCQGlKug05z2+XTBlde5CbEUTEn9rlUzBmO8iGLEjnMri/n+64mgKQhh/t3yvdW+dpkZwoQenjVJ/c1ieQtTkj4ky/OofXG/AcPwgPiErEPcClTB0R+9LbNsY6KQJ/bDzUI+IzTpkaOD+I/Xxyfl7Sjk3RTVsOHDRnF/WzK48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627279; c=relaxed/simple;
	bh=w17eX4Jkmr+FsItCPkabrTfffyNgjO4WCwf8MwfNxw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESrMyxZySt0G7mub5HIIplT74nfVHiRLwgE9hGhDJpvYUDDU1Ftu4pDTba610GxcXLsITM5LSM3ewRCB6N36VYNJslDpPMoKL0J8zlAh6xesegORzE7O2auS0ar9a0vs512N231giurkttKaFXiqn6neIycELeX5eJM4acj6SLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBi3k4TI; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBi3k4TI"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-667bae10ba3so178494d50.2
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 13:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783627277; cv=none;
        d=google.com; s=arc-20260327;
        b=EEuilJ9KUElXZkm4pnPAdHmq4H/zC00gB/NTaMmowKhgl/loOXQX/fNjwBoKxOfZwt
         oWeFUFdPyYqfn9wkBj8SkkCOBw1d8x8WlWvYIXJtScEbk0l9yaD7sbK00GQxqA2GcSDV
         c6HpdmX0cZIGC4dwZveUd45Q/T2xei41Z8ZpH6SLPKmKBw+M7bwPf1oM/ROnUAaoL9g0
         R+unBocTDRU3CHx85c7PF+Y2rlVVkop/tPBkaT4gPo8Lv++0zAeZoMgyAQNJ6FfyutVo
         xsj54uGWVR4+jUWgg2O8WP5xJgMw0QRQtGMi1//uM42gH5th8jhXoklBBDZORQNtEQLS
         tmgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UdaAx5E3GxIJv4e+ntEXnbFwxYgeCSAWQNtuiLCa5yo=;
        fh=ocfAnOMxq5+8/MZ8ziz5LwGsdHdhgWR5um302BDLP2E=;
        b=mMNi1yeTpCqm6SAdqG7THCp2Hufa7HqiH+dvVbCVSEbi1LXeGfg0hXp/6skBwVT5vY
         UQedR0q1QUNtDImpsHXsw5qPIOF2OG8G0JVZ2Kk5fRvIdTfUtQ+9s/Gf5mOqOa3V767k
         /7jDebZ5S8M78wnrOgIguSfu22ac1zejrMaW4r2bmw8Z8r8JV5yCBKcj9jXu7lPB2cjn
         VCjKb3cN5fzXVuzJ5cZniUJtQn3rJryuPkd0CKaNuzDGGcdAuIABZbWFDP+rkUoipfrW
         W11Q9ibZIysZ2WbXwtAryFR5XreARQZDJWWcbuZK8ksMVLDGobTHkDn6yTl7cKWHzMij
         KQPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783627277; x=1784232077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UdaAx5E3GxIJv4e+ntEXnbFwxYgeCSAWQNtuiLCa5yo=;
        b=dBi3k4TIWd43+q7G7Yvma02Mk+ZsazjBN3m/UL8VPcZX4/MaWbaK4HxNknak72fYO2
         RV0/FSA13ddAy0OPmZAPWqatFuBMUgTREl9r7L2Y4+79bdlhyyWJJNpLMb+N8Cmaa9lw
         C8aqrBWI61cS7z9jqLacu0xb7yDHEAe2TVTZlOwrAR4pdFDsI3bKz1Bhh6iiInKrOxWw
         AaeU/+N3zDrsDHojmlymtweIE+/YCIc2qO6jmNaHixHA6E+LI4+ZiRwj/tl+6GbasLu5
         FREkWvvRHVfLCps1zfn+15NurkNo2is7EoaODMMW2i98ipsf3qFy5fiMPR8B1Zz7r2LF
         JXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783627277; x=1784232077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UdaAx5E3GxIJv4e+ntEXnbFwxYgeCSAWQNtuiLCa5yo=;
        b=E2uQYpxK8LLancKlUBX2mpcEoiIwQWyiZDFhJLPsoA8Lri/gVljeyCRmlXnfx+4yCr
         UH8ugF/j4aVJwCbqaMfW3AjlALwe8y5wXKVbdQ+Dd+V2ey9OybtdPqFayJXXaKgoTNlO
         P9JZKZyjf+E1tvEnr5cE3JNOXlwxDoARF1YO1HOboogj1eC5Ot5nv54/H/S+EiewHzze
         Of6kcu1omGOBWntEfmOmUh++iq/qMIlc4r5SU2CXkn8WC0+6ayyNRqn/S1dsPTIGmqrG
         to+UewQapLx37JmqVOTfvfCw6NpWUQ8zPibw6bCmE33zXJtJcTd/zIDNhd1kmYd3FtaA
         h9vA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3amXL1E1vaCkb9Jyih484DCzYdmYNdn8TGvFlte1Mh5cAl5Wdv22DA8LR9+4nQM1fYCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYdeZdB1c/RjwWG45bQL/wfVnIQ9uggAOMr4XOmP+zS3b90R4W
	jM+iBSbAuoZQoVGKDN3mqyUO04CxCurchGsL6KP9E9+Oeajh8wYkU5oEybH4jSwCsxUNK4xy8C0
	BZoas74V3EP7wAJ+DdOCqz3zYHy0ggIs=
X-Gm-Gg: AfdE7cmN5y+7daituT8lvTh+TvvM9cbV1fY2FjxIpd3yMA8zv+/rwY2VKVqcB6xtWqA
	EmEffwAaDDDblJjJxUepk+XoWMWDmyddgKERNgm4b4tzO/36y8IvJ7Zl84bhuO869O3G1IbhEWp
	qf0daKKJhAp8/yy8505/GQah/vAGJQAIsGLizEH9HS66zCEOtUgNg2+aobVBbGbvb/vR+vxXT1G
	Z6dACASYboKl+cnganuyr/fBSfxA/f2hsZkOh50BP7RAjcT7Fc1V7JydjyS+1Jgn3E0SSnGzz5g
	D4aH7FexZg==
X-Received: by 2002:a05:690e:458a:10b0:667:b314:aea4 with SMTP id
 956f58d0204a3-667b314d9ccmr3503746d50.16.1783627276609; Thu, 09 Jul 2026
 13:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709155837.1879230-1-main.kalliope@gmail.com>
 <20260709155837.1879230-2-main.kalliope@gmail.com> <20260709161557.794E01F000E9@smtp.kernel.org>
In-Reply-To: <20260709161557.794E01F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 9 Jul 2026 13:01:03 -0700
X-Gm-Features: AVVi8CfU-FLHyOf2gmxnebYvCzxCj6hmKslGaI-cs-0STr_UKds8Lxhcdl5flWY
Message-ID: <CAMB2axMeZbxWry=P5JTVo_xDw7TUeUKdK6X0_LKjvLWnLJyHMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: reject rdonly/rdwr_buf_size kfunc
 arguments that exceed u32 max
To: sashiko-reviews@lists.linux.dev
Cc: Nicholas Dudar <main.kalliope@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 9:22=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] 32-bit integer overflow in `hid_bpf_get_data()` allows arbitrary=
 out-of-bounds kernel memory access.
> - [High] Explicit 0-sized requests to kfuncs result in out-of-bounds read=
 due to verifier BTF fallback.

I also noticed the second preexisting issue when working on a patchset
unifying helper and kfunc handling. The patchset will fix it.

> --
>
> --- Patch [1]: [PATCH bpf-next v2 1/2] bpf: reject rdonly/rdwr_buf_size k=
func arguments that exceed u32 max ---
> commit 440bc8eb1e0c84aa93160b0ebdb9ef4731dce2ea
> Author: Nicholas Dudar <main.kalliope@gmail.com>
>
> bpf: reject rdonly/rdwr_buf_size kfunc arguments that exceed u32 max
>
> This commit fixes a truncation issue where a 64-bit size argument was
> incorrectly truncated into a 32-bit field without a bounds check. It reje=
cts
> sizes that exceed U32_MAX in check_kfunc_args() before assigning to the
> PTR_TO_MEM register.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 233472a871be5..c7fabe50e4874 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12097,6 +12097,11 @@ static int check_kfunc_args(struct bpf_verifie=
r_env *env, struct bpf_kfunc_call_
> >                               }
> >
> >                               meta->r0_size =3D reg->var_off.value;
>
> [Severity: High]
> This is a pre-existing issue, but how does the verifier handle an explici=
t
> 0-sized buffer request here?
>
> If a BPF program calls hid_bpf_get_data() with rdwr_buf_size =3D 0 and
> offset =3D ctx->allocated_size, the bounds check passes:
>
> drivers/hid/bpf/hid_bpf_dispatch.c:hid_bpf_get_data()
>     if (rdwr_buf_size + offset > ctx->allocated_size)
>         return NULL;
>
> The function legally returns a pointer exactly at the end of the buffer.
> However, in check_kfunc_call(), the verifier seems to misinterpret an
> explicit 0 size as an absent size:
>
> kernel/bpf/verifier.c:check_kfunc_call()
>     if (!meta.r0_size) {
>         __u32 sz;
>         if (!IS_ERR(btf_resolve_size(desc_btf, ptr_type, &sz))) {
>             meta.r0_size =3D sz;
>             meta.r0_rdonly =3D true;
>         }
>     }
>
> Does this fall back to the BTF type size (1 byte for __u8 *) and incorrec=
tly
> grant a 1-byte read permission from the out-of-bounds pointer?
>
> > +                             if (meta->r0_size > U32_MAX) {
>
> [Severity: High]
> This is a pre-existing issue, but does allowing the size to reach U32_MAX
> expose a 32-bit integer overflow in hid_bpf_get_data()?
>
> If a BPF program calls hid_bpf_get_data() with rdwr_buf_size =3D U32_MAX =
and
> offset =3D 1, on 32-bit architectures size_t is 32 bits. This would cause=
 the
> addition to wrap around to 0:
>
> drivers/hid/bpf/hid_bpf_dispatch.c:hid_bpf_get_data()
>     if (rdwr_buf_size + offset > ctx->allocated_size)
>         return NULL;
>
> This bypasses the bounds check and returns a pointer to data + 1. Since t=
he
> verifier records the returned register's mem_size as U32_MAX, does this
> allow arbitrary out-of-bounds read/write access to kernel memory?
>
> > +                                     verbose(env, "%s rdonly/rdwr_buf_=
size exceeds u32 max\n",
> > +                                             reg_arg_name(env, argno))=
;
> > +                                     return -EINVAL;
> > +                             }
> >                               if (regno >=3D 0)
> >                                       ret =3D mark_chain_precision(env,=
 regno);
> >                               else
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709155837.18=
79230-1-main.kalliope@gmail.com?part=3D1
>
