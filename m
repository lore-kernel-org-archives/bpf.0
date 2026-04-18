Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EDD12CD8B
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776520006; cv=none; b=L3rv8Giw8w+uoNTNfMW/uiQgpoyNCBhmMF578TYOwo+vIkDayhU9nnKVanGA07TwMYLPyPPCF9UKLobLWbcWI67ryqJgTnxRfrkQgiMisx5Wh9xyMWAy+PiJ4NYCzHJssQ7xfBVIaWe8Xc8Rai0X2vBAmq+9aroYeWhZ+uwzA6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776520006; c=relaxed/simple;
	bh=qAR73778Yuh9waVD2hkzVQOV2t8lynDZs298CRFba8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RuHlf4yb9YEvoLY+GN2pk/ObUrr8r5HNhQKZFtU/BXCx1VJVxmJNUUrLH4/483Er6AHPXLLQ4sIvPIYDvsLukqCc8C7HvJazT0o3wjHbCHJy6jhW3L/9kwEfTC3X2kDI1ARo2VSwWC7Abh0+fAoWjkmdQRiT0kFx34U6EHezEPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6LYcWzm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6LYcWzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532DAC19424;
	Sat, 18 Apr 2026 13:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776520006;
	bh=qAR73778Yuh9waVD2hkzVQOV2t8lynDZs298CRFba8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=T6LYcWzmCaNeYCX7+90o5xuNEMjCA+cHo0dWxsyBxn2Jh0fKqFihYzbx/MSrVFRcO
	 rRa097B73JdDq3TM9s3mo+ICpcBLfS7SCxsjgbn4P8CSosKIlmLaybgdr8+lulDg0u
	 bOtAEgRAxnWF1VjI12RHrS3Qe/Z06MbQA8dtpE9FX99ciULAhc3AGyaswnLsQGBvcX
	 Y5ItNGFPWO6vhiGAAj+H5dP1e/yrQe3T7JspzHVtcdUqrFRpOwU+ZnTTPuYPGGRCtr
	 eHTGTZyfu7YWkQd/l+Lqn780/S26bsYS+c0i8HaKqD1QPMVhApHd4E8R+w5/0fuE2A
	 ov2ruZtgh6iFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v13 1/6] bpf: adjust BPF JIT dependency to
 BPF_SYSCALL
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260418131614.1501848-2-puranjay@kernel.org>
References: <20260418131614.1501848-2-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 13:46:45 +0000
Message-Id: <20260418134646.532DAC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Making `CONFIG_BPF_JIT` depend on `CONFIG_BPF_SYSCALL` silently di=
sables JIT compilation for seccomp and classic BPF (cBPF) socket filters on=
 systems that intentionally disable the `bpf()` syscall.
--

commit b9f1b2db51ab2071f24b457fa58ed412ec5bc050
Author: Vadim Fedorenko <vadim.fedorenko@linux.dev>

bpf: adjust BPF JIT dependency to BPF_SYSCALL

This commit changes the Kconfig dependency for BPF_JIT from BPF to
BPF_SYSCALL. The intention is to simplify other patches in the series as
BPF JIT moves towards optimizing kfuncs.

> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index eb3de35734f09..b0f49be35675f 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -41,7 +41,7 @@ config BPF_SYSCALL
> =20
>  config BPF_JIT
>  	bool "Enable BPF Just In Time compiler"
> -	depends on BPF
> +	depends on BPF_SYSCALL

Does this change cause a regression by silently disabling JIT compilation
for seccomp and classic BPF socket filters on systems that intentionally
disable the bpf() syscall?

The kernel's internal BPF engine (CONFIG_BPF) translates classic BPF to
eBPF for internal users like seccomp and SO_ATTACH_FILTER. The JIT
compiler (CONFIG_BPF_JIT) optimizes these internal programs independently
of the bpf() syscall.

Systems can configure CONFIG_BPF_JIT=3Dy and CONFIG_BPF_SYSCALL=3Dn to prev=
ent
userspace from loading arbitrary eBPF programs via the syscall.

By tying BPF_JIT directly to BPF_SYSCALL, this change forces these
environments to either run filters in the interpreter or expose the bpf()
syscall.

Additionally, does this force architectures that only implement
HAVE_CBPF_JIT to enable BPF_SYSCALL, pulling in unused eBPF verifier and
map infrastructure just to use their classic JIT compiler?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418131614.1501=
848-1-puranjay@kernel.org?part=3D1
