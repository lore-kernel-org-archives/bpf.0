Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F563AC0E6
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455685; cv=none; b=jMt2fO+XRwg6YKoslbSdgAcNiwzfO4/H4VDu5O1RU7ETwCIzpR0mmxEhynuljWPceb5i39ZeNSrZZAZSRQmKNTpX3ZX7HADsE7i2QFQOyn/NyR3kd1qXDvg1tFJNePL+J3nC0ezZ71rzvB90Mz+gsN1Am4JRutOAlrR3WI13w9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455685; c=relaxed/simple;
	bh=Fjw4fusNEIPqHrb1lk1Mq47GHfYCNEOxMbTroxbWuuo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sBg0JGLmHx4bKi3PZO3ux5EDmo/9lPUMrEz2/qa56Pu8XyTkCzEVWhTybRFqJqB0DGp9ifPk3KlsyJrsZHDcJdfHU/ujH1DhUp0lo4tyc0WMhCae9NqmnPhxaItqi9qLY2VGSQfuBKsSOQIvrt98BFo4HZOzxq0YjLViMAcVs60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emso+6Rq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emso+6Rq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF41C2BCB3;
	Wed, 29 Apr 2026 09:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777455684;
	bh=Fjw4fusNEIPqHrb1lk1Mq47GHfYCNEOxMbTroxbWuuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=emso+6RqRh9IDbk0r8bnpgw9X75TvZ4ZRpXU51UDuGcrOSkcMxQOxUdG6SxrsZito
	 n1R0nPdqcyvGMLip3gVT3DBy8lkp4aJACwQUe6uabTGi0h6M9YkGQbfuIxaArQ54/E
	 MABhXMol/tJY9CozEv/hbVWR5a3t4tN9XovhMkNuwMOVU9KycP5lsYcVB1zoUTcsc6
	 wAEdVISXK+I2y+EIMFzUX/aB5eeXtK9IF6eNCGcPwZVKWKaj7UNkjazcrAX8fZYjL1
	 XW6i1NT4Y+lBdYK5cKZfUBXw/S1TuUXwqPHfIz9iiJ0ok0oSmtm5DfZ21jCwxrZQ5V
	 YUSDMHf6GGw1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] bpf: bpf_dbg: fix off-by-one in cmd_select
Reply-To: sashiko@lists.linux.dev
To: "Hasan Basbunar" <basbunarhasan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429084441.22089-1-basbunarhasan@gmail.com>
References: <20260429084441.22089-1-basbunarhasan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 09:41:23 +0000
Message-Id: <20260429094124.8AF41C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a logic regression in `cmd_select` that ski=
ps bounds-checking for the newly selected packet, allowing subsequent comma=
nds to blindly dereference invalid or out-of-bounds packets and crash the d=
ebugger.
--

commit 34793f5a31a990a20ff41f65cd4c82f4419849d0
Author: Hasan Basbunar <basbunarhasan@gmail.com>

bpf: bpf_dbg: fix off-by-one in cmd_select

This commit changes the loop in cmd_select() to start from 1 instead of 0.
The intent is to fix an off-by-one error where selecting a packet advances
the cursor one packet too far.

> After this fix, 'select K' shows packet K for all K in 1..N, and
> 'select N+1' correctly errors with "no packet #N+1 available!".

Is this description accurate?

For select N+1, the loop will run N times and attempt to validate the
first N packets. If the Nth packet is valid, pcap_next_pkt() returns
true and parks the cursor at the end of the file. Because have_next remains
true, it appears the function will return CMD_OK rather than an error.

Does it only error during testing due to a pre-existing off-by-one check in
pcap_next_pkt() that falsely rejects valid packets aligning exactly with the
file's end? If the PCAP has any trailing garbage bytes, it seems select N+1
would silently succeed.

> diff --git a/tools/bpf/bpf_dbg.c b/tools/bpf/bpf_dbg.c
> index 00e560a17baf..4895602ab37d 100644
> --- a/tools/bpf/bpf_dbg.c
> +++ b/tools/bpf/bpf_dbg.c
> @@ -1141,7 +1141,7 @@ static int cmd_select(char *num)
>  	pcap_reset_pkt();
>  	bpf_reset();
> =20
> -	for (i =3D 0; i < which && (have_next =3D pcap_next_pkt()); i++)
> +	for (i =3D 1; i < which && (have_next =3D pcap_next_pkt()); i++)

Does this change skip bounds checking for the newly selected packet?

Looking at pcap_next_pkt(), it validates the current packet and then
unconditionally advances the cursor. By reducing the loop to which - 1
iterations, it seems cmd_select() positions the cursor on the target packet
but never passes that packet to pcap_next_pkt() for validation.

For example, if which is 1, the loop executes 0 times and have_next remains
true. Could this cause cmd_select() to return CMD_OK even if the PCAP is
empty or the first packet is truncated?

If so, could subsequent commands like run or step blindly dereference the
unvalidated packet from pcap_curr_pkt(), potentially causing an
out-of-bounds memory read?

>  		/* noop */;
>  	if (!have_next || pcap_curr_pkt() =3D=3D NULL) {
>  		rl_printf("no packet #%u available!\n", which);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429084441.2208=
9-1-basbunarhasan@gmail.com?part=3D1
