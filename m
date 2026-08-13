Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C252383C97;
	Thu, 13 Aug 2026 04:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786594940; cv=none; b=iKJDKUGj23UNZzxLXy88/Nk1pNA7BWTV/JF0PJyQym/Wzi6swHStlfTFCFYy/rr+OBMz11SO4qrzkHStdeJN0iYANgRyDKu5WgoGnozM/Dxcf80+aWM939ELUcbjOeMOn5TuzpYOPfAXrGwSML7854bpxQ7ogDLh3Hi1P4Zvq0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786594940; c=relaxed/simple;
	bh=p/R6Rksy9mw5WhdGbJ6g9Ba0X7+fAQ55QJNizdmCYE0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jWwJu3xHMeANuluF6zZ0qGhSUaVcxx0LcESpI7hgl5lW7VC5QXr1a56czgVvAcWTFzHvgEnDM6fRZxhgBm8CBLXndjCB9xGy7T8ndpp4oxAl+Y2kU1Vd+RaqoE9g36DY0ByFJ43FSsrmEVdc3FUCNO6vbaiz6+NpZ1r4S35M9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etmbhg/m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etmbhg/m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BB91F00A3A;
	Thu, 13 Aug 2026 04:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786594939;
	bh=81MKgV5Hg/YoeiwbP4Ktu/0WGpHcnmIQb9HWLpZfU9U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=etmbhg/mz+UaAiDeqTfoVH7L38lqnbkg+YDWh9H66jaBCSGdvRJHnwj5wM6ZfoKFA
	 vHXuNV6MDzXwQ3IduiGNdSVhcYBrgf42tmCny7+8eKx2dLh9UnwnlDgAP+WwJn/soU
	 gIgTYvjf/hxcv4HYdJCYU2sMwlvJUlWy5R0OoBKGA1C1QKV4U7I9T9b4xaTyAUs3Km
	 0OWBc+UbeTKpe/jf1JM84US3qBRf65IyLxeZ+Dr83QyZXGh39ym0ZRT6W3N40nd0pE
	 Owrj2Q2OomVKKJqbH0IRXI9UMRlGk88iY0oRifxRBSGTJMc4CGeP4q0KxsBu/XhM1b
	 s9TKrKvE0EmIA==
Content-Type: multipart/mixed; boundary="===============3800696815030016696=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f368863dfa10ec5402f0a45feaa11f6bcddccc87385a4dde88a8ce8b478598b1@mail.kernel.org>
In-Reply-To: <20260813032613.2755-2-zhaofuyu@vivo.com>
References: <20260813032613.2755-2-zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next v2 1/2] libbpf: support selective kernel module BTF loading via .kmod_btfs section
From: bot+bpf-ci@kernel.org
To: zhaofuyu@vivo.com,bpf@vger.kernel.org,andrii@kernel.org,alan.maguire@oracle.com
Cc: ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,zhaofuyu@vivo.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 04:22:18 +0000 (UTC)

--===============3800696815030016696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 9d160b5b9c0ee..171ea055cd323 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -188,6 +188,20 @@ enum libbpf_tristate {
>  	TRI_MODULE = 2,
>  };
>
> +/* Helper typedef for declaring kernel module names that need BTF loading.
> + *
> + * Usage: define an array in the ".kmod_btfs" ELF section to specify
> + * which modules need BTF loading:
> + *
> + *   DEFINE_KMOD_BTFS(_needed_kmods)= { "module1", "module2", ... };
> + *
> + * This avoids unnecessary BTF loading and speeds up the BPF program
> + * load process.
> + */
> +#define KMOD_NAME_LEN 64
> +#define DEFINE_KMOD_BTFS(name) \
> +	SEC(".kmod_btfs") char name[][KMOD_NAME_LEN]

KMOD_NAME_LEN establishes the on-disk record size for the .kmod_btfs section
format, yet it's duplicated in two files with only a prose comment connecting
them:

  tools/lib/bpf/bpf_helpers.h:201   #define KMOD_NAME_LEN 64
  tools/lib/bpf/libbpf.c:707-708    /* Should match the definition in ... */
                                    #define KMOD_NAME_LEN 64

If the two ever diverge, bpf_object__collect_kmod_btf_names() will silently
mis-slice the section. The d_size % KMOD_NAME_LEN check only catches
non-multiples, not a mismatch between the two values. Could this use a shared
header or a static assert to ensure they stay in sync?

Also, the new macro has no #ifndef guard. This header is included by nearly
every BPF program alongside vmlinux.h and user headers. Other unprefixed
names this header exports (NULL at lines 78-80, KERNEL_VERSION at 82-84) all
have #ifndef wrappers. Should KMOD_NAME_LEN follow that pattern?

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 514e4e9daa825..9fe8a653e8b6b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -5803,6 +5888,11 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>  	return 0;
>  }
>
> +static bool is_kmod_btf_needed(struct bpf_object *obj, const char *name)
> +{
> +	return hashmap_find(obj->kmod_btfs->hashmap, (long)name, NULL);
> +}

This calls the raw hashmap_find() with a manual (long) cast, rather than
the hashmap__find() wrapper that hashmap.h provides:

  hashmap.h:159
  #define hashmap__find(map, key, value) \
      hashmap_find((map), (long)(key), hashmap_cast_ptr(value))

The header comments at lines 50 and 54 say the intent is to use the wrapper
("behind auxiliary macros") so that the _Static_assert on the value pointer
runs. Bypassing the macro also bypasses that check.

This is the only direct caller of the unversioned function in the whole
library. The other function added by this same patch does use the wrapper
(bpf_object__collect_kmod_btf_names at libbpf.c:964 uses hashmap__find), so
the two halves of the change are inconsistent. Should this use the wrapper
too?

[ ... ]

> @@ -9030,6 +9130,12 @@ static void bpf_object_cleanup_btf(struct bpf_object *obj)
>  	/* clean up vmlinux BTF */
>  	btf__free(obj->btf_vmlinux);
>  	obj->btf_vmlinux = NULL;
> +
> +	if (obj->kmod_btfs) {
> +		hashmap__free(obj->kmod_btfs->hashmap);
> +		zfree(&obj->kmod_btfs->data);
> +		zfree(&obj->kmod_btfs);
> +	}
>  }

The .kmod_btfs filter list is ELF open-time data, but it's freed from
bpf_object_cleanup_btf(), which runs while the bpf_object is still alive and
load_module_btfs() can still be called. The filter therefore stops applying
part-way through the object's lifetime. Concrete path:

  bpf_object_load()                       libbpf.c:9182
    ... -> bpf_object_post_load_cleanup() libbpf.c:9229
             -> bpf_object_cleanup_btf()  libbpf.c:9147
                  obj->btf_modules_loaded = false;   (libbpf.c:9128)
                  zfree(&obj->kmod_btfs);            (libbpf.c:9137)

  bpf_program__attach_tracing_multi()     libbpf.c:12791
    -> collect_func_ids_by_glob()         libbpf.c:12752
         -> find_attach_module()          libbpf.c:7877
              -> load_module_btfs()       libbpf.c:5896

At this second entry into load_module_btfs(), btf_modules_loaded is false so
the full scan re-runs, but obj->kmod_btfs is NULL. The filter at
libbpf.c:5960 is skipped and every module BTF in the system is loaded,
exactly what the section is supposed to prevent. collect_func_ids_by_glob()
also calls bpf_object_cleanup_btf(obj) unconditionally at its cleanup: label
(libbpf.c:12786), so the list is destroyed again on every attach.

The other open-time members with the same lifetime (obj->jumptables_data,
obj->arena_data, obj->kconfig) are freed in bpf_object__close()
(libbpf.c:9720-9733), not in the BTF cleanup helper. Should obj->kmod_btfs
be freed there instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31664172915
--===============3800696815030016696==--
