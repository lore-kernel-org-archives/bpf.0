Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB082253EB
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 05:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774763242; cv=pass; b=IKh+ZU6BDFmo4s765NLr7SiP37y8TszH0GfS2AUCzB/liEdRkMbgHTREk2h7F9C9nPuFdCcAfDHEPvT3LW9EYvI3Mm921MeHiG/AoQo95rhI+ovp7ZTGWnA9N1Je+VTU88LWmBoWb+05sYWUvMGlzsjVeQ/M3V5kUuqlffA4S2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774763242; c=relaxed/simple;
	bh=6g6DrpTAKhnXqrK42OWkoWbrpN9ueXmFiP1/LqE5P14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtTPw89BkqwWyJcXCDdFoIMe6/2SlyvcLCpMKlz5swRoNVQtQSFWK1ZbZtYveykyKGXP0faC03rRuCB1QSK2fXlVNIF81nPnLC2EfEbaU5g3c2AsnKqE01yHV+GDHhZtuXgy/333nlkrI8tjL1Tc4cprMBRsfrE4I28yO8NRd3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ouMx6zNA; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouMx6zNA"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6500eae6d2fso1024219d50.1
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 22:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774763240; cv=none;
        d=google.com; s=arc-20240605;
        b=JiDK6XGNzD6HFViWsEsK9rP/9oTBAovNPkldivE6vYMrfkIGhUjhtjirOxKR/Udasl
         wPb80JTuTp5symcr4w7eOO+RHTBqxLSUDNHCjyJUPA/2j3t0c31Z/xHAv7T4qkKC2VB4
         P/g750EHL/F0x0ONmh9XVK70Rm5k59TAFj1pnNi8y/ndlGgvhDrs0R26NNjWD8Wnun7S
         M6F8bhCK77ZakNgp1fw6jLUVadBlnzmdU0XzxLR5yEA7JMWSKiwlmp4NFg5RyIItHwYR
         x8f+wyjaXqEGDKTU579T3cBj24pn6X0wzTHh/xDJruIuw2Ugj3QekUkjxBTj5As7/paX
         hSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/iugZFsSjOuzcJMja6paNm03P4LwjhuAC89wGrDPrX0=;
        fh=WQU8venkldqDHPmtw91swEk5JYU6JjBa9iHik1oEEvw=;
        b=bVBcGkLFKdWtcSyB8Aaq51eaZPIoGeHqHQXZ1hZOE/60l5pLMLKJJRLsqKoswoDWzt
         rGvkzAFY5Xv44Tb2mYgnY1VvcII175LYFDyswkbAQfX06DDmVrKJF9DiY1hPnHUvLqyZ
         IvIHYhn1YafpJMrnErtbXM8qUq01GU8CyFaz1wy7/D35cWbaUNzNSZo/62cjRgOogqyw
         vOs33Or1kfNuTzcXuGPXuYKk7/slYcxC5Fm/eb0its7yxcDOKzHew5mCPEPqbGg3B/nb
         PYkOU5QNzjxsyZdNzG4k0U+UkFKjXD1g3VWUsHqcIhNtMF+4gadq5nh4X+cdDUQ58nVw
         21jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774763240; x=1775368040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iugZFsSjOuzcJMja6paNm03P4LwjhuAC89wGrDPrX0=;
        b=ouMx6zNAEeOW/ePCl4scnqhtSs4htQ5GTgpv6uAK/nsEG+NMb2inQ7tuFkvGuqCWEc
         h0nH4Dc6D4qsW2fY9TLoI+W4YAKOgJdfWGZ+lNJOg3UhzZPucezM6TjgAKAh4YhkqRmR
         whHKP3EEseTq+UzOEk4vdjHdSTyCbHkjlZ3u38VihAS0DECHBHjjsrE2u3d9whJUjZzn
         BWd9ClL+SfaARjeM+7NSmELTgDcRiI4r86WZY+A+8viQ7NlvBC5euHk9IBo9FaslErhx
         dQnYPOhSFzeVdihbQ/651QLRVH12fCycAdV2GHq4iUddEvKQxGnMhFJC7F8IZrbMrwyN
         SqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774763240; x=1775368040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/iugZFsSjOuzcJMja6paNm03P4LwjhuAC89wGrDPrX0=;
        b=NigSihWjkZ9I1U8f+eyHdekXSqAxYxTZPuMVZw4f9D15NCdeN6IdwH8Dl/GupGTESW
         C+6JX2O0vWh++4DjCRaBgyMA8gjuqK0ikW6a/bLpO91mtl7vFPTuL9qwLd2HWkTbdAce
         3Pp8uDLZQSTW0X4GFt571BgFT3LoqAqwohx6bmEjkzjtDXroPwpWabKjNLz1W8zYDsKu
         TFkfbmin76lvkTgi+T5VdShjPgyyIO94VFGRiaC7PnQL8ZiRR7txFhERZFzXVE390XB5
         dcnmCKKUG3g4Q60WYVQeWDnZwBBdohPCm22lpu8EsGVXA9DufCAQ15XSHNovGndErPXA
         1QdA==
X-Gm-Message-State: AOJu0YyYRxdgJgz5kKvFEFp7aa8lmml87zLLFNldNudtcNI9aPkYCGQl
	CPMZYh3Kve3QkEjCVhbFmxhQkcoYsffjTRMttZUkC/HUw+4+sxuakW3T3Jwf0K7Ne6OjX02GKfS
	dAyLDTP67rpWuSjYB6jhWCGES5DCYJPk=
X-Gm-Gg: ATEYQzxDwfMdP/7+Gc97VyhY+qUNwIZVqoCk1LrZyGcq4E8Zx0/DipLGx2egUqJP59A
	vKOoonjcqV62G8mYQ6wwFQVCOAG3UjAHhOYn8z2EV687CUwZbLXzoK1bmBZ+5eDqGIKtQ8/dJ8m
	WUOaZ4vbWAJ/pidYhd+297oMxCQ/XYinRdzgcuq6Osrau2Q8DswJPJdRLQ85BjmkC32BpB35Pst
	zWmrt+4XxcXhdoR+T/2/VDsywTvU+xv1UI8xCuPvsKZDBPV8zveZNnf0PYOJy2UO0qCT0C/CCOz
	a8OOEX9ha0tP8EWIlsmj8p8x0jukjHBcUzFr08zRsX0oCw2mFCFaXNKEaT4=
X-Received: by 2002:a05:690e:1688:b0:640:cccb:1fd2 with SMTP id
 956f58d0204a3-64ff7239c2emr7682432d50.33.1774763240407; Sat, 28 Mar 2026
 22:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329020748.3649741-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260329020748.3649741-1-rhkrqnwk98@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Sun, 29 Mar 2026 13:47:11 +0800
X-Gm-Features: AQROBzBYTYUItKpL89566WBJeajv3BpFtRdkfNzeP_NNr9gLnt4CyjMgmHSd28o
Message-ID: <CABFUUZE9yfTucMqiQDP_2RAWtF5s3d80u6Em2apzbjJ=os6Liw@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix RCU stall in bpf_fd_array_map_clear()
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz78@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 10:08=E2=80=AFAM Sechang Lim <rhkrqnwk98@gmail.com>=
 wrote:
>
> Add a missing cond_resched() in bpf_fd_array_map_clear() loop.
> Other similar loops in the same file already have one.
>
> For PROG_ARRAY maps with many entries this loop calls
> prog_array_map_poke_run() per entry which can be expensive, and
> without yielding this can cause RCU stalls under load:
>
>   rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>   rcu:  (detected by 0, t=3D6502 jiffies, g=3D729293, q=3D305 ncpus=3D1)
>   rcu: All QSes seen, last rcu_preempt kthread activity 6502 (4295096514-=
4295090012), jiffies_till_next_fqs=3D1, root ->qsmask 0x0
>   rcu: rcu_preempt kthread starved for 6502 jiffies! g729293 f0x2 RCU_GP_=
WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
>   rcu:  Unless rcu_preempt kthread gets sufficient CPU time, OOM is now e=
xpected behavior.
>   rcu: RCU grace-period kthread stack dump:
>   task:rcu_preempt     state:R  running task     stack:0     pid:15    tg=
id:15    ppid:2      task_flags:0x208040 flags:0x00004000
>   Call Trace:
>    <TASK>
>    context_switch kernel/sched/core.c:5382 [inline]
>    __schedule+0x697/0x1430 kernel/sched/core.c:6767
>    __schedule_loop kernel/sched/core.c:6845 [inline]
>    schedule+0x10a/0x3e0 kernel/sched/core.c:6860
>    schedule_timeout+0x145/0x2c0 kernel/time/sleep_timeout.c:99
>    rcu_gp_fqs_loop+0x255/0x1350 kernel/rcu/tree.c:2046
>    rcu_gp_kthread+0x347/0x680 kernel/rcu/tree.c:2248
>    kthread+0x465/0x880 kernel/kthread.c:464
>    ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:153
>    ret_from_fork_asm+0x19/0x30 arch/x86/entry/entry_64.S:245
>    </TASK>
>   rcu: Stack dump where RCU GP kthread last ran:
>   CPU: 0 UID: 0 PID: 30932 Comm: kworker/0:2 Not tainted 6.14.0-13195-g96=
7e8def1100 #2 PREEMPT(undef)
>   Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1=
996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>   Workqueue: events prog_array_map_clear_deferred
>   RIP: 0010:write_comp_data+0x38/0x90 kernel/kcov.c:246
>   Call Trace:
>    <TASK>
>    prog_array_map_poke_run+0x77/0x380 kernel/bpf/arraymap.c:1096
>    __fd_array_map_delete_elem+0x197/0x310 kernel/bpf/arraymap.c:925
>    bpf_fd_array_map_clear kernel/bpf/arraymap.c:1000 [inline]
>    prog_array_map_clear_deferred+0x119/0x1b0 kernel/bpf/arraymap.c:1141
>    process_one_work+0x898/0x19d0 kernel/workqueue.c:3238
>    process_scheduled_works kernel/workqueue.c:3319 [inline]
>    worker_thread+0x770/0x10b0 kernel/workqueue.c:3400
>    kthread+0x465/0x880 kernel/kthread.c:464
>    ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:153
>    ret_from_fork_asm+0x19/0x30 arch/x86/entry/entry_64.S:245
>    </TASK>
>
> Fixes: da765a2f5993 ("bpf: Add poke dependency tracking for prog array ma=
ps")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>  kernel/bpf/arraymap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 33de68c95..5e25e0353 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -1015,8 +1015,10 @@ static void bpf_fd_array_map_clear(struct bpf_map =
*map, bool need_defer)
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
>         int i;
>
> -       for (i =3D 0; i < array->map.max_entries; i++)
> +       for (i =3D 0; i < array->map.max_entries; i++) {
>                 __fd_array_map_delete_elem(map, &i, need_defer);
> +               cond_resched();
> +       }
>  }
>
>  static void prog_array_map_seq_show_elem(struct bpf_map *map, void *key,
> --
> 2.43.0
>
>
Reviewed-by Sun Jian <sun.jian.kdev@gmail.com>
