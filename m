Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135524657DB
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751543; cv=pass; b=Ymlzx2PdHFjePFx8o6woNcLsIc0eb6+pwW5d3vCt3JVELmiuzWiKWkG4Y/alIuMQ+ApNg/s+LYjViUitBA3PEHAxw1ADb8fuhZ0uK7HTpqeK1K965kC0Hq2El8mVVsf6ABaGnOkC7RnNzTtPI5J3nK4bIcigp/kWuwm5sK8L0pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751543; c=relaxed/simple;
	bh=RfAQIv+FKjyChWZcfNsSEW6hCNkKaMQ2UoVdejtyssQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkuQ3ZtZ2CSHQ4yO90E8yh/YUW9ZgFfufElzhwaX0vVn5PSIfbASfpsHrKlpsBptP7Tos4Z8mQZnvYjMCkd/2IpdDsyvskzAoAnPlDurS/yHKXLaQPeB3onsRFXj3Pu6V6itrwIR3O1a/Xgrsdjj5CRNtZKMs7Xie3tdiwBWg1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZguUt/6u; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZguUt/6u"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-664c6304683so1667783d50.2
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 09:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782751541; cv=none;
        d=google.com; s=arc-20260327;
        b=JPcsbTJxzjD+beiW1NHjM0/6DiyB/tMobGcWP3Jd4uVX6GJpusSxdTBzDK10UqW9Fo
         oeU7IeSrsW4beIH86nnxonLEAV1NtyTbQl8mV/qQpRpihOHx/EJO3+dvRb490TZbBYSU
         e4T/x+oiYmuQAITLTjNtX8mXqnL23dutssCLvEeHSQt0cXA8bRvlzsgmNE3BLCQJ4ouJ
         hBfy+4hX2sEJ9wGLA9xydJyqEylg9CZyBaxCOTzQ5F8KZFI/NV0qDQECRS/xkYWNOyQ4
         UOxNKllbLYGer55vCgvbpWUTdMaRW4dOtdTmidY3fhrjyRwKu8jK16NkLnXGuv8NjbEO
         vujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RfAQIv+FKjyChWZcfNsSEW6hCNkKaMQ2UoVdejtyssQ=;
        fh=XKE8cqTb/JF5vl4P8NIKySLcJ72kxwh9sEAPxfKwaCc=;
        b=Ofx8UwFrAh6rK8On0/THH4v/nz7f3ewSuV5U2q0FHyMRWypRn0+8kDoNIjYmUvsc88
         hyN2bo3+EpmBx/rLtLDonFX1huOg+D10LfM4/g4uxQ2yFL7Y55U1RE9A/+64kZ66c18Q
         Cni2Wu8dFq+gwou1Udcao+073UR+onU6/pU5FGsBbg2UhP6VS2fphKmngYkx92vjukDR
         sDs6mh/V1BawQBdkxaVUWGFjsfEE244r3aOt22fV5PgqsUE5h6C2wiQII1bXU03TR7Xf
         ctoQMaKkckYr40InUdztdNeTb0Qvc5nU/4NVLXSZQfbpOOQ2UgIbSWdaJM4QfGdp7wst
         2diQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782751541; x=1783356341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfAQIv+FKjyChWZcfNsSEW6hCNkKaMQ2UoVdejtyssQ=;
        b=ZguUt/6uRY+ixRON2HeGfISa9pTO7Pp4viBiXIbUCE6Hqj7rryzlkLkUB0DpsAMKMi
         baiGQ3QNQRJcKf+XCJtKDkUkakaSO4Vh6Wj4Rfq9KwH1xLISIxzFr9/0H2JVvujrFa3z
         93tTQryCrAYRP9anmQyeemy1aNpqtKbgz3vCrbHLUl8MEYjb0hS1GgvOoXZC/CzxfObQ
         +xEN6IoLFAbgvASMs22quUTQTuzBrtQH8XsGpR/xzI3i7FK7LVJxAnxWI5RjuDhjM+Gv
         IYqPjiS0/8bKwOiDaKL2USRipSjUQ8wx6V7yuKtssd+UNvCCBkkcgZYHKcQLjPJGgESW
         M2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782751541; x=1783356341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RfAQIv+FKjyChWZcfNsSEW6hCNkKaMQ2UoVdejtyssQ=;
        b=Q+1/Q4kLPP9tvf8WxmXfHFlSNJBHwSqAVFd4eO5VOyUV7BzZ/Blq+TzD9aIg+UH2XI
         Zy3dVQiDVQH2yMZN5Kg+KT8DuVHmKngY1CXDZEXxOeW4R7EAjcXAxhwbnkAeYGhLnhQd
         Q3O2AAq7AiHU41WAep+nxWzIJtwGu4Cf7dK4xQlpmGhP8/c7veeUl7LoT57xtaD8ncSq
         JNBN1x3KJ0SLu9t8OyqLbdpjwmhd4eplohENgubSSLPxp5SJiHP7Wg0qYglMvrK8zHym
         RtX4sr2bJeKaAYtdB7yyPiBOIMAWNlZrciZqG/44I5evTDeUJocvWuyohg1JCTdMlcPa
         lvzQ==
X-Forwarded-Encrypted: i=1; AHgh+RqoU4ruH2dM9AsJco/4kOZXC5OVGcNrIJp5vWNwEIp7xRsFGO1RlXnQ0YjLkJZJd5X/JHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJaPkdq9g9I5h4+QCwORREE+KYh4ad5VZ04lLfCP+VVKVE/90
	pVYybXNX21DOL+rg5+TiQXoIwjhr89hu+sx6E3foxbNAw3EUVa1o0Xg5PBJzirv32RDhk/dV2CG
	RriE1c8fwvswzXQGWcor8fYNXNyjHTFk3XRejB9bRNmkf4yPOUj6N6eVxTCM=
X-Gm-Gg: AfdE7cne9SI1fN25pieyEZq/sUrK75bomN8y381MvU/BjX9n7AVV/H5ZjSJDMpunEsj
	iFrS70z7eVmeB/gGvQOswI4esLG2CiUiukZgAPSbo7m9C762+xxvNaHcsXCyAoqd4AXG2PgeTEy
	DrOEheIMG4qynRHUyrHuPPvpY5JiblSV8gix9zgCiUSg+Xh/YvrzZEA6vDURxrWr8ORyAGNnr75
	aSHiuKc1JlusDauPVI+bCBnHJ7UygIwvJrv7C9JfaQqG4dHSTwaxbJRz6i3GcGGfs2o15zzqU4f
	hkBSJLgeYuXHO87sywORfqKpuZXuNeQPws7hWA==
X-Received: by 2002:a53:cf06:0:b0:664:e5c5:5b3c with SMTP id
 956f58d0204a3-664f9a36866mr296098d50.59.1782751540298; Mon, 29 Jun 2026
 09:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624-bpf-lskel-fixes-v2-1-e8ac5974a72c@google.com> <CAADnVQLURewU9wJ+4MTjCG9Uq0nR=c=oBbJ4vGbL-tRdp9YJBg@mail.gmail.com>
In-Reply-To: <CAADnVQLURewU9wJ+4MTjCG9Uq0nR=c=oBbJ4vGbL-tRdp9YJBg@mail.gmail.com>
From: Sid Nayyar <sidnayyar@google.com>
Date: Mon, 29 Jun 2026 17:45:28 +0100
X-Gm-Features: AVVi8CekWeW1fxinE3JpwJM_gtUOj6Fel1RD2zjrFANLf0oLUg3OXqT-fWzZggY
Message-ID: <CA+OvW8avnAOq8PAcboZ+YJs9hGsnZHN1bYWstytc+UqoTamnZw@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: allow BPF_LOG_KERNEL from kernel space
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Giuliano Procida <gprocida@google.com>, Matthias Maennich <maennich@google.com>, 
	Tiffany Yang <ynaffit@google.com>, Neill Kapron <nkapron@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 9:02=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> I don't think it's a good idea.
> BPF_LOG_KERNEL prints to dmesg and it's there for cases
> where BTF is corrupted in vmlinux or in the module.
> The verifier log can be large. It's never suitable for dmesg.
>
> Let's step back and discuss the end goal.
> Not just this patch, but overall.
> You're sending a bunch of patches for various lskel things.
> Please explain the full picture.
>
> pw-bot: cr

I am trying to enable support for STRUCT_OPS maps in light skeletons.
The idea is to enable loading sched_ext eBPF programs using in-kernel
loaders, such as a kernel module. I am preparing to send a patch
series for the same.

The changes I have been sending fix bugs I found along the way, for
example poisoning unresolved weak kfuncs and fixing a typo in
struct_ops map FD generation.

This change, however, is not a bug fix but just a quality-of-life
improvement. Having the ability to enable BPF logs in dmesg for
in-kernel loaders has been helpful for debugging. Therefore I sent
this change upstream. I agree that enabling dmesg logs for loaders in
production is a bad idea, but in-kernel loaders can use this option
during development to ease debugging.

That said, I am happy to drop this change since it is merely a quality
of life improvement and doesn't deliver any crucial functionality.

Regards,
Siddharth Nayyar
