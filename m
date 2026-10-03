Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC3336885
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021395; cv=none; b=GwVtEPo8YXE8VifKw2mIJjc6FJf7Z7OJ81g033M/lVLr7M9uhsFHU7Rcq4Ax08JZaK7VwcSusz/+GGNC/ewzE2HEpSCMcA2R9dQiP6HcpGMfRQ5lfEkTl/AASb02p5PvUjbTwCei1y6Ri5e2oWIUc2i8mWZmDOq+3UIn/wMsm+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021395; c=relaxed/simple;
	bh=zvB+GmvA7E1buSEhhFQSNiQiS0Ky9ds8iZsA4bX14t4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bnewAGyEVlAHF0CcH67v+BT9XV9bVmz5fLezNjZeMuSEP0N0DOvw+KHvfNwtjdXPd3lG367OpGeDVwrrmcLPggsWpMp7KsaMgO+0SD3XJz+EGy/PDGeVf2Vt9GRfsKfPuKb4W/ERND9ueuuPutI+vuPn0Y6mz7y2AClzGv6Nx1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7Jwexww; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6sE7ezt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7Jwexww";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6sE7ezt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791021392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFiXTFcRpKSwbR4iF//D20N/Ft4ckAh6KBeG1mHiTBA=;
	b=i7Jwexww7amyCTkoYi0jIu66dckbwAm18A5XQDjg6ICKAu2OMZdoa739BPf5D35vt3hT3A
	pkZJbugshtaIfTuiVEQbyrtOBSy8r97tRHseqk3xMoSLjeH97a9PpEH4Iy6ep6RewfGX9f
	bQLeqf67cjO6uoW72j2QKD8Mlb5GkJI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-XPk22g1COCGeO7DI-6_BLw-1; Sat, 03 Oct 2026 05:56:30 -0400
X-MC-Unique: XPk22g1COCGeO7DI-6_BLw-1
X-Mimecast-MFC-AGG-ID: XPk22g1COCGeO7DI-6_BLw_1791021389
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a004b70f99so3815365e9.2
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 02:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791021389; x=1791626189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CFiXTFcRpKSwbR4iF//D20N/Ft4ckAh6KBeG1mHiTBA=;
        b=O6sE7eztvXPCqRKwBKDlYIZPzBuBo9f27Zx4xFVCLG+tXG12FkTKBQuLs7qjnWKpR1
         ImyO5J2B7Z6WDddQCxU1JZkVgDpR/U2XXolm8lcOSHdip3ejquV2dUFC62+zH/t5nAJV
         GF5kB+ggs7/wcOq88bob++G2Dljh2douPEINiN1dcUKQc3rhzT3z4z/iMm37rAJAZYD+
         O7tJd0O1l4sQPecCmV1AS7FUG/AHjrZ5aLhw9gw4OWPzlsHOuF5MRO0oRfMe346O1aLl
         ecf5j3ct8J6G07XmhjJ2RcMTrduc5dBpvckvcYwLGdrhj7F2loxhIwoF7HmyCHTIP3+Z
         0FAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021389; x=1791626189;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CFiXTFcRpKSwbR4iF//D20N/Ft4ckAh6KBeG1mHiTBA=;
        b=KCgP7nsPxAkpZI8qSQYh8YAVk8y8jNvBuucFeT7UU1O5Q8Pn7UGJpO4yVukLkDaoi4
         w3yAdjqHuPhuQmLXR3tib7BjJxV6F3cLJgdVcgrJ/Taf+aSaV7KfilRQHHr4/FiJE5Y6
         0qY7/I0mV1Ob2/JWbJe2GSMGwUsiyyGW0Bkpt38xCGwTSOY8yyejCEVDGV3EnNZvNYDa
         9yU67sEw5h+ebjsOrWxJPnSw642d8hA1xYyGZ7sF+X7RRQBKJ2E+iCZRmAwO9v+j7pHM
         RmCfjDbSb+sNePyRKrKAbuBwTv3xmfubrDEuBWAAdGyn+b+YZ79i/5Pn0nJOfO0iejfK
         853g==
X-Forwarded-Encrypted: i=1; AKwUvBwjqWXoztz6yG5JhsbtvjGotUOxrcXFfXE9ZEMUVSt+TUVlneN8eSztr+gThuxci6fuKEo=@vger.kernel.org
X-Gm-Message-State: AFuF++l3BXoKYbC8IuLeKjrlyxXQyLewR5qV57gNSD8UWWLjuUPgz7gi
	DPrV0/pjWy/arD+BbCCOCTsY9034n48aeOWvFNiP3+YN965oKlO+21dM5SXGt7id8UZhyAziNi7
	XDVVWOq678gZrt3vYZinAOLSPZFy8ojKDxZWvHjTS7JMTw0sxokfLVQ==
X-Gm-Gg: AYBFou12aJwLRngegZd2xcfePE8vfVJRuFc04zZlI8chlRwobj3NjyURW4eKR08SCqx
	8BAyrwrR89bD26BbLZVXE3uQagMlBiElA55qSkNMBADsPuWGp0c6cdCd7vGQ100xd5aXj14VnkV
	E/z0e78tA61wqbCUUJOjp0js8zLziWBIzeCDwcPfOWhRyH3SyGpRwuNoUNarBDO5eUBtN14RJD3
	UemXWdYBVaAIW7lkRQhnTWbCF2Pkdj0bedqa39l2I4ZqfIknTCGOuRSwUZB+gsK+SzAKZj4CG24
	+Kq955nKcZMhZolgR1wlPySR5Kk2ETV27SRhCBH8OdC2tOHCCzaAYEGjfQRqwYHgXbcdyS7ZEVj
	M69FYVmBc/Zvpe5NgYAcQbaYpx0/cbUlLgOcdRZ4=
X-Received: by 2002:a05:600c:3e07:b0:49f:fe39:5bc8 with SMTP id 5b1f17b1804b1-4a027585dfemr89018095e9.12.1791021389126;
        Sat, 03 Oct 2026 02:56:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3e07:b0:49f:fe39:5bc8 with SMTP id 5b1f17b1804b1-4a027585dfemr89017735e9.12.1791021388657;
        Sat, 03 Oct 2026 02:56:28 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0304407d2sm106558045e9.0.2026.10.03.02.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 02:56:28 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:56:23 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@osuosl.org, Petr Oros <poros@redhat.com>,
 netdev@vger.kernel.org
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Henry Tieman <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH iwl-net 10/10] ice: fix unsigned stat widths
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-11-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com> <20261002130752.2597259-11-poros@redhat.com>
Message-ID: <9235DF68-76D9-4B38-B8D9-BCFF3520E7D8@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 2, 2026 3:07:52 PM GMT+02:00, Petr Oros <poros@redhat=2Ecom> wro=
te:
>tx_restart, tx_busy, rx_buf_failed and rx_page_failed in struct ice_vsi
>are u32, but ice_update_vsi_ring_stats() fills them with sums of the
>64-bit per ring counters=2E The values are truncated and the ethtool
>statistics exported from them wrap at 2^32 while the ring counters keep
>counting=2E
>
>Make them u64 like tx_linearize next to them=2E
>
>i40e fixed the same truncation in commit 3b8428b84539 ("i40e: fix
>unsigned stat widths")=2E
>
>Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat=2Ecom>
>---
> drivers/net/ethernet/intel/ice/ice=2Eh | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice=2Eh b/drivers/net/etherne=
t/intel/ice/ice=2Eh
>index 6c596e5a315175=2E=2Ea985b81efbe2d6 100644
>--- a/drivers/net/ethernet/intel/ice/ice=2Eh
>+++ b/drivers/net/ethernet/intel/ice/ice=2Eh
>@@ -344,10 +344,10 @@ struct ice_vsi {
> 	u64 tx_linearize;
> 	DECLARE_BITMAP(state, ICE_VSI_STATE_NBITS);
> 	unsigned int current_netdev_flags;
>-	u32 tx_restart;
>-	u32 tx_busy;
>-	u32 rx_buf_failed;
>-	u32 rx_page_failed;
>+	u64 tx_restart;
>+	u64 tx_busy;
>+	u64 rx_buf_failed;
>+	u64 rx_page_failed;
> 	u16 num_q_vectors;
> 	/* tell if only dynamic irq allocation is allowed */
> 	bool irq_dyn_alloc;

Reviewed-by: Ivan Vecera <ivecera@redhat=2Ecom>

