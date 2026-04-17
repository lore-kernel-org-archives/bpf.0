Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9695239BFE7
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776445417; cv=pass; b=tjaOJeV8F2H0nHOGFaBMQOFaGiJqCxjsvONE1Ieumt2Wy5ZrUsXR3QggcduHkm9jSKJRWre7U/6ECJBaw2h0cVdPY8YU2mRbAHVM9Oo3LMlQUru5slFh5tIffbKl7UojYAL+v9OF7N4KGcbFYXbvlLWgW1EqChtA9IiGroc0wrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776445417; c=relaxed/simple;
	bh=Z/DQ/h2QpnobDh8FN5ax3kLXccZNdK9wUMOqOI5GD9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iW5EotbEeAqVThpWkBX9keUbI7KJUWG3cKLCyyvq5tJW0EO0dXsFyuOfeBpSYM+hSpsAj71witV4KDvNTrTRpQ/o+LZDjtcGPi0+Qq7lAyOsg3fMNPvFHKexJNLKSD4qgUp6qfWL7+GiBdpGz+2grZtLgw2EtJvigPjyD+SvD4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPxiKkIW; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPxiKkIW"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso571507f8f.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 10:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776445411; cv=none;
        d=google.com; s=arc-20240605;
        b=TaUibBzxEOzhXi25s1zZWtJw59KUyKPGSzXBZRL3yJUHA+LfQ7AOsYaGky0LiFEFoV
         rVS1+ZB/qb2OxO4UELj5xwkITrcLEydPb8mNXC/Zu7UVVEjDlwGP9NvLhuYCjQvFoMKg
         M0Sq+TRWa2+4LZ+5x9kOt41RK/KLurfglE5TO9UqV+qmukh/7RvlgwtClhAjrWpOj2Oh
         e6VFEmxjKkkNXVyl8nueEbqE/ZwxP3qH5f7n3vUORw2xfI3jvoPY7AXpFTofoXHh4kOP
         7dQBakv7ZVhjNWotA6SOY/6Xy1Kxl26FqSCVFlzkndQWRmBJD924nxqCnFNQybJ0JjLP
         kiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lylHX2HKRCAOi59wI/zvCITjrW4MRuS8CtdU8TNY8Uw=;
        fh=RRLmYqaSbD8jEKtM9GsC9ESBIiAL7apAIFfRHYNtylc=;
        b=eoAXr8HzG6vQmt/BP5Rcwe+MJgBSl2I2PWkeU/kIGRKrFUihElPQU0rZ+nbNLen9LZ
         AEG3+tk6ST1y06FsU5k9Jj/jJX+shjMw+ZpIR8m8/WfDdoycYwTsh1esdeb3ykuG5BCb
         teaHgqZO4sZZttmTHpg1eCjQgciVJF1cotQYVsK9CAyQKzS5eU3QzjltIcfhXMGSmvsW
         aVq0rvEKewoS7JSM4YfXvsJWfloHedMILFr1iWHtV2mN65sSq7aog9BKWJ4v/RY8/nLn
         H5SjRhC6izSeMLGeMe/kFH3EecmSSVd2kTUNo3BaAVkCC6V9ttCoW0cwxKmfVNOCL1kv
         RnQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776445411; x=1777050211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lylHX2HKRCAOi59wI/zvCITjrW4MRuS8CtdU8TNY8Uw=;
        b=jPxiKkIWzVu1JvcObyytyAy3Ms2vW6FGG05FCZN/Mm2EStfnB6XkJJFb/nlR1ly/AC
         2oVo2wp1xunoP57Ekg+jQsyP5LUlxcCwe+0lalCzZFGp1Sb9lj+JWA1kZRFcdvcBm+Uy
         M88PTkNTIPIkeNbRqXeqnw6K+/hSIHHwAI5PS8r0FAGU1D4JTHZ6zcanHkmtoSSC6V6r
         zb7y733rGogNriQUD8/fCnoRyCMSYIJJrbEHIdmGsGj/wSx5+7OM849g/gN1MmDL9XbF
         CRPxnHjHfFJSy8zK6t/3DEhDk3WwlIpQmBOiYruA3hCNF05yX4NdJqp3fwyix42K38My
         /Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776445411; x=1777050211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lylHX2HKRCAOi59wI/zvCITjrW4MRuS8CtdU8TNY8Uw=;
        b=M1KHIS17duUlNoF6MokghhcB0GedgQxBXO6oFbW/K0B6UZJUy5Jnf8nuiBN0rOPofv
         HvqUFNTVsBtaFJapfFtc0lZucL7mgA3SQxOnx7aZVuPNgzOOhEm4q1ye7jsI7IeHVkm+
         tD8q+3VgOfhp5cFG+SkYhU13T0UUPzrxdJoJY1piV1nsdJENRRSYnRQ5mBnG0vZWsVIT
         K3fyqyUpzH0y9fypNizIr13MHW09RWka1XlnaDvewa6+V7avc+Od1rmPp1rONvOsJCdU
         jnlg8coDf/f8BO1eC4LulDIFw1uYC3YPS3xzudoiS7yU5Bq0fCeegGOL3F0XwMBJeVz9
         1VUg==
X-Forwarded-Encrypted: i=1; AFNElJ9NXKXHnVe1a+Dm1JPYwoUGol5vROZemPeUtKVr7E+/ajRp4L3txm1dekZXNdSa5dge0QM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNLLXNpGMuBNs/9Wm+FgjpbW+sPjnoDfe9Bha1l5TTKHtB+HpY
	Znbpc+wvUmG+HQcd4+tMfcw20d7RsR8mn2T7gwGcmP3CLr3rAqO2EXcywvLg7HXZagDpLjYaazz
	FRijorL/sEfl8JLwMM/wIVYa52DZozWI=
X-Gm-Gg: AeBDietvgK7IGwDkjcCNbLg/7YYzkqF62c+NcKJmsyhkE5ktn5kjkWIxmO626FucWts
	7E5FHSBagYGG86X/JuEtgNH32GGhrpEbNbtRLwZR4sZn26BwS9wtA8Ojm0sW+YOhXXc6cwNuiPE
	YrAzQZbO6hTfaMJ1Dj1fUquzTLFSAhtFDGreFORTnvOheB5xc52tSAdO0/835/l7osENXWKdAzD
	dTfZth1Sc+0loWNTq30GWEwgZU6Fp3bklu6iqyTu6o1V79Jhwku5b2mo1mpgtXYiqUtk24s1FTa
	AJwZT1ilUJ9jSnt8BDdCJ3MGPODv3Yiz+hJYTW0JyGs2Jq47wKPg7yU8mhGKB3Bl/ffJuoq4+Qu
	Pd0aQlfnaFsYJd0DQ0O65wA5NapStAWRj9hK2
X-Received: by 2002:a05:6000:2287:b0:43e:b0aa:7311 with SMTP id
 ffacd0b85a97d-43fe3e1e29emr5672375f8f.47.1776445411147; Fri, 17 Apr 2026
 10:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414132421.63409-3-leon.hwang@linux.dev> <72dbcacc4cf2e76dc9de3c045e2fe1f3454d8880197b0db92c7d994ca82dcab0@mail.kernel.org>
 <fef2c9a0-c609-49f4-a165-890aaecfbfd8@linux.dev> <yujp3deu4uko2xkr4dghofpvhrni6szmd7wlozehtzndvhasrl@f2xjf4egi5fd>
 <3556a456-70d3-45e7-affa-355107bac30e@linux.dev> <d0059a19-ab24-4e9c-ac54-dafc932317e9@linux.dev>
In-Reply-To: <d0059a19-ab24-4e9c-ac54-dafc932317e9@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Apr 2026 10:03:19 -0700
X-Gm-Features: AQROBzC5poKN0Du2DntSH_FQRzT4zN-u7urq48C4T_6qJ6-jPD9pCbDUthSdva8
Message-ID: <CAADnVQJ0o38xXn6E5ub7kWyoZPiaevr9mwDNxv0GbxyguVTKUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Introduce global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>, 
	Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 8:48=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 2026/4/17 09:30, Leon Hwang wrote:
> > On 15/4/26 10:19, Alexei Starovoitov wrote:
> >> On Tue, Apr 14, 2026 at 10:19:22PM +0800, Leon Hwang wrote:
> >>> On 2026/4/14 22:10, bot+bpf-ci@kernel.org wrote:
> > [...]
> >>>> In the v3 series, bpf_map_direct_read() itself had a guard
> >>>> (map->map_type !=3D BPF_MAP_TYPE_ARRAY), which protected all callers=
.
> >>>> The v4 moved this to caller-side checks but appears to have missed
> >>>> const_reg_xfer().
> >>>>
> >>>>
> >>> Correct.
> >>>
> >>> Will add a guard in bpf_map_direct_read() in the next revision:
> >>>
> >>>     if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> >>>             return -EINVAL;
> >>
> >> hold on.
> >>                          map->ops->map_direct_value_addr &&
> >> -                        map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY) {
> >> +                        map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY &&
> >> +                        map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)=
 {
> >>
> >> map_direct_value_addr() is set, but then immediately disallowed ?
> >> Where else it's used?
> >>
> >> Even if value_addr is working, then map_direct_value_meta() looks brok=
en.
> >>
>
> IIUC, map_direct_value_meta() is only used for dumping xlated insns. If
> no available map_direct_value_addr(), map_direct_value_meta() won't be
> called.

yes, but then xlated insn are bogus, no?

> >
> > Ah, let me dive deeper.
> >
>
> As for the above changes, let me explain them using diff snippet.
>
> @@ -5808,6 +5808,8 @@ int bpf_map_direct_read(struct bpf_map *map, int
> off, int size, u64 *val,
>         u64 addr;
>         int err;
>
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +               return -EINVAL;
>         err =3D map->ops->map_direct_value_addr(map, &addr, off);
>         if (err)
>                 return err;
>
> It is to guard percpu_array map against const_reg_xfer(). Instead of
> updating const_reg_xfer(), better to update bpf_map_direct_read(). WDYT?

yeah and move map_type !=3D BPF_MAP_TYPE_INSN_ARRAY check
into bpf_map_direct_read() as well.
To cleanup const_reg_xfer() a bit.
