Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0538B7C9
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777831057; cv=none; b=d1VZqvLrkY8fz6U1WbyFH0d9dX7f91oluk/NMUgf0f5lXOtQ6bHZ3+toDeJ/SKrCXz5bcEVfcBjwduPJb4kL6jpha6TyKcEt1xZG5Y5q4v3F9RyeAPL6cI7M0rGF96MpR5Vx0oAXYN2mQdu6gdXK+udwBV9Khn9gnybUweXL7B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777831057; c=relaxed/simple;
	bh=zVts2Sl56neHgMzrpJEoNG6Bprg9zkois4U0qEFaEGM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bU97F8dJHTyHNDCWu71bW7Mx+MmfubO1Epy218dPZlgs+vmiXdYMGrGOU4ti062Cbg3V0N1MIi9N1WA7BUMsoBEF7pHlKTiqB8mwDJU7msFrBdeTBpkefGUvSpv5SLFfWGRuptojQRZ0I0Pm24SU2VkhzFacnZFJ2P91zWfevE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRg7jFdt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRg7jFdt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6190AC2BCB4;
	Sun,  3 May 2026 17:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777831057;
	bh=zVts2Sl56neHgMzrpJEoNG6Bprg9zkois4U0qEFaEGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YRg7jFdtf1oq5wBfFfoLCtzsHt636LKUSt2fyXyLqMxG6aT1acds4Lc6q11GmiZLw
	 a33eR/zHbKk1KWMA3P0chHbQ7macBVVbgMzKzx0zqQSpqM5rGioelwXQkVr8r0yWWc
	 a70CZ7ECcJGK4QFzfC7qfUEAobY4Oq5W33oIk70Tt4hLq9odMvl4U4vS1lr/p6W6Ut
	 xTNkQ/l3e0YYuOViX3Cy1IZFl39SpSXHqiTIBbQXn2kcg79ItLPqKZ3cxjJHH0C0zf
	 q+GLWdCLoxdfxXhrvKB1zh0qJnIVT7t7EqCu8s3tbt8O9Np7hjkZm2xN7y1hmIZsRl
	 nl39PYaaGOTCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] samples: bpf: add mthp_ext
Reply-To: sashiko@lists.linux.dev
To: "Vernon Yang" <vernon2gm@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260503165024.1526680-5-vernon2gm@gmail.com>
References: <20260503165024.1526680-5-vernon2gm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 17:57:36 +0000
Message-Id: <20260503175737.6190AC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Infinite loop in `trigger_scan()` when `read()` returns an error
- [Medium] Integer overflow in `FROM_MB()` macro disables fallback logic fo=
r values >=3D 4096
- [Medium] Spurious mTHP fallback during initial cgroup scan due to zero-in=
itialized baseline
- [Medium] Failure in `setup_psi_trigger()` masks the error code and exits =
successfully
--

commit d30597e7a4d6ca7d5532535074e0c66c2c92f486
Author: Vernon Yang <yanglincheng@kylinos.cn>

samples: bpf: add mthp_ext

This commit adds a new BPF sample program, mthp_ext, to adjust mTHP sizes
based on cgroup memory pressure and usage. It monitors the cgroup directory
and automatically falls back to 4KB sizes during high memory pressure or
low usage.

> diff --git a/samples/bpf/mthp_ext.h b/samples/bpf/mthp_ext.h
> new file mode 100644
> index 000000000000..33dc01bcebd3
> --- /dev/null
> +++ b/samples/bpf/mthp_ext.h
> @@ -0,0 +1,30 @@
[ ... ]
> +#define min(a, b)	((a) < (b) ? a : b)
> +#define FROM_MB(s)	(s * 1024 * 1024)

Does this macro suffer from a 32-bit integer overflow if s is 4096 or
larger?

If s is an unsigned int like configs.min_mem, 4096 * 1048576 would wrap to =
0,
which could silently disable the fallback logic.

> +#define TO_MB(s)	(s / 1024 / 1024)
> +
> +struct config_local {
> +	unsigned long threshold;
> +	unsigned long interval;
> +	unsigned int  init_order;
> +	unsigned int  min_mem;
[ ... ]
> diff --git a/samples/bpf/mthp_ext.bpf.c b/samples/bpf/mthp_ext.bpf.c
> new file mode 100644
> index 000000000000..bbee3e9f679c
> --- /dev/null
> +++ b/samples/bpf/mthp_ext.bpf.c
[ ... ]
> +SEC("iter.s/cgroup")
> +int cgroup_scan(struct bpf_iter__cgroup *ctx)
> +{
> +	struct cgroup *cgrp =3D ctx->cgroup;
> +	struct mem_cgroup *memcg;
> +	struct mem_info *info;
> +	struct alert_event *e;
> +	unsigned long curr_stall;
> +	unsigned long curr_mem;
> +	unsigned long delta;
> +
> +	if (!cgrp)
> +		return 1;
> +
> +	if (!cgroup_has_tasks(cgrp))
> +		return 0;
> +
> +	info =3D bpf_cgrp_storage_get(&cgrp_storage, cgrp, 0,
> +				    BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!info)
> +		return 0;
> +
> +	memcg =3D bpf_get_mem_cgroup(&cgrp->self);
> +	if (!memcg)
> +		return 0;
> +
> +	bpf_cgroup_flush_stats(cgrp);
> +	curr_stall =3D bpf_cgroup_stall(cgrp, PSI_MEM_FULL);
> +	delta =3D curr_stall - info->stall;

During the initial scan of a cgroup, info->stall will be zero-initialized.
Since curr_stall represents cumulative stall time, won't delta be a very
large number?

This seems like it could incorrectly trigger the 4KB fallback during the
first interval regardless of current memory pressure.

> +	bpf_mem_cgroup_flush_stats(memcg);
> +	curr_mem =3D bpf_mem_cgroup_page_state(memcg, NR_ANON_MAPPED) +
> +		   bpf_mem_cgroup_page_state(memcg, NR_SHMEM);
> +	if (curr_mem < FROM_MB(configs.min_mem) || delta >=3D configs.threshold)
> +		info->order =3D 0;
> +	else
> +		info->order =3D PMD_ORDER;
[ ... ]
> diff --git a/samples/bpf/mthp_ext.c b/samples/bpf/mthp_ext.c
> new file mode 100644
> index 000000000000..0e064bad136f
> --- /dev/null
> +++ b/samples/bpf/mthp_ext.c
[ ... ]
> +static int trigger_scan(struct bpf_link *iter_link)
> +{
> +	char buf[256];
> +	int fd;
> +
> +	fd =3D bpf_iter_create(bpf_link__fd(iter_link));
> +	if (fd < 0) {
> +		fprintf(stderr, "ERROR: bpf_iter_create failed: %s\n",
> +			strerror(errno));
> +		return -1;
> +	}
> +
> +	/* Read to trigger the iter program execution */
> +	while (read(fd, buf, sizeof(buf)))
> +		;

If read() returns an error (like -1 for EINTR), will this result in an infi=
nite
busy-wait loop since -1 evaluates to true in C?

Could this be updated to check for > 0 instead?

> +
> +	close(fd);
> +	return 0;
> +}
[ ... ]
> +int main(int argc, char **argv)
> +{
[ ... ]
> +	psi_fd =3D setup_psi_trigger(root_path, "some", threshold * 1000,
> +				   interval * 1000);
> +	if (psi_fd < 0) {
> +		fprintf(stderr, "ERROR: PSI trigger setup failed\n");
> +		goto psi_setup_fail;
> +	}
> +
> +	monitor_thread(psi_fd, &skel->bss->configs, iter_link, rb);
> +
> +	close(psi_fd);
> +psi_setup_fail:
> +	ring_buffer__free(rb);
> +rb_fail:
> +	bpf_link__destroy(iter_link);
> +exit_fixed:
> +attach_iter_fail:
> +	bpf_link__destroy(ops_link);
> +attach_opts_fail:
> +load_skel_fail:
> +	mthp_ext__destroy(skel);
> +open_skel_fail:
> +	close(root_fd);
> +
> +	printf("\nExiting...\n");
> +
> +	return err;
> +}

If setup_psi_trigger() fails, the code jumps to psi_setup_fail. However, err
was previously set to 0 from a successful BPF operation.

Does this cause the program to log an error but exit with a success status
code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503165024.1526=
680-1-vernon2gm@gmail.com?part=3D4
