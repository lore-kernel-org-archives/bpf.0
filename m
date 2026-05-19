Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29BE352008
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779231004; cv=none; b=Y6FDYSE1Jmq24jf12T5FpCk8fNZTbixF4nSolFUI33BURb3jqQg0pxhtKYBFQsGywcTpywcrLZz3jqORHrUWD25koLEYbGJrGC6oXMi+cTkHG8RgpOEhahV6YUR4ndh9lafkBhlz2ZBr/ANkatmrhtrjIrDhoe6P9QTpRcSjC8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779231004; c=relaxed/simple;
	bh=JSC1wAmwL9QSjM6CSRDvopp65RjIRHilxy/Fkp4rHVI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TbqDEwcQfCKtH9qP9Mv6saAfjnY96P4t4qWyj3IIEjuYPYZbwMCdtzTy9v9fYDCOBEwTQ41Rpzr6A2NZlF8GpdDNmXlrfqyjigDfK/IHeh5c3n2zfuoBje0fudqIRF3QU8TPntV8C5ehT2+IWMjuoz8UWgv9AZ9I/myPDCv7L7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erGvKrtG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erGvKrtG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986EB1F00893;
	Tue, 19 May 2026 22:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779231002;
	bh=ZH6TvcdXyKZ1D8gqWAEJGeI7me8XlVKaKAC28lh7Giw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=erGvKrtG23NwGmLFZZ70DmsrlnTsUYqzEAHAqityscr+YoOMT0uUoefaiqPN8fcsL
	 IWo+4RM+gsPga63GoApKvTn7PeAnwCuQOT4PmaJ+vCkhs5N6B1utA3Bk8zxNUnON/p
	 PxneKNnLdrDW0I1zRBmGLnKEnpiBpgQFfXgSnfBScASNfRRsSHMQ9wi92CIIgsFGls
	 OzdCfsB/3N3s0Kzfoo8V1i+jAEkRoISBSibMxpoWOTYBC9OCdOxrRDqFthHNQrIYX9
	 VoA5kOdW3ximoiCyKuZcCXtwsVmT+ooST4xbfnlc0Mzg+GSVDDymMfFQN7vP3FQg75
	 jKMWfn3BNljWw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 09/12] bpf: Add infrastructure to support
 attaching struct_ops to cgroups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Martin KaFai Lau" <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519215841.2984970-10-martin.lau@linux.dev>
References: <20260519215841.2984970-10-martin.lau@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 22:50:02 +0000
Message-Id: <20260519225002.986EB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] bpf_cgroup_struct_ops_foreach does not skip dummy items, leading t=
o unintended execution of cfi_stubs.
- [High] Using a loadable module's cfi_stubs as a dummy sentinel causes a U=
se-After-Free when the module is unloaded and reloaded.
- [Medium] The macro bpf_cgroup_struct_ops_foreach uses rcu_dereference(), =
which is incompatible with sleepable struct_ops programs.
- [Medium] cgroup_bpf_struct_ops_register() lacks concurrency protection an=
d global uniqueness enforcement.
--

commit bad29e4e0d1357905491993ee45063766d0f7705
Author: Martin KaFai Lau <martin.lau@kernel.org>

bpf: Add infrastructure to support attaching struct_ops to cgroups

This patch adds necessary infrastructure to attach a struct_ops
map to a cgroup. The initial need was to support migrating
the legacy BPF_PROG_TYPE_SOCK_OPS to a struct_ops.

> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index b2e79c2b41d51..8080f4a5c14b6 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h

[ ... ]

> @@ -110,6 +112,18 @@ struct bpf_prog_list {
>  	u32 flags;
>  };
> =20
> +#define bpf_cgroup_struct_ops_foreach(var, item, cgrp, atype)		\
> +	for (item =3D rcu_dereference((cgrp)->bpf.effective[atype])->items;\
> +	     ((var) =3D READ_ONCE(item->kdata));				\
> +	     item++)

[Severity: High]
Does this macro need to skip dummy sentinel items?

In cgroups with BPF_F_ALLOW_MULTI, compute_effective_progs() inserts dummy
sentinel items at the boundaries between cgroup levels. For struct_ops, this
dummy is the cfi_stubs pointer.

This macro appears to iterate over all non-NULL items and fails to skip the
dummy sentinel, which could cause the subsystem to repeatedly yield the
cfi_stubs pointer as a valid attached struct_ops instance.

[Severity: Medium]
Will this rcu_dereference() trigger Lockdep warnings for sleepable struct_o=
ps
programs?

The commit message mentions adding free_after_mult_rcu_gp to support a mix =
of
sleepable and non-sleepable struct_ops, but plain rcu_dereference() enforces
rcu_read_lock_held().

If a subsystem iterates the array while holding rcu_read_lock_trace()
(required for sleepable execution), this might trigger a 'suspicious
rcu_dereference_check() usage' warning. Conversely, if it holds
rcu_read_lock(), the struct_ops program cannot sleep without causing a pani=
c.

> +
> +static inline bool cgroup_bpf_is_struct_ops_atype(enum cgroup_bpf_attach=
_type atype)
> +{

[ ... ]

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index a033aa479ab6e..d496db48d2b86 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -24,6 +24,29 @@
>  DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATT=
ACH_TYPE);
>  EXPORT_SYMBOL(cgroup_bpf_enabled_key);
> =20
> +static u32 struct_ops_type_id[MAX_CGROUP_BPF_ATTACH_TYPE];
> +static void *struct_ops_cfi_stubs[MAX_CGROUP_BPF_ATTACH_TYPE];
> +static bool struct_ops_mult_rcu[MAX_CGROUP_BPF_ATTACH_TYPE];
> +
> +void cgroup_bpf_struct_ops_register(int atype, u32 type_id, void *cfi_st=
ubs, bool mult_rcu)
> +{
> +	struct_ops_type_id[atype] =3D type_id;
> +	struct_ops_cfi_stubs[atype] =3D cfi_stubs;
> +	struct_ops_mult_rcu[atype] =3D mult_rcu;
> +}

[Severity: Medium]
Does this registration function need concurrency protection to prevent glob=
al
array corruption?

If two modules are loaded concurrently and declare the same cgroup_atype, it
seems this could cause a data race or silently overwrite the registered typ=
e_id
and cfi_stubs of a legitimate module.

> +
> +static enum cgroup_bpf_attach_type find_atype_by_struct_ops_id(u32 type_=
id)

[ ... ]

>  static void *bpf_cgroup_array_dummy(enum cgroup_bpf_attach_type atype)
>  {
> +	if (cgroup_bpf_is_struct_ops_atype(atype))
> +		return struct_ops_cfi_stubs[atype];
>  	return bpf_prog_dummy();
>  }

[Severity: High]
Can using a loadable module's cfi_stubs as a dummy sentinel cause a
use-after-free when the module is unloaded and reloaded?

If all maps are detached, the module providing the struct_ops can be unload=
ed,
and its cfi_stubs memory freed. However, the cgroup's effective array might
still retain the dangling pointer to the freed cfi_stubs if BPF_F_ALLOW_MUL=
TI
was set.

If the module is reloaded, cgroup_bpf_struct_ops_register() updates
struct_ops_cfi_stubs[atype] with a new pointer. If a user then queries the
cgroup via BPF_PROG_QUERY, the loop checks
item->prog =3D=3D bpf_cgroup_array_dummy(atype) to skip the dummy. Since the
array contains the old freed pointer, it won't match the new cfi_stubs
pointer, and the query loop might mistakenly treat the old dummy as a valid
map, causing a use-after-free when calling bpf_struct_ops_kdata_map_id().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519215841.2984=
970-1-martin.lau@linux.dev?part=3D9
