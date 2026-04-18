Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8155522259F;
	Sat, 18 Apr 2026 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776491947; cv=none; b=MN9WxwNjrJrhVgZKzkZJHQ5XzRgitsnG6n/yT1TwOttXPYoFm+IPUQzrxSSNPTXI2NjJKSlwSOPNaFuu8w49O+SRqQYdfwoC7K1G6JiTKbA0GZ9ouVxL8l0hhVbA/c9pmRAkCQZqoSY8HTqr7ZgIxHabs4KNzmWbWYi5aKRLD/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776491947; c=relaxed/simple;
	bh=DjvpuVm6vJcY7bDx5YI4kmp4dLJuHPN92Em3UWCXaTc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gwG1ZCBo7663FceqbJOyQyPHTqii26DLQeZDUNru5bH28Fl3ZoL55l5r3zjjw/Joe1mJoKvymrLfttXRdhCz74r4qp/M5XTJ5FAetVcHe0QxLnQEbQ7T9o/eIAmTV3W9dbzQZSo32wSQutBIwSjMO57eJyqpEZHeXFjq1cW28QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un/mQ4u+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un/mQ4u+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA7AC19424;
	Sat, 18 Apr 2026 05:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776491947;
	bh=DjvpuVm6vJcY7bDx5YI4kmp4dLJuHPN92Em3UWCXaTc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Un/mQ4u+4OLnW4uXVMHdaTEDRTnacpHybJx8dxVmi9lqfz77nxedNUn36I3ZgTfNS
	 0bLDIvfYOLL5pInGMKW+X7UhSD7bKF/E/s9WoEUhkpAph6scwN0r78YSinVyhQ3b2U
	 gETWWppSTOA0Jg/LWzNPNEs00eFyLp22EWq4eUm43f5fzU3pZgO7/6cer44HoEZrKO
	 iy7V42d8mx3W12yjfZMFpwhIrUMRDoRCqfIlQWr9h9gsXPDGjjDeAnayH6rXd7uqjK
	 MhJupK/mI5HYfc3FWESYlfeBynf821AuWiZRhOsiiCNPxvUwHQ6sG3dzI6L/cNbVQk
	 d4VYGyCD4IXLg==
Content-Type: multipart/mixed; boundary="===============7115338192684722360=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7634d754f187df27c83d722c7bcd4ac73c06d13e1ebbc778b4a6d8fe296032c9@mail.kernel.org>
In-Reply-To: <20260417192502.194548-20-jolsa@kernel.org>
References: <20260417192502.194548-20-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 19/28] libbpf: Add btf_type_is_traceable_func function
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 05:59:06 +0000 (UTC)

--===============7115338192684722360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fc08ac6bcdde..49368ee161b1 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +static int btf_get_type_size(const struct btf *btf, __u32 type_id,
> +			     const struct btf_type **ret_type)
> +{
> +	const struct btf_type *t;
> +
> +	*ret_type = btf__type_by_id(btf, 0);
> +	if (!type_id)
> +		return 0;
> +	t = btf__type_by_id(btf, type_id);
> +	while (t && btf_type_is_modifier(t))
> +		t = btf__type_by_id(btf, t->type);

Does this loop need a maximum resolution depth limit?

If a malformed BTF object contains a circular modifier reference
(e.g., typedef A -> const B -> typedef A), could this loop spin
indefinitely and cause a hang?

> +	if (!t)
> +		return -EINVAL;
> +	*ret_type = t;
> +	if (btf_is_ptr(t))
> +		return sizeof(void *);

Does this correctly calculate the pointer size for cross-architecture
analysis?

Since libbpf is a user-space library that may process BTF blobs from
different architectures (like a 64-bit tool processing a 32-bit BPF
object), will hardcoding sizeof(void *) return the host's pointer size
instead of the target's pointer size?

Would using btf__pointer_size(btf) be more appropriate here?

> +	if (btf_is_int(t) || btf_is_any_enum(t) || btf_is_struct(t) || btf_is_union(t))
> +		return t->size;
> +	return -EINVAL;
> +}
> +
> +bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_type *t)
> +{
> +	const struct btf_param *args;
> +	const struct btf_type *proto;
> +	__u32 i, nargs;
> +	int ret;
> +
> +	proto = btf_type_by_id(btf, t->type);

Could this cause an out-of-bounds read if t is not a function type?

Because the type and size fields share a union in struct btf_type,
passing a type like BTF_KIND_STRUCT causes its size to be misinterpreted
as a type ID.

The internal btf_type_by_id() helper skips bounds checking. If the
interpreted ID exceeds the BTF type array bounds, it might read past the
end of the array and return a garbage pointer, which would then be
dereferenced in the next line.

Should this verify !btf_is_func(t) first, and use the bounds-checked
public API btf__type_by_id() along with a NULL check for proto?

> +	if (BTF_INFO_KIND(proto->info) != BTF_KIND_FUNC_PROTO)
> +		return false;

[ ... ]

> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 3781c45b46d3..a9845f57e56c 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -250,6 +250,7 @@ const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, _
>  const struct btf_header *btf_header(const struct btf *btf);
>  void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
>  int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map);
> +bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_type *t);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24598000047
--===============7115338192684722360==--
