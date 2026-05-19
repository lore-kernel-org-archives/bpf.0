Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38EC376475
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216927; cv=pass; b=BmX1v0l4Uw6hmsbseVCbzbhWobVAfmkPcXGVufLFssfUyWmwTIZoWT8n17ZFXdF6Bg3+6Ut+HJUstLrfCWG+u4D2wQDGAY51JCyZw1tJ5eEz8hLeiJ/990zfhzqVbxHc/vL5M2OfOCd5nZue/q0/7U33gG1rr5/Gy+5c3m2h5CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216927; c=relaxed/simple;
	bh=7jJuTFyxIQFgGbFSaoiVo+0a3X/OYWa6i6xQj0whl7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUgzNpUDGgHp5sDGkmxWAMWHSuz50t8wqH5naXJr1D8Li+8+pUaonJtjfN7nzzSfZkCcS+v1p8EikSNVvtW9tijyGoDEPv6pm5zdiSz/aa3csvCWBSmXMG/zade3+d5SrmV7tyls7DABgaO0UUNWi/xvApyFv4XuLVBNznM5EFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i9Kthbg8; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i9Kthbg8"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so305ad.0
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 11:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216924; cv=none;
        d=google.com; s=arc-20240605;
        b=BriUg3EA7x4wPLDEZQHD7fLv8bjDAa+XswohvckTwm3/QroTGhzjs43PXWa2ZtZei+
         vz5UiJKb5dCdD5X+3gwSEp+UXPqpGbmw82uWpp73Yx9jbK1Qpzh5iXwcQNeCXXMwo5I0
         KkAPXuKiis5EdMI8mmGyi/PIcSwFax9TtOjiWln72hsDX4tbe3MI8C/9eCI7bxdohJdq
         rva2amwgt2c5Dfw0UthK7M1myKZ4kpTwdppPDM1jty43nADXVNC76FZwEwvBJ0gtdfdb
         lJMDSZGJCvyZHlPB7k6rX3LP3vjBHV6IiijRvJujW55Pv7vUWmJ0xlgQTDkDenElF/52
         F+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pQ3Jvwmd3/jYVoY+5T+/jl2kd+9Tp3/RpWPQ69jbyeo=;
        fh=MfBtCu1zZyzKXq5b1U95+j6ewR+6c3xgss88oOL+8Pk=;
        b=ccsm0uH1ajEjixo7lGjkfGrIZlTAkVEGk716u5O6Sp1/jaeVJnKqyZqeAvBE15WgXs
         k9QRJvRIz+ZYEqVoCssDRyzg7kFkG12bey3LXSRsYJ4WQmlxZwwI2vsfEeP9l3Kf2C7s
         Kl0i1wTkSg0eAF25V6ftjOGX49cPMv4ODuX+DfSNolMQd6PzXv/8xW7MmKOsfcjgMYm/
         Z3EvibFDFT4Ujo/bw8lJLyGece2vpQQuhm+uUWxi3tC9QNf0MA4WinqX6/NfmUkQh1tY
         UZ8W9RaUm5AtItSFOWfEX9bW/agmwv3LpdQlihCySA7/yZ50oLJwmn7tI/hyxq00OJNj
         mwMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779216924; x=1779821724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ3Jvwmd3/jYVoY+5T+/jl2kd+9Tp3/RpWPQ69jbyeo=;
        b=i9Kthbg87uGSj60qNgX++RI5HMot2mTo3Z80iB6m5FOj0vdvFLe7BuCS7ZS8KGawiq
         lJId5S1ibyfqKS0qyYnf37u+KESGNRRj91238j93W2ptP0dEmJxunzy87oV0dtmO6B+d
         XVFf8YTxVP2oUgGbrwdUs5oOJCxdROc2JlpozFST32x4Nb4Y3NoM6NdTEZOxZdhYndr0
         AK4g3OjtiZ/Z/2HBg1thGhNicI8pTk+dI7iwXSzg8wRAH2+ournVmExK7FzjJgx3wNUp
         +VtdzzbSW0ZqGzgsQzMVwEAGozV2vp//HxoEhg2KOgSdZaH71FElFrP2C8fCD1HiR82A
         BJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216924; x=1779821724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQ3Jvwmd3/jYVoY+5T+/jl2kd+9Tp3/RpWPQ69jbyeo=;
        b=IQoIXXi4fJONcVWwMIhVEPKQoBMBNRbnzLQp7NfWo0uq3XCvUQf1I3nshe79POF84g
         gQca/OB3qUuUTd3qbA9uONpwnAGL48/Q6v8eHKpsVJAtpN0/GovBHfIT6swzAPfOD3SH
         Vp18Uj1rB6xn+JLEzos8tNdmXYiLp+2ru2Yydf8lDLbnzw5HjEcNnQVWNFFSre5OenQI
         mtLuwgX5tfYCzH1SncGCLCmiqOanDmrONEWrDk5OBkqrq0pML8V2MRsrZT4UuOvVGzsh
         YLe1oQ7G2nXcKIDLepFq5CTw+AJUHn9GXQeEFb2wNEKBauGP5Rj3GdyIPZRlrS1i6V2F
         VIKA==
X-Forwarded-Encrypted: i=1; AFNElJ/8si3KpWhdNRDffOYSEiIcR9YneH7K8cXdGPN6N+7r0nyT8okeptAyIZ3gHJqpmmzT9V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrIwrUiJRu4q0DI8YGcoP4Hqtv1FEmhPOAktHba7m3W9CP9W+n
	ZVC/SqcpKYxsUUy0rz+wuK9RVDFVPXHT0nb5bGCZrbb94FQYFLENf8A77GyYGtUuu2bunWu4NO7
	6sSVObfiioLsEbI2P8li2p9GWaOm+1P9sFiA4L/l5
X-Gm-Gg: Acq92OGl3ZakkHpFIoWpFYE15Kek83ovLJ3QIi0+pFUIU2GkR3OML7/NVgPVEdlN0aI
	B9sjaKkkav1RqcT9MrVKN2BaRYlfECql70hsR7fs0CnKBFzqar2OKs+6gd8Sdtkk8TpRMB+Q51i
	ZflHBXOyY3a+zvdRqaZLWn/ytTP/Z5QFPsZ78GjCP4Ygd01+duD7QlWHEf3ppUbLzQkD+hdP6B+
	JWlQnBnQLNWIVEpQunrMeKnhuVeVJG6XbfW7xYBn5xxc3CakluRbC7BmX7YH6xvi++ymdfFkSZR
	OJMDaWfGve6Z9SV9jOTwvSQlPpW7MtiH/AuPuSb7BXN4gswK
X-Received: by 2002:a17:903:2f03:b0:2bd:6727:d689 with SMTP id
 d9443c01a7336-2bdb03a2b85mr7785775ad.12.1779216923701; Tue, 19 May 2026
 11:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519185154.2987285-1-florian.fainelli@broadcom.com>
In-Reply-To: <20260519185154.2987285-1-florian.fainelli@broadcom.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 May 2026 11:55:12 -0700
X-Gm-Features: AVHnY4JlPZT2y2KVD2Jea3uptVn6tXWN7jpuqmjhnpWHibNi0RSzYBZXKWi7G-M
Message-ID: <CAP-5=fUuhNRj2Dwz9FmMnWKwXjM3RCFV1oQKO4e3X20EOHstEg@mail.gmail.com>
Subject: Re: [PATCH stable 6.1 0/3] perf build fixes
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>, "open list:BPF [MISC]" <bpf@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:51=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> This patch series contains "perf" build fixes specific to 6.1. We have
> seen occasional build failures in our CI looking like these:
>
> util/parse-events-bison.c: In function 'yy_symbol_print':
> util/parse-events-bison.c:901: error: unterminated #if
>   901 | #if YYDEBUG
>       |
> util/parse-events-bison.c:1020:62: error: '_p' undeclared (first use in t=
his function)
>  1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _par=
se_state, scanner);
>       |                                                              ^~
> util/parse-events-bison.c:1020:62: note: each undeclared identifier is re=
ported only once for each function it appears in
> util/parse-events-bison.c:1020:64: error: expected ')' at end of input
>  1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _par=
se_state, scanner);
>       |                         ~                                      ^
>       |                                                                )
>  1021 |   YYFPRINTF (yyo, ")");
>       |
> util/parse-events-bison.c:1020:3: error: too few arguments to function 'y=
y_symbol_value_print'
>  1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _par=
se_state, scanner);
>       |   ^~~~~~~~~~~~~~~~~~~~~
> util/parse-events-bison.c:991:1: note: declared here
>   991 | yy_symbol_value_print (FILE *yyo,
>       | ^~~~~~~~~~~~~~~~~~~~~
>
> which are resolved by these patches.

Lgtm, but the changes should be unnecessary as perf from Linux 7.1
should run on Linux 6.1 and with more and better features.

Thanks,
Ian

> Ian Rogers (3):
>   perf build: Conditionally define NDEBUG
>   perf parse-events: Make YYDEBUG dependent on doing a debug build
>   perf build: Disable fewer bison warnings
>
>  tools/perf/Makefile.config     |  1 +
>  tools/perf/util/Build          | 12 ++++++++----
>  tools/perf/util/expr.y         |  4 +++-
>  tools/perf/util/parse-events.y |  3 +++
>  tools/perf/util/pmu.y          |  3 +++
>  5 files changed, 18 insertions(+), 5 deletions(-)
>
> --
> 2.34.1
>
