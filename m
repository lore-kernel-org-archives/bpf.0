Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEB3508402
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418610; cv=none; b=SghQ8jAZbxgNOfWCJ0HsSGgTX+7UVYZN60FAlDnOJM1H7/vpgTcUjyhUIjAwv34fhaKUAO5IQZ8MPlflaKspu43fVa0OCRNYOiFms01GTsbdQ/Z2g8XzLGXA94ybYVTjyzJzOayuT3z/cfpLSGjHixE0UgMnrMuQWROxpnnT7Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418610; c=relaxed/simple;
	bh=vQg7UCkqqjyJHsA6UPJkOFQUzzYf+OUZ+mR+pqLnZ08=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CdOvuc1Rgvz4DFJuanctMg+ku/KhGhZEX6ER0b+9Y+FEGQfNIF8FbyLkaVfB2KDjMrWTauJAYuJ1rdqahNFskbuZNqHMIxIkMgXBris1C71vqQcGNpX3moU/c/GtAa/I8FBrEOJvtgUN+FE311yrTGpMcX1R8ZGZtg/z0wn1Jj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyc65J1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyc65J1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4331F000C7;
	Mon, 19 Oct 2026 14:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792418608;
	bh=zSVi6uJilEtfryl2FOCqO+3Fdv8G5IHThxG5wXjcgmM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kyc65J1giV7udDKwuelUjsOueLPk/brMSAfY9C4LxBrT5NJlTyecGLyYJCvSUmbVe
	 mg6AhIaAvvDf4Bty92/I8kJjiwnhSzG58yJs+eLIaDccE8E2IJ3V3W0XBkRmEUbQlo
	 mcgxsC7YLKIq8ie7+wlubThgq4OK8WRLHxqm/+XALb2ds81uq0eagVxmS2GQ4IPU2B
	 HkOyQZJ6vdfssEY6oLnBEC9BxaCmBh+qwMWm90bIkjJuz/uMia2i5uJS74GanOgRbn
	 xDTBOylbLvjxHsSo+mf2wXWzlz5vMtFz7sBsCeDt9uc4VOHYtA4iuxGo6JkBxJX5Zh
	 rUVbGuNEvkfTQ==
Content-Type: multipart/mixed; boundary="===============6045370894619532022=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cbcb5d1d6782d5171426ba0a091d45ffe1520ff5d029bddf4ecc30748e63743e@mail.kernel.org>
In-Reply-To: <20261019132203.3034698-9-memxor@gmail.com>
References: <20261019132203.3034698-9-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 08/16] selftests/bpf: Test __nullable pointer members
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 19 Oct 2026 14:03:27 +0000 (UTC)

--===============6045370894619532022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test __nullable pointer members

TL;DR: Test-only issue: three comments in struct_ops_nullable.c say __nullable
still requires a NULL check for plain, scalar and untrusted pointers, but the
verifier drops the flag there, contradicting the patch's own other tests.

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_nullable.c b/tools/testing/selftests/bpf/progs/struct_ops_nullable.c
> new file mode 100644
> index 000000000000..929969e1e012
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_nullable.c
> @@ -0,0 +1,82 @@

[ ... ]

> +SEC("struct_ops/test_nullable")
> +int BPF_PROG(test_nullable_cb, struct bpf_testmod_nullable_args *args)
> +{

[ ... ]

> +	/* through a plain pointer the loads are probed, __nullable still asks for a check */
> +	t = args->self->task_or_null;
> +	if (t && t->pid != args->task->pid)
> +		return -1;

Is this comment accurate?  args->self is a plain PTR_TO_BTF_ID, so the load
of task_or_null goes through the "Old compat" branch of
check_ptr_to_btf_access(), which then does:

    if (bpf_may_fault_on_deref(PTR_TO_BTF_ID | (flag & ~PTR_MAYBE_NULL)))
            flag &= ~PTR_MAYBE_NULL;

That clears PTR_MAYBE_NULL, so the verifier does not ask for a check here.

> +	/* a pointer to a scalar walks as untrusted memory, __nullable applies all the same */
> +	i = args->int_or_null;
> +	if (i && *i != 7)
> +		return -1;

The same question applies to this comment.  btf_struct_walk() returns
WALK_PTR_UNTRUSTED for a pointer to a non-struct before tmp_flag (which holds
PTR_MAYBE_NULL) is merged into *flag, and btf_struct_access() then sets:

    *flag = MEM_RDONLY | PTR_UNTRUSTED

so __nullable is ignored for int_or_null.

> +	/* through an untrusted pointer the member is probed too, and stays nullable */
> +	v = bpf_map_lookup_elem(&untrusted_map, &zero);
> +	u = v ? v->args : NULL;
> +	if (u) {
> +		t = u->task_or_null;
> +		if (t && t->pid != args->task->pid)
> +			return -1;
> +	}

Does "stays nullable" hold here either?  u is PTR_UNTRUSTED, so
check_ptr_to_btf_access() overwrites the flag with:

    flag = PTR_UNTRUSTED

and the PTR_MAYBE_NULL from the tag is dropped.

These three comments say the opposite of what the same patch asserts in
struct_ops_nullable_probed__plain.c, struct_ops_nullable_probed__scalar.c and
struct_ops_nullable_probed__untrusted.c.  Each of those says the tag "asks for
no check there" and loads an unchecked dereference with __success.  The
commit message also says these pointers "are probed and lose it".

Could the comments say that the verifier drops the flag in these three cases
and that the NULL checks are only there for the test's own result?  A probed
NULL read gives 0, which would fail the pid and 7 comparisons on the first
call.  For the untrusted case u is never non-NULL, so that reason does not
apply either.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39261628996
--===============6045370894619532022==--
