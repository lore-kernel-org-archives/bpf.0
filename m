Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F83B9604
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627310; cv=none; b=DL5vIL4jYJhvxTjKqhi+47aXbLU86uteZ+WfeVOxcGAyrADI5EpJLfyD5pEKqNm4q3kRAcoxKojJyGvExNOVsOte/qnVt4mBG8+Hpsw5Np0wZd+eHEs2oNiq48J6U6oqDm48xXLgdS0ZJaxSk+FVspa9MR+i7ttGSmEPsgOuZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627310; c=relaxed/simple;
	bh=Chriox/qc0bay3SxHEj4lyBay9RQfH3sx/XKBt1uANw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LMpPypq7r5dEUaQmWj1TGujG+7sarwQ2AFGRY63xzOiWCEyXEV6UkD1Wo5nDGG3ujeyPwU6emh+F4++X5WfQnpLAGDXgnOg3sHFd18eV0Wg47/OVhxsNBA6huFuRJ39NVKEBVzpbVSG9TvKweiEHJUT6YpMqisj5zpoF7WW0xIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AV8YSXGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AV8YSXGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0C71F00A3A;
	Tue, 21 Jul 2026 09:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784627309;
	bh=+yWsoq44i6P9TzQ/AgZbU2cBeolSTfk3AtoqH7zDhw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AV8YSXGrYgt4sdBbfYYQts7/4TNEQ4sEvVeFp4IJ6LaHKXM19RiweOEkKJBnsTFWu
	 XgKykX6txfk2yJuRGzoB3iFjxG+gQwYrcSvaOY5FERuFN4yzf4MqdRahYKI+UykUF1
	 NumAvKzSBbC01VWrz7ae8gC09Ce34qrz4gsGDZpXxAFzb/Noi0jktJpHWSYiHdmsu6
	 qNWGlLVE9Kl48KOv6nyhNx4GatdAPI/nSVstMumJVEJKlqjqFsRsABUFyUYkLn/Klm
	 UxnajUsjYAfRJ+01WQ5ZLedIBrtEpXUUJzY/7WeWF+MgwJBjUEzn29VdnWlAagreNJ
	 gfu6wFFHjCkVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] bpf: Preserve stack frame number for commuted
 arithmetic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <a092a059781aad37b8d8ce3bb927052de5f73431.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
 <a092a059781aad37b8d8ce3bb927052de5f73431.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 09:48:28 +0000
Message-Id: <20260721094829.3D0C71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The patch completely breaks the security check that prohibits =
subtracting a pointer from a scalar (`scalar -=3D pointer`), allowing unpri=
vileged eBPF programs to bypass memory isolation and achieve arbitrary kern=
el memory read/write.
--

--- Patch [1]: [PATCH 1/2] bpf: Preserve stack frame number for commuted ar=
ithmetic ---
commit 3b8c2832d6eb05fc6ef4d1f2af9ee96ccdf5566e
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

bpf: Preserve stack frame number for commuted arithmetic

This patch modifies how commuted pointer arithmetic is handled in
adjust_reg_min_max_vals(). It uses a temporary off_reg to copy the
destination register before calling adjust_ptr_min_max_vals().

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 52be0a118cce0..3c0af83db4672 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -14854,15 +14855,18 @@ static int adjust_reg_min_max_vals(struct bpf_v=
erifier_env *env,
>  					bpf_alu_string[opcode >> 4]);
>  				return -EACCES;
>  			} else {
> +				struct bpf_reg_state off_reg;
> +
>  				/* scalar +=3D pointer
>  				 * This is legal, but we have to reverse our
>  				 * src/dest handling in computing the range
>  				 */
> +				off_reg =3D *dst_reg;
>  				err =3D mark_chain_precision(env, insn->dst_reg);
>  				if (err)
>  					return err;
>  				return adjust_ptr_min_max_vals(env, insn,
> -							       src_reg, dst_reg);
> +							       src_reg, &off_reg);

[Severity: Critical]
Does passing a pointer to the local stack variable off_reg here break the
pointer equality check in adjust_ptr_min_max_vals()?

In adjust_ptr_min_max_vals(), we have this check to prevent subtracting a
pointer from a scalar:

	case BPF_SUB:
		if (dst_reg =3D=3D off_reg) {
			/* scalar -=3D pointer.  Creates an unknown scalar */
			verbose(env, "R%d tried to subtract pointer from scalar\n",
				dst);
			return -EACCES;
		}

Since off_reg is now a stack pointer from adjust_reg_min_max_vals(), it will
never equal the verifier state array pointer dst_reg. Could this regression
allow eBPF programs to bypass the restriction and execute scalar -=3D point=
er,
potentially breaking memory isolation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784563950.gi=
t.chenyy23@mails.tsinghua.edu.cn?part=3D1
