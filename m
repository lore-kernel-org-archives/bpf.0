Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A883E9C11
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121107; cv=pass; b=AJt33XKkdZuCs8gQQMFDy8XT0D/1y5n0AtUIdL2hHGTvJnS0mdRlNZW51LytMA5Lxf7+lJv2fKegRE44oj4xeGlqRBH3nXMgdKkd1aVweQPyo1w9P7mhkejX21gF8SkLZP395p59ksU/Q2wfhDNXXzaCBlDIyF40RlAO+y28utM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121107; c=relaxed/simple;
	bh=dceIWq6rVgqCz4ffX7k9XoJv7TbqaySvnVQCgI9aVKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9qd7DF8f3juY5qU4Y4dh/n/K9vCvL/aN1CCusb8Gbha7rRDYsV1uM95qoc5+M7J5TUm3ixKk2R+4wGlt/ua+Amthg5HWqUQ3nyZYHXnelEDhSw3R6ZoILnQwqrhlHv24EayBEU8QruNS5p6Y1IeY+T873IJSHV2nO6UDyKMyQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=jbHA/Tyz; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=S3/62wng; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="jbHA/Tyz";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="S3/62wng"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI3tsf2542178
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=6pbAmNYRfe9FixeR56ebwQxRT1+2/Is5WxKXJC7FLrI=; b=jbHA
	/TyzrXRtkU1uTQPxUs4DaoH/wlZlZ4R3HZgcquSOsDK9cKPGMNHLKxqv1aKDffQf
	fOWhP5Sa44HQC6pgg+HI7ErYQiZw9iLULSAWjz/2rk3Piww96qCh4Fg4v7k8aBwf
	KKOEPxthSSd/Q4pu7ccGGUShC8YfnQQfvtAnSiJXcwDUM9Cvwh4IFFBblvpxv8v7
	F2AA8RmEgRLcvjlXrTRVZDfTYAxy04wFy9Y+GFp8o9E61VAy/aISYRofGUt2IZYI
	afJ0xLUuD2agrj1EVygjNJKvtiv70RfeiKDU9eOSORo8a9iovraQ3gpu0HKkQ95F
	eqW+j9DEOu1UOQVq3w==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4guxmh970u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:51:39 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8a0dd8f22a7so14906637b3.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 16:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790121098; cv=none;
        d=google.com; s=arc-20260327;
        b=YayaBWYSIloHU//hbIWDNMwAf+bbGJEf2G5qnnhhepdmje6ES/aAu6ivJSPJ8M2qeM
         68eIliRiggZolLl6OJu/Tcw98eg6ijOFnaNf4m0AwY6k0ibAc9OKEq2NOKiQUIlG9lWx
         92YfDmtTItgkchsyheY+rP5WdMkQVB1bEcPt4kE6Moru5laRYWkc5adRcOJCEIvNA7XD
         lfY6Q9eVamyQvtIlx3q63V+rQx1GnB+xrcmXfLFDX0LDghlsnCqojsTGEaytLewLUHGw
         PtOxXF6b7b9VWOEJWdAKvANBCE48l4wmh5q7KVAq5qzF/gw0Bk8kD8ss+uW6+6oG5siU
         kIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6pbAmNYRfe9FixeR56ebwQxRT1+2/Is5WxKXJC7FLrI=;
        fh=KsM7jQtbuG2OJnXgxESyhLjhdpygfAqz1QyD7nTIAdA=;
        b=J4kZnd/vNsZLazM8niqW22IGqHAv0qV50ALMFQggna4/93+Q2BA3FuHoKmyq1qm/7X
         KAy06ht4TufE0qmN4VUG+GK78b4o5Z73t/uXVo0T+6aq6nP7VwPSu0Fnnj2zjgOKkWmn
         dCgGmJlRFTVoxXoIOIZvl0eblo6bSTEo8/Sjj8o2LXw2MTLti7L0+UoYiZ6myg1UU0+n
         Kr4gI+45j7GvHakqEaKoYyCRsc/jPjSPMTxaYUDS3RyoyQ7bGWx1Rpi8iTLeHHcViuvR
         kA9qyQOyuRGKL68D6l/iDxIL1cmb1wk+HdxwIYyhBGSTZiUJMAQzc/KCbqW+6+mXLv67
         JGZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1790121098; x=1790725898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6pbAmNYRfe9FixeR56ebwQxRT1+2/Is5WxKXJC7FLrI=;
        b=S3/62wngutMhFu6v/9QKorOZAok6EWCGI+VfQdZznmk3C2FVqjPcsH4vhHR5UneY0X
         SAKxvVCVEpff13zX3KOecaIjWbpTalkpdJ/T2WMnX2EUn8Xct3ErYgM1g1MDP2pGLMsj
         CW7TVPmSTHcE4PVFSNyUjEUPA2fI8iGN1iiGpNSZx4Nv/JGyK1rw9iLcsKRkxWw7KsjM
         95eztqnzH7ku9oBvH4xqF/sXiMOMwsUHulq4NO1SMidmfhEKnDKepz3LrKHpcuPtLnEH
         g44MWBHvBjS97NyHcTUCysB1zeeatoAsKC6qYPxs47D+wO7atsj2KVjbiQSDDm+2jrTi
         f6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790121098; x=1790725898;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6pbAmNYRfe9FixeR56ebwQxRT1+2/Is5WxKXJC7FLrI=;
        b=s0kb3QE4JyCoi4j2CHeqfbU4o53GZ3587MeLEWaK3h4YlJnw4in756sYH9dgxW2Lbv
         QAYmO6GCiOQ2mITdoVdYaEFJis4d5/Ru76d24BztjH8F0PG7xdlbmzGO90iFdeRq8sOo
         /M7G0Fz3GamJLXWBmOl2i/B8VQ7TyOS3MoT0+V/GBL9Moj9igIw3rPqJowluGTG6eRyO
         XYV/4hzThqMBZd2q4cDCaKXCRrWiV/AouMGyNQd5inGJ2QAU56jYvLT2vJtzv/eCPJp0
         y39bShaMxICp8hJRUj0PBeRr62KfGetD3JKDGF4QgXjO3WoTO+3uot5ZncfmnpcZafS2
         JGPA==
X-Gm-Message-State: AFuF++mnDEy9uIyBMgxUrS2IIJ3Vx1BAwyGvISmlsAoGjGxK/6w29q1l
	SJF3Q8ZEvo2zeg0A+yYOiU0OvyeQFwEMQeSR2Zy2esMX5iW4pB1vG3dAFNq8ZmqXm5y+FHpew4Z
	+s3CrKbTSKNn55OM58DN0YBg9r00jRRmE0kaGB2POa1ZupwjynJlAMHVUTv2xTUnSgklrCt1fcX
	P/lvz0gABvWb3WSsANJ5BzbBbJAf/UUfTjTl8c2T8=
X-Gm-Gg: AYBFou0yggfGMzZypnoh6CyHc1ycWA/Cwuj7AcsKStzbO+5hxIX3xSeme4JWlfQazUn
	yjgAvVrCyA5uSU250LL/spbJdMILCjAI/fbhXxO8mm+An+BH58w5RoyKpc9r6Vcd2YA9O2JmjZw
	ndp/kCcOuKES2BMUQZzBvvZ99O3csBYrMMAcBoIZR0RjykwrvF3hzhvqE2
X-Received: by 2002:a05:690c:438b:b0:858:d554:79c9 with SMTP id 00721157ae682-8a45920f486mr5609737b3.30.1790121098164;
        Tue, 22 Sep 2026 16:51:38 -0700 (PDT)
X-Received: by 2002:a05:690c:438b:b0:858:d554:79c9 with SMTP id
 00721157ae682-8a45920f486mr5609667b3.30.1790121097584; Tue, 22 Sep 2026
 16:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com>
 <20260921223937.3203093-3-andrey.grodzovsky@crowdstrike.com> <20260921230334.13F781F000FF@smtp.kernel.org>
In-Reply-To: <20260921230334.13F781F000FF@smtp.kernel.org>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Tue, 22 Sep 2026 19:51:26 -0400
X-Gm-Features: AclHuK8PJFV42Ev_hPvCPfr9TgzDioVQB_82j42M_vDNe4EK4ZjHdW2SNPZ8Lr0
Message-ID: <CAOu3gNhpjHengpcN5CC6oQ9M70Zd2_JVw=Pani0x9CXix3sbJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/7] libbpf: BPF programs manual loading and attaching
To: bpf <bpf@vger.kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDMwNyBTYWx0ZWRfXyrwL/v3zjOI8
 kkhDo5jeIrJ96IUiml3C5V4u8LpL7w8aTfyCLyrU3dqKuEa6FtSgBDXCjLAsSy/ZvkUbLr1OvhZ
 MsJLWFU3Xxe8BShgZmKUrfdWY1PMTutoPC6pkRm2WnDQN7qV8tLR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDMwNyBTYWx0ZWRfX0iSQ9cDP4JjT
 /t797hMbDg0EKa0Kttj3a8yAXE5R1j/miHQGMgFlIDvJ1OpBf2S9CLAUgtUKd864gRuapzbLeT4
 olRj1NkqydlPsaigEB2yyijVXzQqXCSzEIdS0uWLIuHnFgG0KXaniPlwJYYWhYv13W5rvqzCk5L
 dxNSxarwiyaW+i0DOXy28aFPw0EWiDzlI75hgFrIhhSAC+KyDZJurHiA/aBwc3kN2fDvKaZXHqk
 4A3k5qPWl+8AnjveiRAX545x8ms+1ibaVZR8rKC/XkboWjqNgWa1kHSD3mbC6WvzGx5Cb3R8lF1
 PrrIUUOnAU+FpfWWhTWJEzwaPg9gk92aCbOPF4OLX/dBBIOekYkV61o4X7Upx5ekstOsmnpR+Wa
 6o2YZHdQ4b9kSOM0TpTZnOaN7wKWk9gnTnJouRh5cleeHL1YlU5L3vBO01aFsX72Jz2SBMeHqG9
 otsgNzQ6KVC88In5P1A==
X-Proofpoint-ORIG-GUID: _8a5rKQrX-lFNyQiXMw9as9ipVb6h1VP
X-Proofpoint-GUID: _8a5rKQrX-lFNyQiXMw9as9ipVb6h1VP
X-Authority-Analysis: v=2.4 cv=Z9B5j3RA c=1 sm=1 tr=0 ts=6ab3148b cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=c92rfblmAAAA:8
 a=pl6vuDidAAAA:8 a=1eCNw7Ri81ZHxrmh_9AA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11913
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220307

On Mon, Sep 21, 2026 at 7:03=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] bpf: bpf_program__load() allows loading from failed object, caus=
ing Use-After-Close
> --
>
> commit 62d928e64d7108c312cff920bafa876c284cb8bd
> Author: Slava Imameev <slava.imameev@crowdstrike.com>
>
> libbpf: BPF programs manual loading and attaching
>
> BPF programs designated as manually loaded can be loaded and attached
> independently after the initial bpf_object loading and attaching. This
> patch adds bpf_program__load() to support loading these manual-strategy
> programs independently.
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index a3085847cb97f..939f0d6378e38 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
>
> [ ... ]
>
> > @@ -9233,7 +9286,7 @@ static int bpf_object_load(struct bpf_object *obj=
, int extra_log_level, const ch
> >                       err =3D bpf_gen__finish(obj->gen_loader, obj->nr_=
programs, obj->nr_maps);
> >       }
> >
> > -     bpf_object_post_load_cleanup(obj);
> > +     bpf_object_post_load_cleanup(obj, false);
> >       obj->state =3D OBJ_LOADED; /* doesn't matter if successfully or n=
ot */
> >
> >       if (err) {
>
> [Severity: High]
> Could this state assignment allow dangerous program loads if
> bpf_object_load() fails?
>
> When bpf_object_load() fails after bpf_object_prepare(), it falls through=
 to
> error handling which calls bpf_object_unload() and closes the map FDs.
> However, the state is still unconditionally set to OBJ_LOADED.
>
> [ ... ]
>
> > @@ -15386,3 +15501,34 @@ enum bpf_prog_load_strategy bpf_program__load_=
strategy(const struct bpf_program
> >  {
> >       return prog->load_strategy;
> >  }
> > +
> > +/*
> > + * This function must be called after bpf_object__prepare (or
> > + * bpf_object__load, which calls bpf_object__prepare internally).
> > + * Manually-loaded program data is initialized on object prepare.
> > + * Post-prepare initialization is not supported.
> > + */
> > +int
> > +bpf_program__load(struct bpf_program *prog)
> > +{
> > +     int err;
> > +     struct bpf_object *obj =3D prog->obj;
> > +
> > +     if (obj->state < OBJ_PREPARED)
> > +             return libbpf_err(-EINVAL);
>
> [Severity: High]
> Is this state check sufficient to prevent a use-after-close if the underl=
ying
> object failed to load?
>
> If an application ignores a prior bpf_object_load() error and calls
> bpf_program__load(), this check will pass because the failed object is no=
w in
> the OBJ_LOADED state (which is >=3D OBJ_PREPARED).
>
> Because the failure triggered bpf_object_unload(), the map FDs were close=
d,
> allowing bpf_program__load() to proceed with stale map FDs.
>
> If a map FD is reused, the kernel might attach the BPF program to an
> unrelated map, causing data corruption or security boundary violations.
> For programs with BTF, the kernel rejects the load with -EFAULT because
> func_info is freed but func_info_cnt remains > 0. For programs without BT=
F,
> the kernel proceeds using the stale FDs.

Whle the issue in indeed real, I don't think we should conflate
solving it with this patchset because this is a pre-exsiting issue
IMHO and was introduced in [1] as defensive mechanism.
Same issue as described above I think can be triggerd if we call
bpf_program__clone after failed bpf_program__load.
I think the proper fix to this would be  adding a distinct OBJ_FAILED
> OBJ_LOADED state  and rejecting it in both bpf_program__clone() and
bpf_program__load() explcitily.

Andrey

[1] - https://lore.kernel.org/bpf/CAEf4BzZ1+wojkBW+LLdKa1bUE4Jt+FhfUq_4DwzW=
8YOq64S1tg@mail.gmail.com/
>
> --
> Sashiko AI review =C2=B7 https://urldefense.com/v3/__https://sashiko.dev/=
*/patchset/20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com?part=
=3D2__;Iw!!BmdzS3_lV9HdKG8!zpj66NXxmYFWO7pFsg0dgZQ0cWH_DAHXsaDnmRl26-hwiy42=
gvI00kcYonZ-0w_UhTKS66p4ChBVq6LURKHOj1bkZMHyS6ADaQ$
>
