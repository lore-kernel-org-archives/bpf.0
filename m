Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F295282F1A
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777113875; cv=none; b=bRjVtziFX1WnsUvfYPgmDlrQEDnA7TMGRxx6Gt/aCG//ZSNC2QpBMw1Xaas66iwhnqN07zUY4sf2GPG/fBhvJP+MZBS9doOprMyl2vP4+DhngdSDp9Kxyz2D81t0mrpy+qFTfeqfKSX3s2jMST5+hgiliawHPxa1vyXdgZQ79rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777113875; c=relaxed/simple;
	bh=UGZRcpi5iupeSW7zUVAaJBW4ad2n4EiBvBse/6Ylz9Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eR8bzGTjTu4Dx4khfaRjqJDzKJOOnog0S86DKED1PER5AK3xvOAJZFZfTHseqqXtPxaaJL0t++sy2LToHJt8mGIAWu8MvEHv4Zdkuod9/RaLHN+1uZ7K9hvEMimSieOzW8ObkC7vbFMT38SLdTeAtodKnYEIQCGcjLJBu7q6W4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvEyxOBr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvEyxOBr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4D8C2BCB0;
	Sat, 25 Apr 2026 10:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777113874;
	bh=UGZRcpi5iupeSW7zUVAaJBW4ad2n4EiBvBse/6Ylz9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VvEyxOBrv6AJBG0RAaai2HSxbQX/nc1O8REmj+lLUbaBpuiBaHN9eb8AbvwiyZpCT
	 +QYi6OHVQRWNUk5yZ+DlRYmo+0jGVFNGUSt5bqG76pXIwBCW83HHLqw+G/PYZKd2QW
	 yFsJKfZjT+DNKtDrcTD4CL3qRZF5Je4zqPvb5HQInsUVhuhsEiVZbrZ6P7gZgEbu1C
	 TxxnUOwpAevkJBuVOExGJ/eS7vq1tloEL7yWVnhyL47xwwna4qF4gtzOY3O58X6ST1
	 Be2CpQjuf8ss8F+lZnmnnV51pPJSHoOuO8QPta/EvXd7yGuIYevIASmCD5skPmOlyO
	 ud5KWNRc4UyQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/3] bpf, tcx: reject offloaded programs on
 attach
Reply-To: sashiko@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260424104201.217604-2-jiayuan.chen@linux.dev>
References: <20260424104201.217604-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 10:44:33 +0000
Message-Id: <20260425104434.7E4D8C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] The `bpf_prog_is_offloaded()` check added to `tcx_prog_attach()` is=
 unreachable (dead code).
--

commit 4bde7a6b1e8fdca118910a3c0f4b35254f1c6e42
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf, tcx: reject offloaded programs on attach

This commit adds checks to prevent offloaded BPF programs from being
attached via tcx, as they are meant to run on the NIC rather than the
host. The guards are added to tcx_prog_attach(), tcx_link_attach(),
and tcx_link_update().

Closes: https://lore.kernel.org/bpf/64d8e2b5-a214-4f3c-b9e8-bcedbcb2c602@hu=
st.edu.cn/

> diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
> index 02db0113b8e7c6..1144627483d53d 100644
> --- a/kernel/bpf/tcx.c
> +++ b/kernel/bpf/tcx.c
> @@ -16,6 +16,9 @@ int tcx_prog_attach(const union bpf_attr *attr, struct =
bpf_prog *prog)
>  	struct net_device *dev;
>  	int ret;
> =20
> +	if (bpf_prog_is_offloaded(prog->aux))
> +		return -EINVAL;
> +

Is it possible for an offloaded program to actually reach this check
in tcx_prog_attach()?

Looking at the prog attach syscall handler, it acquires the program
using bpf_prog_get_type(). This function hardcodes attach_drv =3D false
when calling __bpf_prog_get().

As a result, bpf_prog_get_ok() explicitly rejects any offloaded program
with -EINVAL before tcx_prog_attach() is ever called.

While the checks added to tcx_link_attach() and tcx_link_update() lower
in this patch appear necessary (since link creation uses bpf_prog_get(),
which skips attach-type validation and bypasses bpf_prog_get_ok()), does
the caller environment make this specific check in tcx_prog_attach()
unreachable?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424104201.2176=
04-1-jiayuan.chen@linux.dev?part=3D1
