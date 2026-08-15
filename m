Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0024C403E82
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786777290; cv=none; b=IAVwSG4t3WwQi72VtwtPcVmjO+tlI/PkgQaaNzx3dm35rB62Hw4b1YE4N2GTfJtqB6y8+MnxakcyLD+gnT/+/HGN+cJVpQx5pZWojlEdJQg+4gp9mDXGakrgyROVPvhDUwa+kOXJHbR0ET33o7nXfpOitPLbFJq1alRzJXd3G2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786777290; c=relaxed/simple;
	bh=Rw6naS20FxTNVQdIVwPfioT4qvmm0op/9SRgKd9OW2g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W994P/CnHLTvY8MmKsK898LgLSyUfxP2d/ZZIKcOv7N+7wR49eXKtU7Q4IDXZXRVvco8t/9r6OYRCiOA9GkW3ZtMJomP+aWsINK0klyhVXHVCXT3RwrRG1EzaKV+4CeL5NwPnJvZFhqxg28fg9LkLODyu1zlsLCr2wRKlDOhfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3UsUs/O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3UsUs/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BBF1F000E9;
	Sat, 15 Aug 2026 07:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786777287;
	bh=4IxXd9JXMtwZYuMOb2u5LvEm0E0BWEtya8LDpKD23Z0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d3UsUs/OS/4ntN1kKOvTNaV/KCGylxiEe6wnxEqiTeDghqXMR2GmSbhvRc+y2F2O8
	 /jpjvRis6+JMVXeVXn/rWWnIpewsgzJHIBzaPcMYk6kKidLcC4ur5zihxzaGKJMwqj
	 2pR3SPmuhqUlPDn0KdftxAOxNhYhRYGtCcISohgsWQAmjE9tDDiK7JCwUfJHmv6nC1
	 J4jo61axLnnODXRJafyxWSS8xAFJ4vjeOGfskjvioRTMQXLUWKpAkXhvVLnezdJp2n
	 sj/jzcpJyDBfPSkrVfCE3c2sArz/jt7YQlPqa7X+qkpDe6YbFYDI+2E/eYYenwtfI6
	 xz6LUnah/HIsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 02/14] bpf: Add source and instruction
 diagnostic context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260815064612.378577-3-memxor@gmail.com>
References: <20260815064612.378577-1-memxor@gmail.com>
 <20260815064612.378577-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 07:01:26 +0000
Message-Id: <20260815070127.23BBF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The static functions `bpf_diag_source` and `bpf_diag_header` are de=
fined but never called, triggering `-Wunused-function` compiler warnings.
--

--- Patch [2]: [PATCH bpf-next v5 02/14] bpf: Add source and instruction di=
agnostic context ---
commit 6b6d98a70f5ed23a50572323329ceb65edc00d2e
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Add source and instruction diagnostic context

This commit teaches the verifier diagnostics to annotate an instruction with
BTF source line information and nearby BPF instructions. The renderer keeps
source text in a fixed-width lane and prints instructions in a stable
right-hand gutter.

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index e75753552a4dd..815aa7938b502 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
[ ... ]
> +static void bpf_diag_header(struct bpf_verifier_env *env, const char *ca=
tegory,
> +			    const char *problem)
> +{

[Severity: Low]
This isn't a bug, but are there plans to call this function later in the
patch series? It is defined as static but never called in this compilation
unit, which can trigger a -Wunused-function warning and break builds that
are compiled with -Werror.

[ ... ]
> +static void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, =
const char *label,
> +			    const char *fmt, ...)
> +{

[Severity: Low]
This isn't a bug, but this function also appears to be unused in this patch.
Could this cause the same compiler warning for unused static functions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815064612.3785=
77-1-memxor@gmail.com?part=3D2
