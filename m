Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578537;
	b=aqk5IUHFyiQeV7jL8esiP61JRsP/JdZo1KcKmTMyN9mnLXUziTrN8POtTe8iGq/2fLMo
	 61+nlx0TwYcsG4UDpL9QB0wp+k5EBPP/HFID1SLesRu3F4qNn/CVcv+MUFUCK+0qKfRTb
	 DciR2o1+LzePIbACkgI0SNs80PQNLsxwMPQXxPYf4In45raTY5KDYqsCpWZ/jU1pQYlXS
	 5vaOjEZL722oKVAnNd3dM7H4Iitje8KX88LM0Mj024xfW7BuIySI4Dn0pV8TJ1eGiHEr0
	 4Eu7jjxbQu0sjv7dugb3e6kLhf43aeV/GGVX40JnJ1T+r+hCXU7EQ5UWEUMSwDwUkmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578537;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qNZAY6UfltGZFyhV5agfg0LJhkYXtfgZdrwzmXs1Lw4=;
	b=Q8tqDFLjiNcIGJluTmiV5YVQ/WgxBY0u1e13Cm7/Y4HlI/lHAdq7V9mrHqpn6cYpC6wT
	 2B82VXoNvzC5JB9IPjTA42QnoS84ZUb12hKxuBwGJrTI56x0DO1ItIDaoRufbG4GnpXrr
	 GGGwm5gSeaLighO2N8Je+hoxMX1Dj8zEVvGD3CEHBNjf5CWv390XGmnviNBVBnNnasvsT
	 0Zu3CEjoHZGobWrxnnzo1gL9+2+zwYGIjU867K23V4OF8p36YoRkDeHd7zXMqpXNjyDSX
	 H69FGIybNKEAnuQtUuahCt7oycCD1enMJrWm+JIlmvd8f61Fba4w65J7nlcW7SrrH+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xr0oW9a1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CB4606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xr0oW9a1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924731F000CA;
	Wed, 25 Nov 2026 03:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795578536;
	bh=qNZAY6UfltGZFyhV5agfg0LJhkYXtfgZdrwzmXs1Lw4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Xr0oW9a1CPKSzqDUQ7fFREwjowo64ZQnSp8Iyewzjm9X2LtOrVh2Mckm7eRVryQsA
	 la34XYupBGVtKCYpyy3a1P5yonua/Ujdd/YRaYEh2ASDaEz9Rili83E1MLrU7buER+
	 K1URr4a9t4GR9A5G5SQJW4wegbCo+uW+Q8l4EE8Ybk4QqO4bztIxDad/5Jnah+4+Os
	 ih/wcY+5clSVEPdNboj7zLvB8Evt4ztCJY7OP6UeKcIt45qCsekoovk56O0jlWsGcr
	 7FhbOhaSStvMS4rZXxGq7zjOOMpAmB+p3n0WqL2WZhPOduDqdxbasjrslABfC54htM
	 WU+TObMXufUfg==
Message-ID: <sashiko-outbox-232513@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 12/47] bpf: Check for NULL in helpers that take a
 kernel pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261125032938.670542-13-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
 <20261125032938.670542-13-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 03:48:56 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] bpf: uninitialized memory leak in bpf_copy_from_user_task()
  [1]
--

commit 021b75463c0bf9eb8fa8c4cfc85b4a67aea33848
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Check for NULL in helpers that take a kernel pointer

This commit adds NULL checks for BTF pointer arguments in several BPF
helpers to prevent NULL pointer dereferences.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index bc0dd36a2799a..749169a0b157b 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -726,7 +726,7 @@ BPF_CALL_5(bpf_copy_from_user_task, void *, dst, u32,=
 size,
>  	if (unlikely(!size))
>  		return 0;
> =20
> -	mm =3D get_task_mm(tsk);
> +	mm =3D tsk ? get_task_mm(tsk) : NULL;
>  	if (!mm) {
>  		memset(dst, 0, size);
>  		return -EFAULT;

[Severity: Critical]
This problem wasn't introduced by this patch, but does the early -EINVAL
return for non-zero flags just above in bpf_copy_from_user_task() leave
dst uninitialized [1]?

kernel/bpf/helpers.c:bpf_copy_from_user_task() {
	/* flags is not used yet */
	if (unlikely(flags))
		return -EINVAL;

bpf_copy_from_user_task_proto marks dst as ARG_PTR_TO_UNINIT_MEM, so the
verifier treats dst as initialized after the helper returns even on
error, allowing the BPF program to read uninitialized stack or map memory
when non-zero flags are passed.

[1] https://sashiko.dev/#/bug/linux-63188542-7120-4444-b9a3-9977c77b0e2d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125032938.6705=
42-1-alexei.starovoitov@gmail.com?part=3D12
