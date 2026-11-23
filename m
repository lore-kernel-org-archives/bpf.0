Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795477304;
	b=hWF/UDzAum61BxDJzjeXOyTBQyJBY7HKuq5DuBooth/TEnQvzMNEPnFV9mF57yVghPoV
	 q2AK6oo/U4M9xtLWBi+Ckd+Ain3nv097G1ox4mKaNWKJOSLUKarorZMT+hQ8h+f6rz/8N
	 HCHfojHHskD/xQupwKVTzuLSE4s0K4K90V9Pod6T+tvevnsGNQr+Vg92VrAmx4BFWkNTV
	 GACGHUQw4Hu3ukchauCqT/IGpKAvIWgQIHOLjDXj76OPRjDAkYCyx4kldv/1QnMSyH17I
	 0c32Sm9m/+POSA2f3bdog3BnwipysqLFOqCIb03qk8/ic8s8W/xZimsoB77EeXF5+eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477304;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Dbpz5yq7gJjAkGR04GNS7F/n7nOquCefhwUbEDv7Bzg=;
	b=vN3EqOE/ZaS1gZM+3gM9ILT3BmOsAb+gA0JnG5VK3Qc6feTsIuKSA2VTnIz4UdYrLXRB
	 8TDKzB4Ns8d8UKV5JNyTqo15D41FSvQor7JQkzQ/XijhvxfWwNAwWXHXsdiKM+XHCjNpP
	 OvvKbB+6sVmgoEPiTnTCqUmeaOxmHhycRCe7BvFJp+7Oi8qUN9qlk5r5g+aIywuPnCfMU
	 3xRearwjNsFtHkMCA/z8OgNw/uyd4hz3QcpDqRO3odua4QrGCsy0tK12+XVNVNRYubKOg
	 Rc0qVLaFxIK+mJMXaOFdwpGLeiYm/RGEKlWmyJHrWO+LHiBVdfSxzSVI/11mXZpJ8TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eS++9ZkO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B229D606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eS++9ZkO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED4C1F000C0;
	Mon, 23 Nov 2026 23:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795477303;
	bh=Dbpz5yq7gJjAkGR04GNS7F/n7nOquCefhwUbEDv7Bzg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eS++9ZkO8UoUuD1QMYHloXaObpGevjyOhIinBoUCoCySNCm0Eyk5uP2j6M/j1hxwx
	 2hgnmafGkwnqUZpZwiYV5N3NZedsgTNvdCXdYToK+8uvhjysfceQJOJS7gAvNS8SXQ
	 JasyfozzFvc7SB3NexYGeiwl/Yi4fZPCY9hHnsMO1eiNAYEWtYcybvDBdQahXvlJcY
	 mI0belNPQXjcXk1iXxre0Jwq7TbbOLRgV9eNrZNcA4IZEURIoljMybWVTFwb0lWgm3
	 +yswTYxVt2Rh0rlNMPMjtpdINfa0wNwxKqprnKQZzxXlWqczSY9crRMa/d1LcolDB6
	 DuifWleRFr4Gw==
Content-Type: multipart/mixed; boundary="===============6228661783317720632=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <dc257c60f91ba87c244a6bf9a9d7b424adfd17629c6926085c87cd2188772df3@mail.kernel.org>
In-Reply-To: <20261123231058.2538362-1-yonghong.song@linux.dev>
References: <20261123231058.2538362-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 2/2] kbuild, bpf: Remove pahole version checks below v1.24
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 23 Nov 2026 23:41:42 +0000 (UTC)

--===============6228661783317720632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> kbuild, bpf: Remove pahole version checks below v1.24

TL;DR: Commit message only: claiming the resulting config is unchanged looks
inaccurate, since PAHOLE_HAS_BTF_TAG becomes y for clang builds without BTF,
though with no functional effect today.

> kbuild, bpf: Remove pahole version checks below v1.24
>
> The previous patch makes CONFIG_DEBUG_INFO_BTF require pahole v1.24, so
> the Kconfig checks for an older pahole always pass with
> CONFIG_DEBUG_INFO_BTF.
> Remove CONFIG_PAHOLE_HAS_LANG_EXCLUDE (pahole v1.24), which is always
> set with CONFIG_DEBUG_INFO_BTF. Drop it from the dependency of
> CONFIG_RUST on !CONFIG_DEBUG_INFO_BTF, and always pass
> --lang_exclude=rust in scripts/Makefile.btf, which is only included
> with CONFIG_DEBUG_INFO_BTF.
> CONFIG_PAHOLE_HAS_BTF_TAG (pahole v1.23) is still needed, since
> btf_type_tag is only used with clang, but it no longer needs the pahole
> version. Every user of it also checks CONFIG_DEBUG_INFO_BTF, so make it
> depend on CONFIG_CC_IS_CLANG only.
> The pahole flags and the resulting config are unchanged, except that
> CONFIG_PAHOLE_HAS_LANG_EXCLUDE is gone.

Is the last sentence of the commit message accurate?

The new definition changes the resulting config for clang builds without
BTF:

    Before:
    config PAHOLE_HAS_BTF_TAG
        def_bool PAHOLE_VERSION >= 123
        depends on CC_IS_CLANG

    After:
    config PAHOLE_HAS_BTF_TAG
        def_bool CC_IS_CLANG

With LLVM=1 and pahole missing or older than v1.23, PAHOLE_VERSION is
below 123, so PAHOLE_HAS_BTF_TAG was n before.  Now it is y, and
CONFIG_PAHOLE_HAS_BTF_TAG=y is written to .config and the generated
autoconf.h and rustc_cfg even though CONFIG_DEBUG_INFO_BTF is n.

This has no functional effect today, since both users (compiler_types.h
and trace_event_update_with_eval_map()) also test CONFIG_DEBUG_INFO_BTF.

Would it be better to use "def_bool DEBUG_INFO_BTF && CC_IS_CLANG" so the
generated config stays identical, or to reword the commit message to say
that CONFIG_PAHOLE_HAS_BTF_TAG is now also set in clang configurations
without BTF?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45289030741
--===============6228661783317720632==--
