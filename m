Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE2388880;
	Mon,  7 Sep 2026 02:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746676; cv=none; b=QqMBG1TFbtINg1oCdQDrZwXwnFGmDBWV0MF12j3OnJUv/ce4HX9s249bNxuh2vhFJPgSDNjrBXPC0msfyQkmL33QUnVpMyuRPwNl/6bbhRhYl8nO/548kgQH27Tzf8Fezzt1OvBVcNuXkPKBP1pajz5eMb5+twj0NxzQVpL2BXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746676; c=relaxed/simple;
	bh=wrsfoxpKPp2N4g35RwCeggQYTQXhK53KMAL2c9LODJY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=r5b7Cuw3ngoI8Mc6KKmj0XneLdNE8QmI69JSMFDmpeJXDsITRHGF/8TJM+Q5PnnYT3bkfIGxg/8T1fDA9+DUvN0u1a39ekmTWPRv9rNbRjGbd8Fx8jG7UomC/PCR2K5dmvVI3FV7yDFT4EgpMOYEjRxIn8DAtxlCJAUT8EqoRNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl5Vc/C2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl5Vc/C2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1431F00A3D;
	Mon,  7 Sep 2026 02:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746672;
	bh=lfnMXuVdvYsnw767Cdxmc7iR2CyNBtGNakS4fwshBdo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Bl5Vc/C2NdWUPvnUHCDjEvzBR1oXyyGfTe21GIKCdnUN2opDWE/ych5RwzmEJiIuR
	 sPvIpIHdZSBNtuitCYFd+9XdjJZyVmh/Z1vryk1dlIgLfWZn3fZVTxiMbRrkP6ycAR
	 5jqTw+tnvO9d7o8hkeXoFcduy6R3vOiE5/M3rt2uhFrvA60aNW50M+0AFMDIOL65nI
	 eM036KQIJw8j3EBpdLnNqZXpGGGHGgJkdd9S8ycJZcyB7dN0JZKL65ysio4p3OKEzS
	 M8+VyeXUt6vcuUwArbvI2lI4UKnkTNjwMdwf2oFh95xmaVqAHsf6LL3Pug/FqVe4zI
	 i5NI6Xm7lRAJA==
Content-Type: multipart/mixed; boundary="===============1891907528938122853=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <693f57c4fee08005c6e67811a2fbc497e95fbb7373154e9ecdb1f9a76afaba60@mail.kernel.org>
In-Reply-To: <178874362959.1415955.3136948443938068365.flags-v2-1@tychen.cc>
References: <178874362959.1415955.3136948443938068365.flags-v2-1@tychen.cc>
Subject: Re: [PATCH bpf-next v2 1/2] bpftool: Accept symbolic map creation flags
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: hi@tychen.cc,qmo@kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  7 Sep 2026 02:04:31 +0000 (UTC)

--===============1891907528938122853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 75cbcb512eba..73f6a8118267 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -718,6 +718,10 @@ _bpftool()
>                      esac
>                      ;;
>                  create)
> +                    # Keep a flags list together if readline splits at commas.
> +                    if [[ $COMP_WORDBREAKS == *,* && ( $cur == , || $prev == , ) ]]; then
> +                        _get_comp_words_by_ref -n , cur prev
> +                    fi
>                      case $prev in
>                          $command)
>                              _filedir
> @@ -729,7 +733,27 @@ _bpftool()
>                              COMPREPLY=( $( compgen -W "$BPFTOOL_MAP_CREATE_TYPES" -- "$cur" ) )
>                              return 0
>                              ;;
> -                        key|value|flags|entries)
> +                        flags)
> +                            compopt -o nospace
> +                            local flags='BPF_F_NO_PREALLOC BPF_F_NO_COMMON_LRU
> +                                BPF_F_NUMA_NODE BPF_F_RDONLY BPF_F_WRONLY
> +                                BPF_F_STACK_BUILD_ID BPF_F_ZERO_SEED
> +                                BPF_F_RDONLY_PROG BPF_F_WRONLY_PROG BPF_F_CLONE
> +                                BPF_F_MMAPABLE BPF_F_PRESERVE_ELEMS BPF_F_INNER_MAP
> +                                BPF_F_LINK BPF_F_VTYPE_BTF_OBJ_FD BPF_F_TOKEN_FD
> +                                BPF_F_SEGV_ON_FAULT BPF_F_NO_USER_CONV
> +                                BPF_F_RB_OVERWRITE'
                                ^^^^

This isn't a bug, but the flag names are spelled out both here and in
map_create_flags[] in map.c. Since the `type)` branch just above already
sources its list from `bpftool feature list_builtins map_types`, would
it be worth exposing the flag names the same way so the two copies cannot
drift?

> +                            local prefix= flag
> +                            # Readline replaces only the suffix after a word break.
> +                            if [[ $cur == *,* && $COMP_WORDBREAKS != *,* ]]; then
                                  ^^^^

This isn't a bug, but would it read more directly if this comment named
the case the branch handles, that when a comma is not a word break,
readline replaces the whole word and the already-typed prefix has to be
repeated?

> +                                prefix="${cur%,*},"
> +                            fi
> +                            for flag in $(compgen -W "$flags" -- "${cur##*,}"); do
> +                                COMPREPLY+=( "${prefix}${flag}" )
> +                            done
> +                            return 0
> +                            ;;
> +                        key|value|entries)
>                              return 0
>                              ;;
>                          inner_map)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34073340278
--===============1891907528938122853==--
