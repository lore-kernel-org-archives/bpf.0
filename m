Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760E0381B10
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985264; cv=none; b=gNFJQH1N2+fXfY3OxNuzA2JTcomnKsNoFtzH4LdYaKy9hOL8CXLl9lM+66CmmYpte4P+gbDyTCfhunVcWvH3A30R9pjPchhhzxsHaE0sLcjeXi2JRjgc0+4oqqTPdd1Max+9rfcs47C+Q6evP/9of3ThAbmpDXVzXfd/tSIYXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985264; c=relaxed/simple;
	bh=KTLjNxGnzrq83Vak5pi2OmMmAHFam5F3PSPeHxHsMhk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t7Aydb080/1oW13b8czSaLoysLHhBCaDxc1tdl1L8aAbQmoTUJuctME14iagywZQUppyJ9oAKVXpI/9QCFcJCLiVdRA1SfGvV9RrloW4f6CbdLVh+EktF0RuKfJ/8eHyF65N9VZh0QnRICQgckrCgdvEYhRLKgtJtS4Cg5Wp8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDC8RLXk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDC8RLXk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E621F00893;
	Mon, 21 Sep 2026 10:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789985263;
	bh=G2iXEG9MlAcNrLBQ7KoTDUbbXJti5jOgxCBVjRRG3Ic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dDC8RLXkAkLLNoOuymlDF/zk5yn76SakTeWuZx7j/9gXZOjIfKKwZEvs2YzY6WPC5
	 MSIv/kVcaT9B2+gzii42qQcELgVCvCVmjppVpLDQ7ImLkayIYGQ79pAAOMQd01Ua6b
	 XK11XNRLdRTz6kb7JKvgpI9IrU+6YVinjarQxgAjFYfBj4dyGkNdGara2LCu/boY3l
	 jjt7Lup/t+JLKFtUAltlOGL5dOkEviCDO75Pq4q8XxHsVto0HWtX+q/J6pRTKV1GFH
	 KkoGjPl0A17amxw5+9IizrY/2xMggw3NFZrROoW0sId3xTeSNOVNXd7keLCcRruR5H
	 A7wNX0ISIiSfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 5/6] netlink: specs: rt-route: describe lwt
 BPF program options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260920-ynl_rt_encap-v2-5-c664a3e726f6@kylinos.cn>
References: <20260920-ynl_rt_encap-v2-0-c664a3e726f6@kylinos.cn>
 <20260920-ynl_rt_encap-v2-5-c664a3e726f6@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:07:42 +0000
Message-Id: <20260921100742.F0E621F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] netlink: seg6-local BPF attribute uses wrong UAPI header enums via =
lwt-bpf-prog
--

commit cddba7a35aae1dfa7f35285fd4781c86739950cc
Author: Hangbin Liu <liuhangbin@kylinos.cn>

netlink: specs: rt-route: describe lwt BPF program options

Replace binary BPF attributes with a nested lwt-bpf-prog to support
lwt bpf prog options.

> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/ne=
tlink/specs/rt-route.yaml
> index 4b12a8a586521..4a3953c9e9780 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml

[ ... ]

> @@ -508,7 +511,8 @@ attribute-sets:
>          type: u32
>        -
>          name: bpf
> -        type: binary
> +        type: nest
> +        nested-attributes: lwt-bpf-prog
>        -
>          name: vrftable
>          type: u32

[Severity: Low]
Does this incorrectly reuse lwt-bpf-prog for the seg6-local attribute-set's
bpf attribute?

By using the lwt-bpf-prog nested-attributes here, the generated YNL userspa=
ce
API will use linux/lwtunnel.h constants (LWT_BPF_PROG_FD, LWT_BPF_PROG_NAME)
instead of the correct linux/seg6_local.h constants (SEG6_LOCAL_BPF_PROG,
SEG6_LOCAL_BPF_PROG_NAME).

This leaks abstraction and forces users to include lwtunnel.h for seg6-local
operations. While there may be no runtime impact since the enum values happ=
en
to align, should this instead use a dedicated seg6-local nested attribute s=
et
to ensure proper UAPI encapsulation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920-ynl_rt_enc=
ap-v2-0-c664a3e726f6@kylinos.cn?part=3D5
