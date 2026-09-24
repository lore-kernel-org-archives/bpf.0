Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD421382283
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790220480; cv=none; b=Q884DaIPWLPk8bQC/UP4lr0qql0mQj8V46o26bLapRpingtO56cXwy6XTh0cuDT5DaAsiJjbWLsFzsATD0N4xFMb8uzXsqeHXQf7T5aro93J3Sr9GIfqeWT0/bEYEGxrvT0ZPL0AS2Nj+Vp/dcX+WOhwokBR2oev4/UAM7tsWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790220480; c=relaxed/simple;
	bh=okvgc26t/ElkLKykWGQLlOtLyfemHOHLErUcb2ZCakY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K386dzkv2ME+/Hh8SDQ/TzBccaWYfaN7TLWpNS2Ksc7/QEpZnnMPsGThOVKfKiUKoL4fNSaqwcp7j4zvHFZX4az+NC2Ed2CWopLqDO2S1a0tWMRTw4MYucQpubghLfPXhsNtpgsre3FFy0USqrXdDPYfmSlOLv3DgZVmseWC4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFZC/KQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFZC/KQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE1A1F000FF;
	Thu, 24 Sep 2026 03:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790220479;
	bh=nxwlPRIGp2UQK8Z009oz9ylBXG7wzLoCC1h4yZKi5+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EFZC/KQOsK0QOtXpSj2jeJqDJPGPvkhmbpRUekraObu+Nes4wjo6gz/mia1bUTYRj
	 MPenl18mameXrAQrAiF23+giaSe8gJ8IlUxhOLfeXvG/DqiBMy/LgjecwpQforrg6I
	 cueFVlZgqgcm/LHrpCVwlMLpyJtBnzIlh59+FGidrf2OzpZeuWhDEMdp8JR8LC7XZL
	 rSCCrcsJfHBTlvqT1WGHLYWlHpwG3F6DViNZET2UQi6+jybKX5V4i2fpV7myWrlrVX
	 NJ43vXswWnYW3b+qkuXBug7RhATZqi+YymnHI3HkBU45U9yMsH6BYxva3AH0lilSi/
	 tVU6ato+sUAdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 12/17] libbpf: Resolve pointers to functions
 in read-only data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924031042.1690890-13-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
 <20260924031042.1690890-13-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 03:27:58 +0000
Message-Id: <20260924032759.3CE1A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: exception callbacks bypass callx and func ptr evaluation
--

commit 977905067f5778d4a89e59b4be93e1e229b29d4a
Author: Alexei Starovoitov <ast@kernel.org>

libbpf: Resolve pointers to functions in read-only data

This patch enables libbpf to resolve pointers to static functions located in
read-only data, such as struct ops or vtables. It creates per-program map c=
opies
containing the proper offsets, which the kernel later replaces with address=
es.
Programs utilizing callx automatically have statically referenced subprogra=
ms
appended during relocation.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index cd1ea1bb53cbf..fc9b7540aca63 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
[ ... ]
> @@ -7046,7 +7301,7 @@ bpf_object__relocate_calls(struct bpf_object *obj, =
struct bpf_program *prog)
>  	if (err)
>  		return err;
> =20
> -	return 0;
> +	return bpf_object__append_func_ptrs(obj, prog);
>  }
> =20

[Severity: Medium]
Will this miss callx instructions and function pointers used inside excepti=
on
callbacks?

Looking at bpf_object__relocate() in tools/lib/bpf/libbpf.c,
bpf_object__relocate_calls() is executed before exception callbacks are
appended:

tools/lib/bpf/libbpf.c:bpf_object__relocate() {
    ...
    err =3D bpf_object__relocate_calls(obj, prog);
    if (err) {
        ...
    }

    err =3D bpf_prog_assign_exc_cb(obj, prog);
    if (err)
        return err;

    if (prog->exception_cb_idx >=3D 0) {
        ...
        if (subprog->sub_insn_off =3D=3D 0) {
            err =3D bpf_object__append_subprog_code(obj, prog, subprog);
            ...
        }
    }
    ...
}

If the exception callback contains a callx instruction or references a func=
tion
pointer map, it seems they would bypass the bpf_object__append_func_ptrs()
evaluation. This could cause their read-only maps to be mis-relocated since
the has_callx state and subprogram appending are finalized prior to process=
ing
the exception callback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924031042.1690=
890-1-alexei.starovoitov@gmail.com?part=3D12
