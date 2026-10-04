Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481FB397944
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791122554; cv=none; b=BrFikfTaDhCdySe2mS03ycJKPARtxXH6rzIpEm/X1JKMkFakfo3Hi+XYw2KVR3J8i1A5v4mp1P4oYRZrzvu8ruP6HPcMubshRVZhhX3LPZUqxZ/zS3/b7gKWjKxV6XndMXiBZVdLaortU4Fj8pzxIMLJ31bRekgogX3eBSuginU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791122554; c=relaxed/simple;
	bh=tzKIDAt3a4KNeQ4XjPvdxlVVGXVTjxZ0TTcTEhHX6+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g0xuPJqerp2LbK9cwMI/ZecS+xO2uuBR8+6rdLliQoNBgpHLOZNt34jLIzraNIUVzWn2h9PHgiMv4qQu1zMJ6srIgk7SbDgozayUipTYTFhL07dMjVRyPur3Zp/67LBE5WDHfjmnRaJonVTes7W6Tr1mjgCCPVestxA68uEmLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUlyw298; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUlyw298"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A211E1F000FF;
	Sun,  4 Oct 2026 14:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791122552;
	bh=1M01d+MnmFlLKJPg14yfnfW+Dql4BP34pwPIND61aSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kUlyw298+O88UFlFkp1TWA5IzyTNyDGn/pAEnjzwnjjJtYtxQ77EdwUFrdWCZ+3jo
	 o1wgU2prGlRn9h5A7bYKW8AgTdrJMsXctr+zWhTqCvztKukp7IhB6ApTEng7zoqhci
	 qLWUVmIXb6AWq+4ODKRc0R3PVwrHz6C74UMdvBxu6xLLSs3q5KWzgtPznjZoC/yaD/
	 LeEpKYMB+StOb84UM8Yhk8NRXrpPpjwy8W4HjKny7e54AMwiIXVDwa4Lk7D/WKUvjh
	 vGfHK0v22PGcHWbBrRxJD8yQbvoeXyg9x5+XLqTLWMMEaGzKsF4f4/4+ooRlPD4w2O
	 PXvWay97fwmaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 02/43] bpf: describe helper stack accesses
 with arg_access_info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261004-scev-minimal-rebase-v2-2-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
 <20261004-scev-minimal-rebase-v2-2-f6254e29fdf2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 14:02:32 +0000
Message-Id: <20261004140232.A211E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: must_write fails to discard liveness due to may_read mask
--

commit cbeee936583603e6c17220772e7f9ac86e513c50
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: describe helper stack accesses with arg_access_info

Adjust bpf_helper_stack_access_bytes() to return results as a struct
arg_access_info. The commit intends for MEM_WRITE to produce must_write
when allow_uninit_stack is true, allowing the verifier to discard
previous stack knowledge over the affected range.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -14455,18 +14455,21 @@ s64 bpf_helper_stack_access_bytes(struct bpf_ve=
rifier_env *env, struct bpf_insn
>  		return (struct arg_access_info) {};
>  	default:
> -		return S64_MIN;
> +		return info;
>  	}
>  out:
> -	/*
> -	 * Other accesses keep the previous state live, including untouched byt=
es
> -	 * of an unprivileged generic output.
> -	 */
> -	if (full_write)
> -		return -size;
> -	return size;
> +	info.size =3D min_t(u64, size, U32_MAX);
> +	info.may_read =3D !!(access_type & BPF_READ);
> +	info.may_write =3D !!(access_type & BPF_WRITE);
> +	info.must_write =3D info.may_write && exact_size && info.size !=3D U32_=
MAX;

[Severity: Medium]
When a helper uses MEM_WRITE without MEM_UNINIT, access_type evaluates to
BPF_READ | BPF_WRITE. This logic then sets both may_read and must_write to
true for the argument.

Does this accidentally defeat the intended liveness pruning optimization?

Looking at the liveness propagation equation in kernel/bpf/liveness.c
inside update_insn():

unsigned long new_before =3D (new_after[w] & ~must_write[w]) | may_read[w];

If may_read is true, the ~must_write clearing operation is overridden. As a
result, the bit is unconditionally set in new_before, and the verifier will
continue to track the state of these stack slots instead of discarding them.

> +	/* Generic unprivileged outputs retain prior initialization state. */
> +	if (!env->allow_uninit_stack && arg_type_is_raw_mem(at)) {
> +		info.may_read =3D true;
> +		info.must_write =3D false;
> +	}
> +	return info;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-scev-minim=
al-rebase-v2-0-f6254e29fdf2@gmail.com?part=3D2
