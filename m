Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525EE3F9F44
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997486; cv=none; b=EVGh+n5+3c1iRZBkdup/61741AUseAxMz37018FSveE0rsVtXvXKz1NeV/g4zDg2sUDygdgqT0GMWK2d6I2dOc6AdaA0SJp93FiI7xCKY8XIFtDxZzBE7lXdb6Vb7SFdaC/uvghttjIFcoWX1hnHjXXr+3eoNFk27EdHTmTZHbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997486; c=relaxed/simple;
	bh=z5lzI2rCXW9UbXvUQ0qvO2O+FApH5UI+tIDJmCjrpNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uU8+QiclJ6A2uMfSgWWzD/wsUL1v9qmYjZQFpsUbtDBLG7ti9SYd36oT3pwseHltN/frg9zFE5X+G2C0ZkDentx/sSj07S4Q4av4nCYQzwjwic31NQKo/MkZjZ0klCX8IyRqNctDVEIGsykrR3Ul3RWmpmzbH8Hkd0kMVZ1FMNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGPk2GbE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGPk2GbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF3E1F0089A;
	Mon, 21 Sep 2026 13:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789997482;
	bh=TdcUonrTTdL15C+kFc1nt6IyqqKU2WpcKXW5fw1ILXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cGPk2GbE7dp2TXVlMSXkQin94zWEZujSgFbEWN2CHOuI9uGJi5u4PWmOOowsIMV5j
	 Njek6KmpvnH04gMK1Kk6cC5Ams8famH3Xpjz17oNo8RYuDeAtvbxQTTYuCIAKSTbCj
	 3+NS9BqMT9QgtHoPMR+D7QcUYQhV3K04uWB/Q5JK5IrNRI7zjOzzuJHgz4EgrBi7mn
	 +dh8e9fKK3n+7SDISgKiynmbUz6vvL9eOvwt2a9UkRaztEmRAGOd9EZ9pW6RJSLBKp
	 6xMzuNy6mBmicdKIsEKEOU6ZvwRXkeBRL2apQtnI5CnaXsY9HDvjgzMRWpPjmuz9jq
	 6gM6Prk0FM5mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v1] bpf: cpumap: fix use-after-free of dev_rx on
 netdev unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260920133017.248620-1-jiayuan.chen@linux.dev>
References: <20260920133017.248620-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 13:31:21 +0000
Message-Id: <20260921133122.5EF3E1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: cpumap: UAF of netdev due to unlinking dying entry before kth=
read stop
- [High] bpf: cpumap: TOCTOU race in dev unregistering check allows UAF via=
 chained redirects
--

commit 357385e1a9c647836291f6c8f562ac50211ab22f
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf: cpumap: fix use-after-free of dev_rx on netdev unregister

This commit adds a netdev unregister notifier to drain cpumap kthreads to
prevent use-after-free of stale netdev pointers in queued frames. It forces
kthreads to consume existing frames and flush GRO caches before unregistrat=
ion
completes. It also checks for unregistered devices during cpumap redirects =
to
drop stale packets.

> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 5e59ab896f058..bc2186adcd9a4 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
[ ... ]
> @@ -153,6 +171,11 @@ static u32 cpu_map_bpf_prog_run_skb(struct bpf_cpu_m=
ap_entry *rcpu,
>  			skbs[pass++] =3D skb;
>  			break;
>  		case XDP_REDIRECT:
> +			if (cpu_map_dev_unregistering(skb->dev)) {
> +				kfree_skb(skb);
> +				stats->drop++;
> +				break;
> +			}

[Severity: High]
Is there a time-of-check to time-of-use (TOCTOU) race here when chaining
cpumap-to-cpumap redirects?

During a redirect from cpumap A to cpumap B, kthread A might check
cpu_map_dev_unregistering() and see the device is still registered, then get
preempted.

A netdev unregister could then trigger the notifier, which sets drain_left
for all kthreads and starts waiting. Kthread B might wake up, find its queue
empty, report drain_left =3D 0, and wake the notifier.

Then kthread A resumes, enqueues its packet to cpumap B, finishes its batch,
reports drain_left =3D 0, and wakes the notifier.

Since the notifier checks the wait queues one-by-one independently in
cpu_map_netdev_event():

	list_for_each_entry(rcpu, &cpu_map_list, list)
		wait_event(rcpu->drain_wq, !READ_ONCE(rcpu->drain_left));

It could unblock because both queues eventually reported 0, allowing the
netdev to be freed. Kthread B could then wake up to process the newly
enqueued packet, leading to a use-after-free on the netdevice.

>  			err =3D xdp_do_generic_redirect(skb->dev, skb, &xdp,
>  						      rcpu->prog);
[ ... ]
> @@ -528,6 +576,11 @@ static void __cpu_map_entry_free(struct work_struct =
*work)
>  	 */
>  	rcpu =3D container_of(to_rcu_work(work), struct bpf_cpu_map_entry, free=
_work);
> =20
> +	/* Unlink first, so the notifier can't wait on a kthread we stop */
> +	mutex_lock(&cpu_map_mutex);
> +	list_del(&rcpu->list);
> +	mutex_unlock(&cpu_map_mutex);
> +

[Severity: High]
Does unlinking this entry before stopping the kthread open a window for a
use-after-free?

If a netdev unregister happens concurrently with a map update freeing this
entry, cpu_map_netdev_event() will iterate over cpu_map_list.

Since the entry is already removed from the list via list_del(), the notifi=
er
won't wait for this dying kthread to drain.

The netdevice can then be freed, but the kthread could still be processing
its queue while shutting down via kthread_stop(), potentially accessing the
freed netdevice through xdpf->dev_rx or skb->dev.

>  	/* kthread_stop will wake_up_process and wait for it to complete.
>  	 * cpu_map_kthread_run() makes sure the pointer ring is empty
>  	 * before exiting.
>  	 */
>  	kthread_stop(rcpu->kthread);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920133017.2486=
20-1-jiayuan.chen@linux.dev?part=3D1
