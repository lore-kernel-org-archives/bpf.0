Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB1A47DD58
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070506; cv=none; b=pSoailO5ywgJtYeN++W/YxeQcLR6VWd+B/qe67mCLGQQ/LoJpMz4A3IlgzOkBarIHfHVLZipAUfP3Hb3W0HfU1GqTGYzsMcEXwqxcGz3s2X4MHknPhWo4rPMMKau9Cy/e0ZcztSo+s2d1EVCwfBqYofcaKDtb0Ux36G5JrQSts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070506; c=relaxed/simple;
	bh=D0w8JR3OU7Za/9RyF4NM2qbAJQQDMQfpQpdp19t3HmQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AxGVeJwAB2LB7LsAvgLsmO1I/qXe/XhmHhF9ivT8Q5oVPvQswPUdmn6u7/a+okCCnXJlymeojeOjQETTPR2FTmsvWz4dPbRdtNwTwvJ5PPjhcvrfq9X/d/XcWBVqYMX0L5Rg5nW0Lz67Mqrr8A0cas9NrVElerAjD95AkZxqMO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCaTgogx; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCaTgogx"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1273349c56bso239155c88.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775070505; x=1775675305; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A3ab/iiGCmE4MuEkob3dAyeKEJiYiNNjinBJ0RlkEeM=;
        b=gCaTgogxQQButansowav/1ZloN1v6phvlibma1K7eLO9wJIz34Qz6VH+8g9Zac3tOj
         lUDydnHywpdsn1GB7dL4j/3YcF9h9P1kReuJv2gugrVNyD3OzA4JzKUgpOTutIji32Bz
         112sYNba9LnNMxlDBSp+2OYwluGWgIwDXvMUSJ+7L7rkE2L/yO1vdLw0vkw1uw8IRTEo
         jZDhFUiP9QnOrZmTLR9+HBrBDHJ6NPSiQce5/XlO0iNjKIIDo4ozdczi1nOF5h081rXL
         7LBw0tXpEmI9+6M5MGQ1e6GFYDECBfTJS29RInoclPy73ASdcHkl5ocKHjh+/cFbyD8c
         u4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775070505; x=1775675305;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3ab/iiGCmE4MuEkob3dAyeKEJiYiNNjinBJ0RlkEeM=;
        b=EDN6tCKUcwk8CA41y4cHV+xXXoWeEXvOlzfDJwEHHBIhgDCvxu0vXEVizn8yGoOeYu
         F8RkptcF4I4WhmmCq8WuPLDOtaOgYTolLt9wXlCtuvxuyt8iWabwtX+/0IiFb872wuSv
         wu7+hoyuWxcaCdBjiIeT5l0kcn8DsBNztK4Xjb7D3eXcwY5F1AybdXUlJeTajlsK8vCm
         5VPezGS4pNNBC+iU/JDDQ4PkfRzCrvvhJeYoI0GIWrryPhujgypAifcJmGzouPZgswrB
         YlTZysRaXRnJC/708g06+OxeGYhcwFgOGDqCcdGpHNO9h7tvhMlwElFDNTIcoQfORkt8
         NaNg==
X-Forwarded-Encrypted: i=1; AJvYcCXY/Q0rEbwtuo8HL6jHu2da9/Pn3wRf74K7YLOM5ejgBNklVZFSXl/2lx/sYK6FEIfDoFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWsYXIAgHtEQfcfJ4fK/GLIjLsk989ZREzi3wz6OX7cem3BSgG
	G9me6T28/nO0EMDtxHOunSWhSrykAnmdtdomYfmh7neZHPuadnvvA4J/
X-Gm-Gg: ATEYQzww93iP214O5cBm/uxsTqbyczfvkrlWTy66QjgFR6jLuewkwarQdI/xR6IwU4x
	PUfEXIMF4aBYy/iSybcrKHgX2QMBtAiTBa2JQJtQnXorOJb1ziGb0HZgoTpLue4eISEuXmsu8lR
	TC21LiPMZ0l2b93OjH9bO4U7IM26Eq6bFdC3OQd8XxtHEaSeCqKiP+cIDqdrk0z6hEVempxRbhp
	bA8RLyCTbvcLrJ02VVP3jZRfUvRMG+gtAJ1xZIAp54H8J6yE+pR2EyrImvYidwLgKdD9/C/S/GV
	q5Wf84hcei+55FTNLsueOrkVzva7Zwff4W4mBktWJRhfb91V7y9LaYLLl5mlxfXuEXJrhaS6yHf
	6Rl6ZyGdarb4RPY147G8YUYxOgmfPZdT0Divq+vGTk0bc4RUsRoIO0atDMaAZKFZ/bkOuE0IZOQ
	rJS8MWpw1hgY+lpYKJdXmbicPz8/uuAptw1cUqX80G29gLkNrGcLcnu3sKRkTeKa11tNBNQq2oA
	PbJ1i4u
X-Received: by 2002:a05:7022:2508:b0:123:2d38:928e with SMTP id a92af1059eb24-12be653cdf3mr2430885c88.35.1775070504488;
        Wed, 01 Apr 2026 12:08:24 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:7aba:8184:a91b:bf1f? ([2620:10d:c090:500::3:f883])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bedd920b9sm477035c88.8.2026.04.01.12.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 12:08:24 -0700 (PDT)
Message-ID: <32efe62013c49a332fc1c6ae6e4690a2f271b92f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 6/6] bpf: Add helper and kfunc stack access
 size resolution
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com
Date: Wed, 01 Apr 2026 12:08:22 -0700
In-Reply-To: <20260401021635.34636-7-alexei.starovoitov@gmail.com>
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
	 <20260401021635.34636-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-31 at 19:16 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> The static stack liveness analysis needs to know how many bytes a
> helper or kfunc accesses through a stack pointer argument, so it can
> precisely mark the affected stack slots as stack 'def' or 'use'.
>=20
> Add bpf_helper_stack_access_bytes() and bpf_kfunc_stack_access_bytes()
> which resolve the access size for a given call argument.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

(Please see below, I think a few cases can be slightly improved).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct b=
pf_insn *insn,
> +				  int arg, int insn_idx)
> +{

[...]

> +	case ARG_PTR_TO_MEM:
> +		if (at & MEM_FIXED_SIZE) {
> +			size =3D fn->arg_size[arg];
> +			goto out;
> +		}
> +		if (arg + 1 < ARRAY_SIZE(fn->arg_type) &&
> +		    arg_type_is_mem_size(fn->arg_type[arg + 1])) {
> +			int size_reg =3D BPF_REG_1 + arg + 1;
> +
> +			if (aux->const_reg_mask & BIT(size_reg)) {
> +				size =3D (s64)aux->const_reg_vals[size_reg];
> +				goto out;

if `at & MEM_WRITE`, I think it would be correct to `return 0;` here.

> +			}
> +			/*
> +			 * Size arg is const on each path but differs across
> +			 * merged paths.  512 is a safe upper bound for reads.
> +			 */
> +			if (at & MEM_UNINIT)
> +				return S64_MIN;
> +			return 512;

Nit: `return MAX_BPF_STACK;`

> +		}
> +		return S64_MIN;
> +	case ARG_PTR_TO_DYNPTR:
> +		return BPF_DYNPTR_SIZE;
> +	case ARG_PTR_TO_STACK:
> +		/*
> +		 * Only used by bpf_calls_callback() helpers. The helper itself
> +		 * doesn't access stack. The callback subprog does and it's
> +		 * analyzed separately.
> +		 */
> +		return 0;
> +	default:
> +		return S64_MIN;
> +	}
> +out:
> +	/*
> +	 * MEM_UNINIT args are write-only: the helper initializes the
> +	 * buffer without reading it.
> +	 */
> +	if (size > 0 && at & MEM_UNINIT)
> +		return -size;

Same question about MEM_WRITE here, might be possible to `return 0` in
some cases.

> +	return size;
> +}

[...]
