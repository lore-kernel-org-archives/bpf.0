Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3525275B0
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116900; cv=pass; b=nKvcUdyOeWbNCi6G1yJdFYHHV/SbtTFlE1jWZtyc0t9924B8huSccQuj4sKGedRu8+0Ta3a3qFowy6f5Ct6LtW0soQ4mjXiWSEBe/q8uth8kz7fYGlwN6WtH1OYqr5CKrmVyG0OgvBAMoDb1ToGUXw7W0AJN8v/s2QqDmU1erkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116900; c=relaxed/simple;
	bh=XMksKNqknHGvAxIQkpO2ziabukN5n22iaTUCcWfVNCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPOM0HgsAK2QHbx3+js8Objhf87i/e/KYD2xfwJ4dYERorEqYHb9lqVKi07EXtLfKC6SaDtO1Bg2DBud6sHulsT7tI+USnWYzbsDgZ7er9q26o5ZcdN4p7a57FLiIFEtALXLhiyUcBJ2SxosJZtI0u5wEd08eLextFvGITzQAtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAdZCq6Y; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAdZCq6Y"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so165959a91.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 15:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790116892; cv=none;
        d=google.com; s=arc-20260327;
        b=p41Th80F1b4yzi6RiQpVV1+4FU3zftLaGfe2WKosM5Iy57NOO3EVgZcwukiB6cXlL1
         iUL3f3LRwpqIQcz58iAjTO8f/MaVnWXUQFicvQ3LYazs4FIJOwHCG2mjnP+csi4+458Q
         VLrlokV7/TDtKx1oEoyMNw1MKpzPXBBKfogciXYvCBV24yIrtr1UpcVRQeapKJZrj6Dj
         aNCdGsnB2fujZnmalXn+TotXLQejxf/7VNDHT6f6hn/Eih+kTPz7g4NsHCeXuMdiaJoN
         x4670Wr1P5h0OsE0W4zO09dzkU6zsaW7hjZFuFuMsUftHC9NcvSP9/eyOl4x0ckJzAK+
         C5TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EifBlIWLbbiNu1pyTH5rLVkrLNZbYLjk13b2Gi+S+cY=;
        fh=20VC1VqROOFsR3P0uSIskp7XIoQXkfQooZNQYL2iR3E=;
        b=R1j9sSQovo33Mcd5RsdJowLkFWPR3piNaWs0wVZ1zxCDsKiR8jbYKOtehPCl8+05sL
         KeZhUWq646C0JrFNZ1taB5BJa/kPFnN8XRSsRirZSGmQAhMhlCqLu0Vl9EVI2D2SYGUC
         wLQXjlIEEi55Ok/faoviT+xSYn0yjyxrEPXtQYDscYwO4nPXLws57sNIqL2Rn7kvGukk
         hGW9jQ89QGC1j5j/LEWaqqNDbpQU6YwctMJ8I639TInDA5eTCK3uDpx55kUe3dGFft7l
         gzP55Z3MR4/U4prSy/nPymvobZSSBVGurL2BH4vQpN5VfQhcYjNxk/Ki/7iIm9Wg8SSW
         jqpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790116892; x=1790721692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EifBlIWLbbiNu1pyTH5rLVkrLNZbYLjk13b2Gi+S+cY=;
        b=nAdZCq6Y3nb99AlXrAzEH6iyWM0tz9i1kwlJqyF0SJZxBBkj9dL6I+5EDfeUMcwASY
         pEvL6J9rfc5cFG03Vzunv0qitINC8DAppGHNMzUJPd1o2b9fzTZ5MU39p4wK+46Lx07r
         kjW87AUluoaVe7KI8fS0Y2WwDvbS+glftP5SiAFBzHIrTvzlwPm36rxSc2r+GL5mMKgu
         MdZImC2Zu2nHwNp5TOOpyeT6w2eENqMiBFEH3/lGeXNrNha+RGl2v86A3GrmwhsrqmcC
         CcjUqhcffeZ4FgMcjSM5PM3hs+02v0G7B8OzE8i1JKqJ9xRnr++5vcAQIE3KwG5oQTRH
         om9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790116892; x=1790721692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EifBlIWLbbiNu1pyTH5rLVkrLNZbYLjk13b2Gi+S+cY=;
        b=H0n0TPxA5249XPGkInCWlSESzXpXNeazTJrfS7WWhdfZKWsoDkOACcH05OZcs8UWM9
         or616HLTQ61+dcBuLaeP9SuHkD5Gr65lydMbGczgQhB6m5aDU/BnGNQE/CLCofDMjzJy
         jdImOqIQKOxtdeakO12wAhPljItre/K8nAyI2TeqAuBGY5vIa3+9IexcialQo3x7Vqjw
         33jFqdPSIA1uVKuEUGcKGg4pCoBCKy5U2AB9OxMYdxOUoJbRiMergtioAiISLPtKubIF
         9puw6bsMiMlwZlNhRdJEw34cekrRqAnRNpuDjB7ibI2nT0rX1SFDZG2YsWlqEK2jv7qD
         yFpg==
X-Forwarded-Encrypted: i=1; AKwUvBz+7bQF29Mbx4SLepEz0+mS+5PONHNrIBT5IbgrrCfH2ReTTvfdUg3GqxxBC2geR0Jj1e4=@vger.kernel.org
X-Gm-Message-State: AFuF++n1kx//3iFNQQF32oGTYrTX58lzySu968GQotBN2CdzcEhOc5tJ
	yWGtJKsRxZY+kj/R41kGBdS7Bfv7n/3X/axvOECMi8ElUUVodz1AJPK2/GAwTwW4Cs56AM4OP9E
	z8RGPrNo0mYvqs0LK693sXBXiBl2Otqc=
X-Gm-Gg: AYBFou1itb7865iBhtXOtwZ2s3bQDWN9XqazK39Wm6kOEbBRGl+omOJcVX5U/4fu1kF
	r3SxFmZtUFMksxss64UNlWaWSw4XvjUiiK6BNGqO+mR8yHbnsrXgWkCQenj2vd3b43bv4NXgKoo
	ILFeSRqOSE/kDb3RAB24WrC/xpT7dqakz5oScK28MWS99PDdl66Ix2mts5nPahY3lVP4PODeTMM
	8aBynAOe1fKhghSP9eX4qPQFZl1EfzT/HmHcXYd/7rZ58o74AX+QqTyx0xw9U6eT1pbw74ZuPA5
	5oQERR9afF9Cvchcy9g4FfmAfxpnljvlpTWDVTc8Qo/pfDfaiTYShtecv0n3hdm840fD7N8y625
	sQLbSAqL4X9tfPCexdD8UVbx1DG4n4fovEBHa3DLYsmR3pPmw2M8d
X-Received: by 2002:a17:90a:1609:b0:3a0:8050:2ecf with SMTP id
 98e67ed59e1d1-3a080503167mr173387a91.25.1790116892014; Tue, 22 Sep 2026
 15:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
 <DLLGYV7DI406.JRNDNAZ4S29I@gmail.com> <ddb3c0eb-2a95-4af8-a9b9-a0624d38a7bc@linux.dev>
In-Reply-To: <ddb3c0eb-2a95-4af8-a9b9-a0624d38a7bc@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Sep 2026 15:41:17 -0700
X-Gm-Features: AcwNN1UI69p9OfuPaja62sel_0aSwzvzcRKESR-BvjHad32ywPLzgeMec1HUoDk
Message-ID: <CAEf4BzY4LQ7TDCpxuVDwCzLZDr6gDYP44UwLEjqtcdRBj+bT_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/6] bpf: Scope callback arguments to their frame
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nicholas Carlini <npc@anthropic.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 11:13=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> On 2026-09-21 6:55 p.m., Alexei Starovoitov wrote:
> > On Mon, Sep 21, 2026 at 06:03 PM Ihor Solodrai <ihor.solodrai@linux.dev=
> wrote:
> >
> >> Neither has a local fix: both arguments point into a helper's own
> >> frame, with nothing longer-lived to anchor them to.
> >
> > It's the same problem as a pointer to callee's stack.
> > check_stack_write_fixed_off() deals with it like this:
> >    if (state !=3D cur && reg->type =3D=3D PTR_TO_STACK) {
> >            verbose(env, "cannot spill pointers to stack into stack fram=
e of the caller\n");
> >            return -EINVAL;
> >    }
> > CONST_PTR_TO_DYNPTR wasn't spillable before 7.3, so nothing depends
> > on parking it in the caller's frame. Reject it there too ?
> > and then no need for REF_TYPE_FRAME complexity?
>
> If we focus on the nasty bpf_user_ringbuf_drain() bug specifically,
> then yes, check_stack_write_fixed_off() change patches it:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d62c0f74cff5..f261423e9282 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3668,7 +3668,8 @@ static int check_stack_write_fixed_off(struct
> bpf_verifier_env *env,
>                          verbose(env, "invalid size of register spill\n")=
;
>                          return -EACCES;
>                  }
> -               if (state !=3D cur && reg->type =3D=3D PTR_TO_STACK) {
> +               if (state !=3D cur && (reg->type =3D=3D PTR_TO_STACK ||
> +                                    reg->type =3D=3D CONST_PTR_TO_DYNPTR=
)) {
>                          verbose(env, "cannot spill pointers to stack
> into stack frame of the caller\n");
>                          return -EINVAL;
>                  }
>
> However it doesn't cover some of the new test cases:
>    - user_ringbuf_callback_park_data_slice
>    - user_ringbuf_callback_park_kfunc_slice
>    - user_ringbuf_callback_park_clone
>    - user_ringbuf_callback_park_clone_then_slice
>
> (not counting the diag message diff)
>
> The original suggestion that came with the bug report was a
> cb_dynptr_id field in bpf_func_state set up in
> set_user_ringbuf_callback_state() and read in prepare_func_exit() to
> release it there.
>
> The cb_dynptr_id seemed way too specific, I didn't like it. So I've
> tried to figure out a feasible generalization of the problem, and came
> to "verifier can't track a lifetime of a ref tied to a frame", and
> then to this series.
>
> I think we need to decide whether the REF_TYPE_FRAME is a useful
> mechanism in principle, and whether it's sufficiently generic. It at
> least covers the cases in this series and more.
>
> For example AI also flagged for me parking the vma argument
> (PTR_TO_BTF_ID) of the bpf_find_vma() callback. It's low severity,
> which is why I excluded that from the series, but "reject a reg type"
> wouldn't work there AFAIU (we would break many legitimate programs).
>
> Opinions?
>

It does seem like we miss a reference representing single frame
lifetime which we can then use as a parent for all things that
shouldn't survive past the current frame. There is a separate fix
right now to invalidate dynptr created in subprog's frame. Seems like
that one should be expressible the same way: local dynptr's parent is
"frame lifetime" reference.

We can even relax this "cannot spill pointers to stack into stack
frame of the caller" error, potentially, by just turning that
PTR_TO_STACK into SCALAR at exit from current frame and let program
verification go, no harm.

So for me it seems like a necessary and useful addition.
