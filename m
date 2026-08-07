Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9B041A4F2
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141129; cv=pass; b=cdI0DUOzbSCsGj4QiFm6v2/TY5t044ljg/WVHTDK8yUNWoej+4ejQXdrllK15ws/G/DbK7ieMm9T/qzU/7mO0FUYq3RgA/7oVB16ZfKXHqCdg6Vquve347t570ssBVYNbm+X63bY+aVx/HNU+UuCcs0nM55U371LQ2tL8+Os854=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141129; c=relaxed/simple;
	bh=jWVDZ5aogJWPUXgiUeFktfk2DMqo0jJD3bphzGm44y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeWdZm7QPMfh8E1vVOPiUDIcCXZb430QCxu4Ot/K0/fozwMTLidozUOCT0v7K+tobbclbUsoHJcr3J8X56eTdBEUdSIZ9S+Vc00dNC9A/CEJlG7klJfqAfShCuva4Q6JRvlhsW829zjuIa8npoWFnu85FBeP6GB9iAHXWw8bJfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmK8Borj; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmK8Borj"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca957432c7fso3714356a12.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 15:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786141126; cv=none;
        d=google.com; s=arc-20260327;
        b=BH+hRB3GH13tKz9JWl0GDGK2SJ2jrhbZ137FnVvrYOy951WZjB5nbSA4B4V3Ilaghc
         qJAQK3oYjxd0+yrct61CZe9uX1ujnfh1F0SaxSw6v/x1rov6xiIrE7RtBCuU1dFaEvwF
         7RHbf0F2JOWW23oLow2pkdEry+GTriRagIhNECGPeS4q0HB6EKGcy6WKAVlkzDxS6IL3
         hIPKaNr7s38gOZQSoBjK/vOHuHXBMf4PwWMnW/BKJTQdfO3ZKCnZYbwokLKHtNZvZrnF
         YEe83V3INaHlVAPs8L8CQcI79TIbyQL/Ck7jD4dTXj+yV+HBbm7hnodIirI5niamNX0x
         p4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nT23k1w7C3Whnw0ss/93xo7fchWJal/nG0ckrtLiqjk=;
        fh=AJ9b6LI6/h8LfTC8O6H7JiHulq9bKi7yVzJD6EdzyDE=;
        b=C03eUowmNO3tqYjFevKjMixjDqsZCAzO9p3OnsABuy2nYoyGwXjjGG2pqlJO3OEUPV
         bFpSU2n2dAjqCDdPhdDgCiZIq3wPH7KX1XQdZBhSljWM4jsvPRClYQurwdVPSH6XaaIR
         Q+b5ErQ+hL5IOqPnwsK2tEwKSpjXrqDt8amLKIdKHGfAjz4VriPKTH7W4NH/uxdkLUTD
         Xm5ETMEeMwKC8P2PilrXx1bZ8JnxeH8xUCKQNUSUm5vTmbrsG4EsMze4VfBSujtUicg3
         qW6I1FfOtLoW3ez0OomtZN0u71f/l/XzG8D+uAfJDPDVSAZcxWCTtzt//yg7g8QfkPjv
         cihg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786141126; x=1786745926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nT23k1w7C3Whnw0ss/93xo7fchWJal/nG0ckrtLiqjk=;
        b=NmK8Borj3T4XRTm9lONejzz+fDoFdFbgjTjHkDTbC8C+acMwxmQYFvXQWRGSkfQFaD
         TMNU1eoeu14cvAKQQYFP71+6tfRJed1MfMUCfCMw4JAceN4jXHWe8a82GfcJftRxbI6v
         P6wawHuU3aTljMCGOFr70+BzzvImIrMFm95TvLea3e+Mg7XnSCfK2tuc1gm1ra7uykE6
         mq/r3mUAU2bIzBL70jOXVyBs4ARLMLfVDvnD/hTrEYcn/KlXTk+7jK6ViCYDMKv6r94i
         NGEusUNq4kKsFUi5ei/6ywQiLMLN1oeMUT+WZaq/O+mOo/j1TN4GGisLSipGnFTTaJQK
         nAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786141126; x=1786745926;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nT23k1w7C3Whnw0ss/93xo7fchWJal/nG0ckrtLiqjk=;
        b=mRlcZ3NVNbpIvdngteuAKY3u2S+4MQCUwAcpE3iWTL9Prwn2WcDkK7/RjRf/N53uMD
         66edHcsGcEp/8fnwtPSAdJfjJPi90DwFdn5sa/Qt6+f7cKIFaVwbJeTP85aH7jGsOdpG
         m+irp/e/itGhuuPi9ZnOdmFbZfq1TMjtFli1nvi99gFhG+aQdrs5JFFNP3b4g8I38k6g
         o5LbUj5loTsj8Sik56FsH3yCVtHnS7+T9HiKDv6+5V55pGdHJacrTVE6+kxtvEFJmxN9
         gO6sG1pYAz7u3naAXrg1gW42HYD1P+ZhvdRoi5l9h/CUUp0jN1iN/mBmOjU5R6oUlP5g
         9xxw==
X-Gm-Message-State: AOJu0YyruP1WXkjMLVs2mt/RmaReAkv3u6yKS/zrUeokeg4CztrXf4Di
	N1d22LrjgwKMuTDtnnC7yvVjO/hkN9hJNNpDsbsOnKvesuMm7BhRdKJYhkx1Hd4Bkq8OFYzXxkd
	G5oeg9moGeYiDAxYvKTNh8IhiUVs3KC5rqw==
X-Gm-Gg: AR+sD10CqOwGvXdZlfbGf6bZA6zAyR7HRSXcpmCFvy/UYGbZpHLSWiE9+WQlJX2jm+U
	rsBC6+u2FDBLOpMP5JjAegIxctbPqZGM9znYgRUujIQ/YTjWDRdkA3zmT0yygVeZ588UdUyvVFY
	sG8CkTLu1GAxHzBSOUtKUmb1kxP0tdO40ZLcYq194w/eG/cw6dxwF7bTkluhATEvhO+1UjvM2xR
	tZ1x3oOmwfGwpaEwDC/cPzPNmieuguzIK9Cg7RYFVdOLaqz1mQF3WWAZB+67DWFgrVGnszClbAh
	ER6FgBj8pzZQeiBGvQpVo/UIFlNz75a3V24KQLL2NsCxThZ6eDCpHuBINXQBmHwb+rUibNtDFtC
	hxHyU5rVbGu/PCXQnhDT7N6rAy3EqDDUEUET7ry61WQ==
X-Received: by 2002:a05:6a00:1821:b0:84f:21ba:54e9 with SMTP id
 d2e1a72fcca58-84f2e0dbe2cmr28677876b3a.38.1786141126524; Fri, 07 Aug 2026
 15:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806042042.3239428-1-zhaofuyu@vivo.com>
In-Reply-To: <20260806042042.3239428-1-zhaofuyu@vivo.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 7 Aug 2026 15:18:31 -0700
X-Gm-Features: AUfX_mzZpt35RYPI0dPslS-c1ePyazEmvEvOkL2FAMgtZpqpIcjSVddnNfysn40
Message-ID: <CAEf4BzZbsH2kyq9wb=eCNEOioWJnO2jSwsvbL3uWeyL51OnzVw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/2] libbpf: Improve BPF load performance by
 selectively loading kmod BTFs
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 9:21=E2=80=AFPM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
>
> Currently, during BPF object loading, load_module_btfs() unconditionally
> iterates over all loaded kernel modules and loads their BTFs. This
> introduces unnecessary overhead when a BPF program only needs a specific,
> small subset of modules. In environments with hundreds of modules,
> loading all module measurably increases the loading time.
>
> This series introduces a ".kmod_btfs" ELF section, allowing BPF programs
> to declare the modules that need BTF loading. libbpf parses this
> section, collects the module names, and skips loading BTFs for any
> module not in the list, thereby reducing overhead. It also stops the
> iteration early once all declared modules are found.
>
> Usage example:
>
>   DEFINE_KMOD_BTFS(_needed_kmods) =3D { "bpf_testmod" };
>
> Performance impact (<skel>__open_and_load() time):
>
>   Modules loaded | Without .kmod_btfs | With .kmod_btfs | Speedup
>   ---------------|--------------------|-----------------|--------
>   1              | 35.0 ms            | 35.0 ms         | Baseline
>   10             | 36.5 ms            | 35.1 ms         | +3.8%
>   100            | 46.2 ms            | 35.9 ms         | +22.3%
>   300            | 65.2 ms            | 38.0 ms         | +41.7%

First, is 30ms start up overhead really such a big deal when it comes
to one-time thing that sets up a bunch of BPF programs? Can you
elaborate on the use case you have that actually is harmed by this
libbpf behavior?

>
> Fuyu Zhao (2):
>   libbpf: support selective kernel module BTF loading via .kmod_btfs
>     section
>   selftests/bpf: add tests for selective kmod BTF loading
>
>  tools/lib/bpf/bpf_helpers.h                   |  14 +++
>  tools/lib/bpf/libbpf.c                        | 112 ++++++++++++++++++
>  .../selftests/bpf/prog_tests/kmod_btfs.c      |  47 ++++++++
>  tools/testing/selftests/bpf/progs/kmod_btfs.c |  14 +++
>  .../selftests/bpf/progs/kmod_btfs_mix.c       |  15 +++
>  .../selftests/bpf/progs/kmod_btfs_nonexist.c  |  17 +++
>  6 files changed, 219 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
>  create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs.c
>  create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs_mix.c
>  create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.=
c
>
> --
> 2.34.1
>
>
