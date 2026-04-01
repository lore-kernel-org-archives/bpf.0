Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1623939BA
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077806; cv=none; b=h4X6S/lSB+bg9Kwpepmq35BLWzhrnMsYWAOQV2skcGMYBA4z/sn5wvr21yoUsDPWECV2tW4tzwKyxaTW0TQMjLRJedVjuuasv34geI/ADGc0/5AjIlfa5Gg8cqmX2soulwqirLsTOnQszCS0a2Su27DfkNeANSJlr4hWvUv3HDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077806; c=relaxed/simple;
	bh=TLTnN12gO/D6sAlPkCxCgNA8a/KMDg0G4iBXa1iJzrw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gn6cPWw88k1T6wiAqptkd9GeI3/NBMsbm18Qu4mq0qLzmhJrZbZnUJuHe0NXy9xneq2X7O8WxQjarGyMmOjY6kDTZKgc+Vpcz7RUpgqAXnql7VGhFDY/DG6fWt3wxydQqDAGVhb/oZqK0a0rxrQpB7QwWLy9GG8MUedC6WRiRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBllUlpb; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBllUlpb"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c66eafc1easo473538eec.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 14:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775077803; x=1775682603; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=msS7NzbftIb3Vca1ytgK2qsld4VQ+TNs0fqjBf3nr1Q=;
        b=hBllUlpbQORco5I2eraOLoSsyA3h2/8ZAcrod+nwsw0zT01h7L+8ghJHyyCIw7cdoc
         cw4h3/MgWGcnBpNXNkCqpe3U7JNX6znjfCRlBfHzOpdy7HUBtL6rPS8Cmp3RKdNVd5Lj
         unYRM0ahPXb0EKUWuEtleiaxD94wVn2/fpNp/VBoztw+lfpKU3D0O6gVA7rVtm6Uo2tt
         Ix0J/JZgMWV2uv4cebDoCeMe8Sslsvx/O7UrDBCmrGZETximQlrloLz4mzi2WVfZQcjD
         zm6GZ0F1w/O3iM0ocg0nkMAeRmQLqlXAIJla+ilLMSSK5tDzbgKbsSzWGhcj9A14iCLP
         LInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775077803; x=1775682603;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msS7NzbftIb3Vca1ytgK2qsld4VQ+TNs0fqjBf3nr1Q=;
        b=DclMLmbd0AL0lWgAYAnCt8aHvEZ3RKcU0znimX/GurxkWqfiqdT70ICZ6XvoGVhy0w
         Ja1nNQ6/eHOp+YyFw8s8iqA92cjV3L/zR/+6RX2vokw21Fanab1D68DsiNny/JhOPTWt
         rkEywSi8UAHWYTky8tm92Wc+PFSE7JV4D39Lb9k7CiB/UKPLqUiu6eMSRC2cSmauKiUP
         B0pywgwFsfg29DQjmQexOk/baxdqNs8cJR+bolWOajtxvxxPkwoHjv019HelPuYzbm1b
         /BU3VIbAEd+fDPsKfOV50xIvJMuZ+q5u1iSPlaoNUrJK+PuAH+Ht7SySDRpgMyYqI7/T
         1w6A==
X-Forwarded-Encrypted: i=1; AJvYcCXh8FVCfKx1FcFQCTdHx/uqfAeVHWmM5vV5w5UJCjLAoreL5I9f6XD2q1r7Afebhg4YlPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSCwJZlUmBuPGkZzCq1HJaUGHQKD4sT8I6afFLX3OESXpXgJOP
	EM+CzxrLCZpTYmgfp60rU3A2wg0exxdZ+J9nq7vxdJssKQBETTzC+oLM
X-Gm-Gg: ATEYQzyvTuXapktKUF6M3G6vChM4P884ZVSBK6WjKGUL1LAomr+dt1WmM2/8F78aWnq
	qf+bgbId4+BUwd22EnVQ0aRPiAoJasWrzvrTaPFtenUwylU2+Ta76dknh7jj21XrmQPTcFr5hwY
	po/IdTxUpfVL3TuqFFptJP6vk8KZQ+SbTYlQYGhYvQq/ZMxauGKFAxxYeMRphLTDZn/SNe7w4Re
	kJG2hj9e8Ueq8h1yh7Nfcp3x4i2zwDXAfGTXGCSrZHBHjo69ZcplFcn2HDx9OKDMd9C5zltbMHf
	lHCU+2RTxTvNHOiHtExuRvCpWwY8Nbm3EPxTtvZZw0nLGeB8HJzZejVc1RYMUZpN4dIUERO6/28
	4WupNkwm5fXrHQjb43yUWKV46HG8f1QvCIsAgUZ6DzvF8cm+JHeC0NPHeYF9sxnAwCLspqL+QxK
	BFw+hhHEE6363WpHg/S2W/avIR+PVJcX1fih2cExLREgeeA9/gUFZPjiNtMhiRgN4ZUW1Hct5yu
	6iHGLxe
X-Received: by 2002:a05:7300:ed0e:b0:2c4:ec89:be0 with SMTP id 5a478bee46e88-2c930e6bdd8mr3145912eec.9.1775077803054;
        Wed, 01 Apr 2026 14:10:03 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:7aba:8184:a91b:bf1f? ([2620:10d:c090:500::3:f883])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca79e1d331sm804397eec.13.2026.04.01.14.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 14:10:02 -0700 (PDT)
Message-ID: <8c5594573cc578240d3e55874b95a9fa4ff081f4.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: Sort subprogs in topological order
 after check_cfg()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com
Date: Wed, 01 Apr 2026 14:10:00 -0700
In-Reply-To: <4e615056-b0a7-41dc-9560-8269cd3eafcd@gmail.com>
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
	 <20260401021635.34636-3-alexei.starovoitov@gmail.com>
	 <4e615056-b0a7-41dc-9560-8269cd3eafcd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-01 at 18:06 +0100, Mykyta Yatsenko wrote:

[...]

> > +static int sort_subprogs_topo(struct bpf_verifier_env *env)
> > +{
> > +	struct bpf_subprog_info *si =3D env->subprog_info;
> > +	int *insn_postorder =3D env->cfg.insn_postorder;
> > +	struct bpf_insn *insn =3D env->prog->insnsi;
> > +	int cnt =3D env->subprog_cnt;
> > +	int *dfs_stack =3D NULL;
> > +	int top =3D 0, order =3D 0;
> > +	int i, ret =3D 0;
> > +	u8 *color =3D NULL;
> > +
> > +	color =3D kcalloc(cnt, sizeof(*color), GFP_KERNEL);
>=20
> It looks like we are using GFP_KERNEL_ACCOUNT consistently in verifier,=
=20
> should this be different?
>=20
> > +	dfs_stack =3D kmalloc_array(cnt, sizeof(*dfs_stack), GFP_KERNEL);
> > +	if (!color || !dfs_stack) {
> > +		ret =3D -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * DFS post-order traversal.
> > +	 * Color values: 0 =3D unvisited, 1 =3D on stack, 2 =3D done.
> > +	 */
> > +	for (i =3D 0; i < cnt; i++) {
> > +		if (color[i])
> > +			continue;
> > +		color[i] =3D 1;
> > +		dfs_stack[top++] =3D i;
> > +
> > +		while (top > 0) {
> > +			int cur =3D dfs_stack[top - 1];
> > +			int po_start =3D si[cur].postorder_start;
> > +			int po_end =3D si[cur + 1].postorder_start;
> > +			bool pushed =3D false;
> > +			int j;
> > +
> > +			for (j =3D po_start; j < po_end; j++) {
>=20
> Is there a chance that restarting this loop every time from po_start may=
=20
> penalize performance? For example some very big BPF program with a lot=
=20
> of different subprog calls, perhaps autogenerated.

Agree with Mykyta here, remembering the index to return to would be nice he=
re.

> > +				int idx =3D insn_postorder[j];
> > +				int callee;
> > +
> > +				if (!bpf_pseudo_call(&insn[idx]) && !bpf_pseudo_func(&insn[idx]))
> > +					continue;
> > +				callee =3D find_subprog(env, idx + insn[idx].imm + 1);
> > +				if (callee < 0) {
> > +					ret =3D -EFAULT;
> > +					goto out;
> > +				}
> > +				if (color[callee])
> > +					continue;
> > +				color[callee] =3D 1;
> > +				dfs_stack[top++] =3D callee;
> > +				pushed =3D true;
> > +				break;
> > +			}
> > +
> > +			if (!pushed) {
> > +				color[cur] =3D 2;
> > +				env->subprog_topo_order[order++] =3D cur;
> > +				top--;
> > +			}
> > +		}
> > +	}

[...]
