Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505831;
	b=033dTEfuw4E4MFW00WfZblF3x5mohLd3/9YBTvhleLK2k/FT6SZdjNU2RAq6V8yHhe7y
	 5ZX1iIAU5/TAjlBdYAz3qaYzLy+qid05scvpMcH9qX6NLuRulWFApfZaUDqddh6AxF+cp
	 bf+Uieqb0PMk+ZYTCO3Tf8HZj8Wxz2/mkB6DW99U8UcpbUVyWjOkSDYOE4owirViEvKLu
	 XdAs08yoPL3atWTJqGCqxuGy3L+94e36jvhtAFh2McefiOPTR/w8+FYUOTYJE8TMXl/hr
	 7097eE9kf09P7nFAYYc4YkyZj+SDc8q1XBaCnDSEGYrIIAQHDW9Xn5GmXfO11zVLMlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505831;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=EvEWwZXJOQ9AXxY31LoCfiy60IlEMawdYT0DrZFa57A=;
	b=zY1YTVb3Ob9TbE+h/WiICB2Nn4jO8Unjcbj6GdAtrWZJ2ZU2T3XaHsrR1NoP5D9c4ro6
	 H6ZWoqFFAC66nrC/d4GSuY21WDTPTgDAkf//0vYPokALRVxPNj/u7Y6hos6RpxnzKKc1+
	 ENAGDm3evjWYIi70gIW1zmtCrGjtm/M5kr1r+6txu4ruVB9iD3VF99UzraPAUMrWXQDf/
	 JudIfOIaEp9Yh4LYaeGfAWpyraLAaIM7CrGm3ttgpuKzVzBQbiZQFEtLZ/rFgs4txfpdv
	 +7LaTFYAbDmf2YrJTdkdD8ZvnlhgKG0tv7LHr8A7rXQUvZU7aXLoJEHPs9qF23eIF7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOWzZbVM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B5606C212;
	Tue, 20 Oct 2026 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOWzZbVM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA191F000C4;
	Tue, 20 Oct 2026 14:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505831;
	bh=EvEWwZXJOQ9AXxY31LoCfiy60IlEMawdYT0DrZFa57A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JOWzZbVMzJHD9YT2GIP5+X0V8Cj/V90twOPhqK1f1iYY1U8oE9X3seQShMF3ZbP8q
	 /oNigFu9nmnyE4Pa7BiXSlVi5/SyKrpchzJ2CfovIOtg4Rk+TKKQMNjb7u6NEPD4Bd
	 uHP3L8oc9Jyryj63n2V76+7/DynpH48uWp4tChhd0zDdW+hk8/of9XTXvt6L4/MXNB
	 YXiYDgyetzF5L7gCIEkAsT7Q6OgFTyn67zxC2/4kQ7kGxoL1RXL6lrY2FxA9CEjXzF
	 9C2LLsWNkO1OU1QUYKwnANoYyxdc0DQMqIk496eIZ8Jv23KiX2UMKouPJG180SyHti
	 2c2ZPzvuXWVAg==
Content-Type: multipart/mixed; boundary="===============5171442887851383942=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <723450d805c81106880f33239053949f2da673394089f83cecea50b067c58ff8@mail.kernel.org>
In-Reply-To: <d56952f063f90acb07c0a37c96a83851bea227d8.1792503001.git.xukuohai@huawei.com>
References: <d56952f063f90acb07c0a37c96a83851bea227d8.1792503001.git.xukuohai@huawei.com>
Subject: Re: [PATCH bpf-next 12/16] libbpf: Introduce arena percpu helpers for user space
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,emil@etsalapatis.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 14:17:10 +0000 (UTC)

--===============5171442887851383942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Introduce arena percpu helpers for user space

TL;DR: The new libbpf arena percpu symbols are exported under the
already-released LIBBPF_1.8.0 node instead of LIBBPF_1.9.0, which changes that
version's ABI and can cause undefined symbol errors at runtime.

> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index eeba4072a5da..eda89ab60543 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -458,6 +458,8 @@ LIBBPF_1.7.0 {
>
>  LIBBPF_1.8.0 {
>  	global:
> +		bpf_map__arena_percpu_base;
> +		bpf_map__arena_percpu_ptr;
>  		bpf_map__attach_cgroup_opts;
>  		bpf_prog_stream_open;
>  		bpf_program__add_flags;

Should these two symbols be added to the LIBBPF_1.9.0 node instead of
LIBBPF_1.8.0?

Commit 3ead4ead078f ("libbpf: Start v1.9 development cycle") states that
libbpf 1.8.0 has been released, bumped LIBBPF_MINOR_VERSION to 9, and added
an empty node at the end of libbpf.map:

    LIBBPF_1.9.0 {
    } LIBBPF_1.8.0;

That node is still empty here, so exporting the new functions under
LIBBPF_1.8.0 changes the ABI of an already released version.

Binaries that use these symbols will record them as @LIBBPF_1.8.0, so
symbol-version based dependency generators (for example rpm's
libbpf.so.1(LIBBPF_1.8.0)) would accept the real libbpf 1.8.0 release, which
does not have bpf_map__arena_percpu_base or bpf_map__arena_percpu_ptr.  At
runtime the dynamic linker then fails with an undefined symbol error instead
of a clear "version LIBBPF_1.9.0 not found" message.

No later commit in this series changes libbpf.map.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39434884362
--===============5171442887851383942==--
