Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095C34D916
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775700865; cv=none; b=qP4B1budH8GJ0HzJLtVFDALmTbPhwmezViQPSSFUcWH5q8ILhCBVSwRMGWehtJziZzmN6QsUwtPl6xs9TjJw5JnIC9PhQCaxkSgzA0kRY9bEj77VTJm3R/uDoOI/VjSGeQc0EinxRBS3Gfl7yxhl7JkI8IUT2diwJk5hmuA1gFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775700865; c=relaxed/simple;
	bh=UtJ7noyfbqI62SmpleTr+Gj/hJKs/aZP4emPV6iZLPw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BnAjWdpHp//kvCnKPOoAfdjztJWDO2Bi98KwmhqnqTZlkHOuabtizL18RR1TQIgGpmCLbPTHxdKuGy4JkQr5f8Jav3qhuCBfLtprKxSkOU6C23xBwSAh/Af+XCmNg1RYTGB3rPBtklxsuslxU/2kPBXgWiDGxPcDhYZwvBurfik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzROr6Vl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzROr6Vl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF5CC2BC87;
	Thu,  9 Apr 2026 02:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775700864;
	bh=UtJ7noyfbqI62SmpleTr+Gj/hJKs/aZP4emPV6iZLPw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=mzROr6VlS0bqAQ7Q0+8WnZ4b9cdRzu67i3VeHkZTmCYwP2WexbGxmC6PTDHJkHSJ4
	 CrJYRBTZLvq+gIbJgeAbsguuY5rUp6cNEqh37yQIQf6adfp2i4TIOttqz6FF8+Ja1K
	 tiPh8mTP2BjutfywcFfKBELB+csOPkOELoSRSF1Y0eDo3lGfnVa7mWqD2nayr7uclx
	 x6q+sGsYehfAa1aTkvFf+AGnZsNq7IWH5qDHnZdvQjuIbowchOOMvXW83KTyoWmde6
	 BkIVa0L7DzBXfckYhNy5QwE2a5arnoNaZRDrZddx1u1YC7ZVE7DJk9S3fQ1lofP8ox
	 S31ecvPLCqslQ==
Content-Type: multipart/mixed; boundary="===============7956385768880553529=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8579b8a893ff0e0759ceed3be1f0fb12655ade241da3dc0111362c67cfd5b482@mail.kernel.org>
In-Reply-To: <20260408-patch-set-v1-2-1a666e860d42@gmail.com>
References: <20260408-patch-set-v1-2-1a666e860d42@gmail.com>
Subject: Re: [PATCH bpf-next 02/14] bpf: save subprogram name in bpf_subprog_info
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  9 Apr 2026 02:14:24 +0000 (UTC)

--===============7956385768880553529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0bac5c537fad..e6c048c55899 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -3710,9 +3713,16 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
>  	 */
>  	subprog[env->subprog_cnt].start = insn_cnt;
>
> +	if (func_info) {
> +		for (i = 0; i < env->subprog_cnt; i++) {
> +			t = btf_type_by_id(btf, func_info[i].type_id);
> +			subprog[i].name = btf_name_by_offset(btf, t->name_off);
> +		}
> +	}

Could this loop read past the end of the func_info array?

The loop iterates env->subprog_cnt times, but func_info was allocated
with prog->aux->func_info_cnt entries in check_btf_func_early(). The
validation that these two counts match only happens later in
check_btf_func():

  bpf_check()
    check_btf_info_early()  -> sets func_info with func_info_cnt entries
    add_subprog_and_kfunc() -> loops subprog_cnt times over func_info[]
    check_btf_func()        -> validates func_info_cnt == subprog_cnt

If a program has more subprograms than func_info entries, func_info[i]
reads past the kvcalloc'd buffer. A garbage type_id would then go into
btf_type_by_id(), which can return NULL, and the subsequent
t->name_off would be a NULL pointer dereference.

A bounds check against prog->aux->func_info_cnt, or moving the name
population after check_btf_func(), would close the window.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24168298083
--===============7956385768880553529==--
