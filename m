Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C723F4841
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417317; cv=pass; b=TvQF9SK91zN+6f0iPcpta5ogNr5peJM11bP8AsiZBIDk7HcIGEnahv/Zaz/ZeKUnk4chfqta9fvr8iTj464YmU233oGxf8vslj7UnrzL14nZuKevBc0qjwdjY18ANqYZEVb46ufGhxD4UsrxunweTs26UfssZozSZ5xgLU9h1Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417317; c=relaxed/simple;
	bh=Cdzqpc7AKe0kczRTfDfZtBhK/jHqi5wwRmxCKMBaLoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgUyBIEkK6B4iKXWKnr9+/6zaL+3a7M68b2MPHkk/EHKHnL+cVNx3RO+QQllxrCOKDGbHi8ZaQF5FDGQmiH4h58mtcCltwVyoIZ48tEYxhPW5KocLnEyr4YynZ5rozPnpJK+ZOTQAl4X62aq9bxm1haBLNcbaVu/UE01ZYI5zrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXOPM/PZ; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXOPM/PZ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-86a25369f16so2940458b3a.3
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789417315; cv=none;
        d=google.com; s=arc-20260327;
        b=nySrBHo1lOC9ueiYr1IcTJ3O6vxO3vkGLd2sAXb5igk8y3Fhahhjhp+I5Et7wljbZ4
         QGRUQbqecima7XEmJaQu8DDL9t5/6VvnoeP8mTiPGrLBXvv1r1dUd8aAGHmOeA5qQ2kR
         /9mh/QruBY6mpgzzLkT8tYa4kfBcXV2Y+SG+Y15rXcA2kbagbEU8DEUJmKzl5nb7AVxu
         9Fbjtx8e5mXzuJ8zzJBd/YBu3y4eBPzW//JegsqlVOqYw8Jnu1PvP5DHsL4IePgIxWbo
         oHDbyBBceUZ6OI9emm2zCoOY5fw+vwhRypLkiQRgILNhviZPKW+H7qaRAhcKhl5GmSe1
         02aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JV62ZslcIvwytI9YcrSBLFLPljM2c3GaRkd/kE34k3U=;
        fh=n/rXhmC8U59o0vOs1VozahFQopCaPu1wsMQhkRiDUEc=;
        b=EvbiQzYSYcT79MXI1HxDY0wZVYx5G/MSplXG6YpjYl0lLv7WrNI6NIF/vcYbOJILgW
         /t3NlifQvs3z4wgpOPqu5qpicxHmy+OFSHaI/sonh0HKO77Gth9jxeEylAn9uwppN7hG
         0+jWrBetmLTePI9BB+LWHDuk7p92mN0i2A3NmWkx6aHa2MOvR7F0SkwWYgaRxoTPm6zV
         gtJVAG3w3I1yLJJqGQqRg2Hed1ubYXNSjx2ZRlTAFZZsCCkntERqDved/cIPp3bzLoRT
         5esKpDlTxJ11nSlcdJ1Ysu9gJD56dS62GR1UydpMkX8MqpSdqe3S9b1dIeIO7/UzlyMe
         /nFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789417315; x=1790022115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JV62ZslcIvwytI9YcrSBLFLPljM2c3GaRkd/kE34k3U=;
        b=DXOPM/PZK++jXvzddZyNB3hV1JEVerWS7tqgalJwdRb9bGUwdgaFiLbqghODiMz3U6
         Di+Kt2xbwYOyp6GFzsZszC9Q7oR2j89X8zI03AuBZiSZ8cta2jyWS6dq3Kx3Ay7FNoIH
         tlWx3jA/iq3IXiN9zwWDwskopeCJbm6oLZY+uhtj+YA/lW9x81iEjORBMt3m/X8pROAG
         CfoA4rOOY9+p+TzOMSKznqahl9dYIaRw3Jf1I9XADDAkuRrEsMrimn8+vQev8uxeH4xw
         KCjiKz/ioW35L8ken6zMjiCDz4iZiDuGqSAy57D0OnVbj4Hdq7828AbwvlA/uyB1AQEb
         kyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789417315; x=1790022115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JV62ZslcIvwytI9YcrSBLFLPljM2c3GaRkd/kE34k3U=;
        b=yXEvo9YKZ9ycC6RUFnorJ/WAwamYjf5Kqupc+syOsMWve2+A+QWk5g7Og4jg0pb/NX
         mmhYYaZ/s957bjDhGN9KHiGD4Y7vB/0zqZiFeL0nS6TE30bvdNxlwUhSQCSGFA4UvbVf
         tDPneUB8wT9A5oDioGSNl8ZKwfpy047b0JfTq9q4+8cFCNunMkYZGRmJk8KWPBJansvm
         KokZ38i3fhnnxP5bvKV+I5EShIDWApjIWmAmwVnc4wX3+tjVMxU+zMoV5TutICrI/7Z8
         TYjn0oQ+Duq8yQd2eLN5UDSEPAU8gXdtVWxyecvvVVWaeStOl0NVpIKZxi5H5d6gce0G
         TLbw==
X-Forwarded-Encrypted: i=1; AKwUvBzBgO0KXytjZI+Oib46cYJwE83ojTAHs92PqV5GeaqtMfr2mklI7kDk1xQoz08bjJGGDCQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nVUWi395pkt/84fEMs1y16ryTppvbJ3LqCAUqYpa0RTAWZ+9y6
	6dQb4ZwRmgrdE+unFn7RrkT+OZ8InYa4jqdFg87LsqmNGTAfjXGj99DXLIq0ifooutkLY6YMflQ
	eTfNPhv+TlgePVQ9hn9lqXfuGNR9Cck4=
X-Gm-Gg: AYBFou3iDHMxNR+TXw8TstrVJcCVkfKWdxbUq5MkafQ+zi+QPhic15GozG+LXO8duXT
	4Hom5axhSkdrW0aOjsWPzt9BdjHQJNHNSlVWHgHN1piTmCXKZsr4cVNMtdgc8qw6X9teLrog0RQ
	ChKXNMeD//EW4Ibf1KkLNO3jO2VLA5q+sAFTyFbLUCKhtxo9gtMDu7yJtq8PJPwkBOGEf1QqlLZ
	xzzsV2PKMRplWLae4zutPHDcUgDYQCnh9BC1bj/YM66DriQZ2T2VZKrgl8/fjdWKjpBEAEMLmrQ
	23nxyXsrBkK/VJ2ik9pdal+FWw+a38WdVhCb+fDeJ4yHBNyCWui59nistKvDntStuOKw0gXSN+d
	rM5DrWio0YZWRKqwZq8+vDIT3Hq2yRRuHtZRtue7sEDGSxt3HVRUhD8MvNNcVx8jWze9GYV5HAw
	==
X-Received: by 2002:a05:6a00:f04:b0:857:4dea:e1dd with SMTP id
 d2e1a72fcca58-86f851fe665mr7993128b3a.14.1789417314693; Mon, 14 Sep 2026
 13:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914131701.2529725-1-memxor@gmail.com> <20260914131701.2529725-5-memxor@gmail.com>
 <CAEf4BzZjrWzQxaZ1kXyvXHXuUFDsgZe6NwQHH6seqfoMLpJLZw@mail.gmail.com>
In-Reply-To: <CAEf4BzZjrWzQxaZ1kXyvXHXuUFDsgZe6NwQHH6seqfoMLpJLZw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Sep 2026 13:21:43 -0700
X-Gm-Features: AcwNN1Xbu69yejrrz-K4JXyHVU7mm_BUndmfj2wwI1elOwW_Bm0IATinhlsKq2c
Message-ID: <CAADnVQ+SOswCXzZbCbjtjXQDd++Zkrxpg4k3gHMsMPsN9BRQEA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 4/7] bpf: Restrict CO-RE poisoning to relocatable instructions
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Nicholas Carlini <npc@anthropic.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 12:54=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 14, 2026 at 6:17=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > check_subprogs() verifies that each subprogram ends in an exit or an
> > unconditional jump before in-kernel CO-RE relocations are applied.
> > An unresolved relocation can then replace that terminal instruction wit=
h
> > an invalid helper call. The resulting fall-through into another subprog=
ram
> > breaks the CFG invariant used by postorder and stack liveness analysis,
> > which can write past their per-subprogram arrays.
> >
> > Handle instruction poisoning after the instruction has passed the same
> > class and operand-form checks used for a resolved relocation. This reje=
cts
> > relocations targeting jumps, calls, exits, register-source arithmetic, =
or
> > non-immediate loads before they can alter the control flow. Keep poison=
ing
> > supported instructions, including both halves of a plain ldimm64, so an
> > unresolved relocation in dead code remains valid.
> >
> > The shared relocation code applies this restriction to both libbpf and
> > in-kernel CO-RE.
> >
> > Fixes: efcda22aa541 ("bpf: compute instructions postorder per subprogra=
m")
> > Reported-by: Nicholas Carlini <npc@anthropic.com>
> > Suggested-by: Nicholas Carlini <npc@anthropic.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  tools/lib/bpf/relo_core.c | 28 +++++++++++++++++-----------
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> >
>
> Kumar, can you please see if we can move check_core_relo() to right
> after bpf_prepare_btf_info() instead of trying to guard against
> malicious CO-RE relocation? I think what CO-RE logic is doing here
> with poisoning is correct, it marks instruction as invalid because
> CO-RE relocation couldn't be resolved/applied/whatever. That's sane
> generic behavior, IMO.
>
> The fact that this breaks subprog validation is more of a sign that we
> do this CO-RE application too late, perhaps?
>
> Also looking at current bpf_check_btf_info() logic, seems like we'll
> skip CO-RE relocations altogether if we don't have
> func_info/line_info, which is... fine, I guess, in modern world. But
> it certainly is a bit orthogonal. So check_core_relo() seems like a
> stand-alone step to me, which hopefully can be done very-very early,
> so that no matter what patching we did will be properly validated by
> verifier.

Let's do both:
- move bpf_check_btf_info() right after bpf_prepare_btf_info()
- check that relo applies to relocatable insns only
  and hard error if it's not.
