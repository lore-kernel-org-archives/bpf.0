Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C4B3B775E
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293600; cv=none; b=RLfZuT93jfdrU5AFOQ31jecUApnBIAU2tde3pT6/aa4q1XZqMy2QqfK1/HPRgs5DufCzN/qF7SdRludagYU4/HwtFv8UUQ4FHuW4D8I2AzGOiQnFeEQ01mI2DCU8KWC2qA5Q7EqaVCBUdspaNoSSCsK9+14cVue5WieGwtKN/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293600; c=relaxed/simple;
	bh=zVTzcAhu2sh1noRCqYQ5+3ri+BgXa4QWy0Rkq9VVdAo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j3jpbH2cS9dz56Dazmsb5an/p2VEilUHLmPQaax7fykX7cYZKeF08uvuZCUljHqWVB3CBKzqQnJx+rEr/HXAyRmdar7id6BT6IDSqDzNd1UyyBP7RH2lcjPAAzTEjx2jjQSRzOWrO5XKsWN/+PmrO4CV5DGUwLjYtdpC3zXz7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IB3Ezxp4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzhYsAwN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IB3Ezxp4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzhYsAwN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782293589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oScmgVBAZdYqdklOiG9pSCq/MuJ7qIw0aEjZWIJM3Ks=;
	b=IB3Ezxp497OV0SOxfh+33MwswDQoRgitVx0RixvPp4nPgmb2azyAlBJhSifhUQeqWFcSvH
	2W5swbAMlIWzGnLhRVepYGeFreGZQQI6norbZ7parII3aInv24PykbcXSkxt019Na/z0vW
	rr8LRWf/f03ElcNcb+IZ48581/wZYVI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-7z9meUH1O-ixk6HAsUCAWw-1; Wed, 24 Jun 2026 05:33:08 -0400
X-MC-Unique: 7z9meUH1O-ixk6HAsUCAWw-1
X-Mimecast-MFC-AGG-ID: 7z9meUH1O-ixk6HAsUCAWw_1782293587
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490ace40f13so3295665e9.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782293587; x=1782898387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oScmgVBAZdYqdklOiG9pSCq/MuJ7qIw0aEjZWIJM3Ks=;
        b=AzhYsAwNr4C/fkY66dsoT2NUSL7zKlX9cXwHIWgOsiaBQPNybQ6R5nUSVR3LRk7vQa
         haW8mhIYq4ZBMR3voaLUosC1g3+LZ/NUd3RIsKEzexF0YeOvgsjr8t75DQFxpUflhHk0
         6XdqHGbu0BlgzY2+lFOJ4RE1GA/fz2jQNmxyPYUzVAegOemrytq0y+4R/Z6diV3+WRPc
         qFCIGv7k9G6OqLo0cjX/Fhaq/iXpemM4V8dQibKyH3QT8HBBCVFJb80uVAQVGn3rlBKi
         h5ab7TURLmAc2fYp0bC4l9KMDynhHVLaX5MbgWt2wUNbVH7hru35pe3uW70r8d3myQqV
         AT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782293587; x=1782898387;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oScmgVBAZdYqdklOiG9pSCq/MuJ7qIw0aEjZWIJM3Ks=;
        b=eAPy9sO+XMZP/c+z9ABty8kXZDsd8MI2AGI37+4S2eEMhNnJxm4eqR0Dahcup77HLR
         nFz2LN7alOKerci+JSscA3266UwgLcAm99e5rSo5eZxooiYeuj6m7kN8gYG7wmf0NHzZ
         NoV0jGKV02VFjyumho/0a7DV42f4tVNAA4lbOYElWgk4MO55cb05awFpToZ8dgMd93X9
         BxLCQTOXhw/o93MbDyIRS/btu9XsWgovCt3F3hi/6iplnJeU44pBfMJB+KzJzKMTM4/S
         MeHa7+MGfWv6grCA/LSlun+C/7L3ZnveM1eJm9/QS4+QsFyuYOcai+y1XKAKJ6N6z6hr
         YT6w==
X-Forwarded-Encrypted: i=1; AFNElJ9/zsK07im6OK9eVjaGSD/vDK8b5q5yNuJtxxhXhzOLZ35vUnCgjRf4XU06YLNuRL2O+Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGIzvh2ZOz15+XdCMtEifgAmcXbD+EYnPYwFLjiviuBGdxsIoU
	NHZtLoaF36sp7ZCDZP5zRqSyB44AwaZV8kmOLnyF7DPBEKNMRVDSFi0j1D1f5t7623vsCZuj162
	/qPgNDGxoYichoZcCr2vIFQN1x/fEehr5vjgQkiYNC2484aoJ9yuDoQ==
X-Gm-Gg: AfdE7cnsYltYj6ISqb5DPbwyNq9UutLaNA3kWaHc9C+8L2Ps7WGZDpH3XKGiZZ0XwXG
	cJxXQSjJqQyTroU+qQ8R4E+qKtX1JcS2ovVcoTYXdGcEzbX0YM0SZ86O9n8LZk2hpSQsGB1SUbi
	Jd8QNOXlBPdwXQ5Djm9aivQ/gj02LVl+6RTlXvRgzvzhBXj7XYVZBMbs4wHmplW7P2T4OVkCcv0
	Voh4lldCFyQNBmwpzBGI/0ne/9hFfdCdFV1RQIUpfW4+S77xfmOjZn5dwfjWqCui9O7ywGbWki5
	zRi+kxegdrVC6KIdQvM+HS2utJDG7iW1yvbjne83/eaRhQvS5XXvAF/9ECjmQFJkVlDcnzo9fWi
	mtNjt4v0BbXQdD7Du6ZfHevyLWbQ3eoCQMN4=
X-Received: by 2002:a05:600c:a012:b0:492:2e1c:1d19 with SMTP id 5b1f17b1804b1-49260875bbamr34892845e9.31.1782293586992;
        Wed, 24 Jun 2026 02:33:06 -0700 (PDT)
X-Received: by 2002:a05:600c:a012:b0:492:2e1c:1d19 with SMTP id 5b1f17b1804b1-49260875bbamr34892125e9.31.1782293586482;
        Wed, 24 Jun 2026 02:33:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49261063d6esm26451795e9.2.2026.06.24.02.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:33:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 42FAF808FBD; Wed, 24 Jun 2026 11:33:04 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dsahern@kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <20260624030530.3342884-2-avinash.duduskar@gmail.com>
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-2-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 24 Jun 2026 11:33:04 +0200
Message-ID: <87pl1gcmgf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Avinash Duduskar <avinash.duduskar@gmail.com> writes:

> bpf_fib_lookup() returns the FIB-resolved egress ifindex straight
> from the fib result. When the egress is a VLAN device, the returned
> ifindex is the VLAN netdev's, which has no XDP xmit handler; XDP
> programs that want to forward the frame (e.g. xdp-forward) must
> instead target the underlying physical device and push the VLAN tag
> themselves. Today the program has no way to learn either the
> underlying ifindex or the VLAN tag without maintaining its own
> VLAN-to-ifindex map in userspace and refreshing it on netlink
> events.
>
> Add BPF_FIB_LOOKUP_VLAN. When the caller sets this flag and the fib
> result is a VLAN device whose immediate parent is a real (non-VLAN)
> device in the same network namespace, populate the existing output
> fields params->h_vlan_proto and params->h_vlan_TCI from the VLAN
> device and replace params->ifindex with the parent's ifindex.
> params->h_vlan_TCI carries the VID only, with PCP and DEI bits zero; a
> consumer wanting to set egress priority writes PCP itself.
> params->smac is the VLAN device's own address, which can differ from
> the parent's.
>
> Only the immediate parent is resolved, via vlan_dev_priv(dev)->real_dev
> and not vlan_dev_real_dev(), which walks to the bottom of a stack. When
> the immediate parent is not a real device in the same namespace, the
> lookup returns BPF_FIB_LKUP_RET_VLAN_FAILURE and leaves params->ifindex
> at the input. This covers a stacked VLAN (QinQ), where the immediate
> parent is itself a VLAN device and one h_vlan_proto/h_vlan_TCI pair
> cannot describe two tags, and a parent in another network namespace (a
> VLAN device can be moved while its parent stays), whose ifindex would
> be meaningless in the caller's namespace. A program that wants the VLAN
> device's own ifindex re-issues the lookup without BPF_FIB_LOOKUP_VLAN,
> so the unreducible case stays distinct from a physical egress. That
> distinction matters for XDP: a program cannot xmit on a VLAN device, so
> a success carrying the VLAN ifindex would make it redirect to a device
> with no ndo_xdp_xmit and drop the frame at xdp_do_flush(). The swap and
> the vlan fields are written only on the reduce path; other output
> fields keep their existing behaviour, so a frag-needed result still
> reports the route mtu in params->mtu_result.
>
> BPF_FIB_LOOKUP_VLAN is only useful to XDP, which cannot redirect to a
> VLAN device. A tc program can redirect to the VLAN device directly, so
> bpf_skb_fib_lookup() rejects the flag with -EINVAL; bpf_xdp_fib_lookup()
> accepts it. When the flag is not set, behaviour is unchanged:
> h_vlan_proto and h_vlan_TCI are zeroed and ifindex is left at the FIB
> result.
>
> The new block is compiled only under CONFIG_VLAN_8021Q since
> vlan_dev_priv() is not defined otherwise; without that config
> is_vlan_dev() is constant false and the flag is accepted but never
> acts. That is safe because no VLAN device can exist there, so every
> egress is already physical.
>
> This lets an XDP redirect target the physical device and learn the
> tag to push in a single lookup, which xdp-forward's optional VLAN
> mode (xdp-project/xdp-tools#504) wants from the kernel side.
>
> The helper's input semantics are unchanged; the reverse direction
> (supplying a tag as lookup input) is added in the following patch.
>
> Suggested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>

Yes, this is way nicer - thanks! One nit below, otherwise LGTM:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

[..]

> +	if (flags & BPF_FIB_LOOKUP_VLAN)
> +		return -EINVAL;
> +

This is fine, but we should probably reject the input flag as well in
the next patch (for symmetry).

-Toke

