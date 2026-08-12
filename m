Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC9B3EFD30
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530006; cv=none; b=A/7a/47uMdO6fnSGqZ037hCyGMEWM50HOFnEIOfsp2cPD812XyCcXR37fY9WhNwDOb6V5rffrk24+YEqYPgvd3m+BxCjHypDpnNxEc2dLBYgkNRpI7JFIyU1VSOieKO8GBn8BYqyeTeTLpsCWxbQoAedC7SEasjQ7dGF7pJKxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530006; c=relaxed/simple;
	bh=AZwQur0Zv7Ps6EL8Mo6k2wE2v6eh2e2/X4RO/ka+XBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DDrEOn5F6+sQjtdVJIB8qqAlB9xN/nxhx7IlEFDFORVBwXD9O9pEQzOc6FFCglyIQe6cmUNEvxCc97W/pJL4ciwRNs4SZtDqxfJGf5HGyq/mxDM8gfre4MYO3Q9ORoTqiI/KvxAsXNU+UUdBwW5xGl1XEp4mgyRqzavbEaDqsKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcQowcwb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcQowcwb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6001F000E9;
	Wed, 12 Aug 2026 10:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786530004;
	bh=O3vW5JmrhJqlx5Q6N9NbkFXAgIaQ0e1xeU4J5x8d77Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mcQowcwbib+yzHKldbsOf0PqeR0qoWkc4RbQYGhJuX4a/a19ErgZsERyoJl6IkZwC
	 2Aq1ggkYYSEUIkBiqq3Hy+WjMQkueZy0zNmuUS2/zHl64+875RnoVmNKXM+P7/uRz2
	 PvwxxzTwRcuZipBhSK6oZQB1f6C/bLS5FcrbJJfQiBL8/wnDyXNTaFN9PVi5EBW3Sw
	 vMwJ9OPf7c3mIVH7XkfEgTYwcoXDXSs43B7mR7zXigQYi5iR/2g4jzbE6xFKfOc+kR
	 9er7I+zjF6CG7c4dXkbnOFR2bK4mB6SmgRMKPG+aQaRYN97IOpkVta0goyfUIX9eun
	 8fPSg70bWybtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 6/6] selftests/bpf: tc_tunnel - validate
 decap GSO and encapsulation state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nick Hudson" <nhudson@akamai.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260812083115.73100-7-nhudson@akamai.com>
References: <20260812083115.73100-1-nhudson@akamai.com>
 <20260812083115.73100-7-nhudson@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 10:20:04 +0000
Message-Id: <20260812102004.BF6001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Invalid pointer arithmetic `kskb->head + kskb->end` breaks 32-bi=
t compilation and cross-architecture CO-RE portability.
--

--- Patch [6]: [PATCH bpf-next v7 6/6] selftests/bpf: tc_tunnel - validate =
decap GSO and encapsulation state ---
commit 51cad3ba4cd10bce6b9c9134b5e4188fc76f034c
Author: Nick Hudson <nhudson@akamai.com>
selftests/bpf: tc_tunnel - validate decap GSO and encapsulation state

This commit tightens tc_tunnel tests by verifying post-decap tunnel
state for both GSO and non-GSO packets. It enforces DECAP flags and
ensures proper clearing of gso_type bits and encapsulation state.

> diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/t=
esting/selftests/bpf/progs/test_tc_tunnel.c
> --- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c

[ ... ]

> @@ -655,6 +688,40 @@ static int decap_internal(struct __sk_buff *skb, int=
 off, int len, char proto)
>  	if (bpf_skb_adjust_room(skb, -olen, BPF_ADJ_ROOM_MAC, flags))
>  		return TC_ACT_SHOT;
> =20
> +	kskb =3D bpf_cast_to_kern_ctx(skb);
> +	shinfo =3D bpf_core_cast(kskb->head + kskb->end, struct skb_shared_info=
);
                                       ^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Does this pointer arithmetic break compilation on 32-bit architectures?

Since kskb->end is a pointer on 32-bit systems (rather than an integer offs=
et
like it is on 64-bit), adding kskb->head and kskb->end together attempts to=
 add
two pointers, which is invalid in C.

Additionally, CO-RE does not translate this pointer-integer addition to a s=
ingle
pointer dereference when cross-compiled on 64-bit and run on 32-bit kernels,
which can lead to a garbage pointer dereference.

Is there a safer way to calculate the skb_shared_info offset in decap_inter=
nal
that is portable across both 32-bit and 64-bit architectures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812083115.7310=
0-1-nhudson@akamai.com?part=3D6
