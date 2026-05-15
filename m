Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9A30569A
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887676; cv=pass; b=Yb61bHoEDwbGKwj/SGv6k0VTjo2ytw3nJz8qBK3LXq7qaKDPJoYlSiEFiTm5nKIoVm7lB+OwZzEqDMi3PD5DWcEnJrtl8KVEq/CqkNamZMz0sGwGshuXoDWnO9ZFZillFK8YMeXeaLN+5CrRNJFJZWwKTO+lUArhf4LbeawT328=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887676; c=relaxed/simple;
	bh=YwWC4WFrkmp2ONYjnJoQn8j2jErDcE/QFo/5x5YPLwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLrnQrwdI66RoBFtIpo1Jul8d4sxkPeoUAvpzXVwsB7HIuyw/20NPNItTrd+kUos9vjzpHPzhe0dDo9kbxfxXPVMyNmxP6fxDEXEdEs11UGiSFWlQQIbbY2AHMldVzyN3SoKnSu/qFYevfUXGat/6H2UlpGw67KsgkWzLJ97h/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G9yLbqKo; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G9yLbqKo"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b46da8c48eso875ad.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 16:27:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778887675; cv=none;
        d=google.com; s=arc-20240605;
        b=a1RfcjYXH+KYVF/GGyb46R0U1yOwkxRkoWj9JXFMaXW0qqKKJADg0VMyAUCCKb1lHv
         1rAcTh+MAsJdaYCYM0ZMFwYSRy6ox/Mk8RcifoqvolVRN8x7bNJHBl4ljLMeuDc1ocWx
         gbPWJ0moS314xvKSMzEY9+aOl/Q7nbfCM5rCkCAxjhgVt1ZlMqbQm6Q6yN2EUXiSj9mC
         2ZR/C9KiuNEiFdjT0vV/RCFw2Lqc433XwDPG9YGWgnP59yIvO8Rg3Gn7UbwUXMIO6WTx
         IJk25g3DkDgjLyP+pijRNvppLicfyifGjvW6nba4DzBXX6VD0ne8Y6lF5dRBJec78NrK
         setw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XU6/qLMq0pTyP8x21lr53W/CjJX1qRINA5YR5iUfpIY=;
        fh=fAUcOLMJrL6/gSlJAi6JxZuXRW8JDI9oXae6bn18h+k=;
        b=aoSlkJ0SNXJrW2w9cTSdmXsWmLk/eU7pEI2TWQ3iCgWythIsV+1vEJKJkf1l7bBWE9
         c9rvfdXray+QkZ20MVV1H1m2cdKBeR+1YbDmcUOU8+LQzhH8KM0k6hRGNyHZNHHG5xO0
         1KrkTc1lrcjzoYb3U/dcYrzK3clCPOqqgaN8TtTawNVGQ5KwU4osG8vlmkvGZzbJicZc
         sE73LnJkAVEOt++rRcNEXqVv/kRUEMkQV740/dcPVq7+rTvU8w3+ex6r60+9qXb4GBnw
         A24mnGkBfJ/cDkry0mQcDCNOkPjpm7OmCnZejbaG4CVmyxEjaxaYgzR1TNgy5J9LdQG+
         tILg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778887675; x=1779492475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XU6/qLMq0pTyP8x21lr53W/CjJX1qRINA5YR5iUfpIY=;
        b=G9yLbqKofRAeoIhYzNvT+HnabE6pPgN6lrb58BSked20tQcEBWAubJy2ipACGMwcO7
         bfFqyDwKJA95jekdg8vCv0q61BZIPC0LP/VvZdmzVZtXcATpbbgVAo5IpdjONrgvdpBL
         eASTQujWok/U8SUcspWYMCKGKmL/3j8q8p6hNnxtCCPeU22+vnSZOm3mcYl1QUR6oEpI
         7rFUH7rMxXHneLthzUq34/Ey3zZCsu3WR0NChDi5WZNzjXGGvuEz5gHdcc6Jqtb08OnI
         PNx72xFwR7NXhP1KXIyAgV9haQyGyMtOq1kWPVryI/dKPUWzmo4f43hAOZKXgX03D0oV
         7hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778887675; x=1779492475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XU6/qLMq0pTyP8x21lr53W/CjJX1qRINA5YR5iUfpIY=;
        b=n2tvJDPzm1GBJ3mSHIsqaChQXr/esZ+IWohSSz+/8x0T/mhnCHMaGtqFvD55wQaOuj
         etYvB2dcGxBRrAdzT8Rshv6GVj9rG281tABep6De1NwshbzINmjmpcJRjGnyPia3SOHl
         EsVX/b5iFw0p/1RrU/g2/OIjCDjqaYfzpw6isM0nnmBERLY+16bMZ7baqJjSyqLBOgmc
         AekfQEBu71SvGADbRik0WguRS2h9fDZx7EVJfMosHk4awiq7aRebxAL2sanhQwIM7W0g
         8FG0sYlL60GK7Q9Tl4OX9U5PqRIFz6URnu5HUIqDX6BqyjgYf5Qx1Fa1kNZ8Te5zj0L/
         mFfA==
X-Gm-Message-State: AOJu0YzSFqk20xs1N8dUjrr9d/2HDpmWiZBnZ7Ra37DoNX7a6mmpXiJh
	G2Scy/Kay3SgWpaO+nMpx730ptmKqOpVGeyeFfEANheK3vwjMMpNabl45W4iPvJ3Jxgyhsw57WZ
	ZDNymkVvNgvg79x+2H6qkYwkiE7ytCL+QMKgRFxCN
X-Gm-Gg: Acq92OGqXt8zrjBhTmCrzPJeuneT81c/XP7yjRcdwKOD9qyrwe7ifn2OR0UBDqfAi/X
	PiVG6WookeFvkpLadAUdYQjVb5ZIgcr008YvvL7i8ffH1vEDc9/lxezcwJE6kIUM7oOZSBuVUAs
	4zJbrlki5Pkdv4N8N9W29MG6qjLK1oWrCusZR89I74Hc1bzW7rw4y18WzTOTeAbwjcKAJzUsc4E
	eJ+tp3zY9LT1tHYPOe9XjS9lRN7P93wKbwuQzBD9Q9tpVcGT3rg/KBqvo5ZWY6FDIBc3iFVOroD
	Yktxoi9zy4BZ0hsKIvc=
X-Received: by 2002:a17:903:2312:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2bda0deeaffmr1117315ad.2.1778887674217; Fri, 15 May 2026
 16:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515193314.1593560-9-irogers@google.com> <20260515195302.B0AD5C2BCB0@smtp.kernel.org>
In-Reply-To: <20260515195302.B0AD5C2BCB0@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 15 May 2026 16:27:42 -0700
X-Gm-Features: AVHnY4JgeNjpXX7_zw_F_IFv0Az7NoDc8QDwKILAiMbLPJlzNoJdyG58uLM06zg
Message-ID: <CAP-5=fVnZXqsoeh_4+uxHyyVeOer-zMiSTh-nbbihDR1HgEZig@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] perf build: Move libsymbol dependency out of
 prepare step
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 12:53=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Removing `$(LIBSYMBOL)` from the `prepare` step breaks the `make =
check` target and manual object file compilation (e.g., `make util/symbol.o=
`).
> --
>
> commit 6df47358116c567d6b28b1ca848835d2f69dc679
> Author: Ian Rogers <irogers@google.com>
>
> perf build: Move libsymbol dependency out of prepare step
>
> This commit moves the libsymbol dependency out of the prepare step and in=
to
> the dependencies for the bench and util libraries to reduce serialization
> during the build.
>
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 876065a02de6f..96a68723109fc 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
>
> [ ... ]
>
> > @@ -637,8 +637,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE \
> >       bpf-skel-prepare \
> >       $(LIBAPI) \
> >       $(LIBPERF) \
> > -     $(LIBSUBCMD) \
> > -     $(LIBSYMBOL)
> > +     $(LIBSUBCMD)
>
> Could removing $(LIBSYMBOL) from the prepare step introduce a regression =
for
> the make check target and manual object file compilation?
>
> Both the make check target and the generic object fallback rules, such as
> make util/symbol.o, depend exclusively on the prepare target:
>
> check: prepare
>         if sparse; \
> ...
>
> $(OUTPUT)%.o: %.c prepare FORCE
>         $(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=3D$(buil=
d-dir) $@
>
> Previously, prepare triggered the $(LIBSYMBOL) target, which installed
> required libsymbol headers like <symbol/kallsyms.h>.
>
> By removing this dependency, are we no longer guaranteed to have the
> necessary headers installed when running make check or manually building
> object files from a clean tree?
>
> It appears this could cause them to fail with a 'No such file or director=
y'
> error when processing files that include libsymbol headers.

It would, so the user shouldn't do this, they should just use regular
targets like "all" or build these targets incrementally after running
an "all" build. Putting the target on these rules would be equivalent
to putting it back in the prepare step.

Thanks,
Ian

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515193314.15=
93560-1-irogers@google.com?part=3D8
