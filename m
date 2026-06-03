Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C08C38425A
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530384; cv=pass; b=ujkwtEMiCLjKiT+U96FRQ3EhdPM6IpWNWavOokalsusYWuiK0USsxGEoFpYi8DTPfCrgV3hi/ZJEVRk6luKKKethRZ/lfFXoDC8ejlJ9ofh/tQ2suG8m9Da1dNrbw+0hy8rLTPIVJ1QyUmmbiGqmRv8hCYu2+CYPqbbPpAMfXEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530384; c=relaxed/simple;
	bh=2OsX9xrQkx5Cw7QY9LKXYujkkjGcngs8n91bjdXwvg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVNN001PUuTzavIONca2Wd3RwSWZLo1ZLTyGlAzAg9w/JKGkll+VwMNXSDl8xHXsv/bvLp4g0XyWM3+YvbD3dlJTPhqENhLqx9a5QrpE+11lCstJx7jAheGoGO9p5v/830dgg1BQaq0WLrxViOx1AmlMk1+SpD046z8H63ckWHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoTGy5n+; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoTGy5n+"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36bcbd7821fso29925a91.2
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 16:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780530383; cv=none;
        d=google.com; s=arc-20240605;
        b=coSg4WoTvk1uXfAMc9TIKZkOnFpjzsYoXp6v8ejI26RyRnjnfBUk1gqrh9FwLKYyFg
         k7vpi9N9Dzxjhkx8lhPkgBn6wjzOguCMzuNLH28LMcwGaOOYzN0aoGsY8OUoVIxnJg2S
         dBqt1bIUgKIw30mDR4PUcfgXRDk+aZNUYjKy+g2seC/N3pJGpm6Wkgx2zKEPQXcRKbrE
         3a2IkGqn0sG3G1FcSpIJLrhFyGFiVplfthGVxpT0h3/a+8uHnaQhWjnmCAxUOCSNei89
         jCXJmKUlBgOsXKR+5g6tpssuqwb7AQBMyDx1dTtMiSM2CM7iG9WCbTRnnAzFT7y+jp7E
         kJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oDqq79L2KNI1fcXdkS7SY6qPxkZmqKsIeFSaYmJ87+I=;
        fh=i4HnEZXeGjFJlwU9D+6X4d3xBefB+z6SYzHG5fckG+w=;
        b=GXIrBXjsRrvbN7L/XaOGLndVxJEp20LU5DG5U1hKAfIZtMKKMGHXJw0+pBtGLUCllB
         JXn5Xr+3Mcj3HtE/hTqX15d7wCmxf/Qy0p0Ehv1gilT0GRCtXfdv0xd0LhVbZJg+HfSW
         FRPDp+OT0TYfOehbPLA+W9LzqEQOgI4aRLOP7hvaTc8/mEXruoV3ZsF7v8LyIJ9KtbXt
         /R9uKaQ1mAodWGWweWZ1+RtdGRH/hVl6uXHYU9o4kglux/wfXJgObODzglbTzwo9fSXl
         zI4ujJFeW76D5ltcI+v2SZEJi8Ej/qecLD9R9bmH1KA4We2C16kfyiBqq0jWnuM8qg9N
         EZRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780530383; x=1781135183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDqq79L2KNI1fcXdkS7SY6qPxkZmqKsIeFSaYmJ87+I=;
        b=PoTGy5n+ne9RqA617+Xq9bMfQYfLLOLuh6K53Aid5WquiqR9NJcEXoGPO5snv6b+xe
         TCYrBsJiYDIhv67L0GtulbsavVHAT72bQPXOjlIDyVuetKmkwJd3m6SyyhVzEP+KdX6D
         ptvVXIyn9nxYZzHC1MB8BqR+jrX8IdnxxRNz0eq5bDDxeL9WyxjTuD8R1K3B7oGrB/L1
         bUFUyEjZr1sIIgUuTAeU1QsvyJUFOyAfKkHvueYh30Jsn4fAIYB7SOZwsaC7p9mc1I1o
         hRKVb7dvOQBNj3xzAygupO3DuqbTq1i8KABSTc7Zwgbd0oVJuPkPq/7T/k2P6b1PbZ1W
         HcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780530383; x=1781135183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDqq79L2KNI1fcXdkS7SY6qPxkZmqKsIeFSaYmJ87+I=;
        b=EL2bdxqnmneJj3Jq6WWVsagDRihzoM4xAaFjv20yu4t6cck9/7g+Rr2212U3tXWee5
         inFYLtChftyA1rpjR/vIoJUnGmcq60WMrFme3w9aLONA31cyeb2LUJVLJnqhe8s51Y3y
         6R6EqhKLJ/NupiQNOg8FcW9B7UyUEvyOcU0ht8JqPFQYf1JoGZ/0narQ4wT7Dio9t75b
         HDaMqc/T5j+2bJfkF7bTbdBNVIbg9Up33p1w19S7p9NZ9A8RiIW6VoUqhWKgsoqEXeVJ
         5VBL+/zNK4jLekElH1Mdu15m3S8uSoKykMHCOToKh8tHLTPASNWgHJouu0tbHRbPKMun
         8AFw==
X-Forwarded-Encrypted: i=1; AFNElJ9eHZD+yVhtCUu13xEeduc7XG6xmIuse1K33qPAp3i7YOEdat+bN+XTZVKcOyOL8upA86U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhrp1OBgcbwqTdJ7KwfXXrIRw6udH8yiq4ppOjmGWwe9s7f5qz
	+wXygqi6dxZxZF2Hv/kVLDKjSIPLyx4AFNdSNKv74cCsZuSxX0jBBcfp1yS7rtRc27fj/TW+04r
	JYYCntQ9gcANnRezY0ixvG2TcFgEpVvr8Fg==
X-Gm-Gg: Acq92OF997J01QgJsFw0RUv4GilziBqcunk4nhQ7JT1+ca+G6oVIVCr5yt5WQRzyine
	PNF1l2wbzG8QRkZpziWZX3f0IsQ9l5k9L7OVD5nMnnQdX+PKFYjI7CjRZH5gwSvhDKxl3NyhWo8
	d8wmc2zY4s6onOsCKQnOyYw2XzTkTVY3q63XCleMVjArT93ZDPdG513wmw9clB9D7o183KgX7uJ
	WZce6q+gZrndk2HRXQPHjQazExzyBqTucJF8LO9tKp2OLi1gsXS0QQyvPfZnFCJkpfotSwMuS1A
	Dg1ddevO5D3qjvJbbn3Ij1CFo5jjeVQbZgIGEf3xBCTPNCrCf/Ebidnm2QZJ3Y8Wsj9ujB42F4Q
	=
X-Received: by 2002:a17:90b:55c5:b0:36d:bc21:4ae1 with SMTP id
 98e67ed59e1d1-36e33ba4a37mr5389366a91.27.1780530382688; Wed, 03 Jun 2026
 16:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <20260601221805.821394-7-ihor.solodrai@linux.dev> <ah8-6CNIHPCJxAOM@krava> <3ba6ed89-82b3-4dbb-99d4-5e34e496fc33@linux.dev>
In-Reply-To: <3ba6ed89-82b3-4dbb-99d4-5e34e496fc33@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jun 2026 16:45:45 -0700
X-Gm-Features: AVHnY4J5wyC2MeMT_qZAFOzQr-pOLtU2IeLlkAkvBiLJsMe6_YTKdKXFgXdBid8
Message-ID: <CAEf4Bzaq5w33tqNwXeSbi0FoP2q6qSEnyZqWoY2RwUzs_M+sEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 06/14] resolve_btfids: Discover kfuncs from
 BTF ID sets
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 2:09=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 6/2/26 1:36 PM, Jiri Olsa wrote:
> > On Mon, Jun 01, 2026 at 03:17:57PM -0700, Ihor Solodrai wrote:
> >> collect_kfuncs() currently uses bpf_kfunc decl tags to identify the
> >> list of kfuncs. The decl tags are generated by pahole, which makes
> >> current implementation implicitly rely on those tags being generated.
> >>
> >> The authoritative source, used by the the BPF verifier for kfunc
> >> registration, of functions being BPF kfuncs are
> >> BTF_KFUNCS_START()/END() declarations. These are BTF_ID_SET8 under the
> >> hood. Currently resolve_btfids reads kfunc flags from these sets, and
> >> populates them with BTF IDs.
> >>
> >> Implement kfunc discovery from BTF_ID_SET8 symbols in resolve_btfids,
> >> removing the dependency on pahole's emmission of decl tags.
> >>
> >> Walk BTF_ID_KIND_SET8 sets, and use the address-to-symbol index to
> >> look up set entry's BTF_ID symbol name (before .BTF_ids is patched),
> >> recording the paired flags directly. This makes find_kfunc_flags()
> >> helper unnecessary, so it's removed.
> >>
> >> Kernel functions can appear in more than one set, which is legitimate,
> >> since kfunc sets are prog-type dependent in the kernel. So for btf2btf
> >> processing deduplicate kfuncs by BTF ID, accumulate (OR) the flags,
> >> and warn on flags mismatch to catch inconsistent declarations.
> >>
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> ---
> >>  tools/bpf/resolve_btfids/main.c | 122 ++++++++++++++-----------------=
-
> >>  1 file changed, 55 insertions(+), 67 deletions(-)
> >>
> >> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfid=
s/main.c
> >> index 43512af13148..d35a7b2460e8 100644
> >> --- a/tools/bpf/resolve_btfids/main.c
> >> +++ b/tools/bpf/resolve_btfids/main.c
> >> @@ -970,6 +970,23 @@ static int push_kfunc(struct btf2btf_context *ctx=
, struct kfunc *kfunc)
> >>      struct kfunc *arr =3D ctx->kfuncs;
> >>      u32 cap =3D ctx->max_kfuncs;
> >>
> >> +    /*
> >> +     * A kfunc can be listed in multiple BTF ID sets.
> >> +     * In this case, dedup by btf_id and accumulate kfunc flags.
> >> +     */
> >> +    for (u32 i =3D 0; i < ctx->nr_kfuncs; i++) {
> >> +            if (ctx->kfuncs[i].btf_id !=3D kfunc->btf_id)
> >> +                    continue;
> >> +
> >> +            if (ctx->kfuncs[i].flags !=3D kfunc->flags) {
> >> +                    pr_err("WARN: resolve_btfids: inconsistent flags =
for kfunc %s: 0x%x !=3D 0x%x\n",
> >> +                           kfunc->name, ctx->kfuncs[i].flags, kfunc->=
flags);
> >> +                    warnings++;
> >> +            }
> >
> > hit few of those
> >
> > WARN: resolve_btfids: inconsistent flags for kfunc hid_bpf_allocate_con=
text: 0x5 !=3D 0x25
> > WARN: resolve_btfids: inconsistent flags for kfunc hid_bpf_release_cont=
ext: 0x2 !=3D 0x22
> > WARN: resolve_btfids: inconsistent flags for kfunc hid_bpf_hw_request: =
0x0 !=3D 0x20
> > WARN: resolve_btfids: inconsistent flags for kfunc hid_bpf_hw_output_re=
port: 0x0 !=3D 0x20
> > WARN: resolve_btfids: inconsistent flags for kfunc hid_bpf_input_report=
: 0x0 !=3D 0x20
> >
> > I'd think flags like KF_SLEEPABLE might vary in different sets for the =
same kfunc,
> > IIUC you don't need to use KF_SLEEPABLE for syscall hook, because sysca=
ll programs
> > are already sleepable.. not sure there are other examples
>
> That's a good point.
>
> I think from the PoV of resolve_btfids what matters is the mismatch of
> flags that trigger BTF changes, like KF_IMPLICIT_ARGS. We could check for
> the specific flags here, or filter out acceptable inconsistencies (KF_SLE=
EPABLE).
>
> Any other ideas?

I'd only collect and check inconsistency of flags we care about (and
those should be consistent) and ignore the rest.

>
> >
> > jirka
>
