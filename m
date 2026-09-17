Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472664D5978;
	Thu, 17 Sep 2026 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646645; cv=none; b=fUzQWo22QICQlTTTrcEzAI7CapHYJvqzXThds/vUU9ueELb1TsD8Lavxyd654zbO24bCdbxVy9aS1wGd1YjV3srGtr2eC8Blk+GyYSMI1gZuH38HP7XqO/u4szt8eLHqSn3g4p6q43lVKzD5lt15ACJX3lt8bakFI2tGvyEA4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646645; c=relaxed/simple;
	bh=27hrIHlTi/Xxb9kYCmvZTCbF2jcTeNf/ozQwRSb/PXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SaG7W53M9yrBm1q4tqVUabz0kEvg874MKK0idCC4FBhXxpmc33xRKsCB1CpBJV8Cqz3dLbQbUAvOPPDKfcnndeikKLohs02OXre96QnRje/Q2tBQYM5+LuDUcaJXUzOAUJWlFChZdWPriC7MGJFzgh8fA64qZQl8aVJDHnL77/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khrDcBto; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khrDcBto"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D651F00898;
	Thu, 17 Sep 2026 12:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789646626;
	bh=aUacRQG1g7tHz64HhFRLKgogcY6me3feXGZ84iqMDC0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=khrDcBtoiaSncXgdSk3jwvcK2bzD2aUf1iItol53CvkHZXoBiaJzsyld2HWYkOMwa
	 qyJBXrGeIEbpls1yHYnu0lUkoGXqrtewwvYtwqxkFE7OAEZrGW8OsFfAsYwLGzPS+9
	 lTdGv252qFJiULWj55YH7+AT7WjzK4WEmo5oqkQYkb/dVKRNqTql9eHqopMMMNRpyH
	 Go7FUODulAnf3Ibv6ZoIK5ncAuIKnwOyvQqsB0IIxtgBrQI9YtDe+IFT7JEyUMDMNS
	 XmkDxm/nQdhxHajxroD1VrXMq6tr5fYAHxDPZxGP/fSxdJqovdkLc+pEGIVYCqtZRS
	 WciUVpzt0qbSQ==
Message-ID: <6abcb9eb-ddaa-4a4f-9516-7a6a031944cd@kernel.org>
Date: Thu, 17 Sep 2026 13:03:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] bpftool: Skip non-autoload programs when
 generating light skeletons
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Leon Hwang <leon.hwang@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260909042433.1775591-1-tweek@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260909042433.1775591-1-tweek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/09/2026 05:24, Thiébaud Weksteen wrote:
> When generating a light skeleton (bpftool gen skeleton -L),
> bpf_object__load() skips loading programs marked as non-autoload (e.g.
> SEC("?...")), so the generated loader program only records and populates
> file descriptors for autoloaded programs.
> 
> Previously, bpftool emitted struct bpf_prog_desc fields, link fields,
> and attach/detach/destroy functions for all programs in the BPF object,
> causing the loader program to store subsequent program FDs into
> incorrect skeleton struct fields when non-autoload programs were
> present.
> 
> Furthermore, bpf_object__load() can update a program's autoload status
> during preparation (e.g. for struct_ops programs when resolving kernel
> BTF members or adjusting autoload based on map autocreate settings).
> Move bpf_object__gen_loader() and bpf_object__load() out of gen_trace()
> into do_skeleton() before counting programs and emitting struct fields so
> that struct field declarations and attach/detach/destroy functions all
> observe the final post-load autoload state.
> 
> Skip programs with !bpf_program__autoload(prog) when counting programs
> and generating progs/links struct fields as well as attach, detach, and
> destroy functions for light skeletons.
> 
> Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" and "gen skeleton" command.")
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> ---
> Changes since v1:
> - Move bpf_object__gen_loader() and bpf_object__load() out of gen_trace()
> 
>  .../bpf/bpftool/Documentation/bpftool-gen.rst |  4 +-
>  tools/bpf/bpftool/gen.c                       | 64 ++++++++++++-------
>  2 files changed, 44 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> index d0a36f442db7..1cdecf3e4fa5 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> @@ -184,7 +184,9 @@ OPTIONS
>  -L, --use-loader
>      For skeletons, generate a "light" skeleton (also known as "loader"
>      skeleton). A light skeleton contains a loader eBPF program. It does not use
> -    the majority of the libbpf infrastructure, and does not need libelf.
> +    the majority of the libbpf infrastructure, and does not need libelf. BPF
> +    programs marked as non-autoload (e.g., via **SEC("?...")**) are skipped and
> +    not included in the generated skeleton.
>  
>  -S, --sign
>      For skeletons, generate a signed skeleton. This option must be used with
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a50540ef6521..e9a1a018f270 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c

[...]

> @@ -712,19 +721,6 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>  	char ident[256];
>  	int err = 0;
>  
> -	if (sign_progs)
> -		opts.gen_hash = true;
> -
> -	err = bpf_object__gen_loader(obj, &opts);
> -	if (err)
> -		return err;
> -
> -	err = bpf_object__load(obj);
> -	if (err) {
> -		p_err("failed to load object file");
> -		goto out;
> -	}
> -
>  	/* If there was no error during load then gen_loader_opts
>  	 * are populated with the loader program.
>  	 */


This comment could be updated (or moved to do_skeleton()).


> @@ -752,7 +748,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>  				goto cleanup;				    \n\
>  			skel->ctx.sz = (char *)&skel->links - (char *)skel; \n\
>  		",
> -		obj_name, opts.data_sz);
> +		obj_name, opts->data_sz);
>  	bpf_object__for_each_map(map, obj) {
>  		const void *mmap_data = NULL;
>  		size_t mmap_size = 0;
> @@ -795,22 +791,22 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>  			static const char opts_data[] __attribute__((__aligned__(8))) = \"\\\n\
>  		",
>  		obj_name);
> -	print_hex(opts.data, opts.data_sz);
> +	print_hex(opts->data, opts->data_sz);
>  	codegen("\
>  		\n\
>  		\";							    \n\
>  			static const char opts_insn[] __attribute__((__aligned__(8))) = \"\\\n\
>  		");
> -	print_hex(opts.insns, opts.insns_sz);
> +	print_hex(opts->insns, opts->insns_sz);
>  	codegen("\
>  		\n\
>  		\";\n");
>  
>  	if (sign_progs) {
> -		sopts.insns = opts.insns;
> -		sopts.insns_sz = opts.insns_sz;
> -		sopts.data = opts.data;
> -		sopts.data_sz = opts.data_sz;
> +		sopts.insns = opts->insns;
> +		sopts.insns_sz = opts->insns_sz;
> +		sopts.data = opts->data;
> +		sopts.data_sz = opts->data_sz;
>  		sopts.excl_prog_hash = prog_sha;
>  		sopts.excl_prog_hash_sz = sizeof(prog_sha);
>  		sopts.signature = sig_buf;
> @@ -1250,6 +1246,7 @@ static int do_skeleton(int argc, char **argv)
>  	char header_guard[MAX_OBJ_NAME_LEN + sizeof("__SKEL_H__")];
>  	size_t map_cnt = 0, prog_cnt = 0, attach_map_cnt = 0, file_sz, mmap_sz;
>  	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
> +	DECLARE_LIBBPF_OPTS(gen_loader_opts, gen_opts);
>  	char obj_name[MAX_OBJ_NAME_LEN] = "", *obj_data;
>  	struct bpf_object *obj = NULL;
>  	const char *file;
> @@ -1326,6 +1323,21 @@ static int do_skeleton(int argc, char **argv)
>  		goto out_obj;
>  	}
>  
> +	if (use_loader) {
> +		if (sign_progs)
> +			gen_opts.gen_hash = true;
> +
> +		err = bpf_object__gen_loader(obj, &gen_opts);
> +		if (err)
> +			goto out;
> +
> +		err = bpf_object__load(obj);
> +		if (err) {
> +			p_err("failed to load object file");
> +			goto out;
> +		}
> +	}


Could you please add a comment above this block to explain why it's at
the current location (to avoid autoload flags update), to avoid people
moving it by accident, please?

Looks good otherwise, thank you!
