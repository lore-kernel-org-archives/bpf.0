Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C2F28134F;
	Sun,  8 Mar 2026 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772979908; cv=none; b=eUrIvERZfPNeHhipXkCQj64psEzqNn9AeTrb4QnJINHw6KPXf1bDKtryzsO1uLR1pRGXhxINeKIq1Y/Fu1XDbl3DVNa+YnCBJK/4Ud+x403cqJhIL6AFBncnhv2eA9YE0X+30ZjJJRosswI2mHkIWis4lJQWFF28zHdMU5/0Xo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772979908; c=relaxed/simple;
	bh=Wc4CwlNSjvDsMR5CHiHGcplf0nQwA0MliIla4YLiAgw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oMOmozlXzkCui+5ue/hQoGCTsijsqpb/J9sHdiIXCkREh0DTud2IvafPSvYwvGJwOn3MfgpTxFeepADm4GbI0wWTttOuhfeZBKwUqx3C672es4iNAJeZhNI+NbFuAmUQIcBOr9ohxWZMH0XXLE9fm08d4ViB2z81cIgEvFxC0Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkQ9hAB1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkQ9hAB1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39B3C116C6;
	Sun,  8 Mar 2026 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772979908;
	bh=Wc4CwlNSjvDsMR5CHiHGcplf0nQwA0MliIla4YLiAgw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=kkQ9hAB1wk1+kvu3LbX1tmNrg9jcOdtf+elQhxlSou+KSRKD3J4BGGPoHGwZFsZsR
	 HTyerJqEE2Rn7PI+chQNV/9zjEs4maVPS6GYYnYDbBcySQ0P64Mk8ennyEIAGXgXiq
	 YqEvbdu19W70hajjm3PO99qeFBgfgfJUh3xdlPMVjNdKPTDaKmAxQiyo8xizDgVqQZ
	 YVNd+GPl5yGDCbwwzOHaMKorSn+U5pySDw1cbz9FbctLCOUOzFfKuUB345UgOLjSNQ
	 8YvO3eUBrFiDPCpUcQTL3qgA7DFt+Xg5deoqXxOxBglp/j7NZnfyc1842cBfIt+YUJ
	 FU9d7K5O1EQrQ==
Content-Type: multipart/mixed; boundary="===============2665088607031215621=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2e2365aa0d183b5e1741d13d84b5f5d1857d6afcc5f30916d40e9eb322914a95@mail.kernel.org>
In-Reply-To: <20260308134614.29711-3-pilgrimtao@gmail.com>
References: <20260308134614.29711-3-pilgrimtao@gmail.com>
Subject: Re: [PATCH bpf-next v7 2/5] bpf: Add bpf_list_add_impl to insert node after a given list node
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  8 Mar 2026 14:25:07 +0000 (UTC)

--===============2665088607031215621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> +__bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
> +				  struct bpf_list_node *new,
> +				  struct bpf_list_node *prev,
> +				  void *meta__ign, u64 off)
> +{
> +	struct bpf_list_node_kern *kn = (void *)new, *kp = (void *)prev;
> +	struct btf_struct_meta *meta = meta__ign;
> +
> +	return __bpf_list_add(head, kn, &kp->list_head,
> +			      meta ? meta->record : NULL, off);
> +}

The prev argument here is typed as struct bpf_list_node *, so the
verifier classifies it as KF_ARG_PTR_TO_LIST_NODE.  In
check_kfunc_args(), the KF_ARG_PTR_TO_LIST_NODE case requires:

    if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
        ...
        return -EINVAL;
    }
    if (!reg->ref_obj_id) {
        ...
        return -EINVAL;
    }

This means prev must be an owning reference.  However, the natural
way to obtain a reference to a node already in the list is via
bpf_list_front() or bpf_list_back(), which return non-owning
references (PTR_TO_BTF_ID with NON_OWN_REF set via
ref_set_non_owning).  These will not pass the check above.

Compare with KF_ARG_PTR_TO_RB_NODE, which differentiates between
insertion (requires owning ref) and other operations (allows
non-owning refs):

    case KF_ARG_PTR_TO_RB_NODE:
        if (meta->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
            /* owning ref required */
        } else {
            /* non-owning or refcounted allowed */
        }

Should KF_ARG_PTR_TO_LIST_NODE have a similar distinction, so that
for bpf_list_add_impl only the new argument (R2) requires an owning
reference while prev (R3) can accept non-owning references?

Without this, the API only works when prev is an owning reference to
a refcounted object still in the list (e.g. obtained from
bpf_rbtree_remove on a node that is in both a tree and a list).
This is the pattern used in the selftests, but it limits the kfunc
to a narrow use case that the commit message does not describe.

This is not addressed in any later commit in the series (checked
through 4a7e9776ee29 "bpf: refactor kfunc checks using table-driven
approach in verifier").


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22822524869
--===============2665088607031215621==--
