Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1882848BA
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780362308; cv=none; b=LnD5amRAixNa9iwHE1QxWBUDI7GIlnsXgsprF1jF17JE6xXsIk7Q/aKAJfqfcR/kp82SrFcEugtmHhRN4Cdy19OeF7JghXQ0AZoOdjGAttc627Nsf/E6rQAzCUEIIvWjrj00l0fc6Dy6pN4pdlYId9m3SPmbeIyMqzZI85dLakQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780362308; c=relaxed/simple;
	bh=h3e4c6sUbvhMyRLwP8L1aX+wAS0BdUjcK1WBcDxhcKU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M5HC4tbTgaoirLWGTN5TtD0hS6WMT/fkVpAZ5drgnbc9GGxcRQYTH9K1K/TifVUr4ZJK5akD+fV2hSuoVm5JRXJeitl3DBqO+9b6QTLyHPsr235v0PAYAXiQzcShCCVHjEDKCp1ZD1aDSTlgYDOKNxzyXtc/+nciMCkCJKFMSss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE6uSLdG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE6uSLdG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F3B1F00893;
	Tue,  2 Jun 2026 01:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780362307;
	bh=uGW4RzO0zcqEQqFEmBRK1LaecUkgbH287+/GmWFJvo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oE6uSLdGbbg+Q2YyKdxKbDJpmX8n31nRc2ttWQchJo1wiCT4vtj3admhxYhM2A5qO
	 RtMqbu7MJVYARZKSCOgpCoWk3ZjzdfqM3Xrw+pL2rfdKgzyM3aGl2FBI470tkHnlJK
	 YV6xkBlRUaiIz5MTwwdv3jHQn/F7vFHVhGcBKKeLoJBy2CHfH85aR5o7sr7SDd+CAf
	 riHnyHoQ/MHDf3grekfzJ3X/tYvwH/bzs+OyQ98To39zmQDcsvYppY4LvbTVc0kVVk
	 uTLcVP4g0JHfPZLMA+Z/WCPAQzIcwLuxyKjwW5ifq/iaLV5sF/IblU9I3Z/4KAHWB9
	 ykj3UmIkoOthQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/6] verifier: parse BTF type tags for
 function arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602004120.17087-3-emil@etsalapatis.com>
References: <20260602004120.17087-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 01:05:06 +0000
Message-Id: <20260602010506.F2F3B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The `btf_scan_type_tags` function unconditionally rejects any =
`type_tag` other than "arena", breaking previously valid BPF programs.
--

commit 1b7f5032b014c339265f4b7f34961a16eb4c5894
Author: Emil Tsalapatis <emil@etsalapatis.com>

verifier: parse BTF type tags for function arguments

The BTF parsing logic for function arguments goes through
the arguments' decl tags, but does not go into their type
tags. Add type tag parsing for function arguments.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 17d4ab0a82068..c6a930aca67ec 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> +static int btf_scan_type_tags(struct bpf_verifier_env *env,
> +			      const struct btf *btf, u32 type_id,
> +			      u32 *tags)
> +{
> +	const struct btf_type *t;
> +
> +	/* Find the first pointer type in the chain. */
> +	t =3D btf_type_skip_modifiers(btf, type_id, NULL);
> +	if (!t || !btf_type_is_ptr(t))
> +		return 0;
> +
> +	/* We got a pointer, get all associated type tags. */
> +	t =3D btf_type_by_id(btf, t->type);
> +	while (t && btf_type_is_type_tag(t)) {
> +		const char *tag =3D __btf_name_by_offset(btf, t->name_off);
> +
> +		if (strcmp(tag, "arena") =3D=3D 0) {
> +			*tags |=3D ARG_TAG_ARENA;
> +		} else {
> +			bpf_log(&env->log, "function signature member has unsupported type ta=
g '%s'\n",
> +				tag);
> +			return -EOPNOTSUPP;
> +		}

[Severity: Critical]
Will this unconditionally reject any type tags other than "arena", causing
previously valid BPF programs to fail verification?

Since tags like "user", "rcu", or "percpu" are commonly used in kernel
headers, and were previously skipped by btf_type_skip_modifiers(), returning
-EOPNOTSUPP here will propagate through btf_prepare_func_args() and abort
loading global subprograms that use these type tags.

Could this break backward compatibility for existing userspace programs?

> +
> +		t =3D btf_type_by_id(btf, t->type);
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602004120.1708=
7-1-emil@etsalapatis.com?part=3D2
