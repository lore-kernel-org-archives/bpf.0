Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A93C3BE1
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073340; cv=pass; b=PmnfOW7NM1GAULnZ+JhExoVlB830SyXPnQ2R1r91FZ4/AAzIbM14uhelz2YaFNo1V34gxjj6jqcWaLkLYkC5MyZ12HbXIDs07/WejXaj3wmo556iW/ARs/+inMppgknJ1YM6uiey+7TrH71ezRPIMY55LvFXyNrP8eHK7wNgjMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073340; c=relaxed/simple;
	bh=FUb0282YmQTpK+IcAIf5PKo2fA8i1fXrx5fFU8N0DUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RehQnfyxjjQy92DOpPA8T+LtGHmRheK+0Pqw3Bym6qqv1x0Nb+tApIlmJYeFDyug9CQe2PpuAvAOtfPcpwJKrxoXJTuBRK2d3bNh78fMT9GM/F/Zn/bKdMxGmKwJOJpEs4L2Ia6RT6oltBaXzo+E2AerOGiIHntNgRYtIml2FOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=AB/KkVTX; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=cnitYJKa; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="AB/KkVTX";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="cnitYJKa"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629Epvoi1420446
	for <bpf@vger.kernel.org>; Mon, 9 Mar 2026 16:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=3Wbk91UTt3vHz4jJFG8FLc6PpsIJinP0qHzf1ZmXGO0=; b=AB/K
	kVTXTLSr63Kf1SiEB4kVKCV8S/YOmEze/0oV3m6uDxwiLUmAI0rzJKUnDnMzBbli
	W5rDMEclrma5dIUJsSdSVUvMmqe8ALQv2Pez02XVfTiNM62o2GG5qoEhFQxIjoyw
	pCQCtlSJ9dvSQ5T3rDUeqRBNmMUOHy7tlFWHfhuoTG5C3tHUchPUwjGkqwgvtP1c
	Q1esG3XxuSAQKQLxH1RAJWL/NbALUpcZWcKtYQQf5ceXaJrf1f/WiaMe+33u/Jeb
	k+pHrBavJZH652r+izf9mVIJMQ18uSNvann3cZzk8Yveo8QAGt0SLl1XnFRA70//
	LUT2/VdNvZgmmcxB8A==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4crxykdbf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 16:22:11 +0000 (GMT)
Received: from 04WPEXCH006.crowdstrike.sys (10.100.11.70) by
 04WPEXCH008.crowdstrike.sys (10.100.11.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Mar 2026 16:22:10 +0000
Received: from mail-yw1-f197.google.com (10.100.11.78) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Mar 2026 16:22:10 +0000
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7982c466ee1so226792447b3.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 09:22:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773073330; cv=none;
        d=google.com; s=arc-20240605;
        b=WY8ZkSx1BkTzu8aUQjHcrFHSUkK8MKgbzODf+LLEPsGqcyF8sX/6+B62cboUtoLA6b
         9z81g0K5LFKLaPItTFjOi7UpT9dpYrUK4cQVVBF2jyU11UbpjGcIBmrQvY+CK6amspam
         VyAx/f6iJ8JMWzzVS2Nmc9eyNeYWuz1QmY+Wki5A/7ng8Hy8LEHE9D+3hwpvCWgSIG3s
         3PhM1mYBNInRbVFWxa1NZ4D/MHw/NEuHT2+k7OTIgmi0AqNxkzYuT+41upijJjUI47sF
         STVNz+vAcYWHx++t15hfhH0TnTMEgKkoYKZhH/CoReg8g3DWX6KFi5qwqCuqkx66WqNw
         Szyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Wbk91UTt3vHz4jJFG8FLc6PpsIJinP0qHzf1ZmXGO0=;
        fh=Aj/3puJsgbj4KiqfiREgmAIel919/BBFDVCi/EX941A=;
        b=X48DoFGUS0smyyV0afmybuD1IDZj4FtY26SK/dy5l+aPS19aydkie3aH+vHbvQOY5l
         QkelohnfZPKZeqz/yMdqPV6jWb2sx5XCMDwJ19Z9pf80IcmcsZfm0PGOyoCL3rRqx2CI
         bgmz2Cn19wQ5c0ggKEgvHCxivQTOjHDDsPOrGl9eL/5YhyLYlLR9rSZGv8dizSWx2gRI
         rkvOuFXJIQIXbjRczXVMxj1MG36VVuO6PomYgJ73te8mnLsA/KTGtwH1aD5Obof8okVy
         +BMuL1EWl6/Jl6PCuUgxPcv/PCeP+Cjrvcisa0Ei5NbiSbPTJWRuhaEnCepXGhfgqlra
         WGmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1773073330; x=1773678130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Wbk91UTt3vHz4jJFG8FLc6PpsIJinP0qHzf1ZmXGO0=;
        b=cnitYJKaBcrO0zU/JhumOt7n/b2SfklaMGJLLmFAfl1utxJC3HK5eWa2Z/GkTvrQjZ
         APsILsEB6/w+x/xNmXYIgzoo0E6uRBXVCE6IN+E5G/V5lUre/t4ff15v6d19Evywev43
         ukRUMJepHUFrrI3iZD/x5X7TVKnInMUOr6v6OnUnrDyn5E3siTUiZhODPc4p8JZMvLqn
         nbeW1FVQwuFHndEpPhhvGa6txswHbnkFl5CqMTfi7uBckUYC/2tokpzzBQp/UGrSGkBA
         oI9lSvxeQNkFN/YG3L5Fv98gSvpKbJtRUwSSpfJ5NT33C7uWdwcaGwLHtPVaAPRdlWgh
         uTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073330; x=1773678130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Wbk91UTt3vHz4jJFG8FLc6PpsIJinP0qHzf1ZmXGO0=;
        b=nOZQ0VT7i4159HZLMJWKmeTOchxgHE0k+ydEPbbJZ0uowesaQOhxTBUvQLrSCuJ8nE
         OaJHbHncrY9lbzbB+Hht4cVAz4srW6kRodRGT5Ud98wpKWODRKBRwJduoL8wSNAO8VuO
         sqckjjjZmM+2vupmEavbiDyynWpAbcFiIhBlP7+Hz6qy8AXnf/ApdM58N07tBA4FUxcy
         XbyggcesSikM3S7mdPsfCt92Uf5Z+qF8WqIbjpu9KzpG2m8SW9Tv4QdxCuu3vxh3BOUr
         NXqmgOSBZCkhy6Yl6Cbuq05d9Nhq8cLRN3IjebiBCiLs5JKJbtQW+KDxk+2nTnmwg041
         UB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbDV8SgDN9ri+ieocNsgyRq02SR+gCvoor6olVcA+u/pn9sX1mGCL5kTMTt2rEH5F+oS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW8NHcVoWKEdVMw4ALNA8Mq1a5FZP/IVJ9SqWPI7wImDOjd4/Z
	q5YcrC38WT2MR/BoospgIaOZnRxPcwSQ7URPSNxut9hEdWwKo6ABhTQAHj/8v1Ll6ArcBei4GEP
	VNWUbId9B3tkMGsxOuGjbnS4r7cBIP7OLcjrYPcGTFwasfyLoswFkLrJexfoM1B4V9lhDPriddf
	TqC7InDIxfj21iEe/1N96HbEKZzJywj/4mx70GWJDRabFAv5n65+NeEg==
X-Gm-Gg: ATEYQzyFmK6mi5i9GHA2u7JpXTg7Qc5rMO8yyLMTT0Gk6Zx6CVsKK4B7lgOySfJzVC6
	uvNgnQuVUwkob+bD7iRfrXgYMZEvtohD4ecgeZ1a3DNru+qKcnrpAuauuF5TvW8dvsVy9xV9qhb
	ocg+lSkUV/GbgxR5V943LlMiJ6BuyiwWoN7nM+RhL0z74EKD3Rvl4L+pTQ1oy/QLAG8/l2Vn6wZ
	iW3
X-Received: by 2002:a05:690c:c508:b0:796:2fde:5dbe with SMTP id 00721157ae682-798dd742140mr105856607b3.44.1773073329401;
        Mon, 09 Mar 2026 09:22:09 -0700 (PDT)
X-Received: by 2002:a05:690c:c508:b0:796:2fde:5dbe with SMTP id
 00721157ae682-798dd742140mr105856247b3.44.1773073328727; Mon, 09 Mar 2026
 09:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302210532.381083-1-andrey.grodzovsky@crowdstrike.com>
 <20260302210532.381083-2-andrey.grodzovsky@crowdstrike.com>
 <CAEf4BzYiwAczqqdb40YKq8yRd7JWgOV_cgyehpCRzoEZ6qeP7g@mail.gmail.com>
 <CAOu3gNgUp0sqgTUfCM_UFsEi6jwsTDjMrAZL_Pv=FZ4Fx_Khug@mail.gmail.com> <d891ea63-b9e8-47dc-8127-82533ab09098@linux.dev>
In-Reply-To: <d891ea63-b9e8-47dc-8127-82533ab09098@linux.dev>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Mon, 9 Mar 2026 12:21:57 -0400
X-Gm-Features: AaiRm531xog-oiNA7Vc51oXQaSx386L9WiajLHOWojCXWzFuZ3eenDKNCV9YO0E
Message-ID: <CAOu3gNjFVtoHgktuOku7D1c2vt6PXyhfYWHBM=-KFgHrMDBt7Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v4 1/2] libbpf: Handle duplicate
 kprobe symbols in attach_kprobe_opts
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        jolsa@kernel.org, emil@etsalapatis.com,
        linux-open-source@crowdstrike.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Disclaimer: USA
X-Proofpoint-GUID: unJ-aFHwgXDaxGf0VtTKVYAwrCTHsqCw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE0NyBTYWx0ZWRfX7Q0iQ4cv7KF8
 xanet0DV0xSKd1sAJ524SbZZx7FYFJ+3BC0jT6/XPrsBqYKs7Oc1KT4355am2hrK6SA5e9fahOJ
 +yaxNui7bvdx/7ohho9F8Q7GipXTDv/1Y96pm0RUDH4fMY/swmXRzAZWg8QmLwKUeqrj6Gn+ZV1
 2Qt/VWXjJt0Oi1YxyeKqpE6E5+JsuLV5cRhsdOF7RVOra5rFJ6lqKsrToFxHyrrOBCeFNSBUQk+
 7rl3t2U8sr+XznC8PZNR8Ow2zvGj4B6hXkGTguGzqKnxWsC/nz+vXKVGbTvQncYsayNLRw6OhTz
 YGJGwwL9UwKjG6OFVwbGgQMofqg9D78wGBhnXYsy0qAJ0jW1R1afZAenanTOUqBsIlbkfjhHI9h
 jSRCMI54pvfMRwjophlcU3+XNvBOPVRlXxlqQOCtfB65BbY/Gw9Z3hMEFYfzlAyqLs7Hx2CeiBh
 JAyvwtHNIHCF3kv5iSw==
X-Proofpoint-ORIG-GUID: unJ-aFHwgXDaxGf0VtTKVYAwrCTHsqCw
X-Authority-Analysis: v=2.4 cv=M7FA6iws c=1 sm=1 tr=0 ts=69aef3b3 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22
 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8 a=oFkdGbvsFxyz5vJ7UwYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11723
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090147

On Fri, Mar 6, 2026 at 7:37=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 3/6/26 1:08 PM, Andrey Grodzovsky wrote:
> > On Thu, Mar 5, 2026 at 5:47=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Mon, Mar 2, 2026 at 1:05=E2=80=AFPM Andrey Grodzovsky
> >> <andrey.grodzovsky@crowdstrike.com> wrote:
> >>>
> >>> When a kernel module exports a symbol with the same name as an existi=
ng
> >>> vmlinux symbol, kprobe attachment via bpf_program__attach_kprobe_opts=
()
> >>> fails with EADDRNOTAVAIL (perf_event_open path) or EINVAL (legacy
> >>> tracefs path).
> >>
> >> If the same symbol name resolves to multiple addresses, that's an
> >> ambiguity that libbpf has no business resolving. It should be on user
> >> to resolve and use attachment by address, which libbpf supports
> >> through bpf_kprobe_opts or multi-kprobe opts.
>
> Hi Andrey, see my comments below.
>
> TL;DR is that I agree with Andrii here. The proposed mechanism with a
> fallback and kallsyms parsing just doesn't fit in libbpf, especially
> given that a user-side workaround is feasible (even if inconvenient).
>
> The first point that seems obvious to me is that modules shouldn't
> shadow kernel symbols. If your module does it accidentally: fix your
> module. If it's on purpose: sorry, you're on your own then.
>
> But let's set that aside for now. After all the module may be an
> external dependency of whatever system you're building or tracing.
>
> >>
> >> pw-bot: cr
> >>
> >
> > I understand the concern about libbpf making policy decisions on
> > ambiguous symbol resolution. But I think the skeleton-based auto-attach
> > workflow makes this impractical for the user to handle.
> >
> > The recommended upstream pattern is:
> >
> >   skel =3D my_prog__open_and_load();
> >   my_prog__attach(skel);
> >
> > So it's something along the lines of
> >
> > our_skeleteon_bpf__attach(skel)
> >     =E2=86=92 bpf_object__attach_skeleton(skel->skeleton)
> >       =E2=86=92 prog->sec_def->prog_attach_fn()  [=3D attach_kprobe()]
> >         =E2=86=92 bpf_program__attach_kprobe_opts(prog, func, &opts)
> >           =E2=86=92 perf_event_open_probe(name=3Dfunc, offset=3D0)
> >             =E2=86=92 perf_event_open() =E2=86=92 EADDRNOTAVAIL
> >
> > So bpf_object__attach_skeleton(), which iterates over all
> > programs and calls attach_kprobe() internally. That function extracts
> > the symbol name from the ELF section name (SEC("kprobe/func_name"))
> > and passes it to bpf_program__attach_kprobe_opts(). The user has no
> > control point in this chain - no callback, no option struct, no way
> > to intercept a failed attach and supply an address instead.
>
> You are right that the skeleton auto-attach path doesn't have a direct
> interception point, but this is solvable without libbpf changes.
>
> The workaround is essentially what Andrii suggested: resolve the
> address yourself before attaching. I vibe-coded a change on top of
> your selftest patch to demonstrate it, pasted at the bottom. It works.
>

Just to clarify, the offending function is unknown, and since we go
through bpf_object__attach_skeleton, which bulk iterates all our programs, =
we
have no way to relate the returned error to the program that caused it.
Although i do see a hacky way, libbpf logging reports and error at this poi=
nt
and does specifiy which function failed to attach, so this would allow us
to avoid libbpf cnages... But it's obviously hacky...

> But even ignoring the workaround, I think there are conceptual issues
> with the proposed approach, regardless of whether the fallback is in
> attach_kprobe_opts or limited to auto-attach.
>
> The fallback unconditionally prefers vmlinux over module symbols.
> If someone legitimately wants to probe a module function that shadows
> a vmlinux name, this silently attaches to the wrong target with no
> opt-out.
>
> The EINVAL catch in legacy mode is overly broad. EINVAL can come from
> many conditions (bad offset, bad probe name, write errors), not just
> duplicate symbols. The func_name !=3D NULL guard helps but doesn't
> eliminate false positives that trigger unnecessary kallsyms parsing.
>
> kprobe_multi is not covered. libbpf_available_kallsyms_parse()
> resolves symbols by name via glob_match() without module filtering.
> The same duplicate-symbol issue exists there.
>
> Every retry parses all of /proc/kallsyms linearly (that's 100k+
> symbols). If multiple probes fail in sequence, the cost compounds.
>
>
> >
> > If a kernel module happens to export a symbol with the same name as
> > a vmlinux function the user is probing, the attach fails with
> > EADDRNOTAVAIL and the user has no recovery path within the skeleton
> > API. The only options would be:
> >
> > 1. Abandon skeleton auto-attach entirely for any kprobe program
> >  that might hit a duplicate, and manually call
> >  bpf_program__attach_kprobe_opts() with a resolved address for
> >  each one. This defeats the purpose of skeletons.
> >
> > 2. Proactively scan /proc/kallsyms before every attach to detect
> >  potential duplicates, set prog->autoattach =3D false for affected
> >  programs, and manually attach those. But autoattach is not
> >  exposed in the public skeleton API either.
> >
> > Since a kernel module can be loaded at any time, any kprobe could
> > potentially become ambiguous. Pushing resolution to the user
> > effectively means the skeleton auto-attach pattern cannot be
> > reliably used for kprobes.
>
> To that I'd say that you can not *reliably* use kprobes. Period.
> There is a whole can of worms with inlining and functions being
> optimized away etc.
>
> Handling a case when your userspace+BPF system smartly handles symbol
> changes due to module loads is not libbpf or kernel's business IMO.
>
> >
> > The fallback in this patch is intentionally conservative - it only
> > triggers on the specific error codes that indicate duplicate symbols
> > (EADDRNOTAVAIL for perf_event_open, EINVAL for legacy), and it
> > resolves strictly to the vmlinux text symbol, skipping module symbols.
> > This seems like the only reasonable behavior for auto-attach, where
> > the user has expressed intent to probe a specific function by name.
> >
> > Would it make sense to limit this fallback to the auto-attach path
> > (attach_kprobe) rather than the explicit attach_kprobe_opts API?
> > That way users who call attach_kprobe_opts directly still get the
> > raw error and can handle it themselves, while the skeleton workflow
> > has a reasonable default.
> >
> > Happy to hear alternative suggestions on how to make this work
> > within the existing API.
>
> I think we can reframe the issue in terms of "how to make this more
> convenient".
>
> It looks to me that the main issue here is in number_of_same_symbols()
> (in trace_kprobe.c). When no module qualifier is given, it counts
> matching symbols across vmlinux AND all loaded modules. There is no
> mechanism to scope the check only to kernel AFAIU. So any module that
> exports a matching symbol makes the vmlinux symbol unattachable by
> name.
>
> It may be worth a discussion whether a "I want a kernel symbol"
> mechanism could be introduced for kprobes, since the kernel already
> supports MOD:SYM qualification.

Thanks, that's a good point! I might look into this route as an alternative=
.

>
> With a kernel side change like that, the skeleton auto-attach path
> will just work, no libbpf changes needed at all.
>
> Thanks,
> Ihor
>
> And here is the workaround example patch:
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tool=
s/testing/selftests/bpf/prog_tests/attach_probe.c
> index 75c22af2f1b3..c20a1510b4d1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -5,6 +5,7 @@
>  #include "test_attach_probe.skel.h"
>  #include "kprobe_write_ctx.skel.h"
>  #include "testing_helpers.h"
> +#include "trace_helpers.h"
>
>  /* this is how USDT semaphore is actually defined, except volatile modif=
ier */
>  volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribu=
te((section(".probes")));
> @@ -177,6 +178,83 @@ static void test_attach_probe_dup_sym(enum probe_att=
ach_mode attach_mode)
>         unload_module("bpf_testmod_dup_sym", false);
>  }
>
> +/* Workaround for duplicate kprobe symbols without libbpf changes.
> + *
> + * When a module exports a symbol with the same name as a vmlinux functi=
on,
> + * attaching by name fails with EADDRNOTAVAIL. The fix does NOT belong i=
n
> + * libbpf. Instead, the user can:
> + *
> + *   1. Resolve the vmlinux address via /proc/kallsyms using kallsyms_fi=
nd(),
> + *      which returns the first match -- vmlinux symbols precede module =
symbols
> + *      in kallsyms output (module symbols are annotated with [modname])=
.
> + *   2. Attach with func_name=3DNULL and opts.offset=3Dabsolute_address,=
 bypassing
> + *      the kernel's duplicate-symbol check entirely.
> + *
> + * This demonstrates that no libbpf changes are needed; resolution of th=
e
> + * ambiguity is the caller's responsibility.
> + */
> +static void test_attach_probe_dup_sym_workaround(void)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
> +       struct bpf_link *kprobe_link, *kretprobe_link;
> +       struct test_attach_probe_manual *skel;
> +       unsigned long long kaddr =3D 0;
> +       int err;
> +
> +       /* Load module with duplicate symbol */
> +       err =3D load_module("bpf_testmod_dup_sym.ko", false);
> +       if (!ASSERT_OK(err, "load_bpf_testmod_dup_sym")) {
> +               test__skip();
> +               return;
> +       }
> +
> +       /*
> +        * Resolve the vmlinux address of the target function.  kallsyms_=
find()
> +        * stops at the first match; vmlinux entries precede module entri=
es, so
> +        * this gives us the vmlinux address even when a module shadows t=
he name.
> +        */
> +       err =3D kallsyms_find(SYS_NANOSLEEP_KPROBE_NAME, &kaddr);

Just to reiterate my issue  - i don't know that SYS_NANOSLEEP is
the one which casued it. Could be any random function we attach, at any
point of time, depdendant on currently loaded moudles in the system.

Thanks,
Andrey

> +       if (!ASSERT_OK(err, "kallsyms_find_nanosleep"))
> +               goto unload_module;
> +       if (!ASSERT_NEQ(kaddr, 0, "kaddr_nonzero"))
> +               goto unload_module;
> +
> +       skel =3D test_attach_probe_manual__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_dup_sym_workaround_open_and_load")=
)
> +               goto unload_module;
> +
> +       /*
> +        * Attach by absolute address (func_name=3DNULL, offset=3Dkaddr).
> +        * The kernel receives no symbol name to validate, so the duplica=
te
> +        * symbol in the module does not cause EADDRNOTAVAIL.
> +        */
> +       kprobe_opts.retprobe =3D false;
> +       kprobe_opts.offset =3D kaddr;
> +       kprobe_link =3D bpf_program__attach_kprobe_opts(skel->progs.handl=
e_kprobe,
> +                                                     NULL, &kprobe_opts)=
;
> +       if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_dup_sym_workaround=
"))
> +               goto cleanup;
> +       skel->links.handle_kprobe =3D kprobe_link;
> +
> +       kprobe_opts.retprobe =3D true;
> +       kretprobe_link =3D bpf_program__attach_kprobe_opts(skel->progs.ha=
ndle_kretprobe,
> +                                                        NULL, &kprobe_op=
ts);
> +       if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe_dup_sym_work=
around"))
> +               goto cleanup;
> +       skel->links.handle_kretprobe =3D kretprobe_link;
> +
> +       /* trigger & validate kprobe && kretprobe */
> +       usleep(1);
> +
> +       ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_dup_sym_workaro=
und_res");
> +       ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_dup_sym_w=
orkaround_res");
> +
> +cleanup:
> +       test_attach_probe_manual__destroy(skel);
> +unload_module:
> +       unload_module("bpf_testmod_dup_sym", false);
> +}
> +
>  /* attach uprobe/uretprobe long event name testings */
>  static void test_attach_uprobe_long_event_name(void)
>  {
> @@ -480,6 +558,9 @@ void test_attach_probe(void)
>         if (test__start_subtest("dup-sym-link"))
>                 test_attach_probe_dup_sym(PROBE_ATTACH_MODE_LINK);
>
> +       if (test__start_subtest("dup-sym-workaround"))
> +               test_attach_probe_dup_sym_workaround();
> +
>         if (test__start_subtest("auto"))
>                 test_attach_probe_auto(skel);
>         if (test__start_subtest("kprobe-sleepable"))
> --
> 2.52.0
>
>
>
>
> >
> > Andrey
> >
> >
> >> [...]
>
