Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63D3B7B98
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359847; cv=none; b=flcj9ZWWuVTZ7rpuQPN3dy/Kuis7eiwjHuxhGamS5EQjRQriY0s0vspQ5wO9Ke4AzsoweIs2ASsWqS93uefYlPp/xTjFCOuue2k7LyMKWoY3L3rMrReA5hT7sFhYGzr4U+iFaaKDzyRpkbTHnIVEGc4sX1q/6593oq2jJ3btKU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359847; c=relaxed/simple;
	bh=e+UpiJT/lH5rdzoigNg4SjYMWGrzmwQAPmxOJFaD5Lc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UTtGFzVcXX8eEcGzlsE4ccdegUy3rd50R1sz0p6JZ2LTsbLBdF/8wp91fjCJdz/I81slqrnr56gY3qnTLRiURhtCl3lqZOmNEuODM0+NsHWNe5QkmP7sbWGNCGV+IYCCjbNkgFnuS/pzLho4aQ0NnqC01FxQV5WVQ7GLRh6Jcqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdOz2iIb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdOz2iIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D21B1F000E9;
	Mon,  6 Jul 2026 17:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783359846;
	bh=9YHo+JZ7/ecsf2lCLqleFZqcFWAt0b4VGfiwYeM/PBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cdOz2iIb2JkLwfMo8Ve1OWoiJhZlDAWOXBW96dXQ5pWSm0GkYQJmw6IIfW8zmJooa
	 Vi2XQelDDdQXy0yUfktxbMaPw1mYvO5qLy6euzPf2mfLG8PEaCph8agHuu16P87hf6
	 dKnmxUt3KjDziGM1PfMBA1GcDDGV9wQW/O5nQR01X3Tiz66/bBHkK+069EvFGeXhVz
	 fjwMEKqNs/4A6v47oRoKEnrWtVCRS94e92OFgIu1UZ15HE0eRDnySk+XdO3ZocmUoh
	 z2uckoHODiGB9kajCtroPuo60oEhWAIR1qmItS6I3Hp26xmZPKUStic7JfPrs8aKlG
	 e94QQjUbCLAAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 02/15] bpf: Make struct_ops tasks_rcu grace
 period optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706171918.317102-3-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 17:44:05 +0000
Message-Id: <20260706174406.0D21B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-After-Free due to RCU-001 violation in bpf_struct_ops_map_free=
()
--

commit 1218e0fc116da5657ca3ee1c0ca920d127c6c75d
Author: Martin KaFai Lau <martin.lau@kernel.org>

bpf: Make struct_ops tasks_rcu grace period optional

This commit makes the tasks RCU grace period optional for struct_ops maps.
It adds a map_free_pre_rcu callback so ksyms can be removed before
bpf_map_put waits for a regular RCU grace period, and defers tasks RCU
synchronization to map free time only when required by the ops.

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index d06b3d9bcc13c..c422ce41873ee 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
[ ... ]
> @@ -997,24 +1006,8 @@ static void bpf_struct_ops_map_free(struct bpf_map =
*map)
> =20
>  	bpf_struct_ops_map_dissoc_progs(st_map);
> =20
> -	bpf_struct_ops_map_del_ksyms(st_map);
> -
> -	/* The struct_ops's function may switch to another struct_ops.
> -	 *
> -	 * For example, bpf_tcp_cc_x->init() may switch to
> -	 * another tcp_cc_y by calling
> -	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
> -	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
> -	 * and its refcount may reach 0 which then free its
> -	 * trampoline image while tcp_cc_x is still running.
> -	 *
> -	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
> -	 * to finish. bpf-tcp-cc prog is non sleepable.
> -	 * A rcu_tasks gp is to wait for the last few insn
> -	 * in the tramopline image to finish before releasing
> -	 * the trampoline image.
> -	 */
> -	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
> +	if (tasks_rcu && IS_ENABLED(CONFIG_TASKS_RCU))
> +		synchronize_rcu_tasks();
> =20
>  	__bpf_struct_ops_map_free(map);
>  }
[ ... ]
> @@ -1123,6 +1116,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(uni=
on bpf_attr *attr)
> =20
>  	mutex_init(&st_map->lock);
>  	bpf_map_init_from_attr(map, attr);
> +	map->free_after_rcu_gp =3D true;

[Severity: High]
Does this sequence introduce a use-after-free by violating the RCU "remove
before reclaim" ordering?

By setting map->free_after_rcu_gp =3D true, bpf_map_put() will now wait for=
 a
regular RCU grace period before invoking bpf_struct_ops_map_free():

bpf_map_put()
  call_rcu(&map->rcu, bpf_map_free_rcu_gp)
  ...
  // later in workqueue
  bpf_struct_ops_map_free()

However, the programs are unpublished from the map during
bpf_struct_ops_map_free():

static void bpf_struct_ops_map_free(struct bpf_map *map)
{
        ...
        bpf_struct_ops_map_dissoc_progs(st_map);
        ...
        __bpf_struct_ops_map_free(map);
}

Because the unpublish operation (bpf_struct_ops_map_dissoc_progs) happens
after the RCU grace period has already elapsed, could a concurrent BPF prog=
ram
execution (e.g., via bpf_prog_test_run()) start after the grace period begi=
ns,
find the still-associated struct_ops pointer, and access it while it is bei=
ng
synchronously freed by __bpf_struct_ops_map_free()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706171918.3171=
02-1-ameryhung@gmail.com?part=3D2
