Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B502F84F
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776618492; cv=none; b=j/Xh8yoatxn5k352sjbmYhGjd7xfob7RWJZ3XHivH17yki9Xod/8lbiRrlyg6gQD+bFzLcSSVl58VdUIEtsdybHiMgllJFui2jatIVSegKcYJ/nmzmuDd3suGSup0lgxj+rUBZ0tsybu3n3G3BmX4Qde0QTGEYBIprjsMZiFut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776618492; c=relaxed/simple;
	bh=179aHEH2iTddkmQXKv+WWko6WMJgBP5kwX/Rsrylszc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RtuyH9Xx9DNlTsiyYlIshwF0ye4XqIHwSeZC4F05aUEwLtMzYDWbf3swEtXbAe23Dpre4WybWWepoOM9UixXMm1m5FMlFPcT6gGVoO02Gz20sm5HjQocEhXfj/A+rjPbSu//FjJXKC7fQzl3XXFnJz8k1n4wHqtOA5kuejnqDVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3vTks/l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3vTks/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16705C2BCAF;
	Sun, 19 Apr 2026 17:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776618492;
	bh=179aHEH2iTddkmQXKv+WWko6WMJgBP5kwX/Rsrylszc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=g3vTks/lj7mEKBPxMYfGGfoncFZ4pABY4JZKlaeFc9J/rtZogN1wqJbrTdt3j4XOg
	 L/UfqjTtqJbjW5OKFwcH9hzEV6PQONdXhTwVclxM3gqcoSp3mA+01SXqgqt5YAUm6u
	 Kje0OcvMaRYKvtB2SIDDpZDQz/b+zG9/5tIyq8S94rsFiT6xGEXk59+d3Lz/0fpiZo
	 x18Y0q4cvvO3wAg25+U0lgVH3b0QOHlH0LOZt2xLYsa64V90xQC+DUNcC++oylHxuL
	 RkjhYgIfIMP7IY0d1DfD1DhknOn1mhXw9WX2M7cML4DlPyGEJVbGv+b9C0FUM+NhSX
	 +bKBo8p1QSFNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 13/17] bpf: Reject stack arguments if tail
 call reachable
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260419163422.738397-1-yonghong.song@linux.dev>
References: <20260419163422.738397-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Apr 2026 17:08:11 +0000
Message-Id: <20260419170812.16705C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The verifier incorrectly rejects perfectly valid subprograms with =
stack arguments due to an order-dependent state leak of `tail_call_reachabl=
e` during the call graph traversal.
--

commit 2677e39a30cc9fcf44cadb1927d1362ad39f7b4e
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Reject stack arguments if tail call reachable

This commit deprecates tailcalls in the presence of stack arguments,
rejecting subprograms with stack arguments if a tail call is reachable.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 13f1fd7880921..af89750498836 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -5672,14 +5677,23 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
>  	 * this info will be utilized by JIT so that we will be preserving the
>  	 * tail call counter throughout bpf2bpf calls combined with tailcalls
>  	 */
> -	if (tail_call_reachable)
> +	if (tail_call_reachable) {
>  		for (tmp =3D idx; tmp >=3D 0; tmp =3D dinfo[tmp].caller) {
>  			if (subprog[tmp].is_exception_cb) {
>  				verbose(env, "cannot tail call within exception cb\n");
>  				return -EINVAL;
>  			}
> +			if (subprog_has_stack_args(&subprog[tmp])) {
> +				verbose(env, "tail_calls are not allowed in programs with stack args=
\n");
> +				return -EINVAL;
> +			}

Can this leak the tail_call_reachable state across disjoint call graph bran=
ches?

In check_max_stack_depth_subprog(), tail_call_reachable is a local variable
that seems to act as an accumulator. If the main program first calls subpro=
gram A
(which has a tail call) and subsequently calls subprogram B (which has stack
arguments but no tail call), tail_call_reachable remains true while travers=
ing B.

When the traversal finishes subprogram B, this newly added check evaluates =
the
current call stack (main -> B). Since tail_call_reachable leaked from the m=
ain
-> A traversal, and subprogram B has stack arguments, the check would false=
ly
reject the program.

Conversely, if the bytecode is ordered so that B is called before A,
tail_call_reachable would be false while traversing B, allowing the program=
 to
load successfully.

Does this introduce an unpredictable, order-dependent functional regression?

>  			subprog[tmp].tail_call_reachable =3D true;
>  		}
> +	} else if (!idx && subprog[0].has_tail_call && subprog_has_stack_args(&=
subprog[0])) {
> +		verbose(env, "tail_calls are not allowed in programs with stack args\n=
");
> +		return -EINVAL;
> +	}
> +
>  	if (subprog[0].tail_call_reachable)
>  		env->prog->aux->tail_call_reachable =3D true;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419163316.7310=
19-1-yonghong.song@linux.dev?part=3D13
