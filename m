Received: from mail-106102.protonmail.ch (mail-106102.protonmail.ch [79.135.106.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0A22AD35
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099794; cv=none; b=Q47Ss9oU/g/e2UiP6dbvkzA1lScpfSo+f0XpuQfe5YmFDbsePYgA8ZkRi8d/6DYrRacs2hDb/L2ZZS3GbxV69T4K+zMPV9I4kzarg3SdaGrLuNvt4ECqSOBXaalLcIat/UaK0DlE7h2zZbf2Ioes5cfWM995s1EIAohR/pglxZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099794; c=relaxed/simple;
	bh=Qdy6vOu1A+6iXuVteDnntXtQtq/5gyAVkxhMeGuCOMc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eb93ni+56I3s7PwgLaayZuZvdW/vrQuO3CcWgNAWKqR1jswihph583uOy5VQie2xnQNeMhww1UkyuhfkfAEEjCzqNhq3bH48LYxNEXcuri2tVljqvxiF4E9dhYIdws58q+UwUxhaFJk243OdjaCmGup9Xvp8INtiYTgmA3jwq5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DOd5FFhu; arc=none smtp.client-ip=79.135.106.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DOd5FFhu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791099783; x=1791358983;
	bh=yifafxUrjg/Fd7QBGFO2iPLzYAKnyZdf4PUzNYV7Gb0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DOd5FFhunrt+zD+vNC84E4y045F/9ULue8ekFOziNsN/ICOnKF71W+hvG8WL+ICw1
	 vrFHHHxOyohSqC5ae6Z7Myrp6pA5xlI/+3zRyJkSDX03W+GjUJaXKA8IIbtJpOelDL
	 Ms2Mcypo7NtSJkKcBen12+yl63CnZtl8xt8OqNrYtDYvOxwXZ703PX9IVyiy6DDcqO
	 I2E2FAfcrer5s+OI7NHPZXxNTn3INZeMkIkoVYZVyl09JM9bc6dl1jXDMlHnNDwIFJ
	 T0wimsKioxLCJSwfiJaILlKNNJBdz58y1i1NMsE1yxvEabitQJgNIYjA887G82QB4n
	 miYJDnKG5zs6g==
Date: Sun, 04 Oct 2026 07:42:56 +0000
To: Eric Dumazet <edumazet@kernel.org>
From: quanyeyang <quanyeyang@proton.me>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: annotate lockless writes to sk->sk_err
Message-ID: <9NcBQjsEuykTInATuaBUjtFtdQznS1jzk-VuRI7-tbKzaeDqQ2Pfs4YGURFT_x8LJOwEkXgndIfjX1dV_3-hffCHBuBQHoAEFwKZGltO79A=@proton.me>
In-Reply-To: <CAL4WiirzoFX6W01xKK4uAiQ+BzecwidVDH8uB9f3cPsiVV_iww@mail.gmail.com>
References: <20261003-tls-fix-sk-kcsan-err-v2-0-e939a2ebdd56@proton.me> <20261003-tls-fix-sk-kcsan-err-v2-2-e939a2ebdd56@proton.me> <CAL4WiirzoFX6W01xKK4uAiQ+BzecwidVDH8uB9f3cPsiVV_iww@mail.gmail.com>
Feedback-ID: 206494642:user:proton
X-Pm-Message-ID: b9a41c3cb9bafcb8fcf3de09dd1d623a0e3e70ee
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, October 4th, 2026 at AM 12:14, Eric Dumazet <edumazet@kernel.org=
> wrote:

>=20
> Has this patch changed between V1 and V2 ?
>=20
> You are supposed to carry the Acked-by and Reviewed-by tags collected
> during prior iterations.
On Sun, Oct 4, 2026 at ... Eric Dumazet wrote:
> Has this patch changed between V1 and V2 ?
>
> You are supposed to carry the Acked-by and Reviewed-by tags collected
> during prior iterations.

No, 2/2 is identical to v1. Sorry for the extra pass =E2=80=94 I should hav=
e
said "Patch 2: unchanged" in the v2 changelog and kept your tag.

Thanks for the Reviewed-by.

>=20
> Please help reviewers, they need to recover their precious time.

Thanks, I'll pay attention to this next time.

>=20
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
>=20
> Thank you.
> 
