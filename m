Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0693F30BF68
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315509; cv=none; b=RmYj5ponL9LQlkPXaBd+QHtMeSBwCDkZzMO1TK2ExLtuaJYESJNcVtKvGEpv8ZxOcnzGMSS7v8zSuxHHjrvPVtFoR0TQVVshMxGbTaM+rtldAwp+ifRvttCWGdQ6XAk+Xat3TnGR+0ctPP82mb5MG72JmBcPZ8Yn7v2khSZBTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315509; c=relaxed/simple;
	bh=jMQMrzTbpWoy7qpTtCXjVhtjJmgz81CeZ3D3zItZ9+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVgcPe2ZWoOseqEvPwtf51uERQJekfi0A11XN4XY4RzpXTUVijpXcj27N6BIol17BqRUFQpCQGdwWMMUHRcXI76ZyUsrXnjzz7oQZOeQ1l0IOJNNkqwI0s3GqqRvtuXuWMpR3swDWTqasPlcQQ2WrKH1qvZpaGOFEZGFXpch9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjTFPpK7; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjTFPpK7"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so1473240a91.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782315507; x=1782920307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m7clZiyk0OMH0b3QigtKufFqqXyOmFKPxCwbw/xgdsM=;
        b=XjTFPpK7vXbY+OUV01tCzO23vHIyZAfrmUS4rnp13/dy/6Zl+doCiAotAJhGstxheF
         92Uzv50TZaTv7ouvyKi1p9InndEYZSLrZt8O83biCyzp69yOQ94naHRjBxCyY6cIV5nz
         zAvCduRyXgfTpX4isF+OA2tCldxR6t6l8LsP/Q1yevf4rAMvL2muKh9quYHYDQIAWOcs
         lE0jRxcssk3KwWTk0qIkd821wtqC6MExVHHYsoAxUYECQvrQI6cl5kq9iYwBdkXxcU80
         o5UNLHwCvzLW9RIb4SYSiuOCtXVEN3wA1G3JSenPCL4SPgw/255Ey8Ygc8i5iqYU9SHL
         dNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782315507; x=1782920307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7clZiyk0OMH0b3QigtKufFqqXyOmFKPxCwbw/xgdsM=;
        b=ZhYAJ4j5PbwLy5Rjz8tGTkoJaxnzfpfcuV0kzm0jRrZRWknQK3G5maJD+XnkhZYRz6
         aIfCCcLtXJoCq3omRkw9E6/cxVcDFteyM064D4fedYdmf+8kSCTNVQQJwYJxx5jVsAEC
         /f2H8drNKOMt4YwPggJRkdUJN5wtiXF7p4R1CU07VHxP3D0AlRem+/1BjZudiDQWujA4
         Xmm5y4wTWqa3eZW4Wa+goz+xC3BkqWpIIzyu8vCqUD1qVmqgpVcoDiPap2Udgn4S9+bP
         8o36Klhrfdolw9nBe4qCtn21wqDlF2K9lURUZ2JlXMkcTdQGZflzBHsSRwEUazDctseO
         F0TA==
X-Forwarded-Encrypted: i=1; AHgh+RoGv4Gnmgd+D9C5PvjwJRfaBg6xVDQJKDftGKApTNZy7UAh65sIcVGKlS4OulKv7aplXF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7fX38wKAEI3SFtgJHzlty8Hf2vQ8nk6NJGmtlxVUMvIb9b49f
	nSUlRkyEnkfIViY+wTa3+iYOz9sRY6ioqAIahX0Hp1IyKnDRPpR5oYOo
X-Gm-Gg: AfdE7cnySalNLxAexqI2i2fQzm4H/8vhMYJ6iA9MdoQwiw4iYKyU1NVb9NM1yQ42DXl
	yK/s3Z7ifBNgXcC6H3M7M7tjHTP0hgzuYfKrMCzkL4S8SU+JbkWvtvPt+PLT+aL24ASYKVLDTqz
	zLQSgpBVlE+i+OZt9j/bjT4V2TVhoGmQqpBzHzgutfUHVHyNgYy0WyJcRqxb/Fgmrrb24l1gMHX
	c34r0g+Kanf5tzi8GAHUU3zki586ei3HdpLFmUYGymZQHpETsiHBZTRMayazD3d61W9iblmCPRv
	J4UQgKYEeJXmwhZQpkpUu0sT40aQJxCBoK3hgwEo03PNWTUSe4Rx6D0buoqDyJ0ZJZOKa22RQKJ
	HtDRYc2i63WIp7phYjp+UFyyz+yosAZXMGK8xT60FDrRIr/IhIN2douOT6O212G4NZ+qtvGg7oX
	DRlfieE8gjxCFdqxDe
X-Received: by 2002:a17:90b:44:b0:36a:5d1f:7ac with SMTP id 98e67ed59e1d1-37de429f053mr4028561a91.3.1782315506896;
        Wed, 24 Jun 2026 08:38:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df39db8dfsm26648a91.2.2026.06.24.08.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 08:38:25 -0700 (PDT)
Date: Wed, 24 Jun 2026 08:38:20 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kerneljasonxing@gmail.com, bjorn@kernel.org
Subject: Re: [PATCH net 0/7] xsk: fix AF_XDP multi-buffer Tx descriptor
 reclaim
Message-ID: <ajv23_r4M3FGrFNN@devvm7509.cco0.facebook.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>

On 06/23, Maciej Fijalkowski wrote:
> Hi,
> 
> This series fixes several AF_XDP multi-buffer Tx paths where descriptors
> consumed from the Tx ring are not consistently returned to userspace
> through the completion ring when the packet is later dropped as invalid.
> 
> The affected cases are invalid or oversized multi-buffer Tx packets in
> both the generic and zero-copy paths. In these cases, the kernel can
> consume one or more Tx descriptors while building or validating a
> multi-buffer packet, then drop the packet before it reaches the device.
> Userspace still owns the UMEM buffers only after the corresponding
> addresses are returned through the CQ. Missing completions therefore
> make userspace lose track of those buffers.
> 
> The generic path fixes cover three related cases:
> * partially built multi-buffer skbs dropped by xsk_drop_skb();
>   continuation descriptors left in the Tx ring after xsk_build_skb()
>   reports overflow;
> * invalid descriptors encountered in the middle of a multi-buffer
>   packet, including the offending invalid descriptor itself.
> 
> The zero-copy path is handled separately. The batched Tx parser now
> distinguishes descriptors that can be passed to the driver from
> descriptors that are consumed only because they belong to an invalid
> multi-buffer packet. Reclaim-only descriptors are written to the CQ
> address area and published in completion order, after any earlier
> driver-visible Tx descriptors.
> 
> The ZC batching path can also retain drain state when userspace has not
> yet provided the end of an invalid multi-buffer packet. To keep this
> state local to the singular batched path, the series prevents a second
> Tx socket from joining the same pool while such drain state exists.
> During the singular-to-shared transition, Tx batching is gated,
> pre-existing readers are waited out, and bind fails with -EAGAIN if the
> existing socket still has pending drain state. This avoids adding
> multi-buffer drain handling to the shared-UMEM fallback path.
> 
> The last two patches update xskxceiver so the tests account invalid
> multi-buffer Tx packets as descriptors that must be reclaimed, while
> still not expecting those invalid packets on the Rx side.
> 
> This is a follow-up to Jason's changes [0] which were addressing generic
> xmit only and this set allows me to pass full xskxceiver test suite run
> against ice driver.

There is a fair amount of feedback from sashiko already :-( So the meta
question from me is: is it time to scrap our current approach where
we parse descriptor by descriptor? (and maintain half-baked skb and
half-consumed descriptor queues)

Should we:

1. do desc[MAX_SKB_FRAGS] and xskq_cons_peek_desc until we exhaust
PKT_CONT (if the last packet has PKT_CONT, return EOVERFLOW to userspace
and do a full stop here)
2. now that we really know the number of valid descriptors -> reserve
the cq space (if not -> EAGAIN)
3. pre-allocate everything here (if at any point we have ENOMEM -> cleanup
locally, don't ever create semi-initialized skb)
4. construct the skb
5. xmit

If at any point there is an issue, the cleanup is straightforward. That
whole xk->skb goes away, no state between syscalls. Thoughts?
