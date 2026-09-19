Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7BF4718C2;
	Sat, 19 Sep 2026 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789815487; cv=none; b=Yw+QrO5ST733C6s9WSVubxod3RbxNfGflQOLIkLULxqBcvPyISD7F/toytCoZl1NXaUiAr6H/+dUjRwQKzw730xH0QxDOxbma72AqE/vpfrn1qol3V18cqRr2v+5Qn1XNPoM66orhEg/e+qgnMVyHFTzrJmKjkbJg/LVslJBukQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789815487; c=relaxed/simple;
	bh=TaVj+3b14vT6k0Ii5z+03MFmQXVfMnls5tg9LOf7NIk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UtG3Kj83xTF00fa2knrZrjnrdNZxt4jkLjpKoQaoL4nfNDn9PMHpvaauXuJLGBG+qC2feIhk9tejHy8RTCtFnx7bNVUB0545yEQDOcMK2Z+bdO7X5u+ZKFsocFiw82SimNJ+/Bk51IOHgr/yGyx/dVVF65CKeKMG9+wuV4KZgDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F21au6lc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F21au6lc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE9F1F000FF;
	Sat, 19 Sep 2026 10:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789815485;
	bh=G3Q9JVNPeVatCTin9yOa9ai9BXWQ8jKY4rKL0xwmaWY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=F21au6lcrZGNmtRqXyyiO3WGHwd1pVNAYESr3vIBk0/uQaKSrpHe30tP8sREgpEBz
	 Lj8kVoCY7ihQBdvi/4asm2jcknTug9uIP+qG3ycKPqAGP8toc2KxdoaINLSCtvZmEt
	 LgEwvKQ2gFdEZqfefloTInsMlEp+xuW5FKc+ef8b3ygZ4nFS3KD2RYeVuklBqmPO/e
	 e2WqWPj1tW9iKcWhUHZxFvCfS8M9UFQpNOWDuTM0kDXGKLE2bXB01+1P7oPROic/aW
	 UaVpzf9vAn7gkcBeqp4xWDvcYN0V180SHd5t8grHKPSoGO3HTsq+K/+Lxv4t/+cTL3
	 Qn2d/gNesLpxw==
Content-Type: multipart/mixed; boundary="===============3854488706741688450=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ae4fd719188ae85855405378e066df2483b55a1d9667a65defa410f2f295681e@mail.kernel.org>
In-Reply-To: <20260919094400.600585-4-sh_def@163.com>
References: <20260919094400.600585-4-sh_def@163.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpftool: Add support for BPF_F_PREORDER cgroup attach flag
From: bot+bpf-ci@kernel.org
To: sh_def@163.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,qmo@kernel.org,martin.lau@linux.dev,song@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,sh_def@163.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 19 Sep 2026 10:58:03 +0000 (UTC)

--===============3854488706741688450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> index e8185596a759b..f8408ed44d748 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst

[ ... ]

> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 75cbcb512ebae..a51c68029e16f 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool

[ ... ]

> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index ce69d1e5468e3..6ea0492ea5327 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -56,7 +56,7 @@ static const int cgroup_attach_types[] = {
>  };
>
>  #define HELP_SPEC_ATTACH_FLAGS						\
> -	"ATTACH_FLAGS := { multi | override }"
> +	"ATTACH_FLAGS := { multi [ preorder ] | override [ preorder ] | preorder }"

[ ... ]

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

Can the comma-separated flag strings here misalign the Name column?

The new formatter produces strings like "override,preorder" (17 chars) and
"multi,override,preorder" (23 chars), but the plain-text output table in
do_show() and do_show_tree() formats the AttachFlags column with %-15s:

    printf("%-8s %-15s %-15s %-15s\n", "ID", "AttachType",
           "AttachFlags", "Name");

and show_bpf_prog() uses the same width:

    printf(" %-15s %-15s", attach_flags_str, prog_name);

Since %-15s doesn't truncate, strings exceeding 15 characters will push
the Name column to the right for those rows. Before this patch, the same
attachments displayed as "unknown(41)" or "unknown(42)", which fit within
15 characters.

> @@ -593,6 +612,8 @@ static int do_attach(int argc, char **argv)
>  			attach_flags |= BPF_F_ALLOW_MULTI;
>  		} else if (is_prefix(argv[i], "override")) {
>  			attach_flags |= BPF_F_ALLOW_OVERRIDE;
> +		} else if (is_prefix(argv[i], "preorder")) {
> +			attach_flags |= BPF_F_PREORDER;
>  		} else {
>  			p_err("unknown option: %s", argv[i]);
>  			goto exit_cgroup;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35436378806
--===============3854488706741688450==--
