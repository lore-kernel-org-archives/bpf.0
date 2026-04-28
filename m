Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D2A256C84
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777410199; cv=none; b=K4uuVANvlk5YgEYjzto1q+Pxq11xz+rHn2HpZlq8JL+fV1vbaXCjOgFC2FZANVukEdPNTfPQD2M/x69if+AvnPVc3Va97dUt+hhyCOpA/OEa3NIUh8cltzHITwMpAuYdsnCret+SrFphjLt59c73QP8eaZ+STcFDZMbfGW/gYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777410199; c=relaxed/simple;
	bh=45NkpjwJ2hRgLdMju1pTU8rzvOVxyEXLwjh/mBF3Hvc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TaXATlh+BZJD5gLC3PukIvUJBK8FD4S7MPJgDsRKB2bh8upI3a0P+3XeKcsKn2t4sz4BSniNjmVdYa/8seqLNmBxxYAM1FPusvKuRcom263HGsqjPLAQhSzxuesP4W2EV5V0LejDQUnzE3qHwvqQajBsyhGxdGBU+lDX7eEHsK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cstTgQi0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cstTgQi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5968C2BCAF;
	Tue, 28 Apr 2026 21:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777410199;
	bh=45NkpjwJ2hRgLdMju1pTU8rzvOVxyEXLwjh/mBF3Hvc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cstTgQi0BBV5ZHHHUpRc8m5eUjYMA5OI+GpQQpKl+Qg35F4UnPRu6pYUXz9D4idD8
	 O7xfwbq5MrdKuXlTYZucAu8gHqAzIHaBH4R+lFW008Fhm47xJ0F4e1SY4eYVZR1zNV
	 ifkfdDmEgSkpYI9W+l/9LseMPJXw1jD0KauxBUK6W7wYd9VXnEK7fy1s2eSXSxbgQt
	 vwZLKBXi5Czh4SlANb4eA2iBlogAqDS8CJBJdntrM+otEmxL77Rjq232ZA7lVzwW5P
	 Q77XTfn0KfSq8rU7lGxrbU0LUAju9DOnPY8szgrvf5KF8NN20Ux94N0+S714/X3VK4
	 I6kFwzFKTot4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: bpf_dbg: fix off-by-one in cmd_select and
 pcap_next_pkt
Reply-To: sashiko@lists.linux.dev
To: "Hasan Basbunar" <basbunarhasan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428100109.56572-1-basbunarhasan@gmail.com>
References: <20260428100109.56572-1-basbunarhasan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 21:03:18 +0000
Message-Id: <20260428210318.E5968C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a logic error that processes a phantom pack=
et at EOF, leading to an out-of-bounds read and potential crash.
--

commit 0b409950f92375c0cacaee040b899aa78918dfb5
Author: Hasan Basbunar <basbunarhasan@gmail.com>

bpf: bpf_dbg: fix off-by-one in cmd_select and pcap_next_pkt

bpf_dbg's interactive 'select <N>' command, documented in the file
header ("select 3 (run etc will start from the 3rd packet in the pcap)")
to use 1-based packet indexing, advances the pcap cursor one packet too
many.

[ ... ]

> diff --git a/tools/bpf/bpf_dbg.c b/tools/bpf/bpf_dbg.c
> index 00e560a17baf..f21576dc2326 100644
> --- a/tools/bpf/bpf_dbg.c
> +++ b/tools/bpf/bpf_dbg.c
> @@ -923,12 +923,12 @@ static bool pcap_next_pkt(void)
>  	struct pcap_pkthdr *hdr =3D pcap_curr_pkt();
> =20
>  	if (pcap_ptr_va_curr + sizeof(*hdr) -
> -	    pcap_ptr_va_start >=3D pcap_map_size)
> +	    pcap_ptr_va_start > pcap_map_size)
>  		return false;
>  	if (hdr->caplen =3D=3D 0 || hdr->len =3D=3D 0 || hdr->caplen > hdr->len)
>  		return false;
>  	if (pcap_ptr_va_curr + sizeof(*hdr) + hdr->caplen -
> -	    pcap_ptr_va_start >=3D pcap_map_size)
> +	    pcap_ptr_va_start > pcap_map_size)
>  		return false;
> =20
>  	pcap_ptr_va_curr +=3D (sizeof(*hdr) + hdr->caplen);
>  	return true;

Does this change cause pcap_next_pkt() to return true when advancing past t=
he
final packet, leaving pcap_ptr_va_curr pointing exactly at the end of the
mapped file boundary?

If the cursor is placed at the end of the file, could this lead to an
out-of-bounds read in commands like run or step?

Looking at cmd_run(), the loop relies on pcap_next_pkt() returning false to
terminate on the final packet:

tools/bpf/bpf_dbg.c:cmd_run() {
	...
	do {
		struct pcap_pkthdr *hdr =3D pcap_curr_pkt();
		int ret =3D bpf_run_all(bpf_image, bpf_prog_len,
				      (uint8_t *) hdr + sizeof(*hdr),
				      hdr->caplen, hdr->len);
		...
	} while (pcap_next_pkt() && (!has_limit || (++i < pkts)));
	...
}

If pcap_next_pkt() now returns true when advancing past the final packet, it
appears the loop will execute an extra iteration where pcap_curr_pkt() poin=
ts
past the valid data, leading to an out-of-bounds dereference of hdr->caplen.

> @@ -1141,7 +1141,7 @@ static int cmd_select(char *num)
>  	pcap_reset_pkt();
>  	bpf_reset();
> =20
> -	for (i =3D 0; i < which && (have_next =3D pcap_next_pkt()); i++)
> +	for (i =3D 1; i < which && (have_next =3D pcap_next_pkt()); i++)
>  		/* noop */;
>  	if (!have_next || pcap_curr_pkt() =3D=3D NULL) {
>  		rl_printf("no packet #%u available!\n", which);

Does the combination of these changes also cause the select command to
incorrectly succeed when requesting a packet beyond the end of the file?

If have_next receives true when advancing past the final packet, a command
like "select N+1" on an N-packet file will terminate the loop without an er=
ror
but leave the cursor positioned at the end of the mapped file boundary,
meaning subsequent commands could read out of bounds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428100109.5657=
2-1-basbunarhasan@gmail.com?part=3D1
