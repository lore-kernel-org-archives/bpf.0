Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CC023A564;
	Thu, 25 Jun 2026 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782417015; cv=none; b=TCfZRn2CaTUMfcHSQ3UlWJq65dTnx3oMEqIaV+NCMYZeotjVHUu9FLOzlq1zjPcSjOx3EAOc7UlHhIrroRigBcdE3XstvDgPVvS2J+SZow/iiDmf78GY7bMZjEKTyZcshMWOLyvEExCK2En4/mJ5juNfmKgRTgRp501V5VjJ6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782417015; c=relaxed/simple;
	bh=ZwtqIsXZQKhOUM2Y6kUqJMWNT07sluODBroAvBTdd/I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iQ1adkJGFh1+cQpbMAgljQnaL8XwgyjmqnZaHNYz0gASiyBA9ew/oYUTu8U5dhX9wz8I12hkNNeb2sxSsFq7itKCaFk68c/Ic6rHbgnMjfIcOPoejThMjXRwypj3FZ1bihT6tA0oLZN+G2R89yIfH7GzkVdy1ROZzZRZgArDRds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=Yku7au1H; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=Jq+nquC9; arc=none smtp.client-ip=160.80.4.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="Yku7au1H";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="Jq+nquC9"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 65PJn9LN019466;
	Thu, 25 Jun 2026 21:49:14 +0200
Received: from lubuntu-18.04 (unknown [139.28.148.6])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 06B661211F3;
	Thu, 25 Jun 2026 21:49:05 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1782416945; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ds6q24X/mKp/EUynvIKlZc1F3cbT4VWW5mO5SZetav0=;
	b=Yku7au1H9mT7V5yyQAccFZ6+vou0uXePigtBv7mjhnHj1xHXK9XieukqkepLueZucd0DXs
	Rb3PNYcrVPt6sjCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1782416945; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ds6q24X/mKp/EUynvIKlZc1F3cbT4VWW5mO5SZetav0=;
	b=Jq+nquC9i3nKmfDd/HNRu7w4UBia+J24kK7FYvcdkP6FiA5r9V9arp0ZiKVXO9ZFlE7vxM
	tcRPgZFkRa9BjsrfhlRzepecKhCbDqJKRnSQHnY1cPeHPGu+qN/+g2VQCAUS7qBLxKuZOE
	nDx99xJuO4NUT2ClugLQJuW13sVPejYQpjwtrn3SVOiNV+yg71s+8rvA/JvPkgJk/4NWVk
	dcDBm7QPP89wn9heuTncXLDhk9gXfq94COlkX/i3jmMKT1NcnWeiMvvQLsgnKhFpG+Dh8f
	oyFLAaG/pkdQ3rLaiWuVpouAkTynQ80yMwrHwtOKGHtWaJ8rggbRyly5wv6PsA==
Date: Thu, 25 Jun 2026 21:49:04 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mathieu Xhonneux <m.xhonneux@gmail.com>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        David Lebrun <dlebrun@google.com>, stefano.salsano@uniroma2.it,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v2] seg6: validate SRH length before reading fixed
 fields
Message-Id: <20260625214904.155b202be86008d812ae445b@uniroma2.it>
In-Reply-To: <20260623-f01-17-seg6-srh-len-v2-1-2edc40e9e3e1@mails.tsinghua.edu.cn>
References: <20260623-f01-17-seg6-srh-len-v2-1-2edc40e9e3e1@mails.tsinghua.edu.cn>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Tue, 23 Jun 2026 18:32:31 +0800
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn> wrote:

> seg6_validate_srh() reads fixed SRH fields such as srh->type and
> srh->hdrlen before checking that the supplied length covers the fixed
> struct ipv6_sr_hdr fields.
> 
> The BPF SEG6 encap path reaches this with a BPF program-supplied pointer
> and length: bpf_lwt_push_encap() and the SEG6 local BPF END_B6 and
> END_B6_ENCAP actions call bpf_push_seg6_encap(), which forwards the
> length to seg6_validate_srh() with no minimum-size guard.  A 2-byte SEG6
> encap header can therefore make the validator read srh->type at offset 2
> beyond the caller-supplied buffer.
> 
> Reject lengths shorter than the fixed SRH at the top of
> seg6_validate_srh(), before any field is read.  This fixes the BPF helper
> path and keeps the common validator robust.
> 
> Fixes: fe94cc290f53 ("bpf: Add IPv6 Segment Routing helpers")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
> Changes in v2:
> - Narrowed the commit message to the BPF encap callers that can supply a
>   too-short SRH length.
> - Dropped the unnecessary cast in the minimum SRH length check.
> - Link to v1: https://patch.msgid.link/20260620-f01-17-seg6-srh-len-v1-1-36cbb29c12f1@mails.tsinghua.edu.cn  
> 
> To: Andrea Mayer <andrea.mayer@uniroma2.it>
> To: "David S. Miller" <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Simon Horman <horms@kernel.org>
> To: Mathieu Xhonneux <m.xhonneux@gmail.com>
> To: Daniel Borkmann <daniel@iogearbox.net>
> To: David Lebrun <dlebrun@google.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: bpf@vger.kernel.org
> ---
>  net/ipv6/seg6.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> index 1c3ad25700c4c..62a7eb7792026 100644
> --- a/net/ipv6/seg6.c
> +++ b/net/ipv6/seg6.c
> @@ -29,6 +29,9 @@ bool seg6_validate_srh(struct ipv6_sr_hdr *srh, int len, bool reduced)
>  	int max_last_entry;
>  	int trailing;
>  
> +	if (len < sizeof(*srh))
> +		return false;
> +

Thanks for the patch.

Looks good to me.

Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>

On a separate note: the AI review message seems correct. The reported
issue is a separate, pre-existing bug in the BPF SEG6 encap path, not
introduced by this patch.

Regards,
Andrea

>  	if (srh->type != IPV6_SRCRT_TYPE_4)
>  		return false;
>  
> 
> ---
> base-commit: 96e7f9122aae0ed000ee321f324b812a447906d9
> change-id: 20260619-f01-17-seg6-srh-len-a85f35427e0b
> 
> Best regards,
> --  
> Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> 
