Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B05346766
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749747; cv=none; b=rnXn1F6QxTaix6NQ5PA5uapFPUD+t6yPajH3HjBCzjGc4vDZIsIpmq9sB8JebI6DM+FXIHUUutjYm/K7WUHOmnIBLhmlEd2h+SDOG9x7KwarDyI+iyxdP4rSXOVJpv88bQ63867nRJwLmvGthjEmEveJZwdWoKSjmKATO4S5AWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749747; c=relaxed/simple;
	bh=2gi37OUo2teZlYa10uRGEh/8rtTn4sv2+yv7HtXzZxY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ruaKyDHUrkofNULVbW3pCTeQzFvN3Gzp8y1cJATEGk/IEf/56DTejxVZK1XqZ1p6vO8hHQgAlcIhAHD681AihFqhNqOwIDvaoP9sBiF/7J9xy6ghOg7Y3jZFFGXMvOc1lpmYgqOMYstHA94sOLvhatqVa4oP1Bs0ePVzPib/QOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVv6+Ml1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVv6+Ml1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44741F00A3A;
	Mon,  3 Aug 2026 09:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785749745;
	bh=xRfvjFXA5/qsavKiw1nd853nWybpQoTBsHg2rzMudZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GVv6+Ml1BM8R2aYHgVmrisN/gWYDl51OFbYEqlRRAnCNl2CxnqtpnVOS8B2/WHvYc
	 mHrAXEce3W+lhXE7vh6BcTWSbSLPEKxQ6/3aVhjLiwd1ovrfXr8E7J/yx9zgJ4Ozi1
	 tH33SpjioRE3Nmib3NCA9D/4smdWT7RYIBgl65aT4NCajrqsoerV+nh+xWos8c6xeJ
	 qozwywcA0uSOSJiIKzFzeyo0mGef5O58Q7ekdVSS+J6OQfb16S3eJawEON8A1YNBX8
	 won6ubISMycGP+2sjQu1ps5n4Q9M6vg8nLW8COM8z/FIDVZA9h9VQuFIR+UEkvux0I
	 cyGzXafExSyqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/2] bpf: Unconditionally take socket references
 in lookup helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co>
References: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co>
 <20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 09:35:44 +0000
Message-Id: <20260803093544.E44741F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A pre-existing socket reference leak exists when `bpf_sk_assign()`=
 assigns a socket to an skb and `sock_pfree()` acts as the destructor. `bpf=
_sk_assign()` conditionally increments the reference count if `sk_is_refcou=
nted()` returns true, but `sock_pfree()` independently re-evaluates `sk_is_=
refcounted()`. If the socket transitions to `SOCK_RCU_FREE` between these t=
wo calls (e.g., via `connect(AF_UNSPEC)` followed by `listen()`), `sock_pfr=
ee()` returns early without calling `sock_gen_put()`, permanently leaking t=
he reference.
--

--- Patch [2]: [PATCH bpf v2 2/2] bpf: Unconditionally take socket referenc=
es in lookup helpers ---
commit 7463d9a6a26a249e959688cc8e1b8c2847ee47d0
Author: Michal Luczaj <mhal@rbox.co>

bpf: Unconditionally take socket references in lookup helpers

This commit updates BPF socket lookup helpers to unconditionally acquire
and release socket references. It fixes a leak that occurs if a socket
transitions to SOCK_RCU_FREE between the time the reference is
conditionally taken and released.

Closes: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.kernel=
.org/

> TC bpf_sk_assign() has the same issue; it takes a reference only when
> sk_is_refcounted() is true at assign time, but sock_pfree() (the skb
> destructor it installs) re-checks sk_is_refcounted() independently at
> release time. The same connect(AF_UNSPEC)+listen() transition leaks the
> socket here too. I'd welcome suggestions on the right way to handle this.

[Severity: High]
This is a pre-existing issue, but as you noted, a socket reference is
permanently leaked if the socket state changes to unrefcounted between
bpf_sk_assign() and the skb destructor running.

In net/core/filter.c:bpf_sk_assign(), the reference is conditionally acquir=
ed
and the destructor is set:

	if (sk_is_refcounted(sk) &&
	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
		return -ENOENT;

	skb_orphan(skb);
	skb->sk =3D sk;
	skb->destructor =3D sock_pfree;

Then in net/core/sock.c:sock_pfree(), the reference drop is independently
evaluated:

void sock_pfree(struct sk_buff *skb)
{
	struct sock *sk =3D skb->sk;

	if (!sk_is_refcounted(sk))
		return;

	...
	sock_gen_put(sk);
}

If the socket transitions to SOCK_RCU_FREE via a connect(AF_UNSPEC) followed
by a listen() before the skb is freed, sock_pfree() returns early without
calling sock_gen_put().=20

Could this be addressed by either applying the same unconditional reference
counting approach to bpf_sk_assign(), or by introducing a dedicated
destructor for BPF-assigned sockets that unconditionally drops the reference
without re-evaluating sk_is_refcounted()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-sockmap-lo=
okup-tcp-leak-v2-0-306e025bfe66@rbox.co?part=3D2
