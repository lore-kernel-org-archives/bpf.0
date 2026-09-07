Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE39F7262E;
	Mon,  7 Sep 2026 04:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788755119; cv=none; b=qjpRuQmd7Oo26zquBgJYpavMpzt+DPxAR2v0Hvy4OK16saiHNhVUsHNJdik1+dlaxNs1g8oFDbydC4YoMyTAPdqZpWl/yFDw8PNhLjxPEFqq7KVkk6SRLdS0ZyT8LPDQFjSq3YIVCcTIbppewhsSuj0+Gkx6ju9/AMCB+AGFCNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788755119; c=relaxed/simple;
	bh=Jbny74B2XUl665ileo3NxiVqwkgsYfvODE6XdZTx5c0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=b7qUWOkVC2GJFBg4UaFNClOJgzQ9e4XUJ8si6Yebou3DILZ/Eqvyd0bWLhPIh1nXMuyeNqE3XXft62GmxY8EjlXFPvim3KNR5Gr6ruEIfdrd5zAcc1nMh74mD7n71L4mWl+cT2781rg2E6VRl8kbQ+sMSPgFiQ650OAQsSIAH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHOrdQ9U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHOrdQ9U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30411F00A3A;
	Mon,  7 Sep 2026 04:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788755117;
	bh=fw1DcyXyhPsEEwEUfHYH32NIia+v6zBbRNq6QR924ks=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iHOrdQ9UVJgc8dh0byWOBQ8SEaoNoiQJl1r7kv3Wfg4pCfGm9WWr2AzlVL2eddjHW
	 hL64Mzrc3SnOtW1mPfzcqGnbV3926H8CMqZTgS8b9UsEIs4EezaSZE+4IeeejyFmZs
	 fiBxXDLvZ0X6UquR75ImM1t2RmacQrPNssLWjqusMB0iPgBPF6THk3YgE+spYWBxJK
	 olAIw5j6CILJY6b6M9fx7rN3sHjmZaA7cFE5qjgwnLg/kjVtU/c1JOmReLfFvMOlYO
	 W1Lpqsl/qC9EDbGRXgyJuaHqEUXfz98Ws+2y97o2uNJpjbuaqFhIScMkv2OU9df9U+
	 MaMIj8mdYVdaA==
Content-Type: multipart/mixed; boundary="===============6642577418312215302=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0846fe9c15dc189bd3cd979839ddd7101f79979217dda130d0800b047589f9fe@mail.kernel.org>
In-Reply-To: <178874713816.1519295.12130500880299787860.flags-v3-1@tychen.cc>
References: <178874713816.1519295.12130500880299787860.flags-v3-1@tychen.cc>
Subject: Re: [PATCH bpf-next v3 1/2] bpftool: Accept symbolic map creation flags
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: qmo@kernel.org,linux-kselftest@vger.kernel.org,hi@tychen.cc,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  7 Sep 2026 04:25:16 +0000 (UTC)

--===============6642577418312215302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> index 5daf3de5c744..375321d55823 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> @@ -76,9 +76,16 @@ bpftool map { show | list }   [*MAP*]
>  bpftool map create *FILE* type *TYPE* key *KEY_SIZE* value *VALUE_SIZE*  entries *MAX_ENTRIES* name *NAME* [flags *FLAGS*] [inner_map *MAP*] [offload_dev *NAME*]
>      Create a new map with given parameters and pin it to *bpffs* as *FILE*.
>
> -    *FLAGS* should be an integer which is the combination of desired flags,
> -    e.g. 1024 for **BPF_F_MMAPABLE** (see bpf.h UAPI header for existing
> -    flags).
> +    *FLAGS* accepts an unsigned 32-bit integer combining the desired flags
> +    (decimal, hexadecimal with a **0x** prefix, or octal with a **0** prefix),
> +    or a comma-separated list of full, case-sensitive map creation flag names
> +    from the bpf.h UAPI header. For example, **1024**, **0x400**, and
> +    **BPF_F_MMAPABLE** are equivalent. Multiple names are combined with
> +    bitwise OR, for example **BPF_F_NO_PREALLOC,BPF_F_RDONLY_PROG**.
> +    Repeated names are allowed. Empty list elements, abbreviated names, and
> +    lists mixing numbers with names are not accepted. Use **0** for no flags.
> +    Numeric values can include bits unknown to bpftool. The kernel checks
> +    whether the flags are valid for the requested map type.

[ ... ]

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 684a8fb72414..4445014247d6 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c

[ ... ]

> @@ -1474,6 +1554,7 @@ static int do_help(int argc, char **argv)
>  		"       DATA := { [hex] BYTES }\n"
>  		"       " HELP_SPEC_PROGRAM "\n"
>  		"       VALUE := { DATA | MAP | PROG }\n"
> +		"       FLAGS := { integer | BPF_F_NAME[,BPF_F_NAME...] }\n"
>  		"       UPDATE_FLAGS := { any | exist | noexist }\n"
>  		"       TYPE := { hash | array | prog_array | perf_event_array | percpu_hash |\n"
>  		"                 percpu_array | stack_trace | cgroup_array | lru_hash |\n"

The help text gained a FLAGS metavariable production, but the man page
synopsis did not. Looking at bpftool-map.rst, the synopsis section lists
metavariable productions like:

    | *MAP* := { ... }
    | *DATA* := { [**hex**] *BYTES* }
    | *PROG* := { ... }
    | *VALUE* := { *DATA* | *MAP* | *PROG* }
    | *UPDATE_FLAGS* := { **any** | **exist** | **noexist** }
    | *TYPE* := { **hash** | ... }

Should there be a corresponding line for FLAGS in the synopsis? Before
this patch, every metavariable in the map.c help block had a matching
production in the rst synopsis. The FLAGS metavariable is now the only
one that appears in the help text but not in the synopsis.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34075962636
--===============6642577418312215302==--
