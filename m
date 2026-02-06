Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13DB1FE45D;
	Fri,  6 Feb 2026 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770337776; cv=none; b=TtRENkg+LS4YACnn4wf4EHTEujky5tF369dBPCajqSsRLcru4QRu5HMbtOzVylIzdyX45iuE11Z9iRBrR1Rfc+D9Jw+RAMz5E0imfE6Qqo4P1kbv47D2Rnak0zElmtoJgF9lSzKSa8zib3OfG9iPSevUd1DYlWqLNGz8cMAJccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770337776; c=relaxed/simple;
	bh=qi0YT5w+VAfOLVXwbysCpsyOvif5wKvEtusQrIWsrAY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Lo6fvUzIIq+fBBXelXDAzJeIsf3whgCr/hz730hmEZ5NQdF7HvS0K3X2+IjD5uFkHHDzofm7Rk4kcSeQH3loqvS7jJcrgE0vV7L42nUzIm2vdcMw0fTZMfqmO1+CUMvQb0DywCvT6k4v+hLO0GSUKjS1WyWHcgpRcMpeXFbkcPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+2wfR1s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+2wfR1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBC2C4CEF7;
	Fri,  6 Feb 2026 00:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770337776;
	bh=qi0YT5w+VAfOLVXwbysCpsyOvif5wKvEtusQrIWsrAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X+2wfR1saXeUTBZdCYBLA43L0lppZxqbRHlbTRlcwpJ54TlKI7yo81ax01oaidYQ3
	 +JmdBkuNo5DJvGcoWJCkBnx+OVOxc9ClsoG3aZI+ZiUC1kRcYeoo+4hcRTJYx6RvVS
	 bgNp+03DUf+ct2klmvwfhSlG4dCl4Wg2m6YEIYvRWrV/m/RzPow+Vj8JyiPduV+Db+
	 xx7Qxf94ndHhTZU3EX96h28/J1y6sQoTYq20iqY2dzpRxBZWRAlRXehou6TGwr6lM1
	 qxLVHj99ELRN4dcc/Z7ZlJ3EGSbx2B01WaMcsW2tiFVGBqkW8XWhx5JVQNPimm8B8V
	 1wmAHDxrr4RaA==
Date: Fri, 6 Feb 2026 09:29:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: rostedt@goodmis.org, ast@kernel.org, mhiramat@kernel.org,
 andrii.nakryiko@gmail.com, linux-kernel@vger.kernel.org, Donglin Peng
 <pengdonglin@xiaomi.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] btf: Add for_each_enum and for_each_enum64 helper
 macros
Message-Id: <20260206092931.13895170d57fb0c704f2bbc0@kernel.org>
In-Reply-To: <20260202111548.3555306-2-dolinux.peng@gmail.com>
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
	<20260202111548.3555306-2-dolinux.peng@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Feb 2026 19:15:47 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> From: Donglin Peng <pengdonglin@xiaomi.com>
> 
> Introduce two new helper macros, for_each_enum and for_each_enum64,
> to clean up code.
> 
> No functional changes.

This change looks good to me. But this should go through bpf tree.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> ---
>  include/linux/btf.h | 10 +++++++
>  kernel/bpf/btf.c    | 66 +++++++++++++++++++--------------------------
>  2 files changed, 38 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index f06976ffb63f..cde2deb8e25e 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -254,6 +254,16 @@ const char *btf_type_str(const struct btf_type *t);
>  	     i < btf_type_vlen(datasec_type);			\
>  	     i++, member++)
>  
> +#define for_each_enum(i, enum_type, member)			\
> +	for (i = 0, member = btf_enum(enum_type);		\
> +	     i < btf_type_vlen(enum_type);			\
> +	     i++, member++)
> +
> +#define for_each_enum64(i, enum_type, member)			\
> +	for (i = 0, member = btf_enum64(enum_type);		\
> +	     i < btf_type_vlen(enum_type);			\
> +	     i++, member++)
> +
>  static inline bool btf_type_is_ptr(const struct btf_type *t)
>  {
>  	return BTF_INFO_KIND(t->info) == BTF_KIND_PTR;
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0de8fc8a0e0b..c80a7a0cbe1d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -728,11 +728,6 @@ static const struct btf_array *btf_type_array(const struct btf_type *t)
>  	return (const struct btf_array *)(t + 1);
>  }
>  
> -static const struct btf_enum *btf_type_enum(const struct btf_type *t)
> -{
> -	return (const struct btf_enum *)(t + 1);
> -}
> -
>  static const struct btf_var *btf_type_var(const struct btf_type *t)
>  {
>  	return (const struct btf_var *)(t + 1);
> @@ -743,11 +738,6 @@ static const struct btf_decl_tag *btf_type_decl_tag(const struct btf_type *t)
>  	return (const struct btf_decl_tag *)(t + 1);
>  }
>  
> -static const struct btf_enum64 *btf_type_enum64(const struct btf_type *t)
> -{
> -	return (const struct btf_enum64 *)(t + 1);
> -}
> -
>  static const struct btf_kind_operations *btf_type_ops(const struct btf_type *t)
>  {
>  	return kind_ops[BTF_INFO_KIND(t->info)];
> @@ -4317,14 +4307,14 @@ static s32 btf_enum_check_meta(struct btf_verifier_env *env,
>  			       const struct btf_type *t,
>  			       u32 meta_left)
>  {
> -	const struct btf_enum *enums = btf_type_enum(t);
> +	const struct btf_enum *enump;
>  	struct btf *btf = env->btf;
>  	const char *fmt_str;
>  	u16 i, nr_enums;
>  	u32 meta_needed;
>  
>  	nr_enums = btf_type_vlen(t);
> -	meta_needed = nr_enums * sizeof(*enums);
> +	meta_needed = nr_enums * sizeof(*enump);
>  
>  	if (meta_left < meta_needed) {
>  		btf_verifier_log_basic(env, t,
> @@ -4347,16 +4337,16 @@ static s32 btf_enum_check_meta(struct btf_verifier_env *env,
>  
>  	btf_verifier_log_type(env, t, NULL);
>  
> -	for (i = 0; i < nr_enums; i++) {
> -		if (!btf_name_offset_valid(btf, enums[i].name_off)) {
> +	for_each_enum(i, t, enump) {
> +		if (!btf_name_offset_valid(btf, enump->name_off)) {
>  			btf_verifier_log(env, "\tInvalid name_offset:%u",
> -					 enums[i].name_off);
> +					 enump->name_off);
>  			return -EINVAL;
>  		}
>  
>  		/* enum member must have a valid name */
> -		if (!enums[i].name_off ||
> -		    !btf_name_valid_identifier(btf, enums[i].name_off)) {
> +		if (!enump->name_off ||
> +		    !btf_name_valid_identifier(btf, enump->name_off)) {
>  			btf_verifier_log_type(env, t, "Invalid name");
>  			return -EINVAL;
>  		}
> @@ -4365,8 +4355,8 @@ static s32 btf_enum_check_meta(struct btf_verifier_env *env,
>  			continue;
>  		fmt_str = btf_type_kflag(t) ? "\t%s val=%d\n" : "\t%s val=%u\n";
>  		btf_verifier_log(env, fmt_str,
> -				 __btf_name_by_offset(btf, enums[i].name_off),
> -				 enums[i].val);
> +				 __btf_name_by_offset(btf, enump->name_off),
> +				 enump->val);
>  	}
>  
>  	return meta_needed;
> @@ -4382,8 +4372,8 @@ static void btf_enum_show(const struct btf *btf, const struct btf_type *t,
>  			  u32 type_id, void *data, u8 bits_offset,
>  			  struct btf_show *show)
>  {
> -	const struct btf_enum *enums = btf_type_enum(t);
> -	u32 i, nr_enums = btf_type_vlen(t);
> +	const struct btf_enum *enump;
> +	u32 i;
>  	void *safe_data;
>  	int v;
>  
> @@ -4393,13 +4383,13 @@ static void btf_enum_show(const struct btf *btf, const struct btf_type *t,
>  
>  	v = *(int *)safe_data;
>  
> -	for (i = 0; i < nr_enums; i++) {
> -		if (v != enums[i].val)
> +	for_each_enum(i, t, enump) {
> +		if (v != enump->val)
>  			continue;
>  
>  		btf_show_type_value(show, "%s",
>  				    __btf_name_by_offset(btf,
> -							 enums[i].name_off));
> +							 enump->name_off));
>  
>  		btf_show_end_type(show);
>  		return;
> @@ -4425,14 +4415,14 @@ static s32 btf_enum64_check_meta(struct btf_verifier_env *env,
>  				 const struct btf_type *t,
>  				 u32 meta_left)
>  {
> -	const struct btf_enum64 *enums = btf_type_enum64(t);
> +	const struct btf_enum64 *enump;
>  	struct btf *btf = env->btf;
>  	const char *fmt_str;
>  	u16 i, nr_enums;
>  	u32 meta_needed;
>  
>  	nr_enums = btf_type_vlen(t);
> -	meta_needed = nr_enums * sizeof(*enums);
> +	meta_needed = nr_enums * sizeof(*enump);
>  
>  	if (meta_left < meta_needed) {
>  		btf_verifier_log_basic(env, t,
> @@ -4455,16 +4445,16 @@ static s32 btf_enum64_check_meta(struct btf_verifier_env *env,
>  
>  	btf_verifier_log_type(env, t, NULL);
>  
> -	for (i = 0; i < nr_enums; i++) {
> -		if (!btf_name_offset_valid(btf, enums[i].name_off)) {
> +	for_each_enum64(i, t, enump) {
> +		if (!btf_name_offset_valid(btf, enump->name_off)) {
>  			btf_verifier_log(env, "\tInvalid name_offset:%u",
> -					 enums[i].name_off);
> +					 enump->name_off);
>  			return -EINVAL;
>  		}
>  
>  		/* enum member must have a valid name */
> -		if (!enums[i].name_off ||
> -		    !btf_name_valid_identifier(btf, enums[i].name_off)) {
> +		if (!enump->name_off ||
> +		    !btf_name_valid_identifier(btf, enump->name_off)) {
>  			btf_verifier_log_type(env, t, "Invalid name");
>  			return -EINVAL;
>  		}
> @@ -4474,8 +4464,8 @@ static s32 btf_enum64_check_meta(struct btf_verifier_env *env,
>  
>  		fmt_str = btf_type_kflag(t) ? "\t%s val=%lld\n" : "\t%s val=%llu\n";
>  		btf_verifier_log(env, fmt_str,
> -				 __btf_name_by_offset(btf, enums[i].name_off),
> -				 btf_enum64_value(enums + i));
> +				 __btf_name_by_offset(btf, enump->name_off),
> +				 btf_enum64_value(enump));
>  	}
>  
>  	return meta_needed;
> @@ -4485,8 +4475,8 @@ static void btf_enum64_show(const struct btf *btf, const struct btf_type *t,
>  			    u32 type_id, void *data, u8 bits_offset,
>  			    struct btf_show *show)
>  {
> -	const struct btf_enum64 *enums = btf_type_enum64(t);
> -	u32 i, nr_enums = btf_type_vlen(t);
> +	const struct btf_enum64 *enump;
> +	u32 i;
>  	void *safe_data;
>  	s64 v;
>  
> @@ -4496,13 +4486,13 @@ static void btf_enum64_show(const struct btf *btf, const struct btf_type *t,
>  
>  	v = *(u64 *)safe_data;
>  
> -	for (i = 0; i < nr_enums; i++) {
> -		if (v != btf_enum64_value(enums + i))
> +	for_each_enum64(i, t, enump) {
> +		if (v != btf_enum64_value(enump))
>  			continue;
>  
>  		btf_show_type_value(show, "%s",
>  				    __btf_name_by_offset(btf,
> -							 enums[i].name_off));
> +							 enump->name_off));
>  
>  		btf_show_end_type(show);
>  		return;
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
