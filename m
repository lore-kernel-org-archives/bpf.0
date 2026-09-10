Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E20E59220E
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066486; cv=none; b=O/JjYXNWS8lJgAU8ysJmF3m5AF+HVoqm9aDK2etYKYmIiHVlzSJojmtbFSc4QoTygsWpHYFoG2oIFN6dcCNcoWgKkv8NuK9PU9S63ydN1ecU78HKcI4D+5VX/wVgJ2Ec1WKMLYb0KuuK2uEaDJwt9z4XuPZpT2j+AlzwryIGo1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066486; c=relaxed/simple;
	bh=RmctG5NZSfYRm/FwiEf62pwo8PO0/3lzYDxKXVA4F0c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pD4/W7S+MD57ROWL2/w60vdMGV0ib67VIV/r2Zyq65U2ohnUu3tG6UjHBgfwzj2VZ1yXqHnl/iqIUrHHv+jW29uFgJjCe080/wGdCVcmW4eTzc9Zh+5VVoUXWeHb41vDn7BaP0hhCnnPV28wXH0y3DmWJv2EQl83DKgyJk0xPlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRFigFbH; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRFigFbH"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbee846deecso211434a12.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789066483; x=1789671283; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KqrkI1H7pcpPRuK+7k3BRc/EtSvLBGjZYKAlH9/o/kY=;
        b=QRFigFbH9lbvESYyobCK/WnaVs9MRYVeEaGMOv6J5Klg/0h3eJiBqZSPG6mGLH1mN1
         xWnvww1C0kKffsz9XSmTBLxgY95zcmpCtfZPKwnJfj0BaM70cKvEeX4Oa48BQwT0/10k
         GQhKp1U51eiX6BqLHuKyJCmJFmHkE7hmwek2HjhWrHpkUKV6Afj1kQpplFKSqp5Dl7rs
         WjHQDK842GW04IOjH18jmAJduzP//L5R9ovvptbHLTI6qTmna4SFCgJbbsE2XKWwdgEU
         Po0ytbMv76OZOwQP2KRLZaBig5aFJBb1U04DmnMqfG5dUGnbKOKUtoXV0rfTnQtSMIES
         MRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066483; x=1789671283;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KqrkI1H7pcpPRuK+7k3BRc/EtSvLBGjZYKAlH9/o/kY=;
        b=IQ8n/x01kopIC9PBCmnf2J2ChccVPvJmyAIP7dZZcXW1uB9FaOa013izHelWTSIYTj
         uy/rlw7OtitiMda+sXvD9EPEIF40TzlqfuAFBQ+wpCnGE0AqeKvYsJrVsA3jbEZ0THOX
         9ZVlQP1Dh/wsrDo2GYU8E1bZzBBXIbw8sIZg/8FN6HuNH0/vPegkX9hVEbAGuE5W6vNu
         odKgp2CnS3yoWOdzqROjlte4qhy3XmF3YqqIku8k6s4okZd1C5YJFSu6+jDaojJs8ITB
         yej/iwyJGSjzkhnbmPJ1F+I/mIev5/sjTjNHmuUMxfmMldVKXWpbVyyfQJ8WilbmgSei
         a/yg==
X-Forwarded-Encrypted: i=1; AKwUvBx46xS4gCdRxzCBbrt2Xw+2Wj66IBopokrSORyYGXFccoarZI+7m2BF5NACv+a9JMi1W04=@vger.kernel.org
X-Gm-Message-State: AFuF++mCADsE8Nm2mlnLWD+mTVklEmtJHnVRq1XnmhF61GOEsF1Q09zy
	JwkmSzou4VIOaz5GX/I6WpY6jPXt18OBuLIM6EdY5a3PIkFajVm3abvD
X-Gm-Gg: AYBFou3pYO80T0meS5jSomEoD/36NpZYkce/pFEpNUbMejUJ3Sa+N4NCvc8bNDaO6iC
	hpa6SeSn5vcltTdmMUhCCGi9UpnWrT8ucw3f5Y6ZF4QSKBZiuDsxb+bjSsIqG1SWmOyy03vrC97
	78BomYy4Cpn/wUTMngG89CZifenbl68xdZGK8JdyCAncBV6Go0ZObztwmNDrtCUusVLqRiaF8sg
	C3iG+X8lEQezozll24xjnyLeCRww6EJk3FiGdyu82NYJ+4U86ZRlRXczOYT+h7lfjQ4Z5jvrQaN
	IRxrnE89yF9vYIYyfgWb8LShKLrN5+Y5vZGRldTSNwxmRZuk6saV7OlPPCdVH9UTqJYpNwxC67C
	oWB98X5VvqGLqTygJbS+AW1TBy8rSkLHc2tqW40jcPX0XCkOdFMGT6ABxFuliR+YPCDfZdYrQEg
	ohbDScHFzBj0no+5h4wyLYzbM9Gjlg8k6pSQzpwpFu/i05qIDvfLvdhTpYlbM3yub45fFTSb+/R
	xdLu/zi5UZP45db36kQFveCQq5Tgl+jlUuPWVNSoDoetzs9aisoPSG10A==
X-Received: by 2002:a17:90b:164b:b0:398:9be5:b419 with SMTP id 98e67ed59e1d1-39d9c22e219mr89776a91.20.1789066483166;
        Thu, 10 Sep 2026 11:54:43 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a3ce:533a:7492:3ff3? ([2620:10d:c090:500::4:d279])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b759d0sm592951c88.7.2026.09.10.11.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:54:42 -0700 (PDT)
Message-ID: <c90de371d062295815dfff1bdeca4b15adb4a57e.camel@gmail.com>
Subject: Re: [PATCH bpf 1/6] bpf: Avoid quadratic successor rescan in
 bpf_compute_scc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: memxor@gmail.com, a.s.protopopov@gmail.com, info@starlabs.sg, 
	bpf@vger.kernel.org
Date: Thu, 10 Sep 2026 11:54:40 -0700
In-Reply-To: <20260909204035.24289-1-daniel@iogearbox.net>
References: <20260909204035.24289-1-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-09 at 22:40 +0200, Daniel Borkmann wrote:
> The iterative Tarjan DFS in bpf_compute_scc() emulates recursion with an
> explicit 'dfs' stack: when a successor has not been visited yet, the
> successor is pushed and the walk restarts at the top of the loop. On the
> way back to a vertex the successor scan starts over at index zero, so a
> vertex with k successors rescans up to k successors on each of its up to =
k
> descents, i.e. O(k^2) work.
>=20
> For ordinary instructions k <=3D 2 and this is irrelevant. For a gotox th=
e
> successors are the jump table of the containing subprogram, whose size is
> bounded only by the max_entries of the insn_array map, so k can reach the
> 1M instruction complexity limit. Loading such a program keeps a CPU busy
> in the loop for a very long time before verification even begins.
>=20
> Record in 'dfs_pos' the successor index each frame stopped at and resume
> the scan there. Each edge is therefore examined a bounded number of times
> and the walk becomes linear in the number of edges.
>=20
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Reported-by: STAR Labs SG <info@starlabs.sg>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

The change looks correct, but I'd cleanup the comments a bit,
to me these look too LLM-ish.

>  kernel/bpf/cfg.c | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 842c7d1eabcc..081f7003eae6 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -749,7 +749,7 @@ int bpf_compute_scc(struct bpf_verifier_env *env)
>  	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
>  	const u32 insn_cnt =3D env->prog->len;
>  	int stack_sz, dfs_sz, err =3D 0;
> -	u32 *stack, *pre, *low, *dfs;
> +	u32 *stack, *pre, *low, *dfs, *dfs_pos;
>  	u32 i, j, t, w;
>  	u32 next_preorder_num;
>  	u32 next_scc_id;
> @@ -762,13 +762,16 @@ int bpf_compute_scc(struct bpf_verifier_env *env)
>  	 * - 'stack' accumulates vertices in DFS order, see invariant comment b=
elow;
>  	 * - 'pre[t] =3D=3D p' =3D> preorder number of vertex 't' is 'p';
>  	 * - 'low[t] =3D=3D n' =3D> smallest preorder number of the vertex reac=
hable from 't' is 'n';
> -	 * - 'dfs' DFS traversal stack, used to emulate explicit recursion.
> +	 * - 'dfs' DFS traversal stack, used to emulate explicit recursion;
> +	 * - 'dfs_pos[k] =3D=3D j' =3D> the frame 'dfs[k]' resumes visiting its
> +	 *   successors at index 'j'.
>  	 */
>  	stack =3D kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
>  	pre =3D kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
>  	low =3D kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
>  	dfs =3D kvcalloc(insn_cnt, sizeof(*dfs), GFP_KERNEL_ACCOUNT);
> -	if (!stack || !pre || !low || !dfs) {
> +	dfs_pos =3D kvcalloc(insn_cnt, sizeof(*dfs_pos), GFP_KERNEL_ACCOUNT);
> +	if (!stack || !pre || !low || !dfs || !dfs_pos) {
>  		err =3D -ENOMEM;
>  		goto exit;
>  	}
> @@ -851,6 +854,7 @@ int bpf_compute_scc(struct bpf_verifier_env *env)
>  		stack_sz =3D 0;
>  		dfs_sz =3D 1;
>  		dfs[0] =3D i;
> +		dfs_pos[0] =3D 0;
>  dfs_continue:
>  		while (dfs_sz) {
>  			w =3D dfs[dfs_sz - 1];
> @@ -860,13 +864,37 @@ int bpf_compute_scc(struct bpf_verifier_env *env)
>  				next_preorder_num++;
>  				stack[stack_sz++] =3D w;
>  			}
> -			/* Visit 'w' successors */
> +			/*
> +			 * Visit 'w' successors, resuming at the successor this
> +			 * frame last descended into. Restarting the scan at zero
> +			 * on every return to 'w' would examine each successor
> +			 * once per descent, i.e. quadratic in the number of
> +			 * successors, which for a gotox is the size of the jump
> +			 * table.

Please drop the paragraph above, this fact was already stated in the
commit message.

> +			 *
> +			 * Re-folding the successors before that index would be a

I think "visiting" is a better term in this context.

> +			 * no-op. Such a successor 's' has 'pre[s] !=3D 0' by then,
> +			 * so it is never pushed onto 'dfs' again, and low[s] can
> +			 * only decrease while 's' is the top of 'dfs'. If 's' is
> +			 * still on 'dfs' it sits below 'w' and cannot become the
> +			 * top before 'w' is popped; otherwise the only remaining
> +			 * write to low[s] is the pop of its SCC, setting it to
> +			 * NOT_ON_STACK, for which the min below is a no-op.
> +			 */

Tbh, I find this paragraph extremely hard to parse.
Why not simply /* Visit the next 'w' successor */ ?

>  			succ =3D bpf_insn_successors(env, w);
> -			for (j =3D 0; j < succ->cnt; ++j) {
> +			for (j =3D dfs_pos[dfs_sz - 1]; j < succ->cnt; ++j) {
>  				if (pre[succ->items[j]]) {
>  					low[w] =3D min(low[w], low[succ->items[j]]);
>  				} else {
> -					dfs[dfs_sz++] =3D succ->items[j];
> +					/*
> +					 * Resume at 'j', not 'j + 1': the successor
> +					 * is revisited once its DFS completes, to
> +					 * fold its low[] into low[w].
> +					 */

/*
 * Once DFS for succ->items[j] is complete, the pre[succ->items[j]] would b=
e non-zero,
 * hence resuming at 'j' allows to follow the update low[w] =3D min(...) br=
anch above.
 */

> +					dfs_pos[dfs_sz - 1] =3D j;
> +					dfs_pos[dfs_sz] =3D 0;
> +					dfs[dfs_sz] =3D succ->items[j];
> +					dfs_sz++;
>  					goto dfs_continue;
>  				}
>  			}
> @@ -916,5 +944,6 @@ int bpf_compute_scc(struct bpf_verifier_env *env)
>  	kvfree(pre);
>  	kvfree(low);
>  	kvfree(dfs);
> +	kvfree(dfs_pos);
>  	return err;
>  }
