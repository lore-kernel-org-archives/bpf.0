Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57630C353
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785625875; cv=none; b=LP0cW9zbdqeWixjYNcF/ovOrLIeyBBkTS+OUM9CwF6m9A58IcGcD2XsYA9NYv93c0oIF1oLYZyq4DQu7DbznzhJw/XhndTR6nLkJR9YwsyUphiB1vis1DdqGgkBUZT27GZ9Pw73YaFrafjC3XDpKhOyDgQQAFnJdbu+Xa4qZEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785625875; c=relaxed/simple;
	bh=csCHeWSpklGF4Tza/QsGRVWdiWhl7LQuwBjqAcqOL8k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u3tgfSUmNDO3GER1JyCf9mp+y/8LE55XqKaUzQ0wElo58HgO8JTl38E17OcRYvBG8+IxyaU6Nn9VzQ/NeMdTXdX88V8j2W0g+cz2L9/fID5Hdd9UQHN1RdhOPjtJiTgnNSm55ZtGhwaabU2oWdgSOynFBmWM4dBA7PDB0WijWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2tzmxWP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2tzmxWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B711F00AC4;
	Sat,  1 Aug 2026 23:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785625874;
	bh=2coQ3bQYVRNS1xXOaiuwnCsppXmgvqXgRsA9l6hka0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j2tzmxWPdl6ArKhgDXas8i1AZHxyyXQ0SGi8dALBHz/C7raMU3l4Tu8G0sHK5ohNz
	 Lhp/J8z5oELynkE+AtkOCT5kEpHI0MNqVBQcWAxlzmiiniookGj00sW9jNKpfJqHjK
	 /YlxfbkMqBx6nGaIqAqD2eC+Kd0ERkRWvglS4gS2Y5iABK9zw0b20spGicgoJTtg3G
	 vtPILn5JxcYby9cc0opKhoELat2cepsrlZZM5kfkSBPXL6bnt2AiK8gdc0h088o17O
	 h4j11TtBKgLc6qBKE2KDRdNILlBMCu4Tdh0mFo331OBmXaGRKciFcmeAGV7xEoI/FK
	 nq2maXpRxa6kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Show more useful info in stack
 depth stats
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260801230400.850271-2-memxor@gmail.com>
References: <20260801230400.850271-1-memxor@gmail.com>
 <20260801230400.850271-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 23:11:13 +0000
Message-Id: <20260801231113.D0B711F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The new stack depth verifier log format breaks stack metrics par=
sing in the `veristat` tool.
--

--- Patch [1]: [PATCH bpf-next v1 1/3] bpf: Show more useful info in stack =
depth stats ---
commit f7cb915ff02de7a02fe7b2353a1f2d77e1852496
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Show more useful info in stack depth stats

This commit changes the output format of stack depth statistics in the BPF
verifier log. It replaces the old subprogram index-based format with a clea=
rer
name and depth format, avoiding hard-to-read sequences.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8d0635ee48c7e..51ac0a9ae3394 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18703,10 +18703,18 @@ static void print_verification_stats(struct bpf=
_verifier_env *env)
>  	if (env->log.level & BPF_LOG_STATS) {
>  		verbose(env, "verification time %lld usec\n",
>  			div_u64(env->verification_time, 1000));
> -		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
> -		for (i =3D 1; i < subprog_cnt; i++)
> -			verbose(env, "+%d", env->subprog_info[i].stack_depth);
> -		verbose(env, " max %d\n", env->max_stack_depth);
> +		verbose(env, "stack depth");
> +		for (i =3D 0; i < subprog_cnt; i++) {
> +			const char *name =3D env->subprog_info[i].name;
> +
> +			if (name && name[0])
> +				verbose(env, " %s=3D%d", name,
> +					env->subprog_info[i].stack_depth);
> +			else
> +				verbose(env, " subprog[%d]=3D%d", i,
> +					env->subprog_info[i].stack_depth);
> +		}
> +		verbose(env, " max=3D%d\n", env->max_stack_depth);

[Severity: Medium]
Does this change break the veristat tool's parsing of stack depths?

Looking at tools/testing/selftests/bpf/veristat.c in parse_verif_log(), it
appears to rely on the old format using a hardcoded string and splitting by
the plus sign:

tools/testing/selftests/bpf/veristat.c:parse_verif_log() {
    ...
    if (2 =3D=3D sscanf(cur, "stack depth %511s max %ld", stack, &s->stats[=
MAX_STACK]))
    ...
    while ((token =3D strtok_r(cnt++ ? NULL : stack, "+", &state))) {
        if (sscanf(token, "%d", &sub_stack) =3D=3D 0)
            break;
    ...
}

Since the verifier now outputs max=3D%ld instead of max %ld, and the indivi=
dual
depths are formatted as name=3Ddepth rather than numbers separated by a plus
sign, will veristat silently fail to parse STACK and MAX_STACK metrics when
processing BPF objects?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801230400.8502=
71-1-memxor@gmail.com?part=3D1
