Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA4D22D785
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789172623; cv=none; b=LMs6OsV0R6OEP8zN14zyGcG0fZVNoWZd6s5BC3m0UMlSagAZroGE7SYBS+5iJkOeENXaOL16JrwSCJWNnjtJNoFxzVYWInsDftxSa6IfkRTMWpnz1qJ3Ip+yIxcOhGVed0apjmEz/RV/LY/o4S6G8Pfxa4AOA5kEY56IKjb1l4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789172623; c=relaxed/simple;
	bh=88K6fGjphzb/knS0xhlBhdfkSuPfM9PMVGG/viKcOTc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jWCCFd+hlH1IoKiFiYuxjMQfL2hklJjaCnRllb+oPhyeE3ybySGv+o+zqIi91z++A1R2b0cdjT79XBX99TjQ9iCGTW/OO/+ftW/nLSHLSne+8jthKw0RNsjEnMARQR3lQc1NlnCdVioEb/SmMguVK0gYbxdbW2i3+Zd+WZRlDjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNMH2Mq/; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNMH2Mq/"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso91346a91.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 17:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789172621; x=1789777421; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3ssR+GFcKVHOfOJRTGyAqJSP3J43MrDkr6DAHW3Wnio=;
        b=SNMH2Mq/jEockmU8UkJq8UX8nDXoDUMzq1v6+6O+sR7nvuHVODTqb55PmQ1IE9MoFD
         fisilcDeSdSmVQ7eIxNTgoNLM0kxxl5M/Qso9CNx7C82QbJ8YmPEBp/RM+wIUVx2eqZh
         EYa8FtB/Orw7BoaJu83o/Ngz+uv6w3BMochHSRDjaHmzVjgT0xfgdzL4l7VB6RligFb2
         cSp2Ip3+UsECmjF/qFfTUBtN+UIfkZpOSBnDpQi/FsNCkrkVQo0BtMqRgpLY/BpoOjbu
         NoTPjL+ADRpbvOptP55H5q8uFN3bTXcVRR8xBVOIwZKFU0CXKVwUbKJMBivL+nLg4NFm
         WCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789172621; x=1789777421;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ssR+GFcKVHOfOJRTGyAqJSP3J43MrDkr6DAHW3Wnio=;
        b=eowHlkQwoHbeik2ZbYDaDTtDSfDUAPAMyS716cs1IrlntEV3aS1/2kl9ahZF2VrSmb
         VtqHd1IIF9YKmKUlH9rw9LdM/hSmxbo1S0H249RiYoOiqFHWw38jZeY4dQobASthaDqK
         BNvKgaas4yzFEWF61SXlJsUTyJ8Ij8CH9pKx8fdgBE4/oh62nFp3KIFL3F88l1rSI4I0
         qcjREDdO0d+YzphgTJ08mcEYl+RQQWiKgjje/rb9lRUauYSh0OFsIk7fPjdXzB2zFOcG
         isZOwnAXE8MJMZR5nVORzOVZAQ0TV/v171xG9eqWKHXBzAPOq8T0POvBDWbMDRRJITfC
         LxfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqXoXWMtQeuTiZRLIP/nmIGIEMzTq0FLO6i+DUTNb0z6i6wu6z2usJu3uuhM2GfWVMErM=@vger.kernel.org
X-Gm-Message-State: AFuF++lJMdvozhpB3TI/0BXAGKT/YcrlDAR3iTseMCbgfhlPkXrnTipA
	3mE/pP5sX9T/3FeIV0JGqu5dbQBRAx8Vk+xkpzUr7blnQ6w1fXZBrkij
X-Gm-Gg: AYBFou0MWZx4gM7en1LaBJ9TDFM3dijfnHwJd8NWQLkT6VGZ+dwE0jb5nMKujh3UYGx
	plLQtN89EK4scGacOd3r1SU1Hs5sEPRVHbVZLH3tHwWRglIhq1uTRTB7QJyJwzsIdhhr05Wltdn
	sUkSv9eBh0RlYoJoyLRchHXziymjYIC5/mqORE9rzpgKIzZvmXG1FjlvYwWWrGSaTJZMEH/1QIL
	y+hkOERIYtBuD/MxuHZ33zuG3yMnb3teQTQouY14KmOJdVdN5dHjakpNEHsmIUZgm9pA2qHwTfL
	51TN0gYz98qXAYEjWdnJEGN8zO0wBcTHXAAJs5UTtMoU+PquDwNO4fBonI3ukKLSgw5xtL7olL7
	bMoSeBYc8vNVX3C3bmRZuwkRCnuCD/dNyE98UNGD64YKrxc7f5KV0TyNAlArxwB8h0DMwoiWGDT
	GVTlhNzXn9zOTiSFw+o6z/woUiw9Z0SKsaj5+fkKUJp2gE+51zJX50Dh16ziuzZFYEXuTVE4DVb
	rMPeOqsSCOoIZO3lMbFeJUmmRwKVpcDCb8wjANR9JINYOhfzNdxDlwZ9g==
X-Received: by 2002:a17:90a:e7c5:b0:398:d6e6:4671 with SMTP id 98e67ed59e1d1-39dbc71af8fmr952717a91.25.1789172620716;
        Fri, 11 Sep 2026 17:23:40 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c52f:3686:673c:704a? ([2620:10d:c090:500::4:b9a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f82c69sm10209383eec.27.2026.09.11.17.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 17:23:40 -0700 (PDT)
Message-ID: <fc1d616c865c98297c46eada0b8a655599873e19.camel@gmail.com>
Subject: Re: [PATCH bpf v2 6/7] bpf: Assign lock identity to callback map
 values
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Fri, 11 Sep 2026 17:23:38 -0700
In-Reply-To: <20260905083418.3723623-7-memxor@gmail.com>
References: <20260905083418.3723623-1-memxor@gmail.com>
	 <20260905083418.3723623-7-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-09-05 at 10:34 +0200, Kumar Kartikeya Dwivedi wrote:
> The verifier identifies the allocation containing a bpf_spin_lock by the
> pair of the map pointer and register ID. It permits ID zero for direct
> map-value loads into single-element array maps because they have one stab=
le
> value.
>=20
> Callback frame constructors also leave map-value arguments with ID zero,
> but their maps can have multiple elements. Consequently, nested callbacks
> can hold two distinct elements of the same map with an identical lock
> identity. The verifier then permits a lock acquired through one element t=
o
> be released through another. The same confusion lets graph kfuncs operate
> on one element while another element is locked, allowing concurrent list
> corruption.
>=20
> Give lockable callback map values a fresh ID in the for-each,
> timer/workqueue, and task-work frame constructors. Keep ID zero for
> top-level one-element array maps, whose callback argument and pseudo
> map-value load alias the same stable allocation. Maps without locks remai=
n
> unchanged, while copies of one callback value continue to share an ID and
> support balanced locking.
>=20
> Map-in-map lookups need additional care. Distinct concrete inner maps sha=
re
> the verifier-visible inner_map_meta, so a one-element inner array otherwi=
se
> looks like the same static allocation. Preserve lookup identity as map_ui=
d
> for lock-bearing inner maps and consult it before applying the ID-zero
> exception. Restricting UID propagation to maps with identity-sensitive
> fields avoids making state pruning conservative for every inner map.

I find the above commit message extremely hard to parse.
Please replace it with a small repro program and an explanation of
what fails in code.

> Fixes: d0d78c1df9b1 ("bpf: Allow locking bpf_spin_lock global variables")
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9c797cc3df40..ad14a7fbed72 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -448,6 +448,13 @@ static bool reg_may_point_to_spin_lock(const struct =
bpf_reg_state *reg)
>  	return btf_record_has_field(reg_btf_record(reg), BPF_SPIN_LOCK | BPF_RE=
S_SPIN_LOCK);
>  }
> =20
> +static bool map_value_has_static_identity(const struct bpf_reg_state *re=
g)
> +{
> +	const struct bpf_map *map =3D reg->map_ptr;
> +
> +	return !reg->map_uid && map->map_type =3D=3D BPF_MAP_TYPE_ARRAY && map-=
>max_entries =3D=3D 1;
> +}
> +
>  static bool type_is_rdonly_mem(u32 type)
>  {
>  	return type & MEM_RDONLY;
> @@ -1926,11 +1933,18 @@ static void refine_map_lookup_value(struct bpf_re=
g_state *reg)
>  	if (map->inner_map_meta) {
>  		reg->type =3D CONST_PTR_TO_MAP | maybe_null;
>  		reg->map_ptr =3D map->inner_map_meta;
> -		/* transfer reg's id which is unique for every map_lookup_elem
> -		 * as UID of the inner map.
> +		/*
> +		 * Concrete inner maps share the verifier-visible inner_map_meta.
> +		 * Preserve the lookup identity only for embedded objects whose
> +		 * verification needs to distinguish concrete map instances. Doing
> +		 * this for every inner map makes state pruning too conservative.
> +		 *
> +		 * Each map lookup has a unique register ID, so use it as the UID of
> +		 * the inner map.
>  		 */
>  		if (btf_record_has_field(map->inner_map_meta->record,
> -					 BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK))
> +					 BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK |
> +					 BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK))

I'd drop the condition above altogether and route map_uid through
check_ids().

>  			reg->map_uid =3D reg->id;
>  	} else if (map->map_type =3D=3D BPF_MAP_TYPE_XSKMAP) {
>  		reg->type =3D PTR_TO_XDP_SOCK | maybe_null;
> @@ -10036,6 +10050,9 @@ int map_set_for_each_callback_args(struct bpf_ver=
ifier_env *env,
>  	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
>  	callee->regs[BPF_REG_3].map_ptr =3D caller->regs[BPF_REG_1].map_ptr;
>  	callee->regs[BPF_REG_3].map_uid =3D caller->regs[BPF_REG_1].map_uid;
> +	if (reg_may_point_to_spin_lock(&callee->regs[BPF_REG_3]) &&
> +	    !map_value_has_static_identity(&callee->regs[BPF_REG_3]))

reg_may_point_to_spin_lock() check here and below is redundant. Let's
drop it and save ourselves from necessity to analyze in which cases
PTR_TO_MAP_VALUE requires an .id.

map_value_has_static_identity() -- I don't think this predicate is
necessary either. Can you construct a realistic program requiring such
special case?

> +		callee->regs[BPF_REG_3].id =3D ++env->id_gen;
> =20
>  	/* pointer to stack or null */
>  	callee->regs[BPF_REG_4] =3D caller->regs[BPF_REG_3];
> @@ -10132,6 +10149,9 @@ static int set_timer_callback_state(struct bpf_ve=
rifier_env *env,
>  	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
>  	callee->regs[BPF_REG_3].map_ptr =3D map_ptr;
>  	callee->regs[BPF_REG_3].map_uid =3D map_uid;
> +	if (reg_may_point_to_spin_lock(&callee->regs[BPF_REG_3]) &&
> +	    !map_value_has_static_identity(&callee->regs[BPF_REG_3]))
> +		callee->regs[BPF_REG_3].id =3D ++env->id_gen;
> =20
>  	/* unused */
>  	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
> @@ -10250,6 +10270,9 @@ static int set_task_work_schedule_callback_state(=
struct bpf_verifier_env *env,
>  	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
>  	callee->regs[BPF_REG_3].map_ptr =3D map_ptr;
>  	callee->regs[BPF_REG_3].map_uid =3D map_uid;
> +	if (reg_may_point_to_spin_lock(&callee->regs[BPF_REG_3]) &&
> +	    !map_value_has_static_identity(&callee->regs[BPF_REG_3]))
> +		callee->regs[BPF_REG_3].id =3D ++env->id_gen;
> =20
>  	/* unused */
>  	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
