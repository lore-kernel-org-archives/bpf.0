Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67007306768
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641898; cv=none; b=KWks0B+z93QkDQQBpbed9fraX0gJEroHLVrUSBeJZmh2JeZFTFLTh3Ieb8bzvEscP9GBQsxXFjkWcKFJi2qBumZEkYdUGCuO/K2054RYYLQ7jQDhfe4O57jxC2BEWI6UPKldKZdrk1f2imjbPUUn7CmRKdB0WluLZGU6LWpsu54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641898; c=relaxed/simple;
	bh=5OMPs7xoez8L7ZfipLqYGkI4aBtzYP83fI1HcwwPI+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EqWElrysYGvYnCTO1NlljIHoq9krXYL1UfG9V5RHn6jiX9OIikT4QGxOuYlncLc4f7llNI7Fg/NXlgwHf3e1ITwTF/T+/S8ZdBEi0V4d+LydiDHDmdrh/nXsv156SHqch8EaEsRRSWZxHwv2uRYUaFuNUAOFPxeMW18rJsPeu7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEKAZwiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEKAZwiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041DB1F000FF;
	Tue, 29 Sep 2026 00:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790641897;
	bh=NcE1uvKS/Ecouetd/BDv14YERq5OBZy73lh6+pX5ops=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hEKAZwiDzPoAyp/ecTUR9D5PrCY25/N6SjI5dslx4dOiFm1eIN94VX6I+5sP4LTxE
	 JyLSrpBZbt9qG5lcDJEaXWyDXRISu8A29oRliS41rUVplwpT28Ic3aFLJ3fwIEJGs4
	 WKJvaPgTFPHdh4ht8g0jcwQp1KTRl5o47+Sd2I94wylv58V8kxJ1HiJdKNA9ALwsvU
	 g8krLT+v/N4gcAZsKSsVfeCodNZPdIBV8CiOGvoGC4qER9y25YdBWGnEnZi+6bCvP3
	 tud129+LZPP7DE0P3K0bnm6rRAAeVp0xcIpeQARr4/Wa9fy6R5mXIuoDo6wHJxu10s
	 09R2oSfzaXjkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 05/22] bpf: Prepare for an exception cleanup
 table before the CFG walk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260929001628.3247662-1-yonghong.song@linux.dev>
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
 <20260929001628.3247662-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 00:31:36 +0000
Message-Id: <20260929003137.041DB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: cleanup_pad adjustment fails for BPF_PATCH_MOVE_TARGET at off=
=3D0
--

commit fc0420a45de5f3cee47a65d96e78244ace4fbf4e
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Prepare for an exception cleanup table before the CFG walk

This patch prepares an exception cleanup table for BPF programs, adding
landing pads to the instruction auxiliary data for calls that can unwind.
It introduces the cleanup_pad field to track where execution should resume
during exception unwinding.

> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
> index b19fcbf49b7ef..c1779d2d02f05 100644
> --- a/kernel/bpf/exception.c
> +++ b/kernel/bpf/exception.c

[ ... ]

> +static int mark_call_sites(struct bpf_verifier_env *env)
> +{
> +	u32 i, j;
> +
> +	for (i =3D 0; i < env->cleanup_info_cnt; i++) {
> +		struct bpf_cleanup_info *rec =3D &env->cleanup_info[i];
> +
> +		for (j =3D rec->begin_off; j < rec->end_off; j++) {
> +			struct bpf_insn *insn =3D &env->prog->insnsi[j];
> +
> +			if (!bpf_pseudo_call(insn) && !bpf_is_callx(insn) &&
> +			    !bpf_is_unwind_kfunc(insn))
> +				continue;
> +			env->insn_aux_data[j].cleanup_pad =3D rec->landing_pad_off + 1;

[Severity: High]
How does this new cleanup_pad field handle instruction patching when a
landing pad is located at instruction 0?

If mark_call_sites() sets cleanup_pad =3D rec->landing_pad_off + 1, and the
landing pad is at index 0, cleanup_pad becomes 1.

If bpf_convert_ctx_accesses() in kernel/bpf/fixups.c later inserts a
prologue at instruction 0 using BPF_PATCH_MOVE_TARGET,
adjust_insn_aux_data() will try to update the aux data offsets. However,
its check:

    if (data[i].cleanup_pad > off + 1)
        data[i].cleanup_pad +=3D cnt - 1;

will evaluate to 1 > 1 (false) when off=3D0. The required shift is skipped,
leaving the cleanup_pad pointing to the newly inserted prologue instead of
shifting to the original instruction. Unwinding to this pad could re-execute
the prologue and potentially corrupt the frame pointer or stack.

Can this sequence occur and lead to stack issues?

> +		}
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929001601.3242=
665-1-yonghong.song@linux.dev?part=3D5
