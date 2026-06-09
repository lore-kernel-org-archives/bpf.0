Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A5D31197C
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009966; cv=none; b=DFRy3hLnkQ1pWfYZznVEUbKyLb1k3zBmc24fQM/3zzf/zoGt+4AyPmzo/AbK/qmgpb50DWxoR2RT+wQPhWy9CVCxHzw4W5kTY63U3bifqmBzehy/vhtvpiw0N7tWlAZoBaNNt4lAfSM+EiXmvnAEoX7BAtU4fnE10CA347ledVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009966; c=relaxed/simple;
	bh=18FeW9rh/wf850bvUB8jZ7h1BGCD6d5MYqG+WXqN/RU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TFWI4sudb1qG1bapCUXUDrc6K4pt7m552crLdRWM9TVzt5J+eofweg4IERD3YjXtJvlxFfFgPsCUTjCXEnNqGVr4XbCnvwr2O4/b1x50Bn4BVVpKYmS2NLAJ+cXXYNXRdU6OBYssi0OgjohlawMBDAnxgj7KNbF6K/8eIDWPobU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYP/kVnT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYP/kVnT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07691F00893;
	Tue,  9 Jun 2026 12:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781009964;
	bh=FTmd6hQS3H2Ffcv3Pkk2kj/JjwwXBkfk843XVC4N9YY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UYP/kVnTTqyBb0JzkHlN05ItwjEEZpKjG6fwZcoMQ7JEDlCr2VjmOl5lgx8TqCn/z
	 +uBd7hnORwmXq1HsGWj+z6FSsVpdyk5+CSVNhaseWQ7NQkq8nGHPrtnYdmFWH2Jqm1
	 oqqttjbmy37luzwC21R2q9QFVOKQbuSv9j+zUQA23mryR1/yWymwi3/VQ7UNZDoxG0
	 x/3UMc2mIthK/W5rSUraz/enxgOY0eshF86nZaRWiCS5xN3k2UGpJkmLwDBLbeyNan
	 CJBUTYsOWij8MnjhCAHSnZUyDweBTC/BwIleuZ/R+aEsFKqoQZZdSdmCa//2NG1C9i
	 0FfqqMw1WJlDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v6 2/2] selftests/bpf: strengthen
 bpf_kfunc_implicit_arg to verify aux injection
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609125214.3096351-3-chenyuan_fl@163.com>
References: <20260609125214.3096351-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 12:59:23 +0000
Message-Id: <20260609125924.B07691F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Dereferencing a potentially stale or uninitialized `aux` pointer i=
n `strncmp` will trigger a kernel panic (Oops) instead of gracefully return=
ing a test failure.
- [Low] The multi-line comment does not follow the required BPF subsystem s=
tyle.
--

commit 9fe1fbc629675a37bbb1c47b4e9b422cd2edf717
Author: Yuan Chen <chenyuan@kylinos.cn>

selftests/bpf: strengthen bpf_kfunc_implicit_arg to verify aux injection

This commit updates bpf_kfunc_implicit_arg() to verify that the
KF_IMPLICIT_ARGS injection path correctly passes the bpf_prog_aux pointer.
It does this by comparing the name field of the aux pointer to ensure it
matches the expected prefix.

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
[ ... ]
> @@ -1827,7 +1827,11 @@ int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_=
ops_args *args, struct bpf_pro
> =20
>  int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux)
>  {
> -	if (aux && a > 0)
> +	/* Verify the kernel injected the correct bpf_prog_aux pointer
> +	 * rather than leaving a stale register value. */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the expected
BPF subsystem style? The preferred kernel style typically places the opening
/* on its own line before the text begins.

> +	if (!aux || strncmp(aux->name, "test_kfunc", sizeof("test_kfunc") - 1))

[Severity: High]
If the verifier incorrectly skips injection and leaves a stale register
value in the aux pointer, as described in the commit message, wouldn't call=
ing
strncmp() on aux->name trigger a kernel page fault?

Since the intention here is to catch a stale register containing an arbitra=
ry
unmapped or uninitialized memory address, can we safely dereference it dire=
ctly
in strncmp() without using a fault-safe memory access method?

> +		return -EINVAL;
> +	if (a > 0)
>  		return a;
>  	return -EINVAL;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609125214.3096=
351-1-chenyuan_fl@163.com?part=3D2
