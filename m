Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674946;
	b=dBr/rJV7ioU2UrYw+Kw/QP4ff5kveWl+oqnvlWVQrJ1Ov1frTXtzuopqELyHE+tgH+CA
	 K9S4OUt5A4VY84/BG+F6GOc5qt7KU/7U6kvz5dhoP2JUgLBqZi26d7muzIALN9cq13HXY
	 viSHaszF3ZA4TmmCzfG88FJyxyMHHohLAbPX47TdX7VW3fIqg8aiIC8eSJc6tGV2EoMui
	 sKgtVWS4ld+BVNCLBInL0GNjZ+Rh83HuXtboYFpSBG9HD+j+sP6JG6gUqKds/53TcjN5L
	 LP/8tv0iBfrmkiOUxybDZB2TOyayO/OeeMYAFYqDd6kDPFstz7I9raa+Tnb/r4YrQeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674946;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=TJhxwzQVV2Bitil/P+RgNQfU0rtSwWSbTvYT//HoKb8=;
	b=ZfKabTOIu/9eNHpMNqMAgWlWTUgVrSjhlWqhKsvS01ml16r2or9XIGQrrYv513425pd2
	 CQ55I9NP8o6vuaI7mfcmMlCNpyhQ9vEWltI7K2qYxpknovlNGJGxC+5jZeXubynDGGqCt
	 VOcdjHN5IhcD5oKEmtlZqIS6ucu4yHsL/lV+VG9WAQKEG3yftPVCA9FH5Gd11A1hGmOa1
	 19b1WTtD8664miuctxGwBflH+1QHh/sCuhhOLUIMxz2xilikEQmBFoAIuNF1lo3iGI6nb
	 wr2u46PoyDDJcOrSVytrY0Kin81qVqLdvbZseE1w3JxncSoKby+cGZGD1muhn3pV49A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eo54TOrg;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Nx2Qe0Od;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E36606A31E
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 13:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46E36606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eo54TOrg;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Nx2Qe0Od
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792674943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJhxwzQVV2Bitil/P+RgNQfU0rtSwWSbTvYT//HoKb8=;
	b=eo54TOrg55GBUdtK7Xgqnks5RyzCPX7hCbzKBCOfMMWN+dLPSLs6VCvk5608ZFOBv2Lp5L
	rhRwCRR/hqr0jkLrVuTwZ6mOQ9b/FnF7U+dlfM5VB+rQ19FMuYgH0aTbuyQ4hFZtU+ofZQ
	+FZwIJpnNM6iq3VIscmzPqxpx5Bescg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-lnEVaioUNhqvz_CwYvqEMQ-1; Thu, 22 Oct 2026 09:15:42 -0400
X-MC-Unique: lnEVaioUNhqvz_CwYvqEMQ-1
X-Mimecast-MFC-AGG-ID: lnEVaioUNhqvz_CwYvqEMQ_1792674941
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so13080705e9.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792674941; x=1793279741; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TJhxwzQVV2Bitil/P+RgNQfU0rtSwWSbTvYT//HoKb8=;
        b=Nx2Qe0OdCKTwUZNGToxKUf3/hJLkQv5fRTuI27dc0P/fTuHoDUeZdpW3W8MZHkyozu
         7+kfj1XeVDMm6WKlniCdnhAWSHYeLp8GvpphZqxrzaHTxUAuTyRaeyg1NLpohCaLA+cs
         Qw8RnRBMkB423wG9P63SDN87xBc5NuSUA1CUWbgCFr2TcECvjPIIjr0VAzkUqJXCa7af
         r2N/KOwg8/Z6T5LB0RNMwTGXxrKL339fAvrIvk14CTwiJhr+fYCDsY64pRuCwhnSghuC
         jQLC5zl7HTNCPLZdSt7SGFHvqXj2dYVkfFHxLSo6e2N8aDPIkhFcFp4IbzLUU+a7ko4B
         WL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674941; x=1793279741;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TJhxwzQVV2Bitil/P+RgNQfU0rtSwWSbTvYT//HoKb8=;
        b=EDzsyIW9LyTOVA7Y0qCDW7WRCV2ERiEe/1buWLWbrHu2nhcu0/ammUfdvEw3G5ds79
         RRehMGbt6uXZ9xeG/TEjJ8+bx3XJCYQ7SxWs0+kUlppQzHAw93DNBGybnDlosqScf3Dh
         LsOCW01OBo2aLqjYa3I9xRG/co4Qrr6w1HXo8QvmJ8g53ZZ1JH/t376I2R4JOf0igDz+
         91DIhfr8Rb9JFaWhE+Kx4Y+OrYxggTpuASLvuC9MBtIEdKys2xVhkE1VaGbOsq3D7TAk
         jKcuetnfPOVqXpaz4W1IZYUyU0Y62A7CbFXYenCZiRUGz3KVvWrqUzGzkhtstKIEC0jZ
         Tkag==
X-Forwarded-Encrypted: i=1; AKwUvBw61sDUy/DhPIh84mQUI1rS9UTYRXi7SXrKYio+Ou6QfQR2qXyJiwmeqPo77vmmZ1Ni0Yo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsTVGt9K/hgyE/TzDaYhfi1FewQlwT56E4D2nebObJ1yPorPX3
	6ywLhi9NmiBbj+sjF+5Ch2v44Scnu3y9Yex2QaThkGJgLv65XV6OOshcnoSDjr6r9Ndj239qTz5
	mZEcnzfBvQow3zO5sKJuwn4Y6hnWH36VzBoqeS16S86axcyto4iwtng==
X-Gm-Gg: AYBFou3UQkqeXXwLM8+su8IJvX+EThIWCjONioYxn8J9OGaCzNsM1eGpOexTZd79VQ4
	GB0sUiO6eMu2TYmz7yes4G+uLTTywhZHldWghy0d7eHeTZrpyxhow61OC2rQN+r5JjRQaAnYf3s
	P16QR6DXsQqXVs7xVEYepzIrttPektsHMGp2dY5owtQUFUPpF2K6wclVJYWD1NMIGFdhSWpApbb
	ss2eXvwqtrJIQhh2IVY3TX5vO1ehzP5g7F+HLtRoLZEZxIlHeNZX5AtkoyIrdUOq0sM7148ylGZ
	00IP7uPsL66mbwyU9G6oUbxeMZjClvQ6DAspD67e8m1JhAXyfOyRX40BP4WPXye9+hE=
X-Received: by 2002:a05:600c:34c4:b0:4a2:1a:a10a with SMTP id 5b1f17b1804b1-4a2001aa275mr98637705e9.29.1792674940587;
        Thu, 22 Oct 2026 06:15:40 -0700 (PDT)
X-Received: by 2002:a05:600c:34c4:b0:4a2:1a:a10a with SMTP id 5b1f17b1804b1-4a2001aa275mr98636665e9.29.1792674939765;
        Thu, 22 Oct 2026 06:15:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203963f3fsm81299735e9.2.2026.10.22.06.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:15:38 -0700 (PDT)
Date: Thu, 22 Oct 2026 09:15:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Nick Simpson <nick.simo@gmail.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Sridhar Samudrala <sri@us.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, bpf@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] xsk: validate checksum offload requests in copy
 mode
Message-ID: <20261022091241-mutt-send-email-mst@kernel.org>
References: <20261021180329.26358-1-nick.simo@gmail.com>
 <20261021180329.26358-2-nick.simo@gmail.com>
 <87a4o66lio.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a4o66lio.fsf@all.your.base.are.belong.to.us>

On Thu, Oct 22, 2026 at 01:07:59PM +0200, Björn Töpel wrote:
> Nick Simpson <nick.simo@gmail.com> writes:
> 
> > In copy mode, XDP_TXMD_FLAGS_CHECKSUM turns the csum_start and
> > csum_offset from the TX metadata into a CHECKSUM_PARTIAL skb.
> > xsk_skb_metadata() only checks that the checksum fits in the frame, so
> > csum_start can point into the Ethernet or IP header.
> >
> > On a veth, the skb reaches the peer namespace still CHECKSUM_PARTIAL.
> > When that namespace forwards IPv6 with nf_defrag_ipv6 loaded,
> > nf_ct_frag6_reasm() moves the IPv6 header forward by the 8 bytes of the
> > fragment header without adjusting csum_start, the forward hook accepts
> > the reassembled packet, and ip6_fragment() then completes the checksum
> > with skb_checksum_help(), writing two bytes into the accepted header.
> > With csum_start = 22 and csum_offset = 22 on a fragmented IPv6/UDP
> > datagram from fd00:1::100, the write lands on source address bytes
> > 14-15: an nftables forward rule matching "ip6 saddr fd00:1::100"
> > accepted the packet and the fragments sent out carried saddr
> > fd00:1::e87. For an unfragmented packet the same write happens at
> > egress when the output device does not offload the checksum; with
> > csum_start = 14 and csum_offset = 22 the packet left as fd00:1::ebf. A
> > csum_start that ends up before the network header (14 to 21 on the
> > fragmented path) makes skb_checksum_help() warn instead:
> >
> >   offset (-2) >= skb_headlen() (640)
> >   WARNING: net/core/dev.c:3647 at skb_checksum_help+0x4c8/0x850
> >   Call trace:
> >    skb_checksum_help
> >    ip6_fragment
> >    ip6_finish_output
> >    ip6_output
> >    ip6_forward
> >    ipv6_rcv
> >    ...
> >    __dev_direct_xmit
> >    __xsk_generic_xmit
> >    xsk_sendmsg
> >
> > socket(AF_XDP) only requires CAP_NET_RAW in the user namespace that owns
> > the network namespace, so the sender can be a container that owns one
> > end of the veth. With panic_on_warn, the warning panics the forwarding
> > host.
> >
> > The interface is documented for L4 checksums. Leave CHECKSUM_PARTIAL in
> > place only when the request designates the TCP or UDP checksum field of
> > an unfragmented IPv4 or IPv6 packet, not IP-in-IP or GRE encapsulated,
> > on an Ethernet device, and complete any other request in software, as
> > XDP_UMEM_TX_SW_CSUM would, before the frame is handed to the device.
> > The frame is dissected from its Ethernet type, as skb->protocol is not
> > set for xsk skbs. The pending "net: resolve uncommon partial checksums
> > at ingress" applies the same rule to virtio_net_hdr sources.
> >
> > A request on a frame that is itself an IP fragment is therefore
> > completed over that fragment alone, which is also all a device could
> > compute, so the reassembled datagram does not carry a valid transport
> > checksum. Before, if every fragment carried such a request, the
> > reassembled datagram stayed CHECKSUM_PARTIAL and was completed on
> > refragmentation; now conntrack marks it invalid.
> >
> > Skbs without a linear part (IFF_TX_SKB_NO_LINEAR, i.e. virtio_net) are
> > left unchanged: their data stays in the umem, where user space can
> > still modify it after any check, and they go to the device rather than
> > to the local stack.
> >
> > The problem was found with LLM-assisted code review.
> 
> AI;DR. Ask you agent to be terse, please.

Or better read it please.

> Also, please do a proper write
> down of how to test/reproduce. The slop in the cover is no fun to read.
> :-(
> 
> > @@ -1277,6 +1330,11 @@ static int __xsk_generic_xmit(struct sock *sk)
> >  			continue;
> >  		}
> >  
> > +		if (unlikely(xsk_skb_resolve_csum(skb))) {
> > +			xsk_drop_skb(skb);
> > +			continue;
> > +		}
> > +
> 
> Yes, we need to validate the csum offsets, similar to the virtio-net
> work MST is doing. Look what MST is doing in [1]. When that lands, move
> the helpers to ip.h as the TODO says, and use for XSK.

Yea now this is useful maybe I should add it directly there?
Or a patch on top is better after all?

The idea of a self-consistent small single patch died on the vine
at this point anyway...

Willem?


Anyway, pls post a patch on top of my series. I sent v5...

> 
> I *think* the IFF_TX_SKB_NO_LINEAR csum_partial scenario is OK, since
> we'll end up at a virtio device, but TBH I'm a bit skeptic about the
> whole reference to UMEM via an skb case...
> 
> 
> Björn
> 
> [1] 5de86f1afe1165a1a13ac4ef0615b19f4a10cb7a.1792565282.git.mst@redhat.com

