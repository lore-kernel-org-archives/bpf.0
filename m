Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586247D458
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783857; cv=none; b=tZPeGwZAdku6Cu6/v92iAQR0Z8ZIJwzeWX5nUuBIOylYY10UZGeapI62V5A7wnC1YbphFOW2L+n6JjUyp6KKq8PR66Y8KeAaoRVP0dXXjkuN6Pj/g/VuaXv0QbUU85C9eOLx9mVRFott3uw4OTRia4SLPyIwVTdQQVDVIPUYuBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783857; c=relaxed/simple;
	bh=XLWwf74i9ZlE2eZzeZ9BNfV4iIPqgAFAjx4k8Ya51hk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uH0hYADxeg5AWckyXMhoZrqskvmfD7TRmPSMVL/8lfHBkasSOEOOEa9/XVcEz/JVEym9GKHxdTMlau0jPwkOxL0AJdbEaxWCX8xLSyaHAtS9MQXTl5RMuK2Oi7NN5NfKMld84b6HZ1av0OXFwhjNFXHpeDU0kduV2vYhn5vvn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7iw1CgG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7iw1CgG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F7F1F00ACF;
	Mon,  7 Sep 2026 12:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788783854;
	bh=aU1o9fEUBpPLi2fUFwVJqSxEV7Hw+yk2T3+B5bLnCLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A7iw1CgG+soMbas2a116WPQREEgwdBhdnZw7ACbXjqD7lsHhU8DhmK9+kmpvjBUe4
	 xUJ5UjBNo6jGxWsvJj5BlN8TVfc0KJUAR+SqzEz7NSKBlb+9lpQKga8H1L0mzPDHg8
	 /HuZIkeHT85Y9k7WVDk1Y0iT1ny33QeAwmD4tDJRoFlqztUx70XwSQpPryeu6KTNVj
	 ti/qpDfH3QNkeuUXNYG/vsovZQ1LQJeGzK76VKwnAtxnTuhlhUkq/EDo8JzaY7rlCp
	 uLbEwiqbEgIX495akim0y7tO3UxT2MEC2fDz6r6jrLCde3fUWCRw1WkUFVNDpmEcC8
	 WTORDR5d3+H4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Fix bpf_skb_change_tail wrt csum partial
 skbs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260907121025.1923656-1-daniel@iogearbox.net>
References: <20260907121025.1923656-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 12:24:14 +0000
Message-Id: <20260907122414.95F7F1F00ACF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The checksum field space check in `bpf_skb_trim_rcsum()` assumes a=
 2-byte checksum (`sizeof(__sum16)`), but SCTP checksum offloads (`skb->csu=
m_not_inet =3D=3D 1`) require a 4-byte CRC32c. This allows BPF programs to =
trim SCTP packets such that only the first 2 bytes of the checksum field re=
main. The hardware will then attempt to process a 4-byte checksum, causing =
an out-of-bounds access.
--

commit 4cea525b891060e3211b5353724699e42d836d25
Author: Daniel Borkmann <daniel@iogearbox.net>
bpf: Fix bpf_skb_change_tail wrt csum partial skbs

This commit fixes an issue where bpf_skb_change_tail() rejects trims on skbs
carrying a checksum offload, such as those from GRO. It removes the minimum
length restriction from __bpf_skb_min_len() and modifies bpf_skb_trim_rcsum=
()
to downgrade the checksum to CHECKSUM_NONE if the new length no longer cove=
rs
the checksum field.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e7535523..8513167a858a8 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
[ ... ]
> @@ -3983,6 +3977,11 @@ static int bpf_skb_grow_rcsum(struct sk_buff *skb,=
 unsigned int new_len)
> =20
>  static int bpf_skb_trim_rcsum(struct sk_buff *skb, unsigned int new_len)
>  {
> +	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
> +	    new_len < skb_checksum_start_offset(skb) + skb->csum_offset +
> +		      sizeof(__sum16))
> +		skb->ip_summed =3D CHECKSUM_NONE;
> +

[Severity: High]
This is a pre-existing issue, but this patch replicates the flawed 2-byte
assumption from __bpf_skb_min_len(). The checksum field space check in
bpf_skb_trim_rcsum() assumes a 2-byte checksum (sizeof(__sum16)), but SCTP
checksum offloads (skb->csum_not_inet =3D=3D 1) require a 4-byte CRC32c.

This allows BPF programs to trim SCTP packets such that only the first 2 by=
tes
of the checksum field remain. If trimmed so that exactly 2 or 3 bytes of the
4-byte CRC32c remain, the length check evaluates to false, and CHECKSUM_PAR=
TIAL
is not cleared. The packet is then handed to the NIC driver.

Passing a truncated CHECKSUM_PARTIAL packet to the NIC hardware causes the
offload engine to access beyond the packet boundary, causing a hardware sta=
ll
or OOB write on the wire.

Could we check for skb->csum_not_inet and use a 4-byte length for the check=
sum
when processing SCTP packets here?

>  	return __skb_trim_rcsum(skb, new_len);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907121025.1923=
656-1-daniel@iogearbox.net?part=3D1
