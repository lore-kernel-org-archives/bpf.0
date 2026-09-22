Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6403E316B
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 03:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790049587; cv=pass; b=PwGfm42WSl4oyZCO9UZNkBDolpkKAx9sXhG87I2De+LJMV8dJcTZyaXtq2Llp5GZ/wIiT10pHi5m5tmB5Kw2DsUKKfx0vAYrNwetqNdhm1B/iBo/RRUbe6I0B1AMLCt04c7iVMrpWiwRaQMHrpd4mf5sPSabksw6hihJ4myTftk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790049587; c=relaxed/simple;
	bh=kuDUMkXv3afPL+EnBob0k3BsBJPNiUTO2RsSrSswm60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFCLb7KSH2vf38ra3Z/vOnCdkuozoXXnYr4f0FHwW9hZqCe6/6mY4V/10AGevmIwc9eMgZf9Ak089V82LRovHaAx+DqUAeQNJzBLplaU70GLdE1QJYpfKkY4GyzUDsth6FEkg9P8QqDNnlg8Vg3Pl6zF+qg12va2vVe7GWUx7KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eXawhaXk; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eXawhaXk"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52faa58bff5so93771cf.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 20:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790049585; cv=none;
        d=google.com; s=arc-20260327;
        b=r0XDbG4mu3Gf6oi5jUM22dwVuXY4GTSfMXGHbomquR97B8Wd8Ny+JZBZinTKLP3EI6
         va/ByftAzIfIW2v7jn8LhzOdBX5sgZUStxsY0qApPWPKGe5EzDymbpajZ1LSRD78Xcfz
         Ob/rj50NvKUPQuIBaByCTx+Z6nfq3Dpz5/onlQh7YHudlG75NLOY/5SG9HKFg712IqCM
         d+8uvsLdwWgZap0RfLc08FuzDgt/6k6GZQH9+NjdPZUuS+b7vQ7I/fQhe6u4rnMb2xhy
         s5wMdy/hYZT7Ek17YOxFcKsuGQp8XEU80A86tk0QYPNFYB+Pj6TVZQ0V9j1JwT2qxKYs
         R5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kuDUMkXv3afPL+EnBob0k3BsBJPNiUTO2RsSrSswm60=;
        fh=gqNbJDeDgQ+vLVEWPR8K69xPRbEnlL0RcadmxjQ/UpM=;
        b=U+PQtRnLX2j60VQvlARPyiHNPEbsowLgrn6/avWvA+zncWlxK/bTqZ9ePbD38gFYWS
         QJg0WeWCjosXJ+m9UGMLKay6vhk30xBQEWZxhUwevBjADXqNtHn8OHH+3KbhshFGjNAz
         Suwd0NMD6gQpjXyKg5nLQtu4B8A9wv2UeEDHsIvsWvN22TAAHtqWUcWKOTUxudms/1wg
         yjJH1ulzc61NP4ZDKxLEumDlrZoD5ZNunlsB2AwRGxtwRrVNXy8YdVGpfWzTYoiB7bQq
         6oaqLqJ7fOpvG4rCPkQt78bXSkC8HkaMg96j9YOR6U3pC4l84khgzZ1z4G7NV1fJ7aTD
         w9oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790049585; x=1790654385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kuDUMkXv3afPL+EnBob0k3BsBJPNiUTO2RsSrSswm60=;
        b=eXawhaXk94aSjo+ppLPm32o8evkbAmy13dVMyBOjTVK9AsgAgjaflgwUCgXDRYsPXH
         dUMashcU+nj/z3qHaEGcwYJVpOnEPcGRT4rQwsoKAQkJCbWjYqqiQcZVS8uIQa2b8aJk
         MFsnzlJ8/u/cKjDZOKJ+29P+IOBrHCqeR+U4TqaW9LeE3k3kGbyenYgt1AGbBGu26co9
         ORNG0Duq8LY45IJtvSuhxmSK968MKNAA/cm2pqR0KA9ZS+YFqxHk14gLa0yBwJOelSUq
         9nUk8Ze+JOvJz+NraEvklRSyZ4awNDE0hNCFJ7Dzp1BES9TsvzL56rg2tgWk/3XE4B4N
         Fy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790049585; x=1790654385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kuDUMkXv3afPL+EnBob0k3BsBJPNiUTO2RsSrSswm60=;
        b=JRJ47Yk95pQl1fXeHCXef0uSveFrl7ncCZskwzkiSylA7MgTZuJBaSDzZDDxN9BZ8L
         RiOBPV/uKVtWw6a3376mZRbcJVyLmUg1CmP3ZPCXbLEKung+CA909KthmoGeMN+TA1u2
         sqFwTn3uLOBCOyGmFdU0LHvM00NsikAM8xEMCrpB6Sv/bou+bqKzYFFXnA8njtN69ds6
         tY780Ar8ze2rxXhZNolvQfncTyMKREx/PCgs1dMmpZCvT8VOha7GwXaHbsPhC0kjKhBu
         X02NDUDUfvlYLXfN/e6pnCN4Vx041EM3EsqiPJNuDO0AnQEWWBeE/XbYTnXbiRhcWyig
         tTIg==
X-Forwarded-Encrypted: i=1; AKwUvBxp+qLH+tuZcqfVt3ItOSNDScFvneGvZGjojcd58ss6HTBCOA4BqENVn3VkJznluZ9z81k=@vger.kernel.org
X-Gm-Message-State: AFuF++l8ZDzTh8wIz6SFDZFl36aPIEGsN+hH3Mpudx626qOWLBQaBb9L
	SDUcm0r5oAxRBLOPfae8/Wp2hJstqZJwRAasJ1k7T0XUd8CyqjYO25XgPRLSBX044Us86BtfDId
	tI3DTSSOgYbvttJQJSnjDskcA4XnehIk2GXYmu+1I
X-Gm-Gg: AYBFou1bx58jtnJ1DRxTePicG2ai2dCkwbV32jMh3h0OgHK9A9UO6JvjbR9uvHpk9SW
	c9zeMRV6noQr0jSriytFssGoq7yjdRDgnGch/n7jG2mN0T9SM/5TMQoWg73O1BakrKiT6oSGK3/
	/HN4277cEKpYKl+GFsvzM08xyZW6zWIgFibl0KoHXepnwzB6rm/iasE+KZq/l+y9DoRZl+cvBye
	F4mD9/wS08hjkBChO/TwK2PKL5soiB2pCkEbkoIuK1uB4fPBRCcCdFd4vfgqXDKHX9LyxX6JEV7
	779crXX686ygnx6Bx5UyE7gwmRedGmUe2Aok/9Lt4UbyQfwzSH5omeQ0qm88xQGrPTPa87MygMr
	UdiUtSZP3R3k6QmHj7LL1XHRMCzFIO6/b2ZlQKgY=
X-Received: by 2002:a05:622a:418a:b0:532:a17b:9581 with SMTP id
 d75a77b69052e-532ddceafadmr7173951cf.3.1790049584159; Mon, 21 Sep 2026
 20:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918040919.3402577-1-tweek@google.com> <CAEf4BzaeKXEC-gBbxo36wdAGwwZxqkL6pV=oo0dke4S2BmuRmg@mail.gmail.com>
In-Reply-To: <CAEf4BzaeKXEC-gBbxo36wdAGwwZxqkL6pV=oo0dke4S2BmuRmg@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Tue, 22 Sep 2026 13:59:26 +1000
X-Gm-Features: AcwNN1VCSRgYVTkcKQ-igQWPuOPvyTYm8XckPrpz2jX0eeLC27k52LUPgeuDr5M
Message-ID: <CA+zpnLdaqv77PT=azFEzHvnwLzxYLXMkpRy0CcsKKKMgJjxayQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: Skip non-autoload programs when
 generating light skeletons
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 7:30=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 17, 2026 at 9:09=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goo=
gle.com> wrote:
> >
> > When generating a light skeleton (bpftool gen skeleton -L),
> > bpf_object__load() skips loading programs marked as non-autoload (e.g.
> > SEC("?...")), so the generated loader program only records and populate=
s
> > file descriptors for autoloaded programs.
> >
> > Previously, bpftool emitted struct bpf_prog_desc fields, link fields,
> > and attach/detach/destroy functions for all programs in the BPF object,
> > causing the loader program to store subsequent program FDs into
> > incorrect skeleton struct fields when non-autoload programs were
> > present.
> >
> > Furthermore, bpf_object__load() can update a program's autoload status
> > during preparation (e.g. for struct_ops programs when resolving kernel
> > BTF members or adjusting autoload based on map autocreate settings).
> > Move bpf_object__gen_loader() and bpf_object__load() out of gen_trace()
> > into do_skeleton() before counting programs and emitting struct fields =
so
> > that struct field declarations and attach/detach/destroy functions all
> > observe the final post-load autoload state.
> >
> > Skip programs with !bpf_program__autoload(prog) when counting programs
> > and generating progs/links struct fields as well as attach, detach, and
> > destroy functions for light skeletons.
>
> This seems like error prone behavior to me. Wouldn't it be better to
> hard fail if the BPF object has non-autoloaded BPF programs instead,
> as clearly it's not meant to be used with a light skeleton that
> doesn't support such programs? So why not emit a meaningful error and
> exit?

Thanks for the feedback. This was my first approach [1]. I think it
also makes sense. I can send an updated version that addresses
Quentin's feedback ("goto out") if that is the overall preference.

[1] https://lore.kernel.org/bpf/20260904031912.2133476-2-tweek@google.com/

>
> Or I don't know, let's teach light skeleton how to support
> non-loadable programs maybe, not sure what that would take, but worth
> considering to bridge the gap?

This is technically possible, but I'm not sure this is what we want:
it could be implemented by adding a field to struct bpf_prog_desc and
change the behaviour of the loader depending on that field. The issue
is that, for signed light skeleton, we probably want to ignore this
field (for the same reason we are already ignoring initial_value; to
keep the attested blob authoritative). In that case, we end up
silently skipping any non-autoloaded program within a signed light
skeleton. I prefer the hard fail option discussed above, or silently
skipping for all kinds of light skeletons (this patch).

Thanks
