Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8501440E8E6
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599325; cv=none; b=JXf/52DCIF1JhXBan0RZ7/Lloankws/DOLRJuT+VXY0jo5xARrpw+WmNjWnOTG/m5ZTn7UZ/sQVOarWTQCV2EpTIGXBr7zXib7Oo9DS0XVDIwfcbqSMY0hZy+5NIGVSR6nbSCgLIzuCIalZmjzcl1Iyu8XkWq7bpRTMIABz1Oto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599325; c=relaxed/simple;
	bh=4xgQpBWKTNOZpcX8OCbWg3UrdbdLNicL7k5vxveYEtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i7F1hxWrNLg/Vtv7hZ7DPxXDlfhnOIYdrY9oXOc1h0257Qp3rT90ObMIAUixKfy2FKQDBCxVoHwqqWzwB5qVMQCKb27hX7kktgM9XxdLupersNahseGytBxkhJmnCZkE91vUqfiNIk9GPipBuszWNQXiLLriznQsTQJP8qR2amQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlLZdwyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlLZdwyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FD21F000E9;
	Tue, 16 Jun 2026 08:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781599324;
	bh=ntBUtbVOAwhdoVaHDs4MP4DtoO5xFkC0e2SSM0Yzq6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YlLZdwyKSRUZUAulYorvvcWyoN+5ufDLcCq02chkWrPGm6x6WdIF2Pc0kAkRYOpTC
	 gSEDcqF4iQokfOc+/I3wuFNYm8OQFY3EMyQt5NED8Bc798vTi+7xORyUQffZZej2jI
	 VMjB0WHaFvJCNekgjaj6VEyaFUs3im+xkRWtvZdDNx6EiTcqew59QtqXnCRHaKpwKs
	 n17eLt6BeZP0gAviPN6FZVXF/gKYGAce0eKuNoiUx33m+YdHNpzbT2E3kYJWIQxJuM
	 uROQWaqTul36LL7L0+zUyfmVPi3dWj/eH8ZIDXLvo+dfQPU39bXWkx7f0HIeAy7nd9
	 rLnQ3jP4f0VmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Add missing access_ok call to copy_user_syms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260616083056.405652-1-jolsa@kernel.org>
References: <20260616083056.405652-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 08:42:03 +0000
Message-Id: <20260616084204.01FD21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `access_ok()` checks for user pointers `uoffsets`, `uref_c=
tr_offsets`, and `ucookies` before using `__get_user()` in `bpf_uprobe_mult=
i_link_attach`.
--

commit cd20e04dceb618df71198c96a9e801e033dcb0a0
Author: Jiri Olsa <jolsa@kernel.org>
bpf: Add missing access_ok call to copy_user_syms

The patch adds a missing access_ok() check for the user pointer array usyms
in copy_user_syms() before accessing it via __get_user(). It also cleans
up the error path by returning -ENOMEM directly upon memory allocation fail=
ure
instead of using a goto.

Link: https://lore.kernel.org/bpf/20260611115503.AC16D1F00893@smtp.kernel.o=
rg/

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a02bd258677ee..c274109d020f3 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2331,9 +2331,12 @@ static int copy_user_syms(struct user_syms *us, un=
signed long __user *usyms, u32
>  	int err =3D -ENOMEM;
>  	unsigned int i;
> =20
> +	if (!access_ok(usyms, cnt * sizeof(*usyms)))
> +		return -EFAULT;
> +
>  	syms =3D kvmalloc_array(cnt, sizeof(*syms), GFP_KERNEL);
>  	if (!syms)
> -		goto error;
> +		return -ENOMEM;
> =20
>  	buf =3D kvmalloc_array(cnt, KSYM_NAME_LEN, GFP_KERNEL);
>  	if (!buf)
> @@ -2358,10 +2361,8 @@ static int copy_user_syms(struct user_syms *us, un=
signed long __user *usyms, u32
>  	return 0;
> =20
>  error:
> -	if (err) {
> -		kvfree(syms);
> -		kvfree(buf);
> -	}
> +	kvfree(syms);
> +	kvfree(buf);
>  	return err;
>  }

[Severity: High]
This is a pre-existing issue, but while reviewing this patch I noticed a
similar pattern in bpf_uprobe_multi_link_attach() within the same file.

kernel/trace/bpf_trace.c:bpf_uprobe_multi_link_attach() {
    ...
	for (i =3D 0; i < cnt; i++) {
		if (__get_user(uprobes[i].offset, uoffsets + i)) {
			err =3D -EFAULT;
			goto error_free;
		}
		if (uprobes[i].offset < 0) {
			err =3D -EINVAL;
			goto error_free;
		}
		if (uref_ctr_offsets && __get_user(uprobes[i].ref_ctr_offset, uref_ctr_of=
fsets + i)) {
			err =3D -EFAULT;
			goto error_free;
		}
		if (ucookies && __get_user(uprobes[i].cookie, ucookies + i)) {
			err =3D -EFAULT;
			goto error_free;
		}
    ...
}

Are the user-provided array pointers uoffsets, uref_ctr_offsets, and ucooki=
es
missing overarching access_ok() validations before being accessed in this l=
oop?

Since __get_user() explicitly bypasses the access_ok() validation performed=
 by
get_user(), reading these pointers without a prior check could potentially =
allow
an attacker to pass arbitrary kernel memory addresses and trigger unauthori=
zed
reads or crashes.

Does this function need the same fix as copy_user_syms()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616083056.4056=
52-1-jolsa@kernel.org?part=3D1
