Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC433263F
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788649712; cv=none; b=LkygVpCMVUCXrsRYQk8KLZbrgmSyjXJXt6RzzUG77X0vO6kkxiZ457sAJkfHW2KwEmIUW1d+wxuB1pF+m29naaaz/SRernO4YLztYUw0p/DveGzD2qU9F87XV2hABzLFm+WVYn1S7vKJWm/i/LbBWoBSZqP6LHSzdX9G7SJMZ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788649712; c=relaxed/simple;
	bh=zqqmGeWCckygJ7CEXAhibXfwZRb6STmebYboeFpmchI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rLBfiL0ohHQXX2HtRB4fbmg56GRukUzmyudr2RjWV80Aod1jKfUZkWX0Tkz2U0OKHq2Nrzzb4Maorem2WMzVUBYHT1KeNHs+JWuvaWAcIAzm5miv4W75gaw9LVVwSV5CiTlzRTcVTQBSFxYMrR1ew1KkpgGx6QVQgBb9Bl3aQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdTlfseJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdTlfseJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1851F00A3A;
	Sat,  5 Sep 2026 23:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788649711;
	bh=iUk6URweXyVEloAU41iVDtlPw6FS6e8GlB6RajzJEmw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GdTlfseJznthHcOxE6tNTHBkbZQ31pabaOhoG5IdJkgII4L2wnSfD23Fv1aL1iOgX
	 MV3HyZ87BoHwZK1Kfon3wDaWZJ7C5MfieCRcGHwZ/rpZqW6qI1XoCzG9MTI5TmXMHU
	 XhRvh6YUJ8pfa4PzlzsJdbUbVzxJAoxprdAvs9IB2qTBW499FvirVcWUH0/QeouBHI
	 8Hyb5wb4h4V7/BhPfOf9BPs587fsx0w80wyEeA+2TvR9F49OnDqBGRiVxpmobP4XvT
	 4h/EelrXSNROoWOz3GzNOiqqlZVbVnlvpv+5dR/SyclXll4bXeTojJ7WDkUh9EW10Q
	 r81PYhFWXhwpA==
Content-Type: multipart/mixed; boundary="===============4529544850695607230=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <51c890fd762298bb1e73a112953c44751f6161de741b57e9239067ed8d19d75f@mail.kernel.org>
In-Reply-To: <20260905220117.922028-6-ameryhung@gmail.com>
References: <20260905220117.922028-6-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 05/22] bpf: Rename ambiguous function argument types
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 23:08:30 +0000 (UTC)

--===============4529544850695607230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> ARG_ANYTHING does not accept just anything: check_func_arg() accepts
> an initialized scalar and rejects pointers. Rename it to ARG_SCALAR.
>
> ARG_DONTCARE is the zero-valued terminator for the fixed-size argument
> array rather than an argument whose value is ignored. Rename it to
> ARG_UNUSED and stop helper argument iteration explicitly when it
> is encountered.
>
> Also pass ARG_PTR_TO_MEM when checking a global subprogram memory
> argument instead of using the prototype terminator as a placeholder.
>
> No functional change.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

The commit message says check_func_arg() "rejects pointers" for
ARG_SCALAR (formerly ARG_ANYTHING). Is this claim complete?

Looking at kernel/bpf/verifier.c, the rejection is conditional on
allow_ptr_leaks:

    if (arg_type == ARG_SCALAR) {
        if (__is_pointer_value(env->allow_ptr_leaks, reg)) {
            verbose(env, "%s leaks addr into helper function\n",
                    reg_arg_name(env, argno));
            return -EACCES;
        }
        return 0;
    }

and __is_pointer_value() short-circuits when allow_ptr_leaks is true:

    static bool __is_pointer_value(bool allow_ptr_leaks,
                                   const struct bpf_reg_state *reg)
    {
        if (allow_ptr_leaks)
            return false;

        return is_pointer_regtype(reg->type);
    }

So a privileged program (one with allow_ptr_leaks set) can pass
PTR_TO_MAP_VALUE, PTR_TO_STACK, or other pointer types to an ARG_SCALAR
helper argument. The pointer check only applies to unprivileged programs.

The later commit in this series, a490f49b0c4e, acknowledges this
explicitly: "helpers retain their privileged ARG_SCALAR pointer-leak
behavior."

Could the commit message be more precise? Perhaps: "rejects pointers
unless the program is allowed to leak pointers" or "rejects pointers for
unprivileged programs"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33995442755
--===============4529544850695607230==--
