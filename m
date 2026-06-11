Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1103F0743
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182694; cv=none; b=N1NW2s1WWt0zts263y+TAltuyZfp0BIhNoqDEUmrdiZq2/7tFSxjjJDf7OsqRli6cQKXzaaX0g0P5lgas8a99ecXWGe1tdJ1SQah7Mhnc6Z+dlaFwbQ6Qt7jyzQrGz4ZfPz18zs/Segmnfx+uxcfZwMx+xZXTgs5fsF4YzkV0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182694; c=relaxed/simple;
	bh=8KP8yfo963ZmKDEHELu6LAZBCQCeqJ7GoRRIBu+Q3kM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KLcURhVFOieaKQeLH07iRilvOdbEm1t0BuecfbjCsoGHslkeH44vvfDYaYHRMRPykVkfY/ROcwqEuxt1XFK7jVAT9TLfSw7toYEU/A44qedSsiAPqrONgLTNxpEpk8H3+ElEH3mCs2saNSh/FQmHbEOCdmKqd4RKPcwKl9fa4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHFHWKNs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHFHWKNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193281F00893;
	Thu, 11 Jun 2026 12:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781182693;
	bh=0WN5UsgxZfwGvFjN2uu1MO+Q73y8YH8r6bQtBRZL4Q4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YHFHWKNsEO7ZysrWIE/Gez7JbiJeQl7fEXAeaJyuHG5lu7lceb4NWVHqobm1qmiZc
	 re1p7FzFmhJQ7PpbSAFm+3bHlhPuNcg8StMY1UXt4KLcHS/Dg4g5CmiDz/67FThS6f
	 GdAuE3oZH211O1imuSMb34aKthNr3vRpdbWWCvKFyZM21kHbujOr0kgRpYLwm9T/X9
	 1fn4hUb3Rp+tEWDzwLkCzsp6nq930ZjVSJJVvfVvmoGUyYTMIfS5LEZEKcjrMX73cO
	 2TsOSgcB8T4lK5KMYyXXDHVNeaT2rRznOZKeChFCuSJmPSQLzZ/tENxgP2+IdyuWZC
	 +aN74Yvplsb3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/7] bpf, sockmap: reject overflowing copy + len
 in bpf_msg_push_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611123538.156005-2-jiayuan.chen@linux.dev>
References: <20260611123538.156005-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 12:58:12 +0000
Message-Id: <20260611125813.193281F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] bpf_msg_push_data and bpf_msg_pull_data lack a definitive `sta=
rt <=3D msg->sg.size` validation. When operating on an empty or shrunk mess=
age, the do-while loop executes at least once and accesses the unused slot =
at `msg->sg.start`. This slot may contain a 'ghost' element from a previous=
 `sk_msg_recvmsg` consumption, retaining a non-zero length and a freed page=
 pointer. The lack of a `msg->sg.size` check allows a crafted `start` offse=
t to bypass the bounds check, leading to a severe use-after-free.
- [High] Appending data to a full scatterlist ring bypasses the fallback pa=
th and corrupts the ring state. When `space =3D=3D 0` and the append offset=
 matches the end of the message, `bpf_msg_push_data` reads `copy =3D msg->s=
g.data[msg->sg.end].length`. If this unused slot is zero, the `if (copy)` f=
allback block is skipped. The function unconditionally increments `msg->sg.=
end`, forcing it to wrap around and equal `msg->sg.start`. This breaks the =
ring buffer state, causing `sk_msg_elem_used()` to return 0, falsely emptyi=
ng the ring and leaking all previously allocated pages.
--

commit 82335dc5248913fa01b7466c6fedd541ff09a2f0
Author: Weiming Shi <bestswngs@gmail.com>

bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()

This commit adds an overflow check to prevent copy + len from wrapping
around when allocating a page in bpf_msg_push_data. This fixes an issue
where an undersized allocation could lead to an out-of-bounds memcpy.

Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714f..3c8f1cedb217f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2829,6 +2829,9 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
>  	if (!space || (space =3D=3D 1 && start !=3D offset))
>  		copy =3D msg->sg.data[i].length;
> =20
> +	if (unlikely(copy + len < copy))
> +		return -EINVAL;
> +
>  	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
>  			   get_order(copy + len));
>  	if (unlikely(!page))

[Severity: Critical]
This is a pre-existing issue, but does bpf_msg_push_data lack a definitive
start <=3D msg->sg.size validation?

When operating on an empty or shrunk message, the do-while loop executes
at least once and accesses the unused slot at msg->sg.start:

    do {
        offset +=3D l;
        l =3D sk_msg_elem(msg, i)->length;

        if (start < offset + l)
            break;
        sk_msg_iter_var_next(i);
    } while (i !=3D msg->sg.end);

    if (start > offset + l)
        return -EINVAL;

If sk_msg_recvmsg advances msg->sg.start and frees the page without
zeroing the element length or pointer, could this helper read a stale
ghost element?

Without a msg->sg.size validation, could the helper incorrectly accept the
bounds as valid, leading to memcpy operations on a freed page pointer?

[Severity: High]
This is a pre-existing issue, but does appending data to a full
scatterlist ring bypass the fallback path and corrupt the ring state?

When space is 0 and the append offset matches the end of the message,
bpf_msg_push_data reads copy =3D msg->sg.data[msg->sg.end].length:

    if (!space || (space =3D=3D 1 && start !=3D offset))
        copy =3D msg->sg.data[i].length;

If this unused slot is zero, the if (copy) fallback block is skipped:

    if (copy) {
        ...
        goto place_new;
    }

    ...

    /* Slot(s) to place newly allocated data */
    sk_msg_iter_next(msg, end);

Does this unconditionally increment msg->sg.end, forcing it to wrap around
and equal msg->sg.start?

If so, could this break the ring buffer state, causing sk_msg_elem_used to
return 0, falsely emptying the ring and leaking all previously allocated
pages?

[Severity: Critical]
This is a pre-existing issue, but does a similar logic apply to
bpf_msg_pull_data?

    do {
        offset +=3D len;
        len =3D sk_msg_elem(msg, i)->length;
        if (start < offset + len)
            break;
        sk_msg_iter_var_next(i);
    } while (i !=3D msg->sg.end);

    if (unlikely(start >=3D offset + len))
        return -EINVAL;

Could this fail to validate against the actual message size and proceed
to process freed scatterlist elements?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611123538.1560=
05-1-jiayuan.chen@linux.dev?part=3D1
