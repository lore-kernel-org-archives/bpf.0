Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048063A2544
	for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782650211; cv=pass; b=jSqGk6r0UsWmGYHBZxui0wuXQFpXwZ5Arh0yIbzNFChjHeppfTMHxOg7+ubu/ltX+0/+XmJIWDlG1lZX6Z8cJRhyiKmWbjeZ3qy63p5FFYmPbeNCyTGg2dEzW+Gwj3xoMr/G/2nUSG7RIZ7VLLs2/LMm3YgYV0iQGJ/m79ZO1so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782650211; c=relaxed/simple;
	bh=QT3KyRx/yYFX7YJbB0Phy/hJFhtSz/3fbeRsVp3f/3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IB21T1yIT4LEoLNG9ycsQDrVgKI98XcBuZ6y7aNEhgP8hQ01TXuaDbLSMvnr5Ab7kE5j1btmMGwxzYPQH1ZIzG7WS4BJhYpDsbGLDliiLr0f+5Vo7wo40hd3Mc/4UD8g59KHvuQFpsE0LVnCwuUgVbHZ/HSRjNoYpfIP2irLEpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=WW5NNTVS; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="WW5NNTVS"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6611669cd16so2569928d50.0
        for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 05:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782650208; cv=none;
        d=google.com; s=arc-20260327;
        b=cAKSjy0N6G9uYoXZ53uwvjq+HP3AvJtg6WaauZTtHHE0gVZqnv7h9qnjs5J81BexIF
         lTGoHPLbiAVWbyE67gPqHVwYWDTjckTYddYl1tRlmLcEwWcmjmh+iL7xpQAADIsmuOU2
         Xr9Fbjz0cQs3BgMZMya9pBrj2AMp2WJRpCDC33g/OydsZZwkuf/arSBpVnjzEZfppiLi
         87htjqMYja7FmQzKjaC0XheuYiyuxpBYCq27HHscQ+bIcrWrXk4fC1k4RhAeea6PYpC8
         57ZWusQ/2SFF7w+wJU3OPidiOR5X5bnPoZ4PYvTWIrvggjYQEhMCpwSJ7wHejp6isEi6
         xnRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vzP5f4zYs9UEe0wmc6361FiYfWw38ZSqAfPCOvm2SFQ=;
        fh=aqMxS9E53NE+iUAgfcQEIspTRHEdhwwI6iEOaoTTfuA=;
        b=BSEbsFQtREMBMIThOci3NkP/hdBwhi9kPLuR9+MJO6xcNALFwRUQ39SFOpxK8/FQ0Q
         nJLxUGgoNfuIeyf9v0UtaH5kxH0BzyRVnLATX/m74wKCItJkWr8+RUEEix1yAZ9v5zdA
         EP7k64YBf2b6Z9/NKAa1N//Mwc8ouEP9iGjeMQVWDWPCNC49BjlQNtDDPyOVMygAMuYX
         X1SSQ22YzWBx97KFv8M6Qm8FkRxbQDE192s8G4+a1835iYnxXbitR9zEt6+r4jN/T12J
         Qc2PCb7cNvyZkNickUro5wpCHE0FXxlv3QDnqVilZdYEmQJtQeGL4LKWjSdHUyzeQklk
         +aPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782650208; x=1783255008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzP5f4zYs9UEe0wmc6361FiYfWw38ZSqAfPCOvm2SFQ=;
        b=WW5NNTVSch88pbEt7NnwwVgbRhQ/NVC1fq1rBHfIo261G8o2i2hzm6kaHp8lZUoOok
         KR7K46YUX3n4t+ch0acBDbNJ7BrdKS4wuHDbnMOsa3LbgddwXJWVi3fvE0nG0bwTPUVi
         5qVUswUKN/5YBJCvQcrI/A93ti06HC8dxgSos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782650208; x=1783255008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vzP5f4zYs9UEe0wmc6361FiYfWw38ZSqAfPCOvm2SFQ=;
        b=pISTwtAG7uL+YpplS+eiN4f6PAUnAGk8ROSgfn4U/ZSQXd/1pXO/Fj4lERjfc+4Apl
         N+4r+xCUkcXThRcHtMJFsF0Rf7sR332BxYnEEfQbqqDktb/i+C/M0Q8AhCsgFKwr2x8x
         4o/uvfR8YeQe+mV9tbj9I+r00ekzv8mgKXsPN2j2iZuUl06bMIoPAQ0ugwdUTQBzS9BI
         Vm/avvNbjsJdegStKJUR2xnDBW4Akax9w0jw1likYkzFDwKSi6mJbkisxpgi3N4+exZO
         WRwpS0IRO5I4CBFpj1d074y7mQJ3lbGbc3X8t/qeawvpAelD9TWHZUWGG2RkpzWDCERi
         cPcQ==
X-Gm-Message-State: AOJu0YykWTeXxHt6CZ709RyITtW3dNWN3vUoNrUeDNA7pyXZS7RxzOU+
	63ikxxbHELij/cIsiawuvIaHhDGpWK8iy32rIE4amEkxNnMVZZy+hKvMj1uDX9bi9msMvg9CO+X
	CZtrOpLLsT20ZHIuz/D0D3sOViYAfWrGgHSmygtTc
X-Gm-Gg: AfdE7cneKFsxSqpyZ2w5sZ8OucB7HtIVQ4xfbqALons9ZSF5btGcNao6OGuz0uxbTgw
	LVQmS3THBKikXG6I/AV3Nef/gXM07r5/mGNZ2MC2fx9SXQiScx/GxO+QPGpX8arQh0MzFrB2yYq
	bych9uzSYCDrioCd6We/IFikZSGlgHbpDIjmpN4hlZqWMfIbG1nH5bNB51VInkqiElL1OrQ0tlJ
	fFk9lO9uJGHpEjXe3wCL2CopLFtOom33n3FWVGK1S7J74HasEKuWHwIIrnagLiVigEPi0BqiVA5
	4uihJ5Hn
X-Received: by 2002:a05:690e:4508:10b0:660:5e32:b2a2 with SMTP id
 956f58d0204a3-66487e08811mr8856149d50.49.1782650207987; Sun, 28 Jun 2026
 05:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626165156.169012-1-jhs@mojatatu.com> <20260626165156.169012-4-jhs@mojatatu.com>
 <20260627165220.CA0CD1F000E9@smtp.kernel.org>
In-Reply-To: <20260627165220.CA0CD1F000E9@smtp.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 28 Jun 2026 08:36:36 -0400
X-Gm-Features: AVVi8CcMk-OTbWtGzb65ms48PIO_Ru3oLcwHNHpBqSVb0aZgtGM3z9o_xVpkdK0
Message-ID: <CAM0EoM=Sm82LdxrX-tckyxyGbNOawQ0DAXnEPowgyYVZbx=vqw@mail.gmail.com>
Subject: Re: [PATCH net 3/3] selftests/tc-testing: Verify bpf redirect on RED
 block with preceding clsact (egress) classifier
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 12:52=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Hardcoded BPF object path 'action-ebpf' instead of using '$EBP=
FDIR/action-ebpf'.
> --
>
> commit f4ff308069725bd7a3b6c6f843ecb0fda5b73239
> Author: Victor Nogueira <victor@mojatatu.com>
>
> selftests/tc-testing: Verify bpf redirect on RED block with preceding cls=
act (egress) classifier
>
> This commit adds a test case to reproduce a NULL pointer dereference when=
 a
> bpf filter attached to a RED block (which uses shared blocks) returns
> TC_ACT_REDIRECT while a preceding clsact egress classifier is present. Th=
e
> issue stems from a stack-allocated bpf_net_context being torn down before
> tcf_qevent_handle() calls skb_do_redirect().
>
> > diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.j=
son b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> > index a1f97a4b606e8..762f86ceab1cd 100644
> > --- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> > +++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> [ ... ]
> > @@ -1540,5 +1540,37 @@
> [ ... ]
> > +    {
> > +        "id": "fb8d",
> > +        "name": "Verify bpf redirect on RED block with preceding clsac=
t (egress) classifier",
> > +        "category": [
> > +            "qdisc",
> > +            "red",
> > +            "qevent",
> > +            "clsact"
> > +        ],
> > +        "plugins": {
> > +            "requires": "nsPlugin"
> > +        },
> > +        "setup": [
> > +            "$IP addr add 10.10.10.1/24 dev $DUMMY",
> > +            "$IP neigh add 10.10.10.2 lladdr 02:00:00:00:00:01 dev $DU=
MMY nud permanent",
> > +            "$TC qdisc add dev $DUMMY handle 1: root tbf rate 1Mbit bu=
rst 10K limit 1M",
> > +            "$TC qdisc add dev $DUMMY parent 1:1 handle 11: red limit =
1M avpkt 1400 probability 1 burst 38 harddrop min 30000 max 30001 qevent ea=
rly_drop block 10",
> > +            "$TC qdisc add dev $DUMMY clsact",
> > +            "$TC filter add dev $DUMMY egress protocol ip prio 1 match=
all action gact pass",
> > +            "$TC filter add block 10 protocol ip prio 1 matchall actio=
n bpf obj action-ebpf sec action-redirect"
>
> [Severity: Medium]
> In the setup block for "Verify bpf redirect on RED block with preceding c=
lsact
> (egress) classifier", will this test fail with a file-not-found error whe=
n
> the tdc.py runner is executed in an out-of-tree build environment or with=
 a
> customized $EBPFDIR?
>
> Should this path be updated to use $EBPFDIR/action-ebpf instead of the
> hardcoded action-ebpf so it aligns with other tests in the suite and find=
s
> the BPF object correctly?

The $EBPFDIR issue seems to be legit. Victor?

cheers,
jamal

> > +        ],
> > +        "cmdUnderTest": "bash -c 'data=3D$(head -c 1400 /dev/zero | tr=
 \"\\0\" \"x\"); exec 3>/dev/udp/10.10.10.2/12345; for i in $(seq 1 8000); =
do printf \"%s\" \"$data\" >&3; done; exit 0'",
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626165156.16=
9012-1-jhs@mojatatu.com?part=3D3
