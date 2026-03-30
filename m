Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ACA3B0AEE;
	Mon, 30 Mar 2026 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871245; cv=none; b=dmq2LIfgxDB3xgcwRL+cdz13wgMR8AKN9c+PB6V5V1DVxTPD/FnEAKQU0t0DoewWR4emvG/UKjHTbKcNEZMc2ugIwEjHU6ObOd6bOQduU7j1kFEoq2zhnDqzNeBbOgvR3IjTd4Kg6vwDeyKP/NG6p+x/BGtcrTMlIIX8ooFmwzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871245; c=relaxed/simple;
	bh=clntS1H3+5oPRN7KVb5bBCyEIIGwrQTDwAc3gHvnz1c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=krvP7Dt6b4nKqbFykic1huFgG8JgO/MTYnrbS4v/+KmYIoIOFJH+G+UM4deWuFR5V+YvB3xLTiKPWMtIhNlIvMoQkHfvo44vb32mTJst8hzLCwO/m2yV54QZ1I5tlHCCnmws0biwc0yIvgHwNnYixBA0RgFQEDaAt0GYeJBZYz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9zGHmYZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9zGHmYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0123C4CEF7;
	Mon, 30 Mar 2026 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774871245;
	bh=clntS1H3+5oPRN7KVb5bBCyEIIGwrQTDwAc3gHvnz1c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=S9zGHmYZTr1Wko6gmvrRWwvkyD4op65xV0pkrTtdZlnIswauU6bPrrrxCt7kJTdoD
	 gKedcpjkZPCKVbckpWPl0HVGy7k7R8DaFU6zhkMacRqlcpWvePKFTNMsjshOzGxTXD
	 q+E/sb0fobctdmfM4Ll1dEE/yJNg3yXRD288tRs3mPTdGOef7ah4mhx10Nlm8dCW05
	 z00rW+U1BGc6NbDx/9SCwOS1r/kICger5tqpOlpPc+kdfU2eDMlEjooDQcj+xQ/lSu
	 4x9u9SbT+CFLpiuG547bB7LxnmlRzR3d9N0vUKRgakmOvXZyboKeOUUVQLmFPKzzee
	 R3r3VdhyG2GSQ==
Content-Type: multipart/mixed; boundary="===============7468880571898843358=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3ccc2ca64709f1672ed40113f9dc4bd4b988f826eeda55009ea0b7ea6f7c2d20@mail.kernel.org>
In-Reply-To: <20260330110019.549079-2-varunrmallya@gmail.com>
References: <20260330110019.549079-2-varunrmallya@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 1/3] libbpf: Auto-upgrade uprobes to multi-uprobes when supported
From: bot+bpf-ci@kernel.org
To: varunrmallya@gmail.com,andrii@kernel.org,alan.maguire@oracle.com,yonghong.song@linux.dev,song@kernel.org,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,eddyz87@gmail.com,martin.lau@linux.dev,jolsa@kernel.org,menglong8.dong@gmail.com,puranjay@kernel.org,bjorn@kernel.org,leon.hwang@linux.dev,varunrmallya@gmail.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 30 Mar 2026 11:47:24 +0000 (UTC)

--===============7468880571898843358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 9ea41f40dc82..056bc50a0bbb 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -12783,6 +12802,32 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
>  		func_offset += sym_off;
>  	}
>
> +	/* This provides backwards compatibility to programs using uprobe, but
> +	 * have been auto-upgraded to multi uprobe.
> +	 */
> +	if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI) {
> +		LIBBPF_OPTS(bpf_uprobe_multi_opts, multi_opts);
> +		unsigned long offsets[1] = {func_offset};
> +		__u64 bpf_cookie;
> +
> +		multi_opts.retprobe = OPTS_GET(opts, retprobe, false);
> +		if (offsets[0] || func_name) {
> +			multi_opts.offsets = offsets;
> +			multi_opts.cnt = 1;
> +		}

When func_offset is 0 and func_name is NULL, this condition is false
and multi_opts.offsets and multi_opts.cnt are never set. The subsequent
call to bpf_program__attach_uprobe_multi() then fails with -EINVAL
because both func_pattern and cnt are 0:

bpf_program__attach_uprobe_multi() {
    ...
    if (!func_pattern && cnt == 0)
        return libbpf_err_ptr(-EINVAL);
    ...
}

This can happen when callers use bpf_program__attach_uprobe() on an
auto-upgraded program with offset 0:

bpf_program__attach_uprobe() {
    DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, opts, .retprobe = retprobe);
    return bpf_program__attach_uprobe_opts(..., func_offset, &opts);
}

Here func_name is never set in opts. The old perf_event path handled
offset 0 without issue. Should multi_opts.offsets and multi_opts.cnt
always be set unconditionally, since offset 0 is a valid uprobe offset?

> +		if (ref_ctr_off) {
> +			multi_opts.ref_ctr_offsets = &ref_ctr_off;
> +			multi_opts.cnt = 1;
> +		}
> +		bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
> +		if (bpf_cookie) {
> +			multi_opts.cookies = &bpf_cookie;
> +			multi_opts.cnt = 1;
> +		}
> +
> +		return bpf_program__attach_uprobe_multi(prog, pid, binary_path,
> +							NULL, &multi_opts);
> +	}

[ ... ]

> @@ -12902,13 +12948,14 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
>  			else
>  				offset = 0;
>  		}
> -		opts.retprobe = strcmp(probe_type, "uretprobe") == 0 ||
> -				strcmp(probe_type, "uretprobe.s") == 0;
> -		if (opts.retprobe && offset != 0) {
> +		is_retprobe = strcmp(probe_type, "uretprobe") == 0 ||
> +			      strcmp(probe_type, "uretprobe.s") == 0;

Shouldn't this also match "uretprobe.single"? When auto-attaching
with SEC("uretprobe.single/binary:func"), sscanf sets probe_type to
"uretprobe.single", which doesn't match either "uretprobe" or
"uretprobe.s". As a result is_retprobe is false and opts.retprobe
stays false, so the program gets attached as a regular uprobe instead
of a return probe.

Something like strncmp(probe_type, "uretprobe", 9) == 0 would cover
all uretprobe variants ("uretprobe", "uretprobe.s", "uretprobe.single").

> +		if (is_retprobe && offset != 0) {
>  			pr_warn("prog '%s': uretprobes do not support offset specification\n",
>  				prog->name);
>  			break;
>  		}
> +		opts.retprobe = is_retprobe;
>  		opts.func_name = func_name;
>  		*link = bpf_program__attach_uprobe_opts(prog, -1, binary_path, offset, &opts);
>  		ret = libbpf_get_error(*link);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23741893093
--===============7468880571898843358==--
