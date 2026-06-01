Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CBB1EF36E
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341769; cv=none; b=Bm0s5NNOEZlVxL5W+HemgK2Mb5/wNPh012KkW7OnkL9kUj8LdhR6x4nF1v7ll1m8Uz/g62iZn1+qzxlHBeOC7l/a+hi/NMUt+vJ9GzKy9xc7JAi3YJHfSnMAQna2leBV7tYTI+EbPKnmxVMi9y6kVLLaPAgQ+LrlBZgTZge4nNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341769; c=relaxed/simple;
	bh=esab3XlLrJr6Ou0RxZO61NxyXDcQS7Y9eTsOI6XbXhA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KJGZe1+g1xgvXvoYzDXIZaGualTcGEMk8+V/z4SzJyRlXual78Am0XE1SKQu8ruwcETYuXCS41KfxFiX5c7s7DWX8Si+W9o6ecBldqHwSthHvr7/zYdJFNMFEwbwDlQDPactngw7LCHZa3fGBm9peIOm8a4d4t75erKDlRm935U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj+SpfPu; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj+SpfPu"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3042a388168so6018120eec.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 12:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780341768; x=1780946568; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/qkx2HdwN4Jb7bNHAandgoiwH/2U9n535AocXLSfT0M=;
        b=nj+SpfPu8CBmViKYahDlsEfVVII++9Q7cBZncdQAqEyjgSKm1k+fdRls2t9zd/7vQP
         6wJ0SCYMZnSffEDG9JKnwc0fi15+acgVrpxSLwvqWPmSgPijiGO6MpZmGayHTijXvp1t
         wD76OCcNf5/UcH4r9p1HqPu56tKtJxyp+n3A9Yf675Ep1cj+WAByB9WZFlb3c0Va8w7w
         bOnPf1tubjd8ibWANhMWTkEb2O2rSbAS/ThiWIz/blsmdAoPe+gYpWUmOoVJvWZWxdtj
         AnmCCSBdPx2aiM28nW84FIxz2/FHNbRvVVbHAakYuFixlzBe1gN0BqTuhzeWrhP5F5d6
         cmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341768; x=1780946568;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qkx2HdwN4Jb7bNHAandgoiwH/2U9n535AocXLSfT0M=;
        b=RIYGX3oigGr/puEkF0Viklo7ndpojaT9SbFCX6mtvcGKH+X5RxSAqjux4dPJjqeudG
         u7Us4VQCVPCQgzR1G0MAv/+E5QFdFCrvFEsu+z9IPpa2MM/RgCJFT63nCfGl/a4jL3N3
         nMVX/euiZrsXJ6nfLpbIamGkVYq39S5Z5yXLKI26I6sc2UEx/qNehnFqgrXshsBGsLD3
         cdlB8x6oeSwN/l+e0DC+vOPK73F9Oh/GzCh+o4YnNq44Xp5RjKtCWbut9K5H0HXAJFYL
         CSOQseaRfQLYrD6YGsn1DilKkEb99P9Wrd8KCcFhY9dM5j0cPlJW64pxWZ1rJYzWYIjV
         imog==
X-Forwarded-Encrypted: i=1; AFNElJ8lBEvQ0ui7OHOOPT1yylgornggoAqTxZZrPFHccIwyZY+obkjL1o2/KWRozQmRUwlDvYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCTTUWXz1kMHKRiqZBcioIewEk83+EkVk+E/pXhPRWyObO9XAj
	Rqd6u+D154YLfjZWRK9nauiQdvPnqWG1Gs30oKz1yOpQpyzo3a6CYAP0
X-Gm-Gg: Acq92OH/HLMeLs/jYfdNlLpg1BinLbEAJBVWM770Rjt7on/8mNNduVXjmLmXUZYVf5L
	EC2XQEgHrDXjdqbDyG/RsafC8SdSawrt0pKk21/V/FFB5maLlM7rgsNN2r612GgYHPwnEQkVob4
	22tki3hq0FZtNLfELAyDziTsGZlBKsycX3smwDU7s0POxx99w7EPdjg8ojGpHzn/OlXKjCBOKYw
	QooO6zJYAtVX61aM1bpZvJcRwaQWko9O7m5W5d5eTqv04TIsrpGSy65ChVtvaekVmlKHKiTv/b9
	v+yzTYYb5qMkvgZX77EFFB35ZBo8ReTX650Y70G19UKM4O8e8iKUOvg4jRfs76dHoAR94V3tlse
	ZGAGx5egve+uFpmpfaHsxxrMT43VvRIhe19p6vZg2WqbRSmdARvGAa6tFtUM9W/IVXyZfQZZu+d
	NqvNptNunH9dKONYe9flrUD1+fp1qOOBRFlecdRIPawEXf06+y9vzp+/UzroauGX+jdlfsDbgjo
	S7jm3l8cfraDg==
X-Received: by 2002:a05:7300:6da8:b0:2ef:1d11:18b0 with SMTP id 5a478bee46e88-30734c28e47mr397169eec.17.1780341767574;
        Mon, 01 Jun 2026 12:22:47 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:af92:b4b2:3f30:fe90? ([2620:10d:c090:500::96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c120csm9796840eec.4.2026.06.01.12.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:22:47 -0700 (PDT)
Message-ID: <42088bbac8371ae7f66f6744dd8aaa07f8f384b0.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 2/6] bpf: compute loops hierarchy
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Date: Mon, 01 Jun 2026 12:22:45 -0700
In-Reply-To: <DIXY9HEXZK4K.3NF0E685YW1X1@etsalapatis.com>
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
	 <20260527-better-1m-reporting-v3-2-b3ede0588a75@gmail.com>
	 <DIXY9HEXZK4K.3NF0E685YW1X1@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-01 at 15:12 -0400, Emil Tsalapatis wrote:

[...]

> > +static int mark_header(struct bpf_verifier_env *env, int h)
>=20
> Maybe a more descriptive name? Not sure what we are marking the header
> as.

The idea is to mark instruction at index 'h' as a header, hence mark_header=
().
Can change to 'mark_as_header()', open to other suggestions.
I'll add a comment on how this is different from assign_header()
(which restores hierarchy, as far as I remember).

> > +{
> > +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> > +
> > +	if (!aux[h].loop) {
> > +		aux[h].loop =3D kvzalloc_obj(struct bpf_loop, GFP_KERNEL_ACCOUNT);
> > +		if (!aux[h].loop)
> > +			return -ENOMEM;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int assign_header(struct bpf_verifier_env *env, struct loops_df=
s *dfs, int n, int h)
> > +{
> > +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> > +	int *dfs_pos =3D dfs->dfs_pos;
> > +	int err, nh;
> > +
> > +	err =3D mark_header(env, h);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Don't encode self-loops, otherwise can't reflect loops nesting str=
ucture. */
> > +	if (n =3D=3D h)
> > +		return 0;
> > +
> > +	/* Make sure that loop headers up the chain are sorted by dfs_pos. */
> > +	while (aux[n].loop_header !=3D -1) {
> > +		nh =3D aux[n].loop_header;
> > +		if (nh =3D=3D h)
> > +			return 0;
> > +		if (dfs_pos[nh] < dfs_pos[h]) {
> > +			aux[n].loop_header =3D h;
> > +			n =3D h;
> > +			h =3D nh;
> > +		} else {
> > +			n =3D nh;
> > +		}
> > +	}
> > +	aux[n].loop_header =3D h;
> > +	return 0;
> > +}
> > +
> > +/*
> > + * As described in "A New Algorithm for Identifying Loops in Decompila=
tion" by Wei et al,
> > + * adapted to be non-recursive.
> > + */
> > +static int compute_loops_in_subprog(struct bpf_verifier_env *env, stru=
ct loops_dfs *dfs,
> > +				    int subprog_idx)
> > +{
> > +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> > +	struct dfs_state *state =3D dfs->state;
> > +	int start =3D env->subprog_info[subprog_idx].start;
> > +	int *dfs_pos =3D dfs->dfs_pos;
> > +	int *stack =3D dfs->stack;
> > +	int i, s, h, err, cur, stack_sz;
> > +	struct bpf_iarray *succ;
> > +
> > +	stack[0] =3D start;
> > +	state[start].traversed =3D true;
> > +	state[start].next_succ =3D 0;
> > +	dfs_pos[start] =3D 1;
> > +	stack_sz =3D 1;
> > +	i =3D 0;
> > +	do {
> > +		/*
> > +		 * The algorithm should be very fast in practice,
> > +		 * guard against pathological inputs, just in case.
> > +		 */
> > +		if (i++ =3D=3D 1024) {
> > +			i =3D 0;
> Nit: Maybe=20
>=20
> if (!(++i % 1024))
>=20
> ?

Ack.

> > +			if (signal_pending(current))
> > +				return -EAGAIN;
> > +			cond_resched();
> > +		}
> > +
> > +		cur =3D stack[stack_sz - 1];
> > +		succ =3D bpf_insn_successors(env, cur);
> > +		if (state[cur].next_succ =3D=3D succ->cnt) {
> > +			dfs_pos[cur] =3D 0;
> > +			stack_sz--;
> > +			continue;
> > +		}
> > +		s =3D succ->items[state[cur].next_succ];
> > +		if (!state[s].traversed) {
> > +			/* Case A:  start -> ... -> cur -> s [unxplored] */
> Typo: unxplored -> unexplored

Ack.

> > +			state[s].traversed =3D true;
> > +			state[s].next_succ =3D 0;
> > +			stack[stack_sz] =3D s;
> > +			dfs_pos[s] =3D stack_sz + 1;
> > +			stack_sz++;
> > +			continue;
> > +		}
> > +		/* 's' is fully explored at this point */
> > +		if (dfs_pos[s]) {
> > +			/*
> > +			 * start -> ... -> s -> cur --.
> > +			 *                 ^          |
> > +			 *                 '----------'
> > +			 * Case B: 's' is in the current DFS path.
> > +			 */
> > +			err =3D assign_header(env, dfs, cur, s);
> > +			if (err)
> > +				return err;
> > +		} else if (aux[s].loop_header =3D=3D -1) {
> > +			/*
> > +			 * start -> ... -> ... -> s -> ... -> end
> > +			 *           |            ^
> > +			 *           '---> cur ---'
> > +			 * Case C: 's' is explored, not in the current DFS path,
> > +			 * and not a part of any loop.
> > +			 */
> > +		} else if (dfs_pos[aux[s].loop_header]) {
> > +			/*
> > +			 *                 .----------------------.
> > +			 *                 v                      |
> > +			 * start -> ... -> h -> ... -> ... -> s --'
> > +			 *                       |            ^
> > +			 *	                 '---> cur ---'
> > +			 * Case D: 's' is explored, not in current DFS path,
> > +			 * but it's innermost loop header is.
> Typo: it's -> its

Ack.

[...]
