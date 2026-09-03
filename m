Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883B233929
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 00:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394955; cv=pass; b=kupPSmRtYEzvyPnbT6GhXa6Qj9alHaL6hRLSu1sOagGYQ30k2eGGc7JCECQaDrjkIHCmy1jbGlLa0pAw9D2gaMES/h/6b4azFjYBOBh1Qo2HlkC88KsfJS3THaXRZC3zeA3dg1yQGC7j9hwnBD915YBzUCRA2coLAruLyFzO5hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394955; c=relaxed/simple;
	bh=yc/XCwDCJJaEjokK4nDQyUrIjP76wGXp/V1y57foybU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvwGadpk4ZdsiIezM5Qi6Ko8BGWmOkn7uNHup0Ny+Mx6Fv/wT5+IUr0SdZr0PH3rjDFNAAHuJLvPHUowOD3C025k7MdM4q+zpRQlDgTevW+L+aBpRtlOttfthAgicuhoWbUKDflUEPAcv+sMst6LpNab9ueLy6S2PXJOsCh516o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhlUgjh2; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhlUgjh2"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e27035206so1585058b3a.3
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 17:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788394953; cv=none;
        d=google.com; s=arc-20260327;
        b=lkzPlAQblSWkKzT8/ROLkIBU4Dylc/Au2gp/WIyZ2RQrP/7pj9PSsti3y2piwWKvad
         VjeKgSlvYH1FDwRyf4UNQuEwmZgjMVPU9kBA4lsGgIk3phltADdQZ1s7rXqhJbn/EVit
         Ci85mmOdK5dOY9rSwwODLahyDejNNauERVxVxAOoqmpPeX8slOWTa9cmVZCFPihTLndB
         gxeLCQncFpJJfp5sL5tWkVTGz4o3wWrKn6Cjj2LMRjP88VljL9MjV/u/CEw5ZyHIM8qK
         1NEwjPy1a3PdaoMfWNLo91dxbGuFiQ4A/nEk1CDCOoy/SbjiOTkQOTI6hwdgI599k95k
         NN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HSJaIZQ1NlOzwVPE4FelKmhuI0sTnWecrED0YU+uG94=;
        fh=HJk+pDVvE2hRGMBBrhsdgmx1k1EzkSkjd52Q14nJDXM=;
        b=pa1NT64sVlsvETnV0C8xPtQuDF+8BGMc/cXNq08mAZ8xI0SUiloBjN9N/7FRYRN7N0
         WNeJUb2w/Py1S0yEM2YGq3RyyEEO8MMWzIs/tSbYKX9BxDD4swlw6ScID6IUuoXq+f3q
         X+4xCFOzICzI1AhvxqeJ3lKpLpGnQ4ePGG8GBrt8apI8P4c/CZnV6LroLSVZCOUj1P8t
         qaT0Z8d5vstR/KzBMdzRxLyoJEqLGiJngkQy/r+zVKWMMaerAHXEEdkEdxOFUKgESq6L
         WG8eSzsODbY7A3/Uvo6e7AofAc0cGHtzRWoeNmYY9WO4xz7cCiYCzigBZeDyK0A5TvX9
         l6fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788394953; x=1788999753; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HSJaIZQ1NlOzwVPE4FelKmhuI0sTnWecrED0YU+uG94=;
        b=ZhlUgjh2ARxjhBYssUX+RMHmcMDxW+zT86XxongItjLVBLTgQXgwadVJtqdvWIYZkt
         +bjXYUDxIbwq1Bnjs+PkxzBGKSKau0m0ZOrw5XDJPCkHt6+mhFo4rmKG+GHmLDxXTwE/
         rN9YJrx0zGatERU8GtAuDHs7pjY3ltSOtbfq+C70z1aE4Gfcq3yvV5alpC094XZqZzFo
         DeDAmxoTJw//XO7A8yEbhw45AgxveLPeVil6dDFmWevMjrUZw7W1sTgiLDKRgWL0rL2a
         8UbXTqlma/J6tClOSfac7gC33sov3eNko3nt04d7WoWjFiGMh8Uzq5y3vfhwyBX2cwvJ
         IXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788394953; x=1788999753;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HSJaIZQ1NlOzwVPE4FelKmhuI0sTnWecrED0YU+uG94=;
        b=WpqGyqNAS2Uk2F6U2nQdHubWoK7JNTX9kC4s8kCVThozxpzCjDBr3/Md23DhlvYMU+
         XzDSj10ACUTwtuRFl37B8tZoM4si0AwRL70NVF7BxC2erlBi+0xd18fO2EnsbOERn/sC
         vGpzf3z7MbysuLeEGru7h9txS/KRqORPdwOXdwwk6CghuDYOVud0uLUYlvfuFl9Qh2MH
         EC61zuzP6UsVoEBfg9Nm3mLUOSCFv907UWZywNv/YMaVq6A9tmEgrA+uQqf1G1uLhqTo
         U/XPvmFnWQ6l+YThKkX5Nm95IPHxY7O66C2aJjIvgcFruCL7X8eMguvRSNp6t+x8u7X5
         Rqgw==
X-Forwarded-Encrypted: i=1; AKwUvBzeuPAWLLxt2F2bX7Sd77IOlcXyzcWGuProDLZ72RIBqmrY+NrU8PPFMq7z9bkYOyd1puo=@vger.kernel.org
X-Gm-Message-State: AFuF++mLvC/canifR6hm/6mCqS8k0pjQF2Wvt5MKSLKd9o1Am74YcOK3
	YS2SvYzlafrGIt+aflXf5EI/O15ygEtgpAmQ5q2J0a7JBkjrRjQX48MiTiCJQW5gxadMjsrn6bE
	lxIU5OZrlt8kJoQQFI1Gt0lXCJWWUDsk=
X-Gm-Gg: AYBFou2nmxF9Bj3qGys6RydGGjalqwpVOywbrngGd/vUAAZqmfgHW77icLkQ8b7/VGz
	l1bRlD3PO2YDXNp82+GCwpWjVQJzEMwCcLD/hxX6k4R3GaEcsKYKjxqzgV5+R4QpOatF7F2o8wV
	Fhk51l6JsCvmv3z2htyc9DrNTqr5qlptSWD6yJip/OLoYXjaiSM6hWcefx+U66r2P4gPePTGOLr
	jwNU9ujxTuMbNwV+1y3cYbJPI9Dieq2J5ebgiEx8QpFTEbc7FQy12i5OvA/vkBHnT4Iqb0qfMmV
	SXsbxdLMqvlK9CeR4Dj5nOAK8mu5yvDSq4yMOWRDmcqT8VtpXOIDQrtlvOhS12mQKMMTI0GJipD
	PMuCa+RdrTHjZzhvR4bEIWLK/dYZQYUYI4ukW
X-Received: by 2002:a05:6a00:9295:b0:837:e9cc:d474 with SMTP id
 d2e1a72fcca58-85ed1d07a02mr11562973b3a.2.1788394953119; Wed, 02 Sep 2026
 17:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-libbpf-frags-flags-v3-0-4eb6f14968b0@redhat.com> <20260901-libbpf-frags-flags-v3-1-4eb6f14968b0@redhat.com>
In-Reply-To: <20260901-libbpf-frags-flags-v3-1-4eb6f14968b0@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 2 Sep 2026 17:22:19 -0700
X-Gm-Features: AcwNN1Uya_EPc8em6u0NWFruh2HqV6gSZQUAP9dd4jBDCAvedMFrqePOxVJvSUM
Message-ID: <CAEf4BzacBUMLREUObGo5544wyD+mm1=y8ZTnzd7OdDL-c==mMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpftool: Set BPF_F_XDP_DEV_BOUND_ONLY
 flag non-destructively
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 1:47=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> When setting the XDP hints ifname, bpftool would set the
> BPF_F_XDP_DEV_BOUND_ONLY without looking at the existing program flags,
> overriding any other flag values. This was always a destructive action,
> but after we change libbpf to carry the frags section flag in
> prog_flags, this can impact bpftool loading of XDP frags programs.
>
> Change the flag setting to be non-destructive by OR'ing it with the
> existing flags.
>
> Fixes: f46392ee3dec ("bpftool: Specify XDP Hints ifname when loading prog=
ram")
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  tools/bpf/bpftool/prog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index a9f730d407a9..8c2f9255b36d 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1769,7 +1769,7 @@ static int load_with_options(int argc, char **argv,=
 bool first_prog_only)
>                 }
>
>                 if (prog_type =3D=3D BPF_PROG_TYPE_XDP && xdpmeta_ifindex=
) {
> -                       bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_O=
NLY);
> +                       bpf_program__set_flags(pos, bpf_program__flags(po=
s) | BPF_F_XDP_DEV_BOUND_ONLY);

maybe we should just add bpf_program__add_flags() and
bpf_program__clear_flags() to make life a touch easier and code in
selftests and bpftool a touch less verbose?


>                         bpf_program__set_ifindex(pos, xdpmeta_ifindex);
>                 } else {
>                         bpf_program__set_ifindex(pos, offload_ifindex);
>
> --
> 2.55.0
>
