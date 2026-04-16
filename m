Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91438E113
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369708; cv=none; b=MoehbGmwnFNXo5hN2/tiMLPhqevEh+nZZUjf3n0Gf37FHgmK4Loqgoco2VnpLnPvx/DozVa2vT1RSMDYSthSGzvNh5gw7SGptECjhFpCE44MaOeuqC2yCPyGT1xpGHukhWRokIeC3UerpCDK4J3XcirU/eeYi9PjaJC8Zg0pZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369708; c=relaxed/simple;
	bh=NrKtZ6SUjErtkxzqrmTJW6REPsTKyQi04NAxwsh/wNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ee/htH8z6FW+mkj6cWWApJXiVjIBzusUiNK4TejuLz3Q6U6bO4xSBdNHl1MKbb0+8cV+8hYztBGV6EOVSCfonTteRzjFMGUxQez9dZ2NgaL2Y6JwnJH0WbuBCSDIJKwHqye5bAXOVQCwQd9iWD97ha2xPok6vobYoaWo4RdQMRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bw7wrhwy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bw7wrhwy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900AAC2BCAF;
	Thu, 16 Apr 2026 20:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776369707;
	bh=NrKtZ6SUjErtkxzqrmTJW6REPsTKyQi04NAxwsh/wNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bw7wrhwySBopyBGn2ozarMXJ7rAKMRcbrAbxiBdA035ItutWid5NWnwO+GD55D1Zs
	 eWTxqZ50DrxJk06n2scckIsKX6vbh2F6UpT2+G8jWXtx/B24AOLG7Ua0G+0Je6rkcZ
	 yMJ3q4BE0qUC6d1VhDO2CDh7LUXOaX2eDNP5HwP1eNI4f/+j1g4dD+8AN+ws8SQfRE
	 dnG5j8kErbaFAF+NYthDVsI7VChuLFHdbNc7Pi00Rq3r7VfDDl0udCNOMrqZLmTq+V
	 PpPI3uUTIgqQqTxOpWbisoodeBB+qX6xAcri5+Vy7jkf3uZMywZr/9JVaV98Z+HVCj
	 C/ycBjfgMTOJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 3/8] libbpf: Add feature for kernel extended
 vlen/kind support
Reply-To: sashiko@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416143904.1220662-4-alan.maguire@oracle.com>
References: <20260416143904.1220662-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 20:01:47 +0000
Message-Id: <20260416200147.900AAC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Feature probe `probe_kern_btf_vlen_kind_extended` is malformed and=
 always fails, breaking extended BTF support.
--

commit 45c7cfd438137b97d67612513eb9d60104376b8f
Author: Alan Maguire <alan.maguire@oracle.com>

libbpf: Add feature for kernel extended vlen/kind support

This commit adds a feature check for kernel extended vlen/kind support, and
rejects BTF that uses extended vlens/kinds if the kernel does not support i=
t.

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 4f19a0d79b0cf..f835931f4afe7 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c

[ ... ]

> +static int probe_kern_btf_vlen_kind_extended(int token_fd)
> +{
> +	static const char strs[] =3D "\0int\0foo\0bar";
> +	__u32 types[EXTEND_TYPE_LEN] =3D {
> +		/* int */
> +		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
> +		/* var */
> +		BTF_TYPE_ENC(5 /* "foo" */, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),

Is this BTF_KIND_VAR type missing its required trailing struct btf_var
payload? Without it, the kernel's BTF parser might become misaligned
and reject the entire raw BTF payload.

> +		/* datasec */
> +		BTF_TYPE_ENC(9 /* "bar" */, BTF_INFO_ENC(BTF_KIND_DATASEC, EXTEND_VLEN=
, 0), 0),

Looking at BTF_INFO_ENC(kind, kflag, vlen), it appears EXTEND_VLEN is being
passed as the kflag argument rather than vlen. This leaves vlen as 0 and
sets the kflag bit. Could the kernel's btf_datasec_check_meta() reject this?

Additionally, the size argument to BTF_TYPE_ENC here is 0. Will the kernel
reject this DATASEC type since a zero size usually returns -EINVAL?

Finally, if vlen evaluates to 0, will the appended EXTEND_VLEN
btf_var_secinfo structures below be parsed by the kernel as independent
trailing BTF types? If the first struct evaluates to BTF_KIND_UNKN, the
entire probe might fail unconditionally.

> +	};
> +	struct btf_var_secinfo *s;
> +	__u32 *types_data;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416143904.1220=
662-1-alan.maguire@oracle.com?part=3D3
