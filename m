Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3F817B506
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779827593; cv=none; b=JIcI0VLk5LZXLpdJNIlXPwUz83GhXCbjBV+opJPxp4FffxmtHprf/kPiIsDolTgs0ZSH/2COMqmoDt3Vhehwd/GTceFORIzXVqOk5G7NCRgwMRiXIBDhfxTYYPBXeFCUFf3uKWrbIPRhoycngN1H6qwlvDSaMyACkv5UBhcgJkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779827593; c=relaxed/simple;
	bh=Bnz/9cuwUbinKEmevDoJPNbz8nZ/7/TM4Z+qkzwCzM8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UtHqD7sMJzXkwoeyPfdsk9iuW9EGb4tHu5KveCse1gEKYWMRzffeumqX4LzJLXRnssSo42MeA4vff8+fDDhsAinyy7FNp31B7ZUtET7honI7U6qKCwv4+DYaX39o+Smj6altYtxEn0zWnEchULaHWbAtE9AJkuSCAeH9YL29Cgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sg7Z9tdw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sg7Z9tdw"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3684a6f3b0bso5470962a91.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 13:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779827591; x=1780432391; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cv9bHQTyuADxNVgBJ3k2ar2bjjFr5T1pZrUy6kLd1tM=;
        b=sg7Z9tdweYyQfjVybTsj9hyleVPs3rdn8FRLWKaZ8zlAA/BTOBabsOcQjUMXhLbxIv
         z9kcH3Xq2/apasd0CBxWkcGzd2sixMA5G2XDp1i7vUnJSE+hT8Oq/DGzGmyud5rCAKxa
         0zqk/m9G0fgsN9D0wa18p4DexRSAIAFU3TKFrwQ39KfxA/spXGJo8A+Gu+OsQu4FdlbI
         VDElEHSOCUVu+gU5EFcHROr8DT1SJMb2VJ2+4RRYEzPzH4huCE9IdTBnqfFr+5Qvv4NK
         ksBJvx+a+jEtICf99GJnQMluKJrx41WMY3kyOOaDWLzMXHsX+YlQtqmCGhpfZcKd1oag
         tQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779827591; x=1780432391;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cv9bHQTyuADxNVgBJ3k2ar2bjjFr5T1pZrUy6kLd1tM=;
        b=riJFLRZNHWaokfiPDOY9qA30IaQudObM/OFjjfRtjgrnAbia+gY/+oPzkeOrXAbRAg
         Ye1BQU0QalsPfHFS+aoOZvOa8VAZlEN7HTE+GsCNAvvrAmiVl4L+7wMkZcRkw+A8fefN
         MGiNvIjGM1XwZIRXZ/uXxshLfHIbJQ2e4SF0cnwdXOPEcjr+I/tzDcsWA1UsFFtvZgI+
         WwNLso5n/cq2T/2FH8MqYkzuABcz5xEuyRRMNL5HyuGCJdbiCtUKd/lhRoQDwKPAfwqo
         Z0TDlwiQ9pn5b5YcdTt3QK2npJ4Zioltm7wRbuyrn7j7qtiLi1u2We/Q6qL0rrfymR0O
         9q7g==
X-Gm-Message-State: AOJu0YweXqo0RDH+KOpaBff3B25r1tG8O/ATC4VFjvnM4qMggl1dR+CO
	VOpUtkt1SsM9PRJ5wqAkigTfYIJu/TiXSGk7AFcimpAynwmpgbwuFhUVTUhHOH6HsIM=
X-Gm-Gg: Acq92OFYeUa6+5WeMGjqpHFSzAwPemBnQQUpgt47ykdsEdyBTD6K5IuzfjkdWcY+YAV
	cazCIhmloBp0z4PPBv0U2fhOAzCrJ7oYUW9hdKeI6WkrXmNcB5CrhSXzhNTXc5rOtZ8tqKaJaww
	txUgIbGqRSumWM5ojZ5q/IsRZ7PoGMoIvuUpUdmi/GCY5GCWku2s4Q2XQzm+3+OI7W69dZVlZUl
	0OOifg0CdTjTFtklPOJwBJGkCJWFNQI92BAJ5mDmmKkbqXl18uQaNpZNKXCuSwp2qikvES5Bi10
	SoPMJU22O1Klx9r+AGP3SXEZH6jirz191yk/bHMxOp6wlUGLt/O6inwlNa9lfGWm5HP+SwcS4fI
	WXfHDZibypZtgmBQOWw7YvgFi9t71j/ATQ2IkkDqgahsMBS2VavKThcG9/4rvPGgYBAyZJzzQPO
	Sxt8FOWzXBUvex6uC0mYloVLtWZQWkO6GZcRrcKstP2yfY7r8ZpOha
X-Received: by 2002:a17:90b:54c6:b0:35f:c5b8:ef6d with SMTP id 98e67ed59e1d1-36a6ba28e46mr13920506a91.3.1779827591114;
        Tue, 26 May 2026 13:33:11 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a71dbc38fsm13684297a91.5.2026.05.26.13.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 13:33:10 -0700 (PDT)
Message-ID: <7e1941bb9ad328ffdd417764d1d97bf9168e2ef5.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 2/6] bpf: compute loops hierarchy
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Tue, 26 May 2026 13:33:07 -0700
In-Reply-To: <20260526202635.6FBC91F000E9@smtp.kernel.org>
References: <20260526-better-1m-reporting-v2-2-e7ec61c45d41@gmail.com>
	 <20260526202635.6FBC91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-26 at 20:26 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Worst-case O(N^2) algorithmic complexity in assign_header() lack=
ing cond_resched() leads to soft lockup.
> --
>=20
> commit 5ba437ec70f22b36c162a26467753448539086e8
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> bpf: compute loops hierarchy
>=20
> This commit introduces an analysis phase to the bpf verifier that compute=
s
> the loops hierarchy using a non-recursive adaptation of the Wei et al.
> algorithm. It records the innermost loop header per instruction to be use=
d
> as sampling points for callchain profiling.
>=20
> > diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
> > new file mode 100644
> > index 0000000000000..1f0b10c57957a
> > --- /dev/null
> > +++ b/kernel/bpf/loops.c
>=20
> [ ... ]
>=20
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
>=20
> [Severity: High]
> Could this while loop lead to a cpu soft lockup under specific pathologic=
al
> conditions?
>=20
> With deeply nested loops and cross-edges, it appears possible to force
> repeated O(n) traversals of this header chain for O(n) nodes without
> actually modifying the chain. Given the 1 million bpf instruction limit,
> this worst-case O(n^2) algorithmic complexity might result in a massive
> number of iterations.
>=20
> Because neither this chain traversal nor the surrounding search algorithm=
 in
> compute_loops_in_subprog() seem to call cond_resched(), does this risk
> stalling the cpu core long enough to trigger a system soft lockup or a
> local denial of service?

This is a known algorithmic trade off, favoring implementation simplicity.
Neither paper authors nor me hit the pathological case why testing
with real-life programs. Some safeguard counter can be added if people
feel paranoid.

> > +	aux[n].loop_header =3D h;
> > +	return 0;
> > +}
