Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E73BD637;
	Fri,  3 Apr 2026 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223334; cv=none; b=K01ffCpHRDO9+/Hyq0Rj930fm+PR3ul5KKVLpIC+wEks8f/0E5TSmks1OH0m/0U9tgwtAnVyuoytK6RLB5bpRIRgrWrkUiAVyK/lxdrlsfWn02IdhRzwpEAo5Mpq5ayZK9l700UsnjdWVeWjXYF2E0T6Df8BCsbOp9HlVaH5mss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223334; c=relaxed/simple;
	bh=Ovm9TZb/0nEL4GH7WWbcl90FXw3RSWm/2CqJCc2BVo0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YRkbTv1822zWhyboUxsPSMv/OvFmej8EqEyi/2r1EAskFzNVkh60WbbcfY42RP9ck95Cor1I9zXxsSr00/WB69uC9BFNcquL7+j0iamO1zFuLxVn9xp62BZ/NzrSp81n4eTdE3nX6riXnNgtpwr4EvQ5/R3dfYvYhGqz25qAtT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNZF/2Fp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNZF/2Fp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FEDC4CEF7;
	Fri,  3 Apr 2026 13:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775223334;
	bh=Ovm9TZb/0nEL4GH7WWbcl90FXw3RSWm/2CqJCc2BVo0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=vNZF/2Fpe77R2ecNr7ciFtlCTxufRU3gIoVKiuu1TOCR/aBoHFZxYlpbeTLQXtGel
	 f1SEYqNgk/N5J1jOQcI/5NC6OrsF+3NBoVV2NmH1ANxF4GR4Ul1W+I4FwQHYZqmCwf
	 yPM7JXsBHhYKc8RNDJMOhGK0RHN3iOJr0eiXm0PjhdCqHcdwl40WuRR4i5438pu8X+
	 PzxUKDcmn2c6fwsBquavfKbsb0jrkDk510zyJyiBCyE+QtPgUXiOLiFwG9idk+4dFA
	 MMZCT4E30IOS4YNJCALrpTT+FJNJiEfsx8V7MERGfMO2Mt/BE2BsRqC8C6V/zoZF0E
	 Y9414WMvq9wDA==
Content-Type: multipart/mixed; boundary="===============4136821603026896866=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6937abe448cc9370e4868f3148b73af303b47f96274b38da24a35aa975f3f3f3@mail.kernel.org>
In-Reply-To: <20260403124412.37449-2-varunrmallya@gmail.com>
References: <20260403124412.37449-2-varunrmallya@gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 1/3] libbpf: Auto-upgrade uprobes to multi-uprobes when supported
From: bot+bpf-ci@kernel.org
To: varunrmallya@gmail.com,bpf@vger.kernel.org,jolsa@kernel.org,leon.hwang@linux.dev,andrii@kernel.org,alan.maguire@oracle.com
Cc: ast@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,daniel@iogearbox.net,linux-kernel@vger.kernel.org,memxor@gmail.com,song@kernel.org,menglong8.dong@gmail.com,varunrmallya@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  3 Apr 2026 13:35:33 +0000 (UTC)

--===============4136821603026896866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 42bdba4efd0c..bc749b9c291e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -12812,6 +12830,27 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
>  		func_offset += sym_off;
>  	}
>
> +	/* This provides backwards compatibility to programs using uprobe, but
> +	 * have been auto-upgraded to multi uprobe.
> +	 */
> +	if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI) {
> +		LIBBPF_OPTS(bpf_uprobe_multi_opts, multi_opts);
> +		__u64 bpf_cookie;
> +
> +		multi_opts.cnt = 1;
> +		multi_opts.retprobe = OPTS_GET(opts, retprobe, false);
> +		if (func_offset || func_name)
> +			multi_opts.offsets = &func_offset;
> +		if (ref_ctr_off)
> +			multi_opts.ref_ctr_offsets = &ref_ctr_off;
> +
> +		bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
> +		if (bpf_cookie)
> +			multi_opts.cookies = &bpf_cookie;
> +
> +		return bpf_program__attach_uprobe_multi(prog, pid, binary_path,
> +							NULL, &multi_opts);
> +	}
>  	legacy = determine_uprobe_perf_type() < 0;
>  	switch (attach_mode) {
>  	case PROBE_ATTACH_MODE_LEGACY:

Should the redirect to bpf_program__attach_uprobe_multi() take attach_mode
into account?

The attach_mode field is extracted from opts earlier in this function:

    attach_mode = OPTS_GET(opts, attach_mode, PROBE_ATTACH_MODE_DEFAULT);

but the multi-uprobe redirect returns before the switch(attach_mode) is
ever reached. If a caller explicitly passes PROBE_ATTACH_MODE_LEGACY or
PROBE_ATTACH_MODE_PERF, that request is silently ignored and the
attachment goes through the multi-uprobe path regardless.

The kernel's __perf_event_set_bpf_prog() does not check
prog->expected_attach_type for KPROBE programs, so perf-event-based
attachment would still work for auto-upgraded programs if the code were
to fall through.

For example, test_attach_probe_manual() in
prog_tests/attach_probe.c calls bpf_program__attach_uprobe_opts()
with PROBE_ATTACH_MODE_LEGACY and PROBE_ATTACH_MODE_PERF on programs
using SEC("uprobe") and SEC("uretprobe") from
progs/test_attach_probe_manual.c. After auto-upgrade, these tests
would silently use multi-uprobe attachment instead of exercising the
requested attachment modes.

Would it make sense to skip the multi-uprobe redirect when attach_mode
is explicitly set to a non-default value, something like:

    if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI &&
        attach_mode == PROBE_ATTACH_MODE_DEFAULT) {

This would preserve the transparent upgrade for the common case while
still respecting explicit attachment mode requests.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23947048141
--===============4136821603026896866==--
