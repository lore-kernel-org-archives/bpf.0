Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE553ECBFA
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814197; cv=pass; b=XOmiu/3y35GhqU0pB9yo8+x5mCki2G3IsNJVm9hLhTPwvfgRCs0SxFtyVqubE3aPri8IHKZesjx4H/p2frPHS4rJsSdnkHoqqXn/GTDpf/8ipDUliLyQuJBlGWVkJw/VJDxR+aJi1qfp3M6ly9Kic9Ki00QDIlckfJo8bRHFbOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814197; c=relaxed/simple;
	bh=E/Xa+pTtUNuDjXToPX+yJs9XlDJoS5vuypV0mhzO+EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXA2U8yIo8AsQfxCMgYJ9Ggbr8ZGOP8s7mfeH+9lw68/4E4OKtTlOzXuc10P6ud4UNOG11O9F5inh6M/hwlpiHzhqQp3zNUEjgK2ipHNJ79GCeUPSApRSZxatyxllLzkcq3g22Ngk0WY+htKw69oFEOozXwcx4/U2Pg7FJh0jvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8z6WUVW; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8z6WUVW"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so5199631f8f.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 08:23:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772814194; cv=none;
        d=google.com; s=arc-20240605;
        b=NtAegQm9knfSqQMb3Gx/C3B3eIESB4WV/vcRheZCZczl33OrkxGT/FJUJtTP4wvj94
         D1cJRirYWMjR7D6QdNnlQkr9iOcOfNwlvelqPqqR/DwXx5HckomUy7xLlhKYWX2ARp2E
         TSZE1iXvFBFF8Jf6GvxWw7aTLfyapptNPEAqGAdYJkYVxYoDaSRlXghhJ3gcBZ6ReZeU
         Yk8MbBjkf7ydmVDErMpFv7SrCZ/Tkjd8iWLinsCJr0E/NgYb88oKjlBIM3R/jtvcj7vF
         RuUIYR07Kz1R9wqHp3beZoh/6kxzSoo4POiTBEOI+5c3zMtK+9skJH+fGBecxB3202BU
         KT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NHNJbialCaBae1uOW6Ql3IxVQre6+XHxHMvhFYwju24=;
        fh=6gtAjqsPgegIAPuI7kCSSK+wbLzNEJD3q4ayc+4nxWo=;
        b=Wt4WreYCXhUTZu7FdrpSMsVlKEptalJyG47p9g8eU3LadqgqHQtNbOZ/ph5pL8w2bC
         XijDEXDPbfiBtZyPH40lHiRLqq67svs2TDJWNoiBKiTVUlMXl/CohNb4oP1JTE9NEpq1
         mY7SQYZMtu0uxa8uPQhkNrrDPECGXPdG1xN6AqZVDNOrNxlsuLffm8WeA1Ur6rsrJ145
         oEfzzbXLNkKVh7U1ao7o1mRU+792BK2984y2R7iDz5TyskTlvx8GLdv3d1R1sgugdwhd
         580s/NstQDLqy/TBEGpTy0y2k26PZvfghdI4oTPpUG9NeEVSvIzoIvEM9jNXrzWgJaAF
         SBDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772814194; x=1773418994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHNJbialCaBae1uOW6Ql3IxVQre6+XHxHMvhFYwju24=;
        b=N8z6WUVWy3L/pXn2xzInLG55wBTbPlFxEhKZhyHQgHCWM/GrHMzIsFz9B4hNWYGlLn
         nnX0d7VTFryOSAllAFqqS7n8py4xoTYWgvD/CybS1kYdMgWDKG2jf4OosJ/YjZQ8uhpx
         TZ9tvNiJEwE257f8OGAnx5gieCbrYTlkUgZfKVJO5FjYbj3tjbv2O700Cd33r53mOv3V
         o+ItVrHeDev1yXuqrYzKHYQRYkpaPsfa9QiB00k66vjr1nIpKzb/YFf+KDw5jyDWW6BL
         i4NvfdNsudn+DO7t9W1oF1VIS6QiPBfJlnhltQXncPaW3DnrYcEdQmId/6cYV1Xk8Sj9
         5trA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772814194; x=1773418994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NHNJbialCaBae1uOW6Ql3IxVQre6+XHxHMvhFYwju24=;
        b=CfrjxXXrPY7x0UuhpYl1JTPvo9z2Rs9Bfa0u1dta5aq3afLNYM4r5gh6xloPHXNFlG
         7UQdkzN//EpkpgEVgt0S/pxb3le8SM7T/IlgtKj1qNrDWO3wqlAVJm+XbI1r1jlsfmfa
         Rdz8YwkIoApcqWL9IzLgrY/2RdyDetgCpNcFVXwEV7F/xHsmKvO2rfbH2nQnxsiNU+DU
         hqW9cdkOVRZbi1n8OUe3avBE9ciOEw/HtzdQlGtva0G8chr6lHG5BA76z3Nza4Ef5QqI
         cQDDNp3GakYuItRuhsUmcejAgZ9ShXMghqUKSBOWqjHoD9kcuDfjbxq4b4jttQi/Hfp9
         Lq1w==
X-Forwarded-Encrypted: i=1; AJvYcCX1wWVH7ENBJ6qijoha3lsFX3FN7jeN2GfmD+GTZUhzGLl/hFLmDAmom2d+dIdKk1wpbpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOwBpL6A8mEos3QhVzQk56AqaNDcaKNzkB+j288oGFWyRYgYWK
	YTEaO6OUq6Mp9APK9ChuAGXTIcc8df+boZA4WdiOWN2bulHSir5vuhSzv44fWrBuiLj4WLrGYIX
	J5aG2npRY0vIxms7Iqc6XiDb0MhgQhW4YfIqu
X-Gm-Gg: ATEYQzy73zj4AnncVXPI+YJCXpuxe1BgnWgbXrf4pVE51+ADgSYKRvhRvQENuw7B8+f
	/GUKh+aqfRmv9Wa1vwQ1d8nblDjpn0nc3a1B6iZuJ6PoBV2VPQGgYnz6mlIMPN6te/HJObUhdsK
	zNrmLpswy6j/HNw85g7ujF5zuP3yaBgKWz086FyPCwRVQn96gl3ZY2w6d9IhUafSUhNbmFIDiEf
	MJVRaKehbpTEPKEfDXBDuYqmV5xwrd9Z4p3kGH8td2zzb9IoP3bHSX+cagKVOhCps2tHzjZfQuc
	yRHSRaKWPIcHc2XI5u1B8b7QLIs/IUzVoDaoj4pGyAq2W/AI6UfiLUd1iR8+VLJCcvlDUYaRYsV
	5dNkF2iE1JqMP4ZLJpdZySyFkhA==
X-Received: by 2002:a05:6000:3112:b0:439:b624:5ce1 with SMTP id
 ffacd0b85a97d-439da8808d6mr4708394f8f.33.1772814193914; Fri, 06 Mar 2026
 08:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306120024.1032301-1-sun.jian.kdev@gmail.com> <aar9gzh7QVhezeII@Tunnel>
In-Reply-To: <aar9gzh7QVhezeII@Tunnel>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Mar 2026 08:23:02 -0800
X-Gm-Features: AaiRm50LS9hNbcAD33uTMCrJjnjzS4fbWjdxYYFD4OEreg5HEvkmEYUQ056GEic
Message-ID: <CAADnVQJtG9s1CV-qeF8NSgi_UFPgahOXtB3PWiivBooAYC69GA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: avoid jump seq limit in verif_scale_pyperf600
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Sun Jian <sun.jian.kdev@gmail.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 8:15=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail.c=
om> wrote:
>
> On Fri, Mar 06, 2026 at 08:00:24PM +0800, Sun Jian wrote:
> > pyperf600 is a verifier scale test. With newer LLVM, calling __on_event=
()
> > twice can push the generated program over the verifier jump sequence
> > complexity limit (8192), failing with:
> >
> >   The sequence of 8193 jumps is too complex.
> >
> > Let pyperf600 provide its own on_event() that calls __on_event() once, =
and
> > guard the shared wrapper accordingly. Other pyperf600 variants are
> > unaffected.
> >
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >
> > v2:
> >   - Drop runtime -E2BIG skip; instead tweak pyperf600 program source to=
 avoid
> >     hitting the verifier jump sequence complexity limit.
> >   - verif_scale_pyperf600 now passes; other pyperf600 variants unchange=
d.
> >
> >  tools/testing/selftests/bpf/progs/pyperf.h    | 4 +++-
> >  tools/testing/selftests/bpf/progs/pyperf600.c | 7 +++++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing=
/selftests/bpf/progs/pyperf.h
> > index 86484f07e1d1..c02c49c52c77 100644
> > --- a/tools/testing/selftests/bpf/progs/pyperf.h
> > +++ b/tools/testing/selftests/bpf/progs/pyperf.h
> > @@ -343,8 +343,9 @@ int __on_event(struct bpf_raw_tracepoint_args *ctx)
> >       return 0;
> >  }
> >
> > +#ifndef PYPERF_CUSTOM_ON_EVENT
> >  SEC("raw_tracepoint/kfree_skb")
> > -int on_event(struct bpf_raw_tracepoint_args* ctx)
> > +int on_event(struct bpf_raw_tracepoint_args *ctx)
> >  {
> >       int ret =3D 0;
> >       ret |=3D __on_event(ctx);
> > @@ -354,5 +355,6 @@ int on_event(struct bpf_raw_tracepoint_args* ctx)
> >       ret |=3D __on_event(ctx);
> >       return ret;
> >  }
> > +#endif
> >
> >  char _license[] SEC("license") =3D "GPL";
> > diff --git a/tools/testing/selftests/bpf/progs/pyperf600.c b/tools/test=
ing/selftests/bpf/progs/pyperf600.c
> > index ce1aa5189cc4..31e8a422d804 100644
> > --- a/tools/testing/selftests/bpf/progs/pyperf600.c
> > +++ b/tools/testing/selftests/bpf/progs/pyperf600.c
> > @@ -9,4 +9,11 @@
> >   * the loop will still execute 600 times.
> >   */
> >  #define UNROLL_COUNT 150
> > +#define PYPERF_CUSTOM_ON_EVENT
> >  #include "pyperf.h"
> > +
> > +SEC("raw_tracepoint/kfree_skb")
> > +int on_event(struct bpf_raw_tracepoint_args *ctx)
> > +{
> > +     return __on_event(ctx);
> > +}
>
> I'm not sure I like this approach. It feels like the 600 in pyperf600
> wouldn't really be comparable to the 600 or the 180 in other test cases
> since they wouldn't correspond to the same program (yours in five times
> shorter). A low-effort alternative would be to tweak STACK_MAX_LEN and
> UNROLL_COUNT, but I only managed to make that work by reducing
> STACK_MAX_LEN to 180 and then I guess there isn't much difference with
> pyperf180 :(

+1

Sun Jian,
I asked to do a _minimal_ tweak to pyperf600.
What you did is a drastic change. Pls don't hack tests
just to make them pass. The tests have to be meaningful
and test coverage shouldn't degrade.

pw-bot: cr
