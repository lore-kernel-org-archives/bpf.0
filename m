Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA594766B3
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131136; cv=none; b=oIkMc4RGwb+WP56M02RIQTKCGUMp0fjuEnxn00irWlyAsVO7Vssr/bJWRH3Q+Tt2EdznPAXIiAeOXnPvlPbtVZ7ubfKvrHGXTL6L8ks932PNXmHV6DaW04GcooAE5GJGwLwUgwbD5Br9HrebTHu+/MfBkfk1XnfCGlGd2FX4RTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131136; c=relaxed/simple;
	bh=IfSR3lnfYyfZMbiTNS4qswyXeXz5A/u7lDP9tsfiYhk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Nu7i25SUrdaTdYzw6HSbTH0mfxNrjdD25u3Sn7/J11VypzI+ehx3TpJuUKn+PcVIHpSRdIW/nGoMhQS7gHSdf2w8EtFRbQOAiPs1+OfIN6LWM1eHgBTIMpRIS3hkSzfUGb1iD6SlDqoOs3WUx310tC/N/cFACy82LOtm7HnoNi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ8nEaQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ8nEaQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F061F00893;
	Fri, 11 Sep 2026 12:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131135;
	bh=jvPIok4uqly85NLnhI1zi3gpPyz0JkafEr9kTl9j1aM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OQ8nEaQZPYkNi+e+HqxIf/h2AzCxFm6AXBkN/iFLTUyBGzpWu7xUFmz5lPh4re7R0
	 a17SlV6tWeTU9zhwmWT5rJIuFjHxIbNtwafNJXdU2lBYleKpg1ElNMRpuPIiIyeEQt
	 vUUy5zewCrdIPj/iz0tMKxfWhot4CxXtmI6U1aZYTu3eP2O8dW12k7MB7MSP52EmRK
	 FWRqFENsh6SK8fSwJA7QB7dRhQOnzLzOJjoPjTupCXo6V/LrGR5XiQYO1iWyknOGh3
	 kBFWSjuHPo45EKbXVCsEw10H/Suv5HOzHA/43V6roBaRjEzrWIDxyRpZRjTxKcmmYR
	 ZB6AGBx7nMbIA==
Content-Type: multipart/mixed; boundary="===============3543106354470227298=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e9e749ceac4e34adc78f6fd53cf22e40709db06a07f1cc99c66858ff3b67d5c6@mail.kernel.org>
In-Reply-To: <20260911120820.46900-2-zhaofuyu@vivo.com>
References: <20260911120820.46900-2-zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v8 1/2] libbpf: support selective kernel module BTF loading via bpf_object_open_opts
From: bot+bpf-ci@kernel.org
To: zhaofuyu@vivo.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,andrii.nakryiko@gmail.com,alan.maguire@oracle.com,olsajiri@gmail.com,zhaofuyu@vivo.com,andrii@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 12:52:14 +0000 (UTC)

--===============3543106354470227298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad571540..b1602c769f3d 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -224,10 +224,24 @@ struct bpf_object_open_opts {
>  	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
>  	 */
>  	const char *bpf_token_path;
> +	/*
> +	 * Optional allowlist of kernel module names whose BTFs libbpf is
> +	 * allowed to load. The allowlist limits which kernel module BTFs libbpf
> +	 * will consult wherever module BTF might be needed.
> +	 *
> +	 * When the option is not specified, the existing behavior remains
> +	 * unchanged. An explicitly specified empty list prevents libbpf from
> +	 * consulting any kernel module BTFs.
                      ^^^
How can a user specify an empty allowlist? The comment describes the behavior
but not how to achieve it. Looking at the implementation in libbpf.c:8612:

    obj->btf_module_allowlist_cnt = mod_allow ? mod_allow_cnt : -1;

the code uses the pointer to distinguish states, not the count:
  - btf_module_allowlist == NULL (regardless of _cnt) -> -1, allow all
  - btf_module_allowlist != NULL, _cnt == 0 -> allow none

So a caller who writes

    LIBBPF_OPTS(bpf_object_open_opts, opts, .btf_module_allowlist_cnt = 0);

gets unrestricted module BTF loading (the legacy behavior), not the documented
"consult no module BTFs". To actually reach the empty-list mode, the caller
must pass a non-NULL pointer that is never dereferenced. The selftest
(999379bdbd8f) does exactly that:

    static void btf_module_allowlist_empty(void)
    {
            const char *mod_list[] = { NULL };

            test_load_with_list(mod_list, 0, -ESRCH);
    }

with a dummy array whose only element is never read, purely so the pointer is
non-NULL.

Should the comment document this pointer-vs-count distinction and spell out
the required "pass a non-NULL dummy pointer" idiom? Or would it be clearer to
use an unambiguous encoding, like a separate flag for "restrict module BTFs"
or documenting that _cnt == 0 with any pointer value means empty?

> +	 *
> +	 * The list must contain valid, non-empty module names and must not
> +	 * contain duplicate entries; otherwise -EINVAL is returned.
> +	 */
> +	const char **btf_module_allowlist;
> +	int btf_module_allowlist_cnt;
             ^^^
Why use a signed int for the count field instead of size_t? Both existing
precedents in this header for "const char ** array + count" use size_t:

    /* libbpf.h:617 */
    struct bpf_kprobe_multi_opts {
            size_t sz;
            const char **syms;
            size_t cnt;             /* number of elements in syms */

    /* libbpf.h:644 */
    struct bpf_uprobe_multi_opts {
            size_t sz;
            const char **syms;
            size_t cnt;

With int, the code has to validate a state that cannot exist with size_t:

    if ((!mod_allow && mod_allow_cnt > 0) || mod_allow_cnt < 0)
            return ERR_PTR(-EINVAL);

and it overloads the count with a -1 sentinel, then compares it against the
size_t sibling field btf_module_cnt:

    /* libbpf.c:5971 */
    if (obj->btf_module_allowlist_cnt == obj->btf_module_cnt)
            break;

That comparison is safe today (the -1 converts to SIZE_MAX which
btf_module_cnt cannot reach), but it does mix signed and unsigned, and
bpf_object__close() has to introduce a second signed loop variable int j
alongside the existing size_t i purely to iterate this field.

Would size_t matching the neighbouring opts structs be clearer, or is the
signed encoding serving a specific need here?

>
>  	size_t :0;
>  };
> -#define bpf_object_open_opts__last_field bpf_token_path
> +#define bpf_object_open_opts__last_field btf_module_allowlist_cnt

[ ... ]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c036e8a91ed8..4ab7ddc3b4cc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -5851,6 +5853,21 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>  	return 0;
>  }
>
> +static bool is_btf_mod_allowed(const struct bpf_object *obj, const char *name)
> +{
> +	int i;
> +
> +	if (obj->btf_module_allowlist_cnt < 0)
> +		return true;
> +
> +	for (i = 0; i < obj->btf_module_allowlist_cnt; i++) {
> +		if (strcmp(obj->btf_module_allowlist[i], name) == 0)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int load_module_btfs(struct bpf_object *obj)
>  {
>  	struct bpf_btf_info info;
> @@ -5873,6 +5890,9 @@ static int load_module_btfs(struct bpf_object *obj)
>  	if (!kernel_supports(obj, FEAT_MODULE_BTF))
>  		return 0;
>
> +	if (obj->btf_module_allowlist_cnt == 0)
> +		return 0;
> +
>  	while (true) {
>  		err = bpf_btf_get_next_id(id, &id);
>  		if (err && errno == ENOENT)
> @@ -5915,6 +5935,11 @@ static int load_module_btfs(struct bpf_object *obj)
>  			continue;
>  		}
>
> +		if (!is_btf_mod_allowed(obj, name)) {
> +			close(fd);
> +			continue;
> +		}
> +
>  		btf = btf_get_from_fd(fd, obj->btf_vmlinux);
>  		err = libbpf_get_error(btf);
>  		if (err) {
> @@ -5939,6 +5964,9 @@ static int load_module_btfs(struct bpf_object *obj)
>  			break;
>  		}
>  		obj->btf_module_cnt++;
> +
> +		if (obj->btf_module_allowlist_cnt == obj->btf_module_cnt)
> +			break;
                       ^^^
Alan Maguire pointed out in v6 that after the loop exits, there is no check
to verify all requested modules were actually found. If a user requests
modules that don't exist on the system, the function silently succeeds even
though obj->btf_module_cnt < obj->btf_module_allowlist_cnt.

Should the code verify that obj->btf_module_cnt matches the requested number
when an allowlist is specified? That would help users detect when they've
specified non-existent or misspelled module names.

>  	}
>
>  	if (err) {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34598086716
--===============3543106354470227298==--
