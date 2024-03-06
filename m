Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50021BC3E
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709703153; cv=none; b=MHcSfL/+1YVsoxGk3p66DcYgPIt7FCs3y06XRA3vcCyMnhLtWHyus8tAvzOW4vie4gXd/2J/ArU1Be1iSl8CHjd+YoUIGFfq98XK23z+U+ss93QYjqeQJCrS8viYVg3KhMvstkLCqg/EQu0YrXRYSsaJdEZ1BZL5y4lKEseHzWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709703153; c=relaxed/simple;
	bh=TU6enkAGhxLVo9zYShsbcBwAQaBFKNnqNn+vF6qWndE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvlvZvaCO45dIKHOdt0WmEmckDbHmdm5SX7GjUMnT5Ogv8eK2x0auhjE5Hk1fPh4Q2uzqZjvMNpPVVonrKalsM3klqTEkWE87vOziQ/VYrY3PlSfryM5A8PSrlSeFPmnrl1LXhszFbrgU9sHRqziWOs0jtrSAbiHdN45eARqd38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdnN1E3+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdnN1E3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709703150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TU6enkAGhxLVo9zYShsbcBwAQaBFKNnqNn+vF6qWndE=;
	b=PdnN1E3+KecPnHIRxnxwLmahV4XhMPOqtLFZIiSgKT3snZURcCEuxrePFvONz4u6LGBE1Z
	Dxh5thasLVyPKdtQN/euWHHlInP7Q39L2slpTMLaN67/d2rHqQl43Ed0QL3sJQz0T+od49
	Xgvmx1aDWiaBLWzRStKbEbIHRewwh3g=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-KmwHsCMIPQuP2UeBKuGmdQ-1; Wed, 06 Mar 2024 00:32:27 -0500
X-MC-Unique: KmwHsCMIPQuP2UeBKuGmdQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1dccd2efdbfso64222345ad.2
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 21:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709703146; x=1710307946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TU6enkAGhxLVo9zYShsbcBwAQaBFKNnqNn+vF6qWndE=;
        b=arshWLgbmDvgW9o9W07xmB3r6A8MEz/SQ3tw1i+8eSI1Jh7AdL1KlN1P4U+91LRXJJ
         czC5HHYWzwgSoPqcSV6L8NofOQ0pYCQu2eidEvyXnm0VF3H/GtbG/SxignvTz8NBu+Kp
         uSxzdw+RCWwIHOpfIiTtp7I7TcyoGnyGlGGsCK23ny1Ts5yvo9NQ1ajUwTKqFmC6yRzo
         H6K8NMcYGu93s/jNksgx04OdtwrZifhR4bmVQejSI/2svAQGDb2zkkh9JpviYLuzPX7n
         uiqINrxNQ8vnqET/gpLsWKtj02vtLZds7hT1PLDM1yareMjXpYZID+a32rqgKs9Olmbd
         QzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUUncoPJOSc2aIJWdCQIRTNHnv2GptCBsfHMHuiLjPbr539EMhEc+UmLT6PTxLV3AnIgazmU5lSovRoea62hTgQpm3
X-Gm-Message-State: AOJu0YyiXOb129RvbDQCiyMqKzh9K4L5IpOX9cmVVN7oIqNfahcFeZP+
	zPxSsynjTQ30u/VBCOAUtEaaYIEj1CEWPDG6IWL6ZJCmokQDr6d6p8ds5qTLjfzLHKJi8lm0TjW
	EaQhw5lCVJKg407kzI43hKTQNvYLNGeAOhCsdiG3+2L+M2rOP4QWnr2iFiQ04JfytLC1+axGQVk
	DGRSy6ugShFyS6pPz0fWV0k2BV
X-Received: by 2002:a17:90a:d24f:b0:29a:e097:50be with SMTP id o15-20020a17090ad24f00b0029ae09750bemr11686566pjw.31.1709703146440;
        Tue, 05 Mar 2024 21:32:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFevY310UVbmpQFlUk/kqBWvaY92fb2a59CmZ2Hx22y1HnOSHWpHQhrAOQOaJV/YvhnP8j2q2riF5z5dzcbMWs=
X-Received: by 2002:a17:90a:d24f:b0:29a:e097:50be with SMTP id
 o15-20020a17090ad24f00b0029ae09750bemr11686548pjw.31.1709703146152; Tue, 05
 Mar 2024 21:32:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709118356-133960-1-git-send-email-wangyunjian@huawei.com>
 <ZeHiBm/frFvioIIt@boxer> <65e2212e66769_158220294f@willemb.c.googlers.com.notmuch>
In-Reply-To: <65e2212e66769_158220294f@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 6 Mar 2024 13:32:14 +0800
Message-ID: <CACGkMEsd4icR3EDHS-4DjmKMeez41r2SnNP4j70gAdzq8O=w=w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Yunjian Wang <wangyunjian@huawei.com>, mst@redhat.com, 
	kuba@kernel.org, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, xudingke@huawei.com, liwei395@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 2:40=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Maciej Fijalkowski wrote:
> > On Wed, Feb 28, 2024 at 07:05:56PM +0800, Yunjian Wang wrote:
> > > This patch set allows TUN to support the AF_XDP Tx zero-copy feature,
> > > which can significantly reduce CPU utilization for XDP programs.
> >
> > Why no Rx ZC support though? What will happen if I try rxdrop xdpsock
> > against tun with this patch? You clearly allow for that.
>
> This is AF_XDP receive zerocopy, right?
>
> The naming is always confusing with tun, but even though from a tun
> PoV this happens on ndo_start_xmit, it is the AF_XDP equivalent to
> tun_put_user.
>
> So the implementation is more like other device's Rx ZC.
>
> I would have preferred that name, but I think Jason asked for this
> and given tun's weird status, there is something bo said for either.
>

From the the view of the AF_XDP userspace program, it's the TX path,
and as you said it happens on the TUN xmit path as well. When using
with a VM, it's the RX path.

So TX seems better.

Thanks

