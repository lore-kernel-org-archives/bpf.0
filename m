Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0476413D6E;
	Wed, 27 May 2026 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889191; cv=none; b=c+Qhn/j5goglNAFUivaIVTN7jVCwNTo9W0dvE/UYg6CoQBwDC/7SbC0O8n7W5bMDE+rNqI58Roz2OTtTHQ77uPjTZy0dyHmSXgDTxo9vGd8JrSkKVKzHT+Yke2hX5F6H+oyI0m8+eOjkefRpEkKiYakPYI27Eia+nhOJCuqX1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889191; c=relaxed/simple;
	bh=rENs6adlKDfDZfgQvdxALJsiaiABMIitF4JwiKTMAMY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iXO2ZTEhFR8jbVqoFnXi42niq2PHhb9Bn5YeuatC3QyO3D22y1bms2yic8CjGoEgVn0k/2CimSkJFyjTypSJyBVYXQleYam02S8RN4XxBly1pBs354qPbtelRvX0VPBjr3zTXwfP27akVARz4M/LdDDAnK2VuVc6kSh1Y/tI4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEOyX7XL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEOyX7XL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535621F00A3D;
	Wed, 27 May 2026 13:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779889184;
	bh=+Cq+cv2zQ6ju7coPjClbdQ/OJDV3URVkCpagANFGtjA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HEOyX7XLQEiKB1WRudAIVNtCMjTVuqItiFn5IY36bsVINZIMi12kB6RW09SXbRb9h
	 MGRrPVnUAY5hzA/CI2cRW15g7PuO6tZSxRyxSXdT//M2dcPIVkK0OPXj4rF07yYmQs
	 fc88HnZ6HNQ6NCgf5uuTehWs/eOF999j3ZcvQ86zVQyqK9+TYzTt/z0BdU9bIKO9pv
	 K5p2RwvVRtSMwMCNFCu8smXZBBKGiWdEPqw3Z1USC/8XQfmwyDF6ARQUvXgtO8kkU3
	 pXG4DeDLI5tx8texsnKvrxof4UM66rukra0QxhAJz2odltaRR+y3GYW/uTwE02LTcI
	 ULf7+3Op8Hc9g==
Content-Type: multipart/mixed; boundary="===============5071417370446013920=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <df2a3460eb1b46d492faaa7cd0b20956291d537eb543631de31085123c254daf@mail.kernel.org>
In-Reply-To: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-2-27daa15487a9@google.com>
References: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-2-27daa15487a9@google.com>
Subject: Re: [PATCH v4 2/3] libbpf: zero out btf_key_type_id for STRUCT_OPS maps
From: bot+bpf-ci@kernel.org
To: sidnayyar@google.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,gprocida@google.com,maennich@google.com,sidnayyar@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 27 May 2026 13:39:44 +0000 (UTC)

--===============5071417370446013920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 420d37f215ea..673fa0242b4c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5440,6 +5440,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>  		map->btf_value_type_id = 0;
>  		break;
>  	case BPF_MAP_TYPE_STRUCT_OPS:
> +		create_attr.btf_key_type_id = 0;
>  		create_attr.btf_value_type_id = 0;
>  		break;
>  	default:

This change fixes the issue in bpf_object__create_map(), but what about
gen_loader mode?

In bpf_gen__map_create() (tools/lib/bpf/gen_loader.c), when
btf_vmlinux_value_type_id is set for STRUCT_OPS maps, it's not copied
to the attr structure:

    attr.btf_key_type_id = tgt_endian(map_attr->btf_key_type_id);
    attr.btf_value_type_id = tgt_endian(map_attr->btf_value_type_id);
    /* btf_vmlinux_value_type_id is never copied */

This means gen_loader mode (light skeletons) will pass
btf_vmlinux_value_type_id=0 to the kernel, breaking STRUCT_OPS map
creation. Does this need to be addressed?

Also, the conditional that copies btf_fd in bpf_gen__map_create():

    if (map_attr->btf_value_type_id)
        move_stack2blob(gen, attr_field(map_create_attr, btf_fd), 4,
                        stack_off(btf_fd));

This condition evaluates to false for STRUCT_OPS maps since
btf_value_type_id is now explicitly zeroed. Won't this prevent
btf_fd from being copied to the kernel attributes?

The kernel expects a valid btf_fd even for STRUCT_OPS maps (see
kernel/bpf/syscall.c comments: "Even the map's value is a kernel's
struct, the bpf_prog.o must have BTF to begin with to figure out
the corresponding kernel's counter part."). Without btf_fd,
btf_get_by_fd(0) will fail.

It looks like both of these issues are fixed in the next commit
(fe6415fcc857b593808826b2e8d157237162782b), but should they be addressed
in this patch to avoid bisection breakage?

Regarding the commit message:

> libbpf: zero out btf_key_type_id for STRUCT_OPS maps
>
> For BPF `STRUCT_OPS` maps (such as `sched_ext_ops` maps), the kernel BPF
> subsystem enforces strict map-creation safety validations inside
> `map_create()`.  That is, if `btf_vmlinux_value_type_id` is set, the
> kernel forbids passing any userspace `btf_key_type_id` or
> `btf_value_type_id` (they must both be `0`).
>
> However, inside libbpf's map-creation options initialization
> (`bpf_object__create_map()`), libbpf zeroed out
> `create_attr.btf_value_type_id` but does not zero out
> `create_attr.btf_key_type_id`.
>
> Fix this by explicitly zeroing out `create_attr.btf_key_type_id`.
>
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>

This looks like a bug fix but lacks a Fixes: tag. The bug was
introduced when STRUCT_OPS support was added to libbpf. Should this
include:

  Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")

Also, Alexei Starovoitov requested a selftest in v3 of the patch series:

  "The selftest is mandatory to prove that."

  https://lore.kernel.org/bpf/CAADnVQ+AA_fmRw7uRwdL2TMyMbpWeebOQKb=0wvpKiQR6Ee5xQ@mail.gmail.com/

Has this been addressed in v4? Without a selftest proving that
STRUCT_OPS maps work correctly in light skeleton mode, how can we
verify the fix is complete?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26512949106
--===============5071417370446013920==--
