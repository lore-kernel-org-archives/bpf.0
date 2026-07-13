Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED77282F3F
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958554; cv=none; b=IL8yIEqSO8ZMrKxUrFrE6JOJksfnoQVt3VEQN/lMJyap8wF9hhZJWCpaPG3Nht2bwyxoPHMsA2eibVwlG6MUy3X8cINkQwx7Wr5F9u7gCK0FNtQlz+gJ0LiMQrU7tMmKMz6TOASBDP/DMppFXuVH0vFnGsIgVjhyxIWjGyEh8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958554; c=relaxed/simple;
	bh=wy5/JqLXY0Ju7btZhijoeVHTwwD6zZ/p1pW+n1V1DbY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bZTgaOBRQ8aQbJ5z3iMcKroLGw3whf85oK+yvUcUKvqaosr4xT82Spp8tkF1g0YCzVPiiIGuyhnvUteuXftLgpCzYLRIUgBIeDPI3W/GASU4yjxjagxZwqSf0YWU/1aEZ6yqjq7ysuagOFh/xvmNXtAlfy44dh+s1k3K3+NNRLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1OMGyDq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1OMGyDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90741F000E9;
	Mon, 13 Jul 2026 16:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783958553;
	bh=kkUk0SP2L94KhW+zQpnesiWF/6cC+wRjiMlARJUJ3kI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D1OMGyDqyVXPIuZu9VAJp91rLCYri9pSZwEKIMyf1XJGGj4B3ktunZRuGshoW2NEG
	 XgydThG0LIez5+e17P52KbmUUkvMbnVcdYjpdJFZNnQVJTv0hMK8u03yJOxf4tCXxz
	 LsptPspSHYwHyossqwy8ZhoMpld8kGF83GrxJsy2SDu860uJDw4sw1z4nVvXP4FQsm
	 +dLmFcFrcc+WyO1KAQybNm5F+vxan1WJF95E8ug7WKmziqbTqgVxMhK4/hXYks/Ox0
	 6/FctwZHS+aK1nR857x+7KNev92NgT88GlAhmeI+szk6cnGearQB0f9Qw0JwM1tzeO
	 sZb55/SKqUzfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 04/17] bpf: Prune verifier diagnostics when
 switching paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260713153910.2556007-5-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
 <20260713153910.2556007-5-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 16:02:32 +0000
Message-Id: <20260713160232.C90741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditional truncation of the diagnostic event log in `pop_stack=
()` destroys the diagnostic trace when the verifier encounters an error.
- [Low] The commit message inaccurately claims to add logic to record the a=
ctive branch, but this logic was already introduced in a preceding patch.
--

--- Patch [4]: [PATCH bpf-next v3 04/17] bpf: Prune verifier diagnostics wh=
en switching paths ---
commit 59e4455992c872528b5e207bc7864d38d2ea193e
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Prune verifier diagnostics when switching paths
   =20
This commit saves the diagnostic event-log position with each verifier stack
entry and resets it when a queued state is popped or after a successful
subprogram verification. It also queues diagnostic outcomes for branches and
appends them when states are popped.

> Record branch outcomes as true or false. Later reports use those events to
> show the path that reached a verifier error. For queued branches, save the
> queued outcome with the verifier stack entry and append it when that stat=
e is
> popped; record the active branch immediately before continuing.

[Severity: Low]
This isn't a bug, but the commit message states it adds logic to "record the
active branch immediately before continuing". However, looking at the code,=
 it
appears this logic was already introduced in a preceding patch and is not
actually part of this commit's diff in check_cond_jmp_op(). Should the comm=
it
message be updated to reflect only the changes made here?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -1706,8 +1710,8 @@ void bpf_free_backedges(struct bpf_scc_visit *visit)
>  	visit->backedges =3D NULL;
>  }
> =20
> -static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
> -		     int *insn_idx, bool pop_log)
> +static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx, i=
nt *insn_idx, bool pop_log,
> +		     bool activate_diag_branch)
>  {
>  	struct bpf_verifier_state *cur =3D env->cur_state;
>  	struct bpf_verifier_stack_elem *elem, *head =3D env->head;
> @@ -1723,6 +1727,12 @@ static int pop_stack(struct bpf_verifier_env *env,=
 int *prev_insn_idx,
>  	}
>  	if (pop_log)
>  		bpf_vlog_reset(&env->log, head->log_pos);
> +	bpf_diag_event_log_reset(env, head->diag_log_pos);

[Severity: High]
When a program fails verification, do_check() returns a negative error, cau=
sing
do_check_common() to call free_states().=20

free_states() loops over the remaining states, calling pop_stack() with fal=
se=20
for both pop_log and activate_diag_branch:

kernel/bpf/verifier.c:free_states() {
    ...
    while (!pop_stack(env, NULL, NULL, false, false))
        ;
    ...
}

Because bpf_diag_event_log_reset() is called unconditionally here in pop_st=
ack(),
won't this truncate or completely destroy the diagnostic trace during error
cleanup?

If the log is rolled back to the length it had when each unvisited state wa=
s=20
queued, does this result in an empty or useless diagnostic output for users=
=20
trying to debug verifier failures? Should this reset also be conditional?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713153910.2556=
007-1-memxor@gmail.com?part=3D4
