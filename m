Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA41343895;
	Sat, 27 Jun 2026 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782574486; cv=none; b=MgfQ9ig6u9usD1aSeJGxGhhTo0MtEVtXJypQya5Tx2eoMz4Mp0a9va43WZlK6Ba2R0n/A3Wxn1cMdBuyQf4kKx5RpsIRP+vTHuGdUMI91oC8g1oRPk9WySixEzR6B9cdxarLKS/3zBfOZAtBsSA30ImYBrWyYy23mzXnBaaKOmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782574486; c=relaxed/simple;
	bh=0vGdq8NgwzO2H6v5B16P65ceyh4e2tYedUAXiZlGuZ4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=C4RhzKaz6hsDbZ0qe2uGtB1rMi2BXvpz6Bv8rouYd/KCZcgDGtpN1Mo28nN8fVKg3Ux9b8xfmK+kPo6IIXZoXrAy9wjgtv5UomWavAnjWnkeaGYNTQTZSW63EbscwV6s/wlDSfcgnBEeWSsbwYWBrVEkBLkzs9EGajNgrwerAi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev97/phO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev97/phO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1301F00A3A;
	Sat, 27 Jun 2026 15:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782574485;
	bh=zlP9prGKQIZ/6H1WwuMlstVjGJSDj8T8CPGuCyMolqs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ev97/phOyHiAYhQ0MUd+ZHoXQoyMbEPbBHFuAPXUoyQeCpj61OJ/xcul+3ROlHwKR
	 d3dyISMwpC2UEslYssU4gQ4keibHatxv9yOlvB1xFQF255feTjeHSUQFAcvm5YEuzw
	 ko7xbvUKF4vsrOwdk6mYVTVHaDH8p1ix0HTazRQP34QziX0R/4DxjUOslZjP5MhuOp
	 /Kc3JRho0eZv11JZcrPrPDPGRi/s+TnE8ZDRvOOJVgpJuLFvGrot26Y4gilydNqOmB
	 KgeGIVD5briCHx/XfdAt+Eg9GvyVsmBl423EpRHSI6Zi40RmdgrjK95ISxgUlZYTLh
	 072OQe593wOwQ==
Content-Type: multipart/mixed; boundary="===============2409666400934983421=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2988124d82972debcfb2bba8440ffde62f148a10c792a6dc0acd42336684d204@mail.kernel.org>
In-Reply-To: <ec8e3dcd0857d4ed80151ab68be9acf01fa4d93b.1782571533.git.xukuohai@huawei.com>
References: <ec8e3dcd0857d4ed80151ab68be9acf01fa4d93b.1782571533.git.xukuohai@huawei.com>
Subject: Re: [RFC PATCH bpf-next 05/12] bpf: Collect SDT probe BTF IDs from BTF decl tags
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,jolsa@kernel.org,kpsingh@kernel.org,a.s.protopopov@gmail.com,ameryhung@gmail.com,eyal.birger@gmail.com,rongtao@cestc.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 27 Jun 2026 15:34:45 +0000 (UTC)

--===============2409666400934983421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3f8b12a1eb8b..badac128e8ad 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -6692,6 +6693,57 @@ static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struc
>  	return err;
>  }
>
> +static void sdt_collect_btf_ids(struct bpf_object *obj)
> +{
> +	int n = btf__type_cnt(obj->btf);
                                ^^^^^^^^

Can sdt_collect_btf_ids() handle an object with no BTF?

btf__type_cnt(obj->btf) dereferences obj->btf. obj->btf is NULL when
the object carries no .BTF section - stripped or built without BTF.

SDT entries come from the .bpf_sdt_notes section, which is independent of
BTF presence. An object with probe sites but stripped BTF would have
sdt_entry_cnt > 0 and obj->btf == NULL, triggering a NULL dereference
here.

Existing libbpf functions guard this explicitly:

tools/lib/bpf/libbpf.c:bpf_object_fixup_btf() {
    if (!obj->btf)
        return 0;
    n = btf__type_cnt(obj->btf);
    ...
}

Should sdt_collect_btf_ids() return early if obj->btf is NULL, leaving
btf_id as 0 (the intended value per the bpf_insn_array_value comment)?

> +	const struct btf_type *t;
> +	int i;
> +
> +	for (i = 1; i < n; i++) {

[ ... ]

> @@ -6749,6 +6801,8 @@ static int bpf_object__create_sdt_maps(struct bpf_object *obj)
>  	if (err)
>  		return err;
>
> +	sdt_collect_btf_ids(obj);
> +


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28292842584
--===============2409666400934983421==--
