Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767632DC76D
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 03:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773977262; cv=none; b=mUYRWaGM2i4y/obIPqleoGiDgFhZS0HttMmi1WkFFErNX9q266k3Qg0/444Rvqi0EDiFeBjYoRzXVo/O8p9xB19JUPLkb737o9J4Wx6AoFWDydf4778O6iGW5dNVvV8jG+wcdD1njN5ZUhblew+0WkPOoluLcEYDuT09EI1+PWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773977262; c=relaxed/simple;
	bh=qXz0Pgas60ZAPaaRyDGLcOVaC/mBvadZ7GzHjeKYWKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAwuuQE26vAG0Nn6mkLfvH4O/ku8u2WIQV2dlMcoczqFex6k2hwqOuhmA06nmA4h7WukbZigVNsdM++7u9BRt5ZvGCQnUHj/LYf3p630D+yAwI5zmWXIpmOHYf+QW0eZFgULXirklVfItqYk3mA5GXqMRwCPzLOu5SE9HcTWPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6Vr6nZs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6Vr6nZs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E8EC19425
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 03:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773977262;
	bh=qXz0Pgas60ZAPaaRyDGLcOVaC/mBvadZ7GzHjeKYWKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m6Vr6nZsRp1eUogdXgBW71G65aHLYPs7abrHqhk77GT+LU5gbD4HM8b0uTZzzbnUC
	 Cd46hG9ap/OacRpS7hxyX8z00NrorbXXiXjQ4qW4DgmqQtNsyZN7mX4ASxDs8U/PwM
	 Ylo8FRtna/AHfV4sZcK1XxaVb9H6xWRGn2qCvoa/UkTCI0CMNnZIOdj7qFatO7RYD9
	 AsZTKgj3aZtV8CjEHun++ubo8GDnKCI5Bkn1KOk3g/BYNYCQ+y1/Iwkcpdkq7JRF0z
	 2P8t+jKRHcvv9h+wv0IxZ6o/ekphFExL51G0Vhw8YhKG24WeWVfE7+KFiv3d/+4Hn6
	 eqaGvTkUJnDww==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b97e6e48b24so32329866b.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 20:27:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFmTRwq6dZ+EO//cWdUopDpPFUVDmAsNtKQSiZmmfUgzWjLO940XhoF3wOr5PWM1GKkgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO2BYDxfFuPpvwTz32sgWdiDwJecJVsLkzFbPwXPfkQSKtK5+1
	r2A90pZ+evDh7SOdeTw6FUaY8eZRJG5KsjJGssTVzkdGe8PdgEF/kvuRu4Y2VUOprIuAD/WnklW
	YUdDNIFyfIYNvlD04pqP8BQkWo9dvjbk=
X-Received: by 2002:a17:906:2554:b0:b98:1e:6642 with SMTP id
 a640c23a62f3a-b982f3e2c7cmr82421266b.45.1773977260691; Thu, 19 Mar 2026
 20:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310064706.4985-1-yangtiezhu@loongson.cn> <177395545307.1805592.472462208613814092.git-patchwork-notify@kernel.org>
In-Reply-To: <177395545307.1805592.472462208613814092.git-patchwork-notify@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 20 Mar 2026 11:27:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6m4959xs9tYw7MhZFtarvpAFk8xRub7D9W5eycJ+67hg@mail.gmail.com>
X-Gm-Features: AaiRm5391JWnSRNoPmaJO6MbrAe8WXd12FKAPPaVO21zvfiu8HcpMI2r9nwJAkQ
Message-ID: <CAAhV-H6m4959xs9tYw7MhZFtarvpAFk8xRub7D9W5eycJ+67hg@mail.gmail.com>
Subject: Re: [PATCH v1] LoongArch: BPF: Make arch_protect_bpf_trampoline()
 return 0
To: patchwork-bot+netdevbpf@kernel.org
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, hengqi.chen@gmail.com, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 5:24=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net.git (main)
> by Huacai Chen <chenhuacai@loongson.cn>:
Emmm, this patch has already been upstream...

Huacai

>
> On Tue, 10 Mar 2026 14:47:06 +0800 you wrote:
> > Occasionally, there exists "text_copy_cb: operation failed" when execut=
ing
> > bpf selftests, the reason is copy_to_kernel_nofault() failed and the ec=
ode
> > of estat register is 0x4 (PME: Page Modification Exception) due to the =
pte
> > is not writeable, the root cause is that there is another place to set =
pte
> > readonly which is in the generic weak arch_protect_bpf_trampoline().
> >
> > There are two ways to fix this race condition issue, the direct way is =
to
> > modify the generic weak arch_protect_bpf_trampoline() to add a mutex lo=
ck
> > for set_memory_rox(), but the other simple and proper way is to just ma=
ke
> > arch_protect_bpf_trampoline() return 0 in the arch-specific code becaus=
e
> > LoongArch already uses BPF prog pack allocator for trampoline.
> >
> > [...]
>
> Here is the summary with links:
>   - [v1] LoongArch: BPF: Make arch_protect_bpf_trampoline() return 0
>     https://git.kernel.org/netdev/net/c/b254c629a963
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
