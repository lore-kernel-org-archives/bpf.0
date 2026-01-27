Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715CE29B200
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769548095; cv=pass; b=NwBHslYU8UNpy5rgTaMhS1ILTIaD8cb/6Z3h6g53J/nYeEVvhPw+MOvDaPElOXgryQ1NMK1J0bhLmRs05luJWP95itQg1BQDsObhsjcLo2k9oN6U3SYnb58yAWx02AGcXdMvPiHF6+xQHo5x+rwHgN3FleuiYulGc7QxjaX0zsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769548095; c=relaxed/simple;
	bh=P9HSiKttuCPVxcJklWQQg6SJzfTFCS1PCaCrH+OZM6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRnnsHWPxL6L8dou5n2QpNFL2fS/cvfJtPWgKBHz2jaPxHie590u1hZJ/bPfRr04Mdp0u7N0NbVmlUm4xDdB/o8P5Fstfs1Sb59KvD1nLJuQb9/IL/NePS3UDPKdCyEbkkXlNlZCmvMdTreWe7U5PUtaOX7jO17qTY9iUazxGHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gu3W5wcw; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gu3W5wcw"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c2dd0c24e5cso2027416a12.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 13:08:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769548092; cv=none;
        d=google.com; s=arc-20240605;
        b=XWBRMWlxpRQTsQFEh1fqtIMzyY0NalBZPTHvGoRZXtte1fiEfNZxj8vL/KMHm5stUp
         f52DXvdaZAw4TpUU05GM50lG2RMD89QaD/YKSu7S0dY4iy0gEgQ+9K7kF/3ipfu8WiWi
         ZYjc1D4mr6AoJ+V5WYz6NMyhknojjMI2x2dMwHzZJ/1ML5NAgbG0UGrAeky+eYPw5SKF
         cANlz1rLVbREYj5vxj3J0Ej+XIZ5Cbd1fPwNZTk+lPf/4CaLw1fvVncvYi5aUn3VWGru
         hK2wwu4VjeBFb8P2j8SQp/HQMWKGsYvWg3VRQIh/toHeW8a4y2vwqM+EFPt32HMmgFjC
         F1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eQdjtSgPmBAOitqfbEbhL0KWe6W19d0ewiZmP+b4tqo=;
        fh=A3QYb3UDZvzrTiLFlDZXlH2tW05ywda1rTphic3ou3Y=;
        b=G41MU6etfKn/Ygxpq8oVXTbju/mWXczvSsmVifkgLIfsiyyabGsQPXnwRe14FCjIJx
         hHz491i9wrsKwX3Kix/qBmMpOCtZPRbgDQXhDrcOG0QWgSTg3zWVTJiwGn2TAugV0RHf
         awiOHofVAS3GY+uI9wLaRxZBWulAgqHbkZHmApDP66HkiXaFmmcutP/dD/A2kFTUOYde
         P+Taqb+vEEwiUsr8ruX9eROBms+3Oq4+vIft5AXZ8GB1vlsoKAIPd1+6w03O4Cs0iQoM
         LxFByxbhSLRb4rP9m741fySylf4femntVLAgHk9Mu7EG7rSpbRCMZAYxlK3f7JEB/z5L
         QTVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769548092; x=1770152892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQdjtSgPmBAOitqfbEbhL0KWe6W19d0ewiZmP+b4tqo=;
        b=Gu3W5wcwaEqpdFrYhCYOQ9yVsThK5wvVFos7uFLyRYKN5fbGbY3ZY1xf4KYYXkyICF
         IpvwgqRsxRnvl961IuF+MRvxD2qKVCng4J1XVAyISHIanA3yXulfz7C/Gu/TiYeKLtL8
         QilaLHcX8+luNe1oJR+NIyr72ebxfXrDfJ47A4A7XnVXy3Kt8azFluomnepPyGQfWJJ8
         9/NeluIzRQrJGTb6ZY7GLl0n9BwXQWX7HoC8Fx5rjkX55Mq0hgi31MlVy/MJga8OvFLk
         e/QFsNrT2+ja1OovufQF2O+eeWNMxnSNKQrCX9r8awEsLss6LR+7s9Tyt3xXmzGGwO76
         TS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769548092; x=1770152892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eQdjtSgPmBAOitqfbEbhL0KWe6W19d0ewiZmP+b4tqo=;
        b=jDFlg0fJFwMLCI5j8x7L7khS7rI77u28YKV2sqjQEnMDnISc22pPrN7edwgp/YTe5H
         FqqNRS2VLDrLxqbpaf8TNZCQ7o2DbQWssG9yv/3B+1aRr1Lfcv/oDbkSgaiXmsyl7I3+
         3wh9zeye/P1jz+ahM0bift7h0cIFpNWuVPNarC9xQ24WekJ3FNGMPyyJUuv7JHtchYmz
         rXchT55cIcnVVZjAtkmwLWbzXijQiepJtjeiCcSuy4rpvHl6ePV4Pia5PiCOB4I6pOdi
         kfhHgOy3BvY5hij+udCsVdXZkS1SagEq3Q3W9GiQuXnEvmNYFVZVjkuvPMlVUrLJzRek
         jiFg==
X-Forwarded-Encrypted: i=1; AJvYcCURp14Vo42nr/knNvDO+vMhvWldn1hiLmUeFzw1ewghNEpkityPQn/M+fF0fo65yLKkUKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi491k7YIpcmypuiL5uUPkl0mzw8TIlEDvd+aRiBMc/A5DM+WZ
	vokRhRvU9QZxnJVon12nyXkm+XUJ7ruY9iGu6Mlfg4aZBas/uJmzDuYWL+bOxpOtVM3zBGhZAxK
	C5PIPWuUtx/OD5UsrowZIWUpWtTiXH1c=
X-Gm-Gg: AZuq6aKe+o1IVarCOBH1S19oYEAUPYF7ZqHUEDhGUoWrXjJVPKRhCMgM6O/QfI3gaMV
	tN/6QRganykHHfEkJQ3+9V9JBH7PCfEl9j4nxxlqdM3sbZyOopsydZP79RhhYU1ufEDrnLagNq8
	2gEPmcyKgQkBwh3fpjYU5t93k5XCBwjL0zYuglivpB3aRa3LyiK4SNi1qTvdeBmyoXDnkg6E8Ty
	fPXLZPoCveYZGnmMWgM2/CFhiUjc8hnl3U+miOuTVG4z/B35xKUXV4ma6B0mFOrCEnP7P7MYkWq
	ADAdTGH9vHy+2FV2bpQYBw==
X-Received: by 2002:a17:90a:ee88:b0:353:3f04:1b78 with SMTP id
 98e67ed59e1d1-353fecd096emr1923735a91.4.1769548091806; Tue, 27 Jan 2026
 13:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev> <20260126074331.815684-3-chen.dylane@linux.dev>
In-Reply-To: <20260126074331.815684-3-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Jan 2026 13:07:58 -0800
X-Gm-Features: AZwV_QgA8I1tZ-9gW_jo_xgJ3AGB6q-m9rfSy7EoPH9GLYmxOLzle356wwR0nM0
Message-ID: <CAEf4BzZq8g_BciT3JNXuYZpzq9zphaVsvOTuOVnqjDS=9w73Gw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2026 at 11:45=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
> From BPF stack map, we want to ensure that the callchain buffer
> will not be overwritten by other preemptive tasks and we also aim
> to reduce the preempt disable interval, Based on the suggestions from Pet=
er
> and Andrrii, export new API __get_perf_callchain and the usage scenarios
> are as follows from BPF side:
>
> preempt_disable()
> entry =3D get_callchain_entry()
> preempt_enable()
> __get_perf_callchain(entry)
> put_callchain_entry(entry)
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  include/linux/perf_event.h |  5 +++++
>  kernel/events/callchain.c  | 34 ++++++++++++++++++++++------------
>  2 files changed, 27 insertions(+), 12 deletions(-)

[...]

> +struct perf_callchain_entry *
> +get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> +                  u32 max_stack, bool crosstask, bool add_mark, u64 defe=
r_cookie)
> +{
> +       struct perf_callchain_entry *entry;
> +       int ret;
> +
> +       entry =3D get_callchain_entry();
> +       if (!entry)
> +               return NULL;
>
> -exit_put:
> +       ret =3D __get_perf_callchain(entry, regs, kernel, user, max_stack=
, crosstask, add_mark,
> +                                  defer_cookie);
>         put_callchain_entry(entry);
> +       if (ret)
> +               entry =3D NULL;
>

purely stylistical nit, so this can be ignored if you disagree, but I
find code that modifies some variable before returning it slightly
less preferable to more explicit:


if (__get_perf_callchain(...)) {
    put_callchain_entry(entry);
    return NULL;
}

return entry;

>         return entry;
>  }

> --
> 2.48.1
>
