Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B04DEC39
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677040; cv=none; b=AFQEtb9fjVomNpKFrvdbPUCeSuEOg3MWP4FvhC5NVu6c7+S6Hy5oXLWtMbegxrukOzRo3pjwqX0YySMt2iQuDBrR/TJLUmp9fZrJ1qTBIr2ZKb4gfzyP+tlF4iA7t6Fb96OSZr2Yy3zaecdP5KVHl6SMeauzEJRXYzP6xEOl1iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677040; c=relaxed/simple;
	bh=AddNi9dHY8aRlIcGhuA9Vldb7B7aQ2k4ek8rpDct83A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SZAeqgZOVDQlAYPxq/AhAD9QN1uw/E0P9VwDfCmwe3Sm52zd4n868tu7+ofWtAH+FfGOhilZE04dk5oVNeowzTsBf2vm+ad/tJkVfk9FBxGr3COpEH33v1AKwqXyr9Qp7fZZ1CoEmP7OHSkElXNWYIRflCa+IC7FpqfdMFXX3ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hi8YyKG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hi8YyKG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584D81F000FF;
	Thu, 17 Sep 2026 20:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789677039;
	bh=5TCYh5Nr9AhnqTwjSBPmk3xjvboMxmQN6l3FTbQ60+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hi8YyKG6jbyjoAC4mGaL9USjoJrGhN0TYpaLBYqonR4G89ZXRGxYSxX7433WZnKcp
	 Z7ILUpUeu/g87PZjY/JgLnG6KNCQi8+kZVgzo7WXUWA9WEI9Cnfux4DntEddtIORvN
	 JJpr5uc3QCNlk5pgTmweKbhQZMq4PuiHla5e7Sq5xUqVYdHEYRIGUiqdrGsEgq+AUO
	 B4bJb//rUXewqjrkmkAMS8Qz7/NAhz9CBgsemChShk+xvKypxxPqSrAOMg6ijGFq2J
	 TOYLzAdn2EU1Ruz1Xyo2379k3lpEDCFh6M0VIVcSQ8V23nzkL4bBbgJxC7zZ6T3TFd
	 LqEvaVmuGaMwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 02/15] bpf: Make struct_ops tasks_rcu grace
 period optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917200542.3689605-3-ameryhung@gmail.com>
References: <20260917200542.3689605-1-ameryhung@gmail.com>
 <20260917200542.3689605-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 20:30:38 +0000
Message-Id: <20260917203039.584D81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: Use-After-Free of struct_ops map due to RCU ordering violat=
ion
--

commit c2c7b791d71f80e6fb709587eda6dfcc6d96d460
Author: Martin KaFai Lau <martin.lau@kernel.org>

bpf: Make struct_ops tasks_rcu grace period optional

bpf_struct_ops_map_free() currently waits for both a regular RCU grace
period and a tasks RCU grace period for every struct_ops map through
synchronize_rcu_mult(call_rcu, call_rcu_tasks).
Add a map_free_pre_rcu() callback so the struct_ops map can remove
ksyms before bpf_map_put() wait for the regular rcu grace period.

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 3935bf35a4237..7802859eac1ea 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -1037,24 +1046,8 @@ static void bpf_struct_ops_map_free(struct bpf_map=
 *map)
> =20
>  	bpf_struct_ops_map_dissoc_progs(st_map);

[Severity: Medium]
Since map->free_after_rcu_gp =3D true is now set in bpf_struct_ops_map_allo=
c(),
this function executes after the regular RCU grace period. This means
prog->aux->st_ops_assoc is only cleared after the grace period ends.

Does this violate the RCU 'remove before reclaim' invariant?

A BPF program executing after the RCU grace period (for example, via
bpf_prog_test_run()) can read the stale pointer in
bpf_prog_get_assoc_struct_ops():

kernel/bpf/bpf_struct_ops.c:bpf_prog_get_assoc_struct_ops() {
    ...
    st_ops_assoc =3D rcu_dereference_check(aux->st_ops_assoc, bpf_rcu_lock_=
held());
    ...
}

Because the pointer hasn't been cleared yet, the program will read the stale
map pointer, leading to a Use-After-Free when this workqueue subsequently
frees the map.

Can this be exploited using bpf_dummy_ops by closing the map to
trigger the RCU grace period and calling bpf_prog_test_run(prog_fd) exactly
after the grace period ends?

> -	bpf_struct_ops_map_del_ksyms(st_map);
> -
> -	/* The struct_ops's function may switch to another struct_ops.
[ ... ]
> @@ -1163,6 +1156,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(uni=
on bpf_attr *attr)
> =20
>  	mutex_init(&st_map->lock);
>  	bpf_map_init_from_attr(map, attr);
> +	map->free_after_rcu_gp =3D true;

[Severity: Medium]
Setting this flag shifts the RCU grace period to occur asynchronously before
the map free workqueue executes, which causes the aforementioned Use-After-=
Free
issue.

Should bpf_struct_ops_map_dissoc_progs() be called in
bpf_struct_ops_map_free_pre_rcu() instead to ensure the RCU pointer is
cleared before the grace period begins?

> =20
>  	return map;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917200542.3689=
605-1-ameryhung@gmail.com?part=3D2
