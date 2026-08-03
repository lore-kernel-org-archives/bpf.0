Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DF184039
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764347; cv=none; b=JA2n55gF5ilH//K65TQPqpsYRFffL4Ywi34aCJDgqyDu7mtbXp0LYoGEmwfxSLDBI3oGcmJRVn7MaO64xPf2vILn5wQJujqFlYPHafmbQ6IXV6+fhEX93BjJrUxqv3rDs+z3GaeGEMHQN32R4bQEOok9i03tHhSCmgLfMZkOyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764347; c=relaxed/simple;
	bh=49o4YhqrynzGbq1PLGh06pB0hmBXs96K7jwyflR0z/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GJsoNjyvYasoM8h+JnQ672RpS+Loo9E78pu3NCBDWIC6Fr1RHu7GEjCl9cPBX6vTT4+WslUXZvMNhKgJ9LctmS9S1ultANfT6ppqSzhkZfLXNvkrXH8mPpoBDAyc4VTwTDogMH8JSDEPNgUU4EXX36uEqsVI7DHzeWmnDuhl+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqgrqeZV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqgrqeZV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBD81F000E9;
	Mon,  3 Aug 2026 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785764345;
	bh=nMHaN2gYuUKYjoQ1Lc8hNYg45foHfAtcwAgSOB0MDVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WqgrqeZVF8CZCs92iMCjlG5kjtZV9txw8EwiNTri/FJJtAyIJ8Iul4NmeKrLvH+qy
	 RP4Lxd3l1GLYkLuNOi6cjkrUObN9gMNggYXJDlveSlAhyLm9BR99Be8elH3l414+5H
	 ORUKmveWPA3VzcZhYa5L+zQBOTDOvfd0WfgKimJ0WaV/mrSW/pNkp+3ESzyOr4lSdu
	 MrwpvNO/apF1fgwY3btf6UZ2BYUXxjLT0YjRMpYTrmuEf1EWPLWmJWcKAY2d4XgHvw
	 OSu6h9jXmoMnbRNhVqjB/q64MtjEi72H01btcWQ2OragSU7CzJRE1aqIO/wbL+6fS2
	 SgDxGVjL4jMuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 7/9] selftests/bpf: Add struct_ops __arena
 and __arena_nullable argument tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803125115.2264733-8-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
 <20260803125115.2264733-8-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:39:04 +0000
Message-Id: <20260803133905.8EBD81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditional dereference of global pointer st_ops3 in new kfunc=
s can lead to kernel panic if called before struct_ops attachment.
--

--- Patch [7]: [PATCH bpf-next v3 7/9] selftests/bpf: Add struct_ops __aren=
a and __arena_nullable argument tests ---
commit f599951dcb563bef61136071f8ea610da5c68910
Author: Tejun Heo <tj@kernel.org>

selftests/bpf: Add struct_ops __arena and __arena_nullable argument tests

This commit adds test_arena and test_arena_nullable members to the
bpf_testmod_ops3 struct to test arena-tagged arguments and kfuncs that forw=
ard
caller-provided pointers. It ensures that the kfuncs correctly receive a ke=
rnel
arena address and the trampoline converts it back to an arena pointer.=20

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index f4cd1ad254a5a..396e5b467855b 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
[ ... ]
> @@ -418,6 +430,16 @@ __bpf_kfunc void bpf_testmod_ops3_call_test_2(void)
>  	st_ops3->test_2();
>  }
> =20
> +__bpf_kfunc int bpf_testmod_ops3_call_test_arena(u64 *ptr__arena)
> +{
> +	return st_ops3->test_arena(ptr__arena);

[Severity: Medium]
Can this unconditionally dereference st_ops3 without synchronization?

If a BPF program calls bpf_testmod_ops3_call_test_arena() before the
bpf_testmod_ops3 struct_ops map is attached, or after it has been detached,
st_ops3 would be NULL. Could this lead to a kernel panic?

> +}
> +
> +__bpf_kfunc int bpf_testmod_ops3_call_test_arena_nullable(u64 *ptr__aren=
a_nullable)
> +{
> +	return st_ops3->test_arena_nullable(ptr__arena_nullable);

[Severity: Medium]
Similarly, does this have the same risk of a NULL pointer dereference if
st_ops3 is NULL when bpf_testmod_ops3_call_test_arena_nullable() is called?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803125115.2264=
733-1-memxor@gmail.com?part=3D7
