Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBF92ED870
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831299; cv=pass; b=Ail0v8WsGyCJyHICWmjYXn7heXMXMQMd2lgQAcKq2pclhSuqCdfqK89KBcCebT+NJNNXm1mQr+WxgL/9ny0pzEog5n7YOYrE/LFUcM7SVxyvKGScT5s4+BHEnbAc1GyAXFTekM8gJzjVck+9hh8fGl/2ag2HFBzP0UtRcplIssU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831299; c=relaxed/simple;
	bh=tz7xlU8D9UHerw3PrGPoteaAG8FBDzDbfriHdNwcHI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIghVq2mHsfddXZnb6Kmk7T1yyaWQ63pKJMiCtlyhsu2wYIzn+MfUfsZBi+wu0cH7LVeTb+ZIw8AJHCT6Kj/AG5BJ/n3UF0/ldlx9+IqyrzZGJmYEeCuWtgmjo3kW/gDs4iyiXF30b9S5/D27oiAigBgHQw7z7xr1YAQpYgUCp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=uAYXgUth; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=nnX3jekE; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="uAYXgUth";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="nnX3jekE"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626IxeZ63056211
	for <bpf@vger.kernel.org>; Fri, 6 Mar 2026 21:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=U7hLZePx34037ZHb6KOjiAEDsLods061WLt0odaeuiY=; b=uAYX
	gUthj3OYtSAVJ8i35+lDL9zrqFgcrE5QYHwq7URuTrNFfIHJoI3prmj2I6za7x2k
	O3ponee9vPh/iFhzTDxvZ9AtgyT37pAZ3354PgLuYAAV9Kb2Fuu/WXLXf3CEwRAg
	Cpa8B7qr9M9lPL4z4s2kSPnK6BSA689yBV3UzmWfogCf2W18nu9oEiv03SuP91TH
	WvjKxlCS7a3OJCtut1AfQP8n8Y/+ocJBY8oL/qUMPE0mPk4ro+8zvvEPkWORk/2H
	h8TTSPzO7LCElgUrtwZakChu3UVCf2sVlSK9AcRdMCCeHKD9san4OJCvIdbFw68i
	v+3aWHWxg9iA6BQodA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cr3hdgsy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 21:08:16 +0000 (GMT)
Received: from 04WPEXCH005.crowdstrike.sys (10.100.11.69) by
 04WPEXCH013.crowdstrike.sys (10.100.11.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Mar 2026 21:08:15 +0000
Received: from mail-yx1-f70.google.com (10.100.11.78) by
 04WPEXCH005.crowdstrike.sys (10.100.11.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Mar 2026 21:08:15 +0000
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-649deeeb00fso13334917d50.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 13:08:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772831295; cv=none;
        d=google.com; s=arc-20240605;
        b=liX7mKpnEzEbtXeEZZFHys8hBEQw0qvS8x+YKuQnndobe9vv4DvvcGF/zK3S3FBIZ0
         xudadGFk+/1f9uwKTRiaKzVC1ppSFjPmW2khp2AOBkxtLNcCbucf/IdyBKEitPhzqfAN
         3/a83g0iJmHj91WU2vNKSJn2bTbh/ATxjfVfZRh3zQTNyDEFLCglOn9YHvv8U4+4PdBi
         bnhU+CQH3aYQBhpdsaRXkQ/eP820FMqhEkeF2JOzMcLerszwpgmlu6eP9HrBO/QHJbD2
         5lI9pBtbSNVXY9nqJRdSrfcQExXfI7TUOE0bzZxyOo26hHNaLPAJRs09R9KYJHeFjI+n
         1VeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U7hLZePx34037ZHb6KOjiAEDsLods061WLt0odaeuiY=;
        fh=Eu4umwily2rRSS9LrU3YEXKRRKdb5TGhuAGlbptaSF4=;
        b=MquQVABxDAP1NVVCG2kUSbIzk/OVqf2h4S/wi5DdqIfqA1UhZnStGNsUyRsAoP+b3p
         w8xgZLvczdw/MHv/O3OvgkS2UAPszzS1rgre7sclWOW0ryyme5QRGykNeJ1NV+0cNchi
         DdH8EsOAb9jE15kKCOv/b4Uixsx1gTL40RiwI1U73ev7Nkyyk7vtw1LecXXKkb50TaOT
         tEl/xOm/5AgzxIiNf/BYjIsY24VzO6tb1Dx9unPQ/DgcLqZxB5Hji4dwzjBANUAmuf1T
         d+ac9088V0FRsqSfeaGaWfajogLBhL9EWnm7DAAIlmNduN54gcteqF8RXfY5DxAox1oY
         dIIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772831295; x=1773436095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7hLZePx34037ZHb6KOjiAEDsLods061WLt0odaeuiY=;
        b=nnX3jekEPBvhj0K0pL6fwW+bgzHPxUcwJ6XIk8E/Pw0ugCqZYzsm5H/OJk6PU6XshB
         s3qJqj64CLXCw04HQCU2D+2kDx9qpm1oOpDlDxyP8E7IUnUzIEdtMKU26fPAH0NkwnJF
         7HBM3c83bSb3ldTigSLdTnRB5OwuBfP/ih/7wCeOK7UKG+XFkBo1Cs4hfmjlOjyvQWSl
         t9xOy12YV16x8k3nn1qNKa9I5YTKo+nPx8QLUzFF6X2RB6FiR8cNnZ4Zw9lx53LoHRm4
         rDyEIMC/rNJqi/ADrAvmfCAclEvcdOiNqnp+Q8Djab0Nq163iS/6jXC36s0c3j46tQfx
         LHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831295; x=1773436095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U7hLZePx34037ZHb6KOjiAEDsLods061WLt0odaeuiY=;
        b=eBrJtzFtd9I6gP+RPyP0pGt2o8TEkfdhwrAv9gTcR/l6acIb/EuDJM0YjuPUrQdTLt
         T8j4BqYEttcX8f78qTLIAS9xxOpOSKOgXTAyfxC61q7BS5ILJCuGXaiGeLJn+SqzCExO
         VeCopZodNmRw5YlmJDCFOdB/gmvTmOeHo5lX3XjQ1oK1w80JwT9uOKzbNPK871CjBZdT
         YBynQssvv3Z/VCHe7UIXm7D635h6Gyzwa2Eh7wuZrnEb8RAfZPjpH0cNc1YJeMK0JBDg
         UnOOU8xIcjPrWLFPMlzjap/dxoip8EmuQ+bNcvPc9YCuBY4waBGauMYWEkeRsrvKkvKt
         W9Yw==
X-Gm-Message-State: AOJu0YwLLFi44plFPQh6Xf03JnxxRiNBxi3emM4q9YmIJfmdvvOfQ+Bz
	lUEJ3aDsMGfjeRq8bKfqXfc7mFmXZKZfMVgaFHny3qMhEbeloo7QnVm/I59JMZ7e5UTj74NaWXK
	5xvgBF9rVSMeFMqgDHebnEtZePxk/SNKpGkePyAHL/Pzb1S8fBuTCUJ0cnjYtioKEvw2C6Jaern
	rzvXmDWhyMyMnqgq/AVVptyVXtciSKcurc/T7dqdKwoaw=
X-Gm-Gg: ATEYQzw+8C7KiFBG7txe6IfzLBQVFEpc05hRD9np0Pb242BphjP9IOraf1NTE7D10Zj
	Vj1CPj2ATyFjq7mnNTwDf8vZiWfQ8QO4Otgsd69u5kvBFk1d4RwUe70MbQBozmtL1o2Xs5IExmc
	XstaUV5iIZDleXRS/jG+J+sev7Bh7XKjNE/k3xnFRjc/XlPCgezz4H4sUryJsWzLBVYQqxTIzcI
	plS
X-Received: by 2002:a05:690e:120e:b0:64a:db50:faa6 with SMTP id 956f58d0204a3-64d14390485mr3312503d50.87.1772831294917;
        Fri, 06 Mar 2026 13:08:14 -0800 (PST)
X-Received: by 2002:a05:690e:120e:b0:64a:db50:faa6 with SMTP id
 956f58d0204a3-64d14390485mr3312470d50.87.1772831294354; Fri, 06 Mar 2026
 13:08:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302210532.381083-1-andrey.grodzovsky@crowdstrike.com>
 <20260302210532.381083-2-andrey.grodzovsky@crowdstrike.com> <CAEf4BzYiwAczqqdb40YKq8yRd7JWgOV_cgyehpCRzoEZ6qeP7g@mail.gmail.com>
In-Reply-To: <CAEf4BzYiwAczqqdb40YKq8yRd7JWgOV_cgyehpCRzoEZ6qeP7g@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Fri, 6 Mar 2026 16:08:03 -0500
X-Gm-Features: AaiRm50VZUwd9KHddRLsb4GS4kWbf9gi4zyqVka3UQPTjKPD3OrzHc-8pq-WQAY
Message-ID: <CAOu3gNgUp0sqgTUfCM_UFsEi6jwsTDjMrAZL_Pv=FZ4Fx_Khug@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v4 1/2] libbpf: Handle duplicate
 kprobe symbols in attach_kprobe_opts
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, jolsa@kernel.org, emil@etsalapatis.com,
        linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=N+Mk1m9B c=1 sm=1 tr=0 ts=69ab4240 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22
 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8 a=yDVHsGV7-Ncyle89FEcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE5OSBTYWx0ZWRfXyAAAVbLZLspQ
 W2jLnBy/x7H+AKyy7Yq7OEzJU9LpeHEcrPku4Ftta4ZbdiuFGGmmS1cvcsWnM+37OtPjXiTy6Hr
 yHFq6OogpId5NNpxrXzvnVWuAqUcutzNb8G0qqqBOB0e6L4VPW5xMppKBrynLa/L9t0AjxRIOi8
 ZKn80pLzJqmz2ljsL8t8Xc/UD55GEmI7xMYfRW7lUW6lyCNHQS9d+mhBlhM0NPecek9AnfXxkWw
 6z/gEnU6DSG+dTwbRqpq9sidQEESI6MbuTmjqkNQ1+jjfnJXGwKlCtH6YL/d2T8plu6cdIiUP/A
 bRw3/3wNxabSwIiHsAJR/3Q13RoWxy98HkdED74vIHqzLUj7s25n/SwRHIQ4il+bkNNpdGN4ZyR
 3/wSBLhPfPDoa6Gj0u+NHbiEJA0PQU2sJFErZW6hQ3IhBxuXfJl8lCUPeMgUIXKckI8UYs8T1ma
 YA8rbJln+5Uu5aGvsag==
X-Proofpoint-ORIG-GUID: eR4rWD0Bn09-W_80givF5X_71jCIUyHI
X-Proofpoint-GUID: eR4rWD0Bn09-W_80givF5X_71jCIUyHI
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11721
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060199

On Thu, Mar 5, 2026 at 5:47=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 2, 2026 at 1:05=E2=80=AFPM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > When a kernel module exports a symbol with the same name as an existing
> > vmlinux symbol, kprobe attachment via bpf_program__attach_kprobe_opts()
> > fails with EADDRNOTAVAIL (perf_event_open path) or EINVAL (legacy
> > tracefs path).
>
> If the same symbol name resolves to multiple addresses, that's an
> ambiguity that libbpf has no business resolving. It should be on user
> to resolve and use attachment by address, which libbpf supports
> through bpf_kprobe_opts or multi-kprobe opts.
>
> pw-bot: cr
>

I understand the concern about libbpf making policy decisions on
ambiguous symbol resolution. But I think the skeleton-based auto-attach
workflow makes this impractical for the user to handle.

The recommended upstream pattern is:

  skel =3D my_prog__open_and_load();
  my_prog__attach(skel);

So it's something along the lines of

our_skeleteon_bpf__attach(skel)
    =E2=86=92 bpf_object__attach_skeleton(skel->skeleton)
      =E2=86=92 prog->sec_def->prog_attach_fn()  [=3D attach_kprobe()]
        =E2=86=92 bpf_program__attach_kprobe_opts(prog, func, &opts)
          =E2=86=92 perf_event_open_probe(name=3Dfunc, offset=3D0)
            =E2=86=92 perf_event_open() =E2=86=92 EADDRNOTAVAIL

So bpf_object__attach_skeleton(), which iterates over all
programs and calls attach_kprobe() internally. That function extracts
the symbol name from the ELF section name (SEC("kprobe/func_name"))
and passes it to bpf_program__attach_kprobe_opts(). The user has no
control point in this chain - no callback, no option struct, no way
to intercept a failed attach and supply an address instead.

If a kernel module happens to export a symbol with the same name as
a vmlinux function the user is probing, the attach fails with
EADDRNOTAVAIL and the user has no recovery path within the skeleton
API. The only options would be:

1. Abandon skeleton auto-attach entirely for any kprobe program
 that might hit a duplicate, and manually call
 bpf_program__attach_kprobe_opts() with a resolved address for
 each one. This defeats the purpose of skeletons.

2. Proactively scan /proc/kallsyms before every attach to detect
 potential duplicates, set prog->autoattach =3D false for affected
 programs, and manually attach those. But autoattach is not
 exposed in the public skeleton API either.

Since a kernel module can be loaded at any time, any kprobe could
potentially become ambiguous. Pushing resolution to the user
effectively means the skeleton auto-attach pattern cannot be
reliably used for kprobes.

The fallback in this patch is intentionally conservative - it only
triggers on the specific error codes that indicate duplicate symbols
(EADDRNOTAVAIL for perf_event_open, EINVAL for legacy), and it
resolves strictly to the vmlinux text symbol, skipping module symbols.
This seems like the only reasonable behavior for auto-attach, where
the user has expressed intent to probe a specific function by name.

Would it make sense to limit this fallback to the auto-attach path
(attach_kprobe) rather than the explicit attach_kprobe_opts API?
That way users who call attach_kprobe_opts directly still get the
raw error and can handle it themselves, while the skeleton workflow
has a reasonable default.

Happy to hear alternative suggestions on how to make this work
within the existing API.

Andrey


>
> >
> > Implement a fallback mechanism that, on such failures, resolves the
> > vmlinux address through /proc/kallsyms - filtering out module symbols -
> > and retries probe attachment using the absolute address, bypassing
> > kernel symbol name validation.
> >
> > Changes:
> > - Restructure libbpf_kallsyms_parse() to accept a bool skip_if_module
> >   parameter that filters module symbols before invoking the callback.
> > - Add find_kaddr_cb() callback and find_kaddr_ctx struct to resolve
> >   vmlinux text symbol addresses from /proc/kallsyms.
> > - Detect duplicate symbol errors (-EADDRNOTAVAIL for perf_event_open,
> >   -EINVAL for legacy tracefs) and retry with resolved KADDR.
> > - Fix NULL pointer in gen_probe_legacy_event_name() when using absolute
> >   address by passing func_name instead of optional_func_name.
> > - Fix NULL pointer in pr_warn() calls within
> >   perf_event_kprobe_open_legacy() by using ternary fallback.
> > - Fix memory leak of legacy_probe buffer on retry path.
> >
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 155 ++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 137 insertions(+), 18 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 0be7017800fe..e725e3c98ee2 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -8460,9 +8460,11 @@ static int bpf_object__sanitize_maps(struct bpf_=
object *obj)
> >  typedef int (*kallsyms_cb_t)(unsigned long long sym_addr, char sym_typ=
e,
> >                              const char *sym_name, void *ctx);
> >
> > -static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
> > +static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx,
> > +                               bool skip_if_module)
> >  {
> >         char sym_type, sym_name[500];
> > +       char module_name[128];
> >         unsigned long long sym_addr;
> >         int ret, err =3D 0;
> >         FILE *f;
> > @@ -8475,21 +8477,39 @@ static int libbpf_kallsyms_parse(kallsyms_cb_t =
cb, void *ctx)
> >         }
> >
> >         while (true) {
> > -               ret =3D fscanf(f, "%llx %c %499s%*[^\n]\n",
> > -                            &sym_addr, &sym_type, sym_name);
> > -               if (ret =3D=3D EOF && feof(f))
> > +               int n =3D 0;
> > +
> > +               /*
> > +                * Format tries to match both vmlinux and module kallsy=
ms
> > +                * entries in one call. Module entries have the form:
> > +                *   addr type name [module]
> > +                * %n fires only if the closing ']' literal is matched.
> > +                */
> > +               ret =3D fscanf(f, "%llx %c %499s [%127[^] \t\n\r\v\f]] =
%n",
> > +                            &sym_addr, &sym_type, sym_name, module_nam=
e, &n);
> > +
> > +               /* EOF or malformed line - handle after the loop */
> > +               if (ret !=3D 3 && ret !=3D 4)
> >                         break;
> > -               if (ret !=3D 3) {
> > -                       pr_warn("failed to read kallsyms entry: %d\n", =
ret);
> > -                       err =3D -EINVAL;
> > +
> > +               /* ret =3D=3D 4 && n =3D=3D 0: scanset matched but ']' =
didn't */
> > +               if (ret =3D=3D 4 && n =3D=3D 0)
> >                         break;
> > -               }
> > +
> > +               if (ret =3D=3D 4 && skip_if_module)
> > +                       continue;
> >
> >                 err =3D cb(sym_addr, sym_type, sym_name, ctx);
> >                 if (err)
> >                         break;
> >         }
> >
> > +       /* !err: don't overwrite callback errors with -EINVAL */
> > +       if (!feof(f) && !err) {
> > +               pr_warn("failed to read kallsyms entry: ret=3D%d\n", re=
t);
> > +               err =3D -EINVAL;
> > +       }
> > +
> >         fclose(f);
> >         return err;
> >  }
> > @@ -8529,7 +8549,7 @@ static int kallsyms_cb(unsigned long long sym_add=
r, char sym_type,
> >
> >  static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
> >  {
> > -       return libbpf_kallsyms_parse(kallsyms_cb, obj);
> > +       return libbpf_kallsyms_parse(kallsyms_cb, obj, false);
> >  }
> >
> >  static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_n=
ame,
> > @@ -11527,10 +11547,20 @@ static void gen_probe_legacy_event_name(char =
*buf, size_t buf_sz,
> >  static int add_kprobe_event_legacy(const char *probe_name, bool retpro=
be,
> >                                    const char *kfunc_name, size_t offse=
t)
> >  {
> > -       return append_to_file(tracefs_kprobe_events(), "%c:%s/%s %s+0x%=
zx",
> > -                             retprobe ? 'r' : 'p',
> > -                             retprobe ? "kretprobes" : "kprobes",
> > -                             probe_name, kfunc_name, offset);
> > +       /* When kfunc_name is NULL, use absolute address format (0xADDR=
),
> > +        * otherwise use symbol+offset format (SYMBOL+0xOFF)
> > +        */
> > +       if (kfunc_name) {
> > +               return append_to_file(tracefs_kprobe_events(), "%c:%s/%=
s %s+0x%zx",
> > +                                     retprobe ? 'r' : 'p',
> > +                                     retprobe ? "kretprobes" : "kprobe=
s",
> > +                                     probe_name, kfunc_name, offset);
> > +       } else {
> > +               return append_to_file(tracefs_kprobe_events(), "%c:%s/%=
s 0x%zx",
> > +                                     retprobe ? 'r' : 'p',
> > +                                     retprobe ? "kretprobes" : "kprobe=
s",
> > +                                     probe_name, offset);
> > +       }
> >  }
> >
> >  static int remove_kprobe_event_legacy(const char *probe_name, bool ret=
probe)
> > @@ -11559,7 +11589,7 @@ static int perf_event_kprobe_open_legacy(const =
char *probe_name, bool retprobe,
> >         err =3D add_kprobe_event_legacy(probe_name, retprobe, kfunc_nam=
e, offset);
> >         if (err < 0) {
> >                 pr_warn("failed to add legacy kprobe event for '%s+0x%z=
x': %s\n",
> > -                       kfunc_name, offset,
> > +                       kfunc_name ? kfunc_name : "(abs_addr)", offset,
> >                         errstr(err));
> >                 return err;
> >         }
> > @@ -11567,7 +11597,7 @@ static int perf_event_kprobe_open_legacy(const =
char *probe_name, bool retprobe,
> >         if (type < 0) {
> >                 err =3D type;
> >                 pr_warn("failed to determine legacy kprobe event id for=
 '%s+0x%zx': %s\n",
> > -                       kfunc_name, offset,
> > +                       kfunc_name ? kfunc_name : "(abs_addr)", offset,
> >                         errstr(err));
> >                 goto err_clean_legacy;
> >         }
> > @@ -11651,6 +11681,44 @@ int probe_kern_syscall_wrapper(int token_fd)
> >         }
> >  }
> >
> > +/* Context structure for finding vmlinux kernel symbol address */
> > +struct find_kaddr_ctx {
> > +       const char *func_name;
> > +       unsigned long long kaddr;
> > +};
> > +
> > +/* Callback to find vmlinux kernel text symbol address */
> > +static int find_kaddr_cb(unsigned long long sym_addr, char sym_type,
> > +                        const char *sym_name, void *ctx)
> > +{
> > +       struct find_kaddr_ctx *data =3D ctx;
> > +
> > +       /* Only match text section symbols ('T' or 't') */
> > +       if (toupper(sym_type) !=3D 'T')
> > +               return 0;
> > +
> > +       /* Check if this is the symbol we're looking for */
> > +       if (strcmp(sym_name, data->func_name) =3D=3D 0) {
> > +
> > +               /*
> > +                * If we already have an address, we've encountered a
> > +                * duplicate symbol name. Reject such symbols to avoid
> > +                * ambiguous resolution.
> > +                */
> > +               if (data->kaddr && data->kaddr !=3D sym_addr) {
> > +                       pr_warn("kernel symbol '%s': resolution is ambi=
guous: 0x%llx or 0x%llx\n",
> > +                       sym_name, data->kaddr, sym_addr);
> > +                       return -EINVAL;
> > +               }
> > +
> > +               data->kaddr =3D sym_addr;
> > +               pr_debug("found kernel symbol %s at address 0x%llx\n",
> > +                        sym_name, data->kaddr);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  struct bpf_link *
> >  bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
> >                                 const char *func_name,
> > @@ -11663,6 +11731,8 @@ bpf_program__attach_kprobe_opts(const struct bp=
f_program *prog,
> >         size_t offset;
> >         bool retprobe, legacy;
> >         int pfd, err;
> > +       const char *optional_func_name =3D func_name;
> > +       struct find_kaddr_ctx kaddr_ctx =3D { .kaddr =3D 0 };
> >
> >         if (!OPTS_VALID(opts, bpf_kprobe_opts))
> >                 return libbpf_err_ptr(-EINVAL);
> > @@ -11693,9 +11763,10 @@ bpf_program__attach_kprobe_opts(const struct b=
pf_program *prog,
> >                 return libbpf_err_ptr(-EINVAL);
> >         }
> >
> > +retry_create:
> >         if (!legacy) {
> >                 pfd =3D perf_event_open_probe(false /* uprobe */, retpr=
obe,
> > -                                           func_name, offset,
> > +                                           optional_func_name, offset,
> >                                             -1 /* pid */, 0 /* ref_ctr_=
off */);
> >         } else {
> >                 char probe_name[MAX_EVENT_NAME_LEN];
> > @@ -11707,7 +11778,7 @@ bpf_program__attach_kprobe_opts(const struct bp=
f_program *prog,
> >                 if (!legacy_probe)
> >                         return libbpf_err_ptr(-ENOMEM);
> >
> > -               pfd =3D perf_event_kprobe_open_legacy(legacy_probe, ret=
probe, func_name,
> > +               pfd =3D perf_event_kprobe_open_legacy(legacy_probe, ret=
probe, optional_func_name,
> >                                                     offset, -1 /* pid *=
/);
> >         }
> >         if (pfd < 0) {
> > @@ -11716,6 +11787,54 @@ bpf_program__attach_kprobe_opts(const struct b=
pf_program *prog,
> >                         prog->name, retprobe ? "kretprobe" : "kprobe",
> >                         func_name, offset,
> >                         errstr(err));
> > +
> > +               /*
> > +                * If attachment fails with EADDRNOTAVAIL (or EINVAL in
> > +                * legacy mode) and we used non-NULL func_name, try to
> > +                * find function address in /proc/kallsyms and retry
> > +                * using KADDR instead of ambiguous symbol. Legacy
> > +                * tracefs API converts EADDRNOTAVAIL to EINVAL, so
> > +                * we need to check for both.
> > +                */
> > +               if ((err =3D=3D -EADDRNOTAVAIL || (legacy && err =3D=3D=
 -EINVAL)) && optional_func_name) {
> > +                       pr_debug("kallsyms lookup for %s\n",
> > +                                func_name);
> > +
> > +                       kaddr_ctx.func_name =3D func_name;
> > +                       kaddr_ctx.kaddr =3D 0;
> > +
> > +                       /*
> > +                        * Drop the function symbol and add the resolve=
d
> > +                        * KADDR to the offset.
> > +                        * This avoids kallsyms validation for duplicat=
e
> > +                        * symbols in the kernel. See attr.config2 in
> > +                        * perf_event_open_probe and kernel code in
> > +                        * perf_kprobe_init/create_local_trace_kprobe.
> > +                        */
> > +                       optional_func_name =3D NULL;
> > +
> > +                       err =3D libbpf_kallsyms_parse(find_kaddr_cb, &k=
addr_ctx, true);
> > +                       if (err) {
> > +                               pr_warn("failed to get addr for %s\n",
> > +                                       func_name);
> > +                               goto err_out;
> > +                       }
> > +
> > +                       if (kaddr_ctx.kaddr) {
> > +                               pr_debug("retrying %s using kaddr 0x%ll=
x\n",
> > +                                        func_name, kaddr_ctx.kaddr);
> > +
> > +                               offset +=3D kaddr_ctx.kaddr;
> > +                               free(legacy_probe);
> > +                               legacy_probe =3D NULL;
> > +                               goto retry_create;
> > +                       }
> > +
> > +                       pr_warn("symbol '%s' not found in vmlinux\n",
> > +                               func_name);
> > +                       err =3D -ENOENT;
> > +               }
> > +
> >                 goto err_out;
> >         }
> >         link =3D bpf_program__attach_perf_event_opts(prog, pfd, &pe_opt=
s);
> > @@ -11931,7 +12050,7 @@ static int libbpf_available_kallsyms_parse(stru=
ct kprobe_multi_resolve *res)
> >         data.syms =3D syms;
> >         data.res =3D res;
> >         data.cnt =3D cnt;
> > -       libbpf_kallsyms_parse(avail_kallsyms_cb, &data);
> > +       libbpf_kallsyms_parse(avail_kallsyms_cb, &data, false);
> >
> >         if (res->cnt =3D=3D 0)
> >                 err =3D -ENOENT;
> > --
> > 2.34.1
> >
