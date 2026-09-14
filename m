Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419AE48382D
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789401285; cv=pass; b=R5DFhaOSVFc3dzWuBjF6rCjGf48I6+kIKD9r7mD3ezeXgLFK5M5UovnT23CF4p/6XugogGLoiAaU+xeHmhl9H9ZAJP6ZUiEaroYne6sf4Lw+0jsuRR5DIkKQufTR/toXhiGslA6gg9YxLgLcYEW9sPXKM3ThP0XJKxWD2hYMih0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789401285; c=relaxed/simple;
	bh=At+UlZvZYws1S6SVUpZI7s8IcqYthzS0+I2yS2ftiVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIWTeyC+nTkwdF/1TDhJgeb1v/8jQOSO8HZMpmOtJehs8JRzb9mfUJElid+xyZEEqWuqKqt6bSbHr0CqVLUZbJV6xrF3JVvlzqm+p8Y0nupcrTqB4dif5cFdzsoXRXfkkXDKITf0k20xB+997kQSdamQ2zoXv7+I/qBxRKcO7J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPTL2+l4; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPTL2+l4"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb752so2269443a91.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 08:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789401283; cv=none;
        d=google.com; s=arc-20260327;
        b=e5vy3cxi2E/icxjcESHT3CCK5/9IgIGi70XiQeTf0BcKvy3kFuCgczRVPiDtXnzOaa
         g+obE57cGzcV3roXJdRkw1xLRJYCAxoxDhdlwuA/gol2xV1lPLm2ux43yq1HUXjSYa3d
         xcCBoAAGARXrqhCJqgVzxdFssY9oJYek4o2sVeCJ6Wvye6JSkzXVa5dy8K2AdQuLYRxY
         juuMmV5wArqX2mRLrIPI6rM3fiTLqYXxXFpYiiVDisjob5KvwxinuTFgDTcpIsJEyqbg
         evGKmW3BPp4SzVPOgvRi0ms+NfmWtEpAzPV23pf5ZoUgeySK/CRmoW/2qNogYbssfRHJ
         TrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OfcglKcM1GpEqcbtOpR+TcD/aIKqCYwa5Tjibw79wBg=;
        fh=1UtBZlvMSndr6WRsxCPgbgneZEc+/UUSCiFYC4CU0Rw=;
        b=qLed5U+h3TnCS0dgL+omYbaUaxxgb3SypmLCrcpFYS7DRo0RKTuptExWBrdBwFgJpi
         rD6wEgTg06N6cYyQ7Mb5i2l53NppE4P1ZrAT7j8wBlpElSDYEeb5CWLlAuF/hlRNyoUr
         734K7WugG+9yao8sKXWJhJs38e2sZ7LwZ2OZVYpqRnhq9YTys+IzDw86ZxFv7BfiSK19
         VYNqELwfYCgwzOdLYzCaNaKkOtyqZ1c8SQO6L2/XZBDUXXxzN3xM0HCKA1iDKYxaEY2k
         q7P/9GePmFbozEMXFhtojVM25+Qqpzt3gw4KU6vmyehozdUJolL47GGGku+zS98H0k6f
         tRog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789401283; x=1790006083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OfcglKcM1GpEqcbtOpR+TcD/aIKqCYwa5Tjibw79wBg=;
        b=gPTL2+l4grK0QQp1U5e9oDp+fJ6TOKWtYPAfpChvXjzWrPjKLzt4tg+qLjp87+GvU6
         eHO8BmAhHPVnD0oRTnpP0DwSG1/H0sucB576szvQlYBeloFrS4WKziscgHGQ25UA+dsj
         3uagq1hzNHLA/5X4h1hR1ecu5R+8VjX+nzCzpCIzlmTpm7OYIXidWKjkt1C/xYQSDHd8
         XaluDtX7emH9/pN5GWrHtRartpVpVZZ/r696cxztmKwXfOceDxtFDIrPbtNhQSIWoeEh
         kHaTZWfpZkfynB8FzKzrjkBf0zsurQIk9CaH+MtzCpcJDlhRWesh0x7AwtXepE1EJ+SA
         1lAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789401283; x=1790006083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OfcglKcM1GpEqcbtOpR+TcD/aIKqCYwa5Tjibw79wBg=;
        b=YLe3Gzh6g8nGZg2MC5bSEjBonN9t0enb4j64hth9ULsOM/Dg1YAzepI3t5Fn2/64bH
         TiExrQUGA2TCdrXqOasFEfHKnE3cEdt3wtr5npw9aNT84QnadiMwIpmvSe0TSJJrk1th
         r59hezY90JTKtd54xv6Gkna7wuummX6rrZxkjWiSFYWVJJuUF7gf/9gkVTOSxwYOeFBO
         2RtynIyzQYvogrSvzLbEqeU3u92C6xd31qP8+bW/wF0yaoQ4DT8Q7i46EZIAXY/qgvGW
         p5aVNwpl9WUIjlFrfykZpKh8oN+ZVAxwAufbcDVxN+hop2qU8pNtaP/qrCWNqFtBoXVR
         BTzA==
X-Gm-Message-State: AFuF++nlx7HOFwX+yejnYBKIgiZE/F2O5hL6ptn8oanC3tr+0AslATxD
	qXzGb5pR4K28ps/eJxTap8NMegb4WisMRBLRkTA5AWVbSXfaeFgWwtNYblAMTc2JWmnIj2RDP8Y
	dpb86Y1O0dBsRq5wrgUJW+XKvkYE4klw=
X-Gm-Gg: AYBFou3Wt+F6HihJejQ1kTgCRgiyCRFKKvSefZPvDMBnCIGatrYen/peQ8EHXvM+TVD
	SlpHyRNEj0l53gaZGmth83ubs2EBjAXTCAWl8ArxNGFPp+X0tesZjDFKGDeC2GvqaKgnDouJbUz
	jCm/oTRpSZIeg1WaKRAzADKLZgRrPYILN/2UCPy4ETzks4s6bch8UUGHChs3oINQ+Evv+cw0e8/
	bwp3FehehjU91MragcSNjxHf28fSBKc3dURs73uQ3cjZxhuvMWKj0FNpfw8AjQjtpNyAaBhIiB6
	30CCkdXPHENbIorZhHDsIFwemRlyzB6sJXAMj8qG74sY5f5VtI7uLmyDcaNo6rvDo1C73NR7fzl
	jh/gAX0vppmt+xwgjbkF5e10gXAA3En3gnsApN5VGxVfmEzQXy3x8
X-Received: by 2002:a17:90b:380c:b0:398:a2ed:7b5c with SMTP id
 98e67ed59e1d1-39dec148a36mr5885691a91.24.1789401283417; Mon, 14 Sep 2026
 08:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911120820.46900-1-zhaofuyu@vivo.com> <20260911120820.46900-2-zhaofuyu@vivo.com>
 <CAEf4BzYkY3ehPGei5Ra2xUJZHu-JcKLfPOuKeo3Ckks8w=OrEQ@mail.gmail.com> <0eb56403-6782-4126-b660-c5504ec35232@vivo.com>
In-Reply-To: <0eb56403-6782-4126-b660-c5504ec35232@vivo.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Sep 2026 08:54:27 -0700
X-Gm-Features: AcwNN1UeF4lQtRHo8SYT9jW85DnMyuNtZlMQHdYD2iwprUgD8r8lUo05o3sL-Sg
Message-ID: <CAEf4BzY=nuvYTytWXCBXZAR+nDdzynhDdj4cmRO+v+0jazLWmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, alan.maguire@oracle.com, 
	olsajiri@gmail.com, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 9:22=E2=80=AFPM Fuyu Zhao <zhaofuyu@vivo.com> wrote=
:
>
>
>
> On 9/12/2026 3:18 AM, Andrii Nakryiko wrote:
> > On Fri, Sep 11, 2026 at 5:08=E2=80=AFAM Fuyu Zhao <zhaofuyu@vivo.com> w=
rote:
> >>
> >> Add btf_module_allowlist and btf_module_allowlist_cnt fields to
> >> bpf_object_open_opts to limit which kernel module BTFs libbpf is
> >> allowed to load.
> >>
> >> When the option is not specified, the existing behavior remains
> >> unchanged. An explicitly specified empty allowlist prevents libbpf fro=
m
> >> consulting any kernel module BTFs.
> >>
> >> The allowlist limits which kernel module BTFs libbpf will consult
> >> wherever module BTF might be needed.
> >>
> >> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> >> Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
> >> ---
> >>  tools/lib/bpf/libbpf.c | 72 +++++++++++++++++++++++++++++++++++++++++=
-
> >>  tools/lib/bpf/libbpf.h | 16 +++++++++-
> >>  2 files changed, 86 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index c036e8a91ed8..4ab7ddc3b4cc 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -751,6 +751,8 @@ struct bpf_object {
> >>         bool btf_modules_loaded;
> >>         size_t btf_module_cnt;
> >>         size_t btf_module_cap;
> >> +       char **btf_module_allowlist;
> >> +       int btf_module_allowlist_cnt;
> >
> > please use size_T for this count, just like other counts (both
> > internally in bpf_object and in public UAPI opts struct)
> >
> >
> > other than that, looks good, I was about to apply before that `int j`
> > in bpf_object__close() caught my attention
> >
> > pw-bot: cr
> >
>
> Hi Andrii,
>
> I also felt that using `int` for `btf_module_allowlist_cnt` looked a bit
> out of place. But it does allow us to cleanly represent the three
> states -1, 0, and >0 for no list, an empty list, and a specified list,
> respectively, as we discussed previously [1]. An additional benefit is
> that all subsequent checks can rely only on `btf_module_allowlist_cnt`,
> which keeps the code more consistent.
>
> With `size_t`, maybe we could use `SIZE_MAX` to represent the no-list
> case. But I'm not sure if that's preferable, as the count would then
> carry both the list size and the state of whether the option was
> specified. Or is there a better way?

use size_t in UAPI (in opts struct), check that the value is no larger
than SIZE_MAX (-EINVAL otherwise), then just use ssize_t internally
and preserve -1 as marker of "no list"?

>
> [1] https://lore.kernel.org/bpf/CAEf4BzaHTTEob-vmhmcRt1pmED+eBBLWnehEDUk=
=3Dt7O7GUyyFg@mail.gmail.com/
>
> Thanks,
> Fuyu
>
> >>
> >>         /* optional log settings passed to BPF_BTF_LOAD and BPF_PROG_L=
OAD commands */
> >>         char *log_buf;
> >
> > [...]
> >
> >>         err =3D bpf_object__elf_init(obj);
> >>         err =3D err ? : bpf_object__elf_collect(obj);
> >>         err =3D err ? : bpf_object__collect_externs(obj);
> >> @@ -9626,6 +9691,7 @@ static void bpf_map__destroy(struct bpf_map *map=
)
> >>  void bpf_object__close(struct bpf_object *obj)
> >>  {
> >>         size_t i;
> >> +       int j;
> >
> > you don't need j with count defined as size_t
> >
> >>
> >>         if (IS_ERR_OR_NULL(obj))
> >>                 return;
> >
> > [...]
>
