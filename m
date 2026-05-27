Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B1540B6F6
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888328; cv=none; b=nXX7KoqOxCJTahJL3XfH3B1EHHNfyfjn/IegluyLLD4Grn0/jxmVWfCZdx8qJ+Ao3ccPfBB3i//iF3lyKAqqcNP77JQyDHb6GNXVP3GaVfV/Yjbjj+VnncBCwXVXZTLQao6yyiLd+u71CkL64yyKRulP75tztt4tMeBYrePhzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888328; c=relaxed/simple;
	bh=k8ppozzTL3enNurS3PxCZ2gyjOCjKwBnAiAmwsIo8j0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nXXMlFRIjWHoNS6tLdGORyYPc4s0HPKhF87qPv7EKUGFOu/iDzdxGYB3gamn/q6b4ar8x6mPMqSom59VGOS3dN8uwq3pGU13uwUUpcDkehRy6+6Wxm+GtIWnXxy7xucxDM0eM/4QqgyZ0q9MibY9XtlRUdITTkiHuZiGvbe+ZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUMPUoVP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUMPUoVP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBDF1F000E9;
	Wed, 27 May 2026 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779888327;
	bh=bNfmt/tyEsfOqJ5Ze7eNUfB8UFGaDu28fGJngKaRKp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PUMPUoVPsv/RRfH1giVeUtewLoyDE0eNNo8M8KtSxPRvKPIH7pt4mwehtvIgunwtr
	 XhwLzykoifq4wk7PiG6lQY+BFFs09O945WyUK9JjiRAPoApzV/gA1JwV1UOXxZw5Pe
	 YdOHFjo9NjfEzrhNG3EtTqU2V1wt8EyAZKEkjMNy10HdjgAkjvI87HAQTRJbXx8cj4
	 r5rLOzCJM3p7AYonZv7vgDlDAN2RlmPw+15OGz5kZ0l+g0vBxCZN+dQz1yKPNVfYkF
	 equGsV5Ggu4REYmUtvDy/dt0pgLo1FLD0yFnUf2ioRRtr8L14w1uaVMsXizKdYUWeW
	 yp4qa7M3Xj0mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] libbpf: load vmlinux BTF in gen_loader mode for
 struct_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Nayyar" <sidnayyar@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-1-27daa15487a9@google.com>
References: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-1-27daa15487a9@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 13:25:26 +0000
Message-Id: <20260527132526.EDBDF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Enabling light skeleton generation for `struct_ops` maps exposes i=
ncomplete and fundamentally broken loader logic, which will always fail on =
the target system.
--

commit 241c33de1404c9ec6cd0b388a0a3bc61171e6646
Author: Siddharth Nayyar <sidnayyar@google.com>

libbpf: load vmlinux BTF in gen_loader mode for struct_ops

This patch modifies the BTF loading logic in libbpf to ensure vmlinux BTF
is loaded even in gen_loader mode if the BPF object contains struct_ops map=
s.
This provides the necessary type information for generating light skeletons.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3a80a018fc7d5..b159faae7f9c6 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -3590,7 +3590,11 @@ static int bpf_object__load_vmlinux_btf(struct bpf=
_object *obj, bool force)
>  	int err;
> =20
>  	/* btf_vmlinux could be loaded earlier */
> -	if (obj->btf_vmlinux || obj->gen_loader)
> +	if (obj->btf_vmlinux)
> +		return 0;
> +
> +	/* only struct_ops maps need btf_vmlinux in gen_loader */
> +	if (obj->gen_loader && !obj_maps_need_vmlinux_btf(obj))
>  		return 0;

[Severity: High]
Does enabling struct_ops for light skeletons result in a generated loader
that works correctly on the target system?

It appears the gen_loader logic statically embeds the build host's
btf_vmlinux_value_type_id into the BPF_MAP_CREATE attributes buffer. Since
BTF IDs vary across kernel versions and configurations, won't passing the
build host's BTF ID to a different target kernel cause the syscall to fail
with -EINVAL or incorrectly associate the map with the wrong kernel structu=
re?
Shouldn't the loader dynamically resolve this ID using bpf_btf_find_by_name=
_kind
on the target kernel instead?

Additionally, struct_ops maps require their map values to be populated with
the runtime FDs of the loaded BPF programs. Does gen_loader currently have
the necessary logic to emit BPF instructions that read dynamically generated
prog_fds from the loader's stack, patch them into the map value buffer, and
update the map?

Furthermore, does the skel__attach() function generated by
bpftool gen skeleton -L handle struct_ops map attachment? It seems to only
iterate over programs, entirely omitting the struct_ops map attachment that
is normally handled by bpf_map__attach_struct_ops().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527-libbpf-loa=
d-vmlinux-btf-in-gen_loader-mode-v4-0-27daa15487a9@google.com?part=3D1
