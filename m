Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBA1348C54
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937340; cv=none; b=EHkUPksSlXpnTlC8a4idVfd2voVsYXPcbhClgunz61YyZRpZKh+ydHH+CKXZcOO+rdzqUPjVJ6+wUi/lG7IeRboGA98CAlYBXHOmJe+BWiT9bkjZgeHbC57PAlG3z6EKHfvi5c/AKYLVbcR4DXb43f/ZMW2ffXKOo1Ea2CRcacw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937340; c=relaxed/simple;
	bh=+aJBiOKOfnSwnq3A31ae8yMAhhcKRzfy5DUy0II4Vyw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iz4xc0nRNOQ6L15uA7qEdRpZ24mfDJz58B2Jvq+lSIfsqaaxdR6/ThjjBhIWtqD7GOMn1e30B09QBgFwBdfy1A2RQyIh44m0EwLXicVmMsYKB3fBZBvBGVmO6trD4U3Lf5bqdQwajE9Acuoo+mQmwnGUR4RLmeRVFs0RKlFdZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrOvYUyJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrOvYUyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0161F000E9;
	Fri, 28 Aug 2026 17:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787937339;
	bh=aBz5etI4dpqzGoBp5IFi8qZsDema72aI7wcPdsyJpFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PrOvYUyJQTWY1KLDBu/34vFjGGcE9d/1B3osRJEnzLORnGgk4UsY/fnR14iegmXRH
	 YmssfjDZVgGNeufX6XXqxA1sdgB572dLIB9pqVH5Pvptp6DPRZ/SF8syF/jBPTEQld
	 ImJ+I2dYv1CFg0tsL2nd8wj3OP2mz0DMy1x8mCn91x+jZ2gLTUftXQJPVMR3IOLsGE
	 mJe7ek0k8+8G7c1LjaGI+wj55tgL2UE991S7hRtrEDEb8eQuPhlN4nCNk6Cc3Dh8Bu
	 vM5KaB/JaCNGKyzSaxHMmSA8Td4QnIxauaJhD/U0jc9nXtfRRwgn0GTrmk/yfzG1qn
	 XV/TACMBOUZwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/bpf: Bound the offset accumulator in
 __tld_fetch_key()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260828170534.1011183-1-yonghong.song@linux.dev>
References: <20260828170534.1011183-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 17:15:38 +0000
Message-Id: <20260828171538.EF0161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The return value of `__tld_fetch_key` can be truncated to a posi=
tive value when assigned to a `__s16` variable, leading to invalid memory a=
ccesses in BPF programs.
--

commit 9916e7593b30ccde51452c3954f02517563a9c94
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Bound the offset accumulator in __tld_fetch_key()

The LLVM commit c7f4a76da024 caused test_task_local_data.bpf.o to fail=20
verification because TLD_ROUND_UP(x, 8) expansion interacts poorly with an
InstCombine fold. This patch adds a bounds check to the offset accumulator
in __tld_fetch_key() to ensure the verifier maintains precise bounds and
converges during loop analysis.

> diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/to=
ols/testing/selftests/bpf/progs/task_local_data.bpf.h
> index 0df8a12fd61e2..a31a399870bef 100644
> --- a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
[ ... ]
> @@ -189,6 +190,8 @@ static int __tld_fetch_key(struct tld_object *tld_obj=
, const char *name, int i_s
>  			return start + off;
> =20
>  		off +=3D TLD_ROUND_UP(metadata[i].size, 8);
> +		if (off > TLD_DATA_SIZE)
> +			break;
>  	}
> =20
>  	return -cnt;

[Severity: Medium]
This isn't a bug introduced by this patch, but does returning `-cnt` cause =
an
issue if `cnt` exceeds 32768?

The `cnt` variable originates from `tld_obj->data_map->meta->cnt` which is a
user-controlled `__u16` (capable of holding up to 65535). When `-cnt` is
returned by `__tld_fetch_key()`, it is later assigned to a `__s16` field in
`tld_get_data()`:

	off =3D __tld_fetch_key(tld_obj, name, cnt);
	(tld_obj)->key_map->key.off =3D off;

If a user space process sets `cnt` greater than 32768 (e.g., 60000), `-6000=
0`
will be truncated when assigned to the `__s16` field `key.off`, resulting i=
n a
positive value (e.g., 5536).

On subsequent calls to `tld_get_data()`, the cache miss logic would be
bypassed since `off > 0` is true, and the BPF program would erroneously read
from an invalid or unintended memory offset instead of the correct task loc=
al
data.

Could this corrupt the offset cache if an untrusted user space application
provides a maliciously large `cnt` value in the BPF task storage map?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828170534.1011=
183-1-yonghong.song@linux.dev?part=3D1
