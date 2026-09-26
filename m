Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB413839A8
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790445875; cv=pass; b=KIClb3XwVOPYGFXaqlywm/9Y7H3gDlFunYGcujqpxGRAjCQNwXRRo2DIsxPV01soCDqq2it8OW1qCvesHTJd8L7+zquh7bIQSi9Zjo7gVxxX3p8A8SbJ8r0+swNPqCrtgOW9RRPw0k7wwr0ctGWuf2MPf1xYq3tol0TldJjr948=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790445875; c=relaxed/simple;
	bh=tYFORwU82GIPiVzr9eaBMmA/qcuhjPtagnSM/ZDRX9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pz4FKtswRq5T4vO9q0PlEwdaBWLKW27CwjBRyefbWLil6p06kE5EYtdMY0aX1Z3YjIlyztdedHakji9F1akKILytxeZVxNDS0VBlYkUauS1yX2txsqkpnXEHwuIYsUEGLNl+GsrNOliLK1vs9CXb03ufjALX5x83cgmQSUNUbDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=LGV9soC+; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=FvLRvPWL; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="LGV9soC+";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="FvLRvPWL"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68QFPIwF1150816
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 18:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=GtJujZlkuQ828dseqHuH0wNH7O6BdO/6unmn1amR4z8=; b=LGV9
	soC+aInd4sX1l7uTzgoQ+Bbhyd2HkmJqVZhXe3ZhkYDaF8Jmo50EjRC/Lmmx4Y2d
	0eTfjZGNczmdDplfLhcPcyGG7S6P2pv1zm2zpl/5wIg56QK3QUoNV2HoYO3tMdcH
	L3LI2+EwUzjrFeENDcgXrTb3YT/umka7avreIdzwj9kBOGovz2mtwlf5kd2qY3vy
	+TL/q5HFRW73RIwFtj3FX2Xdgs9+sYxVVkGS8lQiEnoVj8o4SyNDEcnc4LoDYBzb
	uC6K4RXbtcRuNADpRSchaWnUtrBzpRtgUz6tdrYGMydQJ9qonjTFpJp+qyh1XQCf
	RoyC8gNJGHoQ+JchEw==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4gxade927q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 18:04:33 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-673263bc7e1so2084569d50.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 11:04:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790445872; cv=none;
        d=google.com; s=arc-20260327;
        b=lQz1sFMKGEIkhMWpzWw9n5CbRG6mOM0JI1JAQ7NMAat8g3cv2ruWAPYfimcMVrpxU8
         SClxoaGonrP1IlzBS6b/Q8OZGjPh9PSq3SGU7/VP0wMxDreU4i6ig8kqHXQ1OtqvfCMg
         FfU/2swOAjzr4TuC3oehP8e70EV8jiIP4I3Zv87FVEOKE8FwGwzZ5iYE6rPWAmrJXkYE
         fCKU76MA6YuUUB1HzEJUzKFEJfV9cK17SktSV37ETEgEJoHIOUJ4RuTTLw+P/qt+4zXS
         8513gd5AKo8JwujIkArZLZjQ1GuoMEYzVtf2kQldp2y/y3dNgRywmURrljhaysqtakaT
         hN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GtJujZlkuQ828dseqHuH0wNH7O6BdO/6unmn1amR4z8=;
        fh=gRVdEfKsy6bBYj2FtlGsH3p7h37Tvsw1/iQP5r5HM4k=;
        b=LEluLIZ2NPjH3luwHv9Q3dpWghXOA4k5wTFEeRqRPfmOCVHWUasl+LvTH2eqxst4q/
         n8HP9/OE7jDxO0Ac4YeQ4w1uvJawEAoFbAp4qNxSYJqqj3yZldhuV6I0T6ZIpIRMxEry
         eejhiCoiS9czP5KbehJNp0vkUW6yQ6ldt+rwPLosiIPdKhU4d/uWG00hTzM552h/UM2l
         S1Nq15uKdGl1OWSvE3GUThR3uciBlhRjKGXcSksEhzWqFvhjZaCZ+tGNgiYQpqfnlCDL
         N+Md6hUDwAEM07rRQM7/jwmxeoce7PlwQWiJ4hZIL0uTZJ2QLUhopNrsJMveo2TH6Thk
         PWWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1790445872; x=1791050672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GtJujZlkuQ828dseqHuH0wNH7O6BdO/6unmn1amR4z8=;
        b=FvLRvPWLyNLIVSPrQjcVaaVqqd0z6zRYp2V87kQB2CJO+gp0xvcI+fBPbExfkChXiY
         /ch/JWaL5COycHuZxTqGkE5mR310pE7/B9jTkE2ZWljU9Naq+rae3Ek0B8W9yfL4YKn5
         9LwE9OTxxRYbLr9B5daGazlRH+fgxgUNV2BP+USwRKc/MyWUeFQY56EAKwir4v36+Qcw
         MgStWeco7CqPEqkounJyKKIq6CJSv+uCmbNpPBjvjYwyVqCE/liNOA+9bCcZvm/oG0bK
         y6ekmvr8neewoiPZ2XoHKPQO2qRIsGp2LzulGPRTDKOcHzVKm0jgzpJEJb8v3LzUuyg9
         PG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790445872; x=1791050672;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GtJujZlkuQ828dseqHuH0wNH7O6BdO/6unmn1amR4z8=;
        b=RDOMnm47Psq4w0jzS7TFF5VDowUclzf6yYT4t/R4EWzhmijmZCNEtQ96NRaOpDlg45
         3LAUhWibWIty30DJQBT+4vh+cTBAcj+RBCFMpqI6QyGS/nJT0gjAqgLM/zQ37jOoXzOv
         woe5fYkg++8y1m2WNKBEvgdQVHmxb+Y2ldG1BtkcINhNShXgXdD5o49KD/jGpLvLMQ9a
         PqcZaAMLAi1oFzU1+LW0n0ZZqtpry0/6qwz3DcssEgWODN0ZqOb9yIoHsvGreY0nEjuc
         2Iw5XTWigpuwoIHZKu1AobB9IhANZTz3o86+cIOPR4/mQCorvf+n3HqHRo9C19iIn+wF
         vpHw==
X-Gm-Message-State: AFq9FYJbS5PzExFitXAaqLSZrz+AdBapXSF3wFMyIQjzoAZUnxykKKNj
	gQo2CK7DSyQgm5AJ837b5ou98YUqxl8/WkyvgUuG2JxgLhZNjrT+K8R6tfTPmNaw6U4+Aw7wHFg
	SABUtfJrJWSs2pwqEnu2W9MxgCeGiqK8a+EWXM5W3l2OcwLpUjIYgi/j704ItOcegx/qUg8g+t7
	0/arVVWKeTnwJxrCfk+x3/EitbjoNG
X-Gm-Gg: AYBFou0GjxeG8gfSKXrGHKVZm+YzHOUnjXVXhy8WejN7Qd36KTBorGiijDb6eC+FvbZ
	cg4LPkfAaKeDPNkTeV3whq3rKjB6ig2lTrBBh0s7OYVfxPOJfXQd9lzAjZ6ZhJmhrdBo9LRzd57
	ysSoMim+AQh742WQ7S5yWiuLGhPaA4HuYTTYd1j0OFpvJjdSiagBAcdjqpKA==
X-Received: by 2002:a05:690e:d58:b0:675:3247:9b3c with SMTP id 956f58d0204a3-6753247a4bbmr428695d50.42.1790445872122;
        Sat, 26 Sep 2026 11:04:32 -0700 (PDT)
X-Received: by 2002:a05:690e:d58:b0:675:3247:9b3c with SMTP id
 956f58d0204a3-6753247a4bbmr428683d50.42.1790445871586; Sat, 26 Sep 2026
 11:04:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
 <20260923232939.1886328-6-andrey.grodzovsky@crowdstrike.com> <CAEf4BzbgkghzOfHJh-A9z=kMn=NaHgr04_DUUrQ63bvHaAsqTg@mail.gmail.com>
In-Reply-To: <CAEf4BzbgkghzOfHJh-A9z=kMn=NaHgr04_DUUrQ63bvHaAsqTg@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Sat, 26 Sep 2026 14:04:20 -0400
X-Gm-Features: AclHuK9m4SJvzgH8tdPrh3tJU4ducfrzz440g9SD_ELiz6OphluwTg_J1yw3VKg
Message-ID: <CAOu3gNjv_NciUt-UxxmfpyakLzpF2tmu+J34g91gxAkuFMSOfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/8] libbpf: Version bpf_program__set_autoattach()
 ABI change
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com,
        linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3MSBTYWx0ZWRfX+mhfJW46kE4m
 TT6h+BvZsimy9wwPxM005yJ073RrAyRm4upUYuSryLqWzyOawQJ7hCL/Dmd+40dVKiR9c0Lm+JQ
 vGVXK6MsFuTHqtgJV8uzhPXxWS88PI/yMEujvhIDt/srHnB8eTr1YS58reU2i3cfphmbryMSsv/
 LUQnuxCppIgela6P5TeoOJFFjH1Ezqm+siko2WLphOhuYt1mF9+8EFuUBl6GGPRL7PrzNItBJvX
 JU0PnW/5BNhVoYboMwqJuKw+UbytyPoWWgiONeP9bB4CwNzQ72PwOD5Z56FOET5A800dRDrGC29
 NLlU7+8L9Tfd+86NzZrhXrUoKoiz4i2TwAvGi6PL5Bae+HYAqmmRqBN0bqqYNia1ZX0HGLfF9h9
 Prxm7id/V+Qa9mwRc1LOWV8JM9KebRwKoCrseZ2dRhw0JsUwPdFuxApQoiWyjc8eNURx9aLWi0G
 qAzsbGl5cvvwkS7VTkQ==
X-Proofpoint-ORIG-GUID: GTMG5Cvg6arI4GueQBBkHJj-Hin3g-k7
X-Proofpoint-GUID: GTMG5Cvg6arI4GueQBBkHJj-Hin3g-k7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3MSBTYWx0ZWRfX4s7JxOaz+zxl
 YLpsFBzZhwi5EdzdEm/XuwFErApE5EpbDy9H4v7p1UU4E9fRLb2vZMyb8aE//68UHQavEVwPUgQ
 YRRLu/nPnpvsaXl92yQh+0o3GqkwOq7876HdoExP5gaUDnYJ4qOE
X-Authority-Analysis: v=2.4 cv=DZyCOftW c=1 sm=1 tr=0 ts=6ab80931 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=t04HzT_fAfAF5W-3wVZy:22 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8
 a=y03PYLBpwSwoDu5VP9oA:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11917
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260071

On Thu, Sep 24, 2026 at 7:19=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Sep 23, 2026 at 4:29=E2=80=AFPM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > bpf_program__set_autoattach()'s return type changed from void to int to
> > let callers observe the new -EINVAL rejection for MANUAL-strategy
> > programs, but the symbol stayed under its original LIBBPF_1.0.0 node in
> > libbpf.map. Binaries already linked against the old void-returning ABI
> > recorded a request for exactly that symbol@version pair at link time;
> > without a version bump they would silently start hitting the new
> > rejection behavior underneath them after a libbpf upgrade.
> >
> > Split the symbol via ELF symbol versioning:
> >
> >   - bpf_program__set_autoattach_deprecated() keeps the original
> >     unconditional behavior, bound via COMPAT_VERSION() to the existing
> >     LIBBPF_1.0.0 node.
> >   - bpf_program__set_autoattach_v1_8_0() carries the new MANUAL-rejecti=
ng
> >     behavior, bound via DEFAULT_VERSION() to the new LIBBPF_1.8.0 node.
> >
> > Old binaries keep resolving bpf_program__set_autoattach() to the old
> > behavior at runtime; anything linked against the current headers/map
> > gets the new int-returning, MANUAL-rejecting behavior. Also adds the
> > missing __LIBBPF_MARK_DEPRECATED_1_8 gate to libbpf_common.h (only the
> > 1.0 gate existed) so LIBBPF_DEPRECATED_SINCE(1, 8, ...) can mark the
> > deprecated variant.
> >
> > Assisted-by: Claude:claude-sonnet-5
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  tools/lib/bpf/libbpf.c        | 9 ++++++++-
> >  tools/lib/bpf/libbpf.h        | 6 ++++++
> >  tools/lib/bpf/libbpf.map      | 2 ++
> >  tools/lib/bpf/libbpf_common.h | 6 ++++++
> >  4 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 85e1d9c775ab..224fb0247a39 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -9974,7 +9974,14 @@ bool bpf_program__autoattach(const struct bpf_pr=
ogram *prog)
> >         return prog->autoattach;
> >  }
> >
> > -int bpf_program__set_autoattach(struct bpf_program *prog, bool autoatt=
ach)
> > +COMPAT_VERSION(bpf_program__set_autoattach_deprecated, bpf_program__se=
t_autoattach, LIBBPF_1.0.0)
>
> no compat stuff, it should be backwards compatible to change return
> from void to int

I was more worried about legacy binaries dynamiclly linking against
this risking to somehow getting silently rejected by load_strategy =3D=3D
BPF_PROG_LOAD_STRATEGY_MANUAL check. But yea, practically this is
impossible so I will drop this.

Andrey

>
>
> > +void bpf_program__set_autoattach_deprecated(struct bpf_program *prog, =
bool autoattach)
> > +{
> > +       prog->autoattach =3D autoattach;
> > +}
> > +
> > +DEFAULT_VERSION(bpf_program__set_autoattach_v1_8_0, bpf_program__set_a=
utoattach, LIBBPF_1.8.0)
> > +int bpf_program__set_autoattach_v1_8_0(struct bpf_program *prog, bool =
autoattach)
> >  {
> >         if (prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL)
> >                 return libbpf_err(-EINVAL);
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index faea42f75847..d172c137cc37 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -393,6 +393,12 @@ LIBBPF_API bool bpf_program__autoload(const struct=
 bpf_program *prog);
> >  LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, boo=
l autoload);
> >  LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog=
);
> >  LIBBPF_API int bpf_program__set_autoattach(struct bpf_program *prog, b=
ool autoattach);
> > +/* this "specialization" should go away once the deprecation window fo=
r
> > + * bpf_program__set_autoattach_deprecated() closes
> > + */
> > +LIBBPF_API int bpf_program__set_autoattach_v1_8_0(struct bpf_program *=
prog, bool autoattach);
> > +LIBBPF_DEPRECATED_SINCE(1, 8, "use int-returning bpf_program__set_auto=
attach() instead")
> > +LIBBPF_API void bpf_program__set_autoattach_deprecated(struct bpf_prog=
ram *prog, bool autoattach);
> >
> >  struct bpf_insn;
> >
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 8def5474885a..999e791d9887 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -465,6 +465,8 @@ LIBBPF_1.8.0 {
> >                 bpf_program__clone;
> >                 bpf_program__load;
> >                 bpf_program__load_strategy;
> > +               bpf_program__set_autoattach;
> > +               bpf_program__set_autoattach_deprecated;
> >                 bpf_program__set_load_strategy;
> >                 btf__find_by_name_kind_own;
> >                 btf__new_empty_opts;
> > diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_commo=
n.h
> > index 8fe248e14eb6..12ad4f5f558f 100644
> > --- a/tools/lib/bpf/libbpf_common.h
> > +++ b/tools/lib/bpf/libbpf_common.h
> > @@ -36,6 +36,12 @@
> >  #define __LIBBPF_MARK_DEPRECATED_1_0(X)
> >  #endif
> >
> > +#if __LIBBPF_CURRENT_VERSION_GEQ(1, 8)
> > +#define __LIBBPF_MARK_DEPRECATED_1_8(X) X
> > +#else
> > +#define __LIBBPF_MARK_DEPRECATED_1_8(X)
> > +#endif
> > +
> >  /* This set of internal macros allows to do "function overloading" bas=
ed on
> >   * number of arguments provided by used in backwards-compatible way du=
ring the
> >   * transition to libbpf 1.0
> > --
> > 2.34.1
> >
