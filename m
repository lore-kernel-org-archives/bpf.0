Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05F33A032
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 03:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779159923; cv=pass; b=u/rcUyFbMHzbJHeFuBy6qeLUbbsMdwVgxMAqsd82mG428JRjSjY+VI3l/GvAsURF54kmTJVaTP9R6M46/gaWGoeVfiQlV7UMkTp4DeUBClN1XMCBaRuWN+Ib2aWJQKFtwUdyLx/Hgjjyg/WRYvV0nerDhKzaEppbVuesDKIhVsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779159923; c=relaxed/simple;
	bh=Q9+bQYcgqcKG4E7oWlBQwRgnuDVbY8gf2xhQ0zFIZWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKwoRqiTvVGjiUftB7dNmtE2XpXiTzN/jw5ANssIDteQAWXLx8orA9u/+32B5aix+tGwb2GVufKWE3JbNpNQgK86V9uYxEFjO+eXFfaR84UjJrNYcj8FEUEXgec77SG+nC6kUQJf4CX+qC533X3NB6k7RpGI6EtMI3+wOQL7hxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0J72eUi; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0J72eUi"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488d2079582so28540395e9.2
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 20:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779159920; cv=none;
        d=google.com; s=arc-20240605;
        b=Y4rOnk3FO1IF0pYsA+e6QAsODa5riF8Z5bQ7id1/veyExSQcY2qaMp5D6DJvvMGkgS
         23gUrKERpESFc2K1ArkWfWHCXzjnBZCoajAE2Ys3qCt66nXVnzIO3/tcJu5nI+WxFaXD
         Mjl2JQ+eCwV5mBN2/WaHvKj33XLgwEY74iF5H9Grs7uaG+ZJdOKSAw02S2a6h7w0wyz/
         efqyaWynLYYCmo23OlF8NF8ia9DR0rZkzeCoSJRJb2YdqQhhMkpcn8lQjVkJi3H0sAr6
         6LCHZKhqzFU3iaAN9wOOnNev0W9tMtgDvviRF9rXWZ0cACfLcTUeT/Iw14x5YdATOLSX
         8shA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5fn5lXdhzUmR8WoBmOTDZiMW6X9iVCgyfgQJdzyZoiE=;
        fh=tVqafba1fmXKmFMvMhAwO0ragDJ0xhRw2l8NW7X3MkE=;
        b=E64GpDlwJBSIYLsDphR30j+uchQgyOdLhvK5TAXcOQTEg6R+ghfNVDHfpl4X1g7r+0
         JGK8A16CJiS2DuuAKgFM6eWsQYssbd3hBXCDM7UQwl5S+nhTaLWsAZbBtigB+0bNlO3K
         aA9hPgUW1VHL14Z6wFmLES5BxcnU9yM28HspF4mXvIOZZG7Wo0fBl2+Xo+VVULtB6Gk9
         055FFrwkLR5zOEsE5HE7YragwxckWm2BtdJJoBivcSC1FYgQBQzqNHt+e+GdrVRTTBRS
         897lWN+Qh95FHtruFtgJ9PHGVMsjJSNMe0gChk+aGK8w6ov7yPljIHGBUzheK5sln0Nf
         Gcfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779159920; x=1779764720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fn5lXdhzUmR8WoBmOTDZiMW6X9iVCgyfgQJdzyZoiE=;
        b=K0J72eUivS4nsp+kMiAcnWfSv3ffaIg+2HZ03qEJ57F4F0bL7DdJLk083LWVVEyNne
         aEGMQgNYDz+02gSHwfkuWReFfUnZlIboGv9lWneAQ7RMV1+2/dD76+JzsQzVkgvI3CDg
         /3HmKk0S2YQkQayZHdgJWuUVgPTu/2oDuX3eGoLfv/KpK829Ed0RN3HaGyNBjboNXPsU
         f4AX+Vy3TCL/jBNB+zM/C2c/PWn2LvGnbnFDU2USKzw/BlAkWam//XRqvWxwSSBUmfYA
         hWqZiao5fUm+5l/NWkYSv8E4MgXB3JA0jPTZxuFtmWll/gIA3248wkUWeuv61Zsro7Oq
         XnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779159920; x=1779764720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5fn5lXdhzUmR8WoBmOTDZiMW6X9iVCgyfgQJdzyZoiE=;
        b=oqogn5IF00CiNlhSBiBg/zQL7xZ/FHJ4eQ8Mn7mHTvUMng9p4nbSJgG5fuV6TIQ7nB
         HhwvPC8lg5o10LFk2sNJjM+Z67tP6SLNWmaJtFzcN2wsug8KnsQWaexJ7cmYJ6gS52pA
         ueVXw38B1f3oSLm86edRQgQKzlRmf+yWXOpGmlos/LeIyzHZZKwQuXKp/Tgp88tzdSLw
         jPyBprzSowWj3ipiO3JgogEpltDb20Jgj8FPCyYdemMnsAouPjI2fpzYG9Yy3EGZM3VQ
         vCNlgUusOqKCNzxvMdR3ABO9vFDLD7KjvdGpyhAK+CaA8t0SHVxtdc5e+jJWM/4JHnth
         MESw==
X-Forwarded-Encrypted: i=1; AFNElJ8EvjPNHMPuKzT8RGYHfEj6P3WIchVwxqbo0luJGVI/XUbNhm2Oy4sQFZIGreAhzbihHgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx77wHGTQsK0+jrRuj8QUkgSpmOMfGi8iO3zWaTy3BlX264uqO2
	M+cQEK3vvpgvdDOwk7QoWNxTCVivE1ek/Z1ROOmIVuZvzx+g/1AkF+d2CI7Mn88fluTMwpI7FcZ
	IvFQgCHGjuZ8FwmTnYFD7bt0d0od8u1s=
X-Gm-Gg: Acq92OGhqRsgl8s2/fyq/AvP1Um4/8bPwGF/xh/VVYo37EoIjCH/LgoJDf/PJrEgzbq
	yPxV+0O5Y1aIwFTdK5V42LF46LqgC9xjdRAh2KT2klQab7qKquNPaqhkp1g/d3KomC5uVsnpXq3
	eKzc2nWoFWld8x4gVJ9Mt+1tEujler8mvlAzo2tMKv0fAPMk/EzyntZ2lWX9B7ZLZ/AiPblRrDT
	GTSFUkCNL8n0JJxvUhKJPLljNFBauAZY35qWUiXJUnk8/xBrKstGSlZNVeev4dP8518BBjnkX2D
	Q5dhBZjTAE9F0x4beNXN0gn2VtQInoaAoaIKWjDyRC0QXb6Yu3s59mB4HVRw7F+VOhCM6ierZcf
	TrihrfmFRsEIMYr808huJhofwm0tzWltfC4vU
X-Received: by 2002:a05:600c:3b21:b0:488:78f2:6b0 with SMTP id
 5b1f17b1804b1-48fe651b39dmr256690525e9.29.1779159919917; Mon, 18 May 2026
 20:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518145446.6794-3-leon.hwang@linux.dev> <18095298384649847dcbe0293f6b710a1382f9ee3eb9aa2bf8f6d02e56a1f0c4@mail.kernel.org>
 <6d869149-49b2-4a7a-8ed1-7db9b6af8542@linux.dev>
In-Reply-To: <6d869149-49b2-4a7a-8ed1-7db9b6af8542@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 18 May 2026 20:05:07 -0700
X-Gm-Features: AVHnY4IMZVY1Ka0Gc2HwMu-nrf1fg0lbl7TQ0eZnTcIDBs7xynIM4zFCGhpFuxQ
Message-ID: <CAADnVQ+rBXAWojPPd40XSkqCM_4XWEqu+_GqCWNkDbi13makcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Fix concurrent regression in map_create()
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Chris Mason <clm@meta.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 7:48=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 18/5/26 23:40, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index 83de8fb9b9aa..322865a88b3a 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -1647,11 +1647,18 @@ static int map_create(union bpf_attr *attr, bp=
fptr_t uattr, struct bpf_common_at
> >>
> >>      /* preserve original error even if log finalization is successful=
 */
> >>      ret =3D bpf_log_attr_finalize(&attr_log, log);
> >> -    if (ret) {
> >> -            if (err >=3D 0)
> >> -                    close_fd(err);
> >> +    if (ret && err < 0)
> >> +            /*
> >> +             * Failed to finalize the log.
> >> +             * Should not close_fd(err) here. Since the bpf_map_new_f=
d()
> >> +             * has published the map fd, if a concurrent thread close=
s the
> >> +             * fd, then opens new, unrelated file that receives the e=
xact
> >> +             * same fd number, close_fd(err) might inadvertently clos=
e the
> >> +             * unrelated file.
> >> +             * As a trade-off, override the err only when failed to f=
inalize
> >> +             * the log and failed to create map.
> >> +             */
> >>              err =3D ret;
> >
> > In the v13 review thread, Alexei Starovoitov suggested moving
> > bpf_log_attr_finalize() earlier in the flow to eliminate the race
> > window entirely:
> >
> >   "bot is correct. Let's avoid these races. Pls move
> >    bpf_log_attr_finalize() into map_create and do it before
> >    security_bpf_map_create."
> >
> >   https://lore.kernel.org/bpf/CAADnVQ+XR3kyqizGgGhtG5xiBu3oK3O+COUMfPDQ=
DBSJbm=3D56A@mail.gmail.com/
> >
> > Does the current approach fully address the race concern? While removin=
g
> > close_fd() prevents the specific file descriptor hijacking issue, the
> > suggestion was to finalize the log before security_bpf_map_create(),
> > which would avoid creating the race window in the first place.
> >
> > Is there a reason why the log finalization cannot be moved earlier as
> > Alexei suggested?
> >
> I've tried his suggestion, attached below.
>
> However, I think there should be a simpler approach to fix it.
>
> I preferred this simple one, so I posted it.
>
> Should I follow the suggestion instead of this trade-off approach?
>
> Thanks,
> Leon
>
> ---
>
> From 7ea7ab53d24b7cf34bd2775ef5c871aa312d07c6 Mon Sep 17 00:00:00 2001
> From: Leon Hwang <leon.hwang@linux.dev>
> Date: Tue, 19 May 2026 10:32:01 +0800
> Subject: [PATCH bpf-next 2/5] bpf: Fix concurrent regression in map_creat=
e()
>
> Because there is time gap between bpf_map_new_fd() and close_fd(), a
> concurrent thread is able to close the new fd and opens a new, unrelated
> file with the exact same fd number. Thereafter, this close_fd() might
> inadvertently close the unrelated file.
>
> To avoid such regression, add bpf_log_attr_finalize() before
> security_bpf_map_create() to report log_true_size on check-success path.
>
> While keep the original bpf_log_attr_finalize() and avoid finalizing
> bpf_log_attr twice, guard the finalization using attr_log->finalized.
>
> Fixes: 49f9b2b2a18c ("bpf: Add syscall common attributes support for
> map_create")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf_verifier.h |  1 +
>  kernel/bpf/log.c             |  4 ++++
>  kernel/bpf/syscall.c         | 21 ++++++++++++++-------
>  3 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 20c421b43849..a10ef58bb6ea 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -788,6 +788,7 @@ struct bpf_log_attr {
>         u32 level;
>         u32 offsetof_true_size;
>         bpfptr_t uattr;
> +       bool finalized;
>  };

No. That looks worse.
The suggestion was to do the finalize log _once_ before
allocating FD.
Why are you doing it twice?
