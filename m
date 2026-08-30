Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC72F3621
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788071100; cv=pass; b=TqTi3zFNwYZRlFJbkNLEU1/OtNoYvy1eItB4OYmSAMAMN9oJlzKsrX6HHhERp0lmzV+GeG3+Ytxv2z5O35mUlqmc5qHN1WIFOlSu8DUdCFTCiqobUYFoi2LpgG/i170VJjps+omwd9QQCc6j4yL69lbdZqoBdkA6IXAU7/FBmYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788071100; c=relaxed/simple;
	bh=mwbnbaMlp8Ae2B8ikyuYp+/a1SwbvdOTBH/giZFf1pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBXfW8FOTd8o6o3KS7Y84agrVrMa+YMTJzBQ+CjMyd8JKr3haD5HBIQrHHlw/eBUhlVS86qyH8qEy+NwcgkKAq1HTo35jhglO6zt/fuUhvRPGXb6KlBaIS1gyLVBUuBCmL3Kz8jxqfKTpAHZ5DKSvT1mPYsAt1cGWuh8fsAE/m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aB9nAcNX; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB9nAcNX"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-85a50f6a7f7so26164687b3.2
        for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 23:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788071097; cv=none;
        d=google.com; s=arc-20260327;
        b=dSZa1lxyrzmnuAstgbMU2n3XQh8PzNqgnfw3NNegwJILHAV35T8210FakTjw9/fFuS
         220xWQxudxFTl9idwXXvx+D0KqWgsJ5yV+s2czg0MR7Zuxic11Mmbyeis96wGt0vWMBp
         euFYQzCaMs3Rghhq3yuTROwqjCG4LOqljMJTY8E4S3pELP1M0BcMSjN9ywgH4/ZqHuUT
         5pvamUSpX4dRRoKuZYABYueMkOrcCnfgD5S6LXkG+IzGAHTabX1++PXbIxMh9y4lZq5+
         dkUcLYVpWjQe5imZI0tl93zP6zBOiH4L+34cZHj2RfMe6n/3DOy+uLlQ3GxbmEmH1KTC
         utnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZkOfAYL8ZF1FMqf/kMu36qJzGPBJNOCPM8hwn45vbh8=;
        fh=qnbUtehjenKXBfFrRK+O0oz5UM5RDZ5ZNB5IiLColMc=;
        b=Qo4J1eZR5nYtSh/8XqcTTmJBqIHdvDlMFgvnX61p4O6DyBOBihUzcqhrQGVIxw+/jr
         S7AVahzuF1CzatHuFaJ4vMyGfSU99R2pJsXfGle6Hk0nLwvsqKSyc3vI3TFubeFxNq/0
         FNhnHopZoUNSmwdzrVHbz6US88vXz3NAI4/ZNB2UKskAWqzpTyZn086WEPSMMBr5aTnF
         AJ1imdwm7GTUkcud5RnKhusL6NvUZJCMujbmgEzND5W7jh7xmDGR/YYjh4EzPV5EuoLB
         UUPuVsrrVN1Y8HUHtWzeDssGXWbBNY251D+LyruJsnAwmartJboA5yW1gdPLGcJqAVhi
         dN1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788071097; x=1788675897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZkOfAYL8ZF1FMqf/kMu36qJzGPBJNOCPM8hwn45vbh8=;
        b=aB9nAcNXdlaizemZAEDW0HlxNga9CJNXMVl8w47V+7iWr8hRPcU6h6Cztrlu/SvhHS
         4SURfH99wDWltcgfyf9QkJgpGDpbu/UfM3Ivp/gXz/lxTxEf4wTn0b9wZVNLEgR4Z3kQ
         eHbj/gVgNKp5og6rPDOTXo3XYEB9a6CD7G9uyxgX1aXVlQTHexzFnSuq5oLvzELRorPs
         J11VoT6sbfw31BKvVqtSc5qmPOd9OmzxTfjr2ZEhVt2+Fuxra4/ovg+gUWeRtjTNZDO2
         hLQYetiMveRTd0vlTUsaCWUdM/N4TenodcNIprngyuV7dHYQtd+2GI0++/n84y5t8/p0
         ffIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788071097; x=1788675897;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZkOfAYL8ZF1FMqf/kMu36qJzGPBJNOCPM8hwn45vbh8=;
        b=iDhXykCpDgkxaYeziO32sMAG5sVAcKrtIp8zkZpcOsZLsFKfE3g9j8gmOTDuSbA+zD
         30AC0HFzV4GdKxtxrhCK+Wy66l0DMsBdrR670iXoRZrrY6z/fFaQzjaqUes7j2ff7CR5
         qFsbT9BmskB/CwKPKaHnzSasfTgbQIA4HYz1RYuJv43flz7K+ZBvl1ztjct/kI+AM3U+
         MldNEiZzTN6xi5AgT/7XMEGeue+33oNAfzIIh/zV4GEmO7QGCoiChKbQ3FPdVPc213SC
         a/o7TYdeSwvOsB/taJu4lDknp/Igwevaq2fVAjJISVDLfcbB7fyed8zfYaBkCV9BbDv6
         X8OQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4M/RJioCCzo4N+3FbSoQr5lVBSr0CDPRUygpSAT8osKLFWB4T5hAdNsJieYQ6EWvRbeM=@vger.kernel.org
X-Gm-Message-State: AFuF++k8VUvuMfi8ScwsVeK8mGW9KZO5uXYmPztHBdgL8ezGj6qjvmZh
	O/0ljxqiGeDEfOVHbwLGukD7KpLqxwbsFZpdTlZM5QYUbFQ3FIQdmsSjTCLq6MusgWhQ+BPRGDi
	7hzD5CaHCQkbW6C3ZJ1zTCpCTVteiS8E=
X-Gm-Gg: AYBFou15LlFrdnYafPVhfx5gyuISEWOlIbH6fg6GFSJXcjPiSzl5443eLR5ZqXrB43o
	KWq9ONX7Zz2jTHrxXXoXZrlvfAhqeZjvDf66Mqh9oViyK7kA718iFMzpi0TaAFHQWYwd8CXaOvW
	O0/WWFK5qAYGz9/sqBhOXoWHxXErY+lwDGmc/iR870m2dh8uPOs2GwQqOspBhWMt4WcUFu0ADx+
	MHKevgRO3u+vNkrUXSoe6V2qAZbXAWNCP11Kxu9OT8H3c9qri6OVxGZl5dZuygZlNYC8RZ4bnmI
	2quOCqUAnxWNKYbwdG2Mz71e+srdNUSPipOdtmdwDsdPZXNxa5zk0Pzswsz6bpPiBJ/sRcFKbhG
	23Ietk6wfcNdJckXzSy4fAvzctUvEBrJTeA==
X-Received: by 2002:a05:690e:118a:b0:66e:5085:f264 with SMTP id
 956f58d0204a3-66e55740fc0mr3654481d50.49.1788071097333; Sat, 29 Aug 2026
 23:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825044507.15217-1-kartikey406@gmail.com>
In-Reply-To: <20260825044507.15217-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 30 Aug 2026 11:54:45 +0530
X-Gm-Features: AcwNN1UJXiPxeecGwMmPThQayYhPtdBKrxtA98QGwRhlFNCPnG14xtruFeO76pg
Message-ID: <CADhLXY6D-+FC24c8-UWf8xW+5tVGM=J-qhViKxRWCfPDyvQ9Lw@mail.gmail.com>
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

Gentle Reminder. Please let me know the status of this patch.

Thanks

Deepanshu
