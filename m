Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCCB479891
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 23:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033490; cv=none; b=KC/KjrvGgbT1qnChsvgS0zHE1BW/tO3t3jGtw/rpE3Dyc7AKCLR9znMz9cXEUrrR1XNu8jXuElwt43tA5F9tj/bqQh/PQhfzqO3aO6HQp/e90rB0GusObgBmX6bjTPAxpEMiNTm4GcW0YvategF0tjrSu9IpYdzeCVZJjJWnjZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033490; c=relaxed/simple;
	bh=wtqz3NdEXMjhkexr46jBzc3EdKtuW4oNX9WOGQiyC0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qc7lEOoKAWfEUnuvPl30nRBdSVgeUvti5EMPsASUy1Y7ORcPB12MPjrn7CvUlKlBNK5FKCs4fF/B5KA5rCTFkONQShK5Wy9TtqT//GS+Kdq9ZHg878+7eTBi9vrCR2c24Lt7HIA4ZLDBd23pyV73grFJCbNqDMr3M+ToHE+/4sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfsmJR6i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfsmJR6i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D7F1F0089C;
	Mon, 21 Sep 2026 23:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033482;
	bh=DKv4iBnu7aQ9+C5jLj77KhMkU6qdaOgKTQEO1uTI89E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QfsmJR6iBf1XfhZXRhMtfWswWr+KvoIKIE6lAOJ5cGx1YOIPUWXey6YwhFYyFHsrG
	 3VbAQm2ruduWjTH3gKktFQRvrns/DGEx35TwoBhHt5m/yi0Li7rK4+GRmmnPmhZLr7
	 ibXEKCYk6LiKfGdk6NpPZRL27v6uepSfnzdCH/EA6NUQ5ljMZ9oorAmEhffhhlLTrD
	 TmNC4/VoumruwBo/2mE8/ScZuXRdy4aTPv674WJAIeIk+v3FDIJF/jR0oTEHxG1s2g
	 aJOaYXtXg7L6tZ4V4aephWZp+SSqrBSpXtMl2ByH1PgsNBLZtnuwL+pgBp2t4pW2yt
	 b6r79oSmijU1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 5/7] libbpf: Version
 bpf_program__set_autoattach() ABI change
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921223937.3203093-6-andrey.grodzovsky@crowdstrike.com>
References: <20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com>
 <20260921223937.3203093-6-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 23:31:21 +0000
Message-Id: <20260921233122.12D7F1F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] libbpf: internal versioned aliases improperly exposed in public =
ABI
--

commit f4a1074a0b47562f2c3d7f448c920fa57fb2ed38
Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
libbpf: Version bpf_program__set_autoattach() ABI change

This commit splits bpf_program__set_autoattach() via ELF symbol versioning.=
=20
It introduces a deprecated variant bound to LIBBPF_1.0.0 and a new variant=
=20
returning int bound to LIBBPF_1.8.0 to handle manual load strategy rejectio=
ns.

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -393,6 +393,12 @@ LIBBPF_API bool bpf_program__autoload(const struct b=
pf_program *prog);
>  LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool =
autoload);
>  LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_autoattach(struct bpf_program *prog, boo=
l autoattach);
> +/* this "specialization" should go away once the deprecation window for
> + * bpf_program__set_autoattach_deprecated() closes
> + */
> +LIBBPF_API int bpf_program__set_autoattach_v1_8_0(struct bpf_program *pr=
og, bool autoattach);
> +LIBBPF_DEPRECATED_SINCE(1, 8, "use int-returning bpf_program__set_autoat=
tach() instead")
> +LIBBPF_API void bpf_program__set_autoattach_deprecated(struct bpf_progra=
m *prog, bool autoattach);

[Severity: Medium]
Does exposing these internal versioned aliases in the public header=20
defeat the purpose of transparent ELF versioning?

Building any application against this updated header might expose these=20
internal symbols, and dynamic linking could permanently bind them to the=20
polluted ABI.=20

Additionally, because the deprecation macro is attached to the internal ali=
as=20
rather than the standard name, will users ever see the deprecation warning=
=20
naturally when they call bpf_program__set_autoattach()?

[ ... ]

> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -465,6 +465,8 @@ LIBBPF_1.8.0 {
>  		bpf_program__clone;
>  		bpf_program__load;
>  		bpf_program__load_strategy;
> +		bpf_program__set_autoattach;
> +		bpf_program__set_autoattach_deprecated;

[Severity: Medium]
Is it intended to export the internal compat implementation as a public=20
symbol in the new LIBBPF_1.8.0 namespace?

This appears to permanently leak the internal compatibility symbol into the
public ABI.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921223937.3203=
093-1-andrey.grodzovsky@crowdstrike.com?part=3D5
