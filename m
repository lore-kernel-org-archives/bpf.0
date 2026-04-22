Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F5534B661
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776845920; cv=none; b=Y3R+Pjk03pdW3G/YZ6GdAIzNcPJFWTq6hgnl614H/M83lnIv2PSs66c0Qeo0dPy1sBn2dgM1VnaiwhG5oWw8VYURuSd44ls2DAPEdPUT1iqNpP6nDfVlYrpKQKMajeLqZr0hZ4edUGUXV4GKtKMTyzaU9D0hdVbNVs/DGcp9KM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776845920; c=relaxed/simple;
	bh=HcddeAEWuEGHuyRr3B6WH5YQSjCvNKPOS6zyBreHeFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxT17KT55J1APMqMpR5+8uyShQVqoLWGiEqVTG0YWK+/v5pLDTvJDNtoOdxuzvhqoaO6+Db3g9Xq2Cs7B+LBZS677szihng/DbFe8QJEAlTu5jv9FNHuxIi9cXyQ4zSvWDhyTFckkXpWkjoM+zWz1rKccXWJA1icMm5r7KV0fqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfrP98zC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfrP98zC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004D5C19425
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 08:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776845920;
	bh=HcddeAEWuEGHuyRr3B6WH5YQSjCvNKPOS6zyBreHeFY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UfrP98zCK+WCMe04KmtRPg2prXV6jp/P7d5rUhOupLI/pgF76UgwMW86YnfwmYB9X
	 YbqeEz+jRTO8+dKbXP0y6iaa/FBX8AeLW8B/W0gI79vvZXe/HPuprIJLDCHK5I9n0Q
	 rfQ4Qrn76MlBk3P+b96QxdfqP+4b2B86xdND48ckxxCZaaSzEg2/r6J4FZWsSGCNi8
	 hHw96f/Bcz7ehduC1JVf0oW4urn7ONdywpaHTwhtxH8MQ3K5AbethFZvgzZAuP6kHp
	 0hsi8HPRrH6NCYRUU1cSidBE8m9f6wz1P5IQ9nla8xdpVhsE0Cu0GFmV94ZVp/qd1X
	 iLZtx47KEDFVA==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-671ab90fc1fso10292756a12.0
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 01:18:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/97dsImGdzF3HtCTebfAzggwVwuX3Qhl08s+5B4bU2BAXSySnX9ai7MG50mbYor5ecMFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgT28zMgOhG4tJ7oePIg4jO1LwBoHpZepcDoCfNn6ORHHmTjpN
	DQXt0MEXehlWdX2dOkH5nhsbeGmq1tN7zT/ZzVP5dGxsSO35mo6Kw6fMuS4k5xRiChcQL/k2vax
	4ld+sYkzapv2TiPBASWCI8phxnNCRVUU=
X-Received: by 2002:a17:907:96a1:b0:ba9:2137:7165 with SMTP id
 a640c23a62f3a-ba92146ccc2mr443462866b.1.1776845918458; Wed, 22 Apr 2026
 01:18:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226065952.4082859-1-hengqi.chen@gmail.com>
In-Reply-To: <20260226065952.4082859-1-hengqi.chen@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 22 Apr 2026 16:18:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7cUtAmmrMeDBCiUcwth7FtN6e9yGC8sC3DBMpYf60zGA@mail.gmail.com>
X-Gm-Features: AQROBzDN4WV-807C-KohUvohrH9WVcGaEsF-NaIkgakMTxmlsWOFKthsQuK3iJg
Message-ID: <CAAhV-H7cUtAmmrMeDBCiUcwth7FtN6e9yGC8sC3DBMpYf60zGA@mail.gmail.com>
Subject: Re: [PATCH 0/3] bpf: fsession support for LoongArch
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, yangtiezhu@loongson.cn, vincent.mc.li@gmail.com, 
	menglong8.dong@gmail.com, loongarch@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hengqi,

On Thu, Feb 26, 2026 at 3:00=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> This small set implements fsession support for LoongArch.
>
> Patch 1 introduces a helper named emit_store_stack_imm64().
> Patch 2 implements fsession support.
> Patch 3 enable fsession selftests on LoongArch.
I have applied Tiezhu's "LoongArch: BPF: Support more features for
trampoline" first, so please resend an updated version on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.g=
it/log/?h=3Dloongarch-next

Huacai
>
> Hengqi Chen (3):
>   LoongArch: BPF: Introduce emit_store_stack_imm64() helper
>   LoongArch: BPF: Add fsession support for trampolines
>   bpf/selftests: Enable fsession tests for LoongArch
>
>  arch/loongarch/net/bpf_jit.c                  | 100 ++++++++++++++----
>  .../selftests/bpf/progs/get_func_args_test.c  |   3 +-
>  .../selftests/bpf/progs/get_func_ip_test.c    |   3 +-
>  3 files changed, 83 insertions(+), 23 deletions(-)
>
> --
> 2.43.5
>
