Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6AF3CC338
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781903363; cv=none; b=Z7j/6HLWXE43mMKZ/jQClhhuhZjQrjp8jYInpDFOQYFlkZDJ2iUDM61IqCTvr17eUNe5qMx5Cmq42+RQxov+11M7SiU0BmcyZCu8A4jbZ5ZwBj6I4sYiotJKCyojoFhnaNjWN36XWH6dxFUfKmX8DfzXni10jnvdHWWYVRkuyuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781903363; c=relaxed/simple;
	bh=PzTL6H7WS5A5wf/GlSJm2tIYo23IYOs7RooiBX7SwY8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oAmLo1B1FD7B1xDBY7fXOeDjCIt0RMo7xmwU4cokcVrNNv0/XWBEzzfdMZzAclH6hop6SzHsg2i+EnApsswqPzJ0LvM9ekzHFDpmtfPB/cNcAOKACm7z7OmR3U9vDMuguazHcJE6EJLSstlHqgkXZAMfWer1zSYyo2MMCGIorDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE9i18Lo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE9i18Lo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1E01F000E9;
	Fri, 19 Jun 2026 21:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781903359;
	bh=AATU3yDjOaqdR/eHloDWX4ibkizOBwCuNdIRhigWa3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hE9i18LobwIG9srrjOM8dWEOs8pymbwnoh0HSU8S0kCVrfe0At0qayltqNoTtO8T9
	 J0SsYd3ZRM1QasMI6Fe35B3O7V5gnHCxG/DSr9SNWeQuCxObstp1biH+uepr6e5a+Y
	 kq9P77u4DQWjjMI0wxhWhG4KWZYNZ4bqDDms6hAspG9xORB0N74Zl/BKZy7PHygymW
	 zhx2EECXrGJEfVRr4g1TdIqCaWg1R1ZVQdQMwMmWa0Nvps8NjLKPTPp0UDTHxWVhw1
	 QYnFG/JfgRzzE6+QBwTyUHrpn+AImN2tGF8p2+nBQ6Jtx/76GJHbIHK2Q7g2iKjinP
	 akPBtTZhcUOjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 01/17] bpf: Add verifier diagnostics report
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260619205934.1312876-2-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
 <20260619205934.1312876-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 21:09:18 +0000
Message-Id: <20260619210919.0F1E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Code and commit message mismatch regarding scratch storage imple=
mentation.
- [Low] Unused static functions break the build under -Werror.
--

commit e4ecd576e6d1cc63d9f51109086546f1b4b2955b
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Add verifier diagnostics report helpers

This commit adds a small diagnostics renderer for verifier reports and wires
it into the BPF build. It provides helpers to emit a common text structure
including a failure header and reusable report sections.

> Wrap report prose at 100 columns so Reason and Suggestion text stays read=
able
> without changing source or instruction gutters. Keep reusable formatting
> scratch storage in the environment-owned diagnostics object.

[Severity: Medium]
The commit message states that formatting scratch storage is kept in the
environment-owned diagnostics object. However, looking at the patch,
bpf_diag_vprint_indented() uses kvasprintf() to dynamically allocate memory
instead of using an environment-owned scratch buffer.

It looks like struct bpf_diag_scratch is introduced in a later patch in this
series ("bpf: Add source and instruction diagnostic context"). Could the
commit message be updated to match the current patch's implementation?

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> new file mode 100644
> index 0000000000000..a18fd5aa395d6
> --- /dev/null
> +++ b/kernel/bpf/diagnostics.c
[ ... ]
> +static void bpf_diag_report_section(struct bpf_verifier_env *env,
> +				    const char *title)
> +{
> +	if (!bpf_diag_enabled(env))
> +		return;
> +
> +	bpf_diag_log(env, "\n%s:\n", title);
> +}
> +
> +static void bpf_diag_report_reason(struct bpf_verifier_env *env,
> +				   const char *fmt, ...)
> +{
> +	va_list args;
> +
> +	if (!bpf_diag_enabled(env))
> +		return;
> +
> +	bpf_diag_report_section(env, "Reason");
> +
> +	va_start(args, fmt);
> +	bpf_diag_vprint_indented(env, fmt, args);
> +	va_end(args);
> +}
> +
> +static void bpf_diag_report_suggestion(struct bpf_verifier_env *env,
> +				       const char *fmt, ...)
> +{

[Severity: Low]
Are bpf_diag_report_reason(), bpf_diag_report_suggestion(), and
bpf_diag_report_section() used anywhere in this specific patch?

Since they are defined as static but not called by any exported functions in
diagnostics.c in this commit, does this trigger a unused-function compiler
warning that breaks the build when CONFIG_WERROR is enabled?

While they are heavily utilized starting in the subsequent patches (e.g.,
"bpf: Report Verifier Internal errors"), would it be better to introduce th=
em
in the patch where they are first used to ensure every individual patch in =
the
series compiles and preserves bisectability?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619205934.1312=
876-1-memxor@gmail.com?part=3D1
