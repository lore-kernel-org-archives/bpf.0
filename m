Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D267A309EF9
	for <bpf@vger.kernel.org>; Sun,  8 Mar 2026 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772949362; cv=pass; b=HxAXyhiUJA9Wb2hrN72QpxafOpJc8w9OAnsA0thzOqq/RNdL0nwTEMQvxMOo7n8aqKeZF2zvL1RBlGwksSAKu02n2CFBUwtDws6B7Tf9I+QQg8X9oqPyv+KqbbOnT2hv6wL6wBqfZ56NRLqord9jKBNtHCBbRq19eYFsEQAP8IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772949362; c=relaxed/simple;
	bh=qzZLCcnHG+Osbm7pa12qQeoDFe0+3vPeHUnXlwX+JZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hj5bEfyzo6wiC8MphPkVmGeQ/M9gNSd83rnJEPmPUcaYmE8hRIBvkpDkWJmsKPhAhUKeLcgLgxZrVqwzizHnr6OnzhPaisQMFvRV+z6IWGqbHDskoh0IxQdQ6kUFtPCwuqk0ZPcPbumAG2wijm2Khxta/d3WXxb4wTgs/ztHVIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JD4Lzhmj; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD4Lzhmj"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ae222d978so10175255d50.1
        for <bpf@vger.kernel.org>; Sat, 07 Mar 2026 21:56:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772949360; cv=none;
        d=google.com; s=arc-20240605;
        b=OvPXrHvrVzUZsw8gO08cyGdMRFW1xSHwBr+2XjJQ4qEDWCtlH1N6n76B30ZojZagwT
         Ebj6JKEDWockAcuMMxIWgeSmGFDZo02CDqFIdMtjL30AKltC8e66SYZpR0O7Ec8XLT04
         6Or9QCTAiYC43QfW6TCYQEFIFMDW5viQkYknpW3xzUzb85cmOtkWvEXqTc9I+LrwZVyv
         y5k2mM6Riz4z3I8UecwoMBO/cNE1qNFv2ULNGHAaPFfhy84RUMG5L07NRfxtoGJ/LGcf
         prp+YR7W2ebxklAsStuor99eaiuM2+nG2lXUuACk8KtQTRcq265pGsowxtG57WIqjbfd
         FzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qzZLCcnHG+Osbm7pa12qQeoDFe0+3vPeHUnXlwX+JZ0=;
        fh=c50BiYsxCqUtwm9MeZBvBZ5ITHkBLm52E9zb2rk5/zQ=;
        b=N3cZf9eLWqLFpka5bdHjsss86qULM3dKyohkyUHNl1wOSe825P487ROwUHYp4TGizm
         2DG/xmQQXtVE5R1j/0RVTno7qvPNDPSvv3e/ED0vREicD1o86OmVXPQoC4+iVlnCqhW9
         R/4FzHfYbif7RXNw6/giSjyK1a+C2Mvwi+8BH5RuZa292OBeiQgDlC84s55UekYhdSIo
         lTU9p0xyXkkpEWFrVsz5gAxa8Z+loowXIV+u0JNnezoyKuTjxPwMgzRAYGaUEG5ojG50
         3kI2+svEJydqlz7akj7Ca9h89ntRoMU2/3u95qp/66mMFqfxMIP0KVRFYeDuQG2UHGBM
         nl/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772949360; x=1773554160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzZLCcnHG+Osbm7pa12qQeoDFe0+3vPeHUnXlwX+JZ0=;
        b=JD4Lzhmj8BLhi0ktY77ZOwbthqiDm6jQaPAiuRihzUNoObi/aTRhGBMiGVwlAzQ/kD
         07h55C2f18u/dtYhN4ydhjIxrzj61EulUqEuuR8KwOOu4llo/GRq5WzhG4YBKPAi82W8
         DMFxapv2q+iU8BkhbQcE67EixUo2ha0AWyGBvJEsF6xEA484jAIDMB+Rw7RaO7dMkm/Z
         0mEubXwkJe7Q9kvcg4qjpWSRmgl/eE8nyZTwdpIy3g6HKLFfoQXfStgGqZYdzzryOrSo
         WH+etbX4oJFa8q5Q+AVarzkLuDLTzs6owz2HIOVyOhfKi0YahDiL8/Ed++FbKPgFGE/+
         c9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772949360; x=1773554160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qzZLCcnHG+Osbm7pa12qQeoDFe0+3vPeHUnXlwX+JZ0=;
        b=iryndQEjKThlsS4Y9FdHgb4+oRKskdX8gRvxs1PLzvON6mtA6u1Ew5XHPVpBUuF6bJ
         Z2luhHa1UWUEKYknFcafc7+X470IMe3WgxrQMsQYup30MMBJ7OeUCqHy7zcC9iDL2MhD
         UYEOyFEUX4hbXMWD6tqiGq4D573zz5NT8pb7IjTUEaIzAzVrbq9Odog5zhA6jFUy4RVr
         ci3w2vrMBxj+5Lvqen0bkcWGwEnBgu2XE1Fg1D1oN+SduC64ILxfWgCAZykNojP/4Vh7
         lojax57beC7dy3nuKs4+e+DBNVHKCzrHV9/HEOuvVJlJeXdxLYH9TuOLgHfzfnCv9svz
         atMA==
X-Forwarded-Encrypted: i=1; AJvYcCXlBNuUzxTKINPoEc+s4djj7VmWpx5B2dsgvKNiOznOoDeSBCh4o7vdAGaCOt6V4RuDz3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsg3qjR/sAaUmOgG63SYnVj7S7wyOUTB+5yz259sooMlrRUZfM
	lt1lS+MOQfBLVqLKHED275SZBEkfjFBhDSg2BecucCux4SHJ5miXQENIRUyViUARn4R6YiI/O3g
	8uILWg1ZnUN3MgEchonSm90GLzRHkPZE=
X-Gm-Gg: ATEYQzwrRmIK1ZCMCnEAQd6TqEWF556QbVROj1rnsi7QAFUCPeU592eFNXJKeYvQRUa
	hntfbCh4QIJF6T6b4vTavBRB9L/70whsuhOdFeWIufgRsYmigGaXKTF8jZg2m0c81ytN+BayN9c
	BeXPKRzQV/KdCDVH4mH2GuSI/5KnuJSgblpqcOHOOhOFRMDdBqvRlOI9+raWfTkURQuYEGqPOJP
	HvPNaPXA5Tw1I+C73/+E30+bnFC8CXNI0ttzS+7tjOXDL1OhqysOXkxvUiVJui/+QeFAk9n1WfT
	XO51kwEAP69R
X-Received: by 2002:a05:690c:690d:b0:798:6a6b:5b0f with SMTP id
 00721157ae682-798dd742160mr68841947b3.32.1772949359778; Sat, 07 Mar 2026
 21:55:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306120024.1032301-1-sun.jian.kdev@gmail.com>
 <aar9gzh7QVhezeII@Tunnel> <CAADnVQJtG9s1CV-qeF8NSgi_UFPgahOXtB3PWiivBooAYC69GA@mail.gmail.com>
In-Reply-To: <CAADnVQJtG9s1CV-qeF8NSgi_UFPgahOXtB3PWiivBooAYC69GA@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Sun, 8 Mar 2026 13:55:48 +0800
X-Gm-Features: AaiRm51lortd9tUoJm6gybm3nts0d_O0elldh2h1076SJcxJM1Dgweg8zuDg1_w
Message-ID: <CABFUUZGV7ZAVY=Y6Py3ytZUzZV0i9otPWADgP9HtVrDzf612ew@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: avoid jump seq limit in verif_scale_pyperf600
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 7, 2026 at 12:23=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 6, 2026 at 8:15=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail=
.com> wrote:
> Sun Jian,
> I asked to do a _minimal_ tweak to pyperf600.
> What you did is a drastic change. Pls don't hack tests
> just to make them pass. The tests have to be meaningful
> and test coverage shouldn't degrade.
>

Hi Alexei, Paul,

I spent some more time looking into this.

Comparing unmodified pyperf600 bytecode between clang-18 and clang-20, I
see fewer instructions with clang-20 and nearly the same number of
branches:

clang-18: 90134 lines of disassembly, 6090 gotos
clang-20: 78369 lines of disassembly, 6085 gotos

So this does not look like a simple program-size increase. What seems to
change is the branch layout in the unrolled loop body, which seems to
make the verifier DFS go deeper before pruning.

One useful data point is that a single __on_event() copy does load
successfully (that was my v2), while with 2 or more copies it
consistently fails at exactly 8193 jumps. In other words, the verifier
hits the jump-sequence limit before reaching the second copy.

I also tried a range of source-level mitigations, but so far I couldn't
find one that preserves the test intent and keeps pyperf600 comparable
to the other variants:

- UNROLL_COUNT tuning: 99 does not compile; 100-120 compile but still
fail at 8193; 121-145 fail to compile; 146-150 compile but still fail
at 8193
- early break/goto on !frame_ptr: insufficient for pyperf600, and also
hurts pyperf600_nounroll by adding branch points to the 600-iteration loop
- wrapping 5x __on_event() in a non-unrolled loop: verifier still unrolls i=
t
- making get_frame_data() __noinline: still fails
- moving the unwind loop into a __noinline subprog: still fails
- SUBPROGS / __on_event as __noinline: still fails; codegen changes,
but the verifier still hits 8193

Paul also mentioned trying STACK_MAX_LEN/UNROLL_COUNT and only getting it
to work with STACK_MAX_LEN reduced to 180, which would make it too close
to pyperf180.

The only source change I found that passes is reducing __on_event() to a
single copy, but that clearly weakens the test as pointed out.

At this point, I don't have a source-level fix that preserves the test
intent.

Regards,
Sun Jian
