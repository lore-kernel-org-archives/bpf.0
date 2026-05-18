Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41A83845B7
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125973; cv=pass; b=kRO8WN+AmKhnNtkgxtio3fpeZvIKC9U+ZQTBWJQrJwpPTlwcbRJFAlRkWHmbxquyKAQVYz/pXvNF5WK5mq+o6PUzZjdb6s4ogsTNlzy7+5cOzm2jsIQWU5W1nBuszDGSqRxt6nGVLMKRVSPqBKEIjw/eUnewZzAjJJf494/kKoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125973; c=relaxed/simple;
	bh=aPWQJbWILXW2i3R+ONWIGBZsXGofUidSdKL6B/NJEWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gttXrpwZPfhW51RVuIqbg4brZ1ekPhazX7NCCTkAfOZj2pLW8xpVH9ZeXngN3GHTl40TFmtmh4P25jRwcPV2KeDQtgc8s9rdNMV9EFEQhJU3QW6RBnR0++YhRzHbruB8/skXxSWqOuqKuWMXlP0WwWU6tJfyP5ePEOapW34v/Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7VqZKdS; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7VqZKdS"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b4583f0a1aso15815675ad.3
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 10:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779125971; cv=none;
        d=google.com; s=arc-20240605;
        b=FMOG0N1JTJ98yrtq9tLn9o4zsI4njNWyBL7YlcsTR8zpzTraEOUqTOORasKIg8WrZV
         /oML/aMvLXzQhgJE+nZ60HPqr9bzi4bsKDrS2JPlSyT60kGO+5Bfb/7o+EWM4fD+cNSX
         w47MTLg/TW1R2PNeVu3Jk7PsUsKBvYu/G4XnLnsSXEGvOQjIOiFfY1vERS009yC5mYWO
         1G8vy7PaXYXLdvk2wbfjkBP/QB2+9FvbMmjnYASYy7Ksf9+PICdNwiiKamPyQaVm9sJi
         G/ncr3UEJ0pebkPiG/sEX2pcbAeTjW7rwyRXdq7oyDZjiRrerG+DU5xk/PEy1+MN1hF4
         LkaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HHqCGvY/O+5u0ZmGB0C5bqEKmgKCYPaaY1uI1EEOomQ=;
        fh=liNlH8YFlBMiHyhCD2QGjq0c7lfsWcBYoKtoWR7l8OY=;
        b=dDvWe1GFrvrYMBuB/H6zZww6VB20WvD15rAJFZt9glhBbW7X211DS0bWWH7O4Md8Vi
         xIr3ZxhZpb1oyY4AkADzIzctrhF9HAnySLEYB9Kvhu/DM3AT7URELv6ofLiq1amTzDrX
         o0RbLj9yEvKDPgRlia4nndNGmE0cgy+jIeJCxoEdJObssviD9C5Wkfeug7xZpP3K/VEh
         rj4+jtgU445Oj8fYARtEZzWdCaAh2dU2xEjYy2DF3/tT1L8ZYOaQ+9Kl01AUu7HT4l5s
         LZwGDYxDNfvodMW374zPNlXkxfbPmAErkOE249iV/BbWfgCAzLvf99euLgXFACTjJF7B
         9/uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779125971; x=1779730771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHqCGvY/O+5u0ZmGB0C5bqEKmgKCYPaaY1uI1EEOomQ=;
        b=W7VqZKdS2CN9mICv4m1zVnAdM+2/OVPHWmkS3XNjD9AYhfLWcreiGQDYkVXMceTGCc
         r2Hvah/qK4JFBXuVPUbJpiTpVGo/nYvO3ng2LH//V12Qgcp5cPQzGFq1qSYYPz30i/g0
         aIa8pRQ83qT6trLUF+xz05yM11bx4EtM3c2wQxfBvb9mFhJg2XnngN0b8tU4ItJJDX0L
         uLioIhJvcPjL8/aJl5CMWwt0fizqbBl1i/om4URsZazHS0P5lao/JzB8szvYst2woonQ
         uHg3Qg9XeqAg1ieFDkBOzEe7YX8C4IVZxCNnceQ9lyddnP93pq8qvlj7zzJMVGsKb3PM
         fJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779125971; x=1779730771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HHqCGvY/O+5u0ZmGB0C5bqEKmgKCYPaaY1uI1EEOomQ=;
        b=SQUtdsAUU0k6u+41l1uT6AoKupos8qrTctDWKj6g+2VQmdf9vggSykd9axx/aqDBg7
         ilnkvD1jT+xU/cdBHN9G/nhRzxFtXdAywbk35gPzQcUhajtcyiGUtzJ/NDEFEKJKbW93
         aygMqzdHV3RRApEOZGlV0wMYNRHcUmPtRv4+dBCwqHbHIEadUM23iUukcgt6R/TG4orE
         ODP4G7vDzxfwEqTylLARE2isfkK2muk1UXa8erRGNDyPAF4PSSRxg8lSdSRB5yjDsxE8
         Zbv8bYk5WHao+8QsLZv4VuYkfUviN4ueyGMAl0c043YMg01ESOjzVkK3ezvBCdx6M9L6
         GUvA==
X-Forwarded-Encrypted: i=1; AFNElJ+zypKzs7ntwIGLwLgYsNSsAqazGUb9nYS7QVtSAaRGXgLeDqGBLBB08IJXfnOlchLRGzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37DwMqkS8TfmuUXmdE4/mwrUYhfrFXNkT3Cnv0pJuwOucSJIt
	JOdKA5YA8jEm9S6azPCiQQJAYF0Zklw+u/JAr/qnoFQdnJQThphrC3s5ck5s7hJxPBOITR4MYyr
	RcANKr8j4VHzF1PFxu3FnugeUq9pZELQ=
X-Gm-Gg: Acq92OET86vx6RZoEujyXQjY3gxT21YMx/F/8V4w/Upn0rjYUm2g65iG/4tomfWvQpg
	cxZ8P0C7KT1/hWwybjEW6JaZVXxAFp9AkX753ZouJLuEdPlRw1XuVfGJVIy3CChvvrdG/PF8Xex
	DIzVCTdHEVp1nXVIWkgtfyb1rFUNZtQcWpHxGITvgGkYZ/iVNNwZoAg+OjUdjaXwGr50u/T5hkV
	8nIfw5byX4T10EohsFXh1d8g+P5+T3egruwp1Zz45kwCREa7rmuMPc/JpDwJo4jMIDof0x+4VRa
	aRB3hd5YXtFa5uSScQG1hXs=
X-Received: by 2002:a17:902:d502:b0:2bd:9b0f:5f2e with SMTP id
 d9443c01a7336-2bd9b0f60d2mr137231485ad.22.1779125971257; Mon, 18 May 2026
 10:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518105957.123445-1-jolsa@kernel.org> <20260518105957.123445-6-jolsa@kernel.org>
In-Reply-To: <20260518105957.123445-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 May 2026 10:39:16 -0700
X-Gm-Features: AVHnY4IfzfH4rplKUJQ-s69e9XK7XipwV-1i2Q2kkUCiJKoRdqL4LE_RrV-IPP0
Message-ID: <CAEf4BzbzjCuWM2=g4U68sFsegpyU3CchscratkTjuWG4Q53XMQ@mail.gmail.com>
Subject: Re: [PATCHv2 05/11] libbpf: Detect uprobe syscall with new error
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 4:00=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> In the previous optimized uprobe fix we changed the syscall
> error used for its detection from ENXIO to EPROTO.
>
> Changing related probe_uprobe_syscall detection check.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Fixes: 05738da0efa1 ("libbpf: Add uprobe syscall feature detection")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/features.c                                | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>

sashiko is wrong, this change is correct (we do not want to attempt
sys_uprobe optimization if -ENXIO is returned from broken kernels)

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b7e388f99d0b..e5641fa60163 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -577,10 +577,10 @@ static int probe_ldimm64_full_range_off(int token_f=
d)
>  static int probe_uprobe_syscall(int token_fd)
>  {
>         /*
> -        * If kernel supports uprobe() syscall, it will return -ENXIO whe=
n called
> +        * If kernel supports uprobe() syscall, it will return -EPROTO wh=
en called
>          * from the outside of a kernel-generated uprobe trampoline.
>          */
> -       return syscall(__NR_uprobe) < 0 && errno =3D=3D ENXIO;
> +       return syscall(__NR_uprobe) < 0 && errno =3D=3D EPROTO;
>  }
>  #else
>  static int probe_uprobe_syscall(int token_fd)
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 955a37751b52..c944136252c6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -762,7 +762,7 @@ static void test_uprobe_error(void)
>         long err =3D syscall(__NR_uprobe);
>
>         ASSERT_EQ(err, -1, "error");
> -       ASSERT_EQ(errno, ENXIO, "errno");
> +       ASSERT_EQ(errno, EPROTO, "errno");
>  }
>
>  static void __test_uprobe_syscall(void)
> --
> 2.53.0
>
