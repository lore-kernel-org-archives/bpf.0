Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F26835CB8C
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057281; cv=pass; b=ghqKIDT/Jutu4wpBf82mWTD06peV+NODpRm+b2iCLl6R6HhmtLLFf5NLHp5cd51uYD0PaPN3zhVW785zcNgZYrLAQbC1BqVFCzo+W023T+SwnJ2324LoqVfzYPxrx8tu72o/tE4lG6Z9v5lPyqQ3OhHp2gnHOGVl4DK8362C9BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057281; c=relaxed/simple;
	bh=4A/xg9VYn45t8YYunHBNUwIaHOOxM2gP1TF/kZTTzrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcMWpOdPSPjioO0xqnrJycYEYJum30uLFK9D1/5A3qR8pjl86UcfZIMYjkmcqNQHyEr0Ve1p5pQb2urQCkEx8cJ9ldnj7wTMTU0DI0l6c2jjRACpHHhpWuRkE2FQok5hHkVfjqZB5tWoIyRwNf9Irc7cUd9hPTzCzSGxY7UrGuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qv/4tX0l; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qv/4tX0l"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fb439299so66021845e9.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 08:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775057278; cv=none;
        d=google.com; s=arc-20240605;
        b=QKJpglzEXHnKBX1DzEe5UwerB+Kjzh9sq/IAmoyUVEjXunvt2Yxl84qd1A5l6GOTt5
         7i/R1NXcjgW05FBnSdrsN2HpFGDH3FaSQV5XRjxu0svyCqKw+kDklsOSfpFNSnrgX/gV
         FrDcHeAOTZ6YgH6nkbqe7ce5OEnyT8ntPuPRVX2tu3xPxjopdi6bCOIupb6pxVrR4YpC
         G0ziZVQTaYZ9WH6vhqrTLt2olaFs7PfxWTTkvJ69JLQIFkn9YfJ7J4UT02Wfm/+uiQKm
         a7veX1O7mvRyo9kreBSYqKbnU/Yl8mt1srwIAQ6ntEDnWzAy5idLgcOAkQlNgI5lOHTX
         OEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vCOHypGKguo8wBkpBnEw63yLvcdsQkVdKAKwk74anwg=;
        fh=1kDMvm6I9r2X6I3GGxDxOXj3VaZfFxVd7HncER/3wcg=;
        b=Rrfbcy9UiGxYbvbDoeUHAntSiN0MhN/9V7Mg8cGvdc2WjjVV035xWqFMvAGMEXQ8VJ
         upiv2Hur4xddmB1NmhG1L2AOgLg/xImtJI5ptKl+T+n/q2ScNDOOyukA/cIpwc+pO+/y
         6Zd+ba7BFRl9NssuE+Dl4lFIB+V4ThMUPYM8tAKgLk8fn/dVT1XehR0dKdusPW89lYW7
         HyfnJRvXKL+tBtgLgCASlZOP0UUnUtcZse3jTGsNiDUnkukPEkZma/tVoh8nFfFGI4PE
         StylKaSLEvdP3QypIfdFFC4ikBQY3WHhs+wPLN5JfdefDuaAk9a9z4z1CyX+/Yll8kuZ
         S4Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775057278; x=1775662078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCOHypGKguo8wBkpBnEw63yLvcdsQkVdKAKwk74anwg=;
        b=qv/4tX0l9OKhkkJH+vDrBljtZYiuCoqt+CNRC1p+kUUZkNUmGpdPGRgxuNhRGrmUWV
         OWawQIcjEVj8SYGrwpmnmzhPeUEAXRAsVuqv4IvFHnwr51jpZ0GLVZmYY5p9pt8VX0qj
         tS2OOjphaT0Cj2NQSYJwIi0eqGqkA9jP9W9KewXaUD8qm6EpUxkUlkC05Z79W2+AbxFY
         igeq6svQN3ddMILocr52O5rr/sf5RWZ+j3bhk2Lar+whTrKsFxmDBEgLH/A/5V0bfSJs
         yoL90cf2n3RqS/Evk48BBfWiLHSdCj3zpsJur787ARAog5z8+OWi2H3UpYgXbWNPNg8l
         NcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775057278; x=1775662078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vCOHypGKguo8wBkpBnEw63yLvcdsQkVdKAKwk74anwg=;
        b=boyXE8UkCNoXFSCnOgZQmcFpEIo66002letmvaQikfx93zDgaWnC6VdSyx/UKU2rw2
         0L+PjZUp6JyeF66hjrQ+dK1uxR+2U/RjgyeE2PB3WskN8UUqfffpEqzMuxcZvLTNNJwz
         YHsCb1vG7X0al2WipC7ODj9GgnO6xaa/MlJTpt1UJcCcUbH28db2uZOkwMl0TUc0duFl
         TDkxIi+mYU5C6HAgOhXjSmyUsCD3SadoqV2oXhiWkuAKgrkFLoGerTtq/Ub6gzCJZprV
         I16eU7eQHaHE5eUV9Wrnfn3HDxWvAkZKP3aBUjy4yEQ8QFu18AnovNgByEk+D+eu00pE
         wQ5g==
X-Forwarded-Encrypted: i=1; AJvYcCW2V8YviaQMSFdh533etprEzElaQQxJXyM0U0Fs3iukw+5GSxe3lE/ePhw+R4Vgb+vtuqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx75iDeapJYlqRGWS/RzCeLyfp10/ihv+y2oTc7xemyoZ0CxJaV
	zzH1NWv7NyYzjj/3D1vRaOBTxJbXKz4zrobugsA7GR8HtJFpMmdfpe78f0BUZwYbQnGprFEA1lA
	qZFsRcxRxxLahXXt1+2J0jV9yyweD9u4=
X-Gm-Gg: ATEYQzw73Yvsfu1W+CHzwN/EtKe4hmoyk6QfqAkuaP2uKBYs4UKJKPrKLg2rBv9YCws
	/4tXARWX8gTcNzx7HADbnInAi58dUjFuam4wW8D+V0SdVCzTUHknXNZk1l314DORTNm7LdZsEU3
	S4qndUO1kHuulKW9tKyLudjrcm2w8MUIXuKqpH/BwtVOJ/vmcvMtDI1UO7boP5iFNdjKq6Z3HZ7
	yzeche3dOJVQJfwz3zc6XSGYgGGdcwM68yWZj6xJqrHyTHnJEnKfd31JET1vQAp0YJm/aAGh2gG
	a3r2k+8fJowllyquwAmJEAYRGQKwnXrqszN/ZoXERz2BDPKiUylK2MiIHwx5G22X8ffpv/n9Mo1
	6hgnD7FoW7JMp42Pwq4r4jbNqMg==
X-Received: by 2002:a05:600c:1f11:b0:486:fd3a:fd22 with SMTP id
 5b1f17b1804b1-48883568b21mr60612905e9.4.1775057278387; Wed, 01 Apr 2026
 08:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ac0Pr9K1Qbn1-Dn9@sirena.org.uk>
In-Reply-To: <ac0Pr9K1Qbn1-Dn9@sirena.org.uk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Apr 2026 08:27:46 -0700
X-Gm-Features: AQROBzC7wcHLCyA-6tldZ7Ce9lGnYrr2f0ucx0sfqhOnFZehMHR_aY88d-OhHDw
Message-ID: <CAADnVQJdQRi+763mE8pVoYjgCzhUJNFj5b2YYOrrcLhv9s9-uQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 5:29=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   kernel/bpf/verifier.c
>
> between commit:
>
>   a8502a79e832b ("bpf: Fix regsafe() for pointers to packet")
>
> from the bpf tree and commit:
>
>   022ac07508836 ("bpf: use reg->var_off instead of reg->off for pointers"=
)
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

thanks for headsup.
lgtm
we will get it resolved once bpf tree gets pulled.
