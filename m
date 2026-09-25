Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D586309EE9
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338045; cv=none; b=NQGLkz1FDZJ3VSsoLMP6HfLWzK2dEkPTujG1PWJCAkheAj/sGSkEmasaluTBBIWQWIDZW2etnZ5d5H4uRe8FhOJ35sU0fYV1QLfrgTCvy3sufU2IM/69BoCAAakBYXWM3aXeCudInywEZtUURnLB0bm69ega8OQsGhXRzokjuys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338045; c=relaxed/simple;
	bh=zRCWzdj8UJRIJ24WNG4h9Yk3bR8w6g39IXfTFLlH36c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjdsLZKhUS+sw5ZgIVoNc/jYiOrGOp7tFxX4bquxREbS7QBpXEA3g/wx0gREwgzH0DswsiMbEIisKKeI7al9mKVgdQpCauodvdkEGDeJXihXk7iRumREtiWri8AOC1r/m/EdggU24IMfvJQqCO/aeYqYv9X80qJ8tHss/LYkuMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq5sZqTJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jq5sZqTJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F861F000FF;
	Fri, 25 Sep 2026 12:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790338044;
	bh=Jam8/DDGritLYCkMwflBLWMrEOwdjI6ymDktpAFWgZ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jq5sZqTJABZvliUBaYppTL+wu+EdpHJVmWvSV4TSV01H/jv5maAdcq/csF21ClVwP
	 LZcBoMAIEBM9cOWngl0v1TDe/6aDUhB1uQNsz6FDlt6jpmY5iNQlGYe4R8dUHqM7v3
	 Ve2gbC0Er4EE57YhXuSGHHBc2srmIST/Ms9CyC4ZUW1lQImv9EY1sJhp4EU3ph1JWz
	 TtNAjHyvXzJn4KTauyu5xJyHNoQkzivPcgim44OMrqI+ejwLrjO41Ki39y1I4ZqiQi
	 5HSfq0QlH4y7rgNiOatd+hDt2B6W48WBY6Zs5MmgqN70LW3MtpsKDA5l2U9wuAEr0N
	 qXyFUqGY922nA==
Message-ID: <7d2f7cea-1055-4ba4-a44e-14078d6d5ef6@kernel.org>
Date: Fri, 25 Sep 2026 13:07:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] bpftool: Update func representation to
 include function signature
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
 yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
 memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
 puranjay@kernel.org, yatsenko@meta.com
References: <20260925095231.879708-1-alan.maguire@oracle.com>
 <20260925095231.879708-3-alan.maguire@oracle.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260925095231.879708-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-25 10:52 UTC+0100 ~ Alan Maguire <alan.maguire@oracle.com>
> Augment func= output for LOCSEC entries to include a mapping from
> function signature to where parameters are stored; for example:
> 
> [290179] LOCSEC 'inline.text' vlen=524941
>         func='task_pid_nr(tsk [reg0])' func_type_id=136691 loc_proto_type_id=136693 offset=2097226
>         func='get_current()' func_type_id=136694 loc_proto_type_id=136695 offset=2097247
>         func='arch_static_branch(key [address 0x2e275e8], branch [const 0x0])' func_type_id=136697 loc_proto_type_id=136700 offset=2097296
> 
> Fixes: 321562c34d5b ("bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/btf.c | 100 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 91 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index e29c8a84e224..6e569ace6add 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -8,6 +8,7 @@
>  #include <fcntl.h>
>  #include <linux/err.h>
>  #include <stdbool.h>
> +#include <stdarg.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -234,8 +235,10 @@ static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
>  						(1ULL << bits) - value;
>  			}
>  		}
> -		snprintf(num, sizeof(num), "0x%llx%s", (unsigned long long)value,
> -			 p->flags & BTF_LOC_PARAM_ADDR ? " (addr)" : "");
> +		snprintf(num, sizeof(num), "%s0x%llx",
> +			 p->flags & BTF_LOC_PARAM_ADDR ? "address " :
> +			 p->flags & BTF_LOC_PARAM_CONST ? "const " : "",
> +			 (unsigned long long)value);
>  	}
>  	if (i != vlen) {
>  		btf_loc_param_raw_str(p, vlen, str, sz);


Thanks Alan!

bpf-ci's comment about "-const 0x16" instead of "const -0x16" seems
legit, please take a look.


> @@ -252,6 +255,87 @@ static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
>  		 p->flags & BTF_LOC_PARAM_DEREF ? ")" : "");
>  }
>  
> +static int btf_locsec_append(char *str, size_t sz, size_t *off,
> +			      const char *fmt, ...)
> +{
> +	va_list args;
> +	int ret;
> +
> +	if (!sz || *off >= sz - 1)
> +		return -ENOSPC;
> +
> +	va_start(args, fmt);
> +	ret = vsnprintf(str + *off, sz - *off, fmt, args);


Nit: Do you really need vsnprintf()? It looks like you always
concatenate, never format any number, so it's probably not the most
efficient. I don't mind much, though.


> +	va_end(args);
> +	if (ret < 0 || (size_t)ret >= sz - *off) {
> +		*off = sz - 1;
> +		return -ENOSPC;


It seems unlikely we'll hit this, but maybe warn that the string is
truncated in that case, or replace the last characters with "..." or
"[truncated]" or something like this??


> +	}
> +	*off += ret;
> +	return 0;
> +}
> +
> +static void btf_locsec_func_str(const struct btf *btf,
> +				const struct btf_loc *loc, char *str, size_t sz)
> +{
> +	const struct btf_type *func, *func_proto, *loc_proto;
> +	const struct btf_param *params;
> +	const __u32 *loc_params;
> +	const char *name;
> +	__u32 i, vlen;
> +	size_t off = 0;
> +
> +	if (!sz)
> +		return;
> +
> +	str[0] = '\0';
> +	func = btf__type_by_id(btf, loc->func);
> +	if (!func || !btf_is_func(func))
> +		goto invalid;
> +
> +	name = btf_str(btf, func->name_off);
> +	func_proto = btf__type_by_id(btf, func->type);
> +	loc_proto = btf__type_by_id(btf, loc->loc_proto);
> +	if (!func_proto || !btf_is_func_proto(func_proto) ||
> +	    !loc_proto || !btf_is_loc_proto(loc_proto) ||
> +	    btf_vlen(func_proto) != btf_vlen(loc_proto))
> +		goto invalid;
> +
> +	params = (const void *)(func_proto + 1);
> +	loc_params = btf_loc_proto_params(loc_proto);
> +	vlen = btf_vlen(func_proto);
> +	if (btf_locsec_append(str, sz, &off, "%s(", name))
> +		return;
> +	for (i = 0; i < vlen; i++) {
> +		const struct btf_type *param_loc;
> +		char param_str[256] = {};
> +
> +		if (!params[i].type) {
> +			/* Handle varargs func proto, must be last parameter */
> +			if (i != vlen - 1)
> +				goto invalid;
> +			if (btf_locsec_append(str, sz, &off, "%s...", i ? ", " : ""))
> +				return;
> +			break;
> +		} else if (loc_params[i]) {
> +			param_loc = btf__type_by_id(btf, loc_params[i]);
> +			btf_loc_param_str(param_loc, param_str, sizeof(param_str));
> +		} else {
> +			snprintf(param_str, sizeof(param_str), "<unavailable>");
> +		}
> +
> +		if (btf_locsec_append(str, sz, &off, "%s%s [%s]",
> +				      i ? ", " : "", btf_str(btf, params[i].name_off),
> +				      param_str))
> +			return;
> +	}
> +	(void) btf_locsec_append(str, sz, &off, ")");
> +	return;
> +
> +invalid:
> +	snprintf(str, sz, "<invalid>");
> +}
> +
>  static int dump_btf_type(const struct btf *btf, __u32 id,
>  			 const struct btf_type *t)
>  {
> @@ -617,22 +701,20 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>  		}
>  
>  		for (i = 0; i < vlen; i++, locs++) {
> -			const struct btf_type *f = btf__type_by_id(btf, locs->func);
> -			const char *name = "<invalid>";
> +			char func_str[1024] = {};
>  
> -			if (f && btf_is_func(f))
> -				name = btf_str(btf, f->name_off);
> +			btf_locsec_func_str(btf, locs, func_str, sizeof(func_str));
>  
>  			if (json_output) {
>  				jsonw_start_object(w);
>  				jsonw_uint_field(w, "func_type_id", locs->func);
> -				jsonw_string_field(w, "name", name);
> +				jsonw_string_field(w, "func", func_str);


Would it be worth keeping the name, too, in the JSON? So that if
somebody wants the name only, they don't have to parse it from "func"?


>  				jsonw_uint_field(w, "loc_proto_type_id", locs->loc_proto);
>  				jsonw_uint_field(w, "offset", locs->offset);
>  				jsonw_end_object(w);
>  			} else {
> -				printf("\n\tname='%s' func_type_id=%u loc_proto_type_id=%u offset=%u",
> -				       name, locs->func, locs->loc_proto, locs->offset);
> +				printf("\n\tfunc='%s' func_type_id=%u loc_proto_type_id=%u offset=%u",
> +				       func_str, locs->func, locs->loc_proto, locs->offset);
>  			}
>  		}
>  		if (json_output)

