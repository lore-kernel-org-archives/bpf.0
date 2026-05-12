Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBCB368D4A;
	Tue, 12 May 2026 06:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568081; cv=none; b=a3N7rjVl7pskP3WP++nGIB3vgpf7nyn3hgEs1U0Wrbnm1pCOHrpapmavCWdMOJQhIaoPr9xB4pUYmM75sUfKWk+sO49XBcRcpjtzXEzYG0/PMarp0drLfVw5V4bM1z7QuW0Yu2rA7rMPcExMVWf8gHoGLT6M4ZyRoeaa5XePBH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568081; c=relaxed/simple;
	bh=60DINgg33vz870fqqt0V7U6mechH3OWJjjyMB3tn+2A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QTEPTElT0KcvvB8vkFAYXuNudQnboBMOY2wWeKO1GA6gy4DczdAuYDUa20HyLXeOOS0ZOQKWEdW0HfwhD6c2mKnALGb6UX9/avmW1SvSkQ78MLI3aGGnBlXTcJWWISS5W8FBc5li4HBDSbS7MrOk7/Y7xBENA3a8xazVnQJPSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6god+hI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6god+hI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825C0C2BCB0;
	Tue, 12 May 2026 06:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778568080;
	bh=60DINgg33vz870fqqt0V7U6mechH3OWJjjyMB3tn+2A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=o6god+hISc9cQJ7mhwxkN9M9I+sELaJkT1H50bANj+AxQ9cxbVD/O9BbtHocrh+Jh
	 JLlfgLaIU0es9O6WIlGrvZ2sAHg4lKCc9QWtX39H9jf55ZHBS35ClPoCf/7o1aGmRM
	 7v2oPZCay2s1qU4SSK9fL/BQBL6RYdOnzY/lhhJlbh+WByyn/9XDsfJfwGK5xRndV6
	 pSVvRklZFIKiqkfO5ldR6cegwB3fQaryT4JzZWx/MVM1JlnXBdkA5DQq/zRCumoP2V
	 xdv5f8GnCbqTKmUBH0u6uaPqYT73IfqGLPAlsIA5N9ngIg49As4uTbrCJqW1cj3Ym0
	 MouFCtodh+6dQ==
Content-Type: multipart/mixed; boundary="===============0813842692136127767=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f33022246bdf8c537f4c9d68d737cdc885f8a8c5da08c574f88f9b45a10cb167@mail.kernel.org>
In-Reply-To: <20260512055919.95716-8-kaitao.cheng@linux.dev>
References: <20260512055919.95716-8-kaitao.cheng@linux.dev>
Subject: Re: [PATCH RESEND bpf-next v10 7/8] bpf: allow non-owning list-node args via __nonown_allowed
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,ast@kernel.org,corbet@lwn.net,martin.lau@linux.dev,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,skhan@linuxfoundation.org,memxor@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-doc@vger.kernel.org,vmalik@redhat.com,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 12 May 2026 06:41:18 +0000 (UTC)

--===============0813842692136127767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 75e6c078e0e7..3a9db1108b95 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst

[ ... ]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index dfd465badd9d..f2f8705f0e9a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -2620,9 +2620,9 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
>  }
>
>  __bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
> -					       struct bpf_list_node *node)
> +				struct bpf_list_node *node__nonown_allowed)
>  {
> -	struct bpf_list_node_kern *kn = (void *)node;
> +	struct bpf_list_node_kern *kn = (void *)node__nonown_allowed;

This isn't a bug, but the second parameter alignment is inconsistent with
the style used in the rest of this file. Most multi-line function
declarations in helpers.c align continuation lines under the first
parameter. The other functions modified in this same patch (bpf_list_add,
bpf_list_is_first, bpf_list_is_last) follow that convention, but this
one does not.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 71d50415f743..4d78d834c609 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12017,6 +12022,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			break;
>  		case KF_ARG_PTR_TO_LIST_NODE:
> +			if (is_kfunc_arg_nonown_allowed(btf, &args[i]) &&
> +			    type_is_non_owning_ref(reg->type) && !reg->ref_obj_id) {
> +				/* Allow bpf_list_front/back return value for
> +				 * __nonown_allowed list-node arguments.
> +				 */
> +				goto check_ok;
> +			}

A subsystem pattern flags this as potentially concerning: The BPF
subsystem guide requests that multi-line comments in kernel/bpf/ files
follow the modern kernel style with the opening /* on its own line,
even when the surrounding file uses the old style. The comment you added
begins text on the same line as the opening delimiter. While the comment
itself is clear and correct, the preferred formatting for new comments
in this directory would be:

				/*
				 * Allow bpf_list_front/back return value for
				 * __nonown_allowed list-node arguments.
				 */

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25716874656
--===============0813842692136127767==--
