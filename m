Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418A241C8C
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188495; cv=none; b=fZR/659zMeJIk+GnNDfVRpK+2OsL27haEiK0hPYldhJEzbC41FsjGuG5Kv5/5JcTnhvf/Fiq4au0w7w+Sthb5+c1+sBrHg3/YuBVa2vYiBdgJ4A87YJUjIxCelc6Y+uPR40iN/RuBIV7RN01GzW+I3CN/DtWMbB43Xa2ydPbyy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188495; c=relaxed/simple;
	bh=JK+m2rrPOl80KHtc3MO+JDj2EXnydcPQTRSha1Wfdcw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CImGOR6bxLVMZJ+KzxOC5aBxBkIGV28VL/ZrnE3cq5dmdhp3Mqi+u4b3N1aGITAkfEe4QbT27VDj7swwaN84Or/+jGF1RzDFoUci/VjxnOlFCzz1aGg3/yDqFqid3fGDF5+iV5fiG8aWBUqUw21FDPDtjXc+M9RZMcR4WHce5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAD9WdWS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAD9WdWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8D31F00893;
	Mon,  5 Oct 2026 08:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791188493;
	bh=AsCdZ88tMLm43ALcRbtF4+Bn+006Ov2jwAWbVOyKQvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iAD9WdWS5lRKbNWLrngaqKaFwa6CujA/D+devwFVvWKdzLaO2/73mnuu0xRk41ywF
	 iYEI/bNnD7I+pl1GCXtg2Nn++gJtUPMJF1eEY/RgH9KyNa3Tafe+kAx6kcfXwJu26f
	 Wc/UaqeI2s/hYYIGkBh/4YQYb8cTlur10aQ8ql2aYmWhoqRfol1thhlxBZAhpZH23O
	 VFMpDcxHyoZbylTJGj+zLJlfJKjfMvEMgJB0pPgMqolna5N7+s88dZzu5EaIbTEF6D
	 9UGX8m6fanb+wvFesbBnw6RQBNEtOKprCxLpOJf3A7OxU/m7X48B08co4m13VxwD53
	 nJCDZcSSXUR1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/sched: cls_bpf: accept dev-bound programs on
 shared blocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <QDISC-PYC7.v1.20261003103747@mojatatu.com>
References: <QDISC-PYC7.v1.20261003103747@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 08:21:33 +0000
Message-Id: <20261005082133.8B8D31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment style violation in cls_bpf.c
--

commit 335af23f9a1d13cab5f84cecaf4fd5a4dda63d7f
Author: Jamal Hadi Salim <jhs@mojatatu.com>

net/sched: cls_bpf: accept dev-bound programs on shared blocks

This commit allows device-bound programs to be attached through shared bloc=
ks
by ensuring the program matches every netdev bound to the block. Prior to
this, attaching to a shared block would incorrectly return -EINVAL because =
the
block's qdisc is NULL.

Link: https://lore.kernel.org/netdev/20260809094418.901607-1-jhs@mojatatu.c=
om/

> diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> index 188cf0f949dd4..6a54f8a7b8218 100644
> --- a/net/sched/cls_bpf.c
> +++ b/net/sched/cls_bpf.c
> @@ -392,9 +392,29 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb,=
 struct cls_bpf_prog *prog,
>  	if (bpf_prog_is_dev_bound(fp->aux)) {
>  		struct tcf_block *block =3D tp->chain->block;
>  		struct net_device *dev;
> -
> -		dev =3D block->q ? qdisc_dev(block->q) : NULL;
> -		if (!dev || !bpf_offload_dev_match(fp, dev)) {
> +		unsigned long ifindex;
> +		bool found =3D false;
> +		bool match =3D false;
> +
> +		/* A shared block has no qdisc (block->q =3D=3D NULL) but may
> +		 * bind several netdevs; the program is offloaded to all of
> +		 * them, so it must match all of them.
> +		 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the documented BPF
subsystem coding style? The BPF subsystem expects the opening "/*" to be on
its own line, rather than having text on the same line as the opening.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/QDISC-PYC7.v1.20261=
003103747@mojatatu.com?part=3D1
