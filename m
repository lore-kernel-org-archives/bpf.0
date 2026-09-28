Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565C34E3228;
	Mon, 28 Sep 2026 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606641; cv=none; b=fxN+u8miWf4fi/Ylz0KA93uhqiOCo7lb2u2fWBRrqcTMAkJOEGsvcNoCz7Fd3Ja4L2bGyAAGaw2gyM21UHLeUOnoFgmc+reqsE2mnWe7HqVfdDcocA3MSV7NuRAY7fV2vo4yRHjQ0/03xOqY6/G6xUvBbLU0VKh9w0NBj+I/nnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606641; c=relaxed/simple;
	bh=Ew5SS+PCwkDkXXRwyIWFpFkp09kOoNXBMyfxhJ9ksuM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HaBX52OdK99/682pG+Gv3qKEqymSg22ow2JmtKO0WJtBbePI+HQGYWiRgsUxweCZB99FV5k457YPAyriIbCtwPanBDoDMWpatWawTnHwNav+K9+6iS5PZ68Wyb1mV+YfFZUgO7WUo1xgNZ+NL6yKk9uW+k3X21/VwXb6LdsScCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGOyNNsO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGOyNNsO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE87C1F000FF;
	Mon, 28 Sep 2026 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790606635;
	bh=PqcWaw1TGdIQlBPIj60DjLPZUt2XOV5/I9GxHAPkweU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CGOyNNsOswC0ei61H+2OuYChP0PAPLuXYOsqT9JcEFKmAAPexuSyQly6gYhXbbPBM
	 KGrpGNApYXuyxv9muRwTaFssoS1YVRkfXsU9U2f6XvUxL3o50LfqUAeGT0n7dH/Zjt
	 RNnExXdCIgOnfKPg/1CwdJdYgnGtexW0C/zRvjpsRQN4yL2UwhsdUV1C8YpuaN62nC
	 +46LGU4BORnCOl3LrLQy2ytVG15XVeBGDKmZzzMKLXNeZqYlGEtnaDnqiHH4AhAfdd
	 Ky9zC11+2t9Nkw5AmFg/KKZjHHhXw2uo1YLOqWFE04nwnX3OzAQG1Km+jw+SJvGxPp
	 tzQwMIKIysdbA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/3] rhashtable: Add use_tasks_rude parameter to
 defer bucket table free
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179060578063.372125.17243688315867196392.stgit@devnote2>
References: <179060575297.372125.10581329083761385407.stgit@devnote2>
 <179060578063.372125.17243688315867196392.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 14:43:54 +0000
Message-Id: <20260928144354.DE87C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rhashtable: UAF in standard walkers and inserts due to Tasks Rude =
RCU mismatch
--

commit 72dce4af7330e16ac9fafbde35eaffd5f5d340ca
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

rhashtable: Add use_tasks_rude parameter to defer bucket table free

This commit adds a use_tasks_rude boolean flag to struct rhashtable_params.
When enabled, old bucket tables are freed using call_rcu_tasks_rude()
instead of call_rcu() to support callers that operate under preempt_disable=
()
without holding rcu_read_lock().

> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 6362896e4f099..b183fb112a705 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -359,7 +359,10 @@ static int rhashtable_rehash_table(struct rhashtable=
 *ht)
>  	 * rhashtable_walk_stop() can use rcu_head_after_call_rcu()
>  	 * to check if it should not re-link the table.
>  	 */
> -	call_rcu(&old_tbl->rcu, bucket_table_free_rcu);
> +	if (ht->p.use_tasks_rude)
> +		call_rcu_tasks_rude(&old_tbl->rcu, bucket_table_free_rcu);

[Severity: High]
Does this create a use-after-free for standard readers when
CONFIG_PREEMPT_RCU=3Dy is enabled?

Standard rhashtable operations like __rhashtable_insert_fast() and
rhashtable_walk_start_check() acquire standard RCU read locks:

lib/rhashtable.c:rhashtable_walk_start_check() {
    ...
    rcu_read_lock();
    iter->walker.tbl =3D rht_dereference_rcu(ht->tbl, ht);
    ...
}

include/linux/rhashtable.h:__rhashtable_insert_fast() {
    ...
    rcu_read_lock();
    tbl =3D rht_dereference_rcu(ht->tbl, ht);
    ...
}

Under CONFIG_PREEMPT_RCU, rcu_read_lock() does not disable preemption. If a
task is preempted during an insert or walk, a Tasks Rude RCU grace period
can complete while the preempted task is still accessing the old bucket
table. Since Tasks Rude RCU only waits for preempt-disabled regions and not
standard RCU read-side critical sections, the bucket table could be freed
before the preempted standard reader finishes.

> +	else
> +		call_rcu(&old_tbl->rcu, bucket_table_free_rcu);
>  	spin_unlock(&ht->lock);
> =20
>  	return rht_dereference(new_tbl->future_tbl, ht) ? -EAGAIN : 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179060575297.372125=
.10581329083761385407.stgit@devnote2?part=3D2
