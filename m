Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51982EB84E
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778743979; cv=none; b=J8P98RRyCRcnT7Z88iSpsYSIXHRtXjElaijOr3/7C6gry+NgDX3MdNvqxOGIpXR7Qn5I3rqpdXs1vDb+Eeop30YuL8fLOvuWbMA5D4K2mM5m30tS8hJLxXM9qmC3mGuRYLybwyDRb2iEdwgy61VbDSYE+pDluTjbBxh6rRrPsFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778743979; c=relaxed/simple;
	bh=UMz9hUwH1uebk6Y4+VmW5vjFglRWFIXiCBiWVxZe7Kc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UuDpxGv95RTQVAIakb5TzO8bqLKOfiJw+l9v4TMJvmFNvf9TvbgCx+gzBmTrTFK5EDE8ry9yoQ82JoYUIyhHrGGJXOelCEVrFdoRD9WvgUOqySFMB+g5Idldt9Z73a3QmmcfJoKpPuVFNUq7O/kfKoXER8908Mm4FP2aApmlC48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3m+Dfa4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3m+Dfa4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6501FC2BCC6;
	Thu, 14 May 2026 07:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778743978;
	bh=UMz9hUwH1uebk6Y4+VmW5vjFglRWFIXiCBiWVxZe7Kc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=R3m+Dfa4XdROoMDboeUul+KzPdyepLe81tQecrbtGV32Lh3NewDvRXcFEyfZv2doS
	 4RwAYDQ2V163nglkDrhzUb/NnztcHwUclcl2F/Ua5JrAIYgTjrXkXYiKMVdJeHNoJu
	 iqmvWTZNlyMs5bNJPC7U6JudFFEXkBFWHIXxY2TcvIkE4/pbl9V7gSEW8Zvc9WI4gX
	 s4NPdL3rHwQiLzOgpu9KpWwd3STMCqkbwXGXV01ZPRL7XIJvWEXkUVZ9xwregpgtx0
	 ajO2sM50hiL80JbbUbR0HvHbgcvfPXNg8WjbBd90xVhq3o+zUIxYNBaDfjBpm9f3Y6
	 yoiIelZt7J/IQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Report maximum combined stack
 depth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Chaignon" <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <d3d23a0410f87f116f3bbaa98a815dbae113bda2.1778689025.git.paul.chaignon@gmail.com>
References: <d3d23a0410f87f116f3bbaa98a815dbae113bda2.1778689025.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 07:32:57 +0000
Message-Id: <20260514073258.6501FC2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] On early verifier failure, 'max_stack_depth' logs as 0, which is in=
consistent with the individual subprog stack depths shown.
--

commit 2f8f05d6e2f1d0777f2f9a6fc7f4f3d3c65baf3f
Author: Paul Chaignon <paul.chaignon@gmail.com>

bpf: Report maximum combined stack depth

This commit adds reporting for the maximum combined stack depth of BPF
programs to the verifier logs. It prints the max combined depth alongside
the per-subprog stack depths to provide a value closer to what is actually
enforced by the verifier.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 11054ad89c14d..39340a6780ebc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -18289,7 +18293,7 @@ static void print_verification_stats(struct bpf_v=
erifier_env *env)
>  		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
>  		for (i =3D 1; i < subprog_cnt; i++)
>  			verbose(env, "+%d", env->subprog_info[i].stack_depth);
> -		verbose(env, "\n");
> +		verbose(env, " max %d\n", env->max_stack_depth);

If the verifier fails early during do_check_main() or do_check_subprogs(),
the process skips check_max_stack_depth() and jumps directly to the
cleanup and logging phase.

Since env->max_stack_depth is only calculated in check_max_stack_depth(),
could this result in confusing log output on early failures where the
subprog depths are printed with a max depth of 0?

For example, it might output something like:
stack depth 16+256 max 0

Would it be better to conditionally print this value only if the max stack
depth check actually ran, or otherwise indicate that the check was
bypassed?

>  		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed=
);
>  		for (i =3D 1; i < subprog_cnt; i++)
>  			if (bpf_subprog_is_global(env, i))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1778689025.gi=
t.paul.chaignon@gmail.com?part=3D1
