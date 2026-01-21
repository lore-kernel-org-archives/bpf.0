Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A9369998
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011808; cv=pass; b=JLw26Vm/FpwNnKMq6CaA3nwGYo54DvPYR7DMXjKkoMnTC03HNTXE1Gc+sgAPMJpM36qGED9THANHZtItmXqwQVmS5nfve54RL7uLZ5pFQgFFTKQXSp4zyEsncLcZNPsoqzRhBGwbT5kOHYlKtAvfnsnh00OlcXzokeenCq1x77w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011808; c=relaxed/simple;
	bh=VY1mTw1PXPJj5Je7mrqoxRLfIjR9Didj9ubHogx9koQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4NUnkXq5jpOtelCwkOOGOULKVQgBW9trECl33Z0MXCOWcE/atYtg4IxqnVRodP4UxS9XEhAAzCmO7q5ZrbqsltiD3PerAD3B26SuRiRAKmFNEckFn3rnqQiPDF5ufVkKnW8qKxPQazuQSAJHgpsHaVHg8sfn5e1TWSCZt+U4uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxYPuubh; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxYPuubh"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4359a16a400so872649f8f.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 08:10:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769011804; cv=none;
        d=google.com; s=arc-20240605;
        b=lnaxGQBf/+Ly92Nn0sA3W8f0K7JGIlzS6ftSfkGRJwMGNSp6ZKHb4lByHuFCBRUoqW
         oQN5HN0W9X1ILNKTq75K2RRkiWu9Oh1hULoRydmywLPn7yDizlcYdNAcxUAm8LTAHyqH
         jIiaUFS7vqx2zo1qcAWwbIbl7LVn0bBE0VjJaMTeviTjJ931Ms6vkd7WGuW0g7SgfqzG
         BPOFJ+D7k7Fc45ZQtl16f3lWIZGQDZmbmYS1maThi2zeDz2rz3bCbrMHK3R2OQ2uugTB
         srCfuJ4qbM+qTA2jCofVNdM5o+zkP2Im+ljWXt321YAA4CoVbPujo9GTF4m95FXLnzJX
         eAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VY1mTw1PXPJj5Je7mrqoxRLfIjR9Didj9ubHogx9koQ=;
        fh=wefqnG8RlLbn8r1kzScQZ0vNuncaJm2PKsFBtMISc8I=;
        b=ea6/BFKUtN5SM08hqlRtm7ao5/ul0Ud9+sHkuNolFlXg739bHLmyASpDp3N7YcpVkq
         z5H6snUxSd0whwHWzAkFD1hDs2WZIdY7SAZNKSUwIMsZFLUMNAUeg3Y6tUhyFSAP/Uwn
         Iy/lLN7PF9EZ/D7hXzEYbfuSFZqRl+qiHA+OYahuUwskra5nL9SCo+0d5p6GGsU0hGKF
         9I3iEK2odtQ8wwX9YhfFTFgW5TK0bRsB5TDa4BCl1HAjlP03wqTHv+6RuP896qyxQO2q
         gVFH2h360/EbraUNNZWgK0f/ltbUljoX4mFZexpfI0PnaTjfY6KLCucIdwiZDa0IqyBf
         qQKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769011804; x=1769616604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VY1mTw1PXPJj5Je7mrqoxRLfIjR9Didj9ubHogx9koQ=;
        b=hxYPuubhhzcZPooc0ukEIaqhxA7w54heysW7ypkZlRItKE3wSP4nLNCYW6xuQjcpbb
         LnVQxWvSudTW72lBCdv0ue4ExeDoyceaBrqj9ex2jdqw8uvfOO6oxPakGoDUo1JYSkxO
         0o6eUXY4LirLGof2d4iNCgn7f0Jtl3ORkOzx2QP5x4qNDZ+vsT/HZqZ1cfFvRMIGTzsB
         63C++Arcs6sw3Dp9E3lIQSXLWVGE9HS6iQXi6FhbaT5aHxvv+P/r5EIGAXg1QfmS2U/f
         0/ckxZrYQw7e1q8n/YhdOQHggBHXqYIcr8Qdeo3mDxtN6SI9RsMyp/cd5ubyfewy2FOA
         10Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769011804; x=1769616604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VY1mTw1PXPJj5Je7mrqoxRLfIjR9Didj9ubHogx9koQ=;
        b=kMKRB9x7vRcfToeJlot92/prfjI7QepjA8ODWOtlSkob//XhCIn4yTI7AFOXxlOrW0
         ByUN/yfciSpZrCVLM3CCgYdRj8yBUUXLe99gTspnNsa+IaU0oqfUKPknzWdllTU65UEt
         /toW9hbyhx665tYLA+vMGDnWrkoQ2tyAoUyYXCf1XtJZkVzvNLauXw5BzLqptb2Pcnhm
         nPmkwGOcaJuhgfse9nyS5ejvexZcA4I6R4+yfQHEj8ph0WDPRpxqvfk3V6zoPhe+u4Ki
         Fg+Y9pCQZurJgcn/yU619gwR0lirk9+SqrKH8o7gPtZDf63mwFQuwgcrf1L9et0d2piZ
         AQtA==
X-Forwarded-Encrypted: i=1; AJvYcCW8200mA16VZcCYnUuYOif+t5OYk25QtBCruG36lIBdq4ryRf/ESj7+D1WEu+mdPTFeZz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSdcZCScsp1d6P9mUkmNBL3P0pw6id/1hsx5kJ3mCYMCXqi43A
	eg5vDch0HuoK/bqwjXn6qFVmKi4I9fKfhcM2+VhZ+KFCSv8OzI3IMYe7LEk+++pHMxRzpx00Q17
	3hoc3+BKzegu6uzUs7/hoG/Kd7KD9uTA=
X-Gm-Gg: AZuq6aLLguQ/v5gMP8C2sEvxY2msUmv3Bv0lo18/jkyKD0YRp5wwiSUjGfSeRTZyc37
	npAHrw9F4cJr8/iSRXj2jRrETs1c0WtZ6rHFZvY6AmqE3mbkrYUjyImO7cUVT0sZxBXPJjXR7Zd
	YCkU7zlvUmXxRdAODSyZO0w4tgdA7KSFFNT0wT4+ED/pDgxBrHkguDIC0sIPdbCCVhLS4ZQ8zZ+
	a6VAunU9Qt8zZEWFBfhbP82XbzXVb+C2ffxhTiQl10pT1T5rlHzzaTmOu/XmN+ES2ILZoiT/sT2
	jnN1/eoiCU53EXqlUCF/cv0gLYKtqXbTb7qL6dwU/2LPRiwkObUZAspiTY1Wohx/JRt8zA==
X-Received: by 2002:a05:6000:4301:b0:430:f5ed:83d3 with SMTP id
 ffacd0b85a97d-4358fed1464mr9805697f8f.5.1769011803897; Wed, 21 Jan 2026
 08:10:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120182034.3647092-1-gary@kernel.org> <b53ee085-d9d2-4365-a5bc-d61e2bce97f8@linux.dev>
 <DFTNNQLGB1CS.2HDOGB99S9ACP@garyguo.net> <ea83b91a-796c-4329-bcf5-2c49efa897fc@t-8ch.de>
 <5364d5ec-f30c-40d6-9a99-c251fec3868c@linux.dev> <DFTTLB4I89PR.26SQVXWNG9U7@garyguo.net>
 <1897b382-41b7-4d63-815d-ac63f38485ee@linux.dev> <CAADnVQKLtnfbaJCbbe=JY+85kBKfiUv9hjW+bumO_Y_YovuFow@mail.gmail.com>
 <c8eb9347-b23c-4ad5-9555-b2a55b788dce@linux.dev>
In-Reply-To: <c8eb9347-b23c-4ad5-9555-b2a55b788dce@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Jan 2026 08:09:52 -0800
X-Gm-Features: AZwV_Qg08VbEHE1D17Z2VhSaMcT7ntl8Abgl8oxwjHSpMcN69Mki4BJ8BcmtevQ
Message-ID: <CAADnVQ+dxmSNoJAGb6xV89ffUCKXe5CJXovXZt22nv5iYFV5mw@mail.gmail.com>
Subject: Re: [PATCH] scripts/gen-btf.sh: fix shebang for NixOS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 9:04=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
>
>
> On 1/20/26 8:52 PM, Alexei Starovoitov wrote:
> > On Tue, Jan 20, 2026 at 8:50=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >>
> >>
> >> On 1/20/26 3:54 PM, Gary Guo wrote:
> >>>> [...]
> >>>>
> >>>> So it's trivial to put $(CONFIG_SHELL) in front of it. But then it
> >>>> must be migrated to #!/bin/sh, right?
> >>>
> >>> Documentation/kbuild/makefiles.rst says:
> >>>
> >>> Make rules may invoke scripts to build the kernel. The rules shall
> >>> always provide the appropriate interpreter to execute the script. The=
y
> >>> shall not rely on the execute bits being set, and shall not invoke th=
e
> >>> script directly. For the convenience of manual script invocation, suc=
h
> >>> as invoking ./scripts/checkpatch.pl, it is recommended to set execute
> >>> bits on the scripts nonetheless.
> >>>
> >>> Kbuild provides variables $(CONFIG_SHELL), $(AWK), $(PERL),
> >>> and $(PYTHON3) to refer to interpreters for the respective
> >>> scripts.
> >>>
> >>> So I suppose it would need to migate to POSIX shell...
> >>
> >> That's my blunder then.
> >>
> >> I'll send a patch tomorrow to make gen-btf.sh runnable with /bin/sh
> >
> > Isn't the current patch enough?
> > -#!/bin/bash
> > +#!/usr/bin/env bash
> >
> > I don't think all kernel build scripts are pure 'sh'.
>
> Well, if we want to follow the makefiles.rst (and Thomas')
> recommendation, which is executing the script via $(CONFIG_SHELL),
> then we have to migrate to #!/bin/sh, because that's the default.
>
> This concerns only scripts in the kernel build pipeline AFAIU.
>
> But you may be right that this is not a strict rule, idk.
> It did come up quite late on the list.

git grep CONFIG_SHELL|wc -l
68

ok, let's convert to pure sh then.
