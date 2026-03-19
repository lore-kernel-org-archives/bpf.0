Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413239DBF4
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773904239; cv=pass; b=BRxKRW9W2yeO1qB2e1611Dh4cJPAug/ve45Q2gVMWRgsRbRf1tdwAj3pwlgRg4fFivj1WmnGrtZRsFz/fXyw1t9AF0aPQ22EZDVmBwCOfWKLOJZ6w0XFoX9iEvKcTZi8Xb83eSyrwMhYkL03unn/YDdphaGUo/gDPAOHsTdTY8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773904239; c=relaxed/simple;
	bh=zWvhRKm9Tcl1X1tv6vaA458EdhxRENwhSAcKjNT7vl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gl5ViPw2KnvwbGo1Xbp2fHhXtq0yJP515xfOEtUPQGrCnG4qildKYRVfn3tBp2MtZJeCYbJd/Iibv5p2Bbu3gGGhmt0DafaWjt45I0URx2hkezBbyY5RKnOkQvD8R+LvZ/pimwbihH8MBgiJsYBz5h9b7fSXzUJ7KU9HOfFu1X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6byNfin; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6byNfin"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79628fb5c05so2898887b3.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 00:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773904237; cv=none;
        d=google.com; s=arc-20240605;
        b=MZh2sBNmp3xDeGEjGQDzt3T15bjP8wPXxiM/fA8BAxL8LklX5UD6tFFk5ZoTiw8Unt
         Y9pAic5EjHF6uKjjqLPlKCrpfq+ATCP8ngN7QPMNjnQRJbj8YTs+tO/j2sXb2S/Ku7ku
         ywkTFFWZffwxcrUgBDvBPB7CBTQ7fWU+sm1OOpDDaKArRmafgE97E7mryU5O/h/5IGXB
         L6uuu+pQnnv5ggx2y9brg2pDkf4AQuU54jok9r3Dy5G7tJQYeMHG7yLWZK/gCWNingr8
         45VYO98+LlyXpinNpzek5DY3sKeU8wtOO1tJhT49kPq5zQ10rfKy6ByMMpr/lKkVmzpM
         js8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zWvhRKm9Tcl1X1tv6vaA458EdhxRENwhSAcKjNT7vl4=;
        fh=RHmfy/fR7YphbOFkm22w7WoUyt1a0kp5gMK/lJRF3IY=;
        b=luZra2fNPtRsnbi/+6xnp85d4Va1yCRqTNElcI4X/ZEzM+M/0Dfrq9mzCAHmJbmAnx
         jSyPV/skusUovi7ch0rZ+d9QmhYjgK+evqnn28dIEUczWJp2N0ssdzv8aQJ0IKP1kova
         LymGkNca1qZai4eFFoAZC9PQNepzm8HwRmIB+TL2ttp0ydsOQeE54qlG8lsNdcRMvOqe
         VeQ6jWdYpSDXCS4K3QGD0OFDSiLhoT1O99rCWZvgdyNLA9UZrkoK5mZm5d9K3sKwNXZT
         8/oaC3hi/e0coIW1dXNpJ1FB18G0lpkbBRcYP/G+3QUqbqAMwWuMG2wD79wT2d69XfAk
         JG6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773904237; x=1774509037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWvhRKm9Tcl1X1tv6vaA458EdhxRENwhSAcKjNT7vl4=;
        b=B6byNfinnOT5Y0KIw7VscQIYRJhQqXkOIbkmFxW4eWVAElgUgH3i54SZHJryEbzaUm
         msP0lrPF3us4aMYhjDwE7TKdJUUxPUNAj3IsD5q5esd9FxV4y6YfqstmxW/29w/WBoty
         xvplINXFuNq+rMViv60SVutsOTW+5QULkcPYwl8WXDoN/U/MzoJsolTBWj4SB3nJSAIA
         pZQaqLG4jlBQVJ18Sp6ANnA8dO+GbC4Kr8rhFgYRvJGgZ3hDsbx2Osl1Ea4u00N/yV60
         jOHQ9OfJsk7eFVXkHJjxyXHgmkkl9TgTLQbd8FCPZMy+eJoCLPAq0n8ijPh8mgKC1OZA
         n7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773904237; x=1774509037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zWvhRKm9Tcl1X1tv6vaA458EdhxRENwhSAcKjNT7vl4=;
        b=H2RFWrirt9Cw6JX76gB7cUFok8AsqC5/5+fRjj4JzbadaeKY02a+V2CREGzwCtIyGI
         /P/TpyGOPVLvRvrKQMesOvyjzl+YrvxM5UXHuy5U7q5xxdE1LUMAMYfC2fXRy6z1gKPU
         d7bEJxJwv8trsB0p7BE216CTuB9EdKe4/rLSEn7My37Sa2C8Mj4Wpjjr/soahAZTNRI0
         1Km1sVnX131CsqMGhdX69QKvpjgtH3QWoVOQeXJufDjIggwPMX+vcRqRXFIyczeShB4D
         37Xn2F9Uwm3szngZUV5ecKXSHmCma/qOcRzzFUhrrYOVfmTEiZVfflA+fRyr5Gv49m/b
         YaEw==
X-Gm-Message-State: AOJu0Yz1DFglQ8fg8Q8E+NH7Rfe8vpddZA6PAbUWYBoEvd6N+gjf9hou
	grMQ5V5uH74C2UVgjp34y8Q6ovsAU1waE7NfIjwJz1QGzcNMiIbv7hobU47dMWMiQWwRl2oXBT4
	g/yO4/KR847qEF5bFewJgtfy6TiK7hbI=
X-Gm-Gg: ATEYQzyTCHNWqRNsZpGKhn1bZlkxAbVQiXHk8ZgvOrdT2jvIZzS6cTNBTuIVjWYVNEf
	CP2D3+kXdd1/H914oZWI3AFsu99hzR38wSLbqZ5zIE6+LkLkVdqnYFXJYY0GZGbHIrlg4wlMNrK
	i2qo1GpmPhQdY0gCeTh51DjUXXIfFBloPZ8DJUzObP+mDwLLobE15V3090+W4j7E4tCJEjkQ3In
	QgGCefziI8gzZ83wlXVDvlLeujdnpODDaYbc9HxE7aE7iWS4JKrmkbyExLPC11A/0bzQUrv4xOf
	WnOxvOo=
X-Received: by 2002:a05:690c:a00a:b0:799:1d0a:aca8 with SMTP id
 00721157ae682-79a718b1697mr52989017b3.19.1773904237044; Thu, 19 Mar 2026
 00:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318113200.303824-1-sun.jian.kdev@gmail.com> <m2fr5xnwkx.fsf@kernel.org>
In-Reply-To: <m2fr5xnwkx.fsf@kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 19 Mar 2026 15:10:28 +0800
X-Gm-Features: AaiRm51Nw-GNS-Z4EKRdhonvG0llaMuqhIP8-0ju-hgfMR5TkAvsi7GUwTF_LjM
Message-ID: <CABFUUZEfGWqL97=_yyJEcRNfLRzQeVvRvvXXQN4gcw_htHvm5w@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: add a 32-bit bounds deduction case
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	paul.chaignon@gmail.com, shuah@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 8:36=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
>
> No new coverage is added.
Agreed.
I'll drop this patch and revisit it later if I come up with a real
two-overlap case.

Thanks for your review.

Regards,
Sun Jian
