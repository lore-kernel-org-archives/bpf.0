Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63627325496
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771538280; cv=pass; b=VAPZ0ipJPaK1Bq+roZ1p3n9UySAVkpvSDH9bR8jj9XeSAAzMbM13wshS1upiTqIDfG+PGeiVW9LdADqStWWHcMQPKmGhnmvGLxIITcVx8AkksR+ZXwPDTHcReurSCI00nYDbZ6JPYOU1h1dNnKrqLqKfQCUsSxsQQ3pzjwwG/WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771538280; c=relaxed/simple;
	bh=njC9rGOg72rhNBenR2HPHTHK/v1nLUCjBbTgnjT55sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVHrol4Tp2bWeaJOndHZJB7XX4Jd3vxvPuLdTpEnOS2cHcbBJzuwq5eTXuYsnGVIN9WeqAmeF9Fihqiv3ztPQi80lNNVGvZizs00Pck3qU+zmmYVCwHi+FCWCXvIzxJrdYILjDi4puX4eC/DlokFuXGknRl10P07S4IEWRKoKTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=GL7GqrSs; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=kkUVJaHP; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="GL7GqrSs";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="kkUVJaHP"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JLlV6e2890800
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 21:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=0uFIrY2cXd/EPYssOwKwR0auG6gdWTwluyqlj+VnGFM=; b=GL7G
	qrSsxO85JPn5fzqA0MpoINF1mtnGj/5uhYH4NSNeSHYG0/Sf957Qz1Xwnm/XzaJV
	FEt0SOSUi+LBll6+r7Jjk42+7qzBOfC++PhSZ92aWdu/6dO7oNlADUrQuQmLKHC1
	bkdV5G3th4lrGwAOzRwSJaHHMrTiv9+BxNPMijn53iZYeKMq9XVpkF/feUp+UK2D
	wYWUXLcwNH4B61RiP/D/ursIr8AvtfdB61LDzHfS5VxW18UbmyubfAeTtOTNJ4sU
	0gs6csXFdgY2j3y+kjlMaLzsgQq1bwgJ0MoJyBPhcL5kXFZYS+kAlqG1y/4EVwrO
	SXhEqhKa+UZPMe5iqg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ce0eatw1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 21:57:58 +0000 (GMT)
Received: from 04wpexch002.crowdstrike.sys (10.100.11.77) by
 04WPEXCH008.crowdstrike.sys (10.100.11.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 21:57:56 +0000
Received: from 04WPEXCH014.crowdstrike.sys (10.100.11.87) by
 04wpexch002.crowdstrike.sys (10.100.11.77) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 21:57:56 +0000
Received: from mail-yw1-f200.google.com (10.100.11.78) by
 04WPEXCH014.crowdstrike.sys (10.100.11.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 21:57:56 +0000
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-797d2f736f3so25904127b3.3
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 13:57:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771538276; cv=none;
        d=google.com; s=arc-20240605;
        b=jC8FVvkNtoitw9Pln3t2OOqoLRrLQfSb/5xVCugmpMyjIJHAVgd5aLvcp92Xt33qUu
         v6OhWe3SuA1ahaIjwvdZr/m1JS8DB14JDqNZFB9EccfZ7qFykN8VQosXyKnvkh870zc5
         0LnFNgNfq31UiNgZTul9C3OzMHSGAXWZFiTjoolPau+Qk7zZYJ5uZwks+mweND//3d8p
         rZ0XygnCMaSeGMBOLrJaOnsYcNCaUJiyEBhi37rMCEcl7/X0NLMq/9DDnfZOoDLjT4td
         zAj/7BhP99r60jFkiftSrN5+jUWgOEXqKduE0MpwQU1Ds6VSalt03uDmHNcK6zZDXICq
         1CbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0uFIrY2cXd/EPYssOwKwR0auG6gdWTwluyqlj+VnGFM=;
        fh=dg8Y6TqrhGGPoMuiFQvhjrc+AXR5n5qC1MDLD7sU4Qw=;
        b=cDpMnEvT7eUjmPO+RA3hOtMQW/KwxQwA8YC5G0D6CpAf08Lx6n4QxbF78kEQnV58B2
         uxhOFQzanewIE1yEESB1rtxigVELAhC8P8pNKu3Ww3AQm5/9n7ydDW33/dqHWfSYPt3M
         mmkQ0gEtNIXSyW5/7p0jqgUk4XOeOag1A0U6zP84l0ZcNCZvreMX7LZ1se2lUsWwfndw
         kRiBIgSyKQ6/UnHBl4xUPmmoz2rhuaeMCpjl0EFzyanKB7TBf9+M61Cbykj+6Ynll57T
         LD7XOh07ro3CGFskIaRs7/0K3yE5bEkIN8TAPO3zS0KmZp2ay/0op4MRJ/tvqnK0UtsM
         tysg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1771538276; x=1772143076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uFIrY2cXd/EPYssOwKwR0auG6gdWTwluyqlj+VnGFM=;
        b=kkUVJaHPoTbDpzlrWpyIZnGPnsss6veaVNJ3jXzN0X0p9vXqxeaeI1SjMV+r9hbzQ/
         pBUHuogBaCrF68W4z/w6FqMDKKPiTHCVKDFssJh49xqw/AWRmuTncJTFj3pXN1zFUQJj
         YrQBerMRuO8HmeIOdExT44SinT6FHmQmaDh3FXgGHzHyyEQHwhLsWVnZcMySuZWE6UZA
         w2QAPtkkWIE9eMIGuQKdqfQ1Ek8NCPqf5g89G6O07esA0QWvmyA2CEn8K0NRrfiWqZsL
         7oXEdtHG+c+3g+SphzZqKY9v8KpQnh5nGVmJlJcYqlOlo4T3+UDH8GYusERyWE9zkCXX
         XMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771538276; x=1772143076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0uFIrY2cXd/EPYssOwKwR0auG6gdWTwluyqlj+VnGFM=;
        b=npmueuK9QV0B7zO/tpn1ldOgSKEFiCUDvvoEMbM579vIz8K/ZluWeMsspDsdNheYd3
         8cTPeu/1I9sGdHDAgochsssFBLyVkrGD4qBWs7+752xSX0zvSjXkhXUgmCs+F7b5mWRZ
         kCgc15xdoGxR2vu/cSfy/cC3gTzGSCFkvrC1RSPUs9Z/MmkX+3Kfh/s/RKhOE5QktoE/
         FK0dkM/D40G7Z76RuSVbXrcIi1VQiXx5WJ0/9XhahAFfGGyEkmvl93wJ3m65c1OBYwVY
         Tcf1ElPxXr/CH1itrkOxfUwNOXCssQELvVXSlFH8ABkgy27VznHI0PIibvkwLWSNaHSP
         kHxw==
X-Gm-Message-State: AOJu0YxaIb63W29w/PPBNADsAi/pm0z1XT1S+1ynHEUn9nnD5qB9v7zS
	4i3E3mchxvry5e89r6s7cLgzQJqGo6JDi9kUCT6JkKTZsm4550bTH5Drya/D1JmslJQGQ5ia56a
	1lbtJAiYP/I/9Cne7YTR/bg6uoTwFp1WMRohpM15sRAAK+Pau1p2pXe6dVFR2K/nP2ZRu0RvYAP
	T4cQtgi8ToL35RoNIrR+c4PCyez/vOmYKvs64buLskxiw=
X-Gm-Gg: AZuq6aLvzpBte/yny1cfzT3MzDjuKHUGxqd7uR6jiXoJS6EppzXHaMBuAtKVQsyD1TX
	CsshdlA90sazKBR1jXN0P4oV00GVj4tboMUJX4xi6tpVVgFqI9oG/iWhBd9lJrk6ebsGQj7Bumq
	mkwEvcb2iUPx2gOM6uz29NigBRfXYqyD+DHISQEMcZ9cLJJ1gE0tvVSPNY7AH/vYqkOh6hVI4OC
	v7d
X-Received: by 2002:a05:690c:360a:b0:796:3787:39ad with SMTP id 00721157ae682-79803b602d9mr38246877b3.27.1771538275629;
        Thu, 19 Feb 2026 13:57:55 -0800 (PST)
X-Received: by 2002:a05:690c:360a:b0:796:3787:39ad with SMTP id
 00721157ae682-79803b602d9mr38246657b3.27.1771538275041; Thu, 19 Feb 2026
 13:57:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218225617.354858-1-andrey.grodzovsky@crowdstrike.com>
 <20260218225617.354858-2-andrey.grodzovsky@crowdstrike.com> <DGIIHMD5LE8T.ADJM2OXAWCGZ@etsalapatis.com>
In-Reply-To: <DGIIHMD5LE8T.ADJM2OXAWCGZ@etsalapatis.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 19 Feb 2026 16:57:44 -0500
X-Gm-Features: AaiRm51LlK7NEcf6FewERzcp5O5csreyFAfT2faXWsEhUGNXXMS9k3LKPcUM7v8
Message-ID: <CAOu3gNg3XKtZNCiwt7OarHrTLgKH7KZO_X6bAtrtFQuL+FZppQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next 1/2] libbpf: Handle duplicate
 kprobe symbols in attach_kprobe_opts
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, jolsa@kernel.org, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=DJiCIiNb c=1 sm=1 tr=0 ts=69978766 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=CWErhr8FAAAA:8 a=pl6vuDidAAAA:8 a=AJ_swzq5JW5wrpRvgZEA:9 a=QEXdDO2ut3YA:10
 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-ORIG-GUID: CaS4WlJQhz-wJpfQnRYjoBzqR-AXtyXk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE5OSBTYWx0ZWRfXx8HWCNLRBtOH
 IVp9uTowRYst2jPM7gjb31jtJ+KAcUsJFFnMe1T8RkljOyCwtK/rtG7pslIUQ42XHoKNsjz2Mf+
 M81Mb9zYt+9oOKSk9TrQHefo18xgheGLCPRVPHk91SdZRJ6Y6iu+Mf7+zXHbbDhtc08+bLEzM5o
 00nOT5d7HULUqCMDdDro0m4JqeSCCbzyI32xSTwX03HRNusvDKICOHmx53uv0iNbJgtx9ghLhGI
 /uxRLj0moKfSZCGMfOY0DR9wmX21r/YwytyqH6RjOceBvBZ2ev+xBFoyyOXMnH7OmnDrbq7Ypk+
 h5FbBNsQU1j+rleAKh/D8zI05yJBEC6QEk1ACg1qIcJA0PcOsTeTKWhNa6wUCSicwUlNtGm11M/
 9NMKLnb37aEZpMEre0itzOJCmACNfTxNltsE+rSVOOtNh3H84IqKrNeAZNGDlbyR9nDsJffbdTD
 +Xcfhr7NnssdVaARcGQ==
X-Proofpoint-GUID: CaS4WlJQhz-wJpfQnRYjoBzqR-AXtyXk
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11706
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190199

On Wed, Feb 18, 2026 at 7:28=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Wed Feb 18, 2026 at 5:56 PM EST, Andrey Grodzovsky wrote:
> > Add fallback to handle EADDRNOTAVAIL by retrying with absolute
> > kernel addresses from kallsyms when symbol names are ambiguous.
> >
> > When kprobe attachment fails with EADDRNOTAVAIL (or EINVAL in
> > legacy mode) and a symbol name was used, the kernel encountered
> > duplicate symbols in kallsyms. This patch:
> >
> > - Adds module_name parameter to kallsyms_cb_t callback and
> >   parser to distinguish vmlinux from module symbols
> > - Implements find_kaddr_cb() to look up symbol addresses in
> >   kallsyms, rejecting ambiguous symbol names
> > - Modifies add_kprobe_event_legacy() to support absolute
> >   address format
> > - Implements retry logic in attach_kprobe_opts() that falls
> >   back to address-based attachment on failure
> > - Updates avail_kallsyms_cb() callback signature
> >
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 150 ++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 133 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 0c8bf0b5cce4..684781d25859 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -8449,11 +8449,12 @@ static int bpf_object__sanitize_maps(struct bpf=
_object *obj)
> >  }
> >
> >  typedef int (*kallsyms_cb_t)(unsigned long long sym_addr, char sym_typ=
e,
> > -                          const char *sym_name, void *ctx);
> > +                          const char *sym_name, const char *module_nam=
e, void *ctx);
> >
> >  static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
> >  {
> >       char sym_type, sym_name[500];
> > +     char module_name[128];
>
> Why 128? __MODULE_NAME_LEN is defined as (64 - sizeof(unsigned long)) in
> moduleparam.h.

I see your point, I didn't see this one. I searched UAPI headers and
found nothing, so I basically
'appealed to authority' in the existing code, and I found that perf in
kernel_get_module_dso defines
Set the length arbitrarily to 128. SO i followed this. I am worried
that if we just redefine
__MODULE_NAME_LEN  (64 - sizeof(unsigned long)) locally here and use
it, if in future kernel
If this version definition gets longer, we will start failing the
parsing on those long names. So it seems
It seems reasonable to give this an extra length buffer. It's just a
stack variable and also it has no
performance penalty as we terminate the moment we see closing ']' anyway.
If you still strongly feel this needs to be changed I will do it. In
this case are you ok with me
locally define  __MODULE_NAME_LEN  (64 - sizeof(unsigned long))


>
> >       unsigned long long sym_addr;
> >       int ret, err =3D 0;
> >       FILE *f;
> > @@ -8465,18 +8466,39 @@ static int libbpf_kallsyms_parse(kallsyms_cb_t =
cb, void *ctx)
> >               return err;
> >       }
> >
> > -     while (true) {
> > -             ret =3D fscanf(f, "%llx %c %499s%*[^\n]\n",
> > -                          &sym_addr, &sym_type, sym_name);
> > -             if (ret =3D=3D EOF && feof(f))
> > +     while (!feof(f)) {
> > +             /* Position indicator - will be updated by %n if format f=
ully matches */
> > +             int n =3D 0;
> > +             /*
> > +              * The module name and symbol name are both without white=
space,
> > +              * but we cannot use %s to capture, as it consumes the cl=
osing ']'
> > +              * of the module format. Hence the %127[^] \t\n\r\v\f] wh=
ich provides
> > +              * the equivalent effect.
> > +              */
> > +             ret =3D fscanf(f, "%llx %c %499s [%127[^] \t\n\r\v\f]] %n=
",
> > +                          &sym_addr, &sym_type, sym_name, module_name,=
 &n);
> > +
>
>
> The following:
>
> > +             if (ret =3D=3D 4 && n > 0) {
> > +                     /*
> > +                      * Module symbol: all 4 fields matched AND we rea=
ched %n.
> > +                      * n > 0 means we successfully parsed up to the c=
losing ']'.
> > +                      */
> > +                     err =3D cb(sym_addr, sym_type, sym_name, module_n=
ame, ctx);
> > +             } else if (ret =3D=3D 3) {
> > +                     /*
> > +                      * vmlinux symbol: 3 fields matched, next is matc=
hing failure against
> > +                      * '[', but we don't care as we got what we neede=
d. Also note that the
> > +                      * trailing newline was consumed by the space aft=
er the symbol name.
> > +                      */
> > +                     err =3D cb(sym_addr, sym_type, sym_name, NULL, ct=
x);
> > +             } else if (ret =3D=3D EOF && feof(f)) {
> >                       break;
> > -             if (ret !=3D 3) {
> > -                     pr_warn("failed to read kallsyms entry: %d\n", re=
t);
> > +             } else {
> > +                     pr_warn("failed to read kallsyms entry: ret=3D%d =
n=3D%d\n", ret, n);
> >                       err =3D -EINVAL;
> >                       break;
> >               }
> >
> > -             err =3D cb(sym_addr, sym_type, sym_name, ctx);
> >               if (err)
> >                       break;
> >       }
>
>
> is pretty difficult to follow. Can avoid the long if-else chain
> immediately after the fscanf? Maybe something like the following:
>
> char *name;
>
> while (
>         ret =3D fscanf(...);
>         if (ret !=3D 3 && ret !=3D 4)
>                 break;

All in all looks much better! Will do. One point: we still need to add

 if (ret =3D=3D 4 && n =3D=3D 0)
          break;

here because we don't want to skip validation where we see the opening '['
of [module_name] matched but the closing ']' didn't.

Andrey

>
>         if (ret =3D=3D 4 && n > 0)
>                 name =3D module_name;
>         else
>                 name =3D NULL;
>
>         err =3D cb(..., name, ctx);
>         if (err)
>                 ...
> }
>
> if (!feof(f)) {
>         pr_warn(...)
>         ret =3D EINVAL;
> }
>
> It's also closer to the original code.
>
