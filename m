Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F52B4A2633
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288957; cv=none; b=uxYrLbolRv4C75Efh2oRPnUmHvJdlRvjFjPjmHgiucHae3DMve96SVPVKzWH/8LnSme+Z7rSKOJpWEeqTmHe15Wq8i5CIQk8CwtNrtGpVXDvCXant+qnBeo/T0uwNlkkDtl7Bb1Ia8NxFtALITw9S60Ml7jKubh5KAV7gWVbE0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288957; c=relaxed/simple;
	bh=wuLzA7Gzqw2u7uHSfVEU+M1bW7kCPPj9ZGeTcLhV7M8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YwV4yIjmh9wowGaz8x0kOwKFW0G4tsHQZ+OWQLccXo+hkWV4WFEutgEM729t8+gHQaccQOxhP4WAJn8oMzYZtwu4RjRh5c6etQ9uIIKfYCmG8ppRqATQK41a4xEOBmHdrwVJgKtoJkgayH/ELzjU7RT4WSlIWkxtDsq2Bbl1p+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9n6bSER; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9n6bSER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0DE1F000E9;
	Tue,  1 Sep 2026 18:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788288956;
	bh=6yUOHvLHtMTeO46WzbUpX2wXiK32ONE0i4lg2LTUi4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T9n6bSERT4eooQZe+pGVXiPt7a3gUoo+GOq3r+leqTYHEZfflE4F0k7v5r1gXP3RF
	 fTU3CuvPzvEcJBBu8DWUxPYzofrwzJkzSpAec4lXatQcGQTw572P0C/+08EoClMmdN
	 6QAXQwJaDHoHZNZktR21gZ8XaZf+i7tM+/CTPy5BsQE0OFyScuo0qy0XSgvnabIQGJ
	 +B0kG26a3Up47iV91upaBeWu6nuk2BpHOBinit69nwWJtrfXgNleg6kkylH8J2d/7r
	 SRXqUe6yct1pu4nQMi2OZOsrxyyqYtKV8oj8NnuqnituISP5upFSJGd7yrtqRLVbLm
	 1a00fP7ayuOzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Fix non-linear SRH access in
 bpf_update_srh_state()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2VuIFpoYW5nIChNaWNyb3NvZnQgU2VjdXJpdHkgRk9SR0UgTGFicyk=?= <cenzhang@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260901183151.16648-1-cenzhang@linux.microsoft.com>
References: <20260901183151.16648-1-cenzhang@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 18:55:55 +0000
Message-Id: <20260901185556.3F0DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The per-CPU `srh_state->srh` pointer caching mechanism leads to us=
e-after-free when BPF helpers or internal functions reallocate the SKB head.
--

commit 0d38e8ff1c91b9fb7ce2f48763adb2a41f8f00a2
Author: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft=
.com>
Subject: bpf: Fix non-linear SRH access in bpf_update_srh_state()

The patch fixes a slab-use-after-free issue in bpf_update_srh_state() by us=
ing
seg6_get_srh() to correctly pull and validate the SRH instead of assuming i=
t's
in the linear head. It also refreshes BPF data pointers when pulling header=
s.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e7535523..1dd3a685d1b89 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -7059,15 +7060,18 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *,=
 skb,
[ ... ]
>  		bpf_update_srh_state(skb);
>  		return seg6_lookup_nexthop(skb, NULL, *(int *)param);
>  	case SEG6_LOCAL_ACTION_END_B6:
> -		if (srh_state->srh && !seg6_bpf_has_valid_srh(skb))
> -			return -EBADMSG;
                ^^^^

[Severity: High]
This is a pre-existing issue, but does seg6_bpf_has_valid_srh() dereference
srh_state->srh when a prior generic BPF helper has already reallocated the
SKB head?

If a BPF program calls a generic helper like bpf_skb_store_bytes() on a
cloned SKB before this action, pskb_expand_head() might reallocate the head
and free the original memory. Since bpf_skb_store_bytes() does not clear
srh_state->srh, the check in seg6_bpf_has_valid_srh(skb) would trigger a
use-after-free when accessing the dangling pointer.

>  		err =3D bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6_INLINE,
>  					  param, param_len);

The same caching mechanism leads to pre-existing use-after-free issues in
other SEG6 helpers when dereferencing the cached SRH pointer or when
ipv6_find_hdr() fails.

For example, in bpf_lwt_seg6_store_bytes():

net/core/filter.c:bpf_lwt_seg6_store_bytes()
{
	struct ipv6_sr_hdr *srh =3D srh_state->srh;
...
	srh_tlvs =3D (void *)((char *)srh + ((srh->first_segment + 1) << 4));

[Severity: High]
This isn't a bug introduced by this patch, but does this blindly dereference
srh when it might be a dangling pointer if bpf_skb_pull_data() or another
helper previously reallocated the head?

Later in the same function:

	if (unlikely(bpf_try_make_writable(skb, offset + len)))
		return -EFAULT;
	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)
		return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but if ipv6_find_hdr() fails aft=
er
bpf_try_make_writable() has successfully reallocated the head, does this
function return without clearing srh_state->srh, leaving it dangling for
subsequent helpers?

Similarly, in bpf_lwt_seg6_adjust_srh():

net/core/filter.c:bpf_lwt_seg6_adjust_srh()
{
	struct ipv6_sr_hdr *srh =3D srh_state->srh;
...
	srh_tlvs =3D (void *)((unsigned char *)srh + sizeof(*srh) +
			((srh->first_segment + 1) << 4));

[Severity: High]
This is a pre-existing issue, but is this another instance where the
potentially freed SRH pointer is blindly dereferenced?

And later in the same function:

	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)
		return -EINVAL;

[Severity: High]
This is a pre-existing issue, but could an early return after skb_cow_head()
(which might reallocate the SKB head) leave srh_state->srh pointing to
freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901183151.1664=
8-1-cenzhang@linux.microsoft.com?part=3D1
