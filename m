Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821975;
	b=YzwyZpHEZLb422FqooOibsfRSs9Fm4jn6emXdhUIBFBRULTcLibw5JsaIZp5mwOErzoe
	 MGlKohZgjLmOhZZTfEJlusRzcBSF6RTFASeUDCWGzsMIT1V3bEBs2JxZpNB9QMEFbS1G9
	 P5Ua9nUQ80wKT8HjB9zOGw2us4aeqlUeZnHy+L0/A4DdWvXW3XXNV7IntM3Ugh/BgWa3j
	 TZF9rNShxcwuWxmos+P7ZcGFArhXhbjC+bcFCYDaFe4gspNSDTCyb8Xr2YsMMxw8LlZ3h
	 kEh1r0PKdBCrW+iBorPPwyGiOtZ8tqPSvHBU3Fpl4A/avEcYa+wPR0jXSBwJmdmSeXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821975;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:Date:
	 From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=EpEivueZqLIKADrPWMjl3A7k/b/byEHl6Jp1sTC5nhg=;
	b=ldGIEEye4F38GYLdeIXqP7UF3zS+gXK+lxNn4RSMR0kD0QY/O1E5qpVWMZS9R3R5qfa1
	 h0IpVpd3sKOngvOH5STYf44jqob8ZinUW1Zh1eJoCNTqWEFs/PRm2S3UaqrqB6ANCfhZx
	 HAzp8OuzvrI5PFS/be/qRu4/ED4BjPJKnWSMmTTlEOD+lTM7X/qJc7DnrCafzxc+wSv0L
	 zZzB1ztuL8u5316CbQbDITmMDE/Qn6aN4u3pypBroqnSfS1jU2wchq2+N52FuffRktAYb
	 RMmVnV1OxDSlC6sPorusStuHNo5lThuLe40wl9hYxCYMtOujvjNPvuVHUwzXy6Vcb9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b="82Rinob/";
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=pNb6qZfq;
	arc=none smtp.remote-ip=160.80.4.35
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.35])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8963606D829;
	Wed,  4 Nov 2026 19:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8963606D829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=82Rinob/;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=pNb6qZfq
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6A4JpmJF025384;
	Wed, 4 Nov 2026 20:51:53 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id CD48A121681;
	Wed,  4 Nov 2026 20:51:43 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1793821904; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpEivueZqLIKADrPWMjl3A7k/b/byEHl6Jp1sTC5nhg=;
	b=82Rinob/Kq6ijDpOWSDVjYui4K310k0guZ4huTu5qmv02CiEy0tC6aSjjC5d6ClOIE/ctE
	Td69ys8BnLPeJnBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1793821904; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpEivueZqLIKADrPWMjl3A7k/b/byEHl6Jp1sTC5nhg=;
	b=pNb6qZfq/ux+uANgdgzkai8tw1rFIfLTwO+Om53h8yqg6/JsnXt9wViqFRRG6MRqAB4y0R
	EouYFy1suM3t5S1VUIWwi/bJlnuLKqAnodQdLN8q4VD6iupoE7mvN8H5N8lIGFRyXTX2in
	z/TjO4lrPe4b3QT3oZ/W+o0/98/CjxJSmbqGvyQ5dkzXVOTZURP5+piBH0e/U/0wux0H/4
	cFwvE7HLUVBiuW9vAxLfr76QbGaFZXLdZgCQ4MAq+wUBagrAgPIF6ySHF9fGHa1Dr/ciuO
	THWheRk2k76QVQ95sZzDTtlHmzR8dnSidQ99TZ0IWFOVPQkYn2U0+r4ZCbCGlw==
Date: Wed, 4 Nov 2026 20:51:43 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, David Lebrun
 <david.lebrun@uclouvain.be>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>,
        David Lebrun <dlebrun@google.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Andrea Mayer
 <andrea@common-net.org>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net 3/6] seg6: update skb checksum when SRv6 behaviors
 advance to the next SID
Message-Id: <20261104205143.f254aaaf5d5b112fc0188016@uniroma2.it>
In-Reply-To: <aulA09qBNtIxJq7S@fedora>
References: <20261031225033.64-1-andrea.mayer@uniroma2.it>
 <20261031225033.64-4-andrea.mayer@uniroma2.it>
 <aulA09qBNtIxJq7S@fedora>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Tue, 3 Nov 2026 10:15:03 +0800
Hangbin Liu <hangbin.liu@linux.dev> wrote:

> [snip]
> > +	if (skb->ip_summed == CHECKSUM_COMPLETE) {
> > +		update_csum_diff4(skb, old, *(__be32 *)srh);
> > +		update_csum_diff16(skb, (__be32 *)daddr, (__be32 *)addr);
> > +	}
> > +
> > +	*daddr = *addr;
> 
> Nit: we can re-use seg6_update_csum() if the transport header set correctly.
> But that function is static and we need adjust header files.
> So the current change looks good for me.
> [snip]

Hi Hangbin,

I thought about something similar. seg6_local finds the SRH with
seg6_get_srh(), and the SRH is not always where the transport header
points, for example with a Destination Options header before it. Passing
the SRH to seg6_update_csum() and moving it to include/net/seg6.h would
make it usable in seg6_local. I will likely propose this for net-next,
after this series, to avoid changing more files than needed in this fix.

Thanks for the review,
Andrea
