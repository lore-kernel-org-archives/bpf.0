Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0BA43B48D
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511312; cv=pass; b=W9hVU1j7DOQjOFKCWRwRDxxygDZH3THZ2QS4ePqn/7mPN8jI577R+hC30WXU9mpkO/t1S248ny9Sqld5mCDfIfuyvRW4hS4Kx4kUpLfNy/i0M+hY5z1rTk36luSIz9rT3LWsm0cMwXGiqL92o+57EfiARNXJTzvyi0xlMNRcgw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511312; c=relaxed/simple;
	bh=v+WL3XoOwQikXd2JtezOQGH92bijGZnMB9gOFI0vCIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uj8WL62Sw0QuCUILN+GpqNSjRtJ0SIOk6Iz7TMBsE9jDBNEAeTsNHxga/99EiDfnp/05v/8IaOoNTGKCtN9qUWrX4WF6XsWA+H4WGTlbwsW9SW64ztjBKsxSXbifNXtQga0ZH5+ZUqfEel9YT0XfhfV8QAq7w1vAlHmv6LIS+LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQeqDpEH; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQeqDpEH"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84a2dcede83so1647846b3a.3
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 08:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511305; cv=none;
        d=google.com; s=arc-20260327;
        b=R6nbA8oMdqhFacm8BRgnwU9ODbcx/Fu1/296pY7DlPjSa0CfVLNEXUq9L4dq0aYyau
         opkvjoxN6dKSSIkpzq5/MPCvLto4UUvXLJg8B9TL9u9kiCXEMaidL+ypGf6PynjB6aBw
         UBRSBlxrt9d8/3pCM2I5Wc4ar5H9gP3RTya9nTEZAtqXufgvT02oOW55njOtco2DhkGq
         iJUDePvbFIGmwr2CBtrGarCq2QqaY/jA045fJmP4ohsAD/+UFAay8sa0JcjZF6PS//65
         Ac/xPbsL+tApihv1lRLmISK73c1gX18x/T+y5jAOo+M47bDL9VVcVbcXqkkV0X79E/2e
         bjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p9+LRn/SvSrh7d6/E5JqQArA7jl7jdT+NZc32lFMXxY=;
        fh=ZD+TWjvdVv6CQAJ03pcYJ5YB24ceDiblC/Zer5CxQ0A=;
        b=F0YAh3k9sv6+I6BSYrzu5InvnKLze42CUvWRF8+5oFU0oGdRLce/lFGBek/be2+Rip
         usLq3Zmu6LeurppTjQ2Z+ypCx1xIfGn6KvWjRqN8DAADq/7o577BXdYom0OoHTw9GZcR
         UCw3WaPaEA8kTsEASzG/lSV3owbt1IoW9H3Ed0clX2cQsfT+CWrgBzUWn8Ei4EUp6Afa
         TDvLeJlnFh6KzpgMCU8MopTclBKvQ4ZT0GBPx37caegtLXeQvj8dh2sDqTzW4p0gD/tD
         JGkXGh0DMUQ/sDXUZUx7Yv+svNFgeLjtqtau3eeCzJYJalA01TcAyvwRQAHoL4l9di7a
         PvTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785511305; x=1786116105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p9+LRn/SvSrh7d6/E5JqQArA7jl7jdT+NZc32lFMXxY=;
        b=MQeqDpEHId0AWi0fgHZhE1c71pI0bvQX5eTFev+whg/QuqGJdhQX8ac8o/w2I91UTm
         MGkSTswyKgaeoFfVRoSOLX/4EAbb2u0vq/rqvhvbSOzlU1u7hGsyJN8oeQHcIDYxQ/Su
         61hScehPZXmT9xHG0S5L/LePjdMg2ogk3DTyPKzbhI/j+5ZC+tztzfFqdL4Cgbyiu+U7
         MF6soGGw+PeXaMxAji8TpP5tZmiWTMTqT7qc3G33uGv0xX3Bu2LX2V4X1ZJNUvlHUDyl
         vwv9CxogyV2tqUquBhiBZPY0E3Btq+QcLYoeYUFc/kAJC/KKmSNxgq3lCERZw6qAEbD8
         mAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511305; x=1786116105;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p9+LRn/SvSrh7d6/E5JqQArA7jl7jdT+NZc32lFMXxY=;
        b=e7l/hd+bJLBD1f7ImEkaffE4aSC9E/Nzy8fxRCAh9ilkL5E9a0XXdfHbfKhJMh0Ngm
         4q/3NyQdNb2aNmwq4JTegQU+pWxTPrNv92pW+uXZzhrbqhmLqYLDHudx6foKzZT6EV/Y
         CPSdIJdhbVzU9Sdcd6qCtexG3YIt9Zb7A1xcZnZTVS7saN24DDmaoNfwbeENAYcH2PVC
         EZGSyYv4qc06BGNjHcg4qNUHgRkOMuNNQ6ezJNieqLGzhzeC7TAvob1X8dMIwNnSUa2v
         El8h8vXBDi0BKejUUScEvakn3iTVSra1ELqoNDXexwMEtf39/Iquq3vLXY5Mm2PqnC5T
         dYuA==
X-Gm-Message-State: AOJu0YzKGIJTUGBufbdPYCPNORd7Y58G98JHnAgLz2peMS6KYCqxOHIM
	WuNuWpxdPTB6bVncyB8IYFaoJJXZDtwrqW9+NBDYDKU6RSScJawb9ukRHGW07cgO84FLP6zUIT7
	gxhDrHXDw7iwPZxUGxo3GiAx3a2Sz7wcIGxyTeT8=
X-Gm-Gg: AR+sD10Hz42t32AiZcAwIpXTQy1gHTSAOxw25EzHhv7scA1qKewOVY7QjagURJ/cE9t
	J0GSVHetZx5LU7xUv1SIwAZ6n1+VzPir6jCKIbZXR9VpNMSwpJGjh5gT+Pn9tkD67cjMl1IcpnQ
	36ZkxsqNDx8Qle+Sl7kl2+Sia7as/YcxEFB1XLW2j++32TIjuVn6tDysCl95xR8GMnTtrs1NeFe
	56h5LnGeKXiXI1MtJZQPcjdFhFPSBeHPfnDwPNhOyFUAX7lX4GQfDea8EJmA3IDz0jouZeZxHAu
	6huvJDrS44pVnampiUUVo+u4/NUMU2ytxcxZVkK7An2CC665fcdXbJVA3AYDQoBS/gxuayQR68m
	lsubNMowMaKXg1YtLh+h9crpqBg==
X-Received: by 2002:a05:6a00:418d:b0:848:2f77:e2dc with SMTP id
 d2e1a72fcca58-84ee49aa19bmr73028b3a.69.1785511304566; Fri, 31 Jul 2026
 08:21:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725132624.78373-1-leon.hwang@linux.dev> <CAEf4BzaoQaODE4F1wfrp37=83bePY=gKpunacKr3rmO230+B3Q@mail.gmail.com>
 <66eaf62b-202b-45b9-8934-fbbc80caa84a@linux.dev>
In-Reply-To: <66eaf62b-202b-45b9-8934-fbbc80caa84a@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 31 Jul 2026 08:21:32 -0700
X-Gm-Features: AUfX_mwX1Lnn-oFVg3jgqe6P4ofXoWURmDZdlHg78-NJyoQdPMHudZHx9cqdijU
Message-ID: <CAEf4BzbjmW0e6DqFLUAyV+m_usHSkHpux3AdS72bJtsmYQC_LA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix sleepable check for tracing prog
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Sechang Lim <rhkrqnwk98@gmail.com>, 
	Varun R Mallya <varunrmallya@gmail.com>, Viktor Malik <vmalik@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 10:20=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> On 31/7/26 08:07, Andrii Nakryiko wrote:
> > On Sat, Jul 25, 2026 at 6:27=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> When CONFIG_FUNCTION_ERROR_INJECTION is disabled, a sleepable tracing =
prog
> >> is allowed to attach to '__x64_'-alike prefix symbols.
> >>
> >> It is because the verifier does not verify whether the symbol is a ker=
nel
> >> function or a bpf prog. That said, a sleepable tracing prog is allowed=
 to
> >> attach to a bpf prog target whose name has '__x64_'-alike prefix.
> >>
> >> For example, a sleepable fentry prog attaches to a '__x64_sys_nop' XDP
> >
> > we do have addr, so we should be able to distinguish between attaching
> > to kernel function vs BPF program, no?
>
>
> Yes, we can distinguish a bpf prog from a kernel function by addr.
>
> I'd prefer passing 'tgt_prog' to btf_id_allow_sleepable() as a simple
> change.
>

I don't think there is a need for new tgt_prog argument, we can just
check that supplied btf is not kernel/module BTF (see btf_is_kernel())

> >
> >> prog, and copies buffer from a user pointer with bpf_copy_from_user()
> >> helper. After attaching the XDP prog to lo interface, the kernel BUG
> >> could be triggered by 'ping -c 1 -W 1 127.0.0.1':
> >>
> >> [    3.460756] BUG: sleeping function called from invalid context at k=
ernel/bpf/trampoline.c:1324
> >>
> >> Fix it by disallowing sleepable tracing prog always when its target is
> >> bpf prog.
> >
> > what happens when we freplace sleepable BPF program/subprogram with
> > another sleepable BPF subprogram? And same question for sleepable
> > fentry/fexit program attaching to sleepable BPF program? Is it
> > something that just cannot work or we can actually allow that?
>
>
> Currently, sleepable freplace/fentry/fexit progs are already disallowed
> from attaching to bpf prog, because btf_id_allow_sleepable() returns
> -EINVAL for them (except for this BUG).
>
> Since no one has proposed relaxing the restriction, I'd like to keep it
> as-is when fixing this BUG.
>
> I'm not sure whether allowing it would introduce any issue.
>
> Thanks,
> Leon
>
> > [...]
>
>
