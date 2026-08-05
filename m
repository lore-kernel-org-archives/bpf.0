Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945F39061C
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955003; cv=pass; b=t2furxhGgFob3d0xLcLehPFBw1ZYMYvUXqDFs5y6ftfXoP5hK2YUQJQsEAAGN42GwCimcWxgxxQe4v2CJbj800aL4HlXCGWkM2XNwIs1qdEPnR4hm8YiNe7DHgVvdIh/tSs23PIIRcFaM9b04lgn3J1z5sPOyX6ENkKgacDN/Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955003; c=relaxed/simple;
	bh=ijz0w/QKzOW1jTiQEYZJLdPV5oAMBIZLEi9qkxfTm24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S69jQ96TnhelRhG6b7pvJb5NlsRD4ypzyYb3p9KcGAaIsk6NumFQsDx9PnvQbEodO6dJXiudo5fUEK4AlecMwWQsRZnT036Hnk5fMCm8VKADoDxWtg4Bf1QAJKUvzg27XYfKtjt0ZfoVZYWZwlHRza65cFWQLVms4hlepJPrks8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKO6av57; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKO6av57"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso1642102b3a.2
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 11:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785955002; cv=none;
        d=google.com; s=arc-20260327;
        b=HLsKChQzN5DLBrKOTudW0j/P5HHJarO2g7GIgyMrbcysKKSBULT3l81jmjiNPFKOhe
         5vVfAdj9uDF4rMix98iJa/8TV+VSl+aRQUQjySMgOae56Ntm0tqbBbx15bovYRdfq4+n
         LLV7VDARzC/6rogfp+DXDJvar/K0sris+9GgkmRcha2PX6mGVB9wccDfelkZZUqDq6jL
         dfpE5+C6fVlqlBOBiaERgxf+uiylzwtDdToyUc4e7Y3Uyrv2w+EH8j3/fObVU3S9GBfs
         HMnt79zLXfa9qJFjI3XYovEO3HjgnT4+lTQAHDVjquYLQw8558W+YA27XbIGPKyLNHza
         wT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zvPtfFlmYMWeI+NCmXYpyRdlPjnza5bEWaz7WF8LG9g=;
        fh=120TVk3ZQqc+flx4xNds2n6tHWp/MkgKR0bfHskO04I=;
        b=mQ5qguh9A/y0Q5Pf/xBWSkqI/v+udSLIk2tyROviuYU09NqOPIUZB8AVgqMjKVgPjz
         gUIjeAi78fRmPiCOagU62gQxX0rXijtUlanTRZ94dAu41iJpawP5Q1mGfMCuXzsqTQ0X
         YLS9CPbMYnakWwJ6A25KlTktzW6mogfcca8eDLMWodKX/Znjd5TUwHJZyjxuLoy1lDrZ
         vDQZYxlGHn+mEjPvqo94B37bzT6c8HhtKRcFuN4QVVhJJChsF5p1ftgfOx6WOkPfJT/u
         s9+8lF+26m7PvLqpUkpenuSayhMQgus/2bbZgOLCDe5jVL1HekPuNdrzRCtiL1ZtQ6hx
         FLXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785955002; x=1786559802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zvPtfFlmYMWeI+NCmXYpyRdlPjnza5bEWaz7WF8LG9g=;
        b=MKO6av57K7XR2iy3+uw54un0tfnki5yPqwAUG28GpdigCiKH4fMRXMBMZKMk92FZoO
         Bs4zgSSv4pi4yFOJivybMevGJdtneFZYxCStQPA8fvSmIxxEBe3gNHDjsb5bKX53IMC9
         OG3J90C6Vq2k4ZudjynXuacFTUbTi3xv1sINi89Z6vjVkmUOrKGEHUzmuysZ8MADWY+Y
         0D/ta+r9U60/NnzDqxh562ySd+twrEJzlav+uQ9JN+1A2LB7jMUn2BH5iJbxvjchAr/5
         2a/UXNlrOQT21OnjeHbtWPQx10YAwSe951kSZTe5bRRlxJ2GMRmbNDCg6miA1GTWte+n
         ovpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785955002; x=1786559802;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zvPtfFlmYMWeI+NCmXYpyRdlPjnza5bEWaz7WF8LG9g=;
        b=gAgowR6wR48+Ttah+Rh5t5N/w4aslUJEvXDUIi+W7Cx1K1NMis5mA3xVCjSFpPNfk/
         4CK/pzzYf1Mft047+Exyna+/3jUF4Fx/aBQ51uXPWHOJZDQ7o1BEWTqt7LtulqhBPrsU
         5QxfOe3f14KT7hAvMNx6YBBMUrQDFtLbDc3flgmViPpERX+tGD+SNwvWYPEUu557RX8u
         F+C0SddkybLB+m06Gc6XItERkrEeOLQkmutWH5G5m43H2zi40Y0hiJpQIxsaSEp2jSHK
         3lFnjtNzTV3cbmN8DWKhmd//30uRW101WefJ/JLQ66A/AZxwP86Iq8Uk9klgJV5ikWkp
         rN8g==
X-Forwarded-Encrypted: i=1; AHgh+RqLddmfHR/eE/3HT1E2kVhhjTAnqE9XagaiQduqT65BBRvYODnDqTZ6eIKpf68lIWdaoSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7++DL9kcCsH0LgE0TrcZ7zexFvpuf3S6otzol1JYfrwqNg4da
	KOOhZroTGmoRFKlMurVNwan3XTrhNHpn3LIJjlPaD39h4nh7QSb9XY0o88ULGdEi053cf1PMEC3
	w5MEFhGMDyFTWRt0C0U1R8VYu4RTISdQ=
X-Gm-Gg: AR+sD13nqRro9Nr6E3gr49+kiAyDpHFv4fIaTNoRc2iWUaVcoVOUrFFWsK+svy7wQV+
	k9sabyTV8AamOAWcvwlji1qXp6LnTukfQm4W6Ht0vffJvgQ9++ffI8iexLR5OX0vlQIE8b89HbH
	iBk7hMjtrN1AYdhqHtxzxvw0v3Im7wL2lqqKiRWynjKUb/PPcxL65ehNczY3VzgeeZtCHSxiTBn
	4Rqgh0Y2kFsRJaR9KuGA0V8QIQKddd4qX8q2zsZNu20vrC40Ua+PUt6eE0ocXMJAPAcwKloRRJj
	oRoP7ZjKPCbTh6lj7K0IRyAZArrVH7iQUp/sXBpiUHlz0BNHISLbkzlyWtJArstJdo4AyfGe0E0
	SakbVeQrgzcUnHEct16DpQEAy5w==
X-Received: by 2002:a05:6a00:e8b:b0:845:363e:12d9 with SMTP id
 d2e1a72fcca58-84f2dfc8f0dmr10566020b3a.3.1785955001543; Wed, 05 Aug 2026
 11:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805092843.516315-1-jolsa@kernel.org>
In-Reply-To: <20260805092843.516315-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Aug 2026 11:36:29 -0700
X-Gm-Features: AUfX_mwM-DMjyw6Lxo3YlY2SHsK8FSC8ylG1JulJn0FFqIx5RmPK9Am0OoFVG7k
Message-ID: <CAEf4BzZaB2+zZ64j54Gvb3tcZmG1fbNXyRsVefNwB_vbtQun3g@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 00/12] bpf: Disable preemption in stack map code
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>, 
	Tao Chen <chen.dylane@linux.dev>, STAR Labs SG <info@starlabs.sg>, 
	Arnaud Lecomte <contact@arnaud-lcm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 2:28=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> we need to disable preemption for get_perf_callchain and keep it disabled
> as long as we are accessing its returned trace entries buffer.
>
> This patchset refactors both bpf_get_stack and bpf_get_stackid helpers as
> suggested by Andrii [1] before applying the actual preemption fix.
>
> Note the initial fix was sent by Tao Chen [2], but there was no follow up
> on this since February, hence this post.
>
> thanks,
> jirka
>
>
> v1: https://lore.kernel.org/bpf/20260720085351.655075-1-jolsa@kernel.org/
> v2: https://lore.kernel.org/bpf/20260729083807.1588544-1-jolsa@kernel.org=
/
> v3: https://lore.kernel.org/bpf/20260803210149.296496-1-jolsa@kernel.org/
>
> v4 changes:
> - fixed changelogs [sashiko]
> - nr_trace variable rename [sashiko]
> - fixed Daniel's email
>
> v3 changes:
> - pass flags rgument to callchain_finalize [sashiko]
> - renamed err label to out in bpf_get_stackid_pe [sashiko]
> - used scoped_guard in bpf_get_stackid [Leon]
> - replaced trace->nr modification from *_pe helpers with length
>   argument (new patches 11,12) [Andrii]
>
> v2 changes:
> - removed several unused functions arguments [sashiko]
> - restore trace-nr value fix in bpf_get_stack_pe [sashiko]
> - kept rcu locking together with preemption disable in __bpf_get_stack [s=
ashiko]
> - clear buf on error paths in __bpf_get_task_stack [sashiko]
>
>
> [1] https://lore.kernel.org/bpf/CAEf4BzZwvAUgLwz-M0Y_NJLTmedyY9U6s7LrSmn7=
51hQdTP4Uw@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/20260206090653.1336687-1-chen.dylane@linu=
x.dev/
> ---
> Daniel Borkmann (1):
>       bpf: Disable preemption in __bpf_get_stack
>
> Jiri Olsa (11):
>       bpf: Factor stackid_init function from __bpf_get_stackid
>       bpf: Factor stackid_fastpath function from __bpf_get_stackid
>       bpf: Factor stackid_new_bucket from __bpf_get_stackid
>       bpf: Use stack id functions instead of __bpf_get_stackid
>       bpf: Disable preemption in bpf_get_stackid
>       bpf: Factor callchain_store function from __bpf_get_stack
>       bpf: Factor callchain_finalize function from __bpf_get_stack
>       bpf: Remove trace_in argument from __bpf_get_stack
>       bpf: Clear buf on error in __bpf_get_task_stack
>       bpf: Avoid changing callchain in bpf_get_stack_pe
>       bpf: Avoid changing callchain in bpf_get_stackid_pe
>

The amount of repetitive but subtly different code for all the
different program types to capture stack trace is a bit mind-numbing,
it all looks good to me (except that preempt_enable ordering which I
fixed up), I hope we didn't introduce any new subtle bugs, but oh
well. Applied to bpf-next.

>  kernel/bpf/stackmap.c | 314 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++-------------------------------------
>  1 file changed, 205 insertions(+), 109 deletions(-)
