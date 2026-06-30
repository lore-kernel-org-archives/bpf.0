Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF5B367293
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829749; cv=none; b=EvKBO5Zas0XFeVGi4g8iV2VJp/9EqXugV6LKFe+7e5/hBOzb+yPao575UjKPxDNDuLSgVWxlOFr5Q4y4OWgRuYmh24Wi+KykOjaRHabAhJ3uvpFrpiqAXmrMwRlBgZ1ShiOwqC4nCwL4uOIrCtVw4w6G69UCYe9MR8LfIwS/Hb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829749; c=relaxed/simple;
	bh=mzGgxZ7ut41Br2p8WLJ1KIBfQ0k5xYlMOxaUhbNUxcg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tV7vC542YSSWxnFRDVLUTXGlRaqWZAXmq0LGXH+V1SR0/1UvJwwuz6fcq6MAY4ndmmB649u3XmQH+jxCXOLZINdU1YWJwLamBzKbA3x54fkgTIzo+eUcvtCy+nx56myN3Qnr7ICpfhOpUkqp7Z7SXbqqWuijYJ59/5WxnAQmg28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf2uu7zS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf2uu7zS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DB21F000E9;
	Tue, 30 Jun 2026 14:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829747;
	bh=m3nTYx1+HJc2GciPuaA+30+hfzens9uETu4agHQEMqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mf2uu7zSyOmd5fG3lF1mGMJVhFq9vcPnbkKV7NnJcjU/tvtRy97ImP+ODc1258trv
	 FzOMZft7rF/dcNKa0vakfHsFPSJNNKvMN9/EyZvMKYStsS3yrWxE8XpKNM9i+P8UmR
	 466ejozbnugC11n+5fpzsoDxeBau8VwdQ1gFeMv7WMd6SYfAkodJCwGo2x11Mteadi
	 J5ckop8108SmE6IJfouYfHR78cVCmALE+NlDdP9oJC7BVCu1fnoZW/y5PF/EKALl+L
	 pdvAjKHr/HPHXfrltl7T8mdMSmHBhYEy23j1pQLXj9csg3aHGZve7aM21FBy8Po7qN
	 YFaZjesevaRzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] bpf: Fix smp_processor_id() call trace for
 preemptible kernels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Edward Adam Davis" <eadavis@qq.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_5E4F8F8DADA5DE0DAD924ADD835DD7991707@qq.com>
References: <20260630132226.C44601F000E9@smtp.kernel.org>
 <tencent_5E4F8F8DADA5DE0DAD924ADD835DD7991707@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 14:29:07 +0000
Message-Id: <20260630142907.A9DB21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unbounded preempt-disabled loop causes severe scheduling latency a=
nd soft lockups.

Pre-existing issues:
- [High] Synchronous freeing of map element fields upon deletion violates R=
CU reader guarantees, causing Use-After-Free.
--

commit 366a895a5502b13454a28525375f08655dba66d2
Author: Edward Adam Davis <eadavis@qq.com>

bpf: Fix smp_processor_id() call trace for preemptible kernels

This commit attempts to fix a preemption warning in bpf_mem_cache_free_rcu()
by wrapping the batch deletion loop in get_cpu() and put_cpu(). This disabl=
es
preemption rather than prohibiting migration.

Link: https://syzkaller.appspot.com/bug?extid=3Dfd7e415d891073b83e1f

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 9f394e1aa2e85..7b98c2eea6859 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -3345,8 +3345,10 @@ static int __rhtab_map_lookup_and_delete_batch(str=
uct bpf_map *map,
>  	}
> =20
>  	if (do_delete) {
> +		get_cpu();
>  		for (i =3D 0; i < total; i++)
>  			rhtab_delete_elem(rhtab, del_elems[i], NULL, 0);

[Severity: High]
Will this unbounded loop with preemption disabled cause soft lockups?

The user-space process provides the count parameter which determines the si=
ze
of the total variable. Wrapping this potentially massive loop inside get_cp=
u()
and put_cpu() completely disables preemption for the entire duration of the
deletion loop.

Can this lead to severe CPU latency spikes and system unresponsiveness,
especially on real-time and preemptible kernels?

[Severity: High]
This is a pre-existing issue, but does calling rhtab_delete_elem() here
violate RCU reader guarantees?

Looking at rhtab_delete_elem() in kernel/bpf/hashtab.c, it synchronously
frees the element's special fields:

kernel/bpf/hashtab.c:rhtab_delete_elem() {
    ...
    /* Release internal structs: kptr, bpf_timer, task_work, wq */
    rhtab_check_and_free_fields(rhtab, elem);
    bpf_mem_cache_free_rcu(&rhtab->ma, elem);
    return 0;
}

Since rhtab_check_and_free_fields() immediately calls bpf_obj_free_fields(),
this destroys fields (like kptr) before the RCU grace period elapses.

Could concurrent RCU readers accessing the element during the grace period
read freed pointers, resulting in a use-after-free?

> +		put_cpu();
>  	}
> =20
>  	rcu_read_unlock();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_5E4F8F8DADA=
5DE0DAD924ADD835DD7991707@qq.com?part=3D1
