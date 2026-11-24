Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795514621;
	b=xG9Tg8YLF3h3uLy9IVwkfCLa4Utg1LrN5SY30ccXVnGdJIriXOnm00yb9EKoueY79t8z
	 j0GbOLzVMSlQMW5z9JNkWijed1KcmjAs9hy8j6WcTI1iZOxhhtOd0L7/SgPv8blfp9V+z
	 KK5VD/ZD2P4skgeDfK/HrzSqQ8JWGs8Nvpn2FsLRGOu6VKqskxmXBaA5emLtzvRbagVA3
	 qwOPsy100EFEqajkeXFGU+Hi85Qfskk0WlV+bNPOkqV5sDw1seyotIZOuUh9Fg43Qdtpq
	 dLjyA0rBaKch5a7AktuvZm1H199FAltQmNKrlkDvVltIS0SqyUC30y7wEYaZD9Gg2Vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cGN5g9PtUGCG+wcdSVJumY3ZUtFUe8Es3+mlikmGYwY=;
	b=d2r4WR5i3BlW2bEg64eX7gCJBtqQ0T48VsWWzjVA4JnGI0DARO/PdMug0gzm775QEY6T
	 Lv4zolgu4ZMr/GnBDPofho80wAenj8h4nhCqXTrf/mJbEXjW5NelxSpgA20CUB+ivZ2m8
	 vOCTjWoW7cqrIYOsY1aPbnchVFbSd7YNlZNXPsRc5A1YRfad4NPPGE3/FOgUzRUGeV0HL
	 EeDk4/UxmUHSTjqRk3TacxM0P8CGd9QCBeLjFlVyOA6spVzeNWSr6aR5o1tuTCfwGAHE7
	 UInRf1gfTAIE677mXs0hxXy1jPTm9RX2C0umZ2seXhl5nQznKr3WbHY7uz6aFJHtruQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=VmWAs86N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7F4606A331
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 10:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA7F4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=VmWAs86N
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b6b22be970so1634274b3a.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 02:03:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795514620; cv=none;
        d=google.com; s=arc-20260327;
        b=pVTVOoKFG8R0amYYHzU/wnIKUeG+frLOBSZxXpzil6NTGgxUVtK0prHqW41RxC0Obi
         pwGHoyl5VBnaaK9hai98rO/c4nvagluVO7ucVfpziP6kS07Coh5UOyLYo7i650dSw6QO
         trGFHEKxFc/cFV75jT2XrgwjQc7NQUoZOkUqd/UKsN/DETsCiq1+OAprmvkgoSxs8iVf
         n0uAZphXzpoePwlSt8qcD2P0k4aOhIH8oM+/wifdIOmTwseJ4wyFk2MSkSq8jByQWhiC
         NdZZNTYa9G5KtAgX9L79r2kz8KVR6cF3UwKyaHIvg65YkpbK4Z75WwLjj1lmZAbxnQHI
         L8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cGN5g9PtUGCG+wcdSVJumY3ZUtFUe8Es3+mlikmGYwY=;
        fh=vmDsDfIKaig/KTINxbz9Ow7Vzxe8HPXRFi9i0XSmMp8=;
        b=lvMaL94yNlTbx8G0Alc4ATqhsw5wLLvsGkdhipEUvDzs7N7o1EqslayXlKk3Uy+4aW
         p2RLaZASZUbDT7q9kMwIRa5xLS6AUzQBgF1WAn2vNS+wrmMc4LgL5422X2LFgOi9reid
         eBCc7/hrsBD4TpnAcl5pd07qigVgPBBHwgKfNqaXarvgbGhVjo+cCOIYUWQP3F+s8u1J
         cGmrvcUK5ehBA93z5aK/rDOTDmfb0+F2vdQ+MiATl/wo9sfXoWoHspcWtI7Jx7JesYtG
         +VKQpOjIlwAcVu30kb/AkXz06NiG6YCkHH7EXjUNkE8dFsA7IYsxG09UHOV/AE+Qw7ck
         zaIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795514620; x=1796119420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cGN5g9PtUGCG+wcdSVJumY3ZUtFUe8Es3+mlikmGYwY=;
        b=VmWAs86Nz7sib60O4izbmOD6cZh1oJHcY4TIr9SaP6pD5C0G2T6As0XqGlZXCid52l
         D7UokUSGtJok+76yw43RikasNHy7al4rTLqNt+q+izWEJlO4nwef7uYHHiWgKe9yWWTM
         I5j2coA6k1F5B5uggw7O4grg7Mi+N5CcJvy20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795514620; x=1796119420;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGN5g9PtUGCG+wcdSVJumY3ZUtFUe8Es3+mlikmGYwY=;
        b=AUGrCT07d2ww0OuGpYCXTpa2LSmSHrYUB4g+bk9qRz7AUq67qgFHA6eYeq7/Ovxy/U
         v7P4R7y4p9OgLNHBmhFVndTE9sxm7TcnUnXCCK1q99IqdqRa/K03wO11q258kePhxJzp
         C3Qun6Cp5gxWzDSX/SX7X5ExmDe3LtvlhqVfalumgdiuETWdbILVRiRXhUeB91BFMcnc
         yz6MFWBdJfqnBXSPAAk4MJ0H5LnHbzfgQaCfNfhjAj0T2FL0HwalJ37J1IZl1j6LuZUz
         ap68kre8jl46LvotWiiNm4MSuTSGlZ1uUQMYKGh8es423fxzjBdFtQDDSWS6onG+k+Pq
         Vpjg==
X-Forwarded-Encrypted: i=1; AL+hErE8wbQ1QgtmdDeM9VCfWQX47oc6SPg2TsmLgJxVKcc3iH0yAgIdKLkJ3OaPxYlO1X1XJa8=@vger.kernel.org
X-Gm-Message-State: APuU4Z88PBgv/xb7lzrtvi80k4UPf/hbXiGkIC/OZnqRQfI8czxzYBmA
	dIGyJfVUdsYMXtrU4GttzjaRgEvzotgbBAHDyZZJugtgsF47SH/6gQwTvsZkuw57uNcI49rFR1w
	PXuJ3QlOd4n0zdgO/ClPlpkszJY6cYIy623VFtHAB
X-Gm-Gg: AZFdTZfUeeSfagdrH7TxI25StXKS68qjAc3MJT/fPMiUzTdS4lLka9bcvqggwvF6x7r
	mjTmVxSWKTl2CZzbfCF/q+bSde40RXU6tiz+U6iYVjZtVgFOniQAorHEENqUqL/RpVr+4rw9CeY
	cdvCTsoHCpnwAnyhWBv4mGKA0fPZJHQr13Xp7czb494dC++soJucgywhu7NJj1Gn562URPH6BfE
	b2ZNVwCV2J7inQJkMOkOr379nPlJgHmHtSaU4pXIF/X2NAic32FZqsJUCmz6oXpxj2KsTZAPlst
	eYL7qtEzibbHu/HuQwt2UYoKsrAZ3pbGDIpwmTXRupxXEpQKQp5q5+mYkrQ+2eA7bxEE5mYU9IG
	WKCekmu3CrvZkl+VNvMP3dxoRGbwB98dURehoF47EiTquWh1U+QP0Csh0nYd+hBOfl8eLvAlYrC
	YOvzQE8+QEcbFepcrMKY2+
X-Received: by 2002:a05:6a00:3c84:b0:89e:ba55:119a with SMTP id
 d2e1a72fcca58-8c87d123bd5mr13499490b3a.47.1795514620227; Tue, 24 Nov 2026
 02:03:40 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6b051681.58b41460.7037.0590.GAE@google.com> <DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com>
In-Reply-To: <DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 24 Nov 2026 05:03:29 -0500
X-Gm-Features: Aa3M54qvcfjcRlRGJK01N9tkR68vSDtEhX-HABSVQSN3K_q0am-4DoB8x5iA1ls
Message-ID: <CAM0EoMnVa=xGD3uiZKuzMfFL6oZNd=Umb0U7+_QUrTK7Ej-BYg@mail.gmail.com>
Subject: Re: net: act_gate bug. was: [syzbot] [tomoyo?] [mm?] INFO: rcu
 detected stall in security_file_ioctl (9)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, andrii@kernel.org, bpf@vger.kernel.org, 
	brauner@kernel.org, daniel@iogearbox.net, jack@suse.cz, jmorris@namei.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@i-love.sakura.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-users_en@lists.sourceforge.net, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 1:00=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 23, 2026 at 08:45 PM syzbot <syzbot+b6f8640465bdf47ca708@syzk=
aller.appspotmail.com> wrote:
> > rcu:           hardirqs   softirqs   csw/system
> > rcu:   number:     5264          0            0
> > rcu:  cputime:      138      52351           25   =3D=3D> 52490(ms)
>
> It's not tomoyo, mm or bpf. Looks like act_gate.
> Zero new softirqs in 52 sec, so one hrtimer_run_softirq() doesn't return.
>
> > RBP: ffff88807ed35538 R08: ffffffff91be1bbf R09: 1ffffffff237c377
> > R10: dffffc0000000000 R11: fffffbfff237c378 R12: ffff8880b8228600
> > R13: ffffffff89fd0480 R14: ffff8880b8228600 R15: 1ffff1101704514a
>
> The registers with lockdep struct sizes:
>
>   reg       value             points to
>   --------  ----------------  --------------------------------------
>   R14       ffff8880b8228600  cpu_base
>   R15 << 3  ffff8880b8228a50  clock_base[HRTIMER_BASE_TAI_SOFT].seq
>   RBP       ffff88807ed35538  kmalloc-512 + 0x138, tcf_gate->hitimer
>
> act_gate has the only soft hrtimer that can be on CLOCK_TAI.
> bpf_timer_init() rejects that clock.
>
> TCA_GATE_CYCLE_TIME is an unchecked u64. In gate_timer_func():
>
>   n =3D div64_u64(ktime_sub_ns(now, base), cycle);
>   close_time =3D ktime_add_ns(base, (n + 1) * cycle);
>
> With base =3D 0 and cycle =3D U64_MAX, n is 0 and close_time is -1.
> The timer restarts in the past and __hrtimer_run_queues() runs it again.
> It's there since
> commit a51c328df310 ("net: qos: introduce a gate control flow action").
>
> Jamal,
> taprio's INT_MAX limit doesn't fit. tdc uses cycle-time of 600 sec.
> The diff saturates the sum instead.

Looks familiar - i will take a look.

cheers,
jamal
> Here is a potential fix:
>
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index 711cf24..5422d60 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -45,8 +45,9 @@ static void gate_get_start_time(struct tcf_gate *gact,
>                                 const struct tcf_gate_params *param,
>                                 ktime_t *start)
>  {
> -       ktime_t now, base, cycle;
> -       u64 n;
> +       u64 cycle =3D param->tcfg_cycletime;
> +       ktime_t now, base;
> +       u64 rem;
>
>         base =3D ns_to_ktime(param->tcfg_basetime);
>         now =3D gate_get_time(gact);
> @@ -56,10 +57,9 @@ static void gate_get_start_time(struct tcf_gate *gact,
>                 return;
>         }
>
> -       cycle =3D param->tcfg_cycletime;
> -
> -       n =3D div64_u64(ktime_sub_ns(now, base), cycle);
> -       *start =3D ktime_add_ns(base, (n + 1) * cycle);
> +       /* cycle is an unchecked u64, the sum must not wrap into the past=
 */
> +       div64_u64_rem(ktime_sub(now, base), cycle, &rem);
> +       *start =3D ktime_add_safe(now, cycle - rem);
>  }
>
>  static void gate_start_timer(struct tcf_gate *gact, ktime_t start)
> @@ -107,15 +107,8 @@ static enum hrtimer_restart gate_timer_func(struct h=
rtimer *timer)
>
>         now =3D gate_get_time(gact);
>
> -       if (ktime_after(now, close_time)) {
> -               ktime_t cycle, base;
> -               u64 n;
> -
> -               cycle =3D p->tcfg_cycletime;
> -               base =3D ns_to_ktime(p->tcfg_basetime);
> -               n =3D div64_u64(ktime_sub_ns(now, base), cycle);
> -               close_time =3D ktime_add_ns(base, (n + 1) * cycle);
> -       }
> +       if (ktime_after(now, close_time))
> +               gate_get_start_time(gact, p, &close_time);
>
>         gact->next_entry =3D next;
>
