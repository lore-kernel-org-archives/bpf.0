Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93373EBF36
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770861387; cv=pass; b=gUXWSViGQpUDERvLDy7qNCqNwtCauuyJrtUTzmPlkJtDfOBuW+v0Ysov4BGsCInuDcGLZonMCETFHrO8Op2yBS7bapuZ9ZJRzlrCdh79tNqGSSA6bNrkPGAC+9oUs18DYCslvKvHuYvdAJat0Yoq7sa3lPQd4jvIVIgV6jSfCts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770861387; c=relaxed/simple;
	bh=frWKgDH5s6+x8xNUS5+okrMlTZrWCJFmfSis+/4QHEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUhKTH9bJazlsBaYv2D339yLsH5Xf+1gwbR0vFccOWs0W1nszsiRpPZSuam1LR7FrQCrxRW7XkT+96jRrdYDCtXQvBMeW4sY8ioZ7Cw8/HoOtgjB5oX48wLKsvYg0U9qC0CeviGL9yGKe3yi7EFh/wi3IZpSAXGyA0hRjsDXwi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkSpx6jQ; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkSpx6jQ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43638a33157so2149610f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 17:56:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770861384; cv=none;
        d=google.com; s=arc-20240605;
        b=GsXTFSurRJoAbgMhRIIRxpc8f1EYb6iUWfqdQAyGNfoVqrsdot0XIiHSBVhJMI5deT
         lXF9AvspW4+LAXmzwe/3if9Amn5bMsFwiNbprpiAOk83LOxxJ+MTXz2Q5dq1H+7FTswU
         J8uABgCxMeqruhK6lSRKWlcw6zrlT44jtsV+ExL5LwXxo3JTDwKAA5iersEdGhdeoWpC
         VlrTl50Qh6q4U32Iu8phDXQJrnIK4HyrmS5BTIlaUbFoGcGL4DkAUCqC+5tY9YE8sHrx
         ZYccgdPLWqBgiUKecClt1+C9rkkWmWX3l3K/PlOCnYz3laJSlN/MjAlkRf8gw06nIFHm
         P5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hTq0b2jT5IC669GVrEU+cppahygOALNim8bS9Ug7FH0=;
        fh=op8o6Ats+hoBVWml3k+BMp37ZQQIiT7Py2A7olmIIeA=;
        b=HB+Qx2/ng+C14LDFjEkaIXegDfD2XpxeyyTrS4imuih1lNFCYY3Y4DziSXsCeW73f/
         Brnq2BjVMUznylRfd3G9JCQXNsS94Ajo/YP2GcE7bCr3Xmu2rBtBZ1o/2Z/7+xo3pMyx
         59GkUCn9Dmgw255Bupp+aDTHyxTf6dHL7tBexi0yM2yfxVLPERQFUcftdjOk6Avop2NW
         hTgig65nGiSIcyeyUlp24P+f1ZVeG2dbeHnD3/RKthLRmzxZ+eu/ju8D3WShfhO8irXT
         S2fdF3C/V+5vaQx3XfUc6MsInRA0/T01doUW7Y8tCA146f2qC/Qami9n5rokscE/TSCW
         YivA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770861384; x=1771466184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTq0b2jT5IC669GVrEU+cppahygOALNim8bS9Ug7FH0=;
        b=nkSpx6jQ0ouv6NzI5gSTrani1DdBkD/wFQ3JpPMAIOimG7QP8X66BeHpQJHbgI6uKY
         EhLyXpkuWiTOnE29k1xcBhp2Q6bs5IpIsceRVh9TiU4snwodRD6lHtQECQFHAd+T6EtG
         9GKQgexheHU8I9LdgNYKQknsGXZZIsq/Q7vAjONevjb6cfkWwQwJHuOgGf6+DvTRDI5a
         /fjK/tiq72VEyw8D8tyXkhF+PjreS22+wyKJOdb7QZ/UeLjGAZi56fltdyH5ze1qRMFZ
         7i1upNsg2UxatO9QcQyXrJCoeLSJcKF2vkDLMMh0KepO1Nlv3yWKni+xzEVW2cVVCvLh
         yNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770861384; x=1771466184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hTq0b2jT5IC669GVrEU+cppahygOALNim8bS9Ug7FH0=;
        b=BLAbgAW5NDMwq9VsazgDxUeAI1K5o6pll84LN+WzCjBImYn8Wdnm4bw6WqgR9iQLKS
         dbY+FJKwta9ZnSWu6OvKUnzwGn+TKr7z7M27ouqxsWTieCSW3X3MLmH/GHuUeUZnA3dq
         sIqv3iF9zLkjm6KJrtp2sTwy1bZbXqVNMnaxV4uZxfhInVLkg5b/WtXNEBJiRAj9YMAD
         DOxP6wRRriSVGq/pcZlBCdNl+aSphqDBoqb8eo0m73fZkSyXzzePNRRzBvMrCNR4qtgu
         pcIaYyoPD1ixSMOuP3Sguz8KUsei8ZsqvDD7Z8s+2nMfK8dwI3GNtt2uIpTvXd7TKP/S
         HwJA==
X-Forwarded-Encrypted: i=1; AJvYcCVYIrpHuVHnCS3kXOYpeuovkLJHHrzn65bGu6sIwJVSY6UF5dEDuin0YiU1XY42/nmsTj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8qJfZ6MmEkVdlizKiIFOEyXyPfrNiNafsfHyn/J2B5XbMcadn
	05OElb0I5i/qRynykgrZLzhLPeUo46Wm00lAv2xpR6y4julw2Bywnhw1+PtRbvh/KRg0st1GUMC
	cZMhry1IPWxTSvLiBKE+Ua+fjMXuvsM4=
X-Gm-Gg: AZuq6aKA4hdktVr8aegAwcUCVu9cWA766MtPRcpTW5FthQoNAAnjIa3bCVohD6i5PBJ
	vkDTG7t71K0SS3L5Jiv2x6laMkFFVrfr8ok0wQDRPv+Jf3nXOTZSsbGpgrBMNWPXLvFkS2wxsvK
	ILPAM62cbGzNrSqoM6ik4FSn+QtzXhZk7qefXPMimIGWEX18NrsoXKqyP26DaA5lClO3a4FOGuE
	PjQzo6HLI0dv9yDqfqV7GpvMUlTR0T94W+KNEjzBBBb8XRCPmN/eDWrMp9A+/KflMIj65urynaI
	oKtvhKzsx6ZUZ7cNe0B607c7tMdosUICxQI6/CKF1JsaqpwyI0RT8rqTSF75Nthpq3lLFIGglz+
	75iTaytabpEmSiS0+IIRQOm1RVVasIltNgO5J
X-Received: by 2002:a5d:5848:0:b0:436:32e9:993f with SMTP id
 ffacd0b85a97d-4378f1287bbmr799251f8f.3.1770861383994; Wed, 11 Feb 2026
 17:56:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209025250.55750-1-pilgrimtao@gmail.com> <20260209025250.55750-2-pilgrimtao@gmail.com>
In-Reply-To: <20260209025250.55750-2-pilgrimtao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 17:56:13 -0800
X-Gm-Features: AZwV_QgbUPOCqax4vo6tL1O5Dezv89cLftb45HLIstLVEAqCtVnRNwq9HWpLVsw
Message-ID: <CAADnVQKjBdfL17d0H6eHdiHYbXOr0Xz6BC=AbwMctQ6860-P5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Introduce the bpf_list_del kfunc.
To: Chengkaitao <pilgrimtao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Chengkaitao <chengkaitao@kylinos.cn>, 
	Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 6:53=E2=80=AFPM Chengkaitao <pilgrimtao@gmail.com> w=
rote:
>
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> If a user holds ownership of a node in the middle of a list, they
> can directly remove it from the list without strictly adhering to
> deletion rules from the head or tail.
>
> This is typically paired with bpf_refcount. After calling
> bpf_list_del, it is generally necessary to drop the reference to
> the list node twice to prevent reference count leaks.
>
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  kernel/bpf/helpers.c  | 19 +++++++++++++++++++
>  kernel/bpf/verifier.c |  6 +++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index db72b96f9c8c..44d9b9ea8d40 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2388,6 +2388,24 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_bac=
k(struct bpf_list_head *head)
>         return __bpf_list_del(head, true);
>  }
>
> +__bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_head *hea=
d,
> +                                              struct bpf_list_node *node=
)
> +{
> +       struct bpf_list_node_kern *knode =3D (struct bpf_list_node_kern *=
)node;
> +       struct list_head *h =3D (void *)head;
> +
> +       if (unlikely(!knode))
> +               return NULL;
> +
> +       if (WARN_ON_ONCE(READ_ONCE(knode->owner) !=3D h))
> +               return NULL;

Existing __bpf_list_del() is actually using 'head',
but here... passing 'head' just to warn on it ?
Seems overkill.
Pass 'node' only. Then it will be more list-like.

Any other apis are missing?

pw-bot: cr
