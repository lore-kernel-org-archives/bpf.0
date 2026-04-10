Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C55B3A255D
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815023; cv=none; b=U2bd+LrUAMlvjCtOK627VpxeibxXhovkRDWOhkPLGcRw9KzwNWBYaKww8HRG+id8cbWlnzigPh8jtxA1/cBlvXE/pf02SGNLKpDMQrazLGL/A/NqUK/+oHeLTtEfNEdUj6BIid8EBeoL0ZR/b+en+Ea4lfDsPv/CDRemlmiAcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815023; c=relaxed/simple;
	bh=qwdGDZntSltIzoH4qv27wroKsiiWO0R3/vzKC7m7JJ4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=U7O/ogBKA5oAtsZoUk6XVwKE2YPZ6Q4917zQ/VXntAEcFwuovvnWbqhKO01fS8K2IZqPPjCykes3vJtWwQOFcYwjhHwOl8IhE0T4Du5dTM3kVZGnZjSt2rN3QhWjb5n4IYLTmUfScCQnwvLzJ2WyCdjUFawnUDQi9CQqcflYTuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fT/yNqO9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fT/yNqO9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DD1C19421;
	Fri, 10 Apr 2026 09:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775815023;
	bh=qwdGDZntSltIzoH4qv27wroKsiiWO0R3/vzKC7m7JJ4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=fT/yNqO9yXa3OLRki0cj/TSpZrw679QAYDnStWWpJUUkIg7ksr7mpnqQcCF12S4dk
	 LPV7owKxUQg3btru4wHXrshwLkPI1u5xIk+Jmyq49DVa/2xwX8TMA0TJGRpGsx57pm
	 VPNVBQLXfdN6nB/OermZJtvURoSiTt76GLwDP32Hwek7zHzaNQPZH6JzV/9+3Gez2x
	 I3461a+CyQrSHxFynY7uSNoI9YNT+W+lrKNJUhlQrZEn/v9KfJizavIXCqjubQhGYy
	 YkuAlpMy2suCQePTI9SQinwlqSj5J5MV4vA5g2Jn8Cy2sSsJp0WO8XeBLuVOFV0if0
	 R1Dh7nPeVHw4Q==
Content-Type: multipart/mixed; boundary="===============0649414833367377282=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <14bdd17ba48246c7ed1add4332eb7df21ca1ba844b12d5f69317c9d1273d18fd@mail.kernel.org>
In-Reply-To: <20260410-patch-set-v3-9-1f5826dc0ef2@gmail.com>
References: <20260410-patch-set-v3-9-1f5826dc0ef2@gmail.com>
Subject: Re: [PATCH bpf-next v3 09/13] bpf: change logging scheme for live stack analysis
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Apr 2026 09:57:03 +0000 (UTC)

--===============0649414833367377282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 1d9c89a269e3..3c421ad8684c 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> +static char *fmt_subprog(struct bpf_verifier_env *env, int subprog)
> +{
> +	const char *name = env->subprog_info[subprog].name;
> +
> +	snprintf(env->tmp_str_buf, sizeof(env->tmp_str_buf),
> +		 "subprog#%d%s%s", subprog, name ? " " : "", name ?: NULL);
> +	return env->tmp_str_buf;
> +}

Should `name ?: NULL` be `name ?: ""`?  When subprog_info[].name is
NULL (programs loaded without BTF func info), this passes NULL to the
third %s.  The kernel's vsnprintf prints "(null)", so the output
becomes "subprog#0(null)" instead of "subprog#0".

The conditional `name ? " " : ""` on the second %s shows the intent
to suppress the name entirely when absent, but the NULL on the third
%s defeats that.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24236538770
--===============0649414833367377282==--
