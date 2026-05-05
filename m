Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214EE2D73A0
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974009; cv=none; b=IhVZxNIichQbDX4sT9ooioAcMje4Fl/lz+quZMZKXridqf6g4ZNZjJpbZShPTVKjYq4hu8hZ+YwAhy4qP/LaBPiJgNvx8tJiQnZtSoeXOOtd3Jrl0IpdfJXQug1WcIKcB64oqJUvE5opPQLOHeDm6xoFUtkWIVIs5N6VoJCqcog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974009; c=relaxed/simple;
	bh=ORDk7AQs6E43i/07UA3/fX2Ua1jXIhwEslAw1weSxpo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BTe0q0LYkZ9eby+P3J386lvWxi3MkgNPpirxvYWLFNO/JdRsx4ZhrjxIj9lfpivYQSh8gFphkI1dXKXgp47cI/An91VkVcBcjGtdb0jYkE0+9gpAqPJ5AXPBfp2bV9BjqpRYlblwTIBgmLIh8KsDcUGy4FCJYQBQ1sJqp31Ys7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpAIg/zU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpAIg/zU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0EFC2BCB4;
	Tue,  5 May 2026 09:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777974008;
	bh=ORDk7AQs6E43i/07UA3/fX2Ua1jXIhwEslAw1weSxpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cpAIg/zUAuR2tXUvE5SZ/b2Jq0rLmxRm4Ff5lCjCO6eIQLHZsX8AnYyRUzlQaWLJL
	 vIiddPx9qg/4IAuFvahOeU7kyrKIWdDMN//IMv6CmpxBrtNZCdP9DRYqAlqjbVn/u7
	 pvq/zgtuwTqFhF25CxclwF850oWi2Xam4lo+TfWusKnRBYXj3obK3bbC2g5cPqkfen
	 NB9EmQVPyZ9O4ZlT7mmsdt7cMEabpCnW+tSgk3lJnzGe3YxT7b8OiWYc8ksnWPs1XD
	 r5JJCTpWocP25Z7MgYB2+VGGo4fKey2z58HNzjdUY76sbryMBEa0adKP2AyzPJUpgI
	 XnARIWvxZ6P1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/14] module: Make module authentication usable
 without MODULE_SIG
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505-module-hashes-v5-7-e174a5a49fce@weissschuh.net>
References: <20260505-module-hashes-v5-7-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 09:40:08 +0000
Message-Id: <20260505094008.8F0EFC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Misleading error message for generic authentication failures.
--

commit bd4ac969635e030618b66220b18c93b8a3a287e1
Author: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Subject: module: Make module authentication usable without MODULE_SIG

This commit splits module authentication functionality out from
CONFIG_MODULE_SIG into a more generic CONFIG_MODULE_AUTH. This change makes
the authentication functionality usable by both signature-based and the
upcoming hash-based module authentication.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 17a352198016a..cd8a74df117e7 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2601,10 +2601,10 @@ static void module_augment_kernel_taints(struct m=
odule *mod, struct load_info *i
>  				mod->name);
>  		add_taint_module(mod, TAINT_TEST, LOCKDEP_STILL_OK);
>  	}
> -#ifdef CONFIG_MODULE_SIG
> -	mod->sig_ok =3D info->sig_ok;
> -	if (!mod->sig_ok) {
> -		pr_notice_once("%s: module verification failed: signature "
> +#ifdef CONFIG_MODULE_AUTH
> +	mod->auth_ok =3D info->auth_ok;
> +	if (!mod->auth_ok) {
> +		pr_notice_once("%s: module authentication failed: signature "
>  			       "and/or required key missing - tainting "
>  			       "kernel\n", mod->name);

Since this infrastructure is being generalized to support hash-based
authentication, will this error message be misleading for modules that fail
hash verification where no PKCS7 signature or key is involved?

Could this be updated to reflect a more generic authentication failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505-module-has=
hes-v5-0-e174a5a49fce@weissschuh.net?part=3D7
