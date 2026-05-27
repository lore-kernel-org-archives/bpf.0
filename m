Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB721E8320
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883079; cv=none; b=hFNnBjGfH6kSliOeIZ44QxlS/Okh/79RuCu7egLmfPg3OWo5Bu9cDx7q3PW8iuVsVf+8zheqjzByRKhwZwgMAkTniPgLPEn/HTZcPc4qz8rMLT0nxo6+WKjLSiKMvn1PgXVJoAwsSPqn4f6/d1LMbOoJLtVgOaVGN0UlqYfrBAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883079; c=relaxed/simple;
	bh=mOxAhoYj35f81Ze05tZiiBJHg9/JXXswsUGQKhp2p4M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hzVU5F6lkc1EPSBxGJBou6GpC1rf8Dwqk43Ibu9ydc575FU58/Kv5ssMAN1D1LQYQBCYEbQnxnBcG9y3ruCwz/KOjcTPJmYdUxPZx8xqKtjhPYjqUTbYmgEp82b/uNBqGQxmpNjfDu7HNaM02VNsiRaIrIDES8eOEllg3oC9ol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA4JIpnq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA4JIpnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F361F000E9;
	Wed, 27 May 2026 11:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883078;
	bh=810ekjPRoKXGw82IwkK3YsmlBP8SRX+eDrskvhFpFwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CA4JIpnqCeNkffTvOtZ46uvgvFiX5vZmACt0+Yzhc/kNpPX4rXrOidea8Ge9fIBVo
	 SLYkuP32iafgZ6Y9nzMdlm68zE+/Kqp/ik0rG59b4vbyvhrCMWJX+nqV4U0eE04lI+
	 XV6T4EvZ7N8c/3fqZvISBKNcLeo3b4T1aE9Ei8PC5ier5Yzcj7bJomae9uUATMxKza
	 JickHymmzzcBvdQY1wHU9F5TQkibUx4gmA/aF5HVV9kiTFD6YYYB3Swcm7yfky6a4D
	 F2ONHaNPqnDyzRzjtq6fSrkLsXwPxm9/IzoXxaBiddv5BJACbE1+a0idZZSBRACPCM
	 tlguk1najSOCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv6 bpf-next 01/29] ftrace: Add ftrace_hash_count function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260527113951.46265-2-jolsa@kernel.org>
References: <20260527113951.46265-2-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 11:57:57 +0000
Message-Id: <20260527115758.24F361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing a fallback stub for `ftrace_hash_count` when `CONFIG_DYNAMI=
C_FTRACE_WITH_DIRECT_CALLS` is disabled.
--

commit 78dc69c9f694d0e9d50e5ac39e06f35ffd293fdf
Author: Jiri Olsa <jolsa@kernel.org>

ftrace: Add ftrace_hash_count function

This commit adds an external ftrace_hash_count() function to allow retrievi=
ng
the hash count outside of the ftrace object.

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 28b30c6f10314..282da661f1313 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -551,6 +551,8 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, =
struct ftrace_hash *hash, b
> =20
>  void ftrace_stub_direct_tramp(void);
> =20
> +unsigned long ftrace_hash_count(struct ftrace_hash *hash);
> +
>  #else

[Severity: Low]
Is a fallback stub for ftrace_hash_count() needed here when
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS is disabled?

Other direct call functions in this header provide static inline fallbacks
in the #else block. Since struct ftrace_hash is gated by the broader
CONFIG_DYNAMIC_FTRACE config, if an external built-in caller uses this
function on a kernel configured without direct calls, could this cause a
build failure due to an implicit declaration?

>  struct ftrace_ops;
>  static inline unsigned long ftrace_find_rec_direct(unsigned long ip)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527113951.4626=
5-2-jolsa@kernel.org?part=3D1
