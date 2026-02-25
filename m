Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1F3D3D1B
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033118; cv=pass; b=soUsFMh9I7/BgoYH/BkXE3CR3ybLMYYQ/thG646Zat9fQSEF5ZKFBw+JDDKW6KnL2waBj9+9U2S584VUl4kqbpTdXZ4LqOIMVoyz0jMQDafFM4yQsWXK56SiNMaAKbK4cSIjO27pKhmqCGClU50eSeVadnp1OqKtDT6BM6HnF34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033118; c=relaxed/simple;
	bh=KabiiyntjUoT20JBJnNSk9yycEy5eMorYUuoAN1FWkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYMBPruKicNOxuGSSB/t8/rBG0y0dByRQQWb10ObpGSMTisywF2gxHYwxnP/6IFwI+AgkuIjIb+wh18BtNjS4p9froehWL/dqQafSrXsUQEQQh452+n8fT902nGESzxCDVCs1iftX77cw5d2erm6M2qsrEDLUB9M55glkTi0zMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=dODVwNHC; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=oUxoCPhs; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="dODVwNHC";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="oUxoCPhs"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PC097U566412
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 15:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=r3rOnWcO3npnZzPx+0wbsHgL9j2g+F6nXf6M5nZ9J0E=; b=dODV
	wNHCcKhnKRC/QHsNuECXld9aB+8a5LY7R9H8wT+YigIdxVa+b8qIl8sqnhubDukR
	YGA4JsUbHC/DDZIqh7IRTNK8ZNW3B8ZTj8hvJKeV3QCj4/q43zKOeZ6ngUShe1zU
	w1e9JCwHak3AuCa/4fwhjs10EHka8gRimrMFMsCrEPcxEMXIjN2MuVBvDTVj6G7H
	HNbFA8RO/D5qBV+NAjenzwEaiyD1aPkiATimpl5qrPqWqsHrHSgcWnMhF7FErzKY
	xadSQ/NQsVsxaGxzDJxPO+kgz25965xvNpdZNsRT8b7Isw72SMbT/lMgM2ictoZN
	YJ5FxrAJoL26F/TYVg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4chjkkbsy8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 15:25:16 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7987281c3cdso857977b3.2
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 07:25:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772033116; cv=none;
        d=google.com; s=arc-20240605;
        b=lvfrabSeT+sdHdbnmg8iAKvLZeX3sbsUVaodIb2foNm+18rDy5L8CAa6ue+zLEsTGk
         N3izU/ZYz+YzAKZdrJlEcfbti+CpHvo67DGOEsUs1UDpRYDxIjso85GI633OQd1DdCmZ
         rcpM5O7D02t6PzoAFhJi4ZiLG3M9S4vBBF28knTKHuYc+pYsTNoS7HBlfe8VaaIQufng
         Qk9Zx81YNCj8IADus+j5PZ3EwcMBUeQt8KhFxBp37f8PuTTBj3eKAoazMw2g4wTly8t1
         P8Y3PfyyE+p9Teg0sBV5k1krNxoZ9EGXD3vpf1Ig8OGtp3kBWs6inajrSulf9jceidS6
         ZVXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r3rOnWcO3npnZzPx+0wbsHgL9j2g+F6nXf6M5nZ9J0E=;
        fh=C+VYcy1dMoSMEQiy9ik4xIIESmZNKn6r/UzTfhDMOzw=;
        b=UnZFwH8vsSPsYH/CPwOZnP2hcPV2Y4VmoFM0YQyEDd6N4VNcYs9NVDW8TpGaOdVrQu
         GembBkRWKSqeGSK5deQ3s8bj9JUJMGX1QGsgvaf9HJpz5QqzKH9WvNVNzzxZa/QPJzvi
         yVIAuY0dMaKVtfJ+T0PEyE9uWSiVyzP+OWNR7CTy7i4ERAnZmwVIvm6Y2bpMko/Qx1HY
         zsbPJMUvfWYqMWcqVoUYVL7TBB/73CjeRuJ6NxIREJo8kZ+0YZP6HqBILkRsfaVnM/iq
         Phn2ZXuQATP1JLdh0uLwNqziWIvRO0DDXxgGGcGY9SnLZ7/ucF8IDveA2HojGYEIUgjt
         WLJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772033116; x=1772637916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3rOnWcO3npnZzPx+0wbsHgL9j2g+F6nXf6M5nZ9J0E=;
        b=oUxoCPhsedkfBc3TrylVAZN8rPbuZacZV9y+o6Ef/IeYf4snu4gEBJGVf0Cu/7e2Fc
         wPYcH0mNknQ6grJratxely8UC0JM7k9YuWrTT0hVIsCuYooHjAh4B/UD1SpSZG5vJmdu
         s7pws/O8tYKn1B2pYVGTXy+E3e/0JgWCiPjebzgwJEnWt/uEZzJkBnw+YEHFDGet3jUs
         u/K/+Udp18We8XxzfJygV13/iIJ7BsTvTBWnVJcRrOpFoJ30zgP3W7VLEyH3J9u5ZM9v
         y5hruscK+nCPVXPow2XlHhOowHFzBLgej5boMV0uiDbspFr43Zp12tr2E6fDQACEljf9
         IXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772033116; x=1772637916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r3rOnWcO3npnZzPx+0wbsHgL9j2g+F6nXf6M5nZ9J0E=;
        b=MwYxEb8PiQAvsFgQEjEykidy3ecxoeSwgGs17+KJ7g7Yu2eJwDy1tJ6ILc4P9J3/yQ
         3kQOT2jFwnP+KX6DQUdUvD5fH1Y0xoDBHjGFbLZd0i3+Tj0eRRUVGqToj0bI6rG4V4c8
         +lf5b+xAYQ1OAwjXDvCh7tz/xdONEB1TVZT/ARiJD6flTXurKK10GkFigGNYxtWGD4yr
         39e4I+aAPHVGvHUU0v5lLLm1IE1sVEtR/R+ZAsnAV9P3YiqgdwoOY10rfONAhTvMQ/+G
         UNIeQxLev2IBsvKpPUxAdGhZFu5nmjL6401TVGSGyuZCoT/b3SF4V8NYFWxOrPzZv3lt
         p1bw==
X-Gm-Message-State: AOJu0Yyo9xpvymG+o4RfKzkENhV/C1LSHLa4lDgvfZzEGoPwaelN6UQ3
	dszFbAsRrBnSZqvxa7PhPCR10r37Ox+TKZPlmOYi6wvHbpB1zC3FVuFluLElwm7wfrFOTsW1WqM
	KFda4YM4d2lUYQ+x9uDqL22xWm5cqA50fFRz2sfZSW3XRLyG64fQfLCONgCqbW6f7EvlxfPyUaX
	esoYrBXpRf/lDGW/zymmWvl1Jc+zEn
X-Gm-Gg: ATEYQzy+rdZ40jeXQXXPzpcTtwydTk4uQMTqaK6ACzxJUjcqSNewftW7NFBbSo1Cx60
	ztwEAAJGtUX/VW4/H7YfOvel4M3CrZt9B+SSBpvnzKRaRX49jEei9+tvunxJkuY10LXMKFm/VdU
	p9TsyMpAYFD8WeAzo4pyV0rUEG/20C81hOvNmeOq/8vpL3RLNLZSs6pxCU9uSpn8+uzMzAU9G2P
	oBX
X-Received: by 2002:a05:690c:39a:b0:794:22cf:6d27 with SMTP id 00721157ae682-79828df8318mr152955347b3.10.1772033115693;
        Wed, 25 Feb 2026 07:25:15 -0800 (PST)
X-Received: by 2002:a05:690c:39a:b0:794:22cf:6d27 with SMTP id
 00721157ae682-79828df8318mr152955047b3.10.1772033115108; Wed, 25 Feb 2026
 07:25:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com>
 <20260223215113.924599-3-andrey.grodzovsky@crowdstrike.com> <20260225064723.53bcce3e@fedora>
In-Reply-To: <20260225064723.53bcce3e@fedora>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 25 Feb 2026 10:25:04 -0500
X-Gm-Features: AaiRm51eNVjvePLenPXzkfp8kpIw1ud6qC00MFX-7ts1dpXjTZbA6sNKq6qrlhE
Message-ID: <CAOu3gNjdE_GaEEC__L=4v44iMJZt_eBN2Se_FotCDjX0BXwi1w@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next 2/3] ftrace: Use kallsyms
 binary search for single-symbol lookup
To: Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, jolsa@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=dYaNHHXe c=1 sm=1 tr=0 ts=699f145c cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=t04HzT_fAfAF5W-3wVZy:22 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8
 a=lUMtyIEoyaf5RNnLcBoA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE0OCBTYWx0ZWRfX5yVXrTZ5iQIx
 m2kPd+r4GtVs4i8dxeRdfe/0MZO8lwAfZbesbB8I5lfkDBKbe5lnVjugPVaUs3nmKlX0Negu2OE
 PSUCX5tfbb0j9jsmq8wiPgSi9jPqPoGdYZOuSt1HzJEREi2emeF1n+M9riurAE8uQ+4dOIPCXF/
 wp610ZI+mEwib53bKYmLevlCEj+KdK+omP4Q15GwW7cfS5HEQJekf8TIvDuTtWeqqH85jGZaYSI
 ZAimJLTfs/9UOb8207lovi13iLhVml0TCUIRH4wZJSJSK1L2iPlU+DgzMqua1uD2EXPWFXbq6N0
 1mk+557svJrKxCcyAp2QE3ZtjRsaTsP0VuOjKUsKmyNETMA1IjtKIDfdTR4sew7csUTCOQN/g8u
 pRcB8e5X7a08zVZfPtO5SOTk5XiBxN0DL0PPvKslrTH5PXFgnGIPq8oMxVZxoAiyNvQmzgCCtWI
 p0Z4joiWYpizYf9H6dg==
X-Proofpoint-ORIG-GUID: fccIb5d5oHNM40VgJvstTGUl1ySZjIYP
X-Proofpoint-GUID: fccIb5d5oHNM40VgJvstTGUl1ySZjIYP
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11712
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250148

On Wed, Feb 25, 2026 at 6:47=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 23 Feb 2026 16:51:12 -0500
> Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
>
> > When ftrace_lookup_symbols() is called with a single symbol (cnt =3D=3D=
 1),
> > use kallsyms_lookup_name() for O(log N) binary search instead of the
> > full linear scan via kallsyms_on_each_symbol().
>
> So this patch looks like it should go through the tracing tree, not bpf.

Hey Steve, are there any extra steps required on my side to make this go
through your tree?

Andrey

>
> >
> > ftrace_lookup_symbols() was designed for batch resolution of many
> > symbols in a single pass.  For large cnt this is efficient: a single
> > O(N) walk over all symbols with O(log cnt) binary search into the
> > sorted input array.  But for cnt =3D=3D 1 it still decompresses all ~20=
0K
> > kernel symbols only to match one.
> >
> > kallsyms_lookup_name() uses the sorted kallsyms index and needs only
> > ~17 decompressions for a single lookup.
> >
> > This is the common path for kprobe.session with exact function names,
> > where libbpf sends one symbol per BPF_LINK_CREATE syscall.
> >
> > If binary lookup fails (duplicate symbol names where the first match
> > is not ftrace-instrumented, or module symbols), the function falls
> > through to the existing linear scan path.
> >
> > Before (cnt=3D1, 50 kprobe.session programs):
> >   Attach: 858 ms  (kallsyms_expand_symbol 25% of CPU)
> >
> > After:
> >   Attach:  52 ms  (16x faster)
> >
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  kernel/trace/ftrace.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 827fb9a0bf0d..bfd7670669c2 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -9263,6 +9263,19 @@ static int kallsyms_callback(void *data, const c=
har *name, unsigned long addr)
> >   * @addrs array, which needs to be big enough to store at least @cnt
> >   * addresses.
> >   *
> > + * For a single symbol (cnt =3D=3D 1), uses kallsyms_lookup_name() whi=
ch
> > + * performs an O(log N) binary search via the sorted kallsyms index.
> > + * This avoids the full O(N) linear scan over all kernel symbols that
> > + * the multi-symbol path requires.
> > + *
> > + * For multiple symbols, uses a single-pass linear scan via
> > + * kallsyms_on_each_symbol() with binary search into the sorted input
> > + * array.
>
> The above is fine.
>
> >  While individual lookups are O(log N), doing K lookups
> > + * totals O(K * log N) which loses to a single sequential O(N) pass
> > + * at scale due to cache-friendly memory access patterns of the linear
> > + * walk.  Empirical testing shows the linear scan is faster for batch
> > + * lookups even well below 10K symbols.
>
> The above is unneeded for a comment in the code and just belongs in the
> change log.
>
> -- Steve
>
> > + *
> >   * Returns: 0 if all provided symbols are found, -ESRCH otherwise.
> >   */
> >  int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsign=
ed long *addrs)
> > @@ -9270,6 +9283,21 @@ int ftrace_lookup_symbols(const char **sorted_sy=
ms, size_t cnt, unsigned long *a
> >       struct kallsyms_data args;
> >       int found_all;
> >
> > +     /* Fast path: single symbol uses O(log N) binary search */
> > +     if (cnt =3D=3D 1) {
> > +             addrs[0] =3D kallsyms_lookup_name(sorted_syms[0]);
> > +             if (addrs[0])
> > +                     addrs[0] =3D ftrace_location(addrs[0]);
> > +             if (addrs[0])
> > +                     return 0;
> > +             /*
> > +              * Binary lookup can fail for duplicate symbol names
> > +              * where the first match is not ftrace-instrumented,
> > +              * or for module symbols.  Retry with linear scan.
> > +              */
> > +     }
> > +
> > +     /* Batch path: single-pass O(N) linear scan */
> >       memset(addrs, 0, sizeof(*addrs) * cnt);
> >       args.addrs =3D addrs;
> >       args.syms =3D sorted_syms;
>
