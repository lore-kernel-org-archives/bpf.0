Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AACE3BD63B;
	Sun,  6 Sep 2026 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788718608; cv=none; b=RDA5P5Dn2PMU2iYG33TA9sBK+eXCZtqSnoG9B7wXXC9mItZyDb/0WYXuSULokPb4PX5oPC85kRdsMdCH+jiLd+fAT5D+ydu9QeWHjGJHAO9UQnjSVTvyb+TmGTKFJ7Hq+h9GGVfShGLaHEF/f7Rp0fZXSf7SacGSNn984ooE4gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788718608; c=relaxed/simple;
	bh=QkPEePJusca0XeNlKgfLyvPM4ZDLRJkEy8fbymwY3BQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TYY3SUXoHApbEipX1p4O3M0GOAZtAtVGSGECpCMJH/9e6wg82bFn5jXajk2jT+K3GyoDXlYu08LwZOHvZKPadpguOwsrunqzzUYTSqnjF0UM5b8rd3n3zr7rYegHNvzl8cUE+ZbCVhVbNyi3JRVHKjiS5OYLQ2l+EHUNyhZr+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gf9dTEW3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gf9dTEW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B676E1F00A3A;
	Sun,  6 Sep 2026 18:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788718606;
	bh=dWLQQI7KGKAWx4f1QUZU9odnYCM3xY9yWNAy0Ll+zNk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Gf9dTEW3SrrK4UeiCohSA8td/ueDwYh6LiP6Jl+JSXOipf0G0s9vmFeUTRUS5hP4u
	 TTVZWo8xlpEgKjEX+0m0xO/mfQlVbi9nffP5qWTEqmfexKRbSI/GbTJwUNmjEWEptI
	 1Vmw0a+5IVy2M7FButZV8wafHjbodsnR0MtEK1d0kpzkJ7Td3MHDF6x7MnU1VqEP1M
	 q4doAJZT/tqHoepnz6A624Kd92ukYJPrWxJocuCfCDRd+ZhzqjFFoyS4g5sg+xklnh
	 XnHUzZHTMLVc4KNMsZQHur6fbZ9G5zHOm/CbDBGg9jNG43srxBpbjX20dx/c6OHfmR
	 vyRPQbyV+1vRQ==
Content-Type: multipart/mixed; boundary="===============5451443486569008885=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4e6b09c913c4320ca7849be75acc2eb88b61564e7f3a75d768ef86c392b3786c@mail.kernel.org>
In-Reply-To: <20260906170715.1212085-2-hi@tychen.cc>
References: <20260906170715.1212085-2-hi@tychen.cc>
Subject: Re: [PATCH bpf-next 1/2] bpftool: Accept symbolic map creation flags
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: hi@tychen.cc,qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  6 Sep 2026 18:16:45 +0000 (UTC)

--===============5451443486569008885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 75cbcb512eba..95f16fff876e 100644
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
> @@ -729,7 +733,26 @@ _bpftool()
>                              COMPREPLY=( $( compgen -W "$BPFTOOL_MAP_CREATE_TYPES" -- "$cur" ) )
>                              return 0
>                              ;;
> -                        key|value|flags|entries)
> +                        flags)
> +                            local flags='BPF_F_NO_PREALLOC BPF_F_NO_COMMON_LRU
> +                                BPF_F_NUMA_NODE BPF_F_RDONLY BPF_F_WRONLY
> +                                BPF_F_STACK_BUILD_ID BPF_F_ZERO_SEED
> +                                BPF_F_RDONLY_PROG BPF_F_WRONLY_PROG BPF_F_CLONE
> +                                BPF_F_MMAPABLE BPF_F_PRESERVE_ELEMS BPF_F_INNER_MAP
> +                                BPF_F_LINK BPF_F_VTYPE_BTF_OBJ_FD BPF_F_TOKEN_FD
> +                                BPF_F_SEGV_ON_FAULT BPF_F_NO_USER_CONV
> +                                BPF_F_RB_OVERWRITE'
> +                            local prefix= flag
> +                            # Readline replaces only the suffix after a word break.
> +                            if [[ $cur == *,* && $COMP_WORDBREAKS != *,* ]]; then
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

Can the comma-separated completion work as written? When bash completes a
single match, it appends a trailing space, which splits the argument into
two words. Example:

  $ bpftool map create /sys/fs/bpf/m type hash key 4 value 4 \
    entries 1 name m flags BPF_F_MM<TAB>

completes to:

  ... flags BPF_F_MMAPABLE ,BPF_F_RDONLY

That becomes two argv words (the space before the comma). do_create() in
map.c consumes "flags BPF_F_MMAPABLE" and re-enters its loop with only
",BPF_F_RDONLY" left, so REQ_ARGS(2) fails with the message "'
BPF_F_MMAPABLE' needs at least 2 arguments, 1 found". To build a multi-
flag list the user has to delete the inserted space by hand, which defeats
the prefix-preservation logic at lines 745-749.

The usual fix is `compopt -o nospace` when emitting list elements (guarded
for shells without compopt), or suppressing the space only when more than
one flag remains plausible.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34048916873
--===============5451443486569008885==--
