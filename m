Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3935BDA8
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131242; cv=none; b=JMNW2OfSqbHriYf3C3fHNeCvmAtgNcwZGH5Z495N4KNfAgyjIWwG/JcC/jCjObpnEmkWacId8Vo26U+nspzvqFVg7c/UpcR2xL7WdMMfSHdXFMP3g4wCd+IUn9nOmNMAouVhu+qVsb1T5XuwtHqGNQA0R1zPO+fgyM7dMnPn+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131242; c=relaxed/simple;
	bh=2GTS9axAx55o6kzqP86+hh7LGHovrEGse3ciNibPeys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YLnV61uBlbLXhzK08ADOcx8ZRJ0uBYimHgs05k30485I+ve1JaJIUfXJ2iOuw63im5B20zWFzJxQwSltoJC1i2W1/15z0+LvgdX3Mk/tvgnGiOqFNfRl9NR0z0TOIb9ZHH2Z3zVlPFEuBTaFJXJb/ejURuJ0s4JG+8zP53gNQz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8iq02YT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8iq02YT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88481F000E9;
	Wed, 15 Jul 2026 16:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784131240;
	bh=2GTS9axAx55o6kzqP86+hh7LGHovrEGse3ciNibPeys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R8iq02YTZM3yjAwvTf0dsUbwvj7wOD8TsWlf/f3VnEZs02otObx41GoDL6rLdZHc0
	 w9KufA18H48/WFWDi+0hoht/N/JcADogWU4GfvfRVrp30I4BU2bj4iE5z65TBwhd+7
	 xVvk9Z676aXr1ffVA/kad1YjNAI5NeOkhy1l0QTjtiR2wr6/jQQVVBx8dbIVGBB0te
	 AP5Q0760JFLzBiHgmPMqn+MFGIkQS2Lw5hWGRJuUT+CJPC7stBVGp9Nd0++QQd71zj
	 d8eLRnR8aGXfhoZNjYu+hmJxsCuFFSMfhro+9lG3joBdcX1XanTyy0nne2PqFw5RO6
	 42CFShIMfHDjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v10 4/9] libbpf: Add support for global percpu
 data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715153254.92010-5-leon.hwang@linux.dev>
References: <20260715153254.92010-1-leon.hwang@linux.dev>
 <20260715153254.92010-5-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 16:00:40 +0000
Message-Id: <20260715160040.A88481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] BPF skeleton generation completely omits the `.percpu` map, brea=
king the promised ergonomic access.
--

--- Patch [4]: [PATCH bpf-next v10 4/9] libbpf: Add support for global perc=
pu data ---
(Note: The format of this review is altered to use a free-form summary rath=
er than inline patch quoting due to automated recitation restrictions.)

commit c26518c258a32645d11a26c0d0ce50242231d6a6
Author: Leon Hwang <leon.hwang@linux.dev>
libbpf: Add support for global percpu data

This commit adds support for a new ".percpu" section in libbpf, enabling
efficient handling of global percpu variables. It handles the section by
creating a percpu_array map and populating it at load time.

[Severity: Medium]
The commit message mentions that users can read initialized percpu data
after loading the program. Does the current implementation fully support
BPF skeleton generation for this new section?

In tools/lib/bpf/libbpf.c:map_is_mmapable(), the new code explicitly
returns false when map->libbpf_type =3D=3D LIBBPF_MAP_PERCPU.

Because PERCPU_ARRAY maps cannot be memory mapped, this prevents the
skeleton generator from emitting the typed datasec pointer (such as
skel->percpu).

Additionally, does bpftool need a concurrent update to fully support this?
Looking at get_map_ident() in tools/bpf/bpftool/gen.c, the sfxs[] array
only contains ".data", ".rodata", ".bss", and ".kconfig".

Without adding ".percpu" to the bpftool suffix list, it appears the skeleton
generator will entirely omit the map from the generated header. If neither
skel->percpu nor skel->maps.percpu is emitted, will users be forced to fall
back to untyped manual lookups like bpf_object__find_map_by_name() instead
of having the intended ergonomic skeleton access?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715153254.9201=
0-1-leon.hwang@linux.dev?part=3D4
