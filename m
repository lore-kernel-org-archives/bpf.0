Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212E2396562
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289814; cv=pass; b=WPt4oLS/OjAsMoh4nyzM9SqIdu7PcsflL8r0JOhDat0gvBRg/2WrMvo5z3lxBQho9u5j8fsuZpIXpGVTZmYalzMPYCXcFyEVJQXg/LjkE2L/5jdYVvepQwD0RqGYF9PeB0oiD1K20EbjT2vk9CdcWO5XsI9iVoCNF6N6cHAl6vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289814; c=relaxed/simple;
	bh=IQZpujVP87VTdmXVxfTNfi9J/0IXL9EHLyAaVdEbWQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFuhstzYZB4USi+Gf3pnbeVyZuVppcu5NPWvX03j2Bn72WcQe59nS6Akd2ocXHSOPV8AkwAsHvAg4ivO+hYAE5aHiCz613+rwKoH9hJ3gdcv3J0c5FSBFU5ryXQHXS8g02cQoGquvRvTG3TEgjbYuCkAi4DZ68/uuzq+rJww1ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FNqgjgKD; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNqgjgKD"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-137dd3af345so1324103c88.0
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 11:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781289812; cv=none;
        d=google.com; s=arc-20240605;
        b=GmkpFWlOlcYhb2/hWZNutxfjqSNzyJA7C5hze5HsF7IPRZpoNi4Dd6yYXqEBVmy57v
         tzZEYKUmjGl2scyc64E0/0y3tBoT+/gkpP16EtHrmFaP/fwHKtn97JjpWG03FvHRgBCF
         G7HEen6nabGJmynb23SRMN4SAZEWF1Nto3T0ThWQTmpuvz9o+kqLO1PgK4K0R88AjFPy
         8tILuCQcULwWYZkYNXgE8vn4hEVt9NTIJkU7/0qPEjNDXKHVs+eAJOKXqw5tYfmOQLnF
         RYrbcP5e/QZ9wA1h45auKn+Dj0Sj6c2jmYiL0m4DlGVm6gXrRbbh0/ZWtiNeBCUFquHX
         4buw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZuYKYCkwO9VPPo9z/rSbFexmMoWoCjN3fygPjKuaDfI=;
        fh=SMN6aGEIJ9520ZfVb29NSv23iIPBBhGcX/AuFXkgSiE=;
        b=WXni1gfo+JyUq20qi+ZOygfEUukFpiJtoNxzpKb4dKSMg4L6fBFOp9MqWG93XWa3Dn
         irI6ruVuYe6ic+krgfbq8l5BxGM9UpncUbEfj4x6w6YVD6mN2+QyPV9lrnr4pxhFRxS3
         1uI57xuvMyOQXYG+zJp5zuuixq2IKT1LAnwU4kT0jTxXwtZ+4rELSBUoz6KnHEo+PV+L
         FQXSHwHtaus5+zY6/c93yqd1W8HAqinMAIS8b0IOqvv0t7prPRg72D64tjqFgut6DQQX
         mYGazkzo+ueZ7oqchpI0JVXdFWiJROR1gmYMSCYzwEtcVlicGyVfD0TShg4vQZY3o5E+
         iPqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781289812; x=1781894612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuYKYCkwO9VPPo9z/rSbFexmMoWoCjN3fygPjKuaDfI=;
        b=FNqgjgKDckM/ef/CMXnPTNMN1jfEk8s4gs8f9SetKVyxbd+n4K1AEEwZ3OYV0H9yw4
         TndiQagpsw9Dv0OpqPJmlWl/X2s99mp5geH0oRQ5iP5EWzQbOgGz1/OmDiNiRxXKEqLg
         PthTVFY+8Zzjbo3qsNgag8YlB9qYdkUToYF5pC4fTCsnpQZNIT/38ySyjf4F+HbiFg+j
         eFNaOxY7BZnmnuXq2mqSLvVgyERmOmN5pmLO8lgUad0/tjRIBIN2N6LgM7+el73WXaS0
         dlu5/OuXV50SmD3cWcZzGLqXCgD4lKqGiYuSS/HbmTtMIjARhWiMh4+a9NrxSxm+LeFy
         LH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289812; x=1781894612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZuYKYCkwO9VPPo9z/rSbFexmMoWoCjN3fygPjKuaDfI=;
        b=DFuI5Abs1a+6PQ0yNYYKsYR/nr4q+d9Yi4QZH5IQS9rQ1uBdlXmFS3VZ779CSWsjdB
         190tWiQyzfqoMRl/LuGMLhEnvbVOKzIA+PcYZKAJ+sNlPcY+U2u/nxWe8kSUkiaWBMaC
         drk0TNBkw1aTN7fj9LA5+ebOria3ZZ0AvgeGgKwffpSuhB0WGQE19G2zf6C5TjZBC6gR
         BC4ZnIk6FAaYivy9U3MfMZeitA1STI9KjnO8p6EMrGmmIO/sRfqngOtV238aJIj4OTRL
         DCbpag6OmuGPO09EgAT6QdVH3Wxsjt5CuYlcKq5r2babAAdbhpwLeic/KJKjJj1Sw2P0
         NFNw==
X-Forwarded-Encrypted: i=1; AFNElJ/ND2idKS4ItRPi1+vZcUEvYSDj3KyQWB7OgaK6ejIltThPgztik6Uk7r0qzu1HebhoTI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYWnlFCe66KH7/JVxtzYxZx9cDqb34RGDxPp/2DR6VT/Jl6GLY
	q5jqNy55jJ1xOavxSxxCqVxLcuCQ34eIv2EjZg+76jiY46oi7iALA2naW3Id7HDyIQeN4dRRXnF
	biR1/flh2pWWzp8ZMWiFKlmbdEKaKcmILbfsiExeM
X-Gm-Gg: Acq92OGc8iD5peedka7KVHYLU5w8YZ8qcBplmMYBB56yWKUloJ3qYujWLvo38QG6TsV
	xy/MyUwYm4ofcHpVd8QsMQS3f0VWl+m2kW/MW0ncc92oj9Sv7o2hZdAjUZydHHbx5od7bw5jz83
	Yiys/+5Zbscp7VwszwLcqyZpsxwW/aqdEc5j4LbF5pSnFVVur+hOrzsfcUqhl8bzhVEHvJZYRP2
	QrnogfZYhqv0H2390nckjO59bPMNHHujCOPFeA/uih5xMMIoqUt7sRjkovYOMdkgDoMwyrY/TAR
	2FrqxuVOutam62EhyHPxcgNnUc9bemxnVsUI5H9ALw7AtE+48a7+1YPPbsQ3lqIxLaI30NSMfAo
	TYyGu7jYeyadVeLppLOpO1Z+MP+Hj0pHaSpdg5vP6dPWFNYagDVKO
X-Received: by 2002:a05:7022:418:b0:137:fe07:8a2d with SMTP id
 a92af1059eb24-1386f24121cmr436470c88.6.1781289811262; Fri, 12 Jun 2026
 11:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612130919.299124-1-jiayuan.chen@linux.dev> <CAADnVQKL26zPepqOf_FtuA6ALQEtFJmiKU12iahdvfeAyJ7XhA@mail.gmail.com>
In-Reply-To: <CAADnVQKL26zPepqOf_FtuA6ALQEtFJmiKU12iahdvfeAyJ7XhA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 12 Jun 2026 11:43:17 -0700
X-Gm-Features: AVVi8CfZ2Yztrdd9Cz0a8Cioo193fVEec7AtKDsitODSamBkyRtcTNl8C85ikBY
Message-ID: <CAAVpQUBmiyfW-3FjssDUmbOXyA+QbsFyATEs2D38ZbWfpNQE+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/7] bpf, skmsg: some fixes for skmsg
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, Shuah Khan <shuah@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Sechang Lim <rhkrqnwk98@gmail.com>, Cong Wang <cong.wang@bytedance.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 10:10=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 12, 2026 at 6:09=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.=
dev> wrote:
> >
> >
> > All fixes are from previous patches sent by Weiming Shi, Zhang Cen,
> > Kuniyuki and Sechang Lim, which have already been reviewed by me and Jo=
hn and Jakub.
> >
> > https://lore.kernel.org/bpf/20260610081218.506709-2-rhkrqnwk98@gmail.co=
m/
> > https://lore.kernel.org/bpf/20260520102715.3033936-1-rollkingzzc@gmail.=
com/
> > https://lore.kernel.org/bpf/20260424190310.1520555-2-bestswngs@gmail.co=
m/
> > https://lore.kernel.org/bpf/20260424191602.1522411-3-bestswngs@gmail.co=
m/
> > https://lore.kernel.org/bpf/20260423155807.1245644-2-bestswngs@gmail.co=
m/
> > https://lore.kernel.org/bpf/20260221233234.3814768-4-kuniyu@google.com/
> >
> > The automated reviewer (sashiko) may still flag a few other potential
> > issues on top of this series. After looking into them, they are either
> > already covered by the patches here, or only reachable under very narro=
w
> > conditions that require a specially crafted BPF program and an unusual
> > sk_msg ring state, so they are not practical to trigger and are left ou=
t
> > of this series. I'm collecting these fixes together because the same
> > problems have been re-sent many times in slightly different forms, and =
I
> > hope this series can be prioritized for merging so the duplicates can
> > finally settle. With so many AI-generated patches floating around for
> > these spots, leaving them unmerged just keeps wasting maintainer review
> > cycles on the same issues.
> >
> >
> > v2->v3: Target to bpf-next and carry Emil's reviewed-by tag.
> >         Reverse xmas tree style is used suggested by Cong.
> >         (not all code match reverse xmas tree due to variable dependenc=
y)
> > v1->v2: fix problem when fix the conflict.
> >
>
> Kuniyuki,
>
> one patch is yours. thanks.
> Please help review the rest.

Sure, will look into it.

Thanks
