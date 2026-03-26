Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE529D29F;
	Thu, 26 Mar 2026 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559761; cv=none; b=ls6n1NHvt+KlS6ro7MJnr8sEL8jpkU8rPk4ZkYtg0bvL94kJS1Ayf/gOAf+/5Soqizyvc6fsXeQ/MoG4N0AdxUVNlQybcWrlGs9s8vGf7wlpasJTYuUF14fuaAatzg56IVY+KdmJzHPjodTVh266viWabyhEXcLD1FgySzM3eQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559761; c=relaxed/simple;
	bh=1Pl+WjgFFGKB0h/WqZvWngHFD8GeFrz/gG9hz5PwpRQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=I6h4+U3vveQdSkiZmM63ccsxuk7fd4lWTRszQLsls0pJULqZVs0I6MYvvGIzOptZ1V8Jx2R5O6TAHKOTgvUvetMC7iO6vZ0CBbsW06vGhmweJRFv1pFfeDO81wJqUOAAQDeClrVPSt7qxwaWA2gADvwPxxTGKAkoIYS4/SgJ5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciNIbzJ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciNIbzJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35756C116C6;
	Thu, 26 Mar 2026 21:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774559760;
	bh=1Pl+WjgFFGKB0h/WqZvWngHFD8GeFrz/gG9hz5PwpRQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ciNIbzJ12Az0aqzMj8n5gTJ3kco6JYbXyXGj+JloA6I4ET3kfbFeLzySMfI5/q7Sm
	 WwFxw8UJqjfLPxUXvPJmjkzqQJq/q/9VTD/vj5j98SjtXtVd6BAQ1122N4w5kpjeh5
	 Gwd51fVZYbtw3S7f/2Am6FiS80SObPBlovBUQ3EDqw4NwvUGcGhfkFJBZhigiuuaKC
	 TLg4xd01Z+0pfZcO78XJNeSbxPkV4nPI953w5CXStH6BJVukwgQLVD8lqh1tvDA+sO
	 8bBaG+rEXzjbJE/hRW7uNNh1G8G5zosSZxsqe47tOvocPDSHjxesjzvr/keOolIkW7
	 0mBCq1rA4sVnA==
Content-Type: multipart/mixed; boundary="===============6558493855404507813=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <07c8ca950f26820b9982344ff798be3bb41f7c1f81f45b599ccb1a687b824f1c@mail.kernel.org>
In-Reply-To: <20260326204335.3756885-1-suzhidao@xiaomi.com>
References: <20260326204335.3756885-1-suzhidao@xiaomi.com>
Subject: Re: [PATCH] libbpf: resolve versioned kfuncs by exact name before essential-name lookup
From: bot+bpf-ci@kernel.org
To: soolaugust@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,sched-ext@lists.linux.dev,suzhidao@xiaomi.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 26 Mar 2026 21:16:00 +0000 (UTC)

--===============6558493855404507813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1eaa7527d4da..85268406c0f5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8630,6 +8630,40 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
>
>  	local_func_proto_id = ext->ksym.type_id;
>
> +	/*
> +	 * For kfuncs with a flavor suffix (e.g. "func___v2"), first try the
> +	 * exact name.

[ ... ]

> +	if (ext->essent_name) {

This commit fixes a bug introduced by the patch that added
triple-underscore flavor support for kfunc relocation.  Should it
include a Fixes: tag?

Suggested:
Fixes: 5964a223f5e4 ("libbpf: Support triple-underscore flavors for kfunc relocation")

> +		struct module_btf *exact_mod_btf = NULL;

[ ... ]

> +	}
> +


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23617578044
--===============6558493855404507813==--
