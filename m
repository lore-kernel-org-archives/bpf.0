Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33153BD647;
	Mon,  9 Mar 2026 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060873; cv=none; b=GUcCjxtZ4uB2GIYE8sZYj/h2/Jd+mF7poXi51WH9PlkR3XTbhCCFjuCRV5GQsnSJ91ZK1qZjQ9nXJvlkRHxgwXQzEDcVM5IYUlX5pL6FPTvWrkLk5+Sr0v0vjrL0+vlHprufSrTztiy5GxXqiYWR1cVKf4hCOKC5aJEP3O53odE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060873; c=relaxed/simple;
	bh=bmv2yxNC4kv3255SjuxNbeF6y4xHz5zJ8lAJJi0EVuQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VnUiRSaRj5DaijlE5l+9Ip45hCA3tt7I4LX6H0nl6gStg/rVKw45HlbLk9TXgxTlygzLDGLtupnxUMDCE/b43NyUgOJWPkJKAYokPoxX2hxnh+9Xth/1Nzodx9p3gSuXXq3dP/Q6QYPf/J8cAqG5dln0h3Iczhj6XeqhjfJceHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jq8tAq0i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jq8tAq0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BF3C4CEF7;
	Mon,  9 Mar 2026 12:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773060873;
	bh=bmv2yxNC4kv3255SjuxNbeF6y4xHz5zJ8lAJJi0EVuQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Jq8tAq0inoxR9GqEaSUKLy5RuK7UAFy7A3TVS2uXXnfemQE2NYukZRMJgYV+XT+0U
	 sW/M331Vcx7NsT5f3zMWNM4H7QVr6Hna+IXBvK/DjU7anYSsHiDDQ4dmySTOyOcexh
	 Thbu4iF3tQdlyekMdtp/KN1GC9m2CtBcGWAkxYtQz/DqKHQSwwyLcw8IqNgcISM3DQ
	 GEAoSHNrT5cnYVZHBDs6jgwCJHt6erpABT1//qQ4jEyRhYmlnzDqzSJnkLRBCemvab
	 J5cCuFmQt7N821O89dQeKDBthYJNGD05TGPheHxch+p2ka7dxmchxhhWio4Mdx+ucI
	 d6npd1rPok7Vg==
Content-Type: multipart/mixed; boundary="===============0450728247394666353=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <847cfc0fded072f6930f8ae9680f22f3d6b4191de77abeda97d430cf8a4f83d0@mail.kernel.org>
In-Reply-To: <20260309121033.2594457-2-bqe@google.com>
References: <20260309121033.2594457-2-bqe@google.com>
Subject: Re: [RFC PATCH 1/1] bpf, docs: structured docs for the verifier
From: bot+bpf-ci@kernel.org
To: bqe@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bqe@google.com,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,corbet@lwn.net,bpf@vger.kernel.org,linux-doc@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  9 Mar 2026 12:54:33 +0000 (UTC)

--===============0450728247394666353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Multi-part docseries (verifier-formal-*.rst) for BPF verifier.

The files are named verifier-overview-*.rst, not
verifier-formal-*.rst.

> diff --git a/Documentation/bpf/verifier-overview-2-domain.rst b/Documentation/bpf/verifier-overview-2-domain.rst
> new file mode 100644
> index 000000000000..8a9d36818f24
> --- /dev/null
> +++ b/Documentation/bpf/verifier-overview-2-domain.rst

[ ... ]

> +* **Top ($\top$)**: The most general state. It represents *any* possible value. The verifier has zero knowledge. In the code, this is represented by the ``tnum_unknown`` bitmask and the widest possible numeric bounds (``umin_value = 0``, ``umax_value = U64_MAX``, ``smin_value = S64_MIN``, ``smax_value = S64_MAX``), applied via functions like ``__mark_reg_unknown()`` and ``__mark_reg_unbounded()``.
> +* **Intermediate Values**: Partial knowledge (e.g., "the value is between 5 and 10," or "the lower 3 bits are 0").
> +* **Bottom ($\bot$)**: The most specific state. It represents an impossible or contradictory state (e.g., a value that must be simultaneously > 10 and < 5). The verifier does not have an explicit ``struct`` for Bottom; instead, it manifests as contradictory bounds (e.g., ``umin_value > umax_value``). When the verifier encounters this, it identifies the execution path as dead code and stops exploring it.

The $\top$ and $\bot$ LaTeX notations will not render in Sphinx
RST. The kernel documentation build uses Sphinx with mathjax as
the math renderer, but dollar-sign delimiters are not enabled by
default. These will appear literally as "$\top$" and "$\bot$" in
the generated HTML.

The standard RST inline math syntax would be :math:`\top` and
:math:`\bot`. The same issue appears in a few other places across
Parts 2, 3, and 4 (e.g. the $\top$ in the tnum_unknown example
and in Part 3's overflow section and Part 4's subsumption
examples).

> diff --git a/Documentation/bpf/verifier-overview-4-pruning.rst b/Documentation/bpf/verifier-overview-4-pruning.rst
> new file mode 100644
> index 000000000000..f1515011d721
> --- /dev/null
> +++ b/Documentation/bpf/verifier-overview-4-pruning.rst

[ ... ]

> +The verifier tracks this using ``REG_LIVE_READ`` and ``REG_LIVE_WRITTEN`` flags. During the ``states_equal()`` check, if a register is marked as dead in the *existing state*, the verifier knows that this register will remain dead regardless of how the current path is explored. As a result, it completely ignores the value of that register in the *current state*.

REG_LIVE_READ and REG_LIVE_WRITTEN do not exist anywhere in the
current kernel tree. The actual liveness mechanism is implemented
in compute_live_registers(), which uses bitmask-based
insn_live_regs structs with in/out/use/def fields, and stores the
results as insn_aux[i].live_regs_before.

Could these references be updated to describe the actual
implementation?

> diff --git a/Documentation/bpf/verifier-overview-5-advanced.rst b/Documentation/bpf/verifier-overview-5-advanced.rst
> new file mode 100644
> index 000000000000..f18d13dd8cab
> --- /dev/null
> +++ b/Documentation/bpf/verifier-overview-5-advanced.rst

[ ... ]

> +The ``struct bpf_verifier_state`` includes fields like ``active_spin_lock`` and ``active_rcu_lock``.
> +
> +* **Spinlocks**: When a program calls the helper ``bpf_spin_lock(map_value)``, the verifier's transfer function asserts that no lock is currently held. It then updates ``active_spin_lock`` with the identity of the map value.

The field active_spin_lock does not exist in struct
bpf_verifier_state. The actual fields are active_locks (u32),
active_lock_id (u32), and active_lock_ptr (void *).

Similarly, active_rcu_lock should be active_rcu_locks (plural) to
match the actual field name in the struct.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22853419607
--===============0450728247394666353==--
