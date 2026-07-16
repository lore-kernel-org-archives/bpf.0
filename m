Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69446239E60
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784168188; cv=none; b=VGCkIO9Soh12//dAxaLacZSVD1D6ands0DWUpTJJj+XVy2BGKBJy4t7zj8m/LMV3vIvkseecjsSnSeYEVP4CQWsKTFNi5WvVD9ySotM+KBn9wVdN8flOQmk36TqqYQb3gYH0B6GoVCJ1ipJFBRi4n6DlvjKkFNdm0K0Ks0xy5y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784168188; c=relaxed/simple;
	bh=pcxYTaferYxiwg0HguVkRbXnF3bDSW6BQAxD93jkh+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SBNPyReUjHigIug1XffWOD8CTLeyA9Dph4ldl14sQqhfhoJ2sr/V+hEOeZj3ypKJHh/qTQ4uoRcTNczJ0sV45n3KQk5Z5HghfmOam4vcnn1bJ4GvUYe4UsZS5pJ4/frTVE8jdxlG8yjjKRhJcRgthYthaRtVxCWwWYaVIEZkN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giU7XgW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giU7XgW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CD31F000E9;
	Thu, 16 Jul 2026 02:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784168187;
	bh=cm7xZqqfhAMczOnV5IlsHuL3Wu1MtQPANNMyefTYeRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=giU7XgW71djF6/229iDygh86H8Kn8J6yicFy6OZxQDRzej4Y1RMSXmkVNYeFIONVr
	 Pl+POLi80GG2yfRwz4fJ0lVOtmsyIuWx8402/R/7KPt6F0jtwRGL8djX0Fozo772RB
	 Wc4okcNRL+SVtf5ddR3VpfL4WmjdMT/trUsnS1fnQx7FdTDykaZWwvwlK5h31Hzlzk
	 9h2FCDfwDrLd/d+5lh5urM6IyzpPPlhAP/BMXKH0SNKTGKTruvnCV36DXv/+4de6QH
	 CaLuDNsl2kRb7fvQen+iqcISOXwZ0jYTvoszokqfGw3ODnT6T2xucZJOCjG5gWqblG
	 QuMVviOGgsoDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH + QUESTION] bpf: use cond_resched_tasks_rcu_qs in
 bpf_fd_array_map_clear() loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rik van Riel" <riel@surriel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715215314.44423f47@fangorn>
References: <20260715215314.44423f47@fangorn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 02:16:26 +0000
Message-Id: <20260716021627.22CD31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The commit message incorrectly claims that `bpf_fd_array_map_cle=
ar()` executes 'under RCU read lock'.

Pre-existing issues:
- [High] perf_event_fd_array_release() iterates over the entire map under a=
 single rcu_read_lock() region, causing Classic RCU stalls for large maps.
- [High] The patch only fixes the RCU-tasks stall in bpf_fd_array_map_clear=
(), leaving identical vulnerabilities in other BPF map teardown functions.
- [High] A Time-Of-Check to Time-Of-Use race in perf_event_fd_array_release=
 can maliciously delete concurrently updated perf events.
--

--- Patch [1]: [PATCH + QUESTION] bpf: use cond_resched_tasks_rcu_qs in bpf=
_fd_array_map_clear() loop ---
commit c19063bda5ebcdaccc0217e960d2910817786a73
Author: Rik van Riel <riel@surriel.com>

bpf: use cond_resched_tasks_rcu_qs in bpf_fd_array_map_clear() loop

syzkaller creates a PROG_ARRAY with huge max_entries and triggers perf
tracepoint open close in parallel. The hung task detector reports
"INFO: task hung in perf_tp_event_init" with event_mutex held waiting
for synchronize_rcu_tasks().

> bpf_fd_array_map_clear walks max_entries under RCU read lock on a
> workqueue kworker. Commit 4406942e65ca added cond_resched for classic
> RCU, but under PREEMPT it is a no-op and a preempted kworker never
> reports RCU-tasks QS. The loop then blocks the grace period while
> event_mutex is held in ftrace_shutdown, stalling perf_event_open().

[Severity: Medium]
This isn't a bug introduced by this patch, but the commit message incorrect=
ly
claims that bpf_fd_array_map_clear() executes 'under RCU read lock'.

bpf_fd_array_map_clear() is executed via map destruction callbacks (e.g.,
prog_array_map_clear_deferred) on a sleepable workqueue context without hol=
ding
rcu_read_lock(). If a classic RCU read lock were actually held, calling
cond_resched_tasks_rcu_qs() (which invokes cond_resched()) would be an ille=
gal
sleeping operation and trigger might_sleep() lockdep splats.

Could the commit message be updated to reflect the actual context?

[ ... ]

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 248b4818178cd..55fd97375130b 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -1015,7 +1015,8 @@ static void bpf_fd_array_map_clear(struct bpf_map *=
map, bool need_defer)
> =20
>  	for (i =3D 0; i < array->map.max_entries; i++) {
>  		__fd_array_map_delete_elem(map, &i, need_defer);
> -		cond_resched();
> +		/* cond_resched() is a noop with preempt; unblock RCU */
> +		cond_resched_tasks_rcu_qs();
>  	}
>  }

[Severity: High]
This isn't a bug introduced by this patch, but the fix only addresses the
RCU-tasks stall in bpf_fd_array_map_clear(), leaving similar issues in other
BPF map teardown functions.

For instance, fd_htab_map_free() in kernel/bpf/hashtab.c loops over all
buckets without any yield point:

	for (i =3D 0; i < htab->n_buckets; i++) {
		head =3D select_bucket(htab, i);
		...
	}

Also, bpf_array_free_percpu() in kernel/bpf/arraymap.c loops over max_entri=
es
using only cond_resched():

	for (i =3D 0; i < array->map.max_entries; i++) {
		free_percpu(array->pptrs[i]);
		cond_resched();
	}

Since cond_resched() is a noop under CONFIG_PREEMPT, wouldn't these loops
similarly stall RCU Tasks when freeing huge hash or per-cpu array maps?

[Severity: High]
This is another pre-existing issue, but while we are looking at
arraymap teardown, perf_event_fd_array_release() also has a potential issue.

It iterates over the entire map under a single rcu_read_lock() region:

	rcu_read_lock();
	for (i =3D 0; i < array->map.max_entries; i++) {
		ee =3D READ_ONCE(array->ptrs[i]);
		if (ee && ee->map_file =3D=3D map_file)
			__fd_array_map_delete_elem(map, &i, true);
	}
	rcu_read_unlock();

Does this cause Classic RCU stalls for large maps, since it prevents grace
periods from completing without any yield points?

[Severity: High]
Additionally, there seems to be a pre-existing Time-Of-Check to Time-Of-Use
race in perf_event_fd_array_release() calling __fd_array_map_delete_elem().

If Thread A closes a map file, it triggers perf_event_fd_array_release(), w=
hich
verifies ee->map_file =3D=3D map_file.

If Thread B concurrently calls bpf_map_update_elem to replace the element,
Thread A then calls __fd_array_map_delete_elem(), which unconditionally
executes:

	old_ptr =3D xchg(array->ptrs + index, NULL);

Does this mean Thread A could unconditionally nullify Thread B's newly inse=
rted
element, incorrectly deleting it from the map?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715215314.4442=
3f47@fangorn?part=3D1
