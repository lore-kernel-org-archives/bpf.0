Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91E44F799D
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790652008; cv=none; b=Shx2xCwLAxlP9WtwfUHnmyCwwqCq0Bc/j/Yi0eiKazMJ8ZBIAFeT45b8eFH0pzpe4iaru9oJ9OiyJwfHbHB+Pl1wuZvi8HEHzWGEWSlGAhayv5W8cpc5di3bEmsFCeiibikOGSKNQmzoKiMxoGlp6iJ8lcou89NSpiX4kghutQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790652008; c=relaxed/simple;
	bh=/A6iZRFjps6bWE87JrI5cUpyjCyhQvmdLBeyc/Afvrs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SbP2Qe98q1VX8tma9RnweBKuqMZwZX4dtLXVGLJZRf8hECnP3rnmN6+mvht6JZEdtaRntOnG+jq0YWOlo6BYsp2OMuH15fFPEKUT40vh9Z8YnuYbSSCNyOVDWPe/Oq5jYWkhnu8u3rJp+t5gCOZD9Gs2KjUTWFV1McggLGhrEr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX/5tHQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX/5tHQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0548A1F000FF;
	Tue, 29 Sep 2026 03:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790652002;
	bh=QA3M7/Vd+Btw45l/GNWyNorVF18RyMb1ILqJWArZIik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XX/5tHQZdS8pejIk+GKX7GVmQEoXXr4Sq4b3hI83wYhqc7bmMHwb8pmDX4bwrjum1
	 aixiCf+7CjJq7HkhCI322faEClDbzas5z57ZEmMpEJY6NW2KSTwM74IWMCUlcp1fRD
	 pNe/QdKamRr0tOoPy6Swq2KKjSdF7aaaWgk33bloxHfemOTNWp5cyOmPImdxwy0/br
	 2CI7TZZMj8u+oKikgvwitsoyLPhiGdZOyxju6T1Z3A2p66VRJu1B/F44abjR13MjME
	 hixf5a9SsQNr6W8jrJxGMCmDnqtk6G+/Tzci5q1/HmXv3jMoNxOpEvKqQFhJK0RARQ
	 6Fpx/KX0NwtGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] bpf: Defer work in bpf_timer_cancel_and_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Dinaburg" <artem@trailofbits.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260929030524.86560-1-artem@trailofbits.com>
References: <20260929030524.86560-1-artem@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 03:20:01 +0000
Message-Id: <20260929032002.0548A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: UAF in bpf_timer_cb due to deferred map element cancellation
--

commit 7fae89f817868d5f5aa9bd764292b2373d1f4677
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Defer work in bpf_timer_cancel_and_free

This commit addresses a deadlock and use-after-free scenario in
bpf_timer_cancel_and_free() by deferring the cancellation of hrtimers to a
workqueue when running within a timer callback.

Link: https://lore.kernel.org/r/20240709185440.1104957-3-memxor@gmail.com

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
[ ... ]
> @@ -1484,14 +1504,8 @@ void bpf_timer_cancel_and_free(void *val)
[ ... ]
>  	 *  CPU 1 (timer1_cb)			CPU 2 (timer2_cb)
>  	 *  bpf_timer_cancel_and_free(timer2)	bpf_timer_cancel_and_free(timer1)
>  	 *
>  	 * To avoid these issues, punt to workqueue context when we are in a
>  	 * timer callback.
>  	 */
> -	if (this_cpu_read(hrtimer_running) !=3D t)
> -		hrtimer_cancel(&t->timer);
> -	kfree_rcu(t, cb.rcu);
> +	if (this_cpu_read(hrtimer_running))
> +		queue_work(system_unbound_wq, &t->cb.delete_work);

[Severity: High]
Does punting the cancellation to a workqueue and returning immediately break
the synchronous cancellation guarantee?

If a BPF program running in a timer callback deletes an element containing a
second timer from a preallocated hash map (or updates an array map),
bpf_timer_cancel_and_free() defers hrtimer_cancel() to the workqueue and
returns immediately.

This allows the caller to immediately recycle the map element (pushing it
to a freelist for preallocated maps, or overwriting it in array maps)
without waiting for the timer callback to finish. If the second timer's
callback is currently executing on another CPU, it will continue to read
and write the map element data, which now belongs to a different key or
has been overwritten.

Can this lead to a use-after-free and data corruption in BPF map elements?

> +	else
> +		bpf_timer_delete_work(&t->cb.delete_work);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929030524.8656=
0-1-artem@trailofbits.com?part=3D1
