Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6F9352F93
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132343; cv=pass; b=YnMMtkuGFAiIK+fOfOfFuTr7cSL2L/eg5WX52oTsrOXWwkEEqL5iAi+e8+MYRwPffRwZFTyx4OR+TlZkOsxlzLowPryi30sEaWWtIq7E/QVHWJJYV3ph6jALTLZRZgQkUABSe1yMrcGPZVnc5+df+TlnR3pznZHcqrUpXSoHJx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132343; c=relaxed/simple;
	bh=iZISFA9WSMFXupvi2HoWpEMRz+NRomvYQYQuwEiHhzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahqlX6qsjImSOtlIspzAieheO9Sk4cfadIBss7smTbheB1D5h933Q8bE8EPPCkQcSYX3unk5+4UvadPOSWphCxSevtBGrm9A7BSQGKE+5io0kkNzIla5yxfZPH4vAxV/GAzfQrHBx8JBceeKvHUIkHKKXU9CQo7TP1MCuEH7Epk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIStV1Kj; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIStV1Kj"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43591b55727so1505705f8f.3
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 17:38:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769132326; cv=none;
        d=google.com; s=arc-20240605;
        b=FhyFPfl49TKas7amisw7PzFuLyrA1XHMg744Fi9xD4c/4+SkUp5ncUjhfqFYOFFACP
         V6gk00HStPmn1BRiEVUGKRZpG+xAnPgIN89+f6YB5hAdGF9QhCDCHPUBY5/ko3UCs4Pf
         J9hPtFhaELbyOQrjp2M83AM8sd20OawBwDU3Zzqz3GhvJltHX6t1IItnUmg0dBxVufFO
         VhVQ77M7eJr2iEmcrEI33o0I3FwSW1ZeuJtKhjCdA1yU8sg9HCc2gw+LqwFlm6N+o7X9
         ws1809BAkdmg0ThYzId2m2naoIV6gIFkJrWdzEAYKGFGyR5eglaC++MAcQ0N8ERbJXSg
         7f/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iZISFA9WSMFXupvi2HoWpEMRz+NRomvYQYQuwEiHhzs=;
        fh=XiQznVffgT/aRbZileG+ik+1d8I4JzHDcLZ2CYZQZFE=;
        b=jyuwl8O8fpN6KhP2IQFgwgMhqmnvP7fFwO4Vd2KFJZUgtrL+H6EuTCt4FD7ChoOCNe
         9AGJIpbQOeZ3gOTzna1jqPdFGKg1hyUBkOsqmN8M+JaWDYoGtWNBc+pHgfGfOSSN2H6p
         muEAFiZnnPb7HgJOCSa1NmWoMHWaefRo8xOPftOFzJvObAFS+TwNuM2FI9LMwG1aTo/Z
         6Q7q2sgjjl31dADJo+E0lU5L2mlmWMEjIXq9cSHlVdwzBZ8T2hXOOLZDJQWEHQj9X1jH
         z5A1nbr0G8WQKYjVxpfUKschjVutqud25r5M9RugnqWaK9rPqRO7Gc1BUvCpjLLV6hrx
         oClQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769132326; x=1769737126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZISFA9WSMFXupvi2HoWpEMRz+NRomvYQYQuwEiHhzs=;
        b=CIStV1KjEzcQdy2A29RSq1MsJt0dQ9mnVLqnPQKEGuNjAglyX54xwTEVPlltouSC3E
         sepAl8NeWSvPsToh1GbKIkYvt/e9qKwZ1PXQFSWIdDT/CKMnd7yHFeAJvxl8RkWaag+q
         +mSnqi1SQvNCXusqdmQU1ACmR9HAOfBK12i6bQRBpvTjdOl/Wv1wy9CCt+gRy27RZeXN
         FRrm7YShAhGtNsEfXVu7oSr07RlIzMhZoJtfUNjsd0R016WS2gHquN6Ege+gAHpEQzZN
         EanwxOmsokVUybgklWVVu3aNmGIXSQMlpZgLu/TNuQrMcHuJvP8GQhKtddxZ0ZaVPlxb
         gjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769132326; x=1769737126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iZISFA9WSMFXupvi2HoWpEMRz+NRomvYQYQuwEiHhzs=;
        b=GZc0ppZ3v5wuurn3ZUc9hf+8DDkmKp5VcwQG1QRa0YAKO17yVlq8vEpTXFFWViubbN
         0LJAmkSiwa+4mWegMO3CrpllsNUMSy4Mbxkm8MG5aruyjYwCdVPmsBDrOJ+66ATY0CLS
         dPW3uFKGQ4td8yGpqttmlhGIubcFr8GNi+KsqNRLr3TFB3B2QgaVwo6HLj2KXQWQ8hEZ
         qmobJ7iZbdldFcni5iQWyGt43HfV7pTRHUiHObj1nBoEKPsSI904QAdfYOJaqRpG9IV3
         GnRsScrStClZ+AW0YARy7SDW+EWlaE9LMR0660GhKBXg88nTOT+yIGaoD5ZFPoeV5rUj
         +eiw==
X-Gm-Message-State: AOJu0Yxk3fuODtFdnss1BqAhUdpBjKs0grOuKUIxrwY6TqHnspAlnxYs
	QGQ4dQauTxvtrNQJqUjyP50uTL1TDrldqZo7+sevORt9aphhYubIFXp9fct5gc61uN8cHmOq9Xx
	dVbk7ugsm5Y8nhpsKmlcjDgrdc2u3nB4=
X-Gm-Gg: AZuq6aJAh4EUO8Q7AriyvNY9QE8j34LYy18JQ/BQXEQmr9QWuN2uoEmRhiHb9ygkrkW
	b//t88PsEYfguCbmQGouzSEOUcbgamJmDnwUtUFgBNcEoCMjMtYgDiZVxwQjBXNahv2DKhdN0rh
	HG1LUE4NRAZmQ9uOal/2RjyH7astWnCBkTpoDX92eAva5YZYvqHyZwdjfWvG9bQff14AoOC0bBA
	MSAxzaLukzOSb6xuaOdaZVES69v2cQ08xGpW4MGSILvD7XHnBfit0MBB5pVOaMJYxhVP+Ylv5tC
	WS0LeVXmYHlHLPHVMqwoCqEu0GOlBtJPdcEU7qaP18EB1udSBSLhP5URYZClWMNkmur0vORfvNi
	KFPlW49Rnedna5Q4XM6V8hdng
X-Received: by 2002:a05:6000:2dc5:b0:435:a21c:f946 with SMTP id
 ffacd0b85a97d-435b161d34fmr2400152f8f.49.1769132325620; Thu, 22 Jan 2026
 17:38:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cde02506-a9ff-465f-a720-637b9033d017@redhat.com>
 <CAADnVQ+hTZ_ynDJk+pccBwHGLs3hyvjDUGyiaKR2osmi0VAQ9g@mail.gmail.com> <3ca5bec2-a138-4f3b-990a-8c786c1c247c@redhat.com>
In-Reply-To: <3ca5bec2-a138-4f3b-990a-8c786c1c247c@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Jan 2026 17:38:34 -0800
X-Gm-Features: AZwV_QhwrxW8h5VfrRYZ1OeRpkBOUDI2vqNbsiCyWzIEpm04g2Pj7OrWUykrh5k
Message-ID: <CAADnVQKnyX-RLjfu-yNSPw2=ptP6k347=YHqOfePA4cOhphA+w@mail.gmail.com>
Subject: Re: [RFC] selftests/bpf: Running test_progs with distro configs
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 10:38=E2=80=AFPM Viktor Malik <vmalik@redhat.com> w=
rote:
>
> On 1/21/26 21:54, Alexei Starovoitov wrote:
> > On Wed, Jan 21, 2026 at 7:02=E2=80=AFAM Viktor Malik <vmalik@redhat.com=
> wrote:
> >>
> >> Hi,
> >>
> >> I know this has been discussed multiple times already but I'd still li=
ke
> >> to open the topic again.
> >>
> >> We struggle to run BPF selftests, especially test_progs, on distros
> >> whose configuration is different from what is in
> >> tools/testings/selftests/bpf/config. While the tests usually compile
> >> fine, many test cases fail because some required config option is not
> >> set (for instance CONFIG_FUNCTION_ERROR_INJECTION required for sleepab=
le
> >> tracing programs, which is often not enabled on enterprise systems).
> >> This makes processing the tests output much harder.
> >>
> >> One possible solution would be to maintain our own DENYLIST but I can
> >> imagine that the same problem affects other distro folks. So, I'm
> >> wondering if the community would be interested in some solution which
> >> could live inside the upstream repo. Obviously, I don't want any
> >> complicated solution which would require a lot of maintenance and woul=
d
> >> bit-rot over time. So, I'm thinking something like introducing
> >> CONFIG_DENYLIST which would contain "config:testcase" pairs and a coup=
le
> >> of lines of code to test_progs runner which would parse the file and
> >> automatically skip the given test cases if the required config is not
> >> enabled.
> >
> > test_progs already has -a and -b and BPF CI is using it to
> > silence the flaky tests on some archs beyond what's in selftests/bpf/DE=
NYLIST*
> > already.
> > For your use case I think you can introduce DENYLIST.redhat file.
>
> A separate DENYLIST file is a good idea. I just wanted to check if folks
> want to share these per-config rather than per-distro. In case this is
> only suitable for RHEL, then we'll certainly go with a separate DENYLIST.

Are you trying to share the burden with other distros ? ;)
It will bit rot anyway and I'd rather have individuals taking
care of their own denylist file than a semi-functional group of people
pretending to share while care about their own thing only.
