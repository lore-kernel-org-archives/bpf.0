Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802D2D5436
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655655; cv=pass; b=D3kghnsIWIMx6NNngolFtkQsjXu2YY6IPoXhgbbzBX5O85iiEzrhMkQuctOcVVQ3iekts7oZqSbNumMxiLIXrWt1rn0CHEIaeJmPIROjRR8OjMd2IHA+HhattKhp9bVQAoYXXlbzvft/W2bPwrUO1HQ7F4hl8l6mbVdvwmP8KQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655655; c=relaxed/simple;
	bh=jcij0a0bdJCJHImpik/mNjjxwB9JULp6Ljj+hpCdPzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBfVGDf+QVEe8zUCA9cHixO+AgKVkiLr7eOt5fyTkAMKS+6v2HdMJVPbE6J5rVl4iriL4KcDAwFkX8GAOzdCAbtohm72ZEAN9883bgeKl9JVr4Q+mtQywJamNgWyqR4Jo6S0GmpjOZ4cpb+k7B/D3upnta6AzsvkTLWFtP+elCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abCSjAai; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abCSjAai"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66843536f94so2408616d50.3
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 10:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784655652; cv=none;
        d=google.com; s=arc-20260327;
        b=DHEzaDobaFZoCUM18KZxd1j83HL4eSo0Yq0IpaqhTdPhI0xWH4UXT4P2oP36o1FDu8
         yY37zo1PG5FpeCciV+hJshx3QG6RFTvvnvM6aGT8FpJWv2hs9b1HIaxIfozI3NBOSK0W
         q0Sl0IxCN5NVOPmXa2KNBp6UAu95tjJVV8diCZBuXuV64S4Cadimnuzl4hTC4ZdkuLyj
         oQALikrl2g4rPwfHq1j1aDeX90ChbGRAA9voQy7cA91P6hWLPTMCHEhDDW9h/60RHd6M
         aQyycEKqnbFMKJbu0x4e35iZgRvEW1VEcgonKEsCwhkbkokmXbJnXzi2+7CUspso6fk7
         Oa4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9almTHjFbfDOI+RxAOp6GPttHl5pp39q475h1J3QeVo=;
        fh=zu4DkwjPVDqXRxzOFLLTuWmAvlQCKk07ey2FM2+++eQ=;
        b=N10KUgWmRXpmpQfk//BTikbVcbxuBVRkpfSrSJzhYwpUE+Yyrum7+F+Lb5W4iCjCiW
         yKSRxIgF3/ap+MVbXpbah72mFomSQhIb+bMfVl2k7J/tRYfKqg7r1mhozyR5LUV2f3Lk
         dgyVPi2iomhKcqFqputyKsFGGCZ9W0Y0I0USV/7cXVtlYfog5kckhgPbR1Euv9+xq7B7
         ElUG9d5u4Lgj9eAI3sE5AUa4f6HjZntiz9rBRU3DZCqpNJrgjYIgxk2LKRA3xC2ZQ1PY
         NOh+UAgWVrfNvqPEorqf5Ir9mmt245QWsuCnA3I9YoQrtYuH8haEEjFLkwxuGeeVE0gp
         7OcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784655652; x=1785260452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9almTHjFbfDOI+RxAOp6GPttHl5pp39q475h1J3QeVo=;
        b=abCSjAaizhkAYigZhknYFWmQpvkYXHNDtUplaf/vlbARdTwz95Cmeh8fQp0HIYgb4C
         kPDvqkFQccvL2dkrwFUm2fF8Yqrd368QA2WOgOtllbTImlzBl5PWZjqxvf5NNH5UIjcV
         /NxDVqlGP3w4tARlMTlW+gTbAQNPaEpZMeVROPccvQJ0cDdIEH4THcu9cD3ZoTEnnOm1
         dpkNFYYgM7LmGSYqhjZE+4THqHEW0mc1ykA64BoOAF2cJpjB3JiMWKZsM0zH4Dxl8uZF
         F8FxTKurYx9owcZ5YjMnTdoEKTW5ETBZ12YWwMR8l/BBcEySDEwQN0nK21t++vshwCEz
         48Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655652; x=1785260452;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9almTHjFbfDOI+RxAOp6GPttHl5pp39q475h1J3QeVo=;
        b=SDj+Wx2F2mr2Li59fBCgPfC2imUWnt37OC1/eF0vg0j+zqIZ33Pf/AXKveiEVn4mEK
         eFfSL9cO6PFYywx2LG4ydtsIkSARMl2/KOAK31UxNXSj/Miu080CYBGMEsrjAZpTgd7F
         RnJKrbkdXzNEnQfXeZO5Hu3ISO8txQkGcMXcoU48IHFm8QDEsK/3spreSy43Wwdrmz7j
         U49uTtlYEJR6icpOJe9MbMFdC93hIzOMqK9EftgnMChg4RM33CohB6zzOj3bmLjNiM6E
         UCcHfnEzW58NO37NDYLzz8iBIizyjZzZE64KwGIiJWGPjw+nqdm3EKqc3/5bJZRGwh7W
         87Zw==
X-Forwarded-Encrypted: i=1; AHgh+RrlDTf7HbiaZJtIDxTz3710ZWU2auRmwPNmjfXjVujY3/GtmTFb6BfYmgpey+hheB7aPvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+FICO+ZYuDfSZubjp1GgWxD1pvMz5H035ypvBlIc5l1B+nfvA
	nFmx+tC3999KPDiq/XTtkC74W2l+JgnvJSbL9Vpa6Rz6Bx33xaedvnvwiGV0Rm81+6l3TO3j2uA
	d3kJ4fkb/snHzvBjYPvc27OhRK8zbp1A=
X-Gm-Gg: AR+sD11Wo5QkUWkn72rPv/2kWKdme+omk/KOt1lkzXgJQFT3fD12M6dYUKBlTt+Gpon
	GnoeG3igFZyyBOabqIbwTkNpzOs/V+lMlkC84WeGEsERVdn802zfvxjW2S2McRK7PvvYpP1ULYE
	PCVKA+oxJdpNVBOEDfimwT9ZMfgbClD7M+aWvEtwJARdCQTrd45mJzNznn/8C71m/vxPPbpu5Ed
	j3a2NVw2dG9aImspDrfpzsGG9dgZEzw08Bs2KGzM/t/gkfJuSs6r+UHwbiRPhtRAr7rbgKA
X-Received: by 2002:a05:690c:4c0f:b0:81d:78e2:2a8b with SMTP id
 00721157ae682-81ef2736942mr63499637b3.7.1784655652574; Tue, 21 Jul 2026
 10:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721041048.1394085-1-pulehui@huaweicloud.com>
 <20260721041048.1394085-3-pulehui@huaweicloud.com> <20260721042151.E6F941F000E9@smtp.kernel.org>
 <723495f2-f4a0-4723-90a8-d4774e6dce05@huaweicloud.com>
In-Reply-To: <723495f2-f4a0-4723-90a8-d4774e6dce05@huaweicloud.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 21 Jul 2026 10:40:41 -0700
X-Gm-Features: AUfX_myeOPuVGwDAlQRpaJu1g5jzmOaSvCbqogymasHlCTogZaZlynSes9d40bM
Message-ID: <CAMB2axMocV3+cC8O5LEu-0bPcGvchwjASbjM_afx=Stc_8AvKw@mail.gmail.com>
Subject: Re: [PATCH bpf v5 2/4] bpf: Fix UAF due to missing link type check in mprog
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 2:18=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com> =
wrote:
>
>
> On 2026/7/21 12:21, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] Anchor link type validation is bypassed when attaching or de=
taching bare BPF programs, leading to wildcard insertions/deletions and dat=
a races.
> > --
> >
> > --- Patch [2]: [PATCH bpf v5 2/4] bpf: Fix UAF due to missing link type=
 check in mprog ---
> > commit 830a4e62ebb8e98cc45b0ce829c6686aacafabc4
> > Author: Pu Lehui <pulehui@huawei.com>
> > Subject: bpf: Fix UAF due to missing link type check in mprog
> >
> > This commit adds a link type validation in bpf_mprog_link() to prevent =
a
> > use-after-free when dereferencing link->prog for foreign anchors. It al=
so
> > adjusts bpf_mprog_attach() and bpf_mprog_detach() to pass down the expe=
cted
> > link type.
> >
> >> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
> >> index 1394168062e85..37ce91e0bcd21 100644
> >> --- a/kernel/bpf/mprog.c
> >> +++ b/kernel/bpf/mprog.c
> >> @@ -17,7 +17,7 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
> >>              link =3D bpf_link_get_from_fd(id_or_fd);
> >>      if (IS_ERR(link))
> >>              return PTR_ERR(link);
> >> -    if (type && link->prog->type !=3D type) {
> >> +    if (type && link->type !=3D type) {
> >>              bpf_link_put(link);
> >>              return -EINVAL;
> >>      }
> >
> > [ ... ]
> >
> >> @@ -243,6 +244,7 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry=
,
> >>              return -EEXIST;
> >>      ret =3D bpf_mprog_tuple_relative(&rtuple, id_or_fd,
> >>                                     flags & ~BPF_F_REPLACE,
> >> +                                   link ? link->type : BPF_LINK_TYPE_=
UNSPEC,
> >>                                     prog_new->type);
> >>      if (ret)
> >
> > [Severity: Medium]
> > When attaching a bare BPF program, link is NULL. This passes
> > BPF_LINK_TYPE_UNSPEC (0) to bpf_mprog_tuple_relative() as the expected
> > anchor link type.
>
> Ah, so when attaching a bare prog with a relative link, having the
> BPF_F_LINK flag set means the relative id_or_fd is a link, not the
> object being attached. Sorry, that definitely confused me.
>
> >
> > In bpf_mprog_link() above, the validation check is:
> >
> >      if (type && link->type !=3D type) {
> >
> > Because type is 0, the validation is bypassed entirely.
> >
> > If a user passes a foreign link with a NULL prog (like struct_ops) as a=
n
> > anchor via id_or_fd, the positioning logic treats tuple->prog =3D=3D NU=
LL as
> > 'no anchor provided' instead of rejecting the invalid anchor with -EINV=
AL.
> >
> > Does this allow wildcard insertions or deletions, and leave a benign da=
ta
> > race when reading link->prog locklessly? Should the expected link type =
be
> > explicitly provided when attaching bare programs?

I also overlooked this. Make sense to pass the expected link type from
callers of bpf_mprog_attach().

> >
> > [ ... ]
> >
> >> @@ -343,6 +345,7 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry=
,
> >>      if (!bpf_mprog_total(entry))
> >>              return -ENOENT;
> >>      ret =3D bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
> >> +                                   link ? link->type : BPF_LINK_TYPE_=
UNSPEC,
> >>                                     prog ? prog->type :
> >>                                     BPF_PROG_TYPE_UNSPEC);
> >>      if (ret)
> >
> > [Severity: Medium]
> > Similarly, when detaching a bare BPF program, link is NULL. This also
> > passes BPF_LINK_TYPE_UNSPEC as the expected link type.
> >
> > Does this bypass the new validation and allow wildcard deletions when u=
sing
> > foreign anchors?
> >
>
>
