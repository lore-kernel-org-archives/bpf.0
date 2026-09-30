Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D864A5EB6
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811183; cv=pass; b=s/UbHgUjPQfV4CEoHccD4Tplts4uDyeAH3rDLN1G0Uv6TCvOPft2UMr4xGQ+BOKSNk7kHBjQ7YJT98l0NMLNrNsHqWSEH5Nwsfei54iSqlegQPkjII6+Tz05ZbECjOsDZpPlvlf5dsttO01MzQkLdmbYxOQsefoUpADd3ZkF42w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811183; c=relaxed/simple;
	bh=4D49IYAXZSVFvCJ88T4gLujZ0d1NNo8WHPi1MaZO/8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZIrVXZ/EZ6+K+x0UYEWrD1DSk8tiXWq4BdBzIpHKptinp1EyOF8eZuikpGLWN8rpzuR4ph0YN5NvfMwUPENpQdnStAuG2Kvx2hQU7V7ja4AOtP8WQr6Qx9qFdpWVSeY06GhWi/my19eFi1YgD4HC0jRRd/+hShsozEVgz1TS8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3x7y/5g; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3x7y/5g"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-4788fe5736eso4087124fac.2
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 16:33:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790811181; cv=none;
        d=google.com; s=arc-20260327;
        b=qavA5zAjvqDi1x50Fvv3kbRMB+8TA0L7Os9mJXxX34WFikbbu8PyC/vUqwjoS72UC8
         Q3gJYwvLRZC3scOpBBZ1KXYkHPFUG3iO89UlUMABA4cYWrewyYLxqlzw27CxtSmV0EEm
         PsYnWqt+pz5GtN8jZzWpv8RM2FjnGVY6NozxrddWpRosX2Xy0mpAkS53N97zHTcMntbR
         Et9XeJCHK3WTXJ1znzDfn7q/Tcbb+OSFqUmcaGHBp4SWJ96p0ymoaTROMVdPiTu0Z0UT
         DE8DSluaouP5ECmGaUmDYvd4835eooU60XagAzZs+kkSpx+IH78g8iGoZAoSkAYpbTmQ
         jfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LPTEm0bKbqUNKMZ37cgD5CITzNrHBkp5GSyeQAQbpHE=;
        fh=quXCdxEhpooyuw52ZpYwFW8wOnENWt8/hHE039M5a2o=;
        b=CgsaUAdYHa0sLgMFOhrK7icOTBBgkcHj+OxleGYi+4EbQg92+YE92dGcTuwWQuixCi
         XmGMqOFssxDcAOvvlxEhLz9IaIjgfvXB8fs6dCRBptr92Y/UXOTVTlEUxls3qn80qbTI
         y0UQqXOwsoYXnkCVhpP02LBrGlIQWfhV7twxv/1pyyhgg5Ipr7qBcklGaFgLibjnfgjU
         TaK9c3u+CDgngzzawHoveUduR9TPdDJ1j2IfXXlIUHYjMbl69YI9FPqRxllDsfqP+o+x
         ghXM0uhgzNbcjino0z2nEyKeRiF+VVLP2KDfJEz2qd89gPXi1MAjJJgjIuVwgCkwC+aN
         dNtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790811181; x=1791415981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LPTEm0bKbqUNKMZ37cgD5CITzNrHBkp5GSyeQAQbpHE=;
        b=M3x7y/5ghOrfaxtvEYyQUW7UVA5cefWnKCJmfohYlLQ8Wn8KMwDu9KhFyX0PCSYNCH
         F4VH/G0oPOkww8Zi/PObgBh+1ZBGNqx4SHfcairq9EE/o1ILPv8yDkrRRTZDEv+r1Xc2
         CIbVD+uVnXuNQBsf7AO+2vT1bwMlJLeKVOBGhD6Icf6MCe7KLFEBpUTw9ih9rMR+Locl
         5DIcDqkJ/SLKUURD+FvFXTSkVEzwfVP/I5fm9WGhlSzslwigk+Xho2H5l+l1hloRI4Ee
         dwMMIAIZ1yoGpDs4hOx0aBo46yxDOJr3vq0j55xWwKeu++HfH7QRs2Hbl71matpgqG59
         mmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790811181; x=1791415981;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LPTEm0bKbqUNKMZ37cgD5CITzNrHBkp5GSyeQAQbpHE=;
        b=1J5MGxDh9N+LgFRuiutJNGE3xsvnMTs2YS+rHvd0YG03kzSMmn7dM87b9HMQIyfyzW
         eC9X02TeUhd8lllqTvhEylfymCskGfOsqxqQC3KUPurBncTn7yjdqP7X9GIDvEfq7BXO
         QboIiKFcR8cb5Q9k1mYCaQG189tSQ896BRZYa7dxmwnaANpi5GRLAvx6tBJ1WaXd4zU3
         wgouUOTMyw3zZcmJ+3ji8zve/xnybA0yT8n9NX+SRl4Vxx0ppEpXgfrEvySPJTedZQZk
         Xy2IjUT59YZY1HQdvI0MPQoyka/f8TTWFE4RD1+7dAORbTfBv2IrgOvUIxLDfEtdAKjE
         DrjQ==
X-Forwarded-Encrypted: i=1; AKwUvBznvV1UTJGWdl9caEkRMJbOiQgQ3HFrvXBDpBiqVUyDGxLfkPbPb3iaCULnNBA3Y0Dicug=@vger.kernel.org
X-Gm-Message-State: AFuF++ki0sGxSth+JxYqP6T1kkKROfsGjyMTyjVCwsYwzuczjLUqm44B
	uRo5NSsIJ284c/gRN3hmjLc9FzRuXKV2JI8O850qYEMgsukLSBTtk6dhg4yOVi7vFQO/vaOeC2s
	PNK6uCMT8tpdEOOpT2Dam7+r3s+OOQcM=
X-Gm-Gg: AYBFou2TVv7rySB2rFutBp2Gr9lHyynz8n4dpkPi7EWsdiof/d6pbTtJKo9mBIoVX/U
	4PsH7vLPKAg3vBxtI/pgB5v04tuMsaWMW+nu7Xob+lTFbbN5qxzU7Ermctsusl0Dr3Xi8WpqcjC
	Kw3oPrSwQjexDimYUqPb3oQO8nxnKj/jt2E6ZmOBKDtF1/yQgzBltora+yd5fkQHSjFtaBebEfl
	LBgAYy9ENC28fbrrYqWm9uwYFxPpUSnOyRvVZL1HIxoTKFUXbjbsHUlDlRCe9MU9rcgdDNah6Bm
	Nay4cVczol/oCLuP+EnbaCxRV3G+7iX77GWLnvQ3CA1nHqbVFyEeUg0=
X-Received: by 2002:a05:6808:1582:b0:4d6:9153:2968 with SMTP id
 5614622812f47-4f1bafc0673mr3201230b6e.57.1790811180876; Wed, 30 Sep 2026
 16:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930135159.3926039-1-shakeel.butt@linux.dev> <CAMB2axN6-sMPu++HPXXJmPp03f80G0WhgHPLe4Tx2N53V5REEA@mail.gmail.com>
In-Reply-To: <CAMB2axN6-sMPu++HPXXJmPp03f80G0WhgHPLe4Tx2N53V5REEA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 30 Sep 2026 16:32:50 -0700
X-Gm-Features: AclHuK97hrec9RWHoEuiahRQWIqiU6qP3tiPiCVfaqtwIdccUEpMi4CzrnU1DEE
Message-ID: <CAMB2axM9ocD_Q=OL=FjpYhcDkz3PR2qyGZ8nWHVs4H8M-Lv38w@mail.gmail.com>
Subject: Re: [PATCH] bpf, cgroup: fix cgroup struct_ops query for a second
 attach type
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 1:23=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Wed, Sep 30, 2026 at 6:52=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> >
> > Two things in __cgroup_bpf_query() work only because CGROUP_TCP_SOCK_OP=
S is
> > the only one struct_ops attach type.
> >
> > It calls cgroup_bpf_enabled(atype) with an atype that
> > find_atype_by_struct_ops_id() works out at runtime.  That macro is an a=
sm
> > goto and needs a constant.  Today the compiler can see there is only on=
e
> > value; add a second type and the build breaks with "impossible constrai=
nt in
> > 'asm'".  Add cgroup_bpf_enabled_runtime(), which reads the key instead,=
 and
> > use it here.  This is a syscall path, so the cost does not matter.
> >
> > And find_atype_by_struct_ops_id() matches on type_id alone.  An attach =
type
> > whose subsystem is not built keeps type_id 0, so a query for type 0 fin=
ds it
> > and returns success with nothing instead of -ENOENT.  Skip such slots.
> >
> > Fixes: 369d9dcd8fb8 ("bpf: Add infrastructure to support attaching stru=
ct_ops to cgroups")
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Acked-by: Yafang Shao <laoar.shao@gmail.com>
>
> Reviewed-by: Amery Hung <ameryhung@gmail.com>

This patch might need a "bpf-next" tag in the subject so CI tests it.
