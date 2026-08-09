Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B372EEE90
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786269442; cv=none; b=tkcZVg1xm6NVdBqW/ekIDOsIBUfA8WB7rbq5uMuOAbf6O9T/EqmdVnuthJcmMUJ6JGEWbHTwoab7WTTQ4e1bRN2z/FbdiKpJkzOPO89bSEcckbL7vtKSUB/PFztUYPX5JkL1gkyuEeknmKUXj/qd5hRgzGbqVyWF6qUOFqMZuiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786269442; c=relaxed/simple;
	bh=Axbb+6GHwqrA2uWDqz066bfeFYLneJgy6H+haUfc8d0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ldLpc/LxpIi03GHu2xgtHue+LK/D9SYIUDiQf4kdso46+exDdy+9neYPzStkyfT4eLeTxYDukuFsohFhaq6bLWcmU1u+S0aZOcOLQjJADnfKBETGx13bsKnOgzS6fVngnuVqnsh7UUWo2kOTmAsl2bv2fAQw+ErNImJmpXiGEcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnOi5jfr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnOi5jfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202571F000E9;
	Sun,  9 Aug 2026 09:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786269440;
	bh=PFXwBqWM4EQ2LNicMFpCSbfSwlhRadp+B6BiLqAp2hw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QnOi5jfrseKW5rhfPhy9sVtNntIpSMzIXv+Pd2XJ3Dk+PwdYNTDridhXzRhnsFVAC
	 3AEmNa086X8xib7Jois8yAnU8Wu9CeU+4BLm+aIkagb3Rde1ikLG5393dOl+SajA6v
	 GyN0CenLlK2lps1mqGwY2OyCudIxa0fK0guUI+W82DpP0W80Vm2VNJwNj8PJ7NtHGk
	 e3Z4DkxRkxOf6dghPI3e+Y3ULnh9qp+Im+/4ZlHtO6i9vJtPT0O9+qObvSuT0/jSGV
	 UbNE7m4TeewQ04s4UVV33736M9g3qrgZqTecYXRW2AK9jtoObZXKcDntvlhPBYqIyg
	 VXPDMgnJ/eoMA==
Content-Type: multipart/mixed; boundary="===============0010239551256923039=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e425dd364d874c0071dd4096c38ba72df96da2afd8c541d99f3a48c878808e5d@mail.kernel.org>
In-Reply-To: <20260809085155.3305519-3-memxor@gmail.com>
References: <20260809085155.3305519-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Test resolve_btfids arena argument suffixes
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  9 Aug 2026 09:57:20 +0000 (UTC)

--===============0010239551256923039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> index 732cfed35e1c..9bd84fe32b89 100644
> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> @@ -15,6 +15,7 @@
>  #define DECL_TAG_FASTCALL "bpf_fastcall"
>  #define DECL_TAG_KFUNC "bpf_kfunc"
>  #define TYPE_ATTR_ARENA "address_space(1)"
> +#define ARENA_ARG(n) (1U << (n))

This isn't a bug, but ARENA_ARG(n) is zero-based while the KF_ARENA_ARGn
flags it sits next to are one-based, so the same argument is spelled two
different ways inside a single table row.

For example, '{ "kfunc_d", -1, KF_ARENA_ARG2, ARENA_ARG(1), false }'
means KF_ARENA_ARG2 and ARENA_ARG(1) refer to the same parameter.

Would a name like ARENA_ARG_IDX(n), or a short comment noting that
ARENA_ARG(0) corresponds to KF_ARENA_ARG1, help keep the two columns
from drifting?

[ ... ]

> @@ -49,13 +50,18 @@ struct kfunc_symbol {
>  	const char	*name;
>  	s32		 id;
>  	u32		 flags;
> +	u32		 arena_args;
> +	bool		 arena_ret;
>  };
>
>  static struct kfunc_symbol kfunc_symbols[] = {
> -	{ "kfunc_a", -1, 0 },
> -	{ "kfunc_b", -1, KF_FASTCALL },
> -	{ "kfunc_c", -1, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2 },
> -	{ "kfunc_d", -1, KF_ARENA_ARG2 },
> +	{ "kfunc_a", -1, 0, 0, false },
> +	{ "kfunc_b", -1, KF_FASTCALL, 0, false },
> +	{ "kfunc_c", -1, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2,
> +	  ARENA_ARG(0) | ARENA_ARG(1), true },
> +	{ "kfunc_d", -1, KF_ARENA_ARG2, ARENA_ARG(1), false },
> +	{ "kfunc_e", -1, 0, ARENA_ARG(0) | ARENA_ARG(1) | ARENA_ARG(2) |
> +	  ARENA_ARG(3) | ARENA_ARG(4), false },
>  };

This isn't a bug, but the new arena_ret field duplicates information
that the existing flags field already carries.

resolve_btfids only ever arena-tags a return value from KF_ARENA_RET:

tools/bpf/resolve_btfids/main.c:add_arena_tagged_proto() {
    ...
    if (kfunc->flags & KF_ARENA_RET)
        /* tag return */
    ...
}

There is no return-position suffix mechanism, so arena_ret is exactly
!!(flags & KF_ARENA_RET) for every row and the old expression it
replaced was already correct.

Since only KF_ARENA_RET drives return tagging, could the return
assertion keep using !!(flags & KF_ARENA_RET) instead of the new
arena_ret field?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31305217088
--===============0010239551256923039==--
