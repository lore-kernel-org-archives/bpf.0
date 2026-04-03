Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD433612E2
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232060; cv=pass; b=NFWRWMDLETPYnKHhFTUzPKQjHwPxJCps5cJXerrLtesR05T6RcFlX5HuRFzbhX2TZOPP1nEHs7c7CBAvmkL9krkPzIz1QEkXwCxKhomxtGcF/R0K++KsK1y+NM337YDp0oH5zHuJDxxIyMInC/BG35t+0mD7NNEIlUeZLx67vLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232060; c=relaxed/simple;
	bh=4J8XcLhyQNpn4ct//tlB3JgTqU1q9N+kL/BF7kTxfb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mn0mfb3LiYbCIqrk8TpLfjLCf0dWNcHA+NeSwZWYluQanPHDNVO8nSF5Xp+daC60r7JFpDJe08F7a/1aF6GJPI1N0g6nSZG+F3mA4PDw5j3Ff4GiN/RoheL+Y1cbAMP96dgTgVvy/rsST+19DwkP+VnNc0xvGNfmEXYh5tTcT4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8LAka2/; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8LAka2/"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6500040f172so903425d50.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 09:00:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775232058; cv=none;
        d=google.com; s=arc-20240605;
        b=XAw5Akux53Fw7J7/j5wJsczeuxomWxAfQUeSQtHmPwXkXPhIZ9J77NHkypQY40YHX3
         jKLa30FBLALQrmY5+qi2fcFGwC4zmZQWHUHoiDYkDC5JkEwc7KE770rhuWdhunhwDfmh
         /irxWSoVuzNqx0G8ZIDvzF8OXGYaiA+NH+jgF286Iv7bw1blGdPmaYDAa7JqeUVaGYJq
         DSDrXsSkjgzkCsS/Q2GEBgm4t3ie3m90MvTJa0n+apWbNyz88lD+Z4FmgbIOpVwW3MOL
         jkZ0Ok5ab1VxELK1smm7W447LsNRTb8Zg6R9BF8h0OKGdHWY69ahh4bsEpOzweVFpuCe
         bQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=smlalJP6W4oXJb7plM4HOYk8mDYdhNOc9XE7DYiHv4c=;
        fh=g6CoGRsLXXvaG86m2xAklee76kIuQTbbmRY62ZGV9F4=;
        b=ZlomNudUyKq2uLyxMQbgY246Yz5LRH+PCJXUbq2E27kcA2gNeRtEwZHk8P1lDuiS92
         nPfEYeNNe+ta1/J95mC5iJht6S+gMvnWBu83EqhFl4r8Oe2Uqk7suIDRzSbc4stB4WV5
         Smobay0jL2euVVfSFz1KJ7qfSrG3wXRlBjfAdi54poFw/3sb8px3BnRC8ZQ6rRPDcv/l
         7sZoGzzSE3rmEOzRHl1vr0azrCLZuzZl7OImuYHq3Dtm+fB6xUuckAjvymJ1DQbScoVd
         LnqFievd+kIU2WrX3qfLccpccfMClthqy7QXz6Sx0fljZ9cD6zJRuUJaq9e7McT7/AaV
         zozg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775232058; x=1775836858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smlalJP6W4oXJb7plM4HOYk8mDYdhNOc9XE7DYiHv4c=;
        b=V8LAka2/M4WKX4H5NMhGWkmhQE6LOYGEOh9Gq0xnMbSyuWQF6qlStIjyusCaeoiTTv
         op0Nq3gX8lF84pDhcadeoVyD144qK1Qg6x51PS6sCuZiBLzSX+T9sX1q1auAZJBi2Xrf
         5RGi21ScBw7M+oIa2Js6AwO5BAbSjXq6Bo7OZdtY8T0vXCFLleLYPFbiLHKk2M2f32Ko
         yGdI7BUSvmJyyzSjHnk3HCzWINkhLEib16h2bYp8EprTXgwFDrQmbKNkQ6vILhjWicdE
         523Ts0upvyVZftAXjHaeKhGUZpc3EwQymdNNjZbH3dKFGwb7MpY+mYlhqY/NKMO7l3+7
         IJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775232058; x=1775836858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=smlalJP6W4oXJb7plM4HOYk8mDYdhNOc9XE7DYiHv4c=;
        b=VBfqv+dxQPWTIQMD/lRjyHMIL9dS6+2XcQ6u+iiQsWfoNFN5Rpj5Eu9gZv12c6Js2D
         4LQoDAIr5wOYahtzabdYAPAD1tdBLU0LkG+Za01vpcR91lUUmNurU2c2Z9Bvlm6wxrnv
         hmA4LLHdcUNtwKAIUc3B16omz7Qb8k5RquS954TwZVRU7Tpy8qYCQ7nJzL1ZidmFIXu+
         Pb4Coh40uM6sigHiT5Dd2bSiyMSPSOWWkmvy9xTGDM8Rvg8K6pNJqz9TJjH+iyL3jQ3V
         5sMDXHdzQRP1oFwXHwt9K9eLen9z6i+36x3Msq/wsWrQrwUfEbkgiAohwjMYEObqCZwI
         7oLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfCie7zzB/vdwyNWui0iOhprzCsB/S9Qy5W4HLVomFyK5zhORyvUlVlWKBMwvUqj6kfKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylogqi4E8ifdHyfUYaZN14TqzP53jH97U2zvIidYoJ68Ur9fL2
	648o+6SJeaYznApw7n2XDQpec7Di2Y4IOqEAxr1iqVYRDClm8FEHGy6P7ZDopsvTmjqhZiLM1Zn
	zcRd2NJdSOHvU0C6ZwD451iLHrmtBfTc=
X-Gm-Gg: AeBDievuMsQG2qTk6hHfKklD+W7dhagr3D1O+kZ281dm/mxU0bI+NXX0R4Eg1dY9W2G
	yIvW3LDhSwgDjQP/a6LWOmhS50eSwIG23zzX0/WEWcXs6Mz7Mg/mtO2RzldLue6+C9VePiVg4N5
	y8JEOWUXG95j1FmKWRM0NxhUXd4xev+vnrTP6j7MLTy/I6nuBysfDSvS3FHG/GPzd4SMnA46P1R
	T97vaGRbJBsTvSBusxoZF5XZJRq2EYOzIqpmk4e9UgUrBI2cvVZXfmAFW4MuVLsQASjfNmlevFE
	LRUKtsgrtibyTXICKpgUFlcFs7sckS7EV49nph8=
X-Received: by 2002:a53:df06:0:b0:650:b0d:f4bd with SMTP id
 956f58d0204a3-6504874d4e6mr2666334d50.24.1775232056866; Fri, 03 Apr 2026
 09:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <2261072.irdbgypaU6@7950hx>
 <CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy5hy9Yqgeo4C0iA@mail.gmail.com>
 <3036842.e9J7NaK4W3@7940hx> <20260403073055.031275d9@gandalf.local.home>
 <CALOAHbBBf_vWcwZp9kdXhpFOq_oG87X-7Nj2yurZ6LgBpDHwwQ@mail.gmail.com> <CAADnVQJobMwH8Q0LtCrwbD2TkzFaLfRaw9gyVnhDpMWGmLFVvg@mail.gmail.com>
In-Reply-To: <CAADnVQJobMwH8Q0LtCrwbD2TkzFaLfRaw9gyVnhDpMWGmLFVvg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 4 Apr 2026 00:00:20 +0800
X-Gm-Features: AQROBzAveI_l2DNpt7U84Ib2Mv4Qw04LElhCVGE816Jd6EhbLPSjW1ZrRCTxVQU
Message-ID: <CALOAHbAiNQaVYO3WeNvUBzw+4zAM-ZjgxYWKX5e_0Fw+KX-ZPA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] trace: Allow kprobes to override livepatched functions
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Menglong Dong <menglong.dong@linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	live-patching@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 10:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 3, 2026 at 6:31=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > >
> > > If this were to go in, I say it would require both a kernel config, w=
ith
> > > a big warning about this being a security hole, and a kernel command =
line
> > > option to enable it, so that people don't accidentally have it enable=
d in
> > > their config.
> > >
> > > The command line should be something like:
> > >
> > >   allow_bpf_to_rootkit_functions
> >
> > The feature is currently gated by CONFIG_KPROBE_OVERRIDE_KLP_FUNC. In
> > the next revision, I will rename this to
> > CONFIG_ALLOW_BPF_TO_ROOTKIT_FUNCS and introduce a corresponding kernel
> > command-line parameter, allow_bpf_to_rootkit_functions, to control
> > it.
>
> No. Even with extra config this is not ok.

I will send patch #3 and #4 as a standalone patchset to upstream the
hybrid livepatch first and then figure out how to move
allow_bpf_to_rootkit_functions forward.

--
Regards
Yafang
