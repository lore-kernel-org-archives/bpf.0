Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976344;
	b=naESM0V3eRfG2sAPp583aYNTUlzYzou3XjUN8wficBbIMOvD2hNSB2v5HN1HZcRZ9h6c
	 27aMQEE6bNG6Qm2wmaNG14oEpXRUWhQZN/up9nAA9N/B3KnMSYAaHLmvdcH4UKIFORrzy
	 ru2CV8PGRa4YXATOUExtjDsGZUs3qJ1nPGDoVnYkYhku3bCpadOEVj4P3PGOVtpE8UYFO
	 vUAXSNvcKabmmjWuyIOgx2DWCaFDX29JqM4xLFcJTlQ5n8iTZml5REfDm8h3edKqVAOJ6
	 EWDN8g7vU4PH6ewQPgIHfWEc6pxNqzFv+Gsd2ixZkp2kgzIAK7RN4WKzAmgQ0sMdoPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976344;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=D8oZmxNlOKsm/Rp//d88vLIxrb2bjb3rSm4pQQTcZQA=;
	b=w5S0ON/SP7vsbOYk06yCsJqyksv3jE5ebLjKn6JjtkJc97HevJgMs54nl/3M1fJnw4ge
	 jSsoaR3DfCLX6pdfT2C3sqxkSeXTxSrPCvtltyBI/AsX9kqvlsc7FYYr75AH0e0G2lCz5
	 Von15MWrIaGRDw5cYy0Mn0Ked/UMPGg7jjt8Os6vSm7H26QtyStfxQjpWAP+2C+04MP3w
	 lU8gd1RoJqqdrBUX3WgNrI/9IkPM2mDsSQPS/FATiT2HDT7110BUaGEhfuPgofEuhrI6a
	 WnoE9QFccJm9CAV6Aye7utEgeHAZc4bcXqOcopXyum6n4jQFrJLvLQEY8134nZXdNuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O694iKXS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE97606A32C
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O694iKXS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C821F00902
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 14:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976344;
	bh=D8oZmxNlOKsm/Rp//d88vLIxrb2bjb3rSm4pQQTcZQA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=O694iKXSJRyqv5P7AKWdMgVg7eGV5VUqteLay04fKbnkp91vwNvnX16VRNjlaStw3
	 cYtFjfmZ90GRSfquVrpsyY1tr+Yv6Evr1KB2h1m6vRaKpmtfUSrJPyVWym4MxdqrWL
	 8q2sl2nGqfQDnO8FMEngOW/krdseih27x3q7S/qgWv8Ts7HxFQ48RXc6IT0arBV2og
	 FIzuqpHAOh/vi6Sf5lVzXlbRa/p1DdM6szpZxDSM5h8QToI/Im8Uo8TFS39fHaVYaF
	 O1FnA3169YX/JYR2T8P8EwJa677u0bM37kegN4iE9hwZmiNx/qntsGTAAh/IxUkJKE
	 /YjKJ14GC5Tuw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b596569640so1074743a12.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 06:45:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFrdsxk7t+PZNkG1XsdW4itIi1tgT6CZmQHRxGoCycBxTbguoPCDYHFhrC1AhOSt76GbDs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+MKbpiB0EyyPUQQ1J5bznZQH9ePG7+ofTj9fRPHXtr0ccRpf3
	kIqyZL3wmZUnQIlQgyI+c0BrXvGTC4fsmsi74RqvP6Y+/vKaWpfckdVz7BL09SgieU7YSCEFaTq
	9ANcYv0VdNq8kYOtoWznDEUyQFLDNvzU=
X-Received: by 2002:a05:6402:3207:b0:6b6:e808:96f7 with SMTP id
 4fb4d7f45d1cf-6b6e80899eemr1325905a12.3.1793976342883; Fri, 06 Nov 2026
 06:45:42 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102072808.23080-3-yangtiezhu@loongson.cn>
 <c3b8e6ae47164ab1a643a1730f0600993de03c8a30e35122a9812ac73d807697@mail.kernel.org>
 <1276eb14-b851-aee7-36ad-d61e2ddd9ba4@loongson.cn>
In-Reply-To: <1276eb14-b851-aee7-36ad-d61e2ddd9ba4@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 6 Nov 2026 22:45:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4GyC5=PvF5yvYnoBpUpU3VTuE8kdNUnApNqvN4vHZfhg@mail.gmail.com>
X-Gm-Features: AclHuK_E27SlHuF9Up4hvhe95PGG3OxpyR3ULOjCKnQ_VAfUevX4tHqFUb9HhkY
Message-ID: <CAAhV-H4GyC5=PvF5yvYnoBpUpU3VTuE8kdNUnApNqvN4vHZfhg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] LoongArch: BPF: Use beqz and bnez instructions for trampoline
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: bot+bpf-ci@kernel.org, hengqi.chen@gmail.com, loongarch@lists.linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 10:27=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 2026/11/2 =E4=B8=8B=E5=8D=883:53, bot+bpf-ci@kernel.org wrote:
> >> LoongArch: BPF: Use beqz and bnez instructions for trampoline
> >
> > TL;DR: Commit message only: the claimed branch-overflow risk looks impo=
ssible,
> > since trampolines fit in one page and the old code behaved identically,=
 so the
> > Fixes: and Cc: stable tags may not be justified.
>
> ...
>
> > Could the changelog drop the overflow-risk wording, or describe the cha=
nge
> > as a cleanup, and could the Fixes: and Cc: stable tags be reconsidered =
given
> > that stable-kernel-rules requires a fix for a real bug?
>
> Will update the commit message and remove the 'Fixes' and 'Cc: stable'
> tags. If no more comments, I will send out v2 next week.
Fixes can be removed but I suggest keep Cc: stable, the overflow risk
actually exists.

Huacai

>
> Thanks,
> Tiezhu
>
