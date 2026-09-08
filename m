Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0D330BB8D
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886895; cv=none; b=MgDSNYfnf1aNOciYlb0nqcq+JM7yWhNCxqGqJw/HZ9BrUiIbj4+CxQDRya8xsfMSdYQ0F8zqL1KTzGwK9fGWtruDxp+xstg4VQufzYJUxV7++v5n7pmNSVrh7tozAvPzNAh3NqPOT5658DStFVtQr50T7J+0Eub4PvJ7vq0Unz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886895; c=relaxed/simple;
	bh=gQWKcmYSzCUVafkVYXoPoh1pE7+XsNAsNkGDgOgKrr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZGrQCI6SRtFxdruVqWyh/vGwkIy+rPpWIfmUqnB9QYgAtfnF8PiT/MpnE46oJJJr013nBy3mjls8iSvxXcUliY3Vxau8bkK0FweWwyTX1HUf9BCscZVfyVFuvNurTjoXgNXH6qqjUYjbMndXs9IMC7vIkpIz38s/re8oGSh6o5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/AG+AnC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/AG+AnC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923D41F00A3D;
	Tue,  8 Sep 2026 17:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788886893;
	bh=C2OVaJRp3Lk5nggrCzqoOSQ6NqA76OG+5xtVmoARu9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W/AG+AnCCAGrV5FZnfRpV0qF/yJMTNX3MCo1/iGEhWIwwtUtVrg+gxVxrFghf+w0U
	 Z8jxumFMjRe8JcR9M+gvigh0vncLJBQI1W0IDvtNtShMTyFUdPpjg8HSG9A8v5QK1Z
	 V3qQMIYEh0pIpwfYU6e5dlFfwXVsKP2jOsB8UJAH1fdvXWOsl+5gHo0H34TDZvkKoT
	 hqnJOJteJBHrpWXFJcJoeG66R1lHsuXHVYNno0r7zBkcnMdROD/jEtRMWvUd3lj0ZW
	 k+2j4SFEFjbjEHwWle9F+Eyz57kwN+nyAzuTpTea+gohadBJOR7h+e6UW7Bd4wuz4N
	 A39UDGYQvmgVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/2] libbpf: Fix array comparison in BTF dedup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mingpei CAO" <caomingpei@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260908164920.108074-2-caomingpei@gmail.com>
References: <20260908164920.108074-1-caomingpei@gmail.com>
 <20260908164920.108074-2-caomingpei@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 17:01:33 +0000
Message-Id: <20260908170133.923D41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] btf_dedup_identical_types() can enter an infinite loop when resolv=
ing cyclic modifiers due to a missing depth decrement.
--

commit 724de86c8298443100e097d1d516c73679a67fcc
Author: Mingpei CAO <caomingpei@gmail.com>

libbpf: Fix array comparison in BTF dedup

btf_dedup_identical_types() reads both array descriptors from t1,
skipping comparisons of their referenced types. This can incorrectly
merge distinct structs and corrupt CO-RE relocation metadata.

Closes: https://lore.kernel.org/bpf/CABzjXVz3iBuump-pXFkefZ5v+2uu4fG61zqRyW=
D4xmz3PuBycw@mail.gmail.com/

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 8417de92d0282..41cc3140925fb 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4827,7 +4827,7 @@ static bool btf_dedup_identical_types(struct btf_de=
dup *d, __u32 id1, __u32 id2,
>  			return false;
> =20

[Severity: High]
This is a pre-existing issue, but looking slightly above this hunk in
btf_dedup_identical_types(), can this code enter an infinite loop when
resolving cyclic modifiers?

    case BTF_KIND_TYPE_TAG:
        if (t1->info !=3D t2->info || t1->name_off !=3D t2->name_off)
            return false;
        id1 =3D t1->type;
        id2 =3D t2->type;
        goto recur;

The depth parameter is tracked to prevent infinite recursion on cyclic type=
s.
However, this path uses goto recur to iteratively traverse the modifiers
without decrementing depth.

If a malformed BTF contains a cycle of modifier types (such as a TYPEDEF
that references itself), it appears depth would never decrease. Could this
lead to an infinite loop and exhaust the CPU during BTF deduplication?

>  		a1 =3D btf_array(t1);
> -		a2 =3D btf_array(t1);
> +		a2 =3D btf_array(t2);
> =20
>  		if (a1->index_type !=3D a2->index_type &&
>  		    !btf_dedup_identical_types(d, a1->index_type, a2->index_type, dept=
h - 1))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908164920.1080=
74-1-caomingpei@gmail.com?part=3D1
