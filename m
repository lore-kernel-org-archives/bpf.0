Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830603EB0FD
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030573; cv=none; b=mMvusT/8akafhl9MOx8rwLNkO30WBYzlDsEohkVqC+QZYBbGUbsC2L+xapmMxSFm/Ng13AriDy4JsSaiP9QplnJTsknVU7DKDl1NoJOesrZz694TQBWN4SxBCfnT9JSjKw9UpOsUlCnDphJt4Tq4BhSowRVxvbX0T+dEsZGagxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030573; c=relaxed/simple;
	bh=KZYgQO6rRUq0DtDJOBzoetc5JL0/u7Y0hOhLOeTToTo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C0Yl00dHe8+onlIJZM0xK7n528PaT8RVayiFjFFTlhNjHMDEUtI8vgpWJ3PhB/wmfAx2SvBMAIF1JcTlJJK2I6nFqr6mOGaqDkq5c12wGBIA7lqGgbLx2dPd/GB11I1RdMSR2clPixTxyQWlXyRalMobI+MKv/i8S437nCCCaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iimKRPiz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iimKRPiz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C691F00893;
	Tue,  9 Jun 2026 18:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781030572;
	bh=htg6OZZTSa6YrO27lyMlnYczZiehFAycfZWOqvLfXsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iimKRPiz89C4V49NudahniJEkoT9XnmZC1DuiLKBLg5ZuH99V/iYP3lQ618ubvHhi
	 1daPvXnGJxsNaG51H5Vb1QW4F+51woSUuZ9Aq1EtfJoc4qOs8iZmGd7ShzkjKnA1x1
	 ChHm13SNLd+UMbIYEQF8HEE9hlpu2UoAVgG3t8kRqN/xENU3vijiMOKghlCfDKZcj9
	 a3TtThGfzdR3Wu1q15OyEPtVYnN/o+7+E08aZWt4QKt/yxge+5VwezouAWMBvtStSK
	 TKkpdrKdfpc9nr2ICX3m5c0irYdbV9/BN7Ik8e4CZspWPXoaNnLDrXdUO+4+6g8Zd8
	 App67MPPlNF2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Keep int return type for
 tailcall subprogs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609163957.1719798-1-yonghong.song@linux.dev>
References: <20260609163957.1719798-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:42:51 +0000
Message-Id: <20260609184252.15C691F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete fix for compiler optimization: `classifier_0` does no=
t consume `subprog_tail0` return value.
--

commit 889c5150d158afd20cd2f2219687b45dbae685e2
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Keep int return type for tailcall subprogs

This commit updates selftests to prevent the LLVM23 compiler from
optimizing away the return value of subprogs that issue a bpf_tail_call.
It does this by storing the return value into a global variable so the
compiler cannot change the subprog return type to void.

> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy=
2.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
> index ae94c9c70ab7d..8f217bef3d62c 100644
> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
[ ... ]
> @@ -41,16 +44,21 @@ int classifier_0(struct __sk_buff *skb)

[Severity: Medium]
Does this miss an update to classifier_0()?

The commit message notes that "Where the caller does not already consume the
return value, store it into a global variable as well".

In this file, classifier_1() and tailcall_bpf2bpf_hierarchy_2() were
updated to store the return values into ret1 and ret2.

However, classifier_0() still calls subprog_tail0(skb) without consuming its
return value:

int classifier_0(struct __sk_buff *skb)
{
        count0++;
        subprog_tail0(skb);
        return 0;
}

Could this allow the compiler to still optimize away the return type of
subprog_tail0?

>  static __noinline
>  int subprog_tail1(struct __sk_buff *skb)
>  {
> +	int ret =3D 0;
> +
>  	bpf_tail_call_static(skb, &jmp_table, 1);
> -	return 0;
> +	barrier_var(ret);
> +	return ret;
>  }
> =20
> +int ret1, ret2;
> +
>  __auxiliary
>  SEC("tc")
>  int classifier_1(struct __sk_buff *skb)
>  {
>  	count1++;
> -	subprog_tail1(skb);
> +	ret1 =3D subprog_tail1(skb);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609163947.1717=
694-1-yonghong.song@linux.dev?part=3D2
