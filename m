Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189552FE578
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064056; cv=pass; b=r+kE9cmqmSDH/1rOO4N8cPk9rQSn2knmehVdqbeTWE51aS9EBxVP/q5JsE74NaSTk918CFUSKUlWTaUbZelgKQvZVJpisZ8bPPh256zouIOs5IRx6cxON3DOmsn/jhnA2ZzqGtcXTVL+4ABgx/idiAdVSUsj+b/fSw0zMasRgRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064056; c=relaxed/simple;
	bh=jfXmnznKLJiTPbD5h8TXzPoCYSLFywcnZTDixTwqnvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvYcPj0TsWgCRbnUffbFnEkbjs5NIqL/+cK2YbNgHb1lT8CIYXqmnpPOKpiYNgLKFZ3uvliYK3u1a2OZpUaTxt+v3H65N7UaPf5RRktXaY2GheIVXpCoTGDXnkX15oKZ9nAQMHpPM+go+4d0oGnfg8Vk41q2ZCjWIjIa3LOGfqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i35lvgzw; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i35lvgzw"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso255068a12.0
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 12:27:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770064053; cv=none;
        d=google.com; s=arc-20240605;
        b=HiYWG/ag5hJfuwGXL2pMYaEdWfW8dCemyqktbq0/usngJCkBvX3cfmOz3rtbE/poAD
         OzQ8XYSjJY6fB0b2Uj8y0eIfKX/vOdtCJ0AkPTXvrEJPWxTEw1pIZpIr/dHLvA8GkbZ3
         r9XILxHto1YrSMxdTuY6tXXfT8CkTbepqKUl6njZlEhptxlxIRlXCqkTBSQDa3cJ3lcE
         b2tlYpuadId8/cBa6xq5fCi6HSTOz14yWzRdRxe9WNFU94ZywxCbxLpMXYPGsZI79VnQ
         Frbv622GGelax+LTNsNePzQ+BY5hSgHQ9+qh6TkUR+0PHYOCXlWOtm73xla3FUb59eNj
         XRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tVRk+zilHW9UjKLQgTp2UA+pwv3RE3RSIRFfK1s01Ps=;
        fh=TO7HN6/Q0ffzn2080nEMdCm99CF9sQRWdH4SzUfi95s=;
        b=kwNpfl4sQ7HoaZ2NpB80XPK96AnWfEgcNjrNa9w2PMUWMt6J66qhv3go1lfJyTwuNE
         1UvowGj1PiqMYiR5YU2dKYPuptVx2s6EEQL4XrGDVm16U2Z/I4rsi4BmQty6XL5sSgjO
         MvvwEgfcX31C23B2Vum98zeyXEy/eGl8yKq9sAkzTKv51VX/D8Yh9qxkcYUraIF7PVay
         2kt54y2AASvry0IicMU72Fc5345CdNmsHwB5zyo7ApfUTCx2OuZvFRymJMKdpph7Qh4f
         MaDWMeBCPLFCOIado2/nBpeSqddElezhyV968/VmbPyKoeX7WQcNR1CsljJeDDfKczAm
         VJ5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770064053; x=1770668853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVRk+zilHW9UjKLQgTp2UA+pwv3RE3RSIRFfK1s01Ps=;
        b=i35lvgzw+EpxLEACaPBJPib1skMRWoVPBETG80k2waGjMfR0bvTZjqFY4pJKbGWn5E
         5z5qZlpRY0MUjIuDeqPiYZ5mJsYcukgBq4FlMWsg5BlznYf+Tb5OQV5igiNXwUBcKK8h
         WanbW26nVcvkhzR6FzEL08DsaIBY1+GGPt4MZnGjaXjCQNR37xzJoWZal2rtGXPrqIhH
         YTiFolGNtNFzwocVne0qhe4Glb8NUm+b4eM48yuDO8eM0RLgYVgm3aCewqU8C3vJdBRp
         aumxQz3314vbyn9SMtuvn8s8DXlZfqEzcjauhwS7efbvBqHQVb8mQ9U15CmJgt116OhL
         xI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770064053; x=1770668853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tVRk+zilHW9UjKLQgTp2UA+pwv3RE3RSIRFfK1s01Ps=;
        b=JNm+zu63FouwTae/WZZOtXaIbIZu6Yk+C7eauZMcwpwQM6y0BlbZzTxEOR8J1LUcCr
         6DEj/k41uVtogfu8JL3z1Lt2YTOCF9lKae0W4rlNrV+9HpwavTngIuGeIxd2uu4klOYi
         Uz2Tn044hswSZ9S4fD3ik9EPY8dM1HmmebruMx7Oven26rqKi2SHfcYomg+2KZhottuC
         uLIHN6Qh/z8txYQ2SG+2tsBZAhfvjWih6oUZJMvjF9+mhQFfM3TGUcBZOCHD1DpNrubC
         VVgL1wsJtxbSHgG/jkcP22MzIO2kL1REF5DeFl6B7B70j4lTxfDc5mdQxPj/UwYJ+4DO
         Rr1g==
X-Forwarded-Encrypted: i=1; AJvYcCWwZFPMO8NKE/OBT+GBvUqT+j3pGVQcm6j+kCKZuyAH6rurQXoAifLp8xhrQYLefZ2o3Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9NZm+5bBxc3wF12Wnm53HP0H4a0XR5BpZugIMbB13KcOOBwu
	PakTU8Ay3OSLK97lJbpNc7C5wh1bFqpUFvjAfCZFPgTt/yItr+LK2HWUXjZmGhcQRHeMloCEULs
	asOGfNc5S1SiPD/FqnpD0dW/UKZTrUdfPD6lphLsI
X-Gm-Gg: AZuq6aKK7hNF0z63poGmfY4IDj6hRsaET4S8WxShQ5ZcGxC+udVXQk38UCRjGik31/1
	uqRzCDnPSg2YpD+rq236LvBaBP+JwQAoy5ZeIPvgJ6Jy5twAZH++1lwmRYt2fkem7DKplUy/K4a
	8LXRrAaCBY8Mg3vvS01g7EWPPLSxBFtQ2ijh4o41Dulrqa1UhOV6vh/W1zKjuRvZ+9tSw0YFMtP
	LAgkIg8Bd2lP0kSUSjiHJjKtGXugKCrCGy7sBMA2/aXwcr4+lr6VQnsO/5bAbGJEl4RhtuUWHIL
	abrH79ygv8Dc5QhRjB+5WmH9x3HTRayXHXAI
X-Received: by 2002:a17:907:7252:b0:b8e:380:5669 with SMTP id
 a640c23a62f3a-b8e83909daamr46612566b.32.1770064053184; Mon, 02 Feb 2026
 12:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124012133.2451708-4-wusamuel@google.com> <9f904e57ca365036b12263b0d0a06b915e6090631df159d17f4e8a9651c1f5ff@mail.kernel.org>
In-Reply-To: <9f904e57ca365036b12263b0d0a06b915e6090631df159d17f4e8a9651c1f5ff@mail.kernel.org>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 2 Feb 2026 12:27:21 -0800
X-Gm-Features: AZwV_Qg29xnGZqAdFJeszWEWENOogIq3Hn6LIMQK7pgNDZsdLvyvbyvFqAYEMNc
Message-ID: <CAG2KctpjRWiLEur+27JZZ0bftDfBLj-dy6TA79iLYk-DQfr2MQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Add tests for wakeup_sources
To: bot+bpf-ci@kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 5:50=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.=
c b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
> > new file mode 100644
> > index 000000000000..c8a38717e284
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
>
> [ ... ]
>
> > +static int get_ws_iter_stream(struct wakeup_source_iter *skel, int *it=
er_fd,
> > +                           FILE **iter_file)
> > +{
> > +     *iter_fd =3D bpf_iter_create(
> > +                     bpf_link__fd(skel->links.wakeup_source_collector)=
);
> > +     if (!ASSERT_OK_FD(*iter_fd, "iter_create"))
> > +             return -1;
> > +
> > +     *iter_file =3D fdopen(*iter_fd, "r");
> > +     if (!ASSERT_OK_PTR(*iter_file, "fdopen"))
> > +             return -1;
> > +
> > +     return 0;
> > +}
>
> If bpf_iter_create() fails above, get_ws_iter_stream() returns -1 without
> writing to *iter_file.
>

This should be fine, if the BPF iter file isn't created, we will not
write to that file.

> > +static void subtest_ws_iter_check_active_count(struct wakeup_source_it=
er *skel)
> > +{
>
> [ ... ]
>
> > +     char *line =3D NULL;
> > +     bool found_ws =3D false;
> > +     FILE *iter_file =3D NULL;
> > +     int iter_fd =3D -1;
>
> This function correctly initializes iter_file and iter_fd before calling
> get_ws_iter_stream().
>
> [ ... ]
>
> > +}
> > +
> > +static void subtest_ws_iter_check_sleep_times(struct wakeup_source_ite=
r *skel)
> > +{
> > +     bool found_test_ws =3D false;
> > +     struct WakeupSourceInfo ws_info;
> > +     char *line =3D NULL;
> > +     FILE *iter_file;
> > +     int iter_fd;
>
> In contrast to subtest_ws_iter_check_active_count(), iter_file and iter_f=
d
> are not initialized here.
>

Ack, this is important and I can address it in the v4 of the patch.

> > +
> > +     if (get_ws_iter_stream(skel, &iter_fd, &iter_file))
> > +             goto cleanup;
>
> [ ... ]
>
> > +cleanup:
> > +     if (iter_file)
> > +             fclose(iter_file);
> > +     else if (iter_fd >=3D 0)
> > +             close(iter_fd);
> > +}
>
> If get_ws_iter_stream() fails at bpf_iter_create(), can this access
> uninitialized iter_file and iter_fd? The cleanup code would then evaluate
> garbage values, potentially calling fclose() with an invalid pointer.
>

Correct, and this issue will be fixed when the variables are
initialized as pointed out in the previous comment.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/213068=
80863
