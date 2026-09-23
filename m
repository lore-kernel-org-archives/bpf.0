Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9535D3C2BA4
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206890; cv=none; b=nCr2NzgRVAJKuTe60S2sRoJX1R/sXWQrKtRhxhTNIW3oEkMOjtLmUuSa5T+wv/yjfPndDm/mtKe5SKx7OtVbNYZlSC7gKuFbqHF8O6JCjkrnYQst9KXSpK8hJxLpD4gofkyIhpbBV2cC6zUYv5I7Uc+56ow6IU0Ju3Q5tFjYfmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206890; c=relaxed/simple;
	bh=mx0NRhxHsJAIA/Xk+p1PqQ3LF1LSQkViLs71bSa+x9Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F1UcQzKmWw/nK3Eyd9kedcPPwiBjRrg+Z+5Wtih2WAtogcRvRiF4uo/ttwZsuD7/FKv9+L9M0/btL+rVyP8VTK4B0wxLPa3BMGgZuCzohDmEsYLj8pR3nsryohEZ9ywCj+9CRJ+YKuCud2o8G1+Is7LTQImmY9Qf0rSznpBn6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uch2zv3p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uch2zv3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD341F000FF;
	Wed, 23 Sep 2026 23:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790206888;
	bh=jzSLDr2q+Jp5ZovVWdemKXems0JV23mN1rVV4Y1lWkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uch2zv3pn9CJlUFz1al/nwmOK295lyoGoVWqGM0rL8tVe8QAZP0NBTYbxPxQOYHHx
	 e78cioeEkQvwxO6ybWH1PxIpafTRcwWFhEtwLMNwK2Ls63OiapooLQrixoFj6KsS1Q
	 KPLre/4vt1pOZUzkiNEotIAP/buWeDdha6XQ4yGbJmFqasf5Af5nNscHm7Ch9oZym8
	 oikha87L7teuDro7RI78vQFVsDPnL7YcTLhJrS+2B+QiMhDVqjgp5YGk8xPbwq/cD6
	 FV/+XDfKpd3brsIZr0M7w8m8imm/7bwZ67W9Wg+RDyx334PeHQe4yQPRt2IlTNoaz8
	 tfHtGgDOsUvdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 5/8] libbpf: Version
 bpf_program__set_autoattach() ABI change
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923232939.1886328-6-andrey.grodzovsky@crowdstrike.com>
References: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
 <20260923232939.1886328-6-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 23:41:27 +0000
Message-Id: <20260923234127.EDD341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] libbpf: API/ABI pollution with internal symbol versioning aliases
--

commit d36af029b0efcdd76647414b7d862ed1b5af5ff2
Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

libbpf: Version bpf_program__set_autoattach() ABI change

This commit splits bpf_program__set_autoattach() via ELF symbol versioning =
to
change its return type from void to int. It introduces
bpf_program__set_autoattach_deprecated for the original behavior and
bpf_program__set_autoattach_v1_8_0 for the new behavior.

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index faea42f758479..d172c137cc376 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
[ ... ]
> @@ -393,6 +393,12 @@ LIBBPF_API bool bpf_program__autoload(const struct b=
pf_program *prog);
>  LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool =
autoload);
>  LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_autoattach(struct bpf_program *prog, boo=
l autoattach);
> +/* this "specialization" should go away once the deprecation window for
> + * bpf_program__set_autoattach_deprecated() closes
> + */
> +LIBBPF_API int bpf_program__set_autoattach_v1_8_0(struct bpf_program *pr=
og, bool autoattach);
> +LIBBPF_DEPRECATED_SINCE(1, 8, "use int-returning bpf_program__set_autoat=
tach() instead")
> +LIBBPF_API void bpf_program__set_autoattach_deprecated(struct bpf_progra=
m *prog, bool autoattach);

[Severity: High]
Does exposing these internal versioning aliases in the public header pollute
the public API?

Since bpf_program__set_autoattach_v1_8_0 is not in the export map, won't any
direct calls to it by users cause linker errors?

> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 8def5474885a8..999e791d98870 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
[ ... ]
> @@ -465,6 +465,8 @@ LIBBPF_1.8.0 {
>  		bpf_program__clone;
>  		bpf_program__load;
>  		bpf_program__load_strategy;
> +		bpf_program__set_autoattach;
> +		bpf_program__set_autoattach_deprecated;

[Severity: High]
Is it intended to export bpf_program__set_autoattach_deprecated in the
LIBBPF_1.8.0 ABI node?

This seems to make it a newly added, globally-visible ABI symbol instead of
an internal symver target, which permanently pollutes the libbpf.so stable
ABI.

>  		bpf_program__set_load_strategy;
>  		btf__find_by_name_kind_own;
>  		btf__new_empty_opts;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923232939.1886=
328-1-andrey.grodzovsky@crowdstrike.com?part=3D5
