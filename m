Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795556892;
	b=X8hTmSebhSxgV25ejH8olcv153N+CWO2vXegColSZ18nAgzJVxJMCrGXeRUMemFIwzSx
	 PCesY3U3G0RUoPgCPrP3Mo5kbtuPGYU3Y3yEd1XZSIoW8jQiYFukwNP3vVJdB2jzs7jDs
	 xeTViA1R74pia7RFQe0f0ea6OmoW1Al2NlV8h75ab4xUrlnspt4xMCJDeexTG96LGVz1R
	 Zb7WWfLzcZRKB5b1sk9aXqMsFRQ46jg2SOxvBmVOs46nWx9z4UOX12BejxZvjtTp5yVXL
	 q4KnngjdjiLXQ22ue9Gesg0iBsWh+2PcUaTX+0AbGxwmf0T28brb6MeGeYOqNcgjshg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SgapFXyCDKFt+peJ7rxw0qXMyT6IhM0lKM6Lr08CTds=;
	b=U6kFpP02KPnC8s2zZ0Y28tblho5wsqX9oAgyl8Wfp0NtND7NzvFnebCyu40CeD2sD1vM
	 W1U3Nsbi+jdUiiLzpjyH8PoG0BJ5nq8SO7we8TrLvkmE0XYfrpc1ml0eeNHz2h+zSlSqi
	 46Bw1mq0moFlPhZQLCPqu4yO48gBDnbqiF/MZD4cwkEelf0d+Q3F/ejFupnAd9omfd2ae
	 vguhDNzJnnn/2tG9huo07jrCPNkTE2Sh0r6RRv+XP9R75JHUmOodiJGrWuWu4bV8ptCgh
	 C0tE2VWB1SpmO4SYDfB+aJHAgREGOVAzwPsbj/PNTZKd6bayL/afkMVAr2FN5QdHubw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJVqJJ+6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B0606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 21:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A7B0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJVqJJ+6
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so2966748f8f.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:48:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795556890; cv=none;
        d=google.com; s=arc-20260327;
        b=ATKDk2Xe8ITUDLqhqn+YIutnmR4Tci0kRs8fNi5Azy6WGa/rkvqrMBbIFnnaoBZoHh
         tWxwT/U3u0fvdFLk2WE6xxd88m5g8R67/vpiNJn3e+kye8FUhhrlo13xlLp8VKIeDJUY
         ds5hu9PE+1evXuO122qmw6ufprK9VmiUa2Ppc1z/Fj1mG1ieFYTVxF58hqYbbq0LYm1y
         Ru02VVi2znQ8uPFKa/Hn9Y58W+MMVvsQSLU3nRxtfg09Xkxj4tZ7cfbDhmCRe3k/5YNb
         rAxcF7tCe1inRlvhWRxKaBvFRWsoIsBvup4Qtm+jCHv7SUWVR6eRxnqL+Ew3NeyiZ/uk
         KuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SgapFXyCDKFt+peJ7rxw0qXMyT6IhM0lKM6Lr08CTds=;
        fh=xfnxXem63xQ5mVyCd7l6f0B25q2hcG4h2qMaZi7ng9g=;
        b=P1LXlmIPbcH5Ef/7dmN8jrv/FSBGtCb5BqWA4CTTc4qGJTSJvSaQlW+XTZHrQVD7Wv
         0TEb+EdHbS/2lPNpOn48Kxpk/ada0Br75y7M5aZ++HuGAs7bSrw63K0NR1cRJchnW+46
         L2b3EF3tfGDToKp7ABOmVUIPI+vcw6fKm6oZRqNL4Hlbsk5stcx9ORUp0/SiMd3eUC9O
         j5Xj3q9EmFEZWNfo296GFj0NyEEVirddU5V5kgNJDuP5h+85cKW/rLcAPgAdefhoAMXN
         THBEYC1oaMkTaMeIuMf1h9md9JqWhHF7A730fm4rxEIJKya83D3r1gWpHHwl3sHDvzSj
         tgLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556890; x=1796161690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SgapFXyCDKFt+peJ7rxw0qXMyT6IhM0lKM6Lr08CTds=;
        b=PJVqJJ+69ydWTdAOwldeOa/Zj/oB1g/WO/zF7iEkoC4mDRrbViIThuul+JuPovnSy8
         VZPYecWWf8aLtnEwNQ1utKYSshKRanMRv1jps/aMfaq7R+ooeavz+OMJtKggZDXQrRBV
         2zZ0eoHWjD0KfpS092rbqq+ea6adZ4qiN904dMbpY6gsgLZgfKqCjThFUnPFowdFu2dn
         VM/qbz3/7AuMADxjYBaLk/MlY4MJzP8iAKicfOjMwlO7P2ZKWxFsPLg8dhMeISZJq0FD
         oNe9kLD/juIUFXh6NekvH99kcZz7l5tRMesdS1E/YznaTja0wQ1rsYYfz3w5C3w3Lszd
         UrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556890; x=1796161690;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SgapFXyCDKFt+peJ7rxw0qXMyT6IhM0lKM6Lr08CTds=;
        b=RflyHfuG0AYtINgR3Vlm/M0PY3HoDtjDLQhUPTIjuQ/z8xHQckfyYDuaZUMSFPxawR
         hvRG6L1JnB0N1M6w348kNJ7bs2U1a/FmckqAFV9JRhFfvVC09VE2uiKW9UHYHZganNKk
         Gs2I2AWwNhEujPpE6xi5WRHn2SlaDGfAyRps7h5SJ6qvoKWHjBjvPxABIaNf8i4uDE72
         OxBi2Jv1yfbgLFz1zqTsUjiLk8oJwtSec8lMx48c/RGnmPed99nzadwMp5nn9GauwyrX
         1hhNVY7HaFpMKStSNw/DBJsmAMbYUl0nR5jIKnl9B8u7bFbBjKyAT6A0D2tw/5uLaQYO
         bl9w==
X-Forwarded-Encrypted: i=1; AL+hErHjUjbnHQxj485vYNoLMPkmBFEO3llMXIwIdetGbUfyt2TTyDR+BRNcK6z6GpLSNVGCJqU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wvxDhD87nQllgSsaL4HuNe9WGXMN7LPwwd68JE3ATW3riUlom
	Ah1o5Y6MnmsZ1BM67acHA8HXggmvGM6ngvopGDSpbsnmQZAbqqNXhHdeG3J6cpu+MvqnNU5JewD
	MMvk+e32xYquJdVBt0uaXsIJ7NEbBtT0=
X-Gm-Gg: AZFdTZd+ukfvgBnqyrAfON4EUvYVpuA7uPBQqFYKeaS0YllLt3opG16qmVuUBqA8TUv
	ilqEqqbK98SZ+gpfsKMH9Apxr307ChOTF1Xm7bZMgSKWoHDfy4eyLkLYUjmNJbMnEWbtctT65LI
	ih5EYeXvyhMhaIuQhZPZo/I1WlbRdI1RMzmIbYd6bEk/bfPONjiJouTlUsk7WaftsVcMETBc5e/
	2v5Ha7jBLiN3uUXxrzCg4E022Qko03EEMmsJCJNvBMj2W/2Y8Y/ZJLycTMuhHaPo6buiqAxz6gw
	48IWwIrTUN8aEDx1mvc6i6Dg5K9v0cV3QpDdqIaAe52Wws0VtAVaZj8na042ym2Kj90gkaAO2aE
	n+7Nyf90rDcHlLi5uP1QJPFC2v3mfZIheFIL/mGESx+QCubUfZ+OTnMvkO0hW30iiH9LaQvMqzd
	G0J6+Sw+77j+LKOagMxMw=
X-Received: by 2002:a05:6000:27c1:b0:4a5:26ff:13d0 with SMTP id
 ffacd0b85a97d-4abb0f3b5bdmr20496747f8f.14.1795556890344; Tue, 24 Nov 2026
 13:48:10 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com> <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com>
In-Reply-To: <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Nov 2026 13:47:58 -0800
X-Gm-Features: Aa3M54r4cLpLVpvm5Jm5CUzi10h61k0_Z20IJHqjjVNyNuLE3oFuveUgR2mZQgg
Message-ID: <CAEf4BzavErcSOZhGobqEo68d+2bCnJ8vFxxT_vqb+oQw1j1d7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: mikeba@sentinelone.com, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 10:21=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 17, 2026 at 03:29 AM Mike Bazov via B4 Relay <devnull+mikeba.=
sentinelone.com@kernel.org> wrote:
> > - Marked programs are not fixed. A program with a per-CPU map or a
> >   tail call loses runs to preemption as it does today.
>
> I suspect users will hate the behavior introdcued by patch 2+3,
> since adding a per-cpu map will suddenly make the prog to miss events.
> But the idea has legs.
>
> Earlier I proposed to insert bpf_preempt_disable() by the verifier.
> No need for that. bpf_prog_exit_run_ctx() can do it when per-cpu access
> is detected. Like below:
>
> > One question: the marking is automatic. A flag that the program's
> > author sets would avoid the second trade-off, but existing programs
> > would keep losing runs until they are rebuilt. Which do you prefer?
>
> No new uapi.
>
> >   series #2    42.34 [42.12-42.78]  39.87 [39.46-41.38]  41.53 [40.79-4=
1.75]
>
> Good enough. let's keep the walk. No need for the array.
>
> +static __always_inline bool bpf_prog_enter_run_ctx(struct bpf_prog *prog=
,
> +                                                  struct bpf_run_ctx *ru=
n_ctx)
> +{
> +       struct bpf_run_ctx *ctx, *old_ctx =3D NULL;
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +       old_ctx =3D READ_ONCE(current->bpf_ctx);
>  #endif
> +       run_ctx->saved_run_ctx =3D old_ctx;
> +       run_ctx->prog =3D prog;
> +       if (prog->percpu_state) {
> +               if (!prog->sleepable)
> +                       preempt_disable_notrace();
> +               /* sleepable prog should be using explicit bpf_preempt_di=
sable() */
> +       }
> +       for (ctx =3D old_ctx; ctx; ctx =3D ctx->saved_run_ctx) {

do you mind checking if unlikely() around ctx improves performance?

> +               if (ctx->prog =3D=3D prog)
> +                       return false;
> +       }
> +#ifdef CONFIG_BPF_SYSCALL
> +       /* Initialize the frame before interrupts and NMIs on this CPU se=
e it. */
> +       barrier();
> +       WRITE_ONCE(current->bpf_ctx, run_ctx);
> +#endif
> +       return true;
> +}
> +
> +/* After an enter that returned false the frame is not linked, and the r=
eset changes nothing */
> +static __always_inline void bpf_prog_exit_run_ctx(struct bpf_prog *prog,
> +                                                 struct bpf_run_ctx *run=
_ctx)
> +{
> +       bpf_reset_run_ctx(run_ctx->saved_run_ctx);
> +       if (!prog->percpu_state)
> +               return;
> +       if (!prog->sleepable)
> +               preempt_enable_notrace();
>  }
>
> I think this should minimize the breakage and fix the issue.
>

So basically to opt out from this behavior BPF program would need to
stop using any per-CPU maps and just implement its own poor man's
per-CPU storage? And even using SEC(".percpu") would still be detected
as per-CPU usage, right?

Should we give a way to opt-out of this protection explicitly while
still using per-CPU maps?

> pw-bot: cr
>
