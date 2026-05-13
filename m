Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19F349CDA
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714475; cv=none; b=PxKuhLAIND1NRQ0qPIV1O6JTkO9BD6Vx150S4wJlwRf4sQUn+H8GuCGzPTFx2QagMpg7cp2kA/nQERDrW9xM4oF81ThL6OgzZkc/cm6dulO/QAUkPSK0DfjM+ROoiuti5D13u9QlMvxoaH5UexDOcrN0s2Z43SQlPolUU48sQTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714475; c=relaxed/simple;
	bh=gykpX8I4HW6c0E701qqp+KvPSpyWypXa8JbDou//jdI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Xa9pQaxyWyxM0pCJcxIhVm1Yr1/FmSt3NCly+UMJJesAzhV8X/Jez5Ecrz3mFEW8jFUotSHa2lrpwEFu/QpDyWgpf7hKNG6Dj+Bffck0oMBJkCvnb6l0T6d7UtcPZucqWL2sl5c1XQpDlNqQPf6jGFZ8ifZWR4p4X4w7PdAZxFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAP2H72v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAP2H72v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2993C19425;
	Wed, 13 May 2026 23:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778714475;
	bh=gykpX8I4HW6c0E701qqp+KvPSpyWypXa8JbDou//jdI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dAP2H72vn8nK1hLXEHwH3IEEOV7KVZuWPBfhke+5I+GA/Ay7WpRmCXdpv0uLK9EG/
	 qurkAptag6U3t3lQIBIFC4/5LDEVwx8yHX4omehWK7SaMZmoAFaTx0cKYZD7zRID/E
	 OP97CWWl4MmGg5cid0JV1LUQfAQ1w7fCJcvAJv//IxKmRFiGg42xWqDdqV5PwwRTTK
	 V5YFzB5theHI0qTIAaBuwZpc6kzhRMBNGQcgQY0hcqm9aMcxlsaLcoWF+GhdgvEprd
	 Tlk7Ol3gEDAponj+IabYEIgae/T5piX6RwHdtPohJFndRReIMEAYbpNbxjsOuDtb3y
	 q15EWs+vRB0CA==
Content-Type: multipart/mixed; boundary="===============3544909184672967376=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <252dc423a3bc75b3f4d936e7706085da71939a88a7ef148926c317d463d20a12@mail.kernel.org>
In-Reply-To: <20260513-rhash-v4-5-dd3d541ccb0b@meta.com>
References: <20260513-rhash-v4-5-dd3d541ccb0b@meta.com>
Subject: Re: [PATCH bpf-next v4 05/11] bpf: Allow special fields in resizable hashtab
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,herbert@gondor.apana.org.au
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 13 May 2026 23:21:13 +0000 (UTC)

--===============3544909184672967376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 61eb88cb9229..9cc41850dc79 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -2943,6 +2965,7 @@ static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void
>  static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
>  				      u64 map_flags)
>  {
> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>  	void *old_val = rhtab_elem_value(elem, map->key_size);
>
>  	if (map_flags & BPF_NOEXIST)
> @@ -2952,6 +2975,13 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
>  		copy_map_value_locked(map, old_val, value, false);
>  	else
>  		copy_map_value(map, old_val, value);
> +
> +	/*
> +	 * copy_map_value() skips special-field offsets, so old timers/
> +	 * kptrs/etc. still sit in the slot. Cancel them after the copy
> +	 * to match arraymap's update semantics.
> +	 */
> +	rhtab_check_and_free_fields(rhtab, elem);
>  	return 0;
>  }

Could calling rhtab_check_and_free_fields() after copy_map_value() create
a race with concurrent BPF programs?

When copy_map_value() skips special field offsets, the old timer/kptr/etc.
remains active in the slot during the copy. If a concurrent program acquires
the spinlock (in the BPF_F_LOCK case via copy_map_value_locked) or just
accesses the value between copy and free operations, couldn't it still use
those special fields even after rhtab_check_and_free_fields() cancels them?

In v3 of this series, sashiko-bot raised this concern about the ordering
of these operations. While the patch moved rhtab_check_and_free_fields()
to occur after the copy (matching arraymap semantics), the fundamental
timing window between copy and free still allows concurrent access to
special fields that are about to be canceled.

[ ... ]

Commit message:

>     bpf: Allow special fields in resizable hashtab
>
>     Add support for timers, workqueues, task work and spin locks.
>     Without this, users needing deferred callbacks or BPF_F_LOCK in a
>     dynamically-sized map have no option - fixed-size htab is the only
>     map supporting these field types. Resizable hashtab should offer the
>     same capability.
>
>     Properly clean up BTF record fields on element delete and map
>     teardown by wiring up bpf_obj_free_fields through a memory allocator
>     destructor, matching the pattern used by htab for non-prealloc maps.
>
>     Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

This looks like a bug fix for resizable hashtab support. Should this
include:

  Fixes: 9cf2facd6b40 ("bpf: Implement resizable hashmap basic functions")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25830929099
--===============3544909184672967376==--
