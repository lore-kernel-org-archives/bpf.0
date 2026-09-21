Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DA749EC74;
	Mon, 21 Sep 2026 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998140; cv=none; b=TKDULMX4Pgj8YvcVmx7WB2WXgfwV29/SluAscs4f2bfamAKjsfIiTOT5G8s0sh5t8V/ACps4PeqpJ9oH0yiJeIU6xnhU2icg0EUEjHTOTYpdLavhc7ug1Xp5dyOukmJNzvzgFxnlEKf4djj2z4DtRwYDe1xJ6z0tOKA70p8QnUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998140; c=relaxed/simple;
	bh=7G9UEBLZgbrN9P4Cfw5Muu4RseL/ECoPsopwRmszSCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7s1F05zwAfv34TgB451PYQct+5ibtrya/aQZMEQ0qdcrmlcaFVHcwH98wnQHtBCK/3IBNAXFVdTmnpy6926hep0ZomQInYAuyPJnglYfkS8AdajKR7JP9oAZdhqNJOM4VwWvCYAcVZcETx6bJa32MeYAr2qlzeMHtpSCBygpU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlkpR2nE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlkpR2nE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A8C1F000FF;
	Mon, 21 Sep 2026 13:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998137;
	bh=Gq0vTj/q+xiEShcvzmhfh6dP6o4g9VLSysSl8QLb3j8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WlkpR2nE17QOZ6zGUzSrJYVr8Kw3DFKfWXsMDeXpbY+q0KIooRx7jZ/crujoKwIwp
	 m63RatM18OEByBGSwPX2q+FotJNoCQPBNvXvPB/Fmcj+5qXrfio/133IaZEmn/P972
	 yqtxRCVFdNAN5Hcybu9jTEvMHsNOfP1GV/VT6SWGnDNPUhpHw6Pu2wi4zRY8FzWmaF
	 R03773xsMgXlHXexWISvTUm7XdEjDyHqX3tz4CqvTd14uy3haNipAJtfOt2Dgv57kq
	 nHBV/U6bSEc+kbXmd5dDsQ2B9kMKuJDbi5GNoGz2DB1AOJvrkTmfbnTXqQkM0NvaIB
	 xak/UDyaYsmUA==
Message-ID: <15ea6ca1-e891-4929-bd58-c0e561b1cf6b@kernel.org>
Date: Mon, 21 Sep 2026 14:42:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/3] bpftool: Add support for BPF_F_PREORDER
 cgroup attach flag
To: Hui Su <sh_def@163.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260919094400.600585-1-sh_def@163.com>
 <20260919094400.600585-4-sh_def@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260919094400.600585-4-sh_def@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-19 18:44 UTC+0900 ~ Hui Su <sh_def@163.com>
> Commit 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs")
> introduced BPF_F_PREORDER to request pre-order execution across the
> cgroup hierarchy. Furthermore, attachments legitimately use combinations
> such as BPF_F_ALLOW_MULTI | BPF_F_PREORDER or
> BPF_F_ALLOW_OVERRIDE | BPF_F_PREORDER.
> 
> With BPF_PROG_QUERY reporting the per-program BPF_F_PREORDER attribute,
> bpftool's exact-match formatter falls back to "unknown(40)" when
> BPF_F_PREORDER is present alone, or "unknown(41)" / "unknown(42)" when
> combined with BPF_F_ALLOW_OVERRIDE or BPF_F_ALLOW_MULTI. Additionally,
> do_attach() only accepts "multi" and "override", rejecting "preorder" with
> "unknown option".
> 
> Before:
>   $ bpftool cgroup show <cg>
>   1234  cgroup_inet_ingress  unknown(42)  test_prog
>   $ bpftool cgroup attach <cg> cgroup_inet_ingress id 5678 multi preorder
>   Error: unknown option: preorder
> 
> After:
>   $ bpftool cgroup show <cg>
>   1234  cgroup_inet_ingress  multi,preorder  test_prog
>   $ bpftool cgroup attach <cg> cgroup_inet_ingress id 5678 multi preorder
>   (attaches successfully)
> 
> Refactor the attach flags formatter into a bitmask formatter that outputs
> comma-separated flag names while preserving unrecognized bits as
> "unknown(...)". Accept "preorder" in do_attach(), update the cgroup
> documentation and synopsis to express valid flag combinations, and teach
> bash completion about them ("multi" or "override" optionally combined with
> "preorder").
> 
> Signed-off-by: Hui Su <sh_def@163.com>


Thank you, please find some comments inline below:


> ---
>  .../bpftool/Documentation/bpftool-cgroup.rst  | 25 ++++++---
>  tools/bpf/bpftool/bash-completion/bpftool     |  4 +-
>  tools/bpf/bpftool/cgroup.c                    | 55 +++++++++++++------
>  3 files changed, 56 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> index e8185596a759..f8408ed44d74 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> @@ -45,7 +45,7 @@ CGROUP COMMANDS
>  |     **cgroup_unix_recvmsg** | **cgroup_sysctl** |
>  |     **cgroup_getsockopt** | **cgroup_setsockopt** |
>  |     **cgroup_inet_sock_release** }
> -| *ATTACH_FLAGS* := { **multi** | **override** }
> +| *ATTACH_FLAGS* := { **multi** [ **preorder** ] | **override** [ **preorder** ] | **preorder** }


This looks more complex than it should, I think this should work just as
well:

    *ATTACH_FLAGS* := { [ **multi** | **override** ] [ **preorder** ] }

(and same for HELP_SPEC_ATTACH_FLAGS in cgroup.c)


>  
>  DESCRIPTION
>  ===========
> @@ -75,20 +75,27 @@ bpftool cgroup attach *CGROUP* *ATTACH_TYPE* *PROG* [*ATTACH_FLAGS*]
>      Attach program *PROG* to the cgroup *CGROUP* with attach type *ATTACH_TYPE*
>      and optional *ATTACH_FLAGS*.
>  
> -    *ATTACH_FLAGS* can be one of: **override** if a sub-cgroup installs some
> +    *ATTACH_FLAGS* can include: **override** if a sub-cgroup installs some
>      bpf program, the program in this cgroup yields to sub-cgroup program;
>      **multi** if a sub-cgroup installs some bpf program, that cgroup program
> -    gets run in addition to the program in this cgroup.
> +    gets run in addition to the program in this cgroup;
> +    **preorder** requests that this program executes in ancestor-to-descendant
> +    order before non-preorder descendants-to-ancestors programs during evaluation
> +    across the cgroup hierarchy. Note that **preorder** alone does not enable
> +    multi-program attachment; specify **multi** together with **preorder** to
> +    attach multiple programs.
>  
> -    Only one program is allowed to be attached to a cgroup with no attach flags
> -    or the **override** flag. Attaching another program will release old
> -    program and attach the new one.
> +    Only one program is allowed to be attached to a cgroup unless the
> +    **multi** flag is specified. Without **multi**, attaching another program
> +    replaces the existing program, provided the **override** setting matches.
>  
>      Multiple programs are allowed to be attached to a cgroup with **multi**.
> -    They are executed in FIFO order (those that were attached first, run
> -    first).
> +    Programs marked with **preorder** are placed before non-preorder programs
> +    in the effective program array. Within each ordering class at the same
> +    cgroup level, attachment order is preserved.
>  
> -    Non-default *ATTACH_FLAGS* are supported by kernel version 4.14 and later.
> +    **multi** and **override** are supported by kernel version 4.14 and later.
> +    **preorder** was introduced upstream in Linux 6.15.
>  
>      *ATTACH_TYPE* can be one of:
>  
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 75cbcb512eba..a51c68029e16 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -1057,7 +1057,6 @@ _bpftool()
>                  attach|detach)
>                      local BPFTOOL_CGROUP_ATTACH_TYPES="$(bpftool feature list_builtins attach_types 2>/dev/null | \
>                          grep '^cgroup_')"
> -                    local ATTACH_FLAGS='multi override'
>                      # Check for $prev = $command first
>                      if [ $prev = $command ]; then
>                          _filedir
> @@ -1087,7 +1086,8 @@ _bpftool()
>                                  # "id|pinned|tag|name" (we already checked for
>                                  # that). This should only leave the case when
>                                  # we need attach flags for "attach" commamnd.
> -                                _bpftool_one_of_list "$ATTACH_FLAGS"
> +                                _bpftool_one_of_list 'multi override'
> +                                _bpftool_once_attr 'preorder'
>                              fi
>                              return 0
>                              ;;
> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index ce69d1e5468e..6ea0492ea532 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -56,7 +56,7 @@ static const int cgroup_attach_types[] = {
>  };
>  
>  #define HELP_SPEC_ATTACH_FLAGS						\
> -	"ATTACH_FLAGS := { multi | override }"
> +	"ATTACH_FLAGS := { multi [ preorder ] | override [ preorder ] | preorder }"
>  
>  #define HELP_SPEC_ATTACH_TYPES						\
>  	"       ATTACH_TYPE := { cgroup_inet_ingress | cgroup_inet_egress |\n" \
> @@ -269,6 +269,39 @@ static int show_effective_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
>  	return 0;
>  }
>  
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


I'm fine with that for bpftool's plain output. For JSON, given that we
introduce a change here already (output will be "multi,preorder" when
BPF_F_PREORDER is set, instead of "multi" previously), we should maybe
take that chance to print an array instead? Like this:

    "attach_flags": [ "multi", "preorder" ]


> +
> +	if (attach_flags)
> +		snprintf(buf + len, sz - len, "%sunknown(%x)",
> +			 len ? "," : "", attach_flags);
> +
> +	return buf;
> +}
> +
>  static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
>  				   int level)
>  {
> @@ -276,7 +309,7 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
>  	__u32 prog_attach_flags[1024] = {0};
>  	const char *attach_flags_str;
>  	__u32 prog_ids[1024] = {0};
> -	char buf[32];
> +	char buf[64];
>  	__u32 iter;
>  	int ret;
>  
> @@ -296,21 +329,7 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
>  		__u32 attach_flags;
>  
>  		attach_flags = prog_attach_flags[iter] ?: p.attach_flags;
> -
> -		switch (attach_flags) {
> -		case BPF_F_ALLOW_MULTI:
> -			attach_flags_str = "multi";
> -			break;
> -		case BPF_F_ALLOW_OVERRIDE:
> -			attach_flags_str = "override";
> -			break;
> -		case 0:
> -			attach_flags_str = "";
> -			break;
> -		default:
> -			snprintf(buf, sizeof(buf), "unknown(%x)", attach_flags);
> -			attach_flags_str = buf;
> -		}
> +		attach_flags_str = format_attach_flags(attach_flags, buf, sizeof(buf));
>  
>  		show_bpf_prog(prog_ids[iter], type,
>  			      attach_flags_str, level);
> @@ -593,6 +612,8 @@ static int do_attach(int argc, char **argv)
>  			attach_flags |= BPF_F_ALLOW_MULTI;
>  		} else if (is_prefix(argv[i], "override")) {
>  			attach_flags |= BPF_F_ALLOW_OVERRIDE;
> +		} else if (is_prefix(argv[i], "preorder")) {
> +			attach_flags |= BPF_F_PREORDER;
>  		} else {
>  			p_err("unknown option: %s", argv[i]);
>  			goto exit_cgroup;

