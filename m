Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD884CB8C9
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154838; cv=pass; b=otZco+WZZfOBIaiF6ToFql407X7PAnT4grfaY8R7AeUZ0ebdfUR4tvWQj5s3R1M2F+o87oFKeVRObUmBef+UgfnGUCU1m5/NW3Nsq/pE8QIUuJF0EUHM5/4mFufuidhjXk8QAhDmYG/YsguOeYJRCcuXRqTvwCM+Uru4EP83Ik8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154838; c=relaxed/simple;
	bh=iY6+Zin828BJjnJazjv6iEdlZ1WQ1OB501bXh0Oqe1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFOmrdvLbhh1sRj7NFX54z0bXWKDwOT25p/UBZPNyL0yLjwnewrz9PE564wvOAvsSivh/Y3BQURbaM7EKS3EH/nyBaehYdUQw0hTlEiBQJvIINWJIPNlbVK3NpvX0EBXDuWZHOJPQO8VDqONHhRE2lCkZi6o+e0V24y1tumyj78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r833c/1g; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r833c/1g"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea75so37752a91.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 12:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789154836; cv=none;
        d=google.com; s=arc-20260327;
        b=atKoY1fakLt2a09mu6C4HyeBURE13Bqvz1k6Pv0MM2yRtrBILk5ZH5S28nYxVJfd8y
         JfKNpngJTPJWNvMIlO21jpencIT0VdGvULbTVJaGOoMJktSA/N7o8otFDwNm58Lhbj6O
         c+q/uYILugeNiM7c+DyZVLkD1MTn3ngvPoffbzQvLkitSxNof0qUVNOkePgp7FQSCfMz
         9/n5EP3CkVyd7RUF/YOSmlR3s9evSJrkf8wNFSvtLUlnZfkA9ffmEUongVO/71Z82cOd
         y8bDoKlGlYQVBzhv9pRTmm0+s5kaKdI6ntnN3UqMHhF9KjjHfgdJZ4sZv9hRH/i+AE6i
         Zz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CJ5qRpTQWRM2qmLNECtZnQwDRdWUV4ql8mZet62Id0s=;
        fh=fbNHKAEKBY02QyBr6qJCPB+2HenG1oLtoYcSQluwGsY=;
        b=oorPrbUOC9F6WQaFNKCBiDFks7y89UMsCz/G3I1LJqhykXhM41eaasjGWa89sjy3pD
         cPFToZj4lBB0Tf6BDOw7EqCt+7XnUOh7lcAIrv3Lj9208GHxuZ8awWJM9fD8JLrFcCOB
         sXcZ2qKyk5TRCu24qLJYYtt9kBdGnZC5Qv5rZV/XDeiPtQG0WYRAsSwjwQXGOoW4Bsrt
         svpBv09UDOpLSvNioNRJ10ZP7jmcUCuntMZVihBeP/xUtTHRiMCR6xLXp9rkF8pD2rVg
         VfM66qQ/5KJMEBM7TaKjLM5Ce3/omhxCEz9dQ2T2nHoSKBlmbRNzerVygsDcPOMmQjcy
         yveg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789154836; x=1789759636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CJ5qRpTQWRM2qmLNECtZnQwDRdWUV4ql8mZet62Id0s=;
        b=r833c/1gz52GdConixD5HRGtz0K7RirHPWpLJ3Xvk6J7HyUNLTrBByK/Xi394Haga0
         bBBtZhoZbRfIa9qOmXo2FyKKdKxs/0uTLxlyaUQdhk/qVwuz8yiMsJCmXKHBnYYTGMKp
         olpd0h75BUNI/zgSNkeU4f3HwigJVqvaA4xnRRQETizmdV5Toheu2MHwVcesZlTnhLM5
         Mcc1pSm4pgsLBkQ5OzZzVrbydz4FFb3X50eLdhYhDUjrk6ird+4p5cNJCJoQvvj6dUa+
         Wx+L72s3r8oHlSJe/e+kyPvOxQ0SX1J27sDcazKY/l4Jq2PKaLwvLK00v049P4cqOpbG
         hPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789154836; x=1789759636;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CJ5qRpTQWRM2qmLNECtZnQwDRdWUV4ql8mZet62Id0s=;
        b=UA/u1FNhoIjvcMde0vkKb1FWn850pPp9BndzUTZ2sqEPAnjbetq1bJCYSqKq+dDCpK
         xzQ1xUl+NR2AN+8fBehnYn1YE9Vdrl7RbwB9p4pluuSVUhi3MN1VDgvqJ0boEhzfmJjA
         yexYUsYktrR4bANGzbMoLx3O9C+Mtt8Xawzwz3yG7t6cHJWg9GIB/wI58KMFLfrx/7Oa
         n/39x/K0zPB/pkR4cleMIvDGRuUH0zKz71YfuN0PbdkUk0mU0Rb/mq4RRut929ajMGMQ
         dmhMyLGz2e7chPKIPvoS9slVfXYNcqMB7JMxrZiauifEOJji6rP0YT3bMFsWlRekh3uo
         O9MQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDKRyxSGygDpiLyCTgFh32oCJzfJTrBuCZT6GSfcQ6dDSUQXjeTifodM0G+A90cEDhTns=@vger.kernel.org
X-Gm-Message-State: AFuF++lLuU459y8IwHBVG8nzWV80fQbKlHYxnw49rxCdrx1YBJ3plDUp
	/hZNUnWRtNzxaJvPXo8jS0OO3gssuEHfWRUsqVN3Qf0Jtt1I8IIZAu7gboPojlsQl4WeXZ4R/mq
	weRGU5qgPEiwapPh0bL8jhsKY0/RGNDs=
X-Gm-Gg: AYBFou0t2D/BiOqLz9f/ODxVBI+GOPYkt8Dvh6xDEzOwNeAAmZHUGveGBk7TctnJnI0
	FnmyPT0EkiMtYn6bYCqpluTg+4lkqJZTZElUwVyzOWbhmMQkaRnKJm4r8ztr3EZrcmNTUp5YXqL
	JhDRBxOo+HHFvXtwh1CKPlRrqf/657ODUrD3NgokY+yxO5A8jaJhCPTcaSAnAk7bYm5MuF+wy8f
	uqB8TeZijX7dNw3pwPHLtDSwkZeQxm233xxZuZNUX9ePs+kzpTlecUP/+Q3/EHJddWP1FupGLNW
	zRaMEhIh6oUnyveKXLGhSOg3MppdNUzrpGM9PD2u2WC2F9F1BmxhuVmC8Zdy1A8X+i27nYlqA65
	ZzEJtqojxrgk7sj8MASHMwVV+DR+RQZamxHxm
X-Received: by 2002:a17:90b:3eca:b0:398:ceef:edde with SMTP id
 98e67ed59e1d1-39d980f90cdmr5086059a91.15.1789154836024; Fri, 11 Sep 2026
 12:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910183222.307208-1-toke@redhat.com>
In-Reply-To: <20260910183222.307208-1-toke@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Sep 2026 12:27:02 -0700
X-Gm-Features: AcwNN1VvzA_XPWR72Irr7kq27h97s4KZM2FmB8Fff61mgZ8sLCtrR4cxw0QVVqw
Message-ID: <CAEf4BzbJsrAgVykX+JO8j5E51v9aUpGaeLKiQvc7uhzRMyKkgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] libbpf: Add bpf_program__add_flags() and bpf_program__clear_flags()
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:32=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>
> When changing BPF program flags, applications often need to just add or
> remove a single flag, without touching the existing ones. When using the
> bpf_program__set_flags() function, this requires reading the existing
> flags and doing bitwise manipulations before resetting the result, which
> is slightly awkward to do, and easy to forget.
>
> Add two new convenience helpers, bpf_program__add_flags() and
> bpf_program__clear_flags(), which wraps bpf_program__set_flags() in the
> bitwise operations required to modify flags without clobbering the
> existing ones.
>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  tools/lib/bpf/libbpf.c   | 10 ++++++++++
>  tools/lib/bpf/libbpf.h   |  6 ++++++
>  tools/lib/bpf/libbpf.map |  2 ++
>  3 files changed, 18 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c036e8a91ed8..221c4fe1fb31 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9938,6 +9938,16 @@ int bpf_program__set_flags(struct bpf_program *pro=
g, __u32 flags)
>         return 0;
>  }
>
> +int bpf_program__add_flags(struct bpf_program *prog, __u32 flags)
> +{
> +       return bpf_program__set_flags(prog, prog->prog_flags | flags);
> +}
> +
> +int bpf_program__clear_flags(struct bpf_program *prog, __u32 flags)
> +{
> +       return bpf_program__set_flags(prog, prog->prog_flags & ~flags);
> +}
> +
>  __u32 bpf_program__log_level(const struct bpf_program *prog)
>  {
>         return prog->log_level;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad571540..3932bf9cb490 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1011,6 +1011,12 @@ bpf_program__set_expected_attach_type(struct bpf_p=
rogram *prog,
>  LIBBPF_API __u32 bpf_program__flags(const struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_flags(struct bpf_program *prog, __u32 fl=
ags);
>
> +/* Convenience helpers to non-destructively add or clear the specified f=
lags
> + * instead of clobbering them as bpf_program__set_flags() does.
> + */

I don't think this is a correct format for doc comment, please follow
the pattern established by other API comments

pw-bot: cr


> +LIBBPF_API int bpf_program__add_flags(struct bpf_program *prog, __u32 fl=
ags);
> +LIBBPF_API int bpf_program__clear_flags(struct bpf_program *prog, __u32 =
flags);
> +

>  /* Per-program log level and log buffer getters/setters.
>   * See bpf_object_open_opts comments regarding log_level and log_buf
>   * interactions.
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 08ab2ea881fb..a811a1b3a085 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -458,7 +458,9 @@ LIBBPF_1.7.0 {
>
>  LIBBPF_1.8.0 {
>         global:
> +               bpf_program__add_flags;
>                 bpf_program__attach_tracing_multi;
> +               bpf_program__clear_flags;
>                 bpf_program__clone;
>                 btf__find_by_name_kind_own;
>                 btf__new_empty_opts;
> --
> 2.55.0
>
