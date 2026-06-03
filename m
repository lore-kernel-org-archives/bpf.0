Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB1C402427
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485991; cv=none; b=srqLwktiqD2+yvoHwOxZVF13tGzRRT2nrmAXcKDSj8/dAOBvqBXugmdVdzE/2oBzvY5JPenCSSl1G9m5rSAddkHGDJJZvZENM+DsuKHOAzklcVYiVOtxbxMp9ItWf4WodbgOoeYbIOTUOPCe4eRKJwa+vyaKCayzD4LILatPlB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485991; c=relaxed/simple;
	bh=LIHrOeSY7wFSP2wnSgWEmwCRQADdHEYDsKjbyx5IylY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ezngZwlBx9rPz8+OsrqTZ0rxbTfSjyBBemvCamXS7V2BS2HIS5KlgjnjJBDZBmbcwMhbbm3LL++vlu9zLzYrRERGHvy0iuHVh0JoLV0ZqN2uw5Uizt4b76guVRm+wDWuHSgopSqYanBV01HLQIWhsUu2nBPVCZ6YyQEcNj21bDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=go1xICj8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go1xICj8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1EB1F00893;
	Wed,  3 Jun 2026 11:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780485990;
	bh=M5yIMw2dGWmOK8I+xyPkGXOAZl5L0afZNTA88S7fj/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=go1xICj8unnVGxZNnL+Isyfr0xMG3O9L5LEkA5AA0Dfotfjk7JhAFfTqctUpxEF6o
	 jIxXyvzWbIH6tCS76H97T/EkFJefb7ijlyXFOZMHMda4llpgGJXPy5qjh0cU7fOIf1
	 MGdVlvxAMFMTBw0l5o0fcKQ6E9SLpw+imARPx5bAkIwQFVKmy0ic4wo6aNjGtLAZD2
	 ryQJVhT4KPDGFaCb1whbzt9pehVy3BHGgfn0I2M4lXyVajQeBSaY4OE/6SCp20Zsee
	 Dg0KxSDPfrM8w8cc+/Eel2QJ2chqRb+q0LMvPdQdHmEG5zfUosldJW9dIMe65GzHlI
	 QrCHuzWwZ8NpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv7 bpf-next 01/29] ftrace: Add ftrace_hash_count function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603110554.29590-2-jolsa@kernel.org>
References: <20260603110554.29590-2-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 11:26:29 +0000
Message-Id: <20260603112630.3D1EB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The generic ftrace_hash_count() API is incorrectly guarded by CO=
NFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS, returning a false 0 when direct call=
s are disabled.
--

commit 61129b2eed8ea43ed2c045ef25d031a4504c8af4
Author: Jiri Olsa <jolsa@kernel.org>

ftrace: Add ftrace_hash_count function

Adds an external ftrace_hash_count function to allow retrieving the hash
count from outside the ftrace object.

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 28b30c6f10314..02c24bf766ced 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
[ ... ]
> @@ -551,6 +551,8 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, =
struct ftrace_hash *hash, b
> =20
>  void ftrace_stub_direct_tramp(void);
> =20
> +unsigned long ftrace_hash_count(struct ftrace_hash *hash);
> +
>  #else
>  struct ftrace_ops;
>  static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
> @@ -590,6 +592,11 @@ static inline int update_ftrace_direct_mod(struct ft=
race_ops *ops, struct ftrace
>  	return -ENODEV;
>  }
> =20
> +static inline unsigned long ftrace_hash_count(struct ftrace_hash *hash)
> +{
> +	return 0;
> +}
> +

[Severity: Medium]
Is it intended to restrict this generic API to configurations where direct
calls are enabled?

It appears this declaration and the inline dummy are placed inside the
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS block.

When CONFIG_DYNAMIC_FTRACE is enabled but direct calls are disabled, any
external caller will silently receive 0. Could this cause subtle logic
errors for users of this generic ftrace infrastructure?

>  /*
>   * This must be implemented by the architecture.
>   * It is the way the ftrace direct_ops helper, when called
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index b2611de3f5943..57ab01fd00bda 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
[ ... ]
> @@ -6288,11 +6288,16 @@ int modify_ftrace_direct(struct ftrace_ops *ops, =
unsigned long addr)
>  }
>  EXPORT_SYMBOL_GPL(modify_ftrace_direct);
> =20
> -static unsigned long hash_count(struct ftrace_hash *hash)
> +static inline unsigned long hash_count(struct ftrace_hash *hash)
>  {
>  	return hash ? hash->count : 0;
>  }
> =20
> +unsigned long ftrace_hash_count(struct ftrace_hash *hash)
> +{
> +	return hash_count(hash);
> +}
> +

[Severity: Medium]
Similarly, does this implementation need to be moved outside the direct
calls block so it is broadly available to dynamic ftrace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603110554.2959=
0-2-jolsa@kernel.org?part=3D1
