Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2F67478
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 00:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792022472; cv=none; b=Y90Jkwxe6sVWQJHDHBP7LjOEFgN0ufhXrfuRnK69mmXSGsyG5GCVkd1gbPSMmm3ajTNwJhXUUAlTlhhhY0NTliSEZUztdjrnAPIoonW0aQ587LGQQYDrH8L/MnUukMn/bMmWN/yRO6EPJF2/4Ji3kpohRX6/6ctg5J3a3l3kMtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792022472; c=relaxed/simple;
	bh=AZl6JsgX6HikkD/tsiO5Aq7SfEfgwTya9/q8nvoz7rg=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=ntEMoBj4lh/FQAjbFHqHqfY9Qd1PEbxBSdSzh6/6iXyPVoW4+S+pBPtFwSAOQRs4rIGZXx26vaEqSUD6iZ48ENR0rbwRW4f6Tsp6ihr7EQNPuUeQ2uUqiMJwfPwDjWWWIpR8KAIgF1Vg/ZGBgMDfNLIKvv6OCGd6TRHf53hQ6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPw5u2gu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPw5u2gu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF1B1F000C4;
	Thu, 15 Oct 2026 00:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792022470;
	bh=8kcTF6wD6e6BgH7VReisCO299wfwSlFkUhZPj0mAQvw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TPw5u2guBt1ykp0bR40uhtyXOS0AKdKLUyhpFIBiUDwNoCTce+LyChbs7IDNXyDZx
	 ibse0T1JvRtSxiCNiV3IQjfatSw8G6T2Xa+lDfNWxyR6qsd97qd0/c6+WWf4MFrrPw
	 PZJLHOumsUPUb1XDr1sAw8tZs23MeJtucE/5hHslMmoGzzAxEmJ3bnU7bN3G7y59ZG
	 oKv7vClhTUS2fVNlO91loJYif7FC8nrAO5gkrH4U6EkBGF7RMavbMTqXSvTWqVQMsa
	 ICOVT+LpzzbxpwJT6u+0qIj4pmO+TUX+6+CdParCxL9LasTMh7WY9ynPmK0QlRFFc7
	 kp5nWShWgc+gw==
Message-ID: <sashiko-outbox-172042@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Associate arena pages with their
 mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261014233442.8392-3-emil@etsalapatis.com>
References: <20261014233442.8392-1-emil@etsalapatis.com>
 <20261014233442.8392-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 00:01:10 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: sleeping lock_page() called under PTL spinlock in existing_pa=
ge_cb()
--

commit 06bc77555d3cf904ccf154edab307819785c3c2b
Author: Emil Tsalapatis <emil@etsalapatis.com>
Subject: bpf: Associate arena pages with their mapping

This commit associates arena backing pages with the arena's private mapping
and sets their page offsets. This allows the fault handler to delegate user
PTE installation to generic MM code, helping avoid races with kfunc-related
arena operations.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index b95ffdb14417a..650baa09fcb5a 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
[ ... ]
> @@ -355,6 +371,14 @@ static struct bpf_map *arena_map_alloc(union bpf_att=
r *attr)
>  	return ERR_PTR(err);
>  }
> =20
> +static void arena_put_page(struct page *page)
> +{
> +	lock_page(page);
> +	page->mapping =3D NULL;
> +	unlock_page(page);
> +	__free_page(page);
> +}
> +
>  static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
>  {
>  	struct bpf_arena *arena =3D data;
> @@ -378,7 +402,7 @@ static int existing_page_cb(pte_t *ptep, unsigned lon=
g addr, void *data)
>  	 * the TLB entries can stick around and continue to permit access to
>  	 * the freed page. So it all relies on 1.
>  	 */
> -	__free_page(page);
> +	arena_put_page(page);

[Severity: High]
Does this code call a sleepable function under a spinlock?

existing_page_cb() is passed as a callback to apply_to_existing_page_range()
during map destruction. The MM core function apply_to_pte_range() acquires
the Page Table Lock (PTL) spinlock via pte_offset_map_lock() before
iterating over PTEs and invoking the callback.

The new arena_put_page() function calls lock_page(), which contains a
might_sleep() check and waits on a bitlock that can sleep.

Sleeping while holding the PTL spinlock will lead to a 'scheduling while
atomic' panic or deadlock.

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014233442.8392=
-1-emil@etsalapatis.com?part=3D2
