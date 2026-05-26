Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AA031ED93
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792357; cv=none; b=dfD+qklBXPBMUNEiLaouvtL6U2CkLhSlmCQszJSjOggqGEdHqAPkpAtIcFk2OhcGWJPY8pc6ho+Ha2tFa0lCOjYueptzZ1x0NWcwkrJ5z9TquBqeM8nnzd64zhnI8/cGgSYfvgxy6+7+7608xRg1l1A+OYEz5SuqP5Ygdb+jvgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792357; c=relaxed/simple;
	bh=oK1QDRvM5f7kBY5FVGX3VKXC9wYIHsLcJZ2ZFsvxj2s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iuBxzRjKJ52Y0AElebWxzGWSiW1bwxeVP4hT67JjdaFn0T/HTcPSuk5d0hw7w8jp+M22rKBlN/9NX7GyaopKtWuMxcGvDuo3WIlrzEEPRwGBktBw8kezQeIC0EhiKQqArmL2yj5mt+y3WNs+6VRaZILEpLRSRp4SiyG7bkvO6zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRMcZCOp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRMcZCOp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3791F000E9;
	Tue, 26 May 2026 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779792356;
	bh=MAsuM4Q4UFn+V6ZpnrKdtLDkxsQXIyAh7M5FakTHW9s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cRMcZCOpX0fZqTjKxTu6P65+POYlMX2EsanaZ0yDpaaWfM+XyfdKn3SDYmmT87TSk
	 BYOQNYVEkINHpmcX1xi/2gichBW5ajTGaW7o97cARc3zIcG7YTDrJLxRav0HW5oThs
	 HwbYNTXDoWe/v1O6qSwW9TA8T6B8at8XEngbWozZV70Po3T5JQN3Us2WA0PNFhMFzg
	 Ccx2T3N1ZzYUhZonJcKletWQJvmI8ynY63oKXF9NHeok0SSai2m+hKjz6E68rAZozS
	 8bmqHLhl5fy/WKNOe1TgFv2z91XlyGdAMAG/dGqiY0n2wl3p52qVMKvs9boOZuN/bL
	 fAU7jw7wQ78yQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 4/6] bpf: report hot simulated callchains
 when 1M instructions limit is met
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526-better-1m-reporting-v1-4-51e4f2c59780@gmail.com>
References: <20260526-better-1m-reporting-v1-4-51e4f2c59780@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 10:45:55 +0000
Message-Id: <20260526104556.5A3791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Missing Memcg Accounting for callchain profiles
- [High] Stack buffer overflow when updating printed_subs bitmap
- [Medium] Uninitialized stack memory copied to heap in update_callchain_pr=
ofile
- [Low] Log buffer truncation due to subprogram disassemblies preceding cal=
lchain summary
- [Low] Compiler warning on 32-bit architectures due to incorrect format sp=
ecifier for ptrdiff_t
--

commit 77e8a884bb6c0c1595ff19bac7fba4cb9e4a26ac
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: report hot simulated callchains when 1M instructions limit is met
   =20
This patch introduces a mechanism to report the hottest simulated callchains
when the BPF verifier hits the 1M instruction budget. It collects and counts
callchains during verification, printing a summary and disassembly of the
relevant subprograms to help debugging.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2b3584712ad28..8eb8f1ce17c76 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -17247,6 +17247,152 @@ static int check_indirect_jump(struct bpf_verif=
ier_env *env, struct bpf_insn *in
>  	return INSN_IDX_UPDATED;
>  }
> =20
> +static void compute_callchain(struct bpf_verifier_state *st, struct bpf_=
callchain *cc)
> +{
> +	int i;
> +
> +	cc->curframe =3D st->curframe;
> +	for (i =3D 0; i <=3D st->curframe; i++)
> +		cc->insn_idx[i] =3D bpf_frame_insn_idx(st, i);
> +}
> +
> +static int update_callchain_profile(struct bpf_verifier_env *env, struct=
 bpf_verifier_state *st)
> +{
> +	struct bpf_callchain_entry *entry;
> +	struct bpf_callchain cc;
> +	u32 hash;
> +
> +	compute_callchain(st, &cc);
> +	hash =3D jhash2(cc.insn_idx, cc.curframe + 1, cc.curframe + 1);
> +	hash_for_each_possible(env->callchain_htab, entry, node, hash) {
> +		if (entry->cc.curframe =3D=3D cc.curframe &&
> +		    !memcmp(entry->cc.insn_idx, cc.insn_idx, (cc.curframe + 1) * sizeo=
f(u32))) {
> +			entry->count++;
> +			return 0;
> +		}
> +	}
> +	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);

[Severity: High]
Does this code allow an unprivileged user (or one inside a container) to
bypass memory limits?

Since the verifier allocates these callchain profiles dynamically during
verification (up to the 1M instruction budget), missing the __GFP_ACCOUNT
flag could cause large amounts of unaccounted kernel memory to be consumed,
potentially leading to an OOM condition.

> +	if (!entry)
> +		return -ENOMEM;
> +	entry->cc =3D cc;

[Severity: Medium]
Will this copy uninitialized stack memory to the heap?

In compute_callchain(), only cc.curframe and the active elements of the
cc.insn_idx array are initialized. The remainder of the array on the stack
remains uninitialized. Assigning the whole struct here copies those
uninitialized bytes, which will trigger KMSAN warnings.

> +	entry->count =3D 1;
> +	hash_add(env->callchain_htab, &entry->node, hash);
> +	return 0;
> +}

[ ... ]

> +static void print_callchain_entry(struct bpf_verifier_env *env,
> +				  struct bpf_callchain_entry *entry, int idx)
> +{
> +	struct bpf_callchain *cc =3D &entry->cc;
> +	const struct bpf_line_info *linfo;
> +	struct bpf_subprog_info *sub;
> +	int i, insn_idx;
> +
> +	verbose(env, "#%d most visited simulated stacktrace (visited %llu times=
):\n",
> +		idx, entry->count);
> +	for (i =3D 0; i <=3D cc->curframe; i++) {
> +		insn_idx =3D cc->insn_idx[i];
> +		sub =3D bpf_find_containing_subprog(env, insn_idx);
> +		linfo =3D bpf_find_linfo(env->prog, insn_idx);
> +		if (sub->name)
> +			verbose(env, "  %s/%d", sub->name, insn_idx);
> +		else
> +			verbose(env, "  subprog#%ld/%d", sub - env->subprog_info, insn_idx);

[Severity: Low]
Does this generate a compiler warning on 32-bit architectures?

The expression sub - env->subprog_info yields a ptrdiff_t. On 32-bit system=
s,
ptrdiff_t is typically int, so using %ld causes a -Wformat warning. Could t=
his
be changed to %td?

> +		if (linfo)
> +			verbose(env, " (%s:%u)",
> +				btf_name_by_offset(env->prog->aux->btf, linfo->file_name_off),
> +				BPF_LINE_INFO_LINE_NUM(linfo->line_col));
> +		verbose(env, "\n");
> +	}
> +}
> +
> +static void disasm_subprog(struct bpf_verifier_env *env, struct bpf_subp=
rog_info *sub)
> +{
> +	u32 i, end =3D (sub + 1)->start;
> +
> +	if (sub->name)
> +		verbose(env, "%s():\n", sub->name);
> +	else
> +		verbose(env, "subprog#%ld:\n", sub - env->subprog_info);

[Severity: Low]
Similar to the previous comment, does this need %td instead of %ld for the
ptrdiff_t type?

> +	env->prev_linfo =3D NULL;
> +	for (i =3D sub->start; i < end; i++) {
> +		verbose_linfo(env, i, "  ; ");
> +		verbose(env, "  %d: ", i);
> +		bpf_verbose_insn(env, &env->prog->insnsi[i]);
> +		if (bpf_is_ldimm64(&env->prog->insnsi[i]))
> +			i++;
> +	}
> +}
> +
> +/*
> + * Print several most visited simulated stack traces,
> + * and a disasembly of related subprograms.
> + */
> +static void print_hotspots(struct bpf_verifier_env *env)
> +{
> +	DECLARE_BITMAP(printed_subs, BPF_MAX_SUBPROGS) =3D {};

[Severity: High]
Does this code overflow the stack array when processing fake or exception
subprograms?

The verifier allocates extra slots for fake and exception subprograms, mean=
ing
env->subprog_cnt can reach BPF_MAX_SUBPROGS + 2. Sizing the bitmap strictly
for BPF_MAX_SUBPROGS could result in out-of-bounds stack writes in the loop
below.

> +	struct bpf_callchain_entry *top[3] =3D {};
> +	struct bpf_callchain_entry *entry;
> +	struct bpf_subprog_info *sub;
> +	int i, j, bkt, nr_top =3D 0;

[ ... ]

> +	for_each_set_bit(i, printed_subs, env->subprog_cnt) {
> +		disasm_subprog(env, &env->subprog_info[i]);
> +		verbose(env, "\n");
> +	}
> +
> +	/* Print the hot callchains */
> +	for (i =3D 0; i < nr_top; i++) {
> +		print_callchain_entry(env, top[i], i + 1);
> +		verbose(env, "\n");
> +	}
> +}

[Severity: Low]
Could printing the disassemblies first cause the callchain summary to be
truncated?

For non-trivial BPF programs, subprograms can contain thousands of
instructions. If these are printed before the hot callchains, the
user-provided log buffer might fill up completely, preventing the actual
callchain summary from being visible.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-better-1m-=
reporting-v1-0-51e4f2c59780@gmail.com?part=3D4
