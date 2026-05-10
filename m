Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9592E296BAF;
	Sun, 10 May 2026 03:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384264; cv=none; b=Fx6eJqPzphI9sbH9UQ27wP9QgPhm4SNS/SHsGsyPr33/TpBI9s2ZSc+W9krMu2UGly240LiIocYFV4e2V1Kz7bmxmR3YWscns5K/g19UGb4NVXC3BLAwCwWfy7iz3MlONTke4N+WP2/q+uqW3f2g4trPlzlgre3xhcYvoYiFL7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384264; c=relaxed/simple;
	bh=I0v2SLK3mJWg+Pw5N45jog3yaredpfDCFGtjLxPJA4A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NXlOpxdNULEw7q550kcFaJ3jfulHlqHRoROiPcdiwvvn6XmmAr8o0qcbygtRqJ2867+wDei6yxzjthg8ck5xay8Wa20sowMivErZvTItQCd/cojTsWZjcNo98MZxhygKfDckiIVBvya1kt1JYYTJKez8lPjlB8YRup6d0K0ErIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk4DNnrw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk4DNnrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FE6C2BCF6;
	Sun, 10 May 2026 03:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384264;
	bh=I0v2SLK3mJWg+Pw5N45jog3yaredpfDCFGtjLxPJA4A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hk4DNnrw1PQhKBT4KER7wi0tuCR+0mSswrHOYGWDgKGkhOGT8/h/OEbto/zqmowJF
	 U4pLc2m0G5N6IKavypbHehVKcFd9lkQVu8Jf6Wq7MyNx5v+3WVqj3Wk+GLPJBlrwab
	 vhsMjfQ+hy+zxCJjDcPrDKRqmKutQHutdKfisRWxgSpa2lqG0COth0VKoSRsjz96eo
	 Zl2Ht5lRFGZo3vmpx96GWht7ix0vSzczwLNGea0d4UG8tTlmhfi6um6M0SYJ+Wtgdb
	 L26i4m8Pi7uWyKYelsN+q3G5UT9NASveJgdMYtHl4KMs3WUi7IaUMhLQ1eo4eb7geb
	 Sm/L9qAKTgE9g==
Content-Type: multipart/mixed; boundary="===============0784201911816781830=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5fb4de9aa4051ecac951e92a8e1c48bd4a8d784fed15ff346f1ae0d3a456c74d@mail.kernel.org>
In-Reply-To: <20260510030136.27876-1-chensong_2000@126.com>
References: <20260510030136.27876-1-chensong_2000@126.com>
Subject: Re: [PATCH V2 1/2] tools/lib/bpf/libbpf: Prioritize module kfuncs over vmlinux kfuncs
From: bot+bpf-ci@kernel.org
To: chensong_2000@126.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,chensong_2000@126.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 10 May 2026 03:37:43 +0000 (UTC)

--===============0784201911816781830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ab2071fdd3e8..b62ec39685e9 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8587,35 +8587,65 @@ static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
>  	return libbpf_kallsyms_parse(kallsyms_cb, obj);
>  }
>
> +static void split_module_from_ksym(const char *ksym_name,
> +			const char **module_name,
> +			size_t *module_name_len,
> +			const char **kfunc_name)
> +{
> +	const char *sep = strstr(ksym_name, "__");
> +
> +	if (!sep) {
> +		*module_name = NULL;
> +		*module_name_len = 0;
> +		*kfunc_name = ksym_name;
> +	} else {
> +		*module_name = ksym_name;
> +		*module_name_len = sep - ksym_name;
> +		*kfunc_name = sep + strlen("__");
> +	}
> +}
> +
>  static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
> -			    __u16 kind, struct btf **res_btf,
> -			    struct module_btf **res_mod_btf)
> +			__u16 kind, struct btf **res_btf,
> +			struct module_btf **res_mod_btf)
>  {
>  	struct module_btf *mod_btf;
>  	struct btf *btf;
> -	int i, id, err;
> +	int i, id = 0, err;
> +	const char *module_name;
> +	const char *kfunc_name;
> +	size_t module_name_len;
> +
> +	split_module_from_ksym(ksym_name, &module_name, &module_name_len, &kfunc_name);
> +	if (module_name_len == 0)
> +		goto search_vmlinux;

Does this break resolution of existing kfuncs and ksyms that live in kernel
modules?

For any ksym name that does NOT contain '__' (the default for essentially all
existing BPF programs and in-tree selftests), split_module_from_ksym sets
module_name_len = 0 and the code takes 'goto search_vmlinux' and never
iterates obj->btf_modules.

In the old code, when a ksym was not found in vmlinux BTF (id == -ENOENT),
load_module_btfs() was called and every loaded module BTF was searched with
btf__find_by_name_kind_own(btf, ksym_name, kind). That fallback is now gone
for names without '__'.

Concrete breaking example: tools/testing/selftests/bpf/progs/kfunc_call_test.c
uses kfuncs registered in bpf_testmod.ko such as bpf_kfunc_call_test1,
bpf_kfunc_call_test5, bpf_kfunc_call_test_acquire, bpf_kfunc_call_test_pass_ctx,
bpf_kfunc_call_test_release. None contain '__', so split_module_from_ksym sets
module_name_len = 0 and find_ksym_btf_id jumps straight to search_vmlinux.

Since these kfuncs live in bpf_testmod.ko's BTF (not vmlinux),
btf__find_by_name_kind() returns -ENOENT and find_ksym_btf_id returns -ESRCH.
The BPF program load then fails at bpf_object__resolve_ksym_func_btf_id with
'extern (func ksym) ...: not found in kernel or module BTFs'.

Call chain demonstrating the breakage:

bpf_object__load (libbpf.c)
  -> bpf_object__resolve_externs
    -> bpf_object__resolve_ksyms_btf_id
      -> bpf_object__resolve_ksym_func_btf_id
        -> find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, ...)
          -> split_module_from_ksym
            -> module_name_len == 0
              -> goto search_vmlinux
                -> returns -ESRCH

Same issue applies to struct_ops registered in modules. For example,
test_kmods/bpf_testmod.c calls register_bpf_struct_ops(&bpf_bpf_testmod_ops,
bpf_testmod_ops). bpf_map__init_kern_struct_ops -> find_struct_ops_kern_types
calls find_ksym_btf_id with stname = "bpf_struct_ops_bpf_testmod_ops" (no
'__'), so the module BTF search is skipped and the struct_ops map can no
longer be initialized.

Same issue applies to bpf_object__resolve_ksym_var_btf_id for any
variable-kind ksym that lives in a module.

>
> -	btf = obj->btf_vmlinux;
>  	mod_btf = NULL;
> -	id = btf__find_by_name_kind(btf, ksym_name, kind);
>
> -	if (id == -ENOENT) {
> -		err = load_module_btfs(obj);
> -		if (err)
> -			return err;
> +	err = load_module_btfs(obj);
> +	if (err)
> +		goto search_vmlinux;
>
> -		for (i = 0; i < obj->btf_module_cnt; i++) {
> -			/* we assume module_btf's BTF FD is always >0 */
> -			mod_btf = &obj->btf_modules[i];
> +	for (i = 0; i < obj->btf_module_cnt; i++) {
> +		/* we assume module_btf's BTF FD is always >0 */
> +		mod_btf = &obj->btf_modules[i];
> +		if (strlen(mod_btf->name) == module_name_len &&
> +			!strncmp(mod_btf->name, module_name, module_name_len)) {
>  			btf = mod_btf->btf;
> -			id = btf__find_by_name_kind_own(btf, ksym_name, kind);
> +			id = btf__find_by_name_kind_own(btf, kfunc_name, kind);
>  			if (id != -ENOENT)
> -				break;
> +				goto found;
>  		}
>  	}
> -	if (id <= 0)
> +
> +search_vmlinux:
> +	btf = obj->btf_vmlinux;
> +	mod_btf = NULL;
> +	id = btf__find_by_name_kind(btf, ksym_name, kind);
> +	if (id == -ENOENT)
>  		return -ESRCH;
>
> +found:
>  	*res_btf = btf;
>  	*res_mod_btf = mod_btf;
>  	return id;

The commit message states:

> Change the kfunc resolution order in find_ksym_btf_id() to search
> module BTFs before vmlinux BTF. This allows kernel modules to override
> vmlinux kfuncs with the same name, enabling a form of live-patching

Does the implementation match this description?

For any ksym_name without '__', split_module_from_ksym sets module_name_len = 0
and find_ksym_btf_id jumps directly to the search_vmlinux label, never touching
obj->btf_modules. So there is no module-first ordering for ordinary kfunc
names.

For ksym_names that contain '__', the code treats the substring before '__' as
a module name and only searches the single module whose mod_btf->name matches
that prefix (strlen(mod_btf->name) == module_name_len && !strncmp(...)). It
does not iterate all modules.

So a kernel module cannot 'override vmlinux kfuncs with the same name' unless
the BPF program author explicitly spells the kfunc as
'<module-name>__<kfunc-name>'. That is a new opt-in naming convention, not a
transparent override, and it is not documented anywhere in the patch.

Either the implementation should actually search modules first for all names
(and reviewers should then decide if that is acceptable), or the commit message
should be rewritten to describe the real semantics: 'introduce a module__kfunc
naming convention so BPF programs can explicitly target a specific module's
kfunc' and document the new convention and its impact on existing callers of
find_ksym_btf_id.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25618517155
--===============0784201911816781830==--
