Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08F951CF4D;
	Fri, 18 Sep 2026 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755817; cv=none; b=dW5lfldy/jyMm7mOGe0hk6/t9U8u6fSwtq1gMf0B15LCEI5l5vyJz+G5w6vTpyMuLoHpb+OE07lteptKiE1LkOMJC56BaVZ8Nx2Bx8fS/UJHfB9eyVvKGY/b7xuEnDNi6Z/GbVqBLQeL3SAbvUZ3/RUduz0jh/ZM3uUe+Tkixpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755817; c=relaxed/simple;
	bh=ds4akJx3jVDhQFoPnsriXNF1Xf/fi0gcnvJ9js2osaI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tY0VqgPhctu9jvuXznuIny5SbC/SpCdU7Xqhbictuvsyi8rcdmG82eBC8cIwj26UE79WJrDGLifz3bLeK6K+Y1PCaTUKG1XIvJmLSnfNJYqHUX5mimjqHDJJmrTm4fU3aKwhRFimePA5CBgeKGcBxL07aYkRjFCt5Tw/IEFQeC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQn212f6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQn212f6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DED81F000FF;
	Fri, 18 Sep 2026 18:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789755815;
	bh=EhOkcofJ+VSseC/MrnCuvzNPQo1pcFtzuqMMp3RviM0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bQn212f6NvqS5KJuE9e5LwXmVfLuaDZI4kPzk2CiOyrl8PM8VhD7Ad9ZQ1u3Z88Rg
	 dfqYzjjjnX5fe7Uferl6aj1CF1u9aLqrknwOtdNXmJWvNSS4/es6PzT8Jpnx/sxSdn
	 Rvbsah6gtMYbA3Vr5mqzGukmtaeX2kc7qzz7n8EYZ0Kk1A40/4vun56jRHhdeh/VRF
	 7HFta6qGstqlN9bWWhLmDuKRsQeftZ7X+Dctr48lHzdX8V6s4Xb3i1wb5QpFmMVRVB
	 expYLyBrbdxI/HKhy/oRbfGi/ZkkFossPbUggtyGTq2RPBiGzrrm/j+pXbm/NMcHfN
	 C1Qwk2diBJY3Q==
Content-Type: multipart/mixed; boundary="===============3058400590292680710=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8cd509dcf036d6709a87cd6960fffd9a04510654e12b2bf45e76445cb5aaa724@mail.kernel.org>
In-Reply-To: <20260918172407.3459188-4-sh_def@163.com>
References: <20260918172407.3459188-4-sh_def@163.com>
Subject: Re: [PATCH bpf 3/3] bpftool: Add support for BPF_F_PREORDER cgroup attach flag
From: bot+bpf-ci@kernel.org
To: sh_def@163.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,qmo@kernel.org,martin.lau@linux.dev,song@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,sh_def@163.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 18:23:34 +0000 (UTC)

--===============3058400590292680710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> index e8185596a759b..8ec2546c0b8ee 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> @@ -45,7 +45,7 @@ CGROUP COMMANDS
> |     **cgroup_unix_recvmsg** | **cgroup_sysctl** |
> |     **cgroup_getsockopt** | **cgroup_setsockopt** |
> |     **cgroup_inet_sock_release** }
> -| *ATTACH_FLAGS* := { **multi** | **override** }
> +| *ATTACH_FLAGS* := { **multi** | **override** | **preorder** }
>
> DESCRIPTION
> ===========
> @@ -75,10 +75,13 @@ bpftool cgroup attach *CGROUP* *ATTACH_TYPE* *PROG* [*ATTACH_FLAGS*]
>     Attach program *PROG* to the cgroup *CGROUP* with attach type *ATTACH_TYPE*
>     and optional *ATTACH_FLAGS*.
>
> -    *ATTACH_FLAGS* can be one of: **override** if a sub-cgroup installs some
> +    *ATTACH_FLAGS* can include: **override** if a sub-cgroup installs some
>     bpf program, the program in this cgroup yields to sub-cgroup program;
>     **multi** if a sub-cgroup installs some bpf program, that cgroup program
> -    gets run in addition to the program in this cgroup.
> +    gets run in addition to the program in this cgroup;
> +    **preorder** requests that this program executes before programs attached
> +    further down the cgroup hierarchy during evaluation. **preorder** can be
> +    combined with **multi**.

Does the new description accurately capture BPF_F_PREORDER's ordering
behavior? The paragraph says preorder programs execute "before programs
attached further down the cgroup hierarchy", which focuses on descendant
cgroups. But compute_effective_progs() in kernel/bpf/cgroup.c places all
preorder programs before all non-preorder programs regardless of where they
are attached:

    fstart = preorder_cnt;
    bstart = preorder_cnt - 1;
    ...
        if (pl->flags & BPF_F_PREORDER) {
            item = &progs->items[bstart];
            bstart--;
        } else {
            item = &progs->items[fstart];
            fstart++;
        }

This means a preorder program runs before every non-preorder program,
including those attached in the same cgroup and in ancestor cgroups. Commit
4b82b181a26c's example shows root with p1,p2 and a child with p3,p4 where
p2 and p4 are preorder - the effective order is "p2 p4 p3 p1". So the
child's preorder p4 runs before the root's non-preorder p1, and p2 runs
before its same-cgroup sibling p1.

Also, the paragraph says preorder "can be combined with multi", but
do_attach() now accepts "preorder" as a standalone flag. When used alone
(without multi), does __cgroup_bpf_attach() stay in the NONE regime where
"Only one program is allowed to be attached to a cgroup"? The phrase "can
be combined" leaves it ambiguous whether preorder alone enables multi-prog
attachment.

>
>     Only one program is allowed to be attached to a cgroup with no attach flags
>     or the **override** flag. Attaching another program will release old

[ ... ]

> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 75cbcb512ebae..819757d7a3609 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -1057,7 +1057,7 @@ _bpftool()
>                 attach|detach)
>                     local BPFTOOL_CGROUP_ATTACH_TYPES="$(bpftool feature list_builtins attach_types 2>/dev/null | \
>                         grep '^cgroup_')"
> -                    local ATTACH_FLAGS='multi override'
> +                    local ATTACH_FLAGS='multi override preorder'
>                     # Check for $prev = $command first
>                     if [ $prev = $command ]; then
>                         _filedir

Can bash completion handle combined flags after this change? The commit
message's After: example shows:

  $ bpftool cgroup attach <cg> cgroup_inet_ingress id 5678 multi preorder

and the rst documentation states "preorder can be combined with multi". But
ATTACH_FLAGS is passed to _bpftool_one_of_list(), which is defined as:

    _bpftool_one_of_list()
    {
        _bpftool_search_list $* && return 1
        COMPREPLY+=( $( compgen -W "$*" -- "$cur" ) )
    }

This helper returns early once any word from the list is already on the
command line, leaving COMPREPLY empty. That was correct when the list was
the mutually-exclusive pair {multi, override}, but now that preorder can
combine with multi, typing "... multi <TAB>" finds "multi" in the words
array and suppresses all completions. Won't this prevent completing the
second flag?

> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index ce69d1e5468e3..aec1281c95d8e 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -56,7 +56,7 @@ static const int cgroup_attach_types[] = {
> };
>
> #define HELP_SPEC_ATTACH_FLAGS						\
> -	"ATTACH_FLAGS := { multi | override }"
> +	"ATTACH_FLAGS := { multi | override | preorder }"

[ ... ]

> +static const char *format_attach_flags(__u32 attach_flags, char *buf, size_t sz)
> +{
> +	static const struct {
> +		__u32 flag;
> +		const char *name;
> +	} flags[] = {
> +		{ BPF_F_ALLOW_MULTI, "multi" },
> +		{ BPF_F_ALLOW_OVERRIDE, "override" },
> +		{ BPF_F_PREORDER, "preorder" },
> +	};
> +	size_t len = 0;
> +	size_t i;
> +	int n;
> +
> +	buf[0] = '\0';
> +	for (i = 0; i < ARRAY_SIZE(flags); i++) {
> +		if (attach_flags & flags[i].flag) {
> +			n = snprintf(buf + len, sz - len, "%s%s",
> +				     len ? "," : "", flags[i].name);
> +			if (n < 0 || (size_t)n >= sz - len)
> +				return buf;
> +			len += n;
> +			attach_flags &= ~flags[i].flag;
> +		}
> +	}
> +
> +	if (attach_flags)
> +		snprintf(buf + len, sz - len, "%sunknown(%x)",
> +			 len ? "," : "", attach_flags);
> +
> +	return buf;
> +}

[ ... ]

> @@ -593,6 +612,8 @@ static int do_attach(int argc, char **argv)
> 			attach_flags |= BPF_F_ALLOW_MULTI;
> 		} else if (is_prefix(argv[i], "override")) {
> 			attach_flags |= BPF_F_ALLOW_OVERRIDE;
> +		} else if (is_prefix(argv[i], "preorder")) {
> +			attach_flags |= BPF_F_PREORDER;
> 		} else {
> 			p_err("unknown option: %s", argv[i]);
> 			goto exit_cgroup;

[ ... ]

This looks like a bug fix for commit 4b82b181a26c. Should this include:

  Fixes: 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35376083935
--===============3058400590292680710==--
