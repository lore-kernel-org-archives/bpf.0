Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3856F3A9611
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788086463; cv=none; b=PhGMndjtJeyMc+zGpJAGKSJJDj9Jt27S+Ph4f+btoiXDqiOanL1mQaXrlPiFPpwBI8IXYWZmsVGnfIBVR98TZQyqv8DPzZazvXq50urwHMOAN6zwGBccWD2ar6OOypMjoBorUtq5Lu+0KIzHkFpVwIu1MDb+HiWocLsQWS4jMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788086463; c=relaxed/simple;
	bh=HoxHMqOi1uwVwjMx6JAxIOH8hjTvQ0su9jdNVcJ5+Dg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ANAUlbV238DUIVdbKa6L+AZ76cu05SVJUF2pJCHYqap46xes5PX8CasnCG1/Y+hLeIJDzb1L2elgWh2f2ggPo/HyA6GqHRU/6vHGGNVxX5eGBVsDl05UT6bctz1Rkg1pQYCZo1lQvtW9X6R2Z7tzyPkt6YK1awOhHSF9a7sjdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+uxBFiU; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+uxBFiU"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48436370540so258347f8f.0
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 03:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788086460; x=1788691260; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DmienoHcBUc9ULMJN4u8BB8CC2u6CirdIee/BAMi6e8=;
        b=Y+uxBFiUjpbr7JzYxqMBc44n99NUl9gWHVmSRvV8y2Dc4ltWozeAnW1/7//4XNEIzX
         9d8QiIujdxNb/3vxszDhETqrFK8Q2D+K/YQCcHCMVRtj1LRIUnxaDtjwUrhhl2LvY8FH
         685pCS5BkEWv9BvYxOVSJc4a/Gauyc+T9mZLUSidJtNrruSRIvU3mOadfPWRHN12yNXY
         KP1EPj0OOjPdI+EmiOxzuUy5NKtb2r6OsXTjwvVHpC5FqjXgNYTf219IXOdJ7NaHFB8P
         lHetJBcPJPaRUuCBlQOUFHka7S4LEP/bXnd6zzC5lVtgUylKg5CPpXhWnIYomrG7crPR
         N/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788086460; x=1788691260;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DmienoHcBUc9ULMJN4u8BB8CC2u6CirdIee/BAMi6e8=;
        b=H2gU+Hhca6df0nu08eBgbUQsKjpIYba2m5hIbIuulr5kkenVpRRv21qBvemZ42nYJp
         +tepdBYcXCc4uF/snjft0pzQH7tm6mqkC2rzRjzUlYEbh+fNIKkOmTOKoduJkIxiJZFv
         xmLAChZ8TaQ/s7AiBmGoUsVZ34wZWsli/4+BqcbQXO9cA1zHhhJk21bbL1s2kD9kRpOY
         y1Mu6NeqsnZ+VKFEY0M8K4AGwBMPfi1YMi2U3GuPiLHJkYv70qrd9i7xBysE+2/bjL9G
         7J6gp1BilBHZQVWUeizAHMDnMyWtVav5mNW9edizIfv/r8VKm5tdbdSsnU3lTdzhGT4d
         2jPA==
X-Forwarded-Encrypted: i=1; AKwUvByUuU+Pj8UDrumLxJGfI+FyfOZ6tEmUfrZd5K20Boo+dduUBUaDG7DVrZbwhhzYLLewK0k=@vger.kernel.org
X-Gm-Message-State: AFuF++mEuUfBwR8GRncozMc9Nj96FACicAzqO1JvhyWRQPj4O2fEggfz
	WnMnxpyae2uLy4nklXjoMl66g1F5UchAGZTV6VU/Rz/5c1/36rTH1weF
X-Gm-Gg: AYBFou1bd+fITtFjjljGnrCYzIOaqyMNftD0eLjqr/KfZp92MAaNJ0ta2yiBMTRuocQ
	kW70MAT0n5Fc4CzUd9up/nqJazwUBR22uxen9DB5yzW/39AABk0gvs702V57q5bxnuLG4F9VvEa
	+t7AYNarFV4X9HLIKIY4sutV6A1FdZq1WvZSY4ukvkb48G5KPN3ss2v6QuZ9EaWF7HGR35xRVPp
	ydhVwBfwuSwSd4eY0lGrxjU//VPvhuE9L0yvvSdN4I+RC9CczFqLySdbsfTNksCWnny6lAvgBKS
	MvGOek6nMJBYwuMczC+Sy0zPkDoL9OqKmxv8LhQHGCjup6SIFubBaAioITQFSsjOuTJRVSLS0Ml
	tIwf794e+MndaL9D+20k4rRZr6+Dju988+6TDqbHhcvwrRC5CAy2DbJDY682u+IynJNHqp6ZSzq
	nS516P57AgkkBbtlqfl95UsMx90cB9EKHpmUvUwnNbTxmSu8rM0hSgJUkhyGNXtdMydMVZffKUW
	CmwunvFnr2uuPwkWBHL8Nrm2QzhDteakD+4pItcgOLrnb5cEZh+3ercA2hvD1eEChcTyEUbhSpd
	LcOCXLI0v4XyNYReGgCaWmlHihI=
X-Received: by 2002:a05:6000:4a09:b0:484:3310:9aaf with SMTP id ffacd0b85a97d-48433109b62mr12541197f8f.24.1788086460209;
        Sun, 30 Aug 2026 03:41:00 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb33070sm15935856f8f.36.2026.08.30.03.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 03:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 30 Aug 2026 12:40:58 +0200
Message-Id: <DL27QZ6SEZKT.1CV2HAX4A3WI4@gmail.com>
To: "Florent Revest (Anthropic)" <florent.revest@linux.dev>,
 <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Jiri Olsa" <jolsa@kernel.org>, "KP Singh" <kpsingh@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Jose
 Fernandez" <jose.fernandez@linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Keep progs alive until the trampoline image
 calling them is freed
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260819122252.1782790-1-florent.revest@linux.dev>
In-Reply-To: <20260819122252.1782790-1-florent.revest@linux.dev>

On Wed Aug 19, 2026 at 2:22 PM CEST, Florent Revest (Anthropic) wrote:
> bpf_tramp_image_put() makes sure a trampoline image is not freed while
> a task may still be running in it (call_rcu_tasks() + im->pcref), but
> nothing similar is done for the progs called by that image. Since
> commit e21aa341785c ("bpf: Fix fexit trampoline."), detach patches the
> return path so that a task still in the original function skips the
> fexit progs when it comes back, and counts on the prog's own RCU flavor
> to cover a task that is inside a prog. On that basis the last prog
> reference is dropped right away and the prog is freed after a single
> RCU / RCU tasks trace grace period.
>
> That leaves out a task in the trampoline glue itself: between two
> progs, or already past the patched jump but not yet in the first fexit
> prog's enter helper. On !PREEMPT kernels this is a few instructions
> that cannot be preempted, so it did not matter. With CONFIG_PREEMPTION

I guess it would make sense to highlight why it may not have mattered. I th=
ink
the real reason was that on !PREEMPT kernels, the execution in the trampoli=
ne
image counted as (implicit) RCU read section which caused program free path=
 to
wait for someone executing the trampoline image? For non-sleepable progs, t=
hey
wait for RCU grace period already, for sleepable, RCU tasks trace has impli=
cit
RCU grace period wait as well, hence this never showed up on !PREEMPT.

> a task can sit there, in no RCU read section of any flavor and holding
> only im->pcref, for longer than it takes to free the prog it is about
> to call:
>
>   CPU 0                               CPU 1
>   in image I, orig_call() returned
>   [preempted before lsm.s prog A]
>                                       bpf_tracing_link_release()
>                                        -> bpf_tramp_image_put(I)
>                                       bpf_link_dealloc()
>                                        bpf_prog_put(A), last ref
>                                       tasks trace GP, A's text freed
>   __bpf_prog_enter_sleepable(A)
>   call A->bpf_func
>
> On x86 this is an int3 in poisoned bpf_prog_pack memory:
>
>   Oops: int3: 0000 [#1] SMP NOPTI
>   CPU: 18 UID: 0 PID: 94573 Comm: x169 Not tainted 6.18.44 #1 PREEMPT(laz=
y)
>   RIP: 0010:0xffffffffc0601d8d
>   Call Trace:
>    <TASK>
>    ? bpf_trampoline_6442515411+0x1a4/0x21b
>    bpf_lsm_bprm_committed_creds+0x5/0x10
>    security_bprm_committed_creds+0x5f/0x70
>    begin_new_exec+0x2d6/0x410
>    ...
>
> We hit this in production on preemptible kernels when progs attached
> through trampolines got detached while their hooks were busy. Adding
> grace periods before the prog free would not help with sleepable progs:
> neither RCU tasks nor RCU tasks trace waits for a task that slept in a
> prog and then got preempted in the gap after it.
>
> Fix it by having the image take a reference on every prog it calls, in
> bpf_tramp_image_alloc(), and drop them in bpf_tramp_image_free(). A
> detached prog now stays loaded until the old image is gone, which
> reverts a deliberate choice of commit e21aa341785c ("bpf: Fix fexit
> trampoline."). Detached fexit progs still stop being called right away
> since the return path is patched.
>
> Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
> Assisted-by: Claude:unspecified
> Signed-off-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
> ---

Overall, looks good to me. Thanks for the fix!

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Note for whoever applies this: please add Reported-by: tag for Sechang as w=
ell.
Optionally, wordsmith the commit log with the suggestion above.

> [...]
