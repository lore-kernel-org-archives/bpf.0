Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708053;
	b=sOfm30U7Com+bVcylUC1y9Y7HWG3/WcBI7rwQKrdWupKj5MQp+BdTuGqAqB5PrDAzg/O
	 VbBR3llaVOlsSHof174BmvS8pg/iZq0rFRNlTBwgeBIRBWioZAROCtXsrIeiBW6lLPOqc
	 5JOBzbTiESobKuvlhtJucBct3h18Wq+lxxSvttTiXmSkSP+ZUXbA1zzXFeasGqFdapArk
	 /ruk+hUuKZkA2uMDmOim3J6nWIu6NNGev+96nHMVeuzFhJsZupi/7ZAqK3YCOei47YMUF
	 WYDZSaeaTZItxewdyBeWjnBq+g4efXJ12+XxY3feFpKthcyendLcVCOagd+pmdIEiIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708053;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=A8XfQkt93awT1q8iV7D8gI7ZDfBSM+KMHfE7UUFp8JY=;
	b=XLqo0q1oAxTC8/1bHKzcKmmzY0oJPurh149msf6CIdU/z/F84LVm5kEMHhVrQL9+dbfo
	 DOQK7BW/uthGENWSHvSv39BK0HgDdlJa+kESoIjB4jKHueWlCrUjgf6yd7Igk6TiKKey8
	 YYzwefwNUtAiSNI/QUKZCi1eEKhM+qMxA/F4h81YonS71Z5358SrLuTU2mJ+4MZ1D6d7U
	 heDSxmj60K8EDGYgsDx2bSaBr3XI+Qj8Is1JXL7ChVhzP9GrQxrEYyDK1WntXbMNrdIPL
	 tIEu6r2XRKOw6fNwXek4d426YB3scSFlmn3lbdyPfu/3dnlEsIidvJ1Lu4rS0M0Iv0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a9x0LxIz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3AF606A330
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a9x0LxIz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6EC1F000C6;
	Thu, 26 Nov 2026 15:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795708053;
	bh=A8XfQkt93awT1q8iV7D8gI7ZDfBSM+KMHfE7UUFp8JY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=a9x0LxIzVVJ4emUpzVn2ra80qRZsFo3q0Y0PPGBGwoQVofJZJSRYPwF3Rn0lGCIS5
	 d6Rf71ue8ve7TB/skUSTzM8cf54G46M0P0jESeymghRYJing3TP+vEJaURPZ+j5bPL
	 wz4UYU9AScbXg44lNRmWbWQd1/re9Fi7NZXgEQT4f9Rn3L1ijxtWnHCqmBpaASJ28c
	 fYFQiMptRTHFx/inNPaB+0fdFImgDbZSJuzAGh4I1c1l785c061abwWj4E81S+kZ6K
	 X4r5GFRD4hkmAZ5QcoRC3zYnbQ09obry1AKGsbvySfoQobXZDfeAmbMjHYO+yMdIH6
	 rrE2uV2jioxyQ==
Content-Type: multipart/mixed; boundary="===============4603946495888804730=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <468774737b63c8aa4d8cd6b2d7de16ac60d3c29add13446eb9960a8be1ef1ff8@mail.kernel.org>
In-Reply-To: <20261126-bpf-relax-get-next-id-v3-4-338e1d3077e7@toke.dk>
References: <20261126-bpf-relax-get-next-id-v3-4-338e1d3077e7@toke.dk>
Subject: Re: [PATCH bpf-next v3 4/7] libbpf: Move bpf_object_prepare_token() to object creation
From: bot+bpf-ci@kernel.org
To: toke@toke.dk,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,toke@toke.dk,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 26 Nov 2026 15:47:31 +0000 (UTC)

--===============4603946495888804730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Move bpf_object_prepare_token() to object creation

TL;DR: Creating the token at open time likely breaks selftest
token/obj_priv_freplace_prog_fail at this commit; the fix is in a later patch.
Could it be folded in or moved earlier to keep the series bisectable?

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -9281,6 +9281,7 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
>  	err = err ? : bpf_object__init_maps(obj, opts);
>  	err = err ? : bpf_object_init_progs(obj, opts);
>  	err = err ? : bpf_object__collect_relos(obj);
> +	err = err ? : bpf_object_prepare_token(obj);
>  	if (err)
>  		goto out;
>

With this change, the token is created at open time.  Does the selftest
token/obj_priv_freplace_prog_fail still pass at this commit?

userns_obj_priv_freplace_prog_fail() opens priv_freplace_prog with
opts.bpf_token_path set, does not call bpf_object__prepare(), and expects
this call to fail inside the user namespace:

	err = bpf_program__set_attach_target(fr_skel->progs.new_xdp_prog2,
					     tgt_fd, "xdp_prog1");
	if (ASSERT_ERR(err, "attach fails"))

Now bpf_program__set_attach_target() ->
libbpf_find_prog_btf_id(attach_func_name, attach_prog_fd,
prog->obj->token_fd) -> btf_load_from_kernel(..., token_fd) issues
BPF_BTF_GET_FD_BY_ID with BPF_F_TOKEN_FD.  The bpffs in that subtest
delegates bit(BPF_BTF_GET_FD_BY_ID), so the call succeeds, ASSERT_ERR
fails and the subtest returns -EINVAL.

A later patch in the series, fd2e3e09e169 ("selftests/bpf: Explicitly
disable token in token/obj_priv_freplace_prog_fail test"), sets
bpf_token_path to "" for that subtest, and its commit message says the
test broke because of this libbpf change.

Could that test update be folded into this commit or placed before it, so
that the series stays bisectable for test_progs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45845510673
--===============4603946495888804730==--
