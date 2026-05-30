Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922DD2594B9
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780117391; cv=none; b=WoVK+zm9l6AUOQTOWb7LYB+VGTvftMhpJ/++rA6+A/tR43CANJFusdTCA4QBz1lPRVHAUuXZncZKCHxYGXl0NGVn4Zrph5UbO91bq6xqdxtcq7LwvaSxQvUY2k0+G+WNoOEYbQH1dXggM1OebvqeLYsG7LpWLJ+Pl3pMuiKnxzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780117391; c=relaxed/simple;
	bh=uz9c7ylirGy4XfegKOYgNgYn3IPTJoqmQFZ8beEKl2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HgQ//84HcbdRWY25vdz1FNg7229jCQL3I/YMYiw+CFpZ0RaGJzFPMFLVIAdg5AhHhrPAtKWnhqhyvnXRDY1N1KRhoCfHFWrzsjWSK81HjJhKI1NkVZrb8xjbC4pvHbswbuQJDmbCmFD33EBJIn+ojrKFvyqSyRoAr3QXeFalRNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hD2Hm+Dn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD2Hm+Dn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113761F00893;
	Sat, 30 May 2026 05:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780117390;
	bh=Xdj0tdH659B+zDcoPkCS/csjFxy/B6Kk0UGxxFMRZf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hD2Hm+DnS5J9sIiPqrXKqZtZ/9vCmBdTd9Ls/wMWoGVmD57jcpWAHTmkmPD63yfvI
	 92CaowhNr11U1hg6Kw/YUo4yhoiKr9tbDeFApcV0iln9HnGP41fGlKmU4PW8ct+65c
	 WkYiu36zipXuINNVKj5hOBGobUcFaWimOf3xVdwzphbu/ZCRNl+02P2MSWarDtQy4E
	 fwXOim4I482WXvkDuYAs7bcLU6lYXI/TzUU5jGDLSRLqlBGdk95Yxg1ySElXTCJMOJ
	 xlM6UpdF6vGHdTH01xXLSlT7Cv36ghPIrplrUpazT6w+ox5G48AB+fjbbJ16Gif+Mb
	 i1qMrkWr9c4eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/5] selftests/bpf: Remove __arg_arena from
 the codebase
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260530002259.4505-5-emil@etsalapatis.com>
References: <20260530002259.4505-5-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 05:03:09 +0000
Message-Id: <20260530050310.113761F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete removal of `__arg_arena` annotation
--

commit 936642e9509313ae2959c6a3c4255651cca7040f
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Remove __arg_arena from the codebase

This commit removes the __arg_arena annotation from the codebase because
it has been subsumed by the __arena BTF type tag. The typedefs previously
used to minimize __arena annotations are removed, and the pointer types
are directly annotated when declaring variables instead.

> diff --git a/tools/testing/selftests/bpf/bpf_arena_htab.h b/tools/testing=
/selftests/bpf/bpf_arena_htab.h
> index acc01a876668e..eb80d67c38708 100644
> --- a/tools/testing/selftests/bpf/bpf_arena_htab.h
> +++ b/tools/testing/selftests/bpf/bpf_arena_htab.h

[ ... ]

> @@ -53,7 +52,7 @@ static int htab_hash(int key)
>  	return key;
>  }
> =20
> -__weak int htab_lookup_elem(htab_t *htab __arg_arena, int key)
> +__weak int htab_lookup_elem(struct htab __arena *htab __arg_arena, int k=
ey)

[Severity: Low]
Is the __arg_arena annotation incorrectly retained here? The commit
message mentions removing __arg_arena from the codebase, but it seems to
still be present in the signature of htab_lookup_elem().

Additionally, is it possible that an empty macro definition for __arg_arena
still remains in the userspace section of bpf_arena_common.h?

>  {
>  	hashtab_elem_t *l_old;
>  	arena_list_head_t *head;

[ ... ]

> @@ -66,7 +65,7 @@ __weak int htab_lookup_elem(htab_t *htab __arg_arena, i=
nt key)
>  	return 0;
>  }
> =20
> -__weak int htab_update_elem(htab_t *htab __arg_arena, int key, int value)
> +__weak int htab_update_elem(struct htab __arena *htab __arg_arena, int k=
ey, int value)

[Severity: Low]
Was __arg_arena intended to be removed from the signature of
htab_update_elem() here as well?

>  {
>  	hashtab_elem_t *l_new =3D NULL, *l_old;
>  	arena_list_head_t *head;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530002259.4505=
-1-emil@etsalapatis.com?part=3D4
