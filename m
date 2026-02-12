Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E866C1531E8
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 03:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770867402; cv=none; b=F4SfBaoFEyt2297W1eeK6EkGfYeqVkM5heOAZp6MvpLLdUV1mfGUaqf02Au56Fh5QcwtaF2MfcmTma6pWCDNuHIRlLFtksKVbJPHazlF0MNmbLnz5YRgswv4ZYv+dYWk2xaRieK0QrcaJmy2XsSzO3cQbgb0uUNtqqvGk10dQyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770867402; c=relaxed/simple;
	bh=3/pFoT7VwY4XYxl8Pm0Zwg7Bm4NUYgI78VGG2y+61YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/GAjmdBqsLyIyUWCzgASTwxnT/OY4U21MGItg2SAcB0a9CailrpuyvxLEztEpysoaISyCT+Qa23rsCpjacR0mg+mziXubTVOJcL0Iv1TGzrS/+YGI14WJ2cUvKHq/F9B0kGLEDhjvVl4fALu7BuSthDzoWhhvDEojVe2lrt3Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ru6i5pMv; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ru6i5pMv"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d1872504cbso1392632a34.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 19:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770867400; x=1771472200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tK21a4JoivTAPugf5a0tgKET71snd9+E0xX3YsV0FIM=;
        b=Ru6i5pMvGCEfIoHg2O9nwPpCH/P6/fsuO2v8Z4Flyk/c6ngKX/EMJ4QTOohc1ifqBV
         1nQP0RAON558dbyP6UULLe0soDvQCDNZLzjWnwRwrEASPL0cf0kf8QMiC/1+4VY6EEvq
         zyUcP0D3dwqJYJR6oawGyLSFxX6MiohtwgyjPNy/2s3eayiGr9Mg7hGZ6pTgrXULrP7C
         P8oRuVq49mOW5P0vghAEYBnnJg0fBgCRNCkmSe74KsZPndBvl7XZerMZAAyCVHUWYZGQ
         6NxB8wi4OYBccO0KCOdni7Mp6FPwAdrrX/QmR3jetyLgTHUQj+Lr6Fgxa35uDYqzoOik
         YAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770867400; x=1771472200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tK21a4JoivTAPugf5a0tgKET71snd9+E0xX3YsV0FIM=;
        b=eYjfNOOxWG4+feXhWvF1ilZDR5rpEyslblb554cnRP+FMOCj1HTMNZwrkksDQu9Shk
         W5xqWR++DihSoN7/L9WqAIMJUmI61Qoya6Pp+fiDCxPe4LhDOAveyNyT0INb+6H+a8G8
         yUr+dKaa6ixlK+7XXkc2lcdyaURxb8hdD10i+JNOUYZSiai/j+sYQIPPkGS1iijIobje
         +W4aiETawnjyzKq5UeT3ZDMNlJCHWSzmq09il+Y7IEhVhGkJDSzS++OH5vT8lBfq+i1x
         Q2ucgQg/z3AwA30j/8NyA2QOUYUkLVRngQtOcn/HSGGyaGXgeD2UqBOUidI+Ay5kvNhy
         aKxA==
X-Forwarded-Encrypted: i=1; AJvYcCVz6Fs554QhgcrsWyY2mW0Uldc/5lm8n2/X+2d4Cw60a3kD6HGQ/G0KR48wNJB8ymrdRR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxAm9jQ9QjAMDq1oX2uePSW6nDKjvurSJ/8KkMKw/ZR23miK5Q
	KgQUAdkLYCwDIs5florR9WfNArgHZpoT1lSbOMCxgMs0z2FXFDQHGz+0w7Dq
X-Gm-Gg: AZuq6aLWRHAEBrFLBRlIJMa28bNxKQcNn6NAS+LxdOQxu1jOLXRgUyW3YsoPr2JdH6V
	V2e4w7vr2ZC3xLgZZdvERYUpiIuVuIb7dtQFcj92oxwiM8JanoV3ZFTS6GKGsO3sCE2YKPR1yY5
	3oki8Ll6WARN7ar9EkxKTCYhymHyTpUhDY1dQKaKOm/E63SL/s8PrgMaYllPlk/1DmP8oiQrsQm
	dil9lxFRwHb4O4XFOb/3CT8N93zlgUe6H1FuUMBJGyN6Al0XEolH/qulgFrH6GvlA8s+e6udHTl
	PaI7r/ErLvwSkN85guBmzcicDclYx1v8zHCzAhaicZ9k7k/7GgnCD16Bf8HXK9f1JDYNvLblzhW
	CKNYxo4IFDX8BjCFUWCm/8/LsX/iXrS6kseNd2vOVE35+BFKp0y+htzgExEw4vXrMULPDuHVZ6g
	/AkWarxrW18h/iP2UGPOvZFnenvqpO0G+hfkwiWpCbjfo0A4jSFSaAMGg+fz3i4dPvpbyXbUXPx
	O0A40DoxzGaO7XveWv70B2OHJYt
X-Received: by 2002:a05:7022:249f:b0:121:d898:edae with SMTP id a92af1059eb24-1272fd99529mr389245c88.24.1770861432625;
        Wed, 11 Feb 2026 17:57:12 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6e943fsm2870384c88.11.2026.02.11.17.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 17:57:12 -0800 (PST)
Date: Wed, 11 Feb 2026 17:57:11 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
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
Message-ID: <aY0zd4Esewxa-8hw@mini-arch>
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
 <20250925-bpf-xdp-meta-rxcksum-v2-1-6b3fe987ce91@kernel.org>
 <aNYUqdaIJV1cvFCb@mini-arch>
 <e03d6d69-73ea-46dc-b632-149ef5831f85@kernel.org>
 <aNcZdfCivLR2slFw@mini-arch>
 <aYtqKfv0F0l2-hgy@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYtqKfv0F0l2-hgy@lore-desk>

On 02/10, Lorenzo Bianconi wrote:
> > On 09/26, Jesper Dangaard Brouer wrote:
> > > 
> > > 
> > > On 26/09/2025 06.20, Stanislav Fomichev wrote:
> > > > On 09/25, Lorenzo Bianconi wrote:
> > > > > Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> > > > > checksum will be use by devices capable of exposing receive checksum
> > > > > result via bpf_xdp_metadata_rx_checksum().
> > > > > Moreover, introduce xmo_rx_checksum netdev callback in order allow the
> > > > > eBPF program bounded to the device to retrieve the RX checksum result
> > > > > computed by the hw NIC.
> > > > > 
> > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > ---
> > > > >   Documentation/netlink/specs/netdev.yaml |  5 +++++
> > > > >   include/net/xdp.h                       | 14 ++++++++++++++
> > > > >   net/core/xdp.c                          | 29 +++++++++++++++++++++++++++++
> > > > >   3 files changed, 48 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > > > > index e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd..00699bf4a7fdb67c6b9ee3548098b0c933fd39a4 100644
> > > > > --- a/Documentation/netlink/specs/netdev.yaml
> > > > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > > > @@ -61,6 +61,11 @@ definitions:
> > > > >           doc: |
> > > > >             Device is capable of exposing receive packet VLAN tag via
> > > > >             bpf_xdp_metadata_rx_vlan_tag().
> > > > > +      -
> > > > > +        name: checksum
> > > > > +        doc: |
> > > > > +          Device is capable of exposing receive checksum result via
> > > > > +          bpf_xdp_metadata_rx_checksum().
> > > > >     -
> > > > >       type: flags
> > > > >       name: xsk-flags
> > > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > > index aa742f413c358575396530879af4570dc3fc18de..9ab9ac10ae2074b70618a9d4f32544d8b9a30b63 100644
> > > > > --- a/include/net/xdp.h
> > > > > +++ b/include/net/xdp.h
> > > > > @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> > > > >   			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
> > > > >   			   bpf_xdp_metadata_rx_vlan_tag, \
> > > > >   			   xmo_rx_vlan_tag) \
> > > > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> > > > > +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> > > > > +			   bpf_xdp_metadata_rx_checksum, \
> > > > > +			   xmo_rx_checksum)
> > > > >   enum xdp_rx_metadata {
> > > > >   #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> > > > > @@ -643,12 +647,22 @@ enum xdp_rss_hash_type {
> > > > >   	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
> > > > >   };
> > > > > +enum xdp_checksum {
> > > > > +	XDP_CHECKSUM_NONE		= CHECKSUM_NONE,
> > > > > +	XDP_CHECKSUM_UNNECESSARY	= CHECKSUM_UNNECESSARY,
> > > > > +	XDP_CHECKSUM_COMPLETE		= CHECKSUM_COMPLETE,
> > > > > +	XDP_CHECKSUM_PARTIAL		= CHECKSUM_PARTIAL,
> > > > > +};
> > > > 
> > > > Btw, might be worth mentioning, awhile ago we had settled on a smaller set of
> > > > exposed types:
> > > > 
> > > > https://lore.kernel.org/netdev/20230811161509.19722-13-larysa.zaremba@intel.com/
> > > > 
> > > > Maybe go through the previous postings and check if the arguments are
> > > > still relevant? (or explain why we want more checksum now)
> > > 
> > > IHMO the linked proposal reduced the types too much.
> > 
> > IIRC, PARTIAL was removed because it's mostly (or only) a TX feature?
> > So no real need to expose it as an rx hint. And I think empty xdp_csum_status
> > in that proposal might have indicated NONE?
> 
> Sorry for the (very) late reply. According to [0] CHECKSUM_PARTIAL can be used
> even on Rx side, right?

So is this for virtio (which I don't think you need)? Or something else?
Can we start with the "easy" cases of UNNECESSARY/COMPLETE/NONE? I'm not even
sure we need to expose the csum_level (start with level=0 and handle
encap if/when there is a real usecase). With kfuncs we should be able to
change/extend the API when needed.

(for PARTIAL, not even sure what the BPF prog is supposed to do with it)
