Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6AF2E62B3
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771317717; cv=pass; b=e6ZnqSU4x0ccRHubEb0mJJoDhMnJqJ+IoN6RxJzW86F5ZQOGudi9WRJfDML69E/MlTu4YvEDWy9f/qWcncMuP71/KY+FLK4EuDRjsf4pbcPYsc7Sjza2vDOZ7N4m4EEvM+s9DcuZf8gADYtAxju9JUKoSi4VtfF0Q7Fg/RFNrjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771317717; c=relaxed/simple;
	bh=sr6l2sn/cCWgbkqXNE2elTu4FxZydQ8A6+cup3YppOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+y5MKNVXIztrSch+OiXKnLbQ4jVkCtgZcFCyNf1/ssz5aJxWNEi2Y+fdK1Tpjieys40omR4xzrqQq5QHMB6aif3JJbHzfB2/DnQPc1nmPgC/k5EiywUzfUq9SeGIR5M/HHzG3YJl5yiVac+uUmXBxVaq2IJPxD3F6sVu8RDMak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbICgqJV; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbICgqJV"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-797ab169454so26784377b3.3
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 00:41:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771317715; cv=none;
        d=google.com; s=arc-20240605;
        b=esNgwtAPVUlI+QRlt4p6p4gw82XosJ8DMX87LbfB3re4ueB5aDBhLqJ3mIDpJunEQM
         6P1oEfB2ijGRIVbNvrDY9wuN2Fl0r8w4JcWSZVmVQ9wlruySLFYXfSvqc/yfAdSQjGj1
         XWK1GuTpOUpozOJSD7+hKwB1pUkKaNgym2zhCfFTY6Ks1GKq3nYRKgm5BlaKgks55/9m
         2JeGtAuiSByp7zCwoBoHp+g80X5PYD4boU9lkhB4MvImE9MbpSXPAwXTJ+PSqPbM0gMw
         P6bh5lhhfpXE9zuS5d/LF+apqrmSKa776aT9l4JQuFh6RJFDJrdYyb+Kev+F9u6peQup
         OLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y89n+th7tnE5Z/5/sRNue21/CtYhyjB+0dCF1kUQxSE=;
        fh=kiQzwcDKSoCVJzHBWfbIo8uY7HQUZQbQ2opCh219ra0=;
        b=eutQWOlBC+Ow1GLgCn45rZ+oHQ6pawpyNasFQ6+X5nbhRsVk6iiCsHXs8nIF3GMBGk
         0L3ZF01X6yHrB1ggOWl7U3EpQJiyzmgUaYE9/duQdlm7GkbOWhomDQNAQ71n/ZGwidip
         AP2tHDefcKT0WecC10UpgDA5SL6fK3WggSV4q5uHFOdxp+r0+f/tr6HB6UaPcAJHzUb8
         vSb4uBF0BZqKOKqQY6qceR8N9HrBBlp5yDBMxICSMxmJGhkVFz/JsJaqMLOkIWVWMeuU
         bO01PJgwFZWCa6K+ti03zJI4NLq7GhszaxjcJPuXtbp3D4aAFu95o4GAg7ZEsA1gn2VM
         LgsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771317715; x=1771922515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y89n+th7tnE5Z/5/sRNue21/CtYhyjB+0dCF1kUQxSE=;
        b=QbICgqJVypGY+rE67iWwxINZ9VPBt6f7FQ3OmgVdFSz5foc9erpL3CchYRCIsyjWZB
         5hKrrFtx46yVrPP/Uzn4r0/+Xilh+LPmzL1y+Or6Ly+Vljz5zqtfn72HUH4j+QCelgU4
         IBC6749skHgl4LsUM/FhBfGg3jxEvBVoqvySyYEva2JLRB4eaPXNL7oG4gowbGzpN9jp
         Xm04tYkVdD1INQ2+Rp/v+nlL8IQ+vZNBxOU3addtGLCsKYwvgtrnt6D8c/TVMeEKZPLD
         SR2gRioHWVCDT+BV3oC5cne56hsiwl/Udoj+ITps5vjB7Z10VrEhOEU7gphw+H9TAhDk
         e7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771317715; x=1771922515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y89n+th7tnE5Z/5/sRNue21/CtYhyjB+0dCF1kUQxSE=;
        b=RroVitW8lm/tYPEhCjCJfEO1p6dboQlvSDFsykaBcDxFx6vAscoDrnhFUVjYLXVOOO
         SbGzjv6Ksq63J8AnR1iPlpASh9cElJoP/h/yXFOd3mnpGgP0FHFkZcKoedfoJke9Xoal
         DnDZtFvN3cPapNou0ko088Bqkz5bDwbhIEIS/VRtxpxVx6Ox1weIU/r47titLGS4BwdJ
         5r0a0UAy6FQsn1pHyjDDWYiJdz2HWRrEnpufCO1gKMcuJiBa2hj67fa2+GZAlp66LXNN
         8UCUODkYb7AXoZw6PcSdG7LAPCa5PHRYZCVjPMn8R0Gg2hdCdtRauPruhgMado92kV7/
         R5TQ==
X-Gm-Message-State: AOJu0YykmBDdB76QCcq9LbK2iREXC2hWArgXu7fhMrqHgyqf34inhUqW
	XSm8pMIrsC6f8xASOM+Chrrmpe5F7g9+LpTayUEoJ4sr7E8F9U9zoM2leLlvvSL5V2p/oZQx1nF
	YDl5WgXr2KqMt1xqzyxSg0/EQgJ0WJq4CD1XhjafdARSj
X-Gm-Gg: AZuq6aK0pmkuc2JTxrApGAU4CGkgST8s9nKh01O9JefPwP8xcx2z/XkWtcZxhiMu51I
	RBZd8WAfwiOk+8Y8E+uaIS7GQS9x9iKWJwaEb0S3866x5vddsTRXQfn/3mebGrxaZJWmeWMmPW1
	35WHh4wC6L6o7uLCWmLHm5QKWixIrej1IAfNbSUp7vwBzcwFTmMnPw5tw/H+Vhwxiij6svP79aF
	1HIjWjPu8QCXVLDAtVdd1zLw2MU6xcBld9dtAoyHbtIgVB+QtpFaBPrflptl/dDVGs2V3AW9oE3
	ZPM2BVdMD7TGOnHoHQ==
X-Received: by 2002:a05:690c:dd4:b0:796:3515:3aa8 with SMTP id
 00721157ae682-797ac5d49d8mr84544127b3.43.1771317715438; Tue, 17 Feb 2026
 00:41:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217080326.50564-1-mahdifrmz@gmail.com>
In-Reply-To: <20260217080326.50564-1-mahdifrmz@gmail.com>
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Date: Tue, 17 Feb 2026 12:11:44 +0330
X-Gm-Features: AaiRm52mTXMPcaWU90JcdTY1oxO4TzgH5nR25AXCXIXhZJzJg66k_Z4176XU8dE
Message-ID: <CA+KdSGPY3YibWEOEDd6vj+=uQkigUMQDuvBbQZXWWVmnAyV3yg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix selftest/xsk single test selection
To: bpf@vger.kernel.org
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 11:34=E2=80=AFAM Mahdi Faramarzpour <mahdifrmx@gmai=
l.com> wrote:
>
> From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
>
> This commit fixes the integer parsing of -t option. The cli parser
> only relies on errno to detect parsing errors. The manpage for
> strtol (https://man7.org/linux/man-pages/man3/strtol.3.html)
> states that the said function "MAY" set errno to EINVAL in case the
> conversion fails. Currently on some systems, this leads to a silent
> failure with return value not being exactly documented in the
> manpages (probably zero). The reliable way to validate the input is
> to check whether the endptr has been bumped all the way to the end
> of the string or not.
>
> Signd-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> Fixes: 146e30554a53 ("selftests/xsk: add option to run single test")
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/sel=
ftests/bpf/xskxceiver.c
> index 05b3cebc5..f2d5c4dd2 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -247,9 +247,10 @@ static void parse_command_line(struct ifobject *ifob=
j_tx, struct ifobject *ifobj
>                         opt_print_tests =3D true;
>                         break;
>                 case 't':
> +                       char *eptr;
>                         errno =3D 0;
> -                       opt_run_test =3D strtol(optarg, NULL, 0);
> -                       if (errno)
> +                       opt_run_test =3D strtol(optarg, &eptr, 0);
> +                       if (errno || *eptr)
>                                 print_usage(argv);
>                         break;
>                 case 'h':
> --
> 2.34.1
>
Some style issues and typos, will send the follow up tomorrow.
