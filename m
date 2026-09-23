Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A1F3A7839
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 03:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134427; cv=pass; b=I2I4EftpT0Djh0tNLhtfIomKjTsuS9yro79nO+7EmuWcBSr4yvDZW4g1b7nkccqMKXsgbWGEbopXGKT8XKGI3WMReGf3cgs0OUDKf4XO/tPAfvRT57VZte5tr2G0LP+d8nXCMEs5XvkXZoltWx7pEVPzCUwZTYLcgD5ZGYTPjtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134427; c=relaxed/simple;
	bh=1rXl+iKvG31hPrkCt1juiT/NMM+N5YG90o7jiJUxLOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oX6gNE8AF4CS/fy4ZVUHegHbaGXiemmAdHbsmdxjH4uN8iINuGZT2rOhe4ivMvX9tYFU2whqMuXU343ZZVqyaVa0WLv4K+qqBRzMG8QRTsuOUOJkyDO/7TvQoyF4xyqSUFj1Px2COUCKxFWkMTQvRrFtfcQvus2MvPvD8XT1OD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk2fygiZ; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk2fygiZ"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672c2880f58so439343d50.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 20:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790134421; cv=none;
        d=google.com; s=arc-20260327;
        b=MSQt4PxsraAXhPrpOW1FmNAF1DqsCAdAwinh5qp4E7qXYCpyH3m2wcF/qYbYYggZB7
         2GSKbvBpRlqVtasVKKuVejk1VZNL66syDE5C/brtOYZBcQBh3eB6RomIULLXJDfMKR+F
         z16i+svFp/o5QrD9HwaUsCskya/4Tf1QKcATo/q5MNWpRTBTgy9/H0rieMweycMLRQ/3
         EOkQWobqqmxu5MCtl1URW9O3dzevfUCV7HvZB1yE/yn7bE2LQ9ATER6aTphwaIrzMsIb
         EzrJYkMVUaNU9fsrHe19TeMXYpH2g4mPqAvsHnsbpvgAInR6tiKFpR93A22oqqknuOTb
         rDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZkOfAYL8ZF1FMqf/kMu36qJzGPBJNOCPM8hwn45vbh8=;
        fh=l0l9DT7b9o4vXd9BQanJdhm27GqD60FFdBaGBwHMaQs=;
        b=et7c1kxD5ny9HCzIPqhWuhZ85Pmz0UETPc2Yt6CLw1czhCkWl0F8CjRd1l+sZFUTew
         gKNo93yo3eahq8ruNjp0mRfJsto8AfEv/4bU+edXKUzwLGw4En60euLqtRmxzjTb9jwg
         iyGLZ3wmj7qGaw6KoOK4Hp1lpFP9DUKjT7fEfS1Ro162ntbqlb6W0ZoQaRL+afOnL7Hl
         ECkq0Z4cmDQIJUNsmZLmeeTNfSsBXR4dkc63frNP9+nEruQLFZxlFd77/xziYxWmT4Oi
         9/rAfwUsBito00ciQq+s2cAdfHTqET+0esAjPdu26CeeZKFEXS9agnAw04swaZ89Tkzl
         uN5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790134421; x=1790739221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZkOfAYL8ZF1FMqf/kMu36qJzGPBJNOCPM8hwn45vbh8=;
        b=Vk2fygiZztDaLIk1AYzOzIIY4JFCZows1thJZzlKsJYfhU9d4Kpp1GiO2wGaqz/v/i
         uMx/xOfTmzbSgWQpvOyOd45DaSDUtHIx5vZ8WfjtPHeFA68c963WPkYFj93zAydRMCnj
         Vy/mGrWgXHVTLYPqkVDlOnS1GlxiB1vXVnUv0GeDW6NemS/9SGHKUMbngDPDAb4m6hTg
         ePIM8HBpJPHsdYfvaDvvmUTxNX4J6Zm0OS24tNd+PkJfSc28e/+zOKc2eqleOKzaXiFr
         toFNBYQHFt/jZXq1k7PY7usHJqtTEbolcJvuVZ2R4t0I3bcm2Ab+KOSWdZ1Te9y+5ghB
         H58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790134421; x=1790739221;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZkOfAYL8ZF1FMqf/kMu36qJzGPBJNOCPM8hwn45vbh8=;
        b=fJ/+F5DXk8y+fXaKVsOFadxwDKWA79UDeSEMELLIxxgPWZsf7xz5hXYiQI/wE08y0H
         5Vvu205jGaGDZnIM8DajB3WhFmLZgNk3hQcmOw12e0y7T68IngqErfxvW87U4nWZ55G4
         oWOB1/HS9JFuzf81U39p6Kg3odT2zIzZQtL2HPQNjGpAGusnQAxG4E5wO8uDFh++aiOW
         8xooQ1UyvgLvb40D44fVtpQDI9HtvUyz99JzT5YB7SQ8yhv+9g9ue4hS5OGYri/4zEp1
         csTmTA0OFnAeB5lNWJqYZr1yTEHIBzQJjO+FL37vQSRjpfI9/gl+TeYluflRYGHqF3mD
         zuGg==
X-Forwarded-Encrypted: i=1; AKwUvBxJMvhnAfOv1aIRkZ115jrsdCIzUDBkU2ZdvpY/JZZeYDbwrcJ0Ay/m9h58vLjQBvGQKIs=@vger.kernel.org
X-Gm-Message-State: AFuF++kMGhIC9ywg+VtbvSXOFS/p7AprZt+06k6jseKn1lk3nu/gTpEn
	Yj5/jEk6Qb65fcsHhousPte8AyjxvGskSA7nA/B/bpH9af/Z8RS8TJouoFsyll/j8MnXFNjHPcO
	A+uFaMlYtxQgqBRkMO5hk2ewxU6v/Vy8=
X-Gm-Gg: AYBFou1vTfZ4r8P0/i8EU9sp/Cs/xk8lw+Eu4xGmf3bvE5iip+jIH09kqS6qn4ZaDsn
	QQJ+yV/3qY6lf03j+gfvrNvJMOHE9zuOpr3rWLsie0Z6mZbYd4b8T0etVcjA/WS63zQeqaDGtgX
	ufZM74nd21K1kWXOAlIXhlO8XJAPRvDWGY+zN8JjazZE5UYD0lLWvKfd7HlZaj+CgdYfX+X+tuJ
	qTzjDnePQ9rpbQ6SAF+kHzrdjc/yv1s6VwagVw4b0xd8Ai1vW4q+i2Jqq9IPBxnGAldx3SWMETG
	1CiK5Jss9y0fY1VxmKJyB8/vxSHn3gAFrKL56OAyUSMpoSFqoEc5aK3+f3Ws3rzFrDAvrieWAXk
	7+SYck0LTlgQvT4BqnrTBLnRRPqRbyOb9OW7LpkTVzgA=
X-Received: by 2002:a05:690e:4803:b0:671:1a7f:f74b with SMTP id
 956f58d0204a3-672d589763dmr497929d50.63.1790134420858; Tue, 22 Sep 2026
 20:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825044507.15217-1-kartikey406@gmail.com>
In-Reply-To: <20260825044507.15217-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 23 Sep 2026 09:03:29 +0530
X-Gm-Features: AcwNN1XofXYRTMqU_1H_lyfP_vGoaxCV2g_bNzhl8WkGKlgr3IVJFhwF945oSaA
Message-ID: <CADhLXY6uRUsNCiPdwd0q38_4jumdK0SdwpCjYewCRJq8QzwbkA@mail.gmail.com>
Subject: Re: [PATCH v2] perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, daniel@iogearbox.net, andriin@fb.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 10:15=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> During fork(), perf_event_alloc() reads parent_event->prog locklessly
> which can race with concurrent detach clearing and freeing the prog via
> perf_event_free_bpf_handler() or perf_event_detach_bpf_prog(). This
> can result in a NULL pointer dereference or use-after-free in
> bpf_prog_inc().
>
> Fix by using READ_ONCE() to atomically read parent_event->prog into a
> local variable and bpf_prog_inc_not_zero() to safely increment the
> reference count only if the program is still alive. This handles both
> tracing and non-tracing event types without requiring any additional
> locking.
>
> Fixes: 85192dbf4de0 ("bpf: Convert bpf_prog refcnt to atomic64_t")
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> v2:
> - Drop bpf_event_mutex approach which was wrong for non-tracing events
>   as perf_event_free_bpf_handler() operates locklessly
> - Use READ_ONCE() + bpf_prog_inc_not_zero() instead which handles both
>   tracing and non-tracing event types safely without any lock
> - Remove extern bpf_event_mutex from perf_event.h (no longer needed)
> - Remove static removal from bpf_trace.c (no longer needed)
> ---
>  kernel/events/core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ba5bd6a78fe7..39755bfacc55 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13433,11 +13433,13 @@ perf_event_alloc(struct perf_event_attr *attr, =
int cpu,
>                 overflow_handler =3D parent_event->overflow_handler;
>                 context =3D parent_event->overflow_handler_context;
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
> -               if (parent_event->prog) {
> -                       struct bpf_prog *prog =3D parent_event->prog;
> -
> -                       bpf_prog_inc(prog);
> -                       event->prog =3D prog;
> +               struct bpf_prog *prog;
> +
> +               prog =3D READ_ONCE(parent_event->prog);
> +               if (prog) {
> +                       prog =3D bpf_prog_inc_not_zero(prog);
> +                       if (!IS_ERR(prog))
> +                               event->prog =3D prog;
>                 }
>  #endif
>         }
> --
> 2.43.0
>

Gentle Reminder. Please let me know the status of  this patch.

Thanks

Deepanshu
