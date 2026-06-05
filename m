Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC32F7EE4
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 20:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780689711; cv=pass; b=BI8DVN+9gp5ogK/aG/WcV/nkyqTFW0/cbagq3GuiYusCtJcszHXvF7atpMIzpkOJPc9MFPUlsFBmbmr5AMdhXZrLKxvBIIP3Q0/kBWnOh3MehQFUm6s5CqdP6+7QDisKTY/kEJ5TITKpFzHfUjpJzBHwZeG/wZJtqwtDQIX5aF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780689711; c=relaxed/simple;
	bh=iuSpu1BzpbcOiHszbQN0eTT8b4TKgwFKK2p4hSM1+9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvDER6gUHY0JZNHzD3Auk1Lqca4fPGNOvVoVd45Ss6uEHXckCZBLYfV0998KnBOnKNXzns723UfHn4CJetK+I5idVIUOf/xACEd88lpgvh62WZdqy28xWD5RLDxFT9hv3p/F868R5+aTxGCe+egvkMzLslyJufQoJIKpM632ok0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdMz56k8; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdMz56k8"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7dc6fbf3e86so26807247b3.3
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 13:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780689709; cv=none;
        d=google.com; s=arc-20240605;
        b=foywXKgi3K8SnEwg0/sSli+MxzDo9d8gfp9edi1ptpzzLK2X5hDVuiRrXU62ikHUWu
         hnAaLKdmFKSJT7W6AWFY1Q8X45SDVf6uwqGoaz1/hQLK9m7XUWVyvHcbWa3K1oeYUstK
         bQ6kQRYGrCX+yinGS3aCjrzT7KFA6mXTUvE0B8/Zmw0JB14BRueGFfz8DCAuqhAdBSiE
         xVB97QVoztWrjx1oq+gaFhvbendD01rCAJWEY8V6Mjm2ysFf/qMGv2Uve6NkBQAN/jXB
         k1ND1AgNfW/5Lfp7H5wbnfidAqhgEe6gige+tqF3Q21ZiAwvJpqi5VdJUHaBVG67zePi
         x9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YEHXC2mVOZGOk1Rk4zHY/GF28qsrwAqEm1e5Niz9baw=;
        fh=SS7tT0KC3jLZdfo/Ptau2hbovOS8lxj95BG5rgPZ6kI=;
        b=gLcisnTklufSpME/HsOGi2vC35kU6g+4my6hIZeMCmIG8V1SUt+HbynT/nQc+4usEy
         hC5QjBeKyh84wN+oexBGS+ZWTSVzBGRJh9EYq4fWm11rLJtIa9w4X45kp9dOj9d4qnl9
         nLccj8Cx09XHoLIDXEbkN0eDJMVVfV21iVOyibPld/+MFN+UJ8zm6NbNAyD/ul8+XgqK
         x42GMXxQZ64e6ypBfnylJMJkpXIaJaQYMZhROniqJikQzBoH9kvkAKVopf0ARf2D6+yJ
         AchAw8h7D9XJStJjI6FP2otpJAPHhB41RecU16h8/ityFrKPZv0rGPhsIm4TKbXP/Ve3
         mBWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780689709; x=1781294509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEHXC2mVOZGOk1Rk4zHY/GF28qsrwAqEm1e5Niz9baw=;
        b=EdMz56k8jBdKXFqF6c+LM+fAJU0lByOE3P94N0sRrP8gvILfwg1lncBjHNru8w5U0g
         nKGMRehQelcbmG0vP3Yh+R3v3a+JyWsjLy55WbXFF6rOQtHfdvHW0DyKJ4tYJh23vMOR
         3AqMjx1JYBjeNDwI37v9y3Zkyd1VbvTpST9g58OugnGzls4XwqGvEgE9eNiaD5XCeObb
         b6VBet/vjh9C2PhijHH1aMjZsec/xMQZEBAyAEQtpRRrgGGR+Q2QD4H2q70oWqkj7uT6
         LYQwJ9J2WwAyC9noFK4/ULK/QzFPB6Nj3odUDBYDiTTkGtUkizYGRmCZnAossxVvyyzj
         sGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780689709; x=1781294509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YEHXC2mVOZGOk1Rk4zHY/GF28qsrwAqEm1e5Niz9baw=;
        b=ZyMbbBwirpPnc4ajuy/pIungNFMN3fF8thIkQvtp+hbsOP7il0WoE/JG9uzcYRVSFx
         91U/dyaaLqQybfLJcn7jbI3ApoEx9pTn9RFw7lzTEb5H+PUX3Gn+KBudRJ6PBujwzRNK
         vOa3iMuAYh4dVSC6+suy5g1Vrg6g90rv8m1HZlnkI2/aCxxZPtt5pO+jOuwpq04xhGHp
         ffcHoEkTMTYXd2JkKvdbUid2i3NObzhtxjxjsBD5EAzNesRBwygwRKzcoD0CYok2T8F6
         5sgYvv+GRmy2Snej791anNpEe4uVGgfDAItEp3aG1CxN/G4rQmyYoxNJOmeNexrYyVeI
         NnUw==
X-Gm-Message-State: AOJu0YzimRzSOiz2x/tD0YkmobDwhZQPPwn4nUh0T8nhL8hY9NPXnhjf
	qsR5rAb1AqQL4k3e09oP1W1QyAEfQ4wglcrh6Xwg6OhmVxpU9G00hGTjzrPqWrg1qiIb/gjYAmf
	ULcr7rnq4pdc3geoc1lmkt7jeU0vbzgk=
X-Gm-Gg: Acq92OGQZnBhWYntRDnK1CIZmi9dPZaGmhnwEc8vRUO+Tfg00mMRdc/475RQejLHVYC
	N+TqZid/fxDlMYLYxAz3dOzmDZ4Ih7bkoWwMNUboqmDmQZ4URq+XU3fEhh6xQaieKHNbUPx5gzm
	GIToqoVc8TvpDZNFX0X9ZSQjwU/TSqD1KeyenFpT5Et4PO8HdKZdoeGCzE/rzXn6KmJeiZKBTYF
	B3i5Phjz3J1Lie0lOTxtu3ZTL09ySgokrK83V4xw6mF7DBCyPrzuGdJC/q31sbimSNjd5aIZ/9E
	JPy/NZm/JHx8AYwoIfSaXoX4OHEthXDnFw==
X-Received: by 2002:a05:690c:6b04:b0:7bd:73f3:7a67 with SMTP id
 00721157ae682-7ed107cf391mr52358317b3.28.1780689708955; Fri, 05 Jun 2026
 13:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605183551.969144-5-ameryhung@gmail.com> <3a3a97529e6a13b4220026c0d97d3c2341a503e3f815e0c67f1cc6a8ba13cab7@mail.kernel.org>
In-Reply-To: <3a3a97529e6a13b4220026c0d97d3c2341a503e3f815e0c67f1cc6a8ba13cab7@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 5 Jun 2026 13:01:35 -0700
X-Gm-Features: AVVi8CfKlJUM2adC1GCY5k2YYjFmyeBHic4clMKFl33ELz2dAtmJl2Cjsf1RD1c
Message-ID: <CAMB2axOHwmz7OWb92va84L09Ag=fVmjqBMD6Z=YspvUr9476EQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] bpf: Remove WARN_ON_ONCE in check_ids()
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 12:08=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: Remove WARN_ON_ONCE in check_ids()
> >
> > check_ids() warned when it ran out of idmap slots, assuming this was
> > impossible because the slots are bounded by the number of registers and
> > stack slots. That assumption no longer holds: referenced dynptrs acquir=
e
> > an intermediate reference that lives in refs[] but is not backed by any
> > register or stack slot [0], so a program can accumulate more reference
> > ids than the idmap can hold and exhaust it.
> >
> > Exhaustion is fine for verification correctness. check_ids() already
> > returns false, which makes the states compare as not equivalent and
> > prevents unsound pruning. The only effect of the WARN_ON_ONCE() is log
> > noise, or a panic under panic_on_warn. Drop the warning and keep
> > returning false.
> >
> > [0] 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix d=
ynptr UAF bug")
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> This removes a WARN_ON_ONCE() that can panic under panic_on_warn, and
> the commit body explains the idmap exhaustion only became reachable once
> referenced dynptrs began acquiring an intermediate reference in refs[]
> that is not backed by a register or stack slot.
>
> Should this carry a Fixes: tag pointing at the commit that introduced
> that behavior, which the body already cites as [0]?

I don't think a fix tag is needed, This is just to reduce noise. Not a bug.

>
>   Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fi=
x dynptr UAF bug")
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/270340=
08594
