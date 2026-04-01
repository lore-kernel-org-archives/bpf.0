Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE0A376BD3
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057603; cv=pass; b=Vz2RJ07o1wPPtby2/y1htBTJnDnvFmFAmqPs1qOzaLSc3L6xzBtuTMkdsUWQ53oGXxs9WZhdFqK1LYdy2Wq+Qtjy7JWLJaCAFji/dLpq4zoqYYmppSM3ZGWHNi9/ZJfARw3kEMwFDswLCSyMRsQjHU6tvNRzaobSMyWG+zEzNYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057603; c=relaxed/simple;
	bh=8u5XZht3wlu/tI/FPO6Hb70fUeiS2U27V7bw9d78LXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLrq9XvA+IqS2rCg+pz0P8lO2Ws0KGtklSpQeP5OpHT1VW9MmID+S65n/B38CWrzUKqjCfn2jk7+HEKlV++Dl9NVGVnOL0AbF6Odhx5zGfPeOeVgGibGGTQFDT1q/AjqSCZeOWtIQ2sPyUUFEqOuDVGD5kqdF00kbXrhHTaYyck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHM8jhSP; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHM8jhSP"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d02a71526so1896182f8f.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 08:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775057600; cv=none;
        d=google.com; s=arc-20240605;
        b=Ek1MFXRAOG0y9dtpeneAAUi4gR0VMzdhQ5wbHn8J3Ti7DUhXrtco92+lrhwxIkCkrE
         jKk/HvSff20cXQOivCxN2bl12TOmjDCPfbwGpokauAlnLDICraM5eNPhcmNa08xsuFUX
         QYDlNnP/cty9n8auCbsLd+TAvaupMY17aXC55GfXgASi9OiI3uLZC9i9xla20OgQ02aH
         LarIV6sQfwo8/+aZFPl+8rnMFs3VrD6X89F2rm85d2ZJTT3mvYRn9yH+nhnCkSPWYVAN
         c7fHXyilllXP4PLrlvtTkaPKHQBwVjeCunWV/3KrPU60uzqx9PDnbXFQgvBW4gI0BTmQ
         QzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WYuJjcsCVjm+nUkvXwexXWFVMP4k/5PKgHBvz1iN5Io=;
        fh=ZjZnlGJ4j6GsPbdN9KU7cNTEhuDuKixuJSySPsKlUQw=;
        b=jADmoPnsnx3oEVvjxaEDSUiZ5Vx5y0wrY1qWmI/ppMj9hkPsIQXhi8OcMohk73rmY+
         rDg/IBadHB+N99B4XqUiIAWuwnWbEKO+9YJ4q/eARLW0qXEtj8VupEGct7kf4zYnPZIQ
         X7S414SMflc/6Q5JP/hhovpuz20JQHQJi46QCKcAMm5NwEYY51YT3u7ivGpWMPrLqDNv
         BDIQ2S4DjyfpJIyX4WrNlVS46L7xUu/n5h/X6LWE6ztDaYPODiF5xyUOqtLEV2pXho4a
         Dzk0j/Da3Eh6gk4oqOlQho1VSbf/WTagEfqvABn4zVnc+J0EgapVHDN12UbqkaIMQN46
         YEFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775057600; x=1775662400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYuJjcsCVjm+nUkvXwexXWFVMP4k/5PKgHBvz1iN5Io=;
        b=RHM8jhSPStndmYk7pPTVa6AE9qMQj8i2pjFjiSY8xDgQ9BEZ4fBfr6e0+Xc1o06ocB
         lHEMenIpn3oFRC9/pSNxpIIO0W2c9Uc0Gj6IWogqdz1+YLAGpPZGd054hrqpGOqNeMBm
         ShaulVJC9uNtGHDBtoBK9jTrw23aFp69E9gQlcCO9VcIp6wMcQUiWM5mA6zenwQ+RxY1
         K2zXf9i18lr0ApLuVlbmwJ5Ginf2xWg7+ryaCgA1h+OK6W1bZyV3yBPa6No04wpmZB2J
         OpKY42e82WTb/SLyaIJgzvqjQ5fFxTCd9zldVhJ7NxXUk3yn5zRkz84KSwb42dCvVpWw
         1Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775057600; x=1775662400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WYuJjcsCVjm+nUkvXwexXWFVMP4k/5PKgHBvz1iN5Io=;
        b=RwzNEzPB2ehcmgI+b3jVREDEAo6mgMY4IzGVnMaXJM2QMJDRIeETlpgocLp951ydCq
         dO2hCNXjm8SkT+TzF+xvUf4havWmZv0SAi37vEk3/xLMUYmvqrS8j/WkNZeXuaBm+8Yx
         utXcpyZOym9IynvunRgj2dol9i02XcZj6wzC29v7rnuEUeOEzUw+rxPvnLMmevcLpsmz
         5c40nvK19HiEA/U92OsUmw9gFxCVSo6EA+SZyHdpKE3eJwanmvNZ7VNUaZ4nxSsbcQzi
         v4Ki/wIz72+3MO9pBf/Hvb+lTTA3Iec9HcMZ9oS7bOhbK7Wo/M/tMth/YzwvyMS9Kx3F
         MNug==
X-Gm-Message-State: AOJu0Yzk1eDQSiLPX61ubg6nlJHYz4qEK9mxMlSDAIOkagXh3zXZyUn6
	vw1y6uZNMXRewRKicnBEe4P5I1fAcUfYpnzA+CWLggnbAyb9zF/kW4UvT6sv/RWBUHW2DsRYJkC
	zCpW31jPVLucjKCsCIrW9pTXKswJSXEQ=
X-Gm-Gg: ATEYQzw5qWkb7yxcCXSlR/p9kcPTlVyhscj5nXB0vAuZTbh91y4tTTjnsQWsIzoCudg
	2OKxB47C6k8qXwwXlOBhTqCecNiH6w9dI/zvyLTV5YhDlbcCp+IX/AZJozcxMDlRF9/kLNa/ch9
	G+nM44jWi68icY1lfiU5M3ILu53ORoqlcUfi6f5GWWXxId2r+P/oelmqFqAKru8/g3N4EpUoSjd
	wmlm2q2At+fBzYuUaeaU+6NRyWO9WpMpXF5GJOd7oLsFmu2Yh7CO1X9aBJwJVqKKc3vyut/BfFr
	uKvVkdE0O8kFNFFTDa9vF7FCtZlbq0dK6Zxrtb0nbo5h3fmxSoAHL0lEhssp5mY9U7Q5W7wFNzF
	YgFJCgMCFTgdhtEsw6GQXuyeqsGJsF79f39f2
X-Received: by 2002:a5d:5f85:0:b0:43a:16d8:96e8 with SMTP id
 ffacd0b85a97d-43d14fc7248mr7971728f8f.0.1775057600370; Wed, 01 Apr 2026
 08:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401021635.34636-2-alexei.starovoitov@gmail.com> <7d2a686a5bae52a650a378e26d84ccdee3cec258044119a1183c4fbda16dae8e@mail.kernel.org>
In-Reply-To: <7d2a686a5bae52a650a378e26d84ccdee3cec258044119a1183c4fbda16dae8e@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Apr 2026 08:33:08 -0700
X-Gm-Features: AQROBzCyupCzw3wPlellmaLMXMk53Kd-UnyyxxRD7g7RnCsipzl05MpZZ0WiNSw
Message-ID: <CAADnVQK+J+xXD_PJBjc3ePm5TKcrarfYqFkTnaqf_b=Bo4NooQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: Do register range validation early
To: bot+bpf-ci@kernel.org
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 8:38=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... mark_reg_known_zero, mark_reg_unknown, mark_reg_not_init
>       WARN_ON guards removed ... ]
>
> > @@ -3957,11 +3936,6 @@ static int __check_reg_arg(...)
> >       struct bpf_insn *insn =3D env->prog->insnsi + env->insn_idx;
> >       struct bpf_reg_state *reg;
> >       bool rw64;
> > -
> > -     if (regno >=3D MAX_BPF_REG) {
> > -             verbose(env, "R%d is invalid\n", regno);
> > -             return -EINVAL;
> > -     }
> >
> >       mark_reg_scratched(env, regno);
>
> [ ... ]
>
> > @@ -22070,6 +22044,14 @@
> >                       verbose(env, "unknown opcode %02x\n", insn->code)=
;
> >                       return -EINVAL;
> >               }
> > +             if (insn->dst_reg >=3D MAX_BPF_REG) {
> > +                     verbose(env, "R%d is invalid\n", insn->dst_reg);
> > +                     return -EINVAL;
> > +             }
> > +             if (insn->src_reg >=3D MAX_BPF_REG) {
> > +                     verbose(env, "R%d is invalid\n", insn->src_reg);
> > +                     return -EINVAL;
> > +             }
> >       }
>
> These new checks are placed after the BPF_LD_IMM64 handling block
> in resolve_pseudo_ldimm64(). That block exits via the next_insn
> label:
>
>     next_insn:
>             insn++;
>             i++;
>             continue;
>
> The continue skips the new dst_reg/src_reg validation for
> BPF_LD_IMM64 instructions. Since insn->dst_reg is a 4-bit
> field (range 0-15) and MAX_BPF_REG is 11, could a crafted
> BPF_LD_IMM64 instruction with dst_reg >=3D 11 reach
> check_ld_imm() without ever being validated?

Nice one. Will fix.
