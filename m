Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709037F72E
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775158704; cv=none; b=rpif4SVKVKidQgXINn0iwoRkVH8Mg6KgSFGfuePhe/tha9i55UrcMsBo2OZpuX3MnTa3LtpFsOlCEEzsnv3Tp+/R/OENR9OTHjm9KOH4dAbEn3BYrGjvsOCRxpF3wPz5Ed5UtNFUZDzAtLuW1qMJV23HhQhhP6y2uPkRM2EhrtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775158704; c=relaxed/simple;
	bh=gH1srPYnUtB99eDiaygGMvUt391mWRFrgM6G954YoEI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=opvhwCpCKl6Sj73adbVDHKDMSi189QVPRxI/yEbLt5eg8x64WI3pK746kraMhXtFgney/CHJvzz777e/4zPNrypy0SHIauHQ78f+mtmYT2lweExKPJ+l4klIhrfcE/xNX5rR3J+p/feIctT6cG7eNhHEYnH61e3dGm7w8xL+PZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx1LHpUP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx1LHpUP"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b256a4c6b5so7492305ad.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 12:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775158702; x=1775763502; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xTckKeD3brFK6cmBCQFzGboCQ4kBNeW+JHlcu0YSo2w=;
        b=Mx1LHpUPZEVINWAfCKOTThBbOOyeGOU4lEcClKXw/rWQRRguMNqBnTyREHvCgYwqOI
         JLl/iibwxKuIvA5N6aIodXCYI/i1VZXx/vcFu3ifmOfq/qleucQAtttxqKyuwfjiamhl
         Cr5EzA5mkfMwuGBFejV44VLf7bSvbRbjn3vyWL1gFGjj4urPE8+ItHOJSVHYvlNgVXaf
         BDLuBMgp+3VpKnHl7MneDUDpyhA4Cy84k89wQhCUTfW7Bt/WDqNtGfz7IHmv8RHmHm0X
         nBJeyNEpSZLja9FvOohd/3vY+g8PckIskww/+SkGz2G3/4Ba1U3SP/ftX/isTi1k/SUg
         zlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775158702; x=1775763502;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTckKeD3brFK6cmBCQFzGboCQ4kBNeW+JHlcu0YSo2w=;
        b=iEkt4FbGECECHs3pSsl8+3AItUWDhj1DOXJfUN+d36Zk8hoSGp3ZZQT+8wV6aiXRig
         Jm4ryOBc9wdMFOMb6yRFUYbu6n21kNErqhVh/a+7ylpwZP3nqjyKBK5U4jZQuCY965RJ
         n+XgPf613vBxdYiZLXs5evXA9J5VFtnVxjkHZWVoHvaufNaelO33x8AvVpvYfHlAoIFE
         U8ACkYGVsOoSXu9mvzpgO/GAapRJGhSnSHmto887nMy/RVvm841ECYyCqzzqce6L7NRt
         cg+UiFyAn6er7IZpdmQSrpw/zje93h3VBb9Ul4DrNyLZFij3WXr0HOIW1wneKQYoCtE0
         Tilg==
X-Forwarded-Encrypted: i=1; AJvYcCXefGHb9/7Hmuy6+zlhN/BQ96HZVDzYVm5RfMo4s18B5mbniQb1qQOTpBU5979Vlia7yWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ezmtzaqyC3gT/5cS1Whysp5oShRb5w8BqtISTejRJGXoZAeN
	m7+gxi98L5CzfzXdpyE9ZJgnjDfEHmS3UxYNQ2UCLwgnMMR8pvgtEHDMO4ijLOuu
X-Gm-Gg: AeBDieutGnC5363+e827QKMSpEEdL4eaUOY1PiZu6DPhsX1mbZ4zr6wp5kt7KeUUv+x
	K2bU6UVrtH6141/xGERMuqz6VAb+ty5KZAR8kpv3EXrxkQgWqXMMbo9Mlp4R2kxjkxhDOeBakGc
	qPFEWp8z2kZxomgN+GRCfWX7RD5+Cje8L4cPuC3K6+bo1EZPe+nkrq+syALipDLXGI3quyTtukR
	x4kGfqGtE+v3HwodG0e9QxGa6IO3ZSRWP7hB58gVr3+ZywRo9ZH3yT5UsQ1d1MnzSYoUAmLe0NI
	vbnCU6io8dU9mzP0SLVwN/Yw2ctZW0Jk1X9d5MfhWnkOJSqLx4bbafq47dK5Q0iiHKLr7NMUIVg
	xYzzd5GOU8f40tbaM3eocdaPHMcKQY7Wm+xTSy4/R1tIC+r1DZcH4FWR06GA2hU9CWjRWNm+Lpm
	Y/2Ae0qOM52MgAVVRroG593IskWSLe6K+nrIX222P87sylIh8YzGcy
X-Received: by 2002:a17:903:38c5:b0:2b0:49e6:9622 with SMTP id d9443c01a7336-2b2817ac962mr5242325ad.37.1775158702118;
        Thu, 02 Apr 2026 12:38:22 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478bc96sm37787545ad.33.2026.04.02.12.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 12:38:21 -0700 (PDT)
Message-ID: <a3e2bab6b8e74f27f779f3fae68e409fe90aa291.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/6] bpf: Sort subprogs in topological order
 after check_cfg()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com
Date: Thu, 02 Apr 2026 12:38:19 -0700
In-Reply-To: <20260402061744.10885-3-alexei.starovoitov@gmail.com>
References: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
	 <20260402061744.10885-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-01 at 23:17 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Add a pass that sorts subprogs in topological order so that iterating
> subprog_topo_order[] walks leaf subprogs first, then their callers.
> This is computed as a DFS post-order traversal of the CFG.
>=20
> The pass runs after check_cfg() to ensure the CFG has been validated
> before traversing and after postorder has been computed to avoid
> walking dead code.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

I disagree with assessment regarding stack of pairs being ugly.
Can be implemented as two stacks and we do it in e.g. check_cfg().
Other than that, I don't see any logical issues with the patch.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

>  include/linux/bpf_verifier.h |  2 +
>  kernel/bpf/verifier.c        | 83 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
>=20
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 090aa26d1c98..4f492eaad5c2 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -787,6 +787,8 @@ struct bpf_verifier_env {
>  	const struct bpf_line_info *prev_linfo;
>  	struct bpf_verifier_log log;
>  	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 =
for the fake and exception subprogs */
> +	/* subprog indices sorted in topological order: leaves first, callers l=
ast */
> +	int subprog_topo_order[BPF_MAX_SUBPROGS + 2];
>  	union {
>  		struct bpf_idmap idmap_scratch;
>  		struct bpf_idset idset_scratch;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8234d80b892a..c0630691c32d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3742,6 +3742,85 @@ static int check_subprogs(struct bpf_verifier_env =
*env)
>  	return 0;
>  }
> =20
> +/*
> + * Sort subprogs in topological order so that leaf subprogs come first a=
nd
> + * their callers come later. This is a DFS post-order traversal of the c=
all
> + * graph. Scan only reachable instructions (those in the computed postor=
der) of
> + * the current subprog to discover callees (direct subprogs and sync
> + * callbacks).
> + */
> +static int sort_subprogs_topo(struct bpf_verifier_env *env)
> +{
> +	struct bpf_subprog_info *si =3D env->subprog_info;
> +	int *insn_postorder =3D env->cfg.insn_postorder;
> +	struct bpf_insn *insn =3D env->prog->insnsi;
> +	int cnt =3D env->subprog_cnt;
> +	int *dfs_stack =3D NULL;
> +	int top =3D 0, order =3D 0;
> +	int i, ret =3D 0;
> +	u8 *color =3D NULL;
> +
> +	color =3D kvzalloc_objs(*color, cnt, GFP_KERNEL_ACCOUNT);
> +	dfs_stack =3D kvmalloc_objs(*dfs_stack, cnt, GFP_KERNEL_ACCOUNT);
> +	if (!color || !dfs_stack) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	/*
> +	 * DFS post-order traversal.
> +	 * Color values: 0 =3D unvisited, 1 =3D on stack, 2 =3D done.

Nit: it appears that the actual color value is never checked, only `if (col=
or[*])`.

> +	 */
> +	for (i =3D 0; i < cnt; i++) {
> +		if (color[i])
> +			continue;
> +		color[i] =3D 1;
> +		dfs_stack[top++] =3D i;
> +
> +		while (top > 0) {
> +			int cur =3D dfs_stack[top - 1];
> +			int po_start =3D si[cur].postorder_start;
> +			int po_end =3D si[cur + 1].postorder_start;
> +			bool pushed =3D false;
> +			int j;
> +
> +			for (j =3D po_start; j < po_end; j++) {
> +				int idx =3D insn_postorder[j];
> +				int callee;
> +
> +				if (!bpf_pseudo_call(&insn[idx]) && !bpf_pseudo_func(&insn[idx]))
> +					continue;
> +				callee =3D find_subprog(env, idx + insn[idx].imm + 1);
> +				if (callee < 0) {
> +					ret =3D -EFAULT;
> +					goto out;
> +				}
> +				if (color[callee])
> +					continue;
> +				color[callee] =3D 1;
> +				dfs_stack[top++] =3D callee;
> +				pushed =3D true;
> +				break;
> +			}
> +
> +			if (!pushed) {
> +				color[cur] =3D 2;
> +				env->subprog_topo_order[order++] =3D cur;
> +				top--;
> +			}
> +		}
> +	}
> +
> +	if (env->log.level & BPF_LOG_LEVEL2)
> +		for (i =3D 0; i < cnt; i++)
> +			verbose(env, "topo_order[%d] =3D %s\n",
> +				i, subprog_name(env, env->subprog_topo_order[i]));
> +out:
> +	kvfree(dfs_stack);
> +	kvfree(color);
> +	return ret;
> +}
> +
>  static int mark_stack_slot_obj_read(struct bpf_verifier_env *env, struct=
 bpf_reg_state *reg,
>  				    int spi, int nr_slots)
>  {
> @@ -26274,6 +26353,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
>  	if (ret)
>  		goto skip_full_check;
> =20
> +	ret =3D sort_subprogs_topo(env);
> +	if (ret < 0)
> +		goto skip_full_check;
> +
>  	ret =3D compute_scc(env);
>  	if (ret < 0)
>  		goto skip_full_check;
