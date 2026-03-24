Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A17397E6C
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366744; cv=pass; b=Eb3MiI650dCatlDKkZYw5lKfCC9FWueRNPO7Lb8NYU0MrKDW+C8PDcIbV2Yw/be3WCzzhhLn+QMjH2cQoyCF7QYpUCUkCFJbltC3gst92cbWWvg32Ga9Uvk4I5K2eaq0xk5DxLx/a6IGi5yHNBtgPlCnggeLCvVixXQfUI5hAGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366744; c=relaxed/simple;
	bh=rt4qT/ui4sfGhTYQQ5tjwRfYxEZXbTdBWfiwG1q9eYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILq7kfgR0hn5KLEAq0QVOjZhY1fmvb2ggodIyTAMss4P4R5V0SBqvbzcuLS2NE/BzL1ccTkptqCwNom/sZeCvRI/mfjYY2pmQXNEQXWj9xjifdX0A1istjcL4h21ZtdR/I1fPuSXh3PVdOQhPfhLcPaiMrfwdEDcXnGCc4IdDrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Urpk3HY3; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Urpk3HY3"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b45bb7548so3935079f8f.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 08:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774366741; cv=none;
        d=google.com; s=arc-20240605;
        b=D+mrjBsSnsIy1gU/qQteFR42H/nhB5soNa5z5bEI/AcO/u6BScNDr6FFtkXDRwgLNj
         aEpYALv4rHulcFmGZwvNxte2cUM3JvqoUEVnfu9zZBFaeXxk2vbL+0UDfeN7RxEbKfz5
         fXxoNP2vdL+8DiEKY2txR/llvVNMJqYNv7/SWm+iWZ3v6rqtfcU4Lu+xDXi/wTbF/q5d
         yZ9Ru3QX1jNhz5FuTWUZbxvnYVXn1oMzN+qwLR8Bk0DZWP513T+ggN4dMUPPM1Gm41xh
         v1pKW1U4putPg6dDMEBWFWreQoHgCwYQa5Myb3DE4w4V1z3tF13TWKdKnZNgvy92Xfp4
         vcig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rt4qT/ui4sfGhTYQQ5tjwRfYxEZXbTdBWfiwG1q9eYs=;
        fh=MKAEK//6DYOxY9D/faa1DM1W+T+tDdhoWdZjetP5E10=;
        b=XcFd5c+HQgfhN/Yb0tnoaAGkpyXnJAm9/t6kb+2MqBa6+zDGYhtHGGRtWjXrlhij9z
         eShnTyrKLgtVWSGgBe2pJpLSUA1REmEMJCIwSwOkFTS8sIW4w+wGsVzCPd95+unitbEn
         CPEzi1IqGBbW+ZWd32+Vbn55uUSJ+RZevltKdS/oWMgXDxDuzXwVb6w8RFahFH79YJYG
         WnOQlacWWPJXN6g4lmlVJGYZ36YX63SHwNesU36yxOvRuWJAAM7gZfZ98/pmbUEB+res
         4s2haWNqp7G9iBCDr6x/XdinznfdcgD3ZAYqil0DKuw5MYnCxov6Am9GOwYhNA5cODMw
         fcVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774366741; x=1774971541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rt4qT/ui4sfGhTYQQ5tjwRfYxEZXbTdBWfiwG1q9eYs=;
        b=Urpk3HY3hO+s6dhxrOY1YgEcI+XJuEFiaH6UvmE25ZiGilaOUEXGlagdRh6nfITGsw
         dwvZ3IAqLjY72M4m/rZrAGL2+wL0ZXTZlvoSFstafOfLD8ep+ygP7/aUYboMzeDi+/iC
         Apci4bE5xgkgUSaslgMtjmRLQ9Ql3IJo+WtrfRlmG33HOJEwKu/VHXZWs+d/AdzdMZFL
         bbhp8hkNMpmf6q50R/4w+7Gfrfn/rBNRt0LN37xhfjF1H/lORZyXBO8mR3VN7/0y4Nlt
         aCsmucxYPrIp8NY1AdBJsntEJt9jmZDWOSeWKApeEpEQwacAyEhQ3WN7W7usmfLnKoox
         0xSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366741; x=1774971541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rt4qT/ui4sfGhTYQQ5tjwRfYxEZXbTdBWfiwG1q9eYs=;
        b=TWJWpbIZTVAyLl4eDdYBe2lkD8AEFtsk4u4pDgkeCRFVxNcNr95KBeyaQZQLUKbiMD
         WtYPl8vA7r9TRBd1GeO9mBTQQh8kRUD9vvmVp+/EBjlY97TUmKEQz/AG3whj9ABcFiBK
         etaPtJiWClaAbvLY+nZde62xysMvK8EHm51K6RxCWjJ+NawEhsS/xgx7CpFZcdMahk3b
         dIKIo3jeagaV+iMlDKHKai3Dd0aaz45+g7TttRZ4xO8V99Mk5L06yTz1+UNSz8YsdIXH
         tBpYOH/3v/+BSq7+IipD/xWpwpbp5YCBIDbfpeKJhQjZETdxh8nm/KB6IY187jJfCXs4
         3EJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4Ph6VLSe1s7vml/ogv5P9Z7kdVC6a8kAKvOre4MMVeQdJlS4gA3geJ7xHh56AVhx0teo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8CPC4OYWJGle5g5owV1T384LJoyrkOwWB9XYTlynXB4hLKGFY
	VuoIO24/WP8M2suN5nGjC5vc6O4YLz0yOepLxul6XMSe3yIDmVJssHLjizj4ZysG0BTsqJ640o4
	i5oXiUc0drOiFBtCmJ5OeKbTEBJ8tRQs=
X-Gm-Gg: ATEYQzxJkQhi4qg0DeUmuhRBrhDX8q8XMo9Ki3ClWEW2LolyQCX8cNhyVjsndvod9Hp
	2tnLPQ4I5XUEd7DNfqiLFpYkP9/hj4bQfY8HLBe+5YNy+Gp1EXYL2FcT5aECN8+O6s2yyfsir1S
	2VRWuAG+RuOKMqk6C+U78xsNjxli2UHtMHs56SQ5SgiKM671qzMbzKBu7/2dId2cmTXbkTgWHrX
	Wx3fAh7mSR9mB2UcrP0GNsBwnJ+ynM+0Cq9mqiGxYvoCP4mjadcYuw8npYUdI36NsBc2Ty757++
	nrlyQGtyoYI2pGnTGiiteXLViKEzdV0MDu0bKiNh9INt/qNc1xc4M2GGPmfMRffOQj1nAQt0AX5
	1GFpYnXTp+3f5jlz6cM58ZRdiJg==
X-Received: by 2002:a05:6000:1884:b0:439:c9e0:83a5 with SMTP id
 ffacd0b85a97d-43b6428ba82mr27243700f8f.54.1774366741482; Tue, 24 Mar 2026
 08:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324040535.work.851-kees@kernel.org> <202603232224.C1555BF@keescook>
 <CAADnVQLhWURvQ=gBYQvuEa3pTxabYQYhrPm9QG0gbxL9ee=vng@mail.gmail.com> <D53376BA-4772-486B-A18A-6858C1732723@kernel.org>
In-Reply-To: <D53376BA-4772-486B-A18A-6858C1732723@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 08:38:48 -0700
X-Gm-Features: AQROBzB5DvXY4ZUpivMY_noBYppyOsiLxJF6u2hNM41m4-WOEutqa7thEOTe8Bo
Message-ID: <CAADnVQLA3K6v_+_7-+BDVEeZ2N=6229FL6Ko=3ywDWsPVOPLcg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
To: Kees Cook <kees@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 8:28=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On March 24, 2026 7:42:04 AM PDT, Alexei Starovoitov <alexei.starovoitov@=
gmail.com> wrote:
> >On Mon, Mar 23, 2026 at 10:25=E2=80=AFPM Kees Cook <kees@kernel.org> wro=
te:
> >>
> >> On Mon, Mar 23, 2026 at 09:05:39PM -0700, Kees Cook wrote:
> >> > While the original strncpy() would have copied a full 16 bytes from =
an
> >> > overlong name (producing an unterminated field that the syscall reje=
cts),
> >> > but this wasn't a reachable state. This replacement will instead alw=
ays
> >> > truncate to 15 bytes and keeps the NUL terminator, which should have=
 no
> >> > behavioral changes with the present code and avoids potential issues
> >> > with future over-long string literals.
> >>
> >> Hm, I got a failure report, but it *seems* unrelated? But nothing else
> >> fails that way recently, so I will try a v2 with the "unterminated at =
16
> >> bytes" behavior restored and see if it passes...
> >>
> >> test_progs_no_alu32-x86_64-llvm-21:
> >> https://github.com/kernel-patches/bpf/actions/runs/23472955268/job/683=
00440546
> >
> >Don't fix what is not broken.
>
> strncpy is broken. ;) This is one of the 6 remaining uses of strncpy in t=
he kernel. But it needs a v3. I'll add explicit rejection of over-long stri=
ngs and validate that the bpf test was a flake, as suggested in the other r=
eply.

Don't. it's not a kernel.
