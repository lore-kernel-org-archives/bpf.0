Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794454927;
	b=unFObtN8ew/6G6iOaj2yT5SRreX/EBzXGsNcW2TltXnNwyhiY8O3o+3qhBHVTblB4tDI
	 f5tfU256LBSAWKhjSazdrrDOko4lZ8yJa6MobRBdRwg1afHGmybyTkN/7aoLL5g2sWM8d
	 dUj7NPLdb317vry88Q5CrdISglR2F7JAPbGSXoAkleVNCV1MjGa8BxRAw3fp1bJuK/rRB
	 h1xmPCitBKfOxPPdrx5jQjnR4kh00I3iPGyN6wrnWWnMkYEP7XZS8JRGwMYxG4/PCfSvT
	 qeJbdbEX8IEv20obQ13FtVDDlFts/mVZPPTd9dqYhRYn9fqwTp0WUUrEmO1dSzBS6DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794454927;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rUMW1hjg12wsTj6cEqSidxLUQKi4jsNQmSF0Fn/XmRA=;
	b=bw0hshY1QmWGPSbjodrWEgGn5uSd/v+a/qgvkVxtn9jYIFQwCxdgHDY8ZUug8CDsgxu1
	 257OcOZKnfAJZS+rqrVfQvmzLHrVAZmtCOraxAr5jwdm5dJii5SgyFeA/DfEhvBPvartP
	 q9lzf21lmBkPvCtv5gKzME8MMC/TFE19RP4Bn/FWdYsE9mHzcEvLvQ7EcagrU9yjRa4QP
	 DGgJFyct3DPQmcx8PbDxDXFZ5VtVmTvo9bMV4RNOSODcM9S59N2vyRq0ziAQ095jcOpCK
	 Jmp68empwEdsebRYkT+CeLoEjYsBpy/xaeGk+TJXWxx8IkZCym4Tsukkr1VIbgYfyzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcpAEah2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152E606A31C
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 03:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcpAEah2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B261F00A05;
	Thu, 12 Nov 2026 03:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794454926;
	bh=rUMW1hjg12wsTj6cEqSidxLUQKi4jsNQmSF0Fn/XmRA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mcpAEah2AxA11pv61iCE49n1swA1Jby4E9XrNU6AyQEtZv3/ujyGFL7SsXjxkBuD3
	 x4LEYx+zgVPh12Bo8Y2uXqOs3Mw11gTXd2iiz1lHrTaeMH/AFMKUcGfqkVM5MIUIgK
	 xqajVdTkWFkC6GzXCorgn1YRdQQqlBUj7E5W8u7E7pWeoOZZRtfeb0qdIgZSSUZR/X
	 78VGv7KYA1mHZt+c11PfZ1LeF2GNnJIkjrOj9gvEnH/nefx/dInns0IdDtANzFIGKQ
	 wYpp5mSWOlgSMGqpMz1XKWf0ZulWxL9LDitOpg/SbAJ/V/HjPpK7ZVtHGfTsub3lzg
	 71eorSk80j73g==
Message-ID: <sashiko-outbox-210291@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf, sockmap: Fix ring capacity invariant break in
 bpf_msg_push_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "bo cao" <treebacker@foxmail.com>, bpf@vger.kernel.org
In-Reply-To: <tencent_84A432FD1AE7054D384BEB36958789AAFA05@qq.com>
References: <tencent_84A432FD1AE7054D384BEB36958789AAFA05@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 03:42:06 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Low] bpf: non-standard multi-line comment style in
  bpf_msg_push_data()
- [Low] bpf, sockmap: inaccurate -ENOSPC claim and dead check in
  bpf_msg_push_data()
- [Low] bpf, sockmap: inaccurate Fixes trailer in bpf_msg_push_data()
  fix
- [Low] bpf: unreachable sg.end check in bpf_msg_push_data() copy path
--

commit a346141a5e25b55660858c935ff1dea8fc5392a6
Author: Bo Cao <treebacker@foxmail.com>

> bpf, sockmap: Fix ring capacity invariant break in bpf_msg_push_data()
>
> A push at msg->size ends the element walk on the ring's free slot, so
> the "no space, absorb by copy" fallback reads the free slot's length
> instead of the last live element's. Nothing is absorbed and the split
> path runs anyway: with the ring already holding MAX_MSG_FRAGS live
> elements it advances sg.end onto sg.start, all NR_MSG_FRAG_IDS slots
> become live, and the occupancy (the distance from sg.start to
> sg.end) reads 0 -- "empty". Every capacity check in push/pop is then
> bypassed and later transforms corrupt the element list.
>
> Without the fix, a single send() with an SK_MSG verdict program on a
> full ring deterministically crashes the SK_DROP teardown (arm64,
> 7.4.0-rc2 + the bpf master sockmap series):
>
>   Unable to handle kernel NULL pointer dereference at virtual address 000=
0000000000008
>   ESR =3D 0x0000000096000004  FSC =3D 0x04: level 0 translation fault
>   Internal error: Oops: 0000000096000004 [#1]  SMP
>   CPU: 2 UID: 0 PID: 546 Comm: skmsg_panic Tainted: G        W           =
7.4.0-rc2 #1 PREEMPT(full)
>   pc : sk_msg_free_elem+0x90/0x148
>   lr : __sk_msg_free+0x8c/0x10c
>   x14: 4141414141414141
>   Call trace:
>    sk_msg_free_elem+0x90/0x148
>    __sk_msg_free+0x8c/0x10c
>    sk_msg_free+0x18/0x24
>    tcp_bpf_sendmsg+0x298/0xa54
>    inet_sendmsg+0x44/0x70
>    __sys_sendto+0x120/0x198
>
> put_page() on a zeroed scatterlist entry. With the fix the helper
> returns -ENOSPC, the message frees normally, and the crash is gone.
>
> Never read the free slot in the fallback: absorb into the last live
> element when the walk ended on it and the ring is full, or fail with
> -ENOSPC if there is nothing to absorb, so the guard slot is never
> consumed.
>
> The bug was found with LLM-assisted source auditing and verified end
> to end: it is reachable with CAP_BPF/CAP_NET_ADMIN and confirmed
> exploitable for local privilege escalation (details reported to the
> maintainers separately). Regression tested with
> tools/testing/selftests/bpf/test_sockmap.
>
> Tested on top of v7.4-rc2 plus the sockmap fix series currently in
> bpf/bpf.git master (b889ea1f6dbe..0048086bd361); neither that series
> nor the June sk_msg fixes (f3f34ca45b96 and friends) touch the ring
> capacity invariant, and the patch applies to mainline and bpf master
> alike.
>
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Signed-off-by: Bo Cao <treebacker@foxmail.com>

[Severity: Low]
Prior to commit 15ab0548e310 ("bpf, sockmap: Several fixes to
bpf_msg_push_data"), bpf_msg_push_data() checked start >=3D offset + l after
the scatterlist walk and returned -EINVAL whenever the loop ended at
i =3D=3D msg->sg.end on a non-empty ring.  Commit 15ab0548e310 ("bpf, sockm=
ap:
Several fixes to bpf_msg_push_data") relaxed that check to allow pushing at
the end of a message and added the sk_msg_iter_var_prev(i) adjustment inside
if (copy), overlooking that copy =3D msg->sg.data[i].length was read earlie=
r.
Should the Fixes: tag point to that commit instead?

  Fixes: 15ab0548e310 ("bpf, sockmap: Several fixes to bpf_msg_push_data")

> diff --git a/net/core/filter.c b/net/core/filter.c
> index d68b521504050..9ecb94a56d548 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2892,8 +2892,29 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg=
, u32, start,
>  	 * offset case because its the common case for inserting a
>  	 * header.
>  	 */
> -	if (!space || (space =3D=3D 1 && start !=3D offset))
> -		copy =3D msg->sg.data[i].length;
> +	if (!space || (space =3D=3D 1 && start !=3D offset)) {
> +		/* A push at msg->size leaves the walk on the ring's free
> +		 * slot, which is not a live element: its length reads 0
> +		 * (or stale data left by an earlier ring rotation), so
> +		 * the copy fallback would absorb nothing and the split
> +		 * path below would run. With the ring already full
> +		 * (space =3D=3D 0) that path advances sg.end onto sg.start,
> +		 * leaving all NR_MSG_FRAG_IDS slots live -- the ring can
> +		 * no longer tell "full" from "empty" and later
> +		 * transforms corrupt state. Absorb into the last live
> +		 * element instead, or fail if there is nothing to absorb.
> +		 */

[Severity: Low]
This isn't a bug, but BPF coding style places the opening /* of a multi-line
comment on its own line with the comment text starting on the next line.

> +		if (i =3D=3D msg->sg.end) {
> +			if (!space) {
> +				sk_msg_iter_var_prev(i);
> +				copy =3D msg->sg.data[i].length;
> +				if (!copy)
> +					return -ENOSPC;
> +			}
> +		} else {
> +			copy =3D msg->sg.data[i].length;
> +		}
> +	}
> =20
>  	if (unlikely(copy + len < copy))
>  		return -EINVAL;

[Severity: Low]
Can copy ever be zero here when !space holds, or is the commit message
inaccurate in stating that the helper returns -ENOSPC on a full ring?

Every live scatterlist element in [msg->sg.start, msg->sg.end) has a
non-zero length.  When !space holds, the ring has MAX_MSG_FRAGS live
elements, so stepping i back from msg->sg.end selects the last live element
with msg->sg.data[i].length > 0; bpf_msg_push_data() then absorbs the push
into a newly allocated page and returns 0 (or -ENOMEM) rather than -ENOSPC.

[Severity: Low]
Does stepping i back from msg->sg.end here make the second msg->sg.end check
inside if (copy) unreachable dead code?

net/core/filter.c:bpf_msg_push_data() {
    ...
	if (copy) {
		int front, back;

		raw =3D page_address(page);

		if (i =3D=3D msg->sg.end)
			sk_msg_iter_var_prev(i);
    ...
}

copy is initialized to 0 and is only set to a non-zero value when
i !=3D msg->sg.end or after the !space branch above has already decremented=
 i
away from msg->sg.end, so i can never equal msg->sg.end when entering
if (copy).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_84A432FD1AE=
7054D384BEB36958789AAFA05@qq.com?part=3D1
