Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470E63233E8
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 01:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780363588; cv=none; b=nZjoQW1N+R251vGLwQCLZ3XxkkPYUHqwYOctjhgYa29ObUauyNYdjTFxqmBT61SzLohCtwQPLEQ84HAaVXFRSbiCREruvbjrihWd6Yd33/IVDYaVXNPagMX921bDh50EkTABEPBp1uE7RFE5MMg2e8fMTVRIZ/5GOk7hl8YweCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780363588; c=relaxed/simple;
	bh=OPzddBQSs7VXlDsTtRFQ4gUnDu5dSs9mjOjPxy/V5ss=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CuU9T2IaVTRg5wHc01gTon3QJ/Ims+SKBODE49qX1cJ637yz3w+l/zhJYOq5wQ8fKsFnPygg7SZ875+KJwV2YpNk/Mhszcr/4f29/DAqf8R5ALyOGxUDIHVChbNP/Uoe81a5bQjpztukcfe9464ZX8t2Dh7aW5Zfb3+mBlYNlAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1tkGaz7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1tkGaz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65731F00893;
	Tue,  2 Jun 2026 01:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780363586;
	bh=OlPj6pGfx3TXcyOXN0eNfmjTHOCMivBbj/utJQsukcE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Z1tkGaz7/EiqluOLj75f9h1TzGg74t5paqbj5Oq+w+3+r0wudHgKxWgjraupz4NMS
	 i8YrqszaABgZihU/JnHW2yGAsck0KejYLkmtqAnJfIQbDMlzKKBqgRltwJn3shA0DW
	 +03D5WW05ByLviWdgtXrmdBFphWqya3Rf6KeZxawEYHL2gpK/rZd3aJlQQs9a1+lSK
	 9smJFjc8iY7ihswnnNi2iZv5PpZHXw6OH7iQbzzNv6GYfzvaMzjLHQzs7rwwzgohnl
	 3j/ibnZhDMEU/gtXKEKrKn5CeutGJOPWcsH8WyYo0yYogVuSmuPHe0ItqUnXB0st1t
	 v7vL/5OkurKEQ==
Content-Type: multipart/mixed; boundary="===============8993611353815754036=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <de3626fcb38375f32f7dddbcffb90ff35cd61caf54a24f6188531af70b55f0a4@mail.kernel.org>
In-Reply-To: <20260602004120.17087-3-emil@etsalapatis.com>
References: <20260602004120.17087-3-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 2/6] verifier: parse BTF type tags for function arguments
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,mattbobrowski@google.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 01:26:26 +0000 (UTC)

--===============8993611353815754036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 17d4ab0a8206..c6a930aca67e 100644
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
> +	t = btf_type_skip_modifiers(btf, type_id, NULL);
> +	if (!t || !btf_type_is_ptr(t))
> +		return 0;

Should this return -EOPNOTSUPP for non-pointer types with type tags? Eduard
Zingerman suggested this in v2, and you agreed it would be appropriate for
handcrafted BTF, but the current code still returns 0.

Reference: https://lore.kernel.org/bpf/e1a40461fa792dc7687b0029f3ede546eeeacbc9.camel@gmail.com/

> +
> +	/* We got a pointer, get all associated type tags. */
> +	t = btf_type_by_id(btf, t->type);
> +	while (t && btf_type_is_type_tag(t)) {

Does this loop handle type tags that are separated from the pointer by other
modifiers like CONST, VOLATILE, or TYPEDEF?

If the BTF chain is structured as:
  PTR -> CONST -> TYPE_TAG("arena") -> INT

the loop would evaluate btf_type_is_type_tag(t) at the CONST modifier, get
false, and exit immediately. The arena type tag would never be collected and
ARG_TAG_ARENA would not be set.

This causes arena-qualified pointer arguments to be mis-classified, defeating
the feature this patch series adds. The issue is confirmed by commit
7e64879a17df ("bpf: Allow subprogs to return arena pointers") which rewrites
this loop to iterate over btf_type_is_modifier(t) with a continue statement
to skip non-type-tag modifiers.

Reference: https://lore.kernel.org/bpf/20260530005922.90CEE1F00893@smtp.kernel.org/

> +		const char *tag = __btf_name_by_offset(btf, t->name_off);
> +
> +		if (strcmp(tag, "arena") == 0) {
> +			*tags |= ARG_TAG_ARENA;
> +		} else {
> +			bpf_log(&env->log, "function signature member has unsupported type tag '%s'\n",
> +				tag);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		t = btf_type_by_id(btf, t->type);
> +	}
> +
> +	return 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26791686730
--===============8993611353815754036==--
