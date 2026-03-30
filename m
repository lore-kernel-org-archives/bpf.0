Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F183C9453;
	Mon, 30 Mar 2026 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871247; cv=none; b=o+mxhhgGSPjAd0vIUQBatzOXkfK3SIRS7PruA+lQ96nAL3gSapgpaC3/G6Y6rpz6QS+FzCBT4LtkL/VyiEV+yz5HAaL1NuaxXp81y19/E6NoMJb4z9Wiw8OccThgInf9BFJmNMx6ItlimRM+PJLHTPPFESCC1OyLCh5diQI78JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871247; c=relaxed/simple;
	bh=WEMKIeHZ724u6rP6iwEPboq1Qx2piqn13mD0Got0lBc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Hm5C5Cfc7TjTeiqXTJBG6imWGYHktBxj5Oh7hYtOIkddR5XQPGMglm0T/JH0jnPqzkvaZ+ztcTyiThFDtkLrLjfJJMlVXvkyjBkRtI6uR7JWPgUj26RpofJZj0ck6OngRo8npXPru1+WZY5pukXbkA15B/CQzFpZsof0SFBX4HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtXazfOc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtXazfOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE6FC4CEF7;
	Mon, 30 Mar 2026 11:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774871247;
	bh=WEMKIeHZ724u6rP6iwEPboq1Qx2piqn13mD0Got0lBc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=DtXazfOcDp/Yv+uWg/YMZ+fd862B+1BMAEuvxzIlk+MgSsWpEvC3ljLVHeH6KU/rg
	 Uh4yoNWbOT6KetTSmG1WZklnfxnN61Cjj01NoaHZ0ruzxpw7HcFuUG4cTnk3xOZ9T8
	 JYGTCrjfvnN5GPsK5Bb1R5KrUpTht66tBzNr0baotKuD3UaIe6rtht+7Pml4sfpe7E
	 sCO2uzZdGhcqwrbjarmixlVk4a1FjIhl5IbODR1Pf8y4IILWB2edXJucu2jH5AJfjV
	 o49NO+KV7mbClWXCOxMPEiYynr26Hffnc7QyqPQ9mHievWeN7VSTcNC2BPK26oYXUF
	 CsnxNEN6Dz3NA==
Content-Type: multipart/mixed; boundary="===============7669256081677238455=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d5f1a4484d26fbff3aaafd358025dffeb2ba3cbff9c35c1643e4b0ab503201d6@mail.kernel.org>
In-Reply-To: <20260330110019.549079-4-varunrmallya@gmail.com>
References: <20260330110019.549079-4-varunrmallya@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 3/3] libbpf: Auto-upgrade kprobes to multi-kprobes when supported
From: bot+bpf-ci@kernel.org
To: varunrmallya@gmail.com,andrii@kernel.org,alan.maguire@oracle.com,yonghong.song@linux.dev,song@kernel.org,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,eddyz87@gmail.com,martin.lau@linux.dev,jolsa@kernel.org,menglong8.dong@gmail.com,puranjay@kernel.org,bjorn@kernel.org,leon.hwang@linux.dev,varunrmallya@gmail.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 30 Mar 2026 11:47:26 +0000 (UTC)

--===============7669256081677238455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 056bc50a0bbb..7b5f83ce543e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -11815,6 +11835,25 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
>  	offset = OPTS_GET(opts, offset, 0);
>  	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
>
> +	/* This provides backwards compatibility to programs using kprobe, but
> +	 * have been auto-upgraded to multi kprobe.
> +	 */
> +	if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
> +	    offset == 0 && attach_mode == PROBE_ATTACH_MODE_DEFAULT) {
> +		LIBBPF_OPTS(bpf_kprobe_multi_opts, multi_opts);
> +		const char *syms[1] = { func_name };
> +		__u64 bpf_cookie;
> +
> +		multi_opts.retprobe = OPTS_GET(opts, retprobe, false);
> +		multi_opts.syms = syms;
> +		multi_opts.cnt = 1;
> +		bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
> +		if (bpf_cookie)
> +			multi_opts.cookies = &bpf_cookie;
> +
> +		return bpf_program__attach_kprobe_multi_opts(prog, NULL, &multi_opts);
> +	}
> +
> +	legacy = determine_kprobe_perf_type() < 0;

What happens when a program was auto-upgraded to
BPF_TRACE_KPROBE_MULTI but the caller passes offset != 0 or
attach_mode == PROBE_ATTACH_MODE_LINK?

The redirect above is skipped, and the code falls through to the
perf_event path, which eventually calls bpf_link_create() with
BPF_PERF_EVENT. The kernel's bpf_prog_attach_check_attach_type()
in link_create() rejects this:

kernel/bpf/syscall.c:bpf_prog_attach_check_attach_type() {
    case BPF_PROG_TYPE_KPROBE:
        if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
            attach_type != BPF_TRACE_KPROBE_MULTI)
            return -EINVAL;
}

This affects callers of the public API
bpf_program__attach_kprobe_opts() who have a SEC("kprobe") program
that was auto-upgraded but then manually attach with offset != 0
(the get_func_ip_test.c case) or with PROBE_ATTACH_MODE_LINK (the
test_attach_probe_manual.c case). The selftests were updated to use
.single, but external users of the API would get a confusing
-EINVAL with no diagnostic.

Would it make sense to add a pr_warn here for the fallthrough case
when expected_attach_type == BPF_TRACE_KPROBE_MULTI, suggesting
SEC("kprobe.single") as a workaround? Something like:

    if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI) {
        pr_warn("prog '%s': kprobe was auto-upgraded to multi but "
                "offset or attach_mode is incompatible; "
                "use SEC(\"kprobe.single\") instead\n",
                prog->name);
        return libbpf_err_ptr(-ENOTSUP);
    }

[ ... ]

> @@ -12269,14 +12308,24 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
>  	*link = NULL;
>
>  	/* no auto-attach for SEC("kprobe") and SEC("kretprobe") */
> +	if (strcmp(prog->sec_name, "kprobe") == 0 ||
> +	    strcmp(prog->sec_name, "kretprobe") == 0 ||
> +	    strcmp(prog->sec_name, "kprobe.single") == 0 ||
> +	    strcmp(prog->sec_name, "kretprobe.single") == 0)
>  		return 0;

This isn't a bug, but the comment above still says SEC("kprobe")
and SEC("kretprobe") -- should it also mention the .single
variants now that they are handled here?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23741893093
--===============7669256081677238455==--
