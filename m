Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5123A874F
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742479; cv=none; b=qLK8bfGX/87PkLlKCEFXTsJAZEf4iVX8wKQt1m8frSj4cizUAGFgJJI8avZb7n/gvJRGV5J3/GgtTL9Ss9Y8/D0Th5t/7HDZPT347WC7zd4kLbV8NN9YgpQV4P9CyIaoS/ihALzEO1BYtJJl1vSVnyGyI53+WmIaEwU3xWEcvt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742479; c=relaxed/simple;
	bh=qyq7MNdnwqUS+0JzEKZYMgg7qzdExNscbIVnpXQhgkc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NowYRH612v/lo5wQOQqzR2Lei7ROMPjx6EBWdn6u+TypXO3TWP384aJFl+uGcRf5eXdyy3pWecz7xQs3FX4FQ5K5ex86DTL/4WN09p161hw3ZHEPF+a0ksuVH+qPM0d+lRAOkLdGiDVbs6I6m3JKpb44zLB+qTNzHsGSC4GJxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeSf7YkG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeSf7YkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DA51F000E9;
	Mon,  3 Aug 2026 07:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785742478;
	bh=6R6PWcXRbBN4RtttjQU9ni6Fc7FSKxu+vEZ19phxuzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LeSf7YkGKLJWqDvyVvInfcXb5rAFwzQPN/wPmaD0Uy05ruV20P69zoef0Vl7Jxifw
	 d1aOduO3YS42j8fATmKVWh0nmSg1y6rih3gWAmMxhmUlX6ydN4WR88S1dRmnmdoFqA
	 gs0XDETtkzn9ahUgYRrEMo3ZYHFPnFapR4XB6VBEKn/NlCL5VKPfOvXKt+iFXz8QKL
	 PmtotgQhutps00cLwq0/UFkxCSG1081t4hU9EKQPDVvcDJR2bb0QRKw7vIPNKF81jx
	 umWU18be5LdrwLDuPTMzBZrc+ZG9107uBOOG2zTEbx5BFVJTs/BrixPBzW38pg6RVE
	 XG3DYBpFo7Tqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Show more useful info in stack
 depth stats
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803072733.191502-2-memxor@gmail.com>
References: <20260803072733.191502-1-memxor@gmail.com>
 <20260803072733.191502-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 07:34:37 +0000
Message-Id: <20260803073437.D7DA51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch changes the verifier stack depth log format but misses=
 updating tools/testing/selftests/bpf/veristat.c, breaking its ability to r=
eport stack depth statistics.
--

--- Patch [1]: [PATCH bpf-next v4 1/3] bpf: Show more useful info in stack =
depth stats ---
commit 5ac25e38dad528d9d2648231f63d507a8cd63820
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Show more useful info in stack depth stats

This commit changes the format of the verifier's stack depth statistics
to display the maximum depth and each subprogram's depth on separate lines
with their names, instead of a single string of depths.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18777,10 +18777,15 @@ static void print_verification_stats(struct bpf=
_verifier_env *env)
>  	if (env->log.level & BPF_LOG_STATS) {
>  		verbose(env, "verification time %lld usec\n",
>  			div_u64(env->verification_time, 1000));
> -		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
> -		for (i =3D 1; i < subprog_cnt; i++)
> -			verbose(env, "+%d", env->subprog_info[i].stack_depth);
> -		verbose(env, " max %d\n", env->max_stack_depth);
> +		verbose(env, "stack depth max %d\n", env->max_stack_depth);

[Severity: Medium]
Does this change in the verifier log output also require an update to the
veristat tool?

Looking at tools/testing/selftests/bpf/veristat.c in parse_verif_log(), it
currently parses the log like this:

	if (2 =3D=3D sscanf(cur, "stack depth %511s max %ld", stack, &s->stats[MAX=
_STACK])) {

Since the patch removes the "stack depth %d...+%d max %d" format and splits
it into multiple lines ("stack depth max %d" and "stack depth subprog ..."),
it looks like veristat's sscanf will no longer match.

Could this cause veristat to silently fail to parse the statistics and repo=
rt 0
for both the MAX_STACK and STACK metrics?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803072733.1915=
02-1-memxor@gmail.com?part=3D1
