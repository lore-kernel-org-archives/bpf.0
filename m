Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6B3261B71
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770965760; cv=none; b=T9fgjzcez8E5+N1Nrmh+5tqqg7KUOfQPblK1p/2Zjznz27w5ajDVCGc25iQSaSw6qajaH0vL7f/AIUf2iexHIRUepRLQ+2hEmkVUonhfqgNJwVw40Bma3K3rAE3Edn3kQWjFhKhTqPeLerNHqH8UFZWZtDtdK4FcMi9Q/BfOmlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770965760; c=relaxed/simple;
	bh=vJz1YZIsrkWRgT3a+32wzuiXm4tMPz5zEmaZG9RxIA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1dz+VLnyyY+VV6viRna2z9Rkqhwy3CUBr5vWxNnuD/i7x0wqMGlQNtgPpIKShSZzO8nSMWAccJA44Kywsk7qTeEoL/8tUNk0b8ijKpMec0qYt8S+DgM/jGeO237YSmWcwHDke6tWZMzAsr2BlqOb0fvOJEyLWGGk5yddpDUo/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejQPTL8C; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejQPTL8C"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b86ce04c5cso1231758eec.1
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 22:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770965758; x=1771570558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WFllcNF1m/veazpXfhkGge2XTmCfSEav8feNbAw2Nvs=;
        b=ejQPTL8C1fNepUA0c6nQ9L793kLsIGNb+/5Ht79t/m3+8AE+e9zSDWqr//P1lqK7M8
         afOH2950zyb9N53MDy/Zziwztf02Y956pAPc59QxE21c2Qrgw/vJYHjraUfK48yC7cwe
         FaA3a4beLAjYvvmA3BG6sze78u3vImtQJT+TeMmxRK7fAqlXNpD1dIqPTr1k62oPXpTW
         IJYCY/3Gcw95FGi2nAw0ueiuGzeHRUzKHZdLI9YddArKmplX0EKbDAocFHO8rbb/nFaJ
         3D7KdoZuQ+vynOJ7HDHAsS1bkTcSzRupDqlelajHSPbhVDa0EBJNsGTblsaGd3r8DWjN
         1XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770965758; x=1771570558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFllcNF1m/veazpXfhkGge2XTmCfSEav8feNbAw2Nvs=;
        b=qqjblU/N+0AebAU6CcatXrnEOXWgvE1DQtKP0ftaXLmxB5hKLISG9IRA1svUP3gcAD
         HdHpe4ssZxNPI5dL1jmDr5PTETNsLErkR7pkbMIg0HD8VGn+0uewbao1pfCr2sYSP6ij
         Z5NOkasuzjtQws2xJBLHFjTu6pjpBDgn2Ho7SZJlvudFUkN21+SSv1nUXxHR9IOdGUf8
         6yCzV1KLPJQyHbIpAfl2i8ZBrj16VHcQvVlts5l/mGOqYJ0yiibHXi9sif/Zd0Tb5JEY
         3BPCT2NIUsqHgvvKSEDqZkL5YHGu4K0Vn/EuXFuzLmD/Z+7uCEGSd0Z2CybqmKbqFe+E
         B9/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIYxq9j88hwIrgF292bRyQEq6NnnldLdGvXkIYpz89UkFqDlY6B8eEzyYd6lBrQtHijT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkCsV098UbDhamsDBjKCzCQ4S0Rkj04TrGikgyK9mGja+2+xUs
	/vPVvxE0GJbagzKZ8EQgendZBWO41aGlyF5sysUTypJSnhaMOJWSjWKxSnzp
X-Gm-Gg: AZuq6aLlX5EJp8HsxQwjytA5dUEgoTVubPC2V0pP3/KRxiJpFTlBR+ECnMzCzDxaAH3
	Lu5Ku+x8Ov3FKrpAblam6xZbeQNxG03w4BLXOnQAYzncDkNfek+7IRpxMTAXCVE5kbbRBanMzGv
	8PYCMIfQ9GP6YzoZhOy4IwdITChfh8RalbaZWHYoprWjuGPEUS24MEJPnwYE5EmrKJDKAWyoxoQ
	eFN0hoEQ+h4lX1MT0NFsRVcexEEXwUk9sSLim+xX5ZMvUMKsZBn7fnP7VShimCNbl+XKOm29r0C
	Ygqx3VACKZKrkmcgqwvc6WnPTXjUVd5KleKQdbqwl/2MLzOtiC/7QOS6io9zjRq7TOTwsc7y6Kb
	xayr8OwK0pxmIYgIA81wb5Mkq2Yhhv+aO3FfjZUsdcuKxRr2ePkYu0DibjYX4oroRbGEk/4hUhA
	LSmg2lUByspERqOGTg0WZAB0btu0tY/8cAwZ2fp2rvW83jhHznhxBUuHV2jRBYKy7YmxDvToINr
	sg3Eb0TNnBM7EajTQ==
X-Received: by 2002:a05:7301:2f99:b0:2ba:7033:533b with SMTP id 5a478bee46e88-2babc47ff16mr240332eec.32.1770959815327;
        Thu, 12 Feb 2026 21:16:55 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dbe123asm5764986eec.13.2026.02.12.21.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 21:16:54 -0800 (PST)
Date: Thu, 12 Feb 2026 21:16:54 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aY6zxmRcBSt4ju86@mini-arch>
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
 <20250925-bpf-xdp-meta-rxcksum-v2-1-6b3fe987ce91@kernel.org>
 <aNYUqdaIJV1cvFCb@mini-arch>
 <e03d6d69-73ea-46dc-b632-149ef5831f85@kernel.org>
 <aNcZdfCivLR2slFw@mini-arch>
 <aYtqKfv0F0l2-hgy@lore-desk>
 <aY0zd4Esewxa-8hw@mini-arch>
 <aY4FB_Gf31V-VYiF@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aY4FB_Gf31V-VYiF@lore-desk>

On 02/12, Lorenzo Bianconi wrote:
> > On 02/10, Lorenzo Bianconi wrote:
> > > > On 09/26, Jesper Dangaard Brouer wrote:
> > > > > 
> > > > > 
> > > > > On 26/09/2025 06.20, Stanislav Fomichev wrote:
> > > > > > On 09/25, Lorenzo Bianconi wrote:
> > > > > > > Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> > > > > > > checksum will be use by devices capable of exposing receive checksum
> > > > > > > result via bpf_xdp_metadata_rx_checksum().
> > > > > > > Moreover, introduce xmo_rx_checksum netdev callback in order allow the
> > > > > > > eBPF program bounded to the device to retrieve the RX checksum result
> > > > > > > computed by the hw NIC.
> > > > > > > 
> > > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > > ---
> > > > > > >   Documentation/netlink/specs/netdev.yaml |  5 +++++
> > > > > > >   include/net/xdp.h                       | 14 ++++++++++++++
> > > > > > >   net/core/xdp.c                          | 29 +++++++++++++++++++++++++++++
> > > > > > >   3 files changed, 48 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > > > > > > index e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd..00699bf4a7fdb67c6b9ee3548098b0c933fd39a4 100644
> > > > > > > --- a/Documentation/netlink/specs/netdev.yaml
> > > > > > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > > > > > @@ -61,6 +61,11 @@ definitions:
> > > > > > >           doc: |
> > > > > > >             Device is capable of exposing receive packet VLAN tag via
> > > > > > >             bpf_xdp_metadata_rx_vlan_tag().
> > > > > > > +      -
> > > > > > > +        name: checksum
> > > > > > > +        doc: |
> > > > > > > +          Device is capable of exposing receive checksum result via
> > > > > > > +          bpf_xdp_metadata_rx_checksum().
> > > > > > >     -
> > > > > > >       type: flags
> > > > > > >       name: xsk-flags
> > > > > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > > > > index aa742f413c358575396530879af4570dc3fc18de..9ab9ac10ae2074b70618a9d4f32544d8b9a30b63 100644
> > > > > > > --- a/include/net/xdp.h
> > > > > > > +++ b/include/net/xdp.h
> > > > > > > @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> > > > > > >   			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
> > > > > > >   			   bpf_xdp_metadata_rx_vlan_tag, \
> > > > > > >   			   xmo_rx_vlan_tag) \
> > > > > > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> > > > > > > +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> > > > > > > +			   bpf_xdp_metadata_rx_checksum, \
> > > > > > > +			   xmo_rx_checksum)
> > > > > > >   enum xdp_rx_metadata {
> > > > > > >   #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> > > > > > > @@ -643,12 +647,22 @@ enum xdp_rss_hash_type {
> > > > > > >   	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
> > > > > > >   };
> > > > > > > +enum xdp_checksum {
> > > > > > > +	XDP_CHECKSUM_NONE		= CHECKSUM_NONE,
> > > > > > > +	XDP_CHECKSUM_UNNECESSARY	= CHECKSUM_UNNECESSARY,
> > > > > > > +	XDP_CHECKSUM_COMPLETE		= CHECKSUM_COMPLETE,
> > > > > > > +	XDP_CHECKSUM_PARTIAL		= CHECKSUM_PARTIAL,
> > > > > > > +};
> > > > > > 
> > > > > > Btw, might be worth mentioning, awhile ago we had settled on a smaller set of
> > > > > > exposed types:
> > > > > > 
> > > > > > https://lore.kernel.org/netdev/20230811161509.19722-13-larysa.zaremba@intel.com/
> > > > > > 
> > > > > > Maybe go through the previous postings and check if the arguments are
> > > > > > still relevant? (or explain why we want more checksum now)
> > > > > 
> > > > > IHMO the linked proposal reduced the types too much.
> > > > 
> > > > IIRC, PARTIAL was removed because it's mostly (or only) a TX feature?
> > > > So no real need to expose it as an rx hint. And I think empty xdp_csum_status
> > > > in that proposal might have indicated NONE?
> > > 
> > > Sorry for the (very) late reply. According to [0] CHECKSUM_PARTIAL can be used
> > > even on Rx side, right?
> > 
> > So is this for virtio (which I don't think you need)? Or something else?
> 
> I forgot to mention before CHECKSUM_PARTIAL is used for the veth use-case
> when the packet is coming from the networking stack.

But what do you do with that partial state in BPF? I doubt you're
calculating/verifying it? Can we treat/export it as NONE/UNNECESSARY for now?
