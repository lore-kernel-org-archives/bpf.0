Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030D93AE196
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616835; cv=pass; b=mYk+GNM+vJ5ugzTu7RHxuArMlwNmn8K4A2siv4iXByoqD4dYYIP4VRgrwPwUBrxCMQvI3qsCEJ/InqF1kmGMIU3YIg2t9YXz6l7wlEpeVT9dp87KTYpfYiy8wGoPdlGmd+yKmSXCKnff242SwNRLJjUL8oKX25vlozFyOOdvTcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616835; c=relaxed/simple;
	bh=W1UGjXUOUr5pw5lZpfHp70Rnm12IZhxZ9f4qzZHvZdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWr6LZZL7+Sl8OerPkhWdOuokEhajJrnMIFtIAqiIR/O6JqCu2qc140MnDK/+Mw0b6yZtg+KuPTYtd2XmUcvCtQmZ/GGGCdzADYRye7DfJtyJXLB9rpYhBWwHzh3DfIWfsgM2wktJrGK0+ydDEgqxxaK5zvbpoiJ97GzNapI5M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EE+mRqvL; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE+mRqvL"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7bd87e5d8ffso75377897b3.1
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 13:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778616833; cv=none;
        d=google.com; s=arc-20240605;
        b=BAqi9zBwxquEoB+p0CFAeaKRV1NszD5C8xrlvZfP82NmhZn1gehXS+EmypKZ9+XNtR
         hkUCyz2q6120im1I4oXdHv9TK2XSQ8bfWNe6EfM4tEPhkGZ4KxxdFQOp3FfrMBV1JeuJ
         HgXZa9UIOnXIM5cXeBZLhHA/XlQisvy7HJJgSgUf4/lFDueipQKTOAMTtnQsrGg4Zk26
         iNyaNYK/8R+9VtO0TJWt7E0pAq3tgoc7ZNY7hRNmI4Skr+O2OEpYT36kegIJpMXFqG9E
         94O7BtAYzC+v2nItcsa+yxPQk8YoxyMo6CQxcqSgbzXqZ42plYxHw2NlzXTTQNdhMJ0A
         jxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=18RQIx270SijuQPvP2u+5KmQApCCLoVeABosefiDH1g=;
        fh=bCoLUvtAu1D3hCyKghQ3VLRStVvdR9Sgh3Xhk/87lZg=;
        b=by4//DkjjBHvrR1Fgbr+BB7TZkzJ4vT9zfsWBD860yR0nFi9DhS++9G0Mmisgj50WR
         cnxwJu8lxbJwCH0qj6PEbFtBUOiDfTjHsI3bsKCiLVFdGnnvB2pTvokupN5AgO7fBZft
         YzmwCjjvhSyHJqgMsSmatOr8y/wM7XTbbQ+bPowCzMRFB4cXJTN6Hs0q+l5VApqD2ryX
         Rs3ieKV4RYxb4F7oP67Nz3SUY96tAEl2C+DWutNvQoirZBtXHbqzZQl4UGATkMArFELK
         HqhFtt2UychFGcCUtT5y8L+iINmQHF2m5XJKmQr3ZOuULcea7hi6Bv4OWYnhCiT8r9lt
         B9Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778616833; x=1779221633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18RQIx270SijuQPvP2u+5KmQApCCLoVeABosefiDH1g=;
        b=EE+mRqvLxG07xaQ3nlhUcnyffLMKoyefrfZ/jn0/KPpzlX7c11L7zb48YEOm2HyTDx
         ZpsLX8fD981bigHfB4au2c2IfqHOw1yt93yylb5x9wRThJhZUucTuz4v/0BoqCC3I4nC
         i/9H64cYNJIkJRI7xLVsA0TgZmFUzF1DeC8AqfXZCY6JHTtcnAAdU1Aj/foJWgc2KCWp
         FYVWgourjlZZ8crwELV39epfLYUNHLn5O3ozE0wl5dqMRLs3o0zsEzOqb9N1/L1kBBVz
         fHanTUoAnkJOQNTjC2uxPqGxb90X3DGmeW6+g2JIaWONJEpaN3kalGftQK/kOM18Z1KE
         nL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616833; x=1779221633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=18RQIx270SijuQPvP2u+5KmQApCCLoVeABosefiDH1g=;
        b=EOSEyNRObCcA8F9uzCg6sdNNQCWzmbTEcaAx/ZMH/4wdHDKW6bLpfjkL8awDbFA3uv
         Q8Zu7gJA6BzFQFoD4QTOtK4pShzQIow1a23VJN0i830nWwOGYB89mGBvTGVqkzM0hN9+
         kN09/xexWlPeJE0gPryoL3oZBVBr7s6yXoAdzKFeerEclmL2AlBHp2mjRgnNFbtsm6IA
         6hcPlHBqlV55hvp42oUNDEq37dFH+EyZMzm0qXOVpvoZ2QA1VIifSYY4/B8i+3EpCFpV
         7tcn0DAkrOE/T/XQyaaLj5ubq5cyzsukwBznBsVDtzSIPf79qtNjMHlhR4kfqfo0GbZD
         gzYg==
X-Gm-Message-State: AOJu0YypvmEjhYOeMmwiBKtU6KFN4XvUKaiMq388toIyf4Dv7EYHXi5E
	hcltsk515WGVRj0HifTYJB5RdmnBUC/qEOri5uD37MW7z01p/xi0o8owTYNzXon4kMZOQoqIZBe
	d7+c1gmbOWsufiWB8e3gJ+QJYcYg2duM=
X-Gm-Gg: Acq92OFnuTxh67wzvkW2zqoYqWP5xk/kLO14vHpfnwbi7COF7txA0MGK5q3pK43bHH1
	Sukc3dYukRPhv6ASh7/WS1qPQgn5m/FdWflcrv9R0Uwspb7UlWcvNX21tVyerwRMS9orLSQ58w/
	+l4MpBi1aFobiguJfbRRMqTbujrLnruzHNRhJnes8lUxF0QIxSYxJusWH5Hx01Ws65Qv7fEHRKX
	0RSWtAP0NOG/41V0pqIVVYSteeZcg6yQCdi+XDqyzgWlvN2UuOKL8tY1CH7roJQ3xPt6WXSiZm0
	W2Q3bLYgdyLThc5e8Segr14EdhntBjceqw==
X-Received: by 2002:a05:690c:c4fa:b0:7bd:76f6:b3a6 with SMTP id
 00721157ae682-7c50d9488bemr47523917b3.3.1778616832777; Tue, 12 May 2026
 13:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-1-ameryhung@gmail.com> <20260506142709.2298255-2-ameryhung@gmail.com>
 <7f0d8cf18e3e0d60751b2453815a1f0ea62ca928.camel@gmail.com>
In-Reply-To: <7f0d8cf18e3e0d60751b2453815a1f0ea62ca928.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 12 May 2026 22:13:39 +0200
X-Gm-Features: AVHnY4KX0SJeKhrAjXoRIRocx25IwiL34Yyv_drtrnkeYUmF784ybo8h12y8eRQ
Message-ID: <CAMB2axOVZyx4Z+gHJVEtfteTESFQBXL51aCM7UDPw5zwo+wgqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 01/12] bpf: Simplify mark_stack_slot_obj_read()
 and callers
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 10:17=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2026-05-06 at 07:26 -0700, Amery Hung wrote:
> > Directly call mark_stack_slot_obj_read() from function processing
> > iter, dynptr and irq_flag. To prepare for unifying dynptr handling,
> > dynptr_get_spi() will be moved out of mark_dynptr_read(),
> > As mark_dynptr_read() would join mark_iter_read() as a thin wrapper of
> > mark_stack_slot_obj_read(), just open code the helpers.
> >
> > In addition, since 6762e3a0bce5 ("bpf: simplify liveness to use
> > (callsite, depth) keyed func_instances") has made
> > mark_stack_slot_obj_read() always succeed. Return void and drop the now
> > unused bpf_reg_state argument.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > +static void mark_stack_slot_obj_read(struct bpf_verifier_env *env,
> > +                                  int spi, int nr_slots)
>
> Nit: this is probably a leftover from the stack liveness commit,
>      but I think that a better name for this function would now be
>      mark_stack_slots_scratched.

Make sense. Will change it to mark_stack_slots_scratched.

>
> [...]
