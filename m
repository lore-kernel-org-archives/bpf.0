Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD63EBF2D
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 01:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167852; cv=pass; b=TaGW2Gts6TxsuiwWZmg1ypR+US+h/RqlttWrHtqDas6BNqbo/xsgghyoL8qrkRJlbZKvwr0zptAql5YdVwnPoIZtZTBSTjrfaxwrihalc5VgCzlykDPwchXe/DS+zBoNO82/CUYU3KzDv+5ExvO+f+kXE+10tF5JnTejVBDtNOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167852; c=relaxed/simple;
	bh=pthws6uxWqub+jx6HvrHLf5wqFVXjS6siiR7rMX7Ahg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+GENF5Osh728QHNjRfyCk2f1yn578GNLEBg8/q7VZaMr6eEkv7/y3lZax1HMAU4h0VF6SoLdsCubtgHOQ0/KtJ2ZDYFzCthM2YkVAej2GyZrMzoahML7z8xZd1AMFbIr/HjTwjJUfpGVg5oCENv+gp94BznkoZSbnGNWzWamT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUvi+y33; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUvi+y33"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c61342a69b9so2430572a12.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 17:17:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770167850; cv=none;
        d=google.com; s=arc-20240605;
        b=RYq4Dqa4lE3/ez8NiLWYBZ6DIWVqZdwhfF5FFo30vpCjfjPrIqqZYgUSmTT/WO2E4n
         3AiPK+uVxLKUO4JrZGz620bPrhrYaLU9DIkfCOs+gzttr0WQcggJX7C73fYm55FqbTIf
         +uuZ6dJSgoHGpOBUDcCsgRd0xzLNop7K+VwLNo/QsyZ5IzX5RYpx0rGTewvuMKfhnwvg
         O+0puvw9mifnKVajOKPxyejRBwFPjhA8ioECq/MIFRn46lrzVnVEqwO08kTE0lsVwCYe
         p9cxj58oz5BJTWD7ZwJruuNwfAAo4zB+NsxMKfO/zz9PHOoyxQrv7XCfXlbGGdAyX8x4
         5p3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pthws6uxWqub+jx6HvrHLf5wqFVXjS6siiR7rMX7Ahg=;
        fh=HCF5jpLaAabILoSa1MB8aj+la2LMZiCcmhbDv5qsBSw=;
        b=D4OGuvKSfBqO18/vQZzrULwMJWNpOks0Uvu5O9b3Vw4R0jSGDjRnXXFiGhdyhbv9lO
         hu9om+ZXb7xkw3kL1mY4yuDkr8Kr4Kv5aqGnPQi/To/Ri3/yeHx8cwAMrbCRgNNeZZ7P
         ylzQqb7LnC0ZwX+N6nA94SHKtCYMWZDXKDxu+OcGU6T1c72k1uojOm356IgFa/yRuk6S
         6SqxhyCTPpg3hBPeqlfso26fthfla9sSQ0clTVwWpwZfGdybVOHitPyJiw8JISdynpJL
         2rpG8mpvQyxsRasz63jsNiNt5pxrgGQnA8qOYe7Mw40wUkZlN5tYXpuoPxCtkS6gMzUe
         5TMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770167850; x=1770772650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pthws6uxWqub+jx6HvrHLf5wqFVXjS6siiR7rMX7Ahg=;
        b=cUvi+y33JwrSxgHUcmk8Hp8lVDQMtxvbaidX0+283GslFQ9wzXE/BMnuylrFRYVloh
         sfjjoGTMCa/dwE0uPFLmJfakvZRe+ohY0v0ePEelUOa5eD7NgcDa/yVHB0i55jZygC+N
         8a6l6UgMFyxgVlDKbwkgpvYbzoD76wAmtpBq355X7dfrKKNuWlr7PFMQ79xqJrmgDF28
         HbiCzmiL/eYIiSkDm0aavz3FAxgbW+Q6wboDFwaOjQ2Ey818D5v+ykzjnTLpx2PO/tNZ
         a3L3ojwGyUHmnABtX05eqx9aDCWfCXIsxr9X+uZ7aM3GqIbCAfc/7BVbYwQMCT1NWhxV
         TZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770167850; x=1770772650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pthws6uxWqub+jx6HvrHLf5wqFVXjS6siiR7rMX7Ahg=;
        b=gqWNSVsm0+TH5aM/OEwqf0j/qif1VsTHBtRPoy6p5BPrLc0gX7vTWlmPr+33/TjYm+
         6c6bm20yF1J6/F6qCR2oEBAaT5Ox/EBa5FdhvqsTwpmnJbQNe37yNxdAs4bvIgMwW0Ui
         daHuRwQkngN3Yz1y8pC9gcMEQXYQtxV+AqKv1mdT3fEd0kS325cVM2iG8tZV04gF384U
         Wak9MSI8NJss71iDp9XotX4nPKv5zsRSW/uKzk/7E1ijrqjw3pesWLJfR6T923a2jir1
         g5D9wNCUWxKeUaNfDU0HDtcgz6H3wbPvi4aYs6qy84G0gocMCvvYGvwbs3E9IyZMs04I
         A/JA==
X-Forwarded-Encrypted: i=1; AJvYcCVuwnGtq+TAoU3cVY49odqjf1tyg9WN3Oq1YD4aMIe7F2MyKdQvsjWwaKfiTnBpRJllCn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5ktB5WJl8Lp3Ui/oLgn8IbRjpSloRiI+zFaX5Cqm3RTdVGsJ
	UXbP1iDXMBMPz00AlzVXtQhO20RN078NeNt+R0EaQ4D80T+h+/cc/CUt3enJ9Mvgrkw7ebPshHd
	d6G9Nb3rUEo01Yd9InxNgWkp4Sj1xfpk=
X-Gm-Gg: AZuq6aLgI7aL9I1O3wasMg175/jabw3bhzItzVMrUYm9wrZqrfNnZ7QDUF7iRX4TSLd
	idprZEAOE7x67mf5LIsFxb3hbvUmTb+jBKbnB20TdSRruUleW+W4Kt83x3imro0g8+lInPXX8lE
	fxLS8xa7mu54CFCCVQYkFo9Wom4y0957GgZmPC3DJ8vRm6/H4u5CqOu5wsNeC8YJkEvBN7nHLhh
	Dj2YNumB7qb66Rnq8LjTrsQu7ZC8QB4xkfh7K4oAs84ukBgFynhYLskm1g408SjHbppiqpfiaIn
	ng4Y+M5/6yA=
X-Received: by 2002:a05:6a21:1507:b0:38d:ef23:12d1 with SMTP id
 adf61e73a8af0-393725ddd5fmr1149906637.74.1770167850408; Tue, 03 Feb 2026
 17:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128233425.374535-1-mykyta.yatsenko5@gmail.com>
 <2b6f4cd9-ff0f-4a91-90ef-8d8e6812f80f@kernel.org> <CAEf4BzY16OkoUQZ-Vaywb0oAL=UGY=8FVcBWLVM8oe=-bQ=4xg@mail.gmail.com>
 <1d4546ca-8849-464d-9080-ef77602134c7@kernel.org>
In-Reply-To: <1d4546ca-8849-464d-9080-ef77602134c7@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Feb 2026 17:17:18 -0800
X-Gm-Features: AZwV_QjTS5SKG7GPVTYZUzjK2-QGIi_LOuLBt8syWpJlVJPPZly613TJlNbYakc
Message-ID: <CAEf4BzZ2cxBfCBsTHDPHRqtbWmmN8ksYCOA_ScNiyAcTHdfZTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: Allow explicitly skip llvm dependency
To: Quentin Monnet <qmo@kernel.org>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 3:48=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> 2026-01-30 12:46 UTC-0800 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > On Thu, Jan 29, 2026 at 9:34=E2=80=AFAM Quentin Monnet <qmo@kernel.org>=
 wrote:
> >>
> >> 2026-01-28 23:34 UTC+0000 ~ Mykyta Yatsenko <mykyta.yatsenko5@gmail.co=
m>
> >>> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>>
> >>> BPF selftests depend on the bpftool. In some environments we may link
> >>> bpftool to llvm dynamically and then try to run somewhere where llvm
> >>> library is not available.
> >>> It's simpler to avoid llvm linking altogether in those cases, this
> >>> change allows to do it.
> >>>
> >>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >>
> >> Hi Mykyta, thanks for the patch. Do you have any other solution to mak=
e
> >> it work on your environment? We've been rejecting similar changes in t=
he
> >> past, because we don't want to encourage people to strip away the
> >> disassembler when shipping bpftool [0], so I'd rather avoid adding thi=
s
> >> if you have another workaround available.
> >
> > LLVM is a huge and somewhat problematic dependency, so I think it
> > makes sense to allow to opt-out of it. Of course this shouldn't be
> > abused by distro packagers and they should strive to provide
> > fully-featured build of bpftool. We don't have full control over this,
> > but let's hope they won't cut corners (either way they can always
> > apply some ugly local patch, if they decide to cut LLVM dependency).
> >
> > But for a lot of environments this might not be worthwhile to wire up
> > LLVM libs. I haven't checked if this is the problem for bpftool's
> > bootstrap variant, but if LLVM gets pulled in for that one, it's
> > especially bad :)
>
>
> Hi Andrii,
>
> The bootstrap version doesn't include "bpftool prog" commands, so it
> doesn't link against any of the disassembling libraries.

ok, that's good, I was hoping we won't bring in unnecessary
dependencies for the bootstrap version of bpftool.

>
> As for opting out from the LLVM disassembler, I understand the lib is an
> issue because of the size or when compiling a binary supposed to run on
> a different machine, although I do fear this won't help with getting
> bpftool shipped with the JIT disassembler.
>
> But if really you want to do this, at least let's do it fully and give
> more control for the disassembler dependencies: I think it shouldn't be
> just LLVM in this case, there should be a way to opt-out from libbfd as
> well, which was problematic for other reasons in the first place, and
> probably some mechanism to tell whether to use libbfd or LLVM for the
> disassembler when the two are available on the machine.

Yeah, absolutely, that makes sense. Mykyta, do you mind looking in
what's the most sensible way to do what Quentin asks? Should we just
have NO_LLVM and NO_BFD switches and take them both into account. If
LLVM or BFD is not explicitly opted-out-from then we'll just prefere
LLVM over BFD?

>
> Quentin
