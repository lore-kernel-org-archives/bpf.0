Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CF026982C;
	Fri, 11 Sep 2026 03:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789097844; cv=none; b=P1tF1+neLNKb1e7oFKbw9HKu9OGj+CzTf20aeJjq9hLhVLGyA5yos0QpVMyWaOwWUBOEgV9MFX1y8aWBiV/p23CE8Rn0EThSFfe2moel9zmZhGbJkQ7Yz/Qky/QhlueV8XBavS5Yx4EeJ02KpkxZLq154ndOhwlT9ZS4oqSOW6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789097844; c=relaxed/simple;
	bh=1lb6ZFYHgEHGifnI40eeUkfTB1aQZMAMGpfPPV8TFNE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HX7sKMMRgkdcfu+SLGoIbKORn2JaNNWJo4biUa+ZC8ugK8NAJqxEcMtRRe6qTdrnmT7yqEaAAfQYXxm0437asX9Gx715VH/v+b9eXhFPVspgk5F1xt4c+kPeMbc83IObrnMkPTkzL/xnuFzxKteLuDXtAmLYITpoYdRnkAk29uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kku8MdvT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kku8MdvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAD11F000FF;
	Fri, 11 Sep 2026 03:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789097842;
	bh=FKYnrf3dD+z8x65x76FNrtG9n0yMZCHQ0U8gHF5I4OM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Kku8MdvTjidDWd57cbk8dA9rH/SoZYWx/Di02bl0Noa0GzBewlUYaMHsjg6je7tk8
	 oARnt98LfJEljYcU157HV6xdP85IDAjDaxX9DABKj3sbPxvwvTTktZAgW+d1zimhBM
	 Ni1SZwQkdedf2hY6FlLjy9dL4ZWwWIOeRjkkHqv1/dng2PCuZD7pQBkWU+s3uRHEA6
	 6h7X+At6d3JdM1vwLmr+GWG8NW9/3f+s/3EO5mhAGwBiU7U2PznNiczvecs/xz1HF8
	 wkcAgG70i9RUUXAOsvNa09lmr+R3XastSGT+xdxo3+S7uIIeuYe6Ilr5CbWBZRzCc3
	 4MbHFuNnpZDNQ==
Content-Type: multipart/mixed; boundary="===============7405869757073996078=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <523c73e7f76e0634a3e061e76ca4c39eb21cb006fc78875ddaf6a35e38bfd500@mail.kernel.org>
In-Reply-To: <20260911025044.190540-2-diannaaav@gmail.com>
References: <20260911025044.190540-2-diannaaav@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpftool: Accept symbolic map creation flags
From: bot+bpf-ci@kernel.org
To: diannaaav@gmail.com,qmo@kernel.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 03:37:21 +0000 (UTC)

--===============7405869757073996078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/Documentation/bpftool-feature.rst b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
> index c7f837898bc7..597f2426d255 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-feature.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-feature.rst

[ ... ]

> @@ -68,12 +68,14 @@ bpftool feature probe dev *NAME* [full] [macros [prefix *PREFIX*]]
>
>  bpftool feature list_builtins *GROUP*
>      List items known to bpftool. These can be BPF program types
> -    (**prog_types**), BPF map types (**map_types**), attach types
> +    (**prog_types**), BPF map types (**map_types**), map creation flags
> +    (**map_create_flags**), attach types
>      (**attach_types**), link types (**link_types**), or BPF helper functions
>      (**helpers**). The command does not probe the system, but simply lists the
>      elements that bpftool knows from compilation time, as provided from libbpf
> -    (for all object types) or from the BPF UAPI header (list of helpers). This
> -    can be used in scripts to iterate over BPF types or helpers.
> +    (for all object types) or from the BPF UAPI header (helpers and map creation
> +    flags). This can be used in scripts to iterate over BPF types, helpers, or
> +    the symbolic flags accepted by **map create**.

This isn't a bug, but could this paragraph be re-wrapped so the new
group folds in at the same width as the surrounding lines? The second
half was re-flowed to match the file's usual 78-column width, but the
first half wasn't, leaving "(**map_create_flags**), attach types" about
half as wide as the lines around it.

> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> index 5daf3de5c744..5a5c26f789cd 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst

[ ... ]

> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 75cbcb512eba..ea3f521b6f08 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool

[ ... ]

> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> index 0f6070a0c8e7..b5419d5a661a 100644
> --- a/tools/bpf/bpftool/feature.c
> +++ b/tools/bpf/bpftool/feature.c

[ ... ]

> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 9315a1db1f7c..3e2856c9f595 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h

[ ... ]

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 684a8fb72414..4445014247d6 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1250,6 +1250,81 @@ static int do_pin(int argc, char **argv)
>  	return err;
>  }
>
> +static const struct {
> +	const char *name;
> +	__u32 value;
> +} map_create_flags[] = {
> +#define MAP_CREATE_FLAG(flag) { #flag, flag }
> +	MAP_CREATE_FLAG(BPF_F_NO_PREALLOC),
> +	MAP_CREATE_FLAG(BPF_F_NO_COMMON_LRU),
> +	MAP_CREATE_FLAG(BPF_F_NUMA_NODE),
> +	MAP_CREATE_FLAG(BPF_F_RDONLY),
> +	MAP_CREATE_FLAG(BPF_F_WRONLY),
> +	MAP_CREATE_FLAG(BPF_F_STACK_BUILD_ID),
> +	MAP_CREATE_FLAG(BPF_F_ZERO_SEED),
> +	MAP_CREATE_FLAG(BPF_F_RDONLY_PROG),
> +	MAP_CREATE_FLAG(BPF_F_WRONLY_PROG),
> +	MAP_CREATE_FLAG(BPF_F_CLONE),
> +	MAP_CREATE_FLAG(BPF_F_MMAPABLE),
> +	MAP_CREATE_FLAG(BPF_F_PRESERVE_ELEMS),
> +	MAP_CREATE_FLAG(BPF_F_INNER_MAP),
> +	MAP_CREATE_FLAG(BPF_F_LINK),
> +	MAP_CREATE_FLAG(BPF_F_VTYPE_BTF_OBJ_FD),
> +	MAP_CREATE_FLAG(BPF_F_TOKEN_FD),
> +	MAP_CREATE_FLAG(BPF_F_SEGV_ON_FAULT),
> +	MAP_CREATE_FLAG(BPF_F_NO_USER_CONV),
> +	MAP_CREATE_FLAG(BPF_F_RB_OVERWRITE),
> +#undef MAP_CREATE_FLAG
> +};

This isn't a bug, but the table walks bits 0-19 of the map creation
flags in include/uapi/linux/bpf.h in order, except bit 14
(BPF_F_PATH_FD) is left out between BPF_F_LINK and BPF_F_VTYPE_BTF_OBJ_FD,
with nothing in the source recording why.

The omission looks deliberate (BPF_F_PATH_FD's comment says it is for
BPF_OBJ_PIN/BPF_OBJ_GET, and the follow-up selftest asserts that
`flags BPF_F_PATH_FD` is rejected), but nothing marks it as intentional,
so the next person adding a flag to that enum has no way to tell a
skipped bit from a forgotten one.

The wording added to bpftool-map.rst - "full, case-sensitive map
creation flag names from the bpf.h UAPI header" - also reads as
covering the whole enum, so a user who finds BPF_F_PATH_FD there and
passes it by name gets "can't parse" while `flags 16384` is accepted.

Would a one-line comment next to the gap (something like
"BPF_F_PATH_FD is an OBJ_PIN/OBJ_GET flag, not a map creation flag")
help, and should the manpage wording narrow "from the bpf.h UAPI
header" a little so BPF_F_PATH_FD doesn't look like an accepted name?

> +
> +const char *map_create_flag_name(unsigned int id)
> +{
> +	if (id >= ARRAY_SIZE(map_create_flags))
> +		return NULL;
> +
> +	return map_create_flags[id].name;
> +}
> +
> +static int parse_map_create_flags(const char *arg, __u32 *flags)
> +{
> +	const char *name = arg, *comma;
> +	long long value;
> +	__u32 parsed = 0;
> +	size_t len, i;
> +	char *end;
> +
> +	/* Keep base-0 numeric input, including bits unknown to this bpftool. */
> +	if (strncmp(arg, "BPF_F_", 6)) {
> +		errno = 0;
> +		value = strtoll(arg, &end, 0);
> +		if (errno || end == arg || *end || value < 0 || value > UINT32_MAX)
> +			goto invalid;
> +		*flags = value;
> +		return 0;
> +	}
> +
> +	do {
> +		comma = strchr(name, ',');
> +		len = comma ? (size_t)(comma - name) : strlen(name);
> +		for (i = 0; i < ARRAY_SIZE(map_create_flags); i++) {
> +			if (strlen(map_create_flags[i].name) == len &&
> +			    !strncmp(name, map_create_flags[i].name, len))
> +				break;
> +		}
> +		if (i == ARRAY_SIZE(map_create_flags))
> +			goto invalid;
> +		parsed |= map_create_flags[i].value;
> +		if (comma)
> +			name = comma + 1;
> +	} while (comma);
> +
> +	*flags = parsed;
> +	return 0;
> +invalid:
> +	p_err("can't parse %s as map creation flags", arg);
> +	return -1;
> +}

[ ... ]

The changelog presents the new rejections as added validation, but
three of them are inputs the old parser accepted, so they are a
user-visible behaviour change rather than new strictness.

The previous branch was parse_u32_arg() -> strtoul(**argv, &endptr, 0)
with only `if (*endptr)` checked, so `flags ""` quietly became 0,
`flags 0x100000000` quietly truncated to 0, and `flags -1` quietly
wrapped to 0xffffffff. The new strtoll() path rejects all three.

That compatibility note is the part a reviewer would most want spelled
out, and it is the one thing the message leaves implicit while the
closing paragraphs restate the documentation and bash-completion hunks.

Could the changelog say that these numeric forms were previously
accepted (empty string and out-of-range values were silently
truncated), so the tightening is visible as an intentional behaviour
change?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34557157318
--===============7405869757073996078==--
