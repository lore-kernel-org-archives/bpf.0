Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF531368D42;
	Fri,  4 Sep 2026 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485632; cv=none; b=R/oI7x1kfp5j3e9dFu2VMys0sLIZynGYl6+Fs1oGdxAnfZ8pIzLbJLhEbU9utre5DmG/OTbPViQ9Fe7Bb1vRQU5L7pO+9iuLR4+442un9UvGaCdtvgStQUcJIfat4dWmgaDBMyoyLjxifVcE4AH+3U92nMQ8jfRLUZB5KdYMpno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485632; c=relaxed/simple;
	bh=P/MrAVGM6Bp/rOzN3pa59j8NBWOPizXJZLkyhC5vnh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pw/Csm+y60Rxv8K0bk+K59x6r4+CiUpsDFxq9eUeNP7StP7ZRMu3YFdGvGW7f5E91cY9OQ2Ui66Y46E2jzvgCcsJbBPy1L5r20JqRpZOcdzLXGV3c/H6+1Yn5kKexmWiSCkxtGYW4uBVbz/p2/hZR2cqt/dueJlNe7NNKF3UV4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqd2GtwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqd2GtwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5141B1F000E9;
	Fri,  4 Sep 2026 01:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788485630;
	bh=768etRWAKyJbvvOPCzBMrVJRNK2LxPl0STlGR/Mq4ns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jqd2GtwGAga9pNvG6kpFf+UOIzedvQoqeb2g2AWa9lu4DvzIgp7sZqQVaw8FPAPvS
	 JUSneg2MesaLQ5/gq4A+r4GABY3ELp0Lh7Yn7WU28foxhxGCHo5KqQE28cP15yhXX/
	 6LvhRBeK4oZtpYV/621uvok6J0t9QAUtiYKDieIkRl0lIOfg5gjLQf27CST/ZvMckO
	 AHiBwgjrNf/FOcOmcRmq7WscXAeFVyc2L+fKVj+g3XYQC4FuG2jYS6tEOfkNtpc8ph
	 eUUXXYJp6OvxgyZpFWxH/rQ1v6GWd63PgcVgBCErnwpqYtuFtsTDs3z07HtnSrFu8q
	 rHg+bzby3o2eA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/8] ftrace: Let ftrace_call_adjust() reject a patch
 site
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Sm9zZSBGZXJuYW5kZXogKEFudGhyb3BpYyk=?= <jose.fernandez@linux.dev>
Cc: ojeda@kernel.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260904-b4-arm64-callops-kcfi-v1-1-ce6687739b0c@linux.dev>
References: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev>
 <20260904-b4-arm64-callops-kcfi-v1-1-ce6687739b0c@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 01:33:49 +0000
Message-Id: <20260904013350.5141B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Permanent memory leak of ftrace page group when all tracepoints =
in a module are rejected.

Pre-existing issues:
- [High] Lockless readers can observe uninitialized ftrace pages due to a m=
issing write memory barrier.
--

commit 47d688aa11de52022b8f09bf86665d475e816eb6
Author: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
Subject: ftrace: Let ftrace_call_adjust() reject a patch site

This commit addresses an issue where ftrace_process_locs() does not skip a
patch site when ftrace_call_adjust() returns 0. It tests the adjusted addre=
ss
and skips the site if it is NULL, preventing a bug_on() during ftrace_init_=
nop
on arm64.

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f9d80c7bd9f16..394f82230e0c3 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7676,6 +7676,10 @@ static int ftrace_process_locs(struct module *mod,
>  		}
> =20
>  		addr =3D ftrace_call_adjust(addr);
> +		if (!addr) {
> +			skipped++;
> +			continue;
> +		}

[Severity: Medium]
If all tracepoints in a module are rejected and skipped here, the allocated
start_pg retains an index of 0. When the module is later unloaded, does this
leave the empty page permanently in the global ftrace_pages list?

During module unload, ftrace_release_mod() checks if the first record's ip
is within the module:

kernel/trace/ftrace.c:ftrace_release_mod() {
    ...
	for (pg =3D ftrace_pages_start; pg; pg =3D pg->next) {
		rec =3D &pg->records[0];
		if (within_module(rec->ip, mod)) {
			/*
			 * pg->index could be zero if we only allocated
			 * a page but did not store any records
			 */
            ...
}

Since the record ip is 0, within_module(0, mod) fails, and the page group
would not be freed. Can this regression cause a memory leak of the ftrace
page group for each incompatible module load?

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this functio=
n,
I noticed that the new ftrace page is published to the lockless list without
a write memory barrier earlier in ftrace_process_locs():

kernel/trace/ftrace.c:ftrace_process_locs() {
    ...
		if (WARN_ON(ftrace_pages->next)) {
			/* Hmm, we have free pages? */
			while (ftrace_pages->next)
				ftrace_pages =3D ftrace_pages->next;
		}

		ftrace_pages->next =3D start_pg;
    ...
}

Because the cpu can reorder the kzalloc initialization of start_pg after its
publication to the ftrace_pages list, lockless readers like
ftrace_location_range() iterating the list under rcu_read_lock() might read
uninitialized data:

kernel/trace/ftrace.c:lookup_rec() {
    ...
	for (pg =3D ftrace_pages_start; pg; pg =3D pg->next) {
		if (pg->index =3D=3D 0 ||
		    rec->ip < pg->records[0].ip ||
		    rec->ip > pg->records[pg->index - 1].ip)
			continue;
    ...
}

Could this lead to a panic or memory corruption due to an out-of-bounds
access or a garbage pointer dereference in bsearch() if the reader observes=
 an
uninitialized pg->index?

> =20
>  		end_offset =3D (pg->index+1) * sizeof(pg->records[0]);
>  		if (end_offset > PAGE_SIZE << pg->order) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-b4-arm64-c=
allops-kcfi-v1-0-ce6687739b0c@linux.dev?part=3D1
