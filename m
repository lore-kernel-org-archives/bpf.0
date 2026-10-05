Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31C43783C8
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188085; cv=none; b=nJ4p4fHUYeqgotOUs46VkiX/cxjz0aCV5fRMY66LngdtBNrd59KIw/Ea/e4PvgWBQa+uCvCAWQAF4GzBez8rt0cooUQPliR4GcFBgeDT44duTcqyHsdrx6i5PWBSbrEcsnwIJEwWeaTw47kuSrFWKW683zAp0hDlRKSQTGJNp6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188085; c=relaxed/simple;
	bh=meaS8h7D68gc6KeY2ndo3A5Cb0GHOFfYlgjM6j/Z6So=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuhQfbMQKObTEEKVNATDB3u0+4orrM+94/2Fy3fvgfAuhD2KJEqEOm2IdWC+qSyCAGMC09jnHetUhrzvFuXWT/X90OSuldwnTHkXglpE91gwQ4y/RWdmfeaDCEkw2AkdNu1AM0gfzRcP0nrrp0veFneM1a3s02ynfVZ6EXuJUeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDEwNTc8; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDEwNTc8"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01d89b23so637768f8f.2
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 01:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791188082; x=1791792882; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lJtTXJS3lNxs6KeGf0mmSgOkxFqn8ISkKtP7HIHVmNI=;
        b=BDEwNTc8UbfNVpMfBRo2icrZbPfnvvBgGj9H1t6WZ7GqA67f3DHS+ZZyoIKyz5tSLQ
         hsWInC5rxX01B6sK/Sm11XW9mePZXW/DayS4q9sF3Otk+/GKA1UL3QuHyMeT49Ef7XjG
         X8FKILjOl+ct+JLA43f9jQjxwpHkdCNa2cpPqlirzFmLI31CHwFZzDWMFqD7tw87L+pR
         5QVbEI46z205ejfDNqeovrKwZYngnvmBvSsrKn5kD1iMH5Ai+VL3lsB51Lp64x8sUtA4
         gpGwhw16wfmjivvEHWKhetVHxet3AyWVqVuXqV7hHtIa06dpR1Ifov6HIkrZCzkdY7E4
         Mmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791188082; x=1791792882;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lJtTXJS3lNxs6KeGf0mmSgOkxFqn8ISkKtP7HIHVmNI=;
        b=vMWCOx9WqhIdRzONshnh5d87nzRr83fYIsO3sZ1juj6E1QZcrYBy63eBdvzYh6nsH0
         coydEjErMM9M4Dmf4z9lpwwg2gjrogj69aHHt5rlvEO1/igory6H8Vxy9OEMcEb3Thqb
         WMeGwc923EYCZz9YJqolGiqRlkBegp6WnIIGK7FpGb0GEucfPCynwIi+uB3tNFsPo9GQ
         CemuVYBlfIf+6eKjl14XaYa+olbgmLVUnkDwXe9cnYnZPPfD3cH2vzcULDx55zx5vR7c
         4Q0+mYf4UDUQ9D3/x3pccOhLynQEfZuzZG935O4lctGiXmn08RuX3lbK7RAJomkssfNA
         ALrQ==
X-Gm-Message-State: AFq9FYLNR6Zki5tc51neKjKaV2gcXzAjfIiV450X0iNlQUDOROJWbPy3
	QbvcxLnpuan2snHHp/97yOP8TCLJtfNBa08MVHFf2NwN7DFRkXeSNvbf
X-Gm-Gg: AYBFou3DOdWO8/BEIuF/vZOMnH6n4v4ycCt7xGuzwRG5dhDXcOATfK3HZREz+EQw8g5
	M18njqarjve6iw+aKyZa5yQ0YoocP0QhL35NgRGcIwmZhY88P/RYpLhI5PdtfsEmKT5fVzJkxK9
	erzNmCTWsaQFf88QCnW32IMH+GiIVBZcdQUKFzLrvItUoWeeVdql/mT+v6Mqg8+r5FUItALOEFE
	rl2JMOsbkf0o+xa70LiWHCEDYxgaif2eZReaXaCxP57HDtuUZ6GAIX4VZVy+wT+QfAeaYLs11L5
	kBof6uTE7UyPXw98tJOoJniFs4byMKV38WGZ4P4UE8oNAJyOADiuVO/WeYZrcql9znP2QyGnDSw
	AbDkVpS3eHH9gP/er+Lu8vDNkJgObt26NPbcUHGVD7YSPl8zFb0UPISg2+cWH50hLLoXruFedSq
	d84WGm6DxTXNDJMyYb6iewo8FUI52/Z48bLjAYSHPGKdQU+ggmuTkmA10b3LwOrbO1YkW8p2H7M
	XjybUXN9jmcWOpqWDUYQI1jO3CrkI798hc=
X-Received: by 2002:a05:6000:25e5:b0:487:15a3:1cab with SMTP id ffacd0b85a97d-48b1270ff98mr16251747f8f.18.1791188081951;
        Mon, 05 Oct 2026 01:14:41 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622bb172sm4106826f8f.42.2026.10.05.01.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 01:14:41 -0700 (PDT)
Date: Mon, 5 Oct 2026 09:14:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@google.com>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 0/2] octeontx2: mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <20261005091440.575f0eea@pumpkin>
In-Reply-To: <asMSSdIK6WBECcs_@rkannoth-OptiPlex-7090>
References: <20260929022915.2704627-1-rkannoth@marvell.com>
	<20261002103752.006a7648@pumpkin>
	<asMSSdIK6WBECcs_@rkannoth-OptiPlex-7090>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 08:28:17 +0530
Ratheesh Kannoth <rkannoth@marvell.com> wrote:

> On 2026-10-02 at 15:07:52, David Laight (david.laight.linux@gmail.com) wrote:
> > > Patch 1 converts PF/VF and representor flag access to atomic bitops.
> > > Patch 2 depends on it for safe OTX2_FLAG_INTF_DOWN and OTX2_FLAG_PORT_UP
> > > updates on asynchronous mbox paths and during the mqprio netdev bounce.  
> >
> > Can't you just move those two flags to a separate structure member?
> > In at least one place the code separately clears one and sets the other.
> > That makes me think it should a a three-valued state not two bits.
> >
> > That would save all the expensive locked operations.  
> 
> Thanks for your review.
> 
> I agree that atomizing the entire flags bitmap is broader than strictly required for the
> mqprio/mbox concurrency: the cross-CPU hazard is otx2_sync_flags_from_rep() doing a non-atomic
> read-modify-write on nic->flags while other CPUs update bits in the same word. Relocating
> OTX2_FLAG_INTF_DOWN and OTX2_FLAG_PORT_UP (or restricting rep sync so it cannot clobber those
> bits) would be a narrower approach than converting every OTX2_FLAG_* accessor to
> set_bit()/clear_bit().
> 
> On the three-valued model: INTF_DOWN and PORT_UP are not a single FSM in the driver today.
> INTF_DOWN reflects netdev teardown and is consulted from NAPI completion etc.
> PORT_UP is set and cleared from rep RVU_EVENT_PORT_STATE in the mbox up-handler and
> suppresses a duplicate carrier/queue bring-up in otx2_handle_link_event() when rep has already
> applied port state. Combinations such as INTF_DOWN set after otx2_stop() while PORT_UP remains
> set are deliberate, so folding the two bits into one enum would need a seperate work
> and review beyond this series.
> 
> please note that this restructuring feels somewhat orthogonal to the goals of the
> current series. Patch 1 focuses on replacing the non-atomic |=/&=~ operations on the
> stop/open and mbox paths with atomic bitops for INTF_DOWN/PORT_UP, which patch 2's netdev
> bounce depends on. The rep-flag sync behavior in otx2_sync_flags_from_rep() is a related but
> separate concern, and I'd prefer to address the lifecycle-bit layout and sync logic in a
> dedicated follow-up rather than expand the scope of this patch series.

Right, but the atomic updates are are far more expensive than the non-atomic ones.
They really are best avoided unless you really need to change/test multiple bits
or need to limit the size of the data area.
The patch is likely to be smaller if you remove the UP/DOWN bits from the bitmap
since it will change far less code.

David
 
> 
> >  

