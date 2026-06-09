Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834F3D5253
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998925; cv=none; b=Rh2hKoICHimL/J27jKRqnMs8A3knW+jWiVzM/fxkrsgVN4tNOMXYwDUQ1LGp5knCE91CK261JL5jcjnRHvEqDR3vrTUqYR9qXrMxdKIcVRPcOs+HdsRYVnHdS8PuqztMvH89BOs7rncH+ua8RnFoNQ3uy542z+zICWXQ15PsF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998925; c=relaxed/simple;
	bh=DcBFsIpAZhGV4SWAntpK9gOP0R33pu3PxexqnuhfXzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F7zSn3CFRe6H2jj34y7JHTiEcjOrLLo/AFllbFz4cduznCb7XR2H5lCtfV4Zoxu0TL+Z2H15s5Eifn+IoL80H6Hushvw/2V4GqWZWWiAiOFdQgBtq8rw1suN7yfRDw+KIXzRKS2oqex4a8FOPLt8+/desUKlScv3Gnkpq9l7HpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gx+k18nN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gx+k18nN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE501F00893;
	Tue,  9 Jun 2026 09:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780998924;
	bh=fOTKfp2g1PtYi407qKWhxiXLUPEzfiVWr56yAWFfTWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gx+k18nNLPBNp0OWZcB5GCI9QjLEuE047+7fk2DoF8UtJs0oz8e1RY/2tWFZphDwx
	 QdbKX9E2dpXcrun3qZIoBZAIFQCIC6K3XnOeDGfAWu1cdfmuM90N9zh16uodgAWnP3
	 +ibjms+gRh/mclNx1qmt8lJeGLzcZ1Yj39pBJFOxzfL+/HqqDjafUTYT8wwOEGNvuQ
	 rfJLcxr62IU3k/6wNObiepmrh7BsICw1XiIjqecBcabSQ82hb5nEcbaa106en+jynO
	 wZDNhc91Y4J8z1yUNHiP8Eejl6W1CnencWexjk20RsUZDVr16ruoGig1MENVk9qc11
	 dOCHbDymRnW2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Cancel special fields on map value
 recycle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609093719.2858096-3-memxor@gmail.com>
References: <20260609093719.2858096-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 09:55:23 +0000
Message-Id: <20260609095524.3AE501F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Replacing `bpf_obj_free_fields()` with `bpf_obj_cancel_fields(=
)` fails to zero or free kernel pointers on map element deletion and update=
, causing new hash map keys to inherit valid kptrs from deleted elements (c=
ross-key contamination).
--

commit a156fa02499cc2be66e3982937fa823e00008e97
Author: Justin Suess <utilityemal77@gmail.com>

    bpf: Cancel special fields on map value recycle

This commit introduces bpf_obj_cancel_fields() for NMI-safe cleanup of time=
r,
workqueue, and task_work fields on map value recycle. It replaces
bpf_obj_free_fields() in the array and hashtab update/delete/recycle paths.

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index e6271a2bf6d64..4e8d6fe6999bf 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
[ ... ]
> @@ -392,7 +392,7 @@ static long array_map_update_elem(struct bpf_map *map=
, void *key, void *value,
>  			copy_map_value_locked(map, val, value, false);
>  		else
>  			copy_map_value(map, val, value);
> -		bpf_obj_free_fields(array->map.record, val);
> +		bpf_obj_cancel_fields(array->map.record, val);
>  	}
>  	return 0;

[Severity: Critical]
Does replacing bpf_obj_free_fields() with bpf_obj_cancel_fields() fail to c=
lear
old kptrs in the array slot?

Since the new bpf_obj_cancel_fields() helper only processes timers and
workqueues, the old kernel pointers (like BPF_KPTR_REF) seem to remain valid
and unzeroed in the slot indefinitely.

[ ... ]
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index b4366cad3cfa5..a9b2b882b90f2 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
[ ... ]
> @@ -844,11 +848,11 @@ static void check_and_free_fields(struct bpf_htab *=
htab,
>  		int cpu;
> =20
>  		for_each_possible_cpu(cpu)
> -			bpf_obj_free_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
> +			bpf_obj_cancel_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
>  	} else {
>  		void *map_value =3D htab_elem_value(elem, htab->map.key_size);
> =20
> -		bpf_obj_free_fields(htab->map.record, map_value);
> +		bpf_obj_cancel_fields(htab->map.record, map_value);
>  	}
>  }

[Severity: Critical]
Can this leak kernel pointers between different hash keys?

When a hash map element is deleted, check_and_cancel_fields() is called.
Because it doesn't clear kptrs, the element is returned to the memory cache=
 or
preallocated freelist with its kernel pointers still intact.

When a new hash map element is inserted for a different key, alloc_htab_ele=
m()
reuses this memory. Because copy_map_value() safely skips writing to special
BTF field offsets:

alloc_htab_elem() {
    ...
    copy_map_value(&htab->map, htab_elem_value(l_new, key_size), value);
    ...
}

won't the new element silently inherit the valid kernel pointers from the
previously deleted key?

[ ... ]
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index d4188a992bd8b..8d12aa3728ea9 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
[ ... ]
> +void bpf_obj_cancel_fields(const struct btf_record *rec, void *obj)
> +{
> +	const struct btf_field *fields;
> +	int i;
> +
> +	if (IS_ERR_OR_NULL(rec))
> +		return;
> +	fields =3D rec->fields;
> +	for (i =3D 0; i < rec->cnt; i++) {
> +		void *field_ptr =3D obj + fields[i].offset;
> +
> +		switch (fields[i].type) {
> +		case BPF_TIMER:
> +			bpf_timer_cancel_and_free(field_ptr);
> +			break;
> +		case BPF_WORKQUEUE:
> +			bpf_wq_cancel_and_free(field_ptr);
> +			break;
> +		case BPF_TASK_WORK:
> +			bpf_task_work_cancel_and_free(field_ptr);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}

[Severity: Critical]
Since this new helper handles BPF_TIMER, BPF_WORKQUEUE, and BPF_TASK_WORK,
doesn't it leave fields like BPF_KPTR_REF, BPF_LIST_HEAD, BPF_UPTR and
BPF_RB_ROOT completely intact without zeroing them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609093719.2858=
096-1-memxor@gmail.com?part=3D2
