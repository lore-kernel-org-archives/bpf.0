Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54078402423
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345938; cv=none; b=djF0TrpVDZk7y7PK9zEng+6DFSzJnRsKKyNhYME2neau+rszjoH6VpfMR+O6iDkY5za2DLWOXTquNW4vtgawvr4zHhM/tBXu3wBNVMv+UF8QrXjwIF/yVhhPdT6Ctgegg3H4dGDO12LDCsK2MZyhvt2FXydLlmgFiWx6Y/7z7ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345938; c=relaxed/simple;
	bh=1zMP1xvl/GXf/Q4HOpT6QcGVkT90QRtytTsKrfdMtbY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jC7baI0LuKqxPyjKpPkGY1vuh99qhfXKAlNBAb7WH+APTdTF2DAKlk2T4lMv1M+EU9AvUjHb5HR+Z0q4WjOzP0IkbcOTgz8eadXLDK0yORwU5DHa+eZt8SOyBvXSStGf6wj4ykuUPGz+Ir+wfUXu6EqcMD9QCeioG19jc72bboU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ey0LVf9T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ey0LVf9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEAAC2BC9E;
	Thu, 12 Mar 2026 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773345938;
	bh=1zMP1xvl/GXf/Q4HOpT6QcGVkT90QRtytTsKrfdMtbY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ey0LVf9TfHkJnl6KWyyvLSPhXfDST7HSsNQqsc5+oXybABj14VxQHk4wInUA7eM8e
	 6XCirmilEMsnQjXz/wViroF2P0y2kPLYZ7exO8NMEfGMOr/h+cWWRWtuFaVmqfu3qX
	 Fi0QZAPoMnfpRhedS1QeRCKNbvxpL4hjN6j6Sdvob3vFDDqR29P/KR7IyfIsFifLoo
	 w9CUevK9LQ2zoLk9mc2zndyKbKAAPRMAzk6VbPSZ8BBlPbH0SmoNVpsdFcbCojaL10
	 oDq7DYzRvzydPoV4auAMkY4vyNnKX4eTh3rS70HvieAs9LtFzWDxNXIjPys2biaYoe
	 iBhTzFI0iugaQ==
Content-Type: multipart/mixed; boundary="===============1908534947561405693=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2512f1b588a1828236698c2c6228d9dc3892d98b33c534a8cfe4c288860e1ff3@mail.kernel.org>
In-Reply-To: <20260312193546.192786-2-ihor.solodrai@linux.dev>
References: <20260312193546.192786-2-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Update kfuncs using btf_struct_meta to new variants
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com
Cc: alexis.lothore@bootlin.com,bpf@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 12 Mar 2026 20:05:37 +0000 (UTC)

--===============1908534947561405693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -8,156 +8,11 @@ #define __BPF_EXPERIMENTAL__
>  #define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))

[ ... ]

> -extern void *bpf_percpu_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
> +/* Convenience macro to wrap over bpf_obj_new */
> +#define bpf_obj_new(type) ((type *)bpf_obj_new(bpf_core_type_id_local(type)))
>
>  /* Convenience macro to wrap over bpf_percpu_obj_new_impl */
> -#define bpf_percpu_obj_new(type) ((type __percpu_kptr *)bpf_percpu_obj_new_impl(bpf_core_type_id_local(type), NULL))
> +#define bpf_percpu_obj_new(type) ((type __percpu_kptr *)bpf_percpu_obj_new(bpf_core_type_id_local(type)))

The comment above bpf_percpu_obj_new still says "wrap over
bpf_percpu_obj_new_impl" but the macro now wraps bpf_percpu_obj_new.

> -extern void bpf_percpu_obj_drop_impl(void *kptr, void *meta) __ksym;

The extern for bpf_percpu_obj_drop_impl is removed here, but later
in the same file the bpf_percpu_obj_drop macro was not updated:

    /* Convenience macro to wrap over bpf_obj_drop_impl */
    #define bpf_percpu_obj_drop(kptr) bpf_percpu_obj_drop_impl(kptr, NULL)

Was bpf_percpu_obj_drop missed? Every other kfunc in this commit was
moved from the _impl variant to the new KF_IMPLICIT_ARGS variant
(bpf_obj_new, bpf_obj_drop, bpf_percpu_obj_new, bpf_refcount_acquire,
bpf_list_push_front, bpf_list_push_back, bpf_rbtree_add), but
bpf_percpu_obj_drop still goes through bpf_percpu_obj_drop_impl.

The macro is used in test_bpf_ma.c in batch_percpu_alloc() and
batch_percpu_free().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23020502189
--===============1908534947561405693==--
