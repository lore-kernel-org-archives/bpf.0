Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B3234964;
	Sun,  3 May 2026 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777829010; cv=none; b=TFWy1GZt0sBqSyUuoBTj4+xcESe/zZx3g4dry+p7dWbK5EEwFCG+hkXzt5T/c55NS9vEoVg2GJFYKbezQPy9sK9Ta8gsIRFx784B1aFyP3hJMl3ckuGIBUVF8IXN/XDjg0yze/pfbkvnUefyzhuajJ8ZElYqh+mEx/5YRhDujb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777829010; c=relaxed/simple;
	bh=MAX1WLXMN+1GNFQMEzikaKWBNYQVg3O6ltYlnFE7FsA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Y870UvkL63kUEgvfrWvnJHGOqnStUdVaiakc8BMMAXHGy4IHteTrX+KNXG27i0Q2DJGEl8lohrNl9DAhBsl3swxZA6zfPQTsCTl+9jTIFXLDbXB5HbYlu7EK+WlIhS+zEo1y22tmzF0B8uD0wBr5IHCgS8cRi5ni33KLixXrX7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0Va3qU7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0Va3qU7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6890EC2BCB4;
	Sun,  3 May 2026 17:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777829010;
	bh=MAX1WLXMN+1GNFQMEzikaKWBNYQVg3O6ltYlnFE7FsA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=a0Va3qU7k0KT2KpuPOfeQKseLEbqBUjzORSfVBhgmDQOObUBkkCdxvDoHLjpd43F1
	 4h5E8P8OrIs5Z0UILb+AOKF+7NCz7YXpKCyj9Yrm7i/7DQN7Py2Q8AaguvE2ct80tm
	 d+wSUyyFPwtOAtNKc4KXOoPjSXJ1b/vVLlu8uJT6+MCJS/T6HrPlm14plfWF9Qx3bJ
	 UevK+enFcqpLdvPcaERjr8HF9MWDcVbVW62RtlPF7gxfDqB37rwvPQq7rdAkhJPipZ
	 MRt8QpthU5PmyJRppz6aMhFBNwH+8Yz3X+DuoJRCmFErqNvlaQc6z+OiLcpznurp04
	 E7ix8cgHvBKcA==
Content-Type: multipart/mixed; boundary="===============1060358541369016392=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <91c02dbb561c7a4d760ff3314c99fed77870e0d7665848b5832f6719d21feb17@mail.kernel.org>
In-Reply-To: <20260503165024.1526680-3-vernon2gm@gmail.com>
References: <20260503165024.1526680-3-vernon2gm@gmail.com>
Subject: Re: [PATCH 2/4] bpf: add bpf_cgroup_{flush_stats,stall} function
From: bot+bpf-ci@kernel.org
To: vernon2gm@gmail.com,akpm@linux-foundation.org,david@kernel.org,ljs@kernel.org,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,ast@kernel.org,daniel@iogearbox.net,surenb@google.com
Cc: linux-kernel@vger.kernel.org,linux-mm@kvack.org,bpf@vger.kernel.org,baohua@kernel.org,lance.yang@linux.dev,dev.jain@arm.com,yanglincheng@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  3 May 2026 17:23:28 +0000 (UTC)

--===============1060358541369016392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index baa12b24bb64..d7b04f1fc9f1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -2819,6 +2820,32 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
>  	return cgrp;
>  }
>
> +/**
> + * bpf_cgroup_stall - acquire the total stall time of cgroup
> + * @cgrp: cgroup struct
> + * @states: psi states
> + *
> + * Return the total stall time.
> + */
> +__bpf_kfunc unsigned long bpf_cgroup_stall(struct cgroup *cgrp,
> +					   enum psi_states states)
> +{
> +	struct psi_group *group = cgroup_psi(cgrp);
> +
> +	return div_u64(group->total[PSI_AVGS][states], NSEC_PER_MSEC);
> +}

Can cgroup_psi() return NULL here? Looking at include/linux/psi.h, cgroup_psi()
returns cgrp->psi for non-root cgroups, which is allocated in
psi_cgroup_alloc() only when the psi_cgroups_enabled static branch is true.

When the kernel boots with cgroup_disable=pressure or psi=0, cgrp->psi remains
NULL for all non-root cgroups. The sysfs *.pressure files are gated by
cgroup_psi_enabled() so they never hit this case, but these new kfuncs are
directly callable from BPF programs without such gating.

A BPF program could obtain a valid non-root cgroup (e.g., via
bpf_cgroup_from_id) and call bpf_cgroup_stall on it. If PSI is disabled for
cgroups, this would dereference NULL at group->total[...].

Similarly for bpf_cgroup_flush_stats below, passing NULL to
psi_group_flush_stats would eventually reach __psi_group_flush_stats which
does mutex_lock(&NULL->avgs_lock).

Should these functions check for NULL after calling cgroup_psi()?

A subsystem pattern also flags this as potentially concerning: the `states`
parameter is used directly as an array index without bounds checking. The
backing array is declared as u64 total[NR_PSI_AGGREGATORS][NR_PSI_STATES - 1]
(see include/linux/psi_types.h, struct psi_group), while enum psi_states has
the range 0..NR_PSI_STATES-1 (PSI_NONIDLE is the last member).

The BPF verifier only checks that the register is SCALAR_VALUE and does not
validate enum ranges. Because the parameter is not marked __const, a BPF
program can pass any scalar, including values derived from map lookups or
arithmetic.

Passing PSI_NONIDLE (a valid enum value) reads one element past the inner
array; passing a negative value (legal because enum is signed int in C) reads
memory before the array. This would leak adjacent memory contents to the BPF
program.

Existing BPF cgroup-stat kfuncs guard against this pattern:

bpf_mem_cgroup_page_state (mm/bpf_memcontrol.c):
	if (unlikely(!memcg_stat_item_valid(idx)))
		return (unsigned long)-1;

bpf_mem_cgroup_memory_events (mm/bpf_memcontrol.c):
	if (unlikely(event >= MEMCG_NR_MEMORY_EVENTS))
		return (unsigned long)-1;

Should this function add a similar check, such as:
	if ((unsigned int)states >= NR_PSI_STATES - 1)
		return -1;

> +
> +/**
> + * bpf_cgroup_flush_stats - Flush cgroup's statistics
> + * @cgrp: cgroup struct
> + */
> +__bpf_kfunc void bpf_cgroup_flush_stats(struct cgroup *cgrp)
> +{
> +	struct psi_group *group = cgroup_psi(cgrp);
> +
> +	psi_group_flush_stats(group);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25285279315
--===============1060358541369016392==--
