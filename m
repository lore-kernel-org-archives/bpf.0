Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515F224234
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803828; cv=none; b=d4V0UadhN2QzBX1YycjywtFKznlr6z7F1/c4ieoZp/bXLZWDNJrJ3LFMjCTgGpagr4NxAh6WQQ2yEro9CpNWqB+XjbeUIDFe06DOHbr9JUuBMZw0TH7X2S3adWZyb/l7trk0CdNjX4SGYOSpnD3Ja5Nth73+l7f6WKcp56+oaM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803828; c=relaxed/simple;
	bh=J9P8J65FWnrCxAS3S85F/S+Q+A0OBIonmEWbCPvAYUk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ec19Y71qdrCC2d1gAR7cj4JGboPNImVy9aYuvS2h4/T1dV+Q3K+1lODwBpjBQAjJtZFD+9QElv+X5lhrsPV3RUBoa5XTZm1kzTFFE2r4Y1Qa9yaVCwitUzpj9xZfONuOPz24s3qWzgBNhlN1dqyBouwfhqPHUTFHQ9md+Q50S64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK2dZf1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK2dZf1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104231F000E9;
	Tue, 26 May 2026 13:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779803827;
	bh=4eK5ab5zMs9H7r0DCaJHwTZ5f5qF8fARJrBuFmJdHXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gK2dZf1N9TM+aOb4WcIDUIGj+KAY9gukcIFKBa2/GshSWgm/9yrw9aAvmb1X2GJ8h
	 R87BYlKqPlGMhflVvozN4W6io2W2RMU+xNn5WoEqjaUNVfJR5kDLhYwAqRV/7s0ZUc
	 4FrqhsAqQtZPT6df7+/Dsw6MugpAoBNv07DZAMLPMZfaOHal+dY7LfDedp3/z6Gz6P
	 7uWrwEYNxgZ8KbXdqt1A0wbQLOcgAq31daLV3jZ1VML8jrBlo8+WFdooF0uhqLmb+L
	 /eh7x7t8LyRl8VmebARnvbuGQzogJUTtVmlupZUP7p0EQm9MRVAqxaKCPQn0Dhlbjz
	 kSkGpC7vRAjqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] libbpf: plumb btf_vmlinux_value_type_id and
 btf_fd in gen_loader
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Nayyar" <sidnayyar@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v2-3-6750f5859bc6@google.com>
References: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v2-3-6750f5859bc6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 13:57:06 +0000
Message-Id: <20260526135707.104231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch incorrectly reduces `attr_size` when constructing the BP=
F map creation attributes, silently truncating and discarding the `map_extr=
a` field.
--

commit 72a5ab975182d8bdeec79a02a460190b45ceeb56
Author: Siddharth Nayyar <sidnayyar@google.com>

libbpf: plumb btf_vmlinux_value_type_id and btf_fd in gen_loader

This commit updates the gen_loader map creation logic to include
btf_vmlinux_value_type_id and conditionally copy the loaded btf_fd into
the BPF attributes blob. It also alters the attr_size calculation based
on an assumption about the layout of union bpf_attr.

>     Previously, the `gen_loader` map creation generator
>     (`bpf_gen__map_create()`) completely omitted plumbing
>     `btf_vmlinux_value_type_id` because `attr_size` was calculated only up
>     to `map_extra` (which resides before `btf_vmlinux_value_type_id` in
>     `union bpf_attr`).

[Severity: High]
Is this description accurate regarding the layout of union bpf_attr?

Looking at the structure layout, map_extra is actually located immediately
after btf_vmlinux_value_type_id, not before it.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index cd5c2543f54d8..27b0353d1082e 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -507,7 +507,7 @@ void bpf_gen__map_create(struct bpf_gen *gen,
>  			 __u32 key_size, __u32 value_size, __u32 max_entries,
>  			 struct bpf_map_create_opts *map_attr, int map_idx)
>  {
> -	int attr_size =3D offsetofend(union bpf_attr, map_extra);
> +	int attr_size =3D offsetofend(union bpf_attr, btf_vmlinux_value_type_id=
);

[Severity: High]
Does this change silently truncate the map_extra field from the generated
system call arguments?

Since map_extra actually follows btf_vmlinux_value_type_id in union bpf_att=
r,
reducing attr_size to offsetofend(..., btf_vmlinux_value_type_id) completely
strips map_extra from the payload.

When add_data() copies attr_size bytes, the kernel will subsequently assume
map_extra is 0. This seems like it would break functionality for maps that
rely on map_extra when loaded via light skeletons, such as BPF_MAP_TYPE_ARE=
NA
(where it represents the mmap address) and BPF_MAP_TYPE_BLOOM_FILTER (where
it specifies the number of hash functions).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-libbpf-loa=
d-vmlinux-btf-in-gen_loader-mode-v2-0-6750f5859bc6@google.com?part=3D3
