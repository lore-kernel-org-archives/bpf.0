Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CEE1C861D
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792203030; cv=none; b=AvrHrKh7HDobGwVOxN81hmGkOxXIotffTvzIiUl+UmthGe4NsBcvDAgklVSkaIPd5wUxZJHOB9vF18eLg5XXqGDcO/TzXJLgp54PoaSIa4p8AaKWCSTQJSusWrgLGxxmTbwZU+tQ35wi6FZAlKxLzDsVzVWUJsbmB25XkkUCWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792203030; c=relaxed/simple;
	bh=cwf9ptQjwT3QZ9NA7Fd+ZynFCsNRPvEQ2aey+sILfyY=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=HgH8a1uIv5z0sJ9NW4x3HQGkopb6TcvYiZ2udVaqCsOMVOITakRnPm4pW1b9DS1KEQSlAiTTB83ZIYdyKgWy5LzdNTfVzHbEOfY1wvru4nJkRAZujZUArvUE+eN0/43RdbsL2h1HrJT/248s5yPk/T4gu1DD06whleR2ZD4hzcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjfF27ND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjfF27ND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2261F000C4;
	Sat, 17 Oct 2026 02:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792203028;
	bh=7LhTtxPHrv/JbZb80Nj3OHXVcPrwG0W2PlA9UF3vRQw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UjfF27NDs3AL9uJJlZL2huF2vXat/1CX2cYn4ujwbKeqvWPAsC6hBk22cN5/8HsVZ
	 DjfKBI7cFKFM0Z/PJ6GlP5QjHQtQQ/H93fY+T9t4NTcBIIL+p36PBdtSF+MqznsAij
	 I8IOEalQmCCB3/5hnOzR3W3++bNvoxW5dTRE8Xypayjh6Qy5/PCKmGO6VkAFffBgFi
	 7p0O7okhPdnv5aobVDXa9sBTMqkWnPMiJsmSVO2pU48BWA+exWhgOyWks4qCQzMSbb
	 0OsWSHVhwnGpR/O0EZZMzjhJbulbZEWUD2ed03yQrqngm9JFJjqQP2TBiIhEZjnswf
	 0/SuMHhLNuHhA==
Message-ID: <sashiko-outbox-175194@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 33/38] bpf: Drop packet pointers behind kfuncs
 writing an skb
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261017012451.364800-25-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
 <20261017012451.364800-25-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 02:10:28 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: missing seen_direct_write for dynptr_write_kfuncs in check_kf=
unc_call()
--

commit 851ba1993e9264b3115b008c369c9dc215b291c2
Author: Josef Bacik <josef@toxicpanda.com>

bpf: Drop packet pointers behind kfuncs writing an skb

This commit invalidates packet pointers and skb dynptr slices when kfuncs
such as bpf_dynptr_copy(), bpf_dynptr_memset(),
bpf_probe_read_{user,kernel}[_str]_dynptr(), and
bpf_copy_from_user[_task][_str]_dynptr() write through an skb or skb_meta
dynptr.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6ee9b5c6fe477..e002728abd041 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -15625,7 +15659,9 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>  		}
>  	}
> =20
> -	if (bpf_is_kfunc_pkt_changing(&meta))
> +	if (is_kfunc_dynptr_write(&meta) ?
> +	    dynptr_write_changes_pkt_data(meta.dynptr_write_type) :
> +	    bpf_is_kfunc_pkt_changing(&meta))
>  		clear_all_pkt_pointers(env);
> =20
>  	proto_slots =3D kfunc_abi_slots(&desc->func_model);

[Severity: High]
When a kfunc in dynptr_write_kfuncs writes to a BPF_DYNPTR_TYPE_SKB or
BPF_DYNPTR_TYPE_SKB_META dynptr, does check_kfunc_call() also need to set
env->seen_direct_write (for instance via may_access_direct_pkt_data(env,
NULL, BPF_WRITE)) so that convert_ctx_accesses() emits
bpf_unclone_prologue()?

Unlike bpf_dynptr_write(), which always goes through __bpf_dynptr_write() ->
__bpf_skb_store_bytes() -> bpf_try_make_writable(), all of the kfuncs in
dynptr_write_kfuncs first try to obtain a writable slice in C via
bpf_dynptr_slice_rdwr() and write directly into it:

kernel/bpf/helpers.c:bpf_dynptr_memset() {
	...
	slice =3D bpf_dynptr_slice_rdwr(p, offset, NULL, size);
	if (likely(slice)) {
		memset(slice, val, size);
		return 0;
	}
	...
}

For linear skb data and skb metadata, bpf_dynptr_slice_rdwr() returns a
direct pointer into skb->head without uncloning the skb, relying on the
verifier having emitted bpf_unclone_prologue():

kernel/bpf/helpers.c:bpf_dynptr_slice_rdwr() {
	/*
	 * 1) The requested slice is in the head of the skb. In this case, the
	 * returned pointer is directly to skb data, and if the skb is cloned, the
	 * verifier will have uncloned it (see bpf_unclone_prologue()) already.
	 * The pointer can be directly written into.
	 */
	...
	return bpf_dynptr_slice(p, offset, buffer__nullable, buffer__szk);
}

When a program calls bpf_dynptr_slice_rdwr() directly, check_special_kfunc()
calls may_access_direct_pkt_data(env, NULL, BPF_WRITE), which sets
env->seen_direct_write =3D true. However, specialize_kfunc() restores
env->seen_direct_write to its previous value when specializing
KF_bpf_dynptr_from_skb:

kernel/bpf/verifier.c:specialize_kfunc() {
	...
	} else if (func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_from_skb]) {
		seen_direct_write =3D env->seen_direct_write;
		is_rdonly =3D !may_access_direct_pkt_data(env, NULL, BPF_WRITE);

		if (is_rdonly)
			addr =3D (unsigned long)bpf_dynptr_from_skb_rdonly;

		/* restore env->seen_direct_write to its original value, since
		 * may_access_direct_pkt_data mutates it
		 */
		env->seen_direct_write =3D seen_direct_write;
	}
}

If a program creates an skb or skb_meta dynptr and only modifies it through
one of the kfuncs in dynptr_write_kfuncs without performing other direct
packet writes, env->seen_direct_write remains false. Could this skip
bpf_unclone_prologue() and allow these kfuncs to overwrite shared skb->head
memory in place on cloned skbs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017012058.3557=
87-1-alexei.starovoitov@gmail.com?part=3D33
