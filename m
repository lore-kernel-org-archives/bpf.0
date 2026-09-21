Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BDC47A883
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 23:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032910; cv=none; b=a+AHHhsO87iBuR2oR1gHTqhJ15K7IKPsJ9YXO/2KHl3SHv8Tsv22ZMIXT3syZ5xblgyy57k+w6iHJeF6Lb7lI6FX3m68/iqzl9glIJ7Q3iJ47ghSypZMWmHUaBsfRFAHPC8aC7cUlmVtzsM5AZCAhTXD7YwUmeIuCTcyYMUkYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032910; c=relaxed/simple;
	bh=BBXdkGFoRNI1964DKrhoV3etvclN993VYIhbaCl6F88=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Xy/Kr0TnlRj/bC2KK+i0V7vtQm4Ja1GJll53T5jYL4Wp3zarrnrZUNuPrf95N9a0Ez4kD9IyEQIfLak3o+jIr1FON8RTzSSdfM6m+lk8fvLgA7j6+Oi3x8ufdwPv3RWGG0BEwsy0IhvcK2lrD4DVbBWqHWy4CO7M4RzKrMjS9mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loVxU0Mm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loVxU0Mm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF291F00893;
	Mon, 21 Sep 2026 23:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790032909;
	bh=vtJ+cZvsKcoSGzjbWt5awftaK0qljPIKu5rTqbPJbRQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=loVxU0MmpxPmMgvZL0VMikYn3aVpiFWLJcppwyo/XjIALXih9dKYyZ4Kt1eZtCBrn
	 oTa3YwI8hsYl8CNIgH+AzlOIVnYQPmJgTt8JyUJxlFe9L2hcn/8ObDLjIl17i6b9FN
	 vMRdP9IiQdD8k3ejmP38WoHoaZuc6AV1v87cAhdbKUmP+29bXlKT/xKDk5DMDqpvka
	 L/tF28C7t9VLWM9f3U7s5w03Mlxp5kOQAPpNXvxlg/AxBSSEltxbyXhEmN6QpXNEo4
	 072z73+m/TWK/+LnbgfwRYq0VcvJe9vC5szGgC76RgKtoPYi/ll6pGqsJ4TbC3bXdR
	 Y0wtjWz3ZcQAw==
Content-Type: multipart/mixed; boundary="===============6478683053718833315=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7253a3b91b000dc7fb7200330834d77e5ccd34c313f358515ac465e33100d8b0@mail.kernel.org>
In-Reply-To: <20260921223937.3203093-4-andrey.grodzovsky@crowdstrike.com>
References: <20260921223937.3203093-4-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v4 3/7] libbpf: Support declarative manual load via SEC("!...") prefix
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org
Cc: ast@kernel.org,martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 23:21:47 +0000 (UTC)

--===============6478683053718833315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 939f0d6378e3..476172933a1f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -892,16 +892,25 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
>  	/* libbpf's convention for SEC("?abc...") is that it's just like
>  	 * SEC("abc...") but the corresponding bpf_program starts out with
>  	 * autoload set to false.
> +	 *
> +	 * Similarly, SEC("!abc...") marks the program for manual loading:
> +	 * it is skipped by the bulk auto-load pass and must be explicitly
> +	 * loaded later via bpf_program__load_manually().
> +	 */

Does bpf_program__load_manually() exist?  Looking at the tree at this
commit, git grep finds only this comment.  The real API added earlier in
the series (commit 7f73306ceddb) is bpf_program__load():

tools/lib/bpf/libbpf.h:2179  LIBBPF_API int bpf_program__load(struct bpf_program *prog);

The rest of the series uses the correct name - libbpf.h's doc for
bpf_program__unload() references bpf_program__load() for reloading a
MANUAL-strategy program, and the selftests added later in the series call
bpf_program__load(skel->progs.prog4) for the SEC("!...") program.  So the
only documentation of the new SEC("!...") prefix points at a symbol that
will fail to link.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35664584544
--===============6478683053718833315==--
