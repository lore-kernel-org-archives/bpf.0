Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96D2E7389
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782203396; cv=none; b=u/N4OA0VFedY4xZVwKgSXJNPBWP6sa4IaAj/P7vFwtzkX5eGi+JRypkqBj5xryJLoAQwUKtxChTZILkQUlTbb1rSxufzTC892vN7OSHktd7bqs2YgM0A1R3KfvA6SxXgvykUNMxbOn/xzjKzYNKy7z0xqFU5J6impozRMPicBhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782203396; c=relaxed/simple;
	bh=OR+mpMaUD9O366o/y2W/AdAZb6L3d0ICjUl7f5AFjZE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hcPtEHbnrBvhtJ0WgodOvLe+dzngea9s53C8BpFjm7sa4O+Y+XRKpvbGB5J9xTs1fffy+7uLytciTHjD3UWamGjwLB0H+mU8LXugGNJu5y4265NHNGkxwj6x0GJliH2Td7pDaSVcwdZvOIboeaNcrOj6O+Bh5oVVrEmts0m8K3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wuy+L5/0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wuy+L5/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBC31F000E9;
	Tue, 23 Jun 2026 08:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782203395;
	bh=Aw5hNxoitZ3UWE/lesB+oSnIuTchb6mV4HDaHejXuP8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Wuy+L5/0JYhBBs5RXAbBugj+S5oCIB9Bj1Pw7pn7DjwGBsbwcJ2pJYSb02/HJI1id
	 m233VzmO6TvbggmW+lhtNK/GNWuurBLFvnxslEg3CbgzzK7cPE9hj1c/l/0EuKc/bP
	 Jan+58CVvkoL/YBzlGlozmYCMneT5eH2ZAKcNuUIXtZbx3aJ3YByztvs+3JTUjNDDN
	 o1XtvBSxIbvrLahXFB9lS1BUza0xmvrPaWOcwwWRewQYy5N35Uj0hbBzAzHieh80Oe
	 ASfbZs3kJmgrPM4Fz0erUQ0VE3nj7+ngv4wSolsk+lsat1NPtwoan3XuGiT4Ys/TbX
	 yjzto8CvuOHsA==
Content-Type: multipart/mixed; boundary="===============2510226624966471283=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <94ac9fea051c25b0bc884c2da3cc1fa83be2fb3e24007550e57687d2989916c4@mail.kernel.org>
In-Reply-To: <178220124597.31744.3595561672327420327@digiscrypt.com>
References: <178220124597.31744.3595561672327420327@digiscrypt.com>
Subject: Re: [PATCH] libbpf: bounds-check float size in btf_dump_float_data()
From: bot+bpf-ci@kernel.org
To: naveed@digiscrypt.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 08:29:55 +0000 (UTC)

--===============2510226624966471283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> btf_dump_float_data() copies t->size bytes from the object being dumped
> into a fixed-size 16-byte on-stack union float_data whenever the source
> data is not naturally aligned:
>         union float_data fl;
>         int sz = t->size;
>         ...
>         if (!ptr_is_aligned(d->btf, type_id, data)) {
>                 memcpy(&fl, data, sz);
>                 flp = &fl;
>         }
> sz comes straight from the BTF type and is never bounded. libbpf does not
> validate the size of a BTF_KIND_FLOAT type while parsing BTF
> (btf_validate_type() just breaks for it), and
> btf_dump_type_data_check_overflow() accepts any size below INT_MAX. A BTF
> blob describing a FLOAT larger than sizeof(union float_data) therefore
> makes the memcpy() write past fl and smash the stack when such a value is
> formatted via btf_dump__dump_type_data().
> btf_dump_int_data() already rejects out-of-range sizes before its copy;
> add the same check to the float path.
> Signed-off-by: Naveed Khan <naveed@digiscrypt.com>

This looks like a fix for a stack buffer overflow that has been present
since the typed data dumper was added.  Should this carry a Fixes: tag?

  Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28011525735
--===============2510226624966471283==--
