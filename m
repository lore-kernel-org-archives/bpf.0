Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.82.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793295143;
	b=qmsAb/pWImnGxTIllW5NuCKWP1YclO1umqji9pwOng9US3D7v8Ab5TazwfN1St0j2d9+
	 pcX/cOm+mzCZWagCCtDEy9rIZFF/fljpb+p+TC90enVJsTicnYnICXR1OGtsp/lWyS5lp
	 ZTYQ6+YdYiks0UXp2EQHaqLpkA9lga9LNuAxdyGYLVwV7XmsGnGtBnTWjVGmTvWiB6uQi
	 Kn29snpOZYbug5SE99jcrz4IaiMtts3Xl+yu8bJSLRsF1Gk6aaYeJn7MwG2bUYe/XsBZX
	 B0nPE+gBAfJYbC1r4Y95Xo2Lk3Q+aQlQ+lrsfdURV9FuaI4mAIu47w1Y0Q+92gNRKRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=R4Rs+OXHP0WWXEc1HyOxC7jIqK/84yuL7ps1Yjc1ZrA=;
	b=ZtKhyh1veA5Ze0PkV+FfvSRguptAfJIFvvRuCqFb0LZvi1CupHiowAEW7c5HHouSSV74
	 khl84H8YldZuZKUvpfHFysQVBN6X6M0UbJueXxoIg6KSeIM6q6oWtQtUuhNF2940K4YFq
	 MqlJHWwcKXN7zt+SBLV2sUchMpeJ5a/U3X89axE2uyb9IHXj075Pu/802v69+atRHVDP0
	 pyTG0vPdSnWOMVYdOVYQMcEtU8DwanIuJZ0XPS++ieeXUIZtdZmn+IOavaWC5x4fzkTZw
	 6VNny4P2zyV62TQ9KiX6wPYxEEBQ6RiwrgpcngWRlga4PM6fyqV9+eD5AUj2tuZPF/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sn8ZaqyK;
	arc=fail smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF83606A31E
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 17:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFF83606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sn8ZaqyK
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35159e0092aso268967eec.2
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 10:32:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793295142; cv=none;
        d=google.com; s=arc-20260327;
        b=gGB5xJOKVZ2VsUMDmohvsb8Oj/kGjgIuWTVy6gppaGfG73j68Eei59IBnCQj535bIL
         tNM+n9AjcFf7BJZH1Up3SaQ5d/z9tn5zAEPSGJOimcJ6bV0cBAQ2AnTCaMtw74L72Ar3
         3y1kJqc2rGRC8a1/ZQlkveGI+eDdDTHXve3c8aw7+7kw2gW4DuKpufwegXu45mFowDis
         94IyNR+qoVR5u5uRHipKvwnRkJLZFTxf+ZdXMgnjzBwUts7Q7TClZELkbVkcg5RIJaou
         IYRHWszYOtud3TARyaW2ACkNN4gxAvBkTgvDuISXQjNtQ1aC5G24e63v/OgSmNEiHjat
         Bc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R4Rs+OXHP0WWXEc1HyOxC7jIqK/84yuL7ps1Yjc1ZrA=;
        fh=J1oP5ctHnEkC90jKXVAZsfoQDWBP6Up035dJ3jaEFe4=;
        b=CCA9oCwQgGHVJXSFVvBQKPr4hJKV2FWS3GCwaugWqAje4ci13AUhQ2gkiPvlTEhMCz
         dbwcG7NM7tusRH0olYm/Rm+eiCd2FgiKUPwOx8XUIC4Fp1u/csoYvPoLPXZDjXcupvUh
         flmBfGq1Cm2Yf+0F2KQ1BeBXQiqCZa6uI7IOrv66QlvJbtHHV8UFVKwvML3NYWWfC9Dv
         QZMQryLgLNKngleKw1UDSfm9N0DKWI69USz3N2A6vhVE/rJwT4JN8rfAW0gFOYbzqClR
         NThv704cBko6WiI9Y8P742riGCh4U89i2VYgreHjicQCmSiQ94YtF4NBi8aPws9yEnJf
         AbKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793295142; x=1793899942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R4Rs+OXHP0WWXEc1HyOxC7jIqK/84yuL7ps1Yjc1ZrA=;
        b=Sn8ZaqyKa9l3To+a5GYvvAD0uAR4LJpfMXeTB71mq8b5e1Cu/L8u9HO8Zj4J0B5nci
         ikPSN1UBdudd69fky6nx+fn2zpQNEKKb8ndM85agvMeZX1huHviwXrVWGf3dK98oNA2n
         kPm3sFQi0kDHKs5E2U8HTKnHQfybkyFStMtmeFjCEYXW2mEF15JtSDG+5XlGpHWRHj6s
         p7K5MntJv9WyU0bgxVoYY7vLJvNAw48cDUARB5+Bim5Zy0yKYy1Tv3NY6ydDdUGsXC0O
         83MJ9sAETqsv7YSQ9eLhf5V4kUe2K4/oqFg8hHLQtP7JGEDhl74TjhF3bkIgdYuBHeUM
         yhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793295142; x=1793899942;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R4Rs+OXHP0WWXEc1HyOxC7jIqK/84yuL7ps1Yjc1ZrA=;
        b=e7/X2ElXHWyPSBfAHXV879M5eN4Gqywz/AfOSCQEb00by7WTVhcIYrbE/h+vpLSqhC
         uPJzubzDm6L/k8UAfjZ0BEl4fjq4vKThGWX3K1nhbOCwJU0WqzTL2NGX+3pnGq3dZy0J
         HgU/+uqGYIIgVMCBdQ877TyTSXOWRvoWRFZP7IlPA+eJdlDLZ+a/uJx3rWXV6GiQb+lW
         hOzjq6qEhd8YkA2mm9i/IilWKDJu2t0vFrJ2VvXSvPZlPziWk0o9mPcIGard2Cy6D4tg
         C58lPH4M1Ez/OQfehVw6jcDYC5foMNBw4051MAOGgIF0vaCAwjUuN9SwzenXECruVJ2B
         N21w==
X-Forwarded-Encrypted: i=1; AKwUvByJHhP+5abF/Je/ug9mbGuVwVcDZDOKXHQs9NmXbKtPyUlRMXa6Va3vLsryiPN7UbFr5S4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxHb61sE6UP75Uxo/tqJino/Xaeue6Eps1mnLhzEzTt2wcmHZ5
	3ZbwQd1mIJB9X3oxNwq6qlt5vC0dGrxwGRIdGHUn16viKvOJ13PS69CN91sewiIcZDh15UlG5SO
	4opt3POziGxlu7z846ZYztrh55SAzIqc=
X-Gm-Gg: AYBFou0IGMNPe/4QyXBQ3BmRzvebuqeKrCFstTeZMgp7kKTFBZ6UCF5bduuerkBsEwS
	wPSLG4eX8Ofb9K2++ejrINvC0uGtp+454xWwQdiAhkFWdevAF50a8mt5bo4P8NvN4YgzrYfJJQE
	WeEpUYgdEZwSn8xO7Fu9M9EJ4c7TKDWImeyOtmTJqUAIzRNRbbjHPWVgsEVaWPY88Uz3WoVqV/r
	eL3PwIJVjiFH78/qkyjTo5FtQprswFF7/P2EclWsiIxIswNCmJg0QdnSuBiue0u2ItvrUjiZK15
	731hlLQvnBqS0Qv9Yus7CIPCrKhrvN0f/Guk5QEiy/hJHphCAa3CEygYRBkIXAMTaYSvEiAI72N
	/cTXZf76eyQjR/K34kTGx1HbwAJ5RqqS7FZUCn30qpC7MmfXCSpaBxQ0QZc4FSERvXkGwwxefNX
	N4n74XtmvuygIKn1V5FlgeHbldIVuDWecpFHj8DbevtTIkPDfvC7CJWb8o5w5e4x2yAt5MgYIu/
	djMXcfmCTKZaFmFqk6Bxt4OE3m7nBc5da3FLBNnfaN47j14wQKh0ws4FQ==
X-Received: by 2002:a05:7300:ae18:b0:36a:13fd:b5c with SMTP id
 5a478bee46e88-36a4235ceddmr139643eec.2.1793295141770; Thu, 29 Oct 2026
 10:32:21 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029162958.3224280-1-irogers@google.com>
In-Reply-To: <20261029162958.3224280-1-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 Oct 2026 18:32:09 +0100
X-Gm-Features: AclHuK-0mxI3LKAZpnOHH-Drrv94DNRirn4x7gfXbdMbpDKW_doTTtE6JJd6tT0
Message-ID: <CANiq72nrhqK0NP5q8_G=936++gZR3=zrES+cK96T95-ThVTpbg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] tools: Add Rust library build infrastructure
 and prefer zlib-rs
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:30=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> 1. **tools build: Add Rust library build infrastructure and zlib-rs featu=
re test**:
>    - Adds `tools/build/Makefile.rust` with helpers to locate Cargo crate
>      sources in distro (`/usr/share/cargo/registry`) or local Cargo
>      registries (`CARGO_HOME` / `~/.cargo`), map `.rlib` prerequisites to

When we were discussing whether to vendor crates for the normal build
or whether to fetch them locally from the registry a couple years ago,
we discussed approaches like this one, i.e. picking a version from the
registry by folder name etc.

But that doesn't work too well. For instance, the graph of
dependencies may change, there may be several versions available (and
the highest may not be the proper one to pick), there may be different
major versions available (i.e. not backwards compatible), they may
change the build scripts, etc. Even picking the highest major wouldn't
always be correct, from what I recall.

I also asked a few distributions how they felt about it, and they
indeed said that it wasn't a great idea without querying properly the
registry.

So one should really ask Cargo for the right information about the
local registry (i.e. offline). It has been a while, so Cargo (or maybe
`pkg-config` or whatever) may have better support for querying it
nowadays too -- I would suggest checking that first (e.g. `cargo
metadata`).

I think depending on Cargo for this, especially nowadays and for
`tools/`, should be fine (we were considering even back then and for
the normal build).

By the way, checking Cargo's cache sounds very strange to me: that
means the version that gets picked is even more "uncontrolled".

I hope that helps!

[ In the end, for normal kernel crates, we decided to vendor for other
reasons, e.g. we wanted to pin the versions, to customize sometimes,
and most importantly to avoid any possible user misconfiguration that
could lead to a subtly incorrect kernel. But for `tools/` it makes way
more sense, of course. ]

Cheers,
Miguel
