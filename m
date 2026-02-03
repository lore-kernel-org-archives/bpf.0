Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865FB320CBE
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 23:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770162815; cv=pass; b=GqIpYmb/5bs3Rd3R7CetOzfsQjhVsQrEhGzMExmfnjGft4q6Wd3tij0m7LrX+ZWmAgQd4tPz+0u71DXzIFEFUAtg9NpiYZJQZMzQE0SVks6nWPUgaCRrC/kqEDOgDZWH637OrlNL/8DZfm8iPY5pVFgygTrjtThgCGz61MiaOXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770162815; c=relaxed/simple;
	bh=sWBU5dR7bqE6gcUoDbn4XTarOpaAPj7pe9odcGG41mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTlibp6xHVLW1OUov16Zbr9HNRH3DfYFt9ZAIElIZ6t5uU69T2FEw5WL4LMDwGOAiiEbBh8OK4RjN+nLv51w3G8uuSezyOoQ9LlRvrywrHACbqNEPHFSeIzOypVbpkQRlO7nG7bE48zvh1LMQgydpaNuiljgTgaISajLZ6b2T54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcZXTYDk; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcZXTYDk"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-352f60d6c2fso3988798a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 15:53:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770162814; cv=none;
        d=google.com; s=arc-20240605;
        b=lvMgHmKBgn4AKFuXGGNke8poxMp7Iz2P13qr1+/h+nenqqJSIuW6QRZJx2rdofyJMt
         IdD5PWxSteTLTqLqZP2rN8Ueqqz2iqEnsbD9Cm+nLukcJvacOdfHx1bj0/1d+xwEFyxv
         hMbpD3SEB/62m/QFwih/fCnk0AmxI6V+q01dGBUd5NFCxMFGs8b9avB4z5bEqjXusJCb
         WOn6O5UKJci+tLCDCVEM6JTpnaQHL1yurxgRju0JKhBnySa5whGdyYis5JW6D0uqCis4
         0hKKFM0oGY9SIZ7WgAhHYLZEz5L8wsTH1W3k8HUHuot9O0MemsuNXJuWvUFQ7LEqKor/
         p2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=prTlIOsn11D69UtmpO3SxDs0bMWJCxMIrQjJlk4NovY=;
        fh=ho6KmtfhenyMiGWYl8yibBZ1T9Ot2owIFIDwSbxpwss=;
        b=GfauLMIrlGBhe8BfIqAhvPrQQv5wHnh0uaS555C7SqXGOhS6JV0u6KmLVI3v+f59sU
         W5zQ21ZSzQCK4ZFd8HiPxeWwByudNCdG9AQWqRMYbcp9p57sPKsO5K/t+NTeJ4LJlgQD
         8zODbrHmSymYnwyQXiaKLnQskxuRYrgr0vGrx7wtXzHL/5p91k9CkLg1DXoPFfCMJ5gl
         Z0nAmK0ZYML7UWyX1pq0v+Z2mXPdtyzzsgsza8Zj8SlbWHQ+06Yl8tr9LrmSsc6yzfyS
         IYncK9NWyo/Qlf9Ue7zuWT1luK/1QMc8wzReLa7h1CB2d6IImgb5cj7DTvig++osvwgz
         oRQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770162814; x=1770767614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prTlIOsn11D69UtmpO3SxDs0bMWJCxMIrQjJlk4NovY=;
        b=DcZXTYDky1NWWYz9BElRAd9tvXkjL0ijik7bqNiUTmDmfF+DEElGcCxfxm9vEthW0o
         8WlIlkDm2tTeFszK1QHQ5led1R93ATQX1Mjj/mVBjBImAi54anv36FUoEf4MGY6ljPdN
         Zm6ZuXtqFGm5WRo01WS4ZWCssaSjLLYZGQsRDUqWt7WeyaUX1cfsJai6G9R8i80QH0dG
         4EZn2vWA5a7pKXZnLcf9qmnGxbuDoLCIPHCZ6rpLDP19XXgiXak7fbSUP6eZyMQY2AnH
         rTjPMfvH+eVoMkPmLNxMswusBUOvIfkQffSCkCdWvzBSqCaqo7ovom1Fv7sLyrQcEK+2
         N3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770162814; x=1770767614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=prTlIOsn11D69UtmpO3SxDs0bMWJCxMIrQjJlk4NovY=;
        b=Xsg+bMrcEdUASeB+xntGzlZybD+dwITEFgMbIh+JaTcAQxTwt/GqBKHAWCwrItaqkW
         y2gsfY5vhwBgTxj0cxsdwFREPs0SkmXl/Q26Sxp9wHsz/canb+/i/YBmuygEmSqLSj+X
         vZkQYl8ADN6b9nNR/kgokeDxjCGmT/7Wjhl69JxVW/jGrvyLfLJKVIzGsKrxOv9x7u8W
         FuBS65plozXuUkJ2Bo4J3Iv23NLB4Zm3MIzsxuYGbE8QfL6VvDhlSSthdrlmzBiCj+BM
         PV43k+QdApCQ8swNJQiIGX6drskgPLE5Hgx9XeNtsCx3mW4FR3bgQtoefolwC5qW5Cbf
         1oKQ==
X-Gm-Message-State: AOJu0YwGwy738RnBYTCdb3BbNVrhdyU39OfpbiJIbftXWaO5EDc0nyHP
	SrFV6PZuGOL8kdhuqilT8wlKfAfTnQ1NKTl5AQeOO8giiqGgvpVNX5ksa23GQLyUgPN+S3zl9Zj
	GZBuo/Q84ntu4j81tZrqHYLDSWDq9p1k=
X-Gm-Gg: AZuq6aJ7yvhonIED0XwuZiBr/yG3TzuD7snXL649zkurJPltck4S4u/7q+21zvAqSl/
	4ka7aEq6s3l1vOdjqbHlPrzUkENfPKgg9QiW7TzLuYzx6mOsqiQRudoW9viztL/NS6K74G3IQUf
	J418PjkQnurCBAYusNxL+Hz4M8XazOGu0D417bNp74Of1YeKw/6RMN1UwNAW1z/iLLvuhG+dDOY
	4gdB5pncWLzfXsJu0x48D7/ONU/ktyP/LLd1rMGCNeBBnPR9gA1cv4Kci72ImzJE3oNWiH9hzGP
	tl4n8yczR72XAHQPTMtRWg==
X-Received: by 2002:a17:90b:35c8:b0:340:b86b:39c7 with SMTP id
 98e67ed59e1d1-354870e4f05mr970587a91.11.1770162813798; Tue, 03 Feb 2026
 15:53:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201025403.66625-1-alexei.starovoitov@gmail.com> <20260201025403.66625-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20260201025403.66625-2-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Feb 2026 15:53:21 -0800
X-Gm-Features: AZwV_QiKoT74EqANVXoUXIK7AA56gMdL3pVyxemqI-vahhc7gXemF4oMZGtsWwE
Message-ID: <CAEf4BzZxWzntugOkbPLC=yy9TZ4v1YVaALR25-rOqF6xezVW-w@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 1/9] bpf: Enable bpf_timer and bpf_wq in any context
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, memxor@gmail.com, mykyta.yatsenko5@gmail.com, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 6:54=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Refactor bpf_timer and bpf_wq to allow calling them from any context:
> - add refcnt to bpf_async_cb
> - map_delete_elem or map_free will drop refcnt to zero
>   via bpf_async_cancel_and_free()
> - once refcnt is zero timer/wq_start is not allowed to make sure
>   that callback cannot rearm itself
> - if in_hardirq defer to start/cancel operations to irq_work
>
> Co-developed-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/helpers.c | 408 ++++++++++++++++++++++++-------------------
>  1 file changed, 225 insertions(+), 183 deletions(-)
>

[...]

> @@ -1456,10 +1493,20 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern=
 *, timer, u64, nsecs, u64, fla
>         if (flags & BPF_F_TIMER_CPU_PIN)
>                 mode |=3D HRTIMER_MODE_PINNED;
>
> -       hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> -out:
> -       __bpf_spin_unlock_irqrestore(&timer->lock);
> -       return ret;
> +       /*
> +        * bpf_async_cancel_and_free() could have dropped refcnt to zero.=
 In
> +        * such case BPF progs are not allowed to arm the timer to preven=
t UAF.
> +        */
> +       if (!refcount_inc_not_zero(&t->cb.refcnt))
> +               return -ENOENT;
> +
> +       if (!in_hardirq()) {
> +               hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> +               bpf_async_refcount_put(&t->cb);

any reason not to use bpf_async_process_op(BPF_ASYNC_START) here? you
are basically open-coding it here (same for bpf_wq_start). For
bpf_timer_delete() you just call
bpf_async_process_op(BPF_ASYNC_CANCEL), so it's inconsistent...

I can fix it up while applying, let me know


> +               return 0;
> +       } else {
> +               return bpf_async_schedule_op(&t->cb, BPF_ASYNC_START, nse=
cs, mode);
> +       }
>  }
>
>  static const struct bpf_func_proto bpf_timer_start_proto =3D {

[...]
