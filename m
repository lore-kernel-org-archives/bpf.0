Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E442DAFA9
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780081341; cv=none; b=a/lIThuZrLYbkM2u3nZZLlrBQ1+t0ZVX/v69+LWgo9Phu1BnUipHD1bEZXKedNxzjmlFk/VhLCo/mz8PuwXq8m38W9KizJZ6lsl1W34abvUrAJK3Ln/pxCL8fcHgGYJdzX1lI2166y2YlaYgUhmudQz8T4sT/aams824eq9+kNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780081341; c=relaxed/simple;
	bh=qOXvnCnYpkDUlXeAL4A+RRKcCE6l5w9ociQqRBqW0Zk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o8j/NOfrLo6Fgtg90YFJqmBvboyjzzwWlW19I/T/aIsLR+dCzNw+/AJXujmJiGWtr1W9G23KqXs7bd+HB3aO60VGcH9dGKWsklyziCtIt1qru6pEY/Id2StIqdhbYodfkeypVDtk5Xue6E/SOa35DlfxbwGe4eP4WxW3tpnXU9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw1eO6W9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw1eO6W9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2090C1F00893;
	Fri, 29 May 2026 19:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780081340;
	bh=CYH2hAWbay0WhRuP5pvB4CrRbNB+ZnkGN8CdsPT3jHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dw1eO6W9YKMdABoSZvG6D8m9+o0tnyMd07odrLTFh/4xsPVFj4NQMgpWRHUOo4w0X
	 0x6bVLF5z51XB2OL+7R7Udyuo8P7OVzw8hMEewSlQFW5DakNjIrRD51vr9+YlZ7JRd
	 mYFpUAcQ7pIi6y4LLsFw5KqT/jAo+n++i73RCD5I5SAYyjyKDmuNB3rQ+kgeJCFmFe
	 qM99Gu3fwJg1ps2HtXiU2eLleshaK1cUgLr7hkuD424UgHsvGWSDqO6dgjTmnIDoLC
	 44J8c00+CauCT1ll9C/dkXfmH9vnjebBbGQflsuZyQMmK2SN4KA1xBmvR5sFoBMzVq
	 bpBTlCyunXNBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, lpm_trie: Allow lookups from sleepable BPF
 programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vlad Poenaru" <vlad.wing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529174233.2954240-1-vlad.wing@gmail.com>
References: <20260529174233.2954240-1-vlad.wing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 19:02:19 +0000
Message-Id: <20260529190220.2090C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the fix is incom=
plete. The patch resolves an RCU lockdep splat in `trie_lookup_elem` for sl=
eepable BPF programs, but leaves identical core kernel locking rule violati=
ons in `trie_update_elem` and `trie_delete_elem`. Sleepable eBPF programs h=
old `rcu_read_lock_trace()`, not the classic `rcu_read_lock()`. The update =
and delete operations acquire the map's spinlock (`trie->lock`) and correct=
ly serialize access, but they use `rcu_dereference()` to traverse the trie =
instead of the update-side API `rcu_dereference_protected()`. `rcu_derefere=
nce()` strictly asserts that `rcu_read_lock_held()` is true. Holding a spin=
lock disables preemption but does not satisfy this check, leading to the ex=
act same 'suspicious rcu_dereference_check() usage' lockdep splat that this=
 patch aimed to fix.
--

commit 1ac6e30b3c7fb4d93d67bfcbb5dc35077814b266
Author: Vlad Poenaru <vlad.wing@gmail.com>

bpf, lpm_trie: Allow lookups from sleepable BPF programs

This commit fixes a lockdep warning caused by sleepable BPF programs
accessing LPM tries. It updates the RCU dereference checks in
trie_lookup_elem() to use bpf_rcu_lock_held() instead of
rcu_read_lock_bh_held().

> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 0f57608b385d4..ac36063cb7e62 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
[ ... ]
> @@ -280,7 +280,7 @@ static void *trie_lookup_elem(struct bpf_map *map, vo=
id *_key)
>  		 */
>  		next_bit =3D extract_bit(key->data, node->prefixlen);
>  		node =3D rcu_dereference_check(node->child[next_bit],
> -					     rcu_read_lock_bh_held());
> +					     bpf_rcu_lock_held());
>  	}
> =20
>  	if (!found)

[Severity: High]
This is a pre-existing issue, but does this patch leave the fix incomplete?

While this patch updates the lookup path to avoid lockdep splats from sleep=
able
BPF programs, sleepable BPF programs can also trigger map updates and delet=
es.
The functions trie_update_elem() and trie_delete_elem() acquire the map's
spinlock (trie->lock) but traverse the tree using rcu_dereference():

kernel/bpf/lpm_trie.c:trie_update_elem() {
...
        while ((node =3D rcu_dereference(*slot))) {
                matchlen =3D longest_prefix_match(trie, node, key);
...
}

kernel/bpf/lpm_trie.c:trie_delete_elem() {
...
        while ((node =3D rcu_dereference(*trim))) {
                matchlen =3D longest_prefix_match(trie, node, key);
...
}

Because rcu_dereference() strictly asserts that rcu_read_lock_held() is tru=
e,
and holding a spinlock does not satisfy the classic RCU read lock check, wo=
n't
calling map updates or deletes from sleepable programs still trigger the ex=
act
same suspicious rcu_dereference_check() usage lockdep splats?

Should these paths be updated to use rcu_dereference_protected() since the
trie->lock is held?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529174233.2954=
240-1-vlad.wing@gmail.com?part=3D1
