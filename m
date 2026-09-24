Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448594A6CFC;
	Thu, 24 Sep 2026 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265579; cv=none; b=pPrIW2FFscAm85EGQ2dokF4ZTiv+sSH/aiA/43q+1BdPzBe0b1bF1CdYSukkN+fyAZCeDw/cnym9IH+78tOdrGoaHWPWRuIFlCWftpzA9xuvkncQlnhypHCsWk4PktpVQhYmQuHoq4/710wBy3jsg3aGZIQo1i7rbF9ee0gEs58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265579; c=relaxed/simple;
	bh=EXdRAtBwTkCWGQ/vJb4zvnE/HU1tvhD44zHQuxXPHUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RydHqEkwAU3b9l/H5hTEC/VF9UhAsSTpIXWk6yX5LCIm9VD3rsX5H0koI8wbgd7gXreq4IM7FpDfH1dd1Q3l5uxO0ZfzWE+umWBJr7ZvkjVeQlmny1x2iGMOoqo3dDnE9NTfP3fKj2J4EmKOkcS7uI0JycqfaamL2d4tVA+VbOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksRRI1sE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksRRI1sE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFC41F0089B;
	Thu, 24 Sep 2026 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790265577;
	bh=j9R8rPTq/I0uphSc3nDpTaHkQfGKBamRXLvAcZ4XwdE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ksRRI1sExQqUrr2oCvIAAYeUREd2dctLG/g1aTav6DxqYWKjJypGwBm1JeH+IoLbg
	 pty8olYSObjQmFXr9Y4cL2LcvdW34rZgJYdrrxfRH6kvnMMLzbmDKk4aFLXHlC9wIf
	 0wVl3+FkbVxyNW47eWFYKUBxgnuNQPuQo/R1JATRiW9kqYEor6mmefsO+hU6+ElwIc
	 qy04RXXlP2UWBdFLEOhe1TWTSm0nj0GtvAJHbb12h16GMdtQYW+EYj0erhW1iuljbB
	 ZOk/Dvy/daDg3d8kyeoe2k5u7EKmnOMvEDy3k0WUSfEjLIM0MDJ4CKguZnrRmORhmo
	 pjKKeftwgjzbQ==
Message-ID: <44ec5184-5a77-413d-9f42-fd93b0abbf11@kernel.org>
Date: Thu, 24 Sep 2026 16:59:35 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 1/2] bpftool: Add recursive map dumping
To: Tianyi Chen <diannaaav@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260911051053.283421-1-diannaaav@gmail.com>
 <20260911051053.283421-2-diannaaav@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260911051053.283421-2-diannaaav@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-11 13:10 UTC+0800 ~ Tianyi Chen <diannaaav@gmail.com>
> From: Tianyi Chen <hi@tychen.cc>
> 
> Dumping a map-of-maps currently shows inner map IDs without their
> contents. Add -r/--recursive to dump referenced inner maps as well,
> leaving the default output unchanged. Show the selected maps followed
> by distinct discovered inner maps, preserving plain and BTF formatting
> and using an array of map objects for JSON output.
> 
> Holding every discovered inner-map FD open would make descriptor use
> grow with the number of maps and could exhaust RLIMIT_NOFILE. Keep the
> selected map FDs open, queue distinct inner map IDs, and open, dump and
> close each queued map in turn. This needs only one additional map FD.
> The tradeoff is deferred ID resolution: concurrently removed inner
> maps can disappear before they are opened, so the dump is not atomic.
> 
> Report failure when an inner map cannot be opened, retain per-entry
> lookup errors, and close JSON containers before returning.
> 
> Link: https://github.com/libbpf/bpftool/issues/58
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>

Hi, and thanks for working on this!

Please find some comments below.

> ---
>  .../bpf/bpftool/Documentation/bpftool-map.rst |  22 ++-
>  tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
>  tools/bpf/bpftool/main.c                      |   7 +-
>  tools/bpf/bpftool/main.h                      |   1 +
>  tools/bpf/bpftool/map.c                       | 130 ++++++++++++++++--
>  5 files changed, 151 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> index 5daf3de5c74..23faa672685 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> @@ -16,7 +16,8 @@ SYNOPSIS
>  
>  **bpftool** [*OPTIONS*] **map** *COMMAND*
>  
> -*OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } | { **-n** | **--nomount** } }
> +*OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } |
> +{ **-n** | **--nomount** } | { **-r** | **--recursive** } }

Nitpick: I'd rather break the line after |COMMON_OPTIONS|, like in
bpftool-prog.rst.

>  
>  *COMMANDS* :=
>  { **show** | **list** | **create** | **dump** | **update** | **lookup** | **getnext** |
> @@ -170,6 +171,25 @@ OPTIONS
>      Do not automatically attempt to mount any virtual file system (such as
>      tracefs or BPF virtual file system) when necessary.
>  
> +-r, --recursive
> +    Also dump the inner maps referenced by **array_of_maps** and **hash_of_maps**
> +    entries when running **map dump**. Each map ID is visited once, even if
> +    several entries refer to it. Selected maps are followed by their inner maps.

OK

> +
> +    Plain output includes a header identifying each map. On success, JSON output
> +    is always an array of map objects, each containing an **id** and an
> +    **elements** array, including when only one map is dumped. Outer map entries
> +    retain their **inner_map_id** field, which identifies the corresponding inner
> +    map object.

I'm not sure we need such a detailed description of the output format in
the man page. Please remove.

> +
> +    Inner map IDs are resolved when the maps are visited. The dump is not an
> +    atomic snapshot: concurrent updates can change map contents or remove a
> +    referenced inner map before it is visited. Failure to open a referenced
> +    inner map stops the dump and returns a nonzero exit status. Output may
> +    contain maps or entries printed before the error.

Same thing, I'm not sure this is necessary. Maybe just keep the first
half (the note about the maps susceptible to change during the dump).

> +
> +    In JSON mode, the enclosing arrays and objects are closed before returning.

Let's get rid of this, please.

> +
>  EXAMPLES
>  ========
>  **# bpftool map show**
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 75cbcb512eb..45c336d63be 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -261,7 +261,7 @@ _bpftool()
>  
>      # Deal with options
>      if [[ ${words[cword]} == -* ]]; then
> -        local c='--version --json --pretty --bpffs --mapcompat --debug \
> +        local c='--version --json --pretty --recursive --bpffs --mapcompat --debug \
>              --use-loader --base-btf --sign -i -k'
>          COMPREPLY=( $( compgen -W "$c" -- "$cur" ) )
>          return 0
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 5ababd8f7d0..c0f4df10102 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -26,6 +26,7 @@ static int (*last_do_help)(int argc, char **argv);
>  json_writer_t *json_wtr;
>  bool pretty_output;
>  bool json_output;
> +bool recursive_dump;
>  bool show_pinned;
>  bool block_mount;
>  bool verifier_logs;
> @@ -456,6 +457,7 @@ int main(int argc, char **argv)
>  		{ "json",	no_argument,	NULL,	'j' },
>  		{ "help",	no_argument,	NULL,	'h' },
>  		{ "pretty",	no_argument,	NULL,	'p' },
> +		{ "recursive",	no_argument,	NULL,	'r' },

The "recursive" option that you add is specific to a single subcommand
for "bpftool map". It's true that some other options behave in a similar
way, but overall, bpftool tends to use dash-options when it affects the
generic behaviour (perfect example: JSON flags), and keywords otherwise.
In the current case, given that we don't really have an equivalent use
for "recursive" for the other commands, I'd keep it a keyword:

    bpftool map dump id 1337 recursive

Could you change it, please?

The code itself looks good to me, thanks for working on this!

Quentin
