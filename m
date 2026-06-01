Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D3E372ED6
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342149; cv=none; b=LmRacNWr6sxHNT9dhSsUBqv5I4DMitEDw4eJr4QsZFhW9aUKMv6qJWyx1gBsu/7ybFbP6UeK2U6iW//XigQWj0ByaOcGSk4Reu8gruTQY+vtLxU/5HDYMS6yOsC8aHGoLPiYntn3Qu59aA2rU0W7xz3OR1skIEREsFjAWaDJ/Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342149; c=relaxed/simple;
	bh=ms4DBDnzqu8NoI6UgvL9mvpvNAvtOxbY/F2mv9oGSlg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=MACGfSKol6Xtt9I8hDZ8Y/2T8N2IGrQ0VMnwfDwMU6qz9zyVF9dcD3vXdAIM8fXH1J0UZptInXlZe67aP7geh+/v0KejkdUoLzJ5u71NtaZ5nPrIpW4cPGrhK0buwtxieSRzywOQtTYjIh7/9MCmxrq/BxCt8CGyTcIc0XPkYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=X+tbKUqy; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="X+tbKUqy"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1370417c01cso10067138c88.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 12:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780342147; x=1780946947; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+IgbqWeUOwO1kuGX+W1xOBsghftk6n7fxQwZY4InEY=;
        b=X+tbKUqyit06th/BSXOHlLtkD7uXgFaJRDtctLB1TEertYE4LWQ8+2RCELgXYfZQB9
         yQd2bz/9210vrT2uEepFzpSsJ86WRQ6B39o/PNUtZ2RxZ3cWIY8GULYpAfJWXUt6S1q1
         yW6L02sE8VY/ETAj+MDe01ByWktZ6JPn5eNM0iLelvn0q990QE+RQP9PybIAWUO/EwK9
         lY7ozHuNvUIm4fnekoh6971chdOXp01dCC1OiOBopjcBTSe5HOb/c2Js7tgFmzqMU3k/
         c1+/Hp+OFm+GbOmoGSIE0d96XL8O1kShjHCMxBwVWBdA1FURnxZFUtCn7li6HIeZ9W25
         3lmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780342147; x=1780946947;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+IgbqWeUOwO1kuGX+W1xOBsghftk6n7fxQwZY4InEY=;
        b=JU6HwTZGuX4e//bwy2NcsYDu8ruIaPhg3JJb/u49KtHG+b/X4oxBM765qU7WcL/PNf
         6FdGTqZDWi+JAQsOiSzISQQcH/NaziuLKqOBkcL9TJ05Gb0c/xAdTa8QVWaLiCHksKyn
         XwD5nXXdQeqgmrxOL/+gIMJj4oDDf0GfvXLr66qvaf796T4YfylcVd0zCK6a+AOQyggx
         O2QN1db6MeFndScKiZNwMY3HKcvFMA0PY7x16iPl/JsnfBqQVEQgVQqfw0rdgnAkoUm7
         g8Fij7yuw6xp9sQEogh2Zsx6ZLKFTS3KnPiPap50M7SEd2Dob51LLg/+w2+stM4gkwUR
         a5Cw==
X-Forwarded-Encrypted: i=1; AFNElJ9MO8V0Hzfv8pA9SnHFmjeGIQBuM98YNWzaO1mcoMYdGkhxW75SlvMKw0Foz1Nbj5yw6As=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg2g6P9sWFpsbI3JFhBvGDZOzRL49hUmjquHW+FxKNhiEQeSzZ
	aCVxTSWlFpJmb+jBkGcfK4kIA93Ctc5+BxlcE2t3UO6XtAV8ZjkJawAPUMpOLNB82SI=
X-Gm-Gg: Acq92OHHfEJZ85RyNXadug59x8etd971QdAllaGr+C78P12gUw8os6zKLWwNAEcG6Pw
	t6iHnwiUcIcHm6rjhEakf+becIUT34qQqVFnBvdC896GBm9iP+3Qwn7sJrk1ytjVemhIoInVkDH
	NCLFVXEElholHZBcMFiZjiW6cZeQNbBYE1G7n3oLAlLOOHBcFk6TkJvlycFhA9BmSe+Av3r5TMl
	NN+KXAvX3CYHW3cO66a9bJb+VdmwOs0sln0dpuZ8g/jU33G0g2C/i/3EMM3tNjK+ittde1Bdz8p
	nsy5w8+//E9+Or7WDlUVG1PTYUkr2Wc16gohvTlToX0g9daPgLtLlvDGz0Pk76MMVB1lP8+3Cy1
	uL1yE1JOSiia9btErS4ewl/Lbq4fdCOZ8gWoVyLZ+mPgU3KjfGrug46g4I2+jyynnujlbrKlKbV
	u9h9QL5Fet/+mAgwQ=
X-Received: by 2002:a05:7022:6192:b0:132:956b:3a3 with SMTP id a92af1059eb24-137d401b909mr5140739c88.10.1780342146911;
        Mon, 01 Jun 2026 12:29:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::ceef])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137eda36ddbsm598965c88.12.2026.06.01.12.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 12:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 15:29:03 -0400
Message-Id: <DIXYM9UVP38G.11UV88Z4GBY8B@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>, <ast@kernel.org>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
 <kernel-team@fb.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC bpf-next v3 2/6] bpf: compute loops hierarchy
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
 <20260527-better-1m-reporting-v3-2-b3ede0588a75@gmail.com>
 <DIXY9HEXZK4K.3NF0E685YW1X1@etsalapatis.com>
 <42088bbac8371ae7f66f6744dd8aaa07f8f384b0.camel@gmail.com>
In-Reply-To: <42088bbac8371ae7f66f6744dd8aaa07f8f384b0.camel@gmail.com>

On Mon Jun 1, 2026 at 3:22 PM EDT, Eduard Zingerman wrote:
> On Mon, 2026-06-01 at 15:12 -0400, Emil Tsalapatis wrote:
>
> [...]
>
>> > +static int mark_header(struct bpf_verifier_env *env, int h)
>>=20
>> Maybe a more descriptive name? Not sure what we are marking the header
>> as.
>
> The idea is to mark instruction at index 'h' as a header, hence mark_head=
er().
> Can change to 'mark_as_header()', open to other suggestions.
> I'll add a comment on how this is different from assign_header()
> (which restores hierarchy, as far as I remember).
>

mark_as_header() sounds much better, thanks.

>> > +{
>> > +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
>> > +
>> > +	if (!aux[h].loop) {
>> > +		aux[h].loop =3D kvzalloc_obj(struct bpf_loop, GFP_KERNEL_ACCOUNT);
>> > +		if (!aux[h].loop)
>> > +			return -ENOMEM;
>> > +	}
>> > +	return 0;
>> > +}
>> > +
>> > +static int assign_header(struct bpf_verifier_env *env, struct loops_d=
fs *dfs, int n, int h)
>> > +{
>> > +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
>> > +	int *dfs_pos =3D dfs->dfs_pos;
>> > +	int err, nh;
>> > +
>> > +	err =3D mark_header(env, h);
>> > +	if (err)
>> > +		return err;
>> > +
>> > +	/* Don't encode self-loops, otherwise can't reflect loops nesting st=
ructure. */
>> > +	if (n =3D=3D h)
>> > +		return 0;
>> > +
>> > +	/* Make sure that loop headers up the chain are sorted by dfs_pos. *=
/
>> > +	while (aux[n].loop_header !=3D -1) {
>> > +		nh =3D aux[n].loop_header;
>> > +		if (nh =3D=3D h)
>> > +			return 0;
>> > +		if (dfs_pos[nh] < dfs_pos[h]) {
>> > +			aux[n].loop_header =3D h;
>> > +			n =3D h;
>> > +			h =3D nh;
>> > +		} else {
>> > +			n =3D nh;
>> > +		}
>> > +	}
>> > +	aux[n].loop_header =3D h;
>> > +	return 0;
>> > +}
>> > +
>> > +/*
>> > + * As described in "A New Algorithm for Identifying Loops in Decompil=
ation" by Wei et al,
>> > + * adapted to be non-recursive.
>> > + */
>> > +static int compute_loops_in_subprog(struct bpf_verifier_env *env, str=
uct loops_dfs *dfs,
>> > +				    int subprog_idx)
>> > +{
>> > +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
>> > +	struct dfs_state *state =3D dfs->state;
>> > +	int start =3D env->subprog_info[subprog_idx].start;
>> > +	int *dfs_pos =3D dfs->dfs_pos;
>> > +	int *stack =3D dfs->stack;
>> > +	int i, s, h, err, cur, stack_sz;
>> > +	struct bpf_iarray *succ;
>> > +
>> > +	stack[0] =3D start;
>> > +	state[start].traversed =3D true;
>> > +	state[start].next_succ =3D 0;
>> > +	dfs_pos[start] =3D 1;
>> > +	stack_sz =3D 1;
>> > +	i =3D 0;
>> > +	do {
>> > +		/*
>> > +		 * The algorithm should be very fast in practice,
>> > +		 * guard against pathological inputs, just in case.
>> > +		 */
>> > +		if (i++ =3D=3D 1024) {
>> > +			i =3D 0;
>> Nit: Maybe=20
>>=20
>> if (!(++i % 1024))
>>=20
>> ?
>
> Ack.
>
>> > +			if (signal_pending(current))
>> > +				return -EAGAIN;
>> > +			cond_resched();
>> > +		}
>> > +
>> > +		cur =3D stack[stack_sz - 1];
>> > +		succ =3D bpf_insn_successors(env, cur);
>> > +		if (state[cur].next_succ =3D=3D succ->cnt) {
>> > +			dfs_pos[cur] =3D 0;
>> > +			stack_sz--;
>> > +			continue;
>> > +		}
>> > +		s =3D succ->items[state[cur].next_succ];
>> > +		if (!state[s].traversed) {
>> > +			/* Case A:  start -> ... -> cur -> s [unxplored] */
>> Typo: unxplored -> unexplored
>
> Ack.
>
>> > +			state[s].traversed =3D true;
>> > +			state[s].next_succ =3D 0;
>> > +			stack[stack_sz] =3D s;
>> > +			dfs_pos[s] =3D stack_sz + 1;
>> > +			stack_sz++;
>> > +			continue;
>> > +		}
>> > +		/* 's' is fully explored at this point */
>> > +		if (dfs_pos[s]) {
>> > +			/*
>> > +			 * start -> ... -> s -> cur --.
>> > +			 *                 ^          |
>> > +			 *                 '----------'
>> > +			 * Case B: 's' is in the current DFS path.
>> > +			 */
>> > +			err =3D assign_header(env, dfs, cur, s);
>> > +			if (err)
>> > +				return err;
>> > +		} else if (aux[s].loop_header =3D=3D -1) {
>> > +			/*
>> > +			 * start -> ... -> ... -> s -> ... -> end
>> > +			 *           |            ^
>> > +			 *           '---> cur ---'
>> > +			 * Case C: 's' is explored, not in the current DFS path,
>> > +			 * and not a part of any loop.
>> > +			 */
>> > +		} else if (dfs_pos[aux[s].loop_header]) {
>> > +			/*
>> > +			 *                 .----------------------.
>> > +			 *                 v                      |
>> > +			 * start -> ... -> h -> ... -> ... -> s --'
>> > +			 *                       |            ^
>> > +			 *	                 '---> cur ---'
>> > +			 * Case D: 's' is explored, not in current DFS path,
>> > +			 * but it's innermost loop header is.
>> Typo: it's -> its
>
> Ack.
>
> [...]

