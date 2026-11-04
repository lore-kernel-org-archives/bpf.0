Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824002;
	b=Vb3dJzMy//kPHC9cNeyrYIsct+dH7SmDKefoU/SmN3ODL8tlx2nJTeRlkYNPNlC5Yy6g
	 dOqApALWU61uvFepgF5kd633cTzLDLX8N+ZIF6whO6vzGn1V91LixY2e7dWvRcWxtqmCL
	 l0U3B+cRGkD5fRpScqMmAvHK/HqUtmpnzezjkI5smzWZATYLR7H43iCCj3d5qCPvl3EZ0
	 ZxBGwCM3xBwiAWl0MeKfLzUqg1M+txwOQ9P3urYiP273abmaHBPdTyZow1KD3Gtned8IJ
	 LHmsqrRPAOMkJqRIzTqRIIIRJLnSU2tYYv3UnqjAqNI4pduz8nmYt0Tp6JJgnou9DVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824002;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:Date:
	 From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=Zy0da+RmL4OG3OVXsPiCDxk1YUO9Mt8OW1eMIQoj6ps=;
	b=pk3hzerbAyADDlPt0qXQMABGbBz7RtYylfurkTcQIwNEp6LkM109NhEAr47JxTskL0BN
	 tVlGbnHahqcHdBm7PwejDqjUk+UmKEPijxvG5HieznZdn+FcJUaeqRhYh08667EcXr8Zq
	 9HA5fY4s2MMxYFkt+pdhtVDcXuEemBNXsCptDxFTNmD9IQ/s/uZ8QezDVj8z7/vqK5bUh
	 Ekh7G2dJxOq4rda/rKmopXQdPP6SChq9oAW3hiO8kvlnhhstekyD8hwfPug5k8h2QdmCl
	 jvTnmPwgPcIQhSQWFuCa7UAEExhvGMocyjI6FQDlrVzcDFtNiMsYoPqMT1+44yqp6NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=ldLCA6rR;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=mjJK1j5Q;
	arc=none smtp.remote-ip=160.80.4.35
Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.35])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA62606A33B;
	Wed,  4 Nov 2026 20:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FA62606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=ldLCA6rR;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=mjJK1j5Q
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6A4KPoV6026281;
	Wed, 4 Nov 2026 21:25:55 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 402991209D4;
	Wed,  4 Nov 2026 21:25:46 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1793823946; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zy0da+RmL4OG3OVXsPiCDxk1YUO9Mt8OW1eMIQoj6ps=;
	b=ldLCA6rRq3os4tvfZIs6fO/PijLgBdg7VxyRstRpyQ9UzRMGOXI6uI0AQHbokBPMrJuLwa
	Kl5lYnzZCYRTtACg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1793823946; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zy0da+RmL4OG3OVXsPiCDxk1YUO9Mt8OW1eMIQoj6ps=;
	b=mjJK1j5QTbfhSGv23Dw+64AcWgl6YE3lhTwdbo9BKazkGHYVDBUCH3yBSasN8iDyAlY2v4
	1gj/cFeZWVg3/yM3QiIq4NrngPkIJ4Jb9bZbzS4bKomXQjPeCBFJGTcAOYHSZucyC7chzT
	Jemqedpx7QfoyHHukGFnZ9WbRLTmzqp5RxTNBqBJR5MKJZLB43p6la/eyLKv+Lz1Q+i26T
	8ZN0REU41k1FXHEUgTIMDi+41Y29r3zJ8SHW2Dz8IJvUcoCUBqe5BnNamLuf8Rduu3afIH
	yUVSaQ6Gj3os5xhH+bM2tWbMmUH2rosbTpIt9v9hYU+WR7MQmjZnytkh6B0LMQ==
Date: Wed, 4 Nov 2026 21:25:46 +0100
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
Subject: Re: [PATCH net 5/6] seg6: account for the MAC header in skb
 checksum on L2 encapsulation
Message-Id: <20261104212546.1222c4cfcccaecf68f326cdf@uniroma2.it>
In-Reply-To: <aulI7pl1oWRKzXgt@fedora>
References: <20261031225033.64-1-andrea.mayer@uniroma2.it>
 <20261031225033.64-6-andrea.mayer@uniroma2.it>
 <aulI7pl1oWRKzXgt@fedora>
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

On Tue, 3 Nov 2026 10:37:34 +0800
Hangbin Liu <hangbin.liu@linux.dev> wrote:

> [snip]
> >  		skb_mac_header_rebuild(skb);
> > -		skb_push(skb, skb->mac_len);
> > +		skb_push_rcsum(skb, skb->mac_len);
> >  
> >  		if (tinfo->mode == SEG6_IPTUN_MODE_L2ENCAP)
> >  			err = __seg6_do_srh_encap(skb, tinfo->srh,
> > -- 
> > 2.43.0
> > 
> 
> Should we put the skb_push_rcsum() inside of __seg6_do_srh_encap() and
> seg6_do_srh_encap_red()? They all do skb_mac_header_rebuild() again.
> [snip]

Hi Hangbin,

I am not sure where exactly you would like to put skb_push_rcsum() in
these two functions. I can read it in two ways.

1) Right after skb_mac_header_rebuild(), for example in
   __seg6_do_srh_encap():

 	skb_push(skb, tot_len);
 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
+	if (proto == IPPROTO_ETHERNET)
+		skb_push_rcsum(skb, skb->mac_len);
 	hdr = ipv6_hdr(skb);

   Here the outer headers are already pushed, and skb_mac_header_rebuild()
   moves the MAC header in front of them, outside skb->data. The push then
   makes the packet start with that MAC header, instead of the outer
   IPv6 header.

2) Before the outer headers are pushed, for example in
   __seg6_do_srh_encap():

+	if (proto == IPPROTO_ETHERNET)
+		skb_push_rcsum(skb, skb->mac_len);
+
 	inner_hdr = ipv6_hdr(skb);
 	flowlabel = seg6_make_flowlabel(net, skb, inner_hdr);

   This can work, with the push removed from seg6_do_srh(), but the L2
   case in seg6_do_srh() would still keep the skb_mac_header_was_set()
   check and the headroom for the MAC header, and part of the L2 handling
   would move into __seg6_do_srh_encap() and seg6_do_srh_encap_red().
   __seg6_do_srh_encap() is also used by the ENCAP mode, End.B6.Encaps
   and bpf_push_seg6_encap(), and seg6_do_srh_encap_red() by the
   ENCAP_RED mode.

So the first way does not work. In the second one I do not see a real
advantage, and it would split the L2 handling between three functions.
For this reason I would like to keep the change as it is in the patch.

What do you think? If you meant something else, please let me know.

Thanks,
Andrea
