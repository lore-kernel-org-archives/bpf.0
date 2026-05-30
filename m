Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458312D24B7
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101908; cv=none; b=AbX3lMWRGISkHRJVNKXG3HTaANXNinYHHTndQT5E5dybHI0cvkRY/j34Kax1tAZaz6/nzF7If3xYZfD0gmcittrM6wAZ4NpAPDWJvbyNhQvIXJ4fFpxVDYn10ExaPonLtUTgB4q+CgxdHsDEiNn9vysKcr1IuJgI96Kk2/YLV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101908; c=relaxed/simple;
	bh=ouCkd4vSStTlVeJpurTsNwhFolxO2rqJ1z3Zunq+xwk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o2G9CjGsftOYlQlzLtAli/eD72QfnujlevzWB7gwfdMKscGOTN19h/dWUbuband3rd1T/7pPvNRtXKaktbiUBgkEo3NPHc6KTVJhVbDW1j2uJsrRDwq1wIEt4eIud3TY/fe+YWmTIO63AmLqBq8M1bIpyhfE2/rqJKBZ5nBlGd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvhb5x93; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvhb5x93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EEF1F00898;
	Sat, 30 May 2026 00:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101907;
	bh=PoTiPX+FDOetdEm00FRpfOoMNineKnLjfglFY0NKq5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gvhb5x93xF94b5qemJ/91OqNPB+NaDYqVNlw/ctbfG4kSDIuyu9Xw8Co0mKqs/Tn2
	 AWkWCNKau1fqPHWHYWfbn1bF5hSK05KTPGJhSSVvLBnyJxljXkFhWLMgsGpxHUz8+I
	 X5zvf3NYFtgfJgfYn1SrDsWAza0wqApVF1+NNXB/4U92i1VvVL+/CPuSXKBx08f5LJ
	 qZg7ELecexO2/8cGQgie8z37OBxkr6rvQEaATTMdT+JiRyNqnNR3SChLQrGFALRoZq
	 p5Jy1Z5JL1YgRmuweFAIPW4St3ejuHvDO/lVcjHcFsMPAXzcQ9YaOH3OXxO17ynmUZ
	 g9AuOO+i+pl1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 2/6] atm: convert to getsockopt_iter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520-getsock_four-v3-2-b8c0b16b7780@debian.org>
References: <20260520-getsock_four-v3-2-b8c0b16b7780@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:45:06 +0000
Message-Id: <20260530004506.D9EEF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In `vcc_setsockopt()`, for the `SO_SETCLP` option, the kernel read=
s `sizeof(unsigned long)` bytes from user space instead of the expected `si=
zeof(int)` bytes, leading to an out-of-bounds read and logic error on 64-bi=
t systems.
--

commit 930f98204692e2b9c158cfe678aa997c3aaa716a
Author: Breno Leitao <leitao@debian.org>

atm: convert to getsockopt_iter
   =20
This commit converts the ATM SVC and PVC sockets, along with the shared
vcc_getsockopt() helper, to use the new getsockopt_iter callback. It replac=
es
user pointers with sockopt_t and utilizes copy_to_iter() for transferring
data to user space.

> diff --git a/net/atm/common.c b/net/atm/common.c
> index fe77f51f6ce18..60132de4eebe1 100644
> --- a/net/atm/common.c
> +++ b/net/atm/common.c
[ ... ]
> @@ -812,11 +813,13 @@ int vcc_getsockopt(struct socket *sock, int level, =
int optname,
>  	case SO_ATMQOS:
>  		if (!test_bit(ATM_VF_HASQOS, &vcc->flags))
>  			return -EINVAL;
> -		return copy_to_user(optval, &vcc->qos, sizeof(vcc->qos))
> +		return copy_to_iter(&vcc->qos, sizeof(vcc->qos),
> +				    &opt->iter_out) !=3D sizeof(vcc->qos)
>  			? -EFAULT : 0;
>  	case SO_SETCLP:
> -		return put_user(vcc->atm_options & ATM_ATMOPT_CLP ? 1 : 0,
> -				(unsigned long __user *)optval) ? -EFAULT : 0;
> +		val =3D vcc->atm_options & ATM_ATMOPT_CLP ? 1 : 0;
> +		return copy_to_iter(&val, sizeof(val), &opt->iter_out) !=3D
> +		       sizeof(val) ? -EFAULT : 0;

[Severity: High]
This is a pre-existing issue, but since you are correctly fixing the size
mismatch here in vcc_getsockopt(), should we also fix vcc_setsockopt() where
it attempts to read an unsigned long?

For SO_SETCLP, the kernel validates that the user-provided optlen is exactly
4 bytes via len !=3D __SO_SIZE(optname). However, vcc_setsockopt() uses an
unsigned long:

net/atm/common.c:vcc_setsockopt() {
    ...
    unsigned long value;
    ...
    case SO_SETCLP:
        if (copy_from_sockptr(&value, optval, sizeof(value)))
            return -EFAULT;
        if (value)
            vcc->atm_options |=3D ATM_ATMOPT_CLP;
    ...
}

On 64-bit architectures, this attempts to read 8 bytes from the 4-byte user
buffer, reading 4 bytes of uninitialized adjacent memory.

Due to little-endian packing, if the user explicitly passes 0 to disable the
option, non-zero garbage in the upper 4 bytes will result in value being
non-zero, wrongly enabling the ATM_ATMOPT_CLP flag.

Could this also trigger a spurious -EFAULT if the user's 4-byte buffer is at
the end of a mapped memory page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-getsock_fo=
ur-v3-0-b8c0b16b7780@debian.org?part=3D2
