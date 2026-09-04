Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962252D2A7
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788555774; cv=pass; b=JtzvSGAhEMoORc+XUE/mMt2GFcB3isdexEvFgClSJXS1+om+BwcvDO/oZzNNI9HKVohoP6JqLY4WVE743v+U/4+M0muemOQHE3MpUNR7dtzhyK/thIjJTNEOmdhsJOMK2WorZjS+Rrzcz2vw8a3blP/H6bF7bHYmKV7dRaA5OHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788555774; c=relaxed/simple;
	bh=4ZVr+prKPSIFRpCnkF0vfYGjCPol1vKUSTfk40A7uPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJ1dyrlfnGfRfw6wKcR+aJ427LUlESfrTVVKzKJdcsDAYOM3eqdees5k4zJXTdr/yC9sf8+RKWi3NiiltZTrIZ8Rjioo1itDyG7/20oBK1dtByfNKkW+q0wigotEoayKd6woOZQ9rhpDQuesrY3l4IOlUjPT18o3GK/NEjPHjSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=O2BGNrng; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="O2BGNrng"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-855de2d0d4dso17683607b3.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 14:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788555765; cv=none;
        d=google.com; s=arc-20260327;
        b=R6T08gIjx6t9Jvc/h33dlUBbRaIWafk1paVVOCkl0bl/xuhx5EJfgFhieC6MBPHrtU
         c8cu3qhBB6qykphwieRUP3iVm+X0XhWCmR3apN+v1eK439uySCnOHukih5PiQ/Z1m9D/
         689C6yHqM7hFLW+T4cMLRCgh8Yb4yJXk1sYKwIsEMovm/FcjITdfypKBeBh3+R30wvr2
         jCmlSP3t+d7Dqj7TqyXVsWlWeIf6puXZrByZ5yZZLRTS5w92dZG9uHvYZcUzBi/X8Ju9
         GyI1WC//77tgi0/K0ltKbtBhSxPfrQoo70FFTI01ke7AFh6Bh7x1NzPU56OUssCpfD0z
         vN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y0O5VreqryP02nG988+WPb+s3VdaAZHwNkZOW0J/A1s=;
        fh=lNLKcnujLHiImrq9iRAsmJf7Gu68ojwu27b+o4ro8KM=;
        b=l5B/eT5ANrNJ8QsG0tvpJKJJtXIpL22KT03+OvEh2Rwqhho5TDvcLRQQOc9PleIcpe
         W9EcvJtAaAKStRRjEQyYMgrUR/r6ng9du4dIjbDQk+skvUjQ+WwTp+tUOPJunEh/lp3P
         +NhIwUphg3O9aSrRSCmLUwIYMiJrer5fwBdAFGck0L5v3SasQcLLqFWNLyAZJ7onUlva
         4CgdU0K6l59VdVwXABu5j5Oyf5u91mtKjirUzP2gdobnXhIuY1gTSnsuYrywLU/dpgVS
         sIXLdQw5B0YbIIjf7FMGu4U+RjKJgAjIvxn99LJM3EsestnMPoBaAmOOfb/cyZpHosfr
         gDLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788555765; x=1789160565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y0O5VreqryP02nG988+WPb+s3VdaAZHwNkZOW0J/A1s=;
        b=O2BGNrngKtWXt2JGLl+dKG4/n5Zu4pzAywj869LCry9tqj7mj1P7BD+pAcFIvIGZCt
         8NrL4IlyGXA/40J7aN6+mVVfuqlnGG8IO9Wzwix/eHj2lX7uyvK26NVqNlum8c3ds04d
         BMC3PByFIQxbN94wq7ri7h/GZicuCkjLuhVkW+9xuFjpjoDBzZUKVatvat0BgQNz8+RC
         loUazT+E1ENbhptCRnG4Fs/eKlefwFg6+8cPGGiO5SPh3NKjcQw7GCXfdfZoWnWaALYB
         TzXng6P0d87LcGGwTD1jxzn95+viqpS0F45GPQKhmKWggDwAkMXPkIdgDZFGH1PT5cXz
         Ap7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788555765; x=1789160565;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y0O5VreqryP02nG988+WPb+s3VdaAZHwNkZOW0J/A1s=;
        b=cWgHLSmEtzPOGz/kSY3N6KO1VSUqTA8KvbxVznFiIAmUpvFtEiwemIFYE+gQdCB/lR
         SSknnm1HzK32r9RR6kajr7xScdRh28V8veOGcbdkMeRQdA8kM/AZcH8lQAD/Gs71J4+T
         jQ7GtCJAaCzJZXnRgrB9vAh/WIsRcCbWBVsjJG74djeEwsX8n+32FOrVigatyvyKS9eP
         lE6WgLcKue1P7WQnvUhMFJWAQqOyr1jrJ2oCxhPJpxAdGY7mnfUbRJAdOE3wgLMxwwV5
         iCSPNuWCjCqPQk64aaQ1XWmn3PBc9qqLe00onFM/LEUU8YXap9zOyFTzluQI898eHjAL
         DUaA==
X-Gm-Message-State: AFuF++nNM+51f8lw2o33MzDRwrID77aC0Wl68aTuLxWjIm15FdW4RCdC
	F/H1BrkPGkes3bbw4mH1H5LBDEKHnSXEHxep8FpLLVFT6awcXfr09oNni8Gl0+Tngn6nGBm7O3o
	zz4O8gVj4PrrwAA4j9eG5jatfYcjQkbl+NQgDEKh2yQ==
X-Gm-Gg: AYBFou1Kyrx3tC0/tJtQDcPj5mXNWYGkeG8/qmggV7oatGl3reC26xQWmQaKwv3MZA9
	KH50eab+MQiA1E4RujbHe/gpkukIbZH7ezubAWpY/J7HK2LsB8+M4fPW6ZIoWz20CFAdvX8T+cU
	tCiFWhw+b7sDnUMCAU57FhpHmScPa2faadcsFtFHO2ak6aAHAHJ50B9/geGAyE+zN7Cis0QpXuU
	BKis81Cy972R3MBR7s9Rc9eFXZd9wXa/mbdLFq5R84tTqWSipNqHiDkFFqpLFSpg7JRk1x+5Z+u
	sfafMIgjz5AVj48ahgKn/726wEv/2ZUw7csMn4mBFlEDksqjWo7o0xjXb/m+08mbgjqi9ehLZA=
	=
X-Received: by 2002:a05:690c:7202:b0:873:5c7b:c13a with SMTP id
 00721157ae682-8735c9a76a5mr8052607b3.34.1788555764789; Fri, 04 Sep 2026
 14:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787897193.git.rakukuip@gmail.com> <35813d54d61b7b415adf002ef71087af6047da6e.1787897193.git.rakukuip@gmail.com>
In-Reply-To: <35813d54d61b7b415adf002ef71087af6047da6e.1787897193.git.rakukuip@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Fri, 4 Sep 2026 17:02:33 -0400
X-Gm-Features: AcwNN1WzRE-WMrnXOW-gBNYNIJ6qfMt4LVYPtBsLWXJkGpDjXbxeT2yzV5bc5j0
Message-ID: <CABFh=a5mOKjT1h4X7c6hgQDNepKMSLp_irqC7hsd7c0U4GYK-Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] bpf: Fix use-after-free in bpf_prog_test_run_sk_lookup()
To: Ren Wei <weir@nebusec.ai>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, lmb@cloudflare.com, vega@nebusec.ai, 
	rakukuip@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 11:36=E2=80=AFAM Ren Wei <weir@nebusec.ai> wrote:
>
> From: Luxiao Xu <rakukuip@gmail.com>
>
> In bpf_prog_test_run_sk_lookup(), bpf_test_timer_leave() is called
> immediately after the repeat loop finishes, which drops RCU read-side
> protection via rcu_read_unlock(). However, the subsequent code dereferenc=
es
> ctx.selected_sk (checking sk_reuseport and generating cookie via
> sock_gen_cookie()) outside the RCU read-side critical section.
>
> bpf_sk_lookup_assign() explicitly allows selecting non-refcounted sockets
> whose lifecycles rely on RCU grace periods. If the selected socket is
> concurrently destroyed and reclaimed by RCU callbacks after the timer loo=
p
> leaves, accessing ctx.selected_sk results in a use-after-free (UAF).
>
> Fix this by deferring the bpf_test_timer_leave() call until after
> ctx.selected_sk has been accessed and processed. This ensures that
> ctx.selected_sk remains protected by the RCU read lock held during the fi=
nal
> iteration, while preserving the cooperative scheduling and grace period
> progress (via cond_resched()) within bpf_test_timer_continue().
>
> Fixes: 7c32e8f8bc33 ("bpf: Add PROG_TEST_RUN support for sk_lookup progra=
ms")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  net/bpf/test_run.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 5d51f6cb7d15..e677ec3390e3 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1650,21 +1650,21 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *=
prog, const union bpf_attr *kat
>                 ctx.selected_sk =3D NULL;
>                 retval =3D BPF_PROG_SK_LOOKUP_RUN_ARRAY(progs, ctx, bpf_p=
rog_run);
>         } while (bpf_test_timer_continue(&t, 1, repeat, &ret, &duration))=
;
> +
> +       if (ret >=3D 0) {
> +               user_ctx->cookie =3D 0;
> +               if (ctx.selected_sk) {
> +                       if (ctx.selected_sk->sk_reuseport && !ctx.no_reus=
eport)
> +                               ret =3D -EOPNOTSUPP;
> +                       else
> +                               user_ctx->cookie =3D sock_gen_cookie(ctx.=
selected_sk);
> +               }
> +       }
>         bpf_test_timer_leave(&t);
>
>         if (ret < 0)
>                 goto out;
>
> -       user_ctx->cookie =3D 0;
> -       if (ctx.selected_sk) {
> -               if (ctx.selected_sk->sk_reuseport && !ctx.no_reuseport) {
> -                       ret =3D -EOPNOTSUPP;
> -                       goto out;
> -               }
> -
> -               user_ctx->cookie =3D sock_gen_cookie(ctx.selected_sk);
> -       }
> -
>         ret =3D bpf_test_finish(kattr, uattr, NULL, NULL, 0, 0, retval, d=
uration);
>         if (!ret)
>                 ret =3D bpf_ctx_finish(kattr, uattr, user_ctx, sizeof(*us=
er_ctx));
> --
> 2.43.0
