Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DDA38BF6A
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104346; cv=none; b=oFU/JLu39IV6cp9VkXAgLgmwEgfqRCRksgq9SAGeWlp2+c+Z+J70INzjJsCMZXRsDXL7vDupw/7BbKzqSZcYIT3redL/ua81JfWF43n2AbMwJXoTH8V7eMFf/UAqed6LPYQpj3z11qgcOwOTinfOaLoiGVIFZDEv17TF8lIY2y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104346; c=relaxed/simple;
	bh=f+aSwlQd0H4yMA4ovXfX93LCkoOi83P327MTt5nGdKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keQ4LD4BtSTmCU+EzhEagMuBmvVBlQvZWRIeWmUrKeIu+VLjF3aymh+u0IMzGGV/FwqtazZev0hFEbIG6jWGM89La4KWkDrDXo3vMRp9/EaqYZw2qwbTB5NMqBpBeNF/z538ZM+rPNkrydreBm0kR5DaxLOVJN5+iUqiYwGjWuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQi3XJmN; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQi3XJmN"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc6207127aso25818975ad.1
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 01:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784104345; x=1784709145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AvK4rlZieqdDEX/C3RF2OhSiSp9tIt5loVtN+a7NID8=;
        b=CQi3XJmNJVCpuMwkWQVonmAV1b35uWn30IQUN7O0kT79rSNY5GtPxCW4mhSuUEbx+/
         pOZXE+X7vh4MQ3nBlnKUTBiBW3/AQXtQhD0i/oHj1mLoxlENbQ3+r/3XJYi2KmdMx93L
         9UMaNXySRfctfxF1qw5urrEMTcO3YjXpQDyujYQ9eSaw3DAolYEJb+7NB1lIJGTQcVhS
         lK1+D1RQ5zNq8K84sUo+dV4GWQgD2e3MC3mjx2BZinetJyucfuvqB9OtPzvOnLhRLPSF
         QQ1LrDTjDLPjGB7hsiLazEd63POzx8c9d25wmltiqNDbQNyiyx8GOvKN3VyumK0aAP0U
         FbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784104345; x=1784709145;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AvK4rlZieqdDEX/C3RF2OhSiSp9tIt5loVtN+a7NID8=;
        b=ilok+dvI9HNurlgXmRCDjUr9lZGF3aO/sSQH/crSm3Y5UQxcXZnIPsDzwDjNuO6ygH
         FEcPjIwBegpBB/BJvqE3V5hZ/dhd9MWG0bLSpHtxRQqXKmTJa8a6xPqlN1gdBYhmvCwh
         PPCETNYPvRAeAQR3K903YPr/cvZdqwXI41l03l2h5ysWObBI1snFjQIWjPrwhXsEwGtP
         8j93xGgAE59Hn3+ZrYIKckJV+tq5my7GJARHdvWGLnx9V+nv0jPXL0WV7NBLqzcjf1KM
         gQm334DnEFfmfGufKe04S3PCPH6dPxWxNjOjJDaQniwKZiUUs8/ZEXx09+eM1Qv2PJQU
         3Www==
X-Forwarded-Encrypted: i=1; AHgh+RreQzzwbUfFLZzuRCMYhLpfnN9trKH64Im7OKP0ABHelpLqrlxuz9e/RIy+/AzrdqBOsZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj3Kom3Fu4zV8t7zui11l2LmeW6RvIylLBBMK16UibSLV50nu+
	Vp4By41o7Z4R01owT+/qyYGdvryTASzLf2pSOUl4ax2vnJhVjDvHOxnf
X-Gm-Gg: AfdE7clCN8cz8JcfYvrxqd7YTqnkGHI6DFf6gUxdTRi3Fz4rgYd6uAJiS4t87e4Z8Do
	byGc9M/haVStqW0bJdUqtjWceWsnI3bnT7s+8lDRUNaTat+5Vddm7c/LyTGEYPicHBICjGY2O/n
	j4IULyowzPFekuj2oHFvm/92vza4E88Dw45XV9HDm3Qff89b51yFqWVoFOdmPAr4Pr5ErUWUS1w
	mdsjr8VaO6zCsZKCDe5TfF8yCVjSHwB6zd29r6MT7wuYmH1ettIAe2t86KCb175jyqJo8oHFMOV
	rgH25k/rcEqshgxBfjF8HO8IojTI5HAPBkbbJVKQ1wYMoea1id6C8rGQNgG7e7x/moSx9jQLO1n
	MZrAjlTi85i/b5H24Z/yD/8dvKEsRgtUND5TkjKvmJehonH+QZjnHXhncBnQpcOB8YT07K8m7iI
	+DxDWP
X-Received: by 2002:a17:902:d4c7:b0:2cc:6817:d9b1 with SMTP id d9443c01a7336-2cf03df6a24mr15483195ad.41.1784104344760;
        Wed, 15 Jul 2026 01:32:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb75fsm129307865ad.8.2026.07.15.01.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:32:24 -0700 (PDT)
Date: Wed, 15 Jul 2026 01:32:16 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Vladimir Vdovin <deliran@verdict.gg>, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/6] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aldE7W4T_ylUTLv5@devvm7509.cco0.facebook.com>
References: <20260708203410.45121-1-deliran@verdict.gg>
 <20260708203410.45121-2-deliran@verdict.gg>
 <alE8oBxkrak8n602@devvm7509.cco0.facebook.com>
 <alZtI782RGKb8y4Y@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alZtI782RGKb8y4Y@lore-desk>

On 07/14, Lorenzo Bianconi wrote:
> > On 07/08, Vladimir Vdovin wrote:
> > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > 
> > > Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> > > checksum will be use by devices capable of exposing receive checksum
> > > result via bpf_xdp_metadata_rx_checksum().
> > > Moreover, introduce xmo_rx_checksum netdev callback in order to allow
> > > the eBPF program bound to the device to retrieve the RX checksum result
> > > computed by the hw NIC and reported via DMA descriptors.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
> > > ---
> > >  Documentation/netlink/specs/netdev.yaml |  5 ++++
> > >  include/net/xdp.h                       | 18 ++++++++++++++
> > >  include/uapi/linux/netdev.h             |  3 +++
> > >  net/core/xdp.c                          | 32 +++++++++++++++++++++++++
> > >  tools/include/uapi/linux/netdev.h       |  3 +++
> > >  5 files changed, 61 insertions(+)
> > > 
> > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > > index 5f143da7458c..6d0d90d3a614 100644
> > > --- a/Documentation/netlink/specs/netdev.yaml
> > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > @@ -61,6 +61,11 @@ definitions:
> > >          doc: |
> > >            Device is capable of exposing receive packet VLAN tag via
> > >            bpf_xdp_metadata_rx_vlan_tag().
> > > +      -
> > > +        name: checksum
> > > +        doc: |
> > > +          Device is capable of exposing receive checksum result via
> > > +          bpf_xdp_metadata_rx_checksum().
> > >    -
> > >      type: flags
> > >      name: xsk-flags
> > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > index aa742f413c35..e255ff786131 100644
> > > --- a/include/net/xdp.h
> > > +++ b/include/net/xdp.h
> > > @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> > >  			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
> > >  			   bpf_xdp_metadata_rx_vlan_tag, \
> > >  			   xmo_rx_vlan_tag) \
> > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> > > +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> > > +			   bpf_xdp_metadata_rx_checksum, \
> > > +			   xmo_rx_checksum)
> > >  
> > >  enum xdp_rx_metadata {
> > >  #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> > > @@ -643,12 +647,26 @@ enum xdp_rss_hash_type {
> > >  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
> > >  };
> > 
> > [..]
> >  
> > > +/* Please note the driver is required to invalidate the checksum if the NIC
> > > + * reports CHECKSUM_UNNECESSARY or CHECKSUM_COMPLETE and the eBPF program
> > > + * modifies the packet since it can change some fields validated by the
> > > + * checksum.
> > > + */
> > 
> > Sorry, a bit confused about this part. IIUC this is in response to this
> > discussion https://lore.kernel.org/bpf/aaLYfWnuuf_ne72u@lore-desk/ ?
> > 
> > Looking at a few drivers:
> > - bnxt (bnxt_rx_pkt) does UNNECESSARY - ok
> > - mlx5 (mlx5e_handle_csum) does UNNECESSARY and skips COMPLETE if there is
> >   bpf prog attached
> > - fbnic (fbnic_rx_csum) - can do COMPLETE even with xdp attached?
> > - gve (gve_rx) - can do COMPLETE even with xdp attached?
> > 
> > So none of the drivers invalidate anything (and nether the bpf machinery), some
> > choose to (correctly?) not report COMPLETE when there is XDP. So was the
> > discussion about documenting this and giving some guidance? This probably
> > belongs to that `DOC: skb checksums` section of include/linux/skbuff.h?
> 
> Hi Stanislav,
> 
> re-reading the previous upstream discussion, I guess we should just document the
> expected driver behaviour (invalidate the cksum for both COMPLETE and
> UNNECESSARY cases when the XDP program running on the NIC returns XDP_PASS) and
> add a given kselftest for it. Agree?

Yes, let's have something a bit more detailed about how it works right now
vs the expectation.

By my point is: the comment in this patch also seems wrong? We do not seem
to invalidate the csum, we just disable COMPLETE when there is a xdp program
attached (or I'm missing something).
