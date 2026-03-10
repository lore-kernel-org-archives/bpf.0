Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8C23112C1
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108401; cv=none; b=IZbCFkD4gjLG6pU+e/wtPvK+0C7Xr2Vz4H8yS2yZ0a22O6yqc8mYgySXqS58RnPktrMxum6aWZFQoVob13p5ZKpI4ksdefVwTUn6UijaiWiUzlVkfIJSGAAAi/rYyOZZmCccggz4/y5gqkxvzCByW8Y5Uxvbk2teADn2RG0X20k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108401; c=relaxed/simple;
	bh=TTdpw+ZfrEr36ZVnmAy/7MfXfSaLw+69NkvcyoTi0LM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRAH4o6lHyzEyfOLGu2Ped+g6g6XcIBb8mrE2CAN885W8tFBDRmBA4isSYybqjipQRbTaXKzZiT3CO+KM2wbvmgtklWkSuwLbW+PJPfl0zIN9IXQ0+AGOA+zpgCa+LB5CIqiBxsM3ypMpU9oKTcGzueX6jC8p1UR4PhrGCrh4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZkmR1tbD; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZkmR1tbD"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-466f00535cfso1735136b6e.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 19:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773108399; x=1773713199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qppXRsV2V/FmRBwf00yJrZ1V5d8XLH+BfF9hDiyjOds=;
        b=ZkmR1tbD7JD/UAlbOXzkk2bZFL9mxsjqcFZmiwbLn39PylDC7ophl96ywfQJ3B5FAh
         bjmIq6dfD94ntBD9FFU2OOKta/A0aEGBrN6Gf+AQl1+1qYQeYuCsXc8gy4ecuOPfdOVA
         q1QEa/Ri4JXt0BQZBF5WvRzzBE6H+VJzj85rIVAj4yGGBfqIjKzGny4Cyz/0BWCc6KOy
         CnrzSeCvskK9fh2ZTGcVm/KnavWHAVGKhE5fhN2CQgJnMbvAsqNmpeKhIwzjeSzSKzno
         k5+ET5TrK3BdWPtumLckP7fnkuPRQ7JzQjKz+PdBTt4Qcnq3l57e7f034VTbMVRnY69B
         boQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773108399; x=1773713199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qppXRsV2V/FmRBwf00yJrZ1V5d8XLH+BfF9hDiyjOds=;
        b=gqPpOcpUu2wXdvo5+bhB31B4IVBInTGVurUiQEMlqbGND1i2Udk8Gu8KItrZs5XN60
         TKBvhYHTqJCYh705NTZieUkvE9wfSsIugqggJDlkrCd0mBxdERC3cHkppM9IFAOFz1ye
         LIjbXVDBQgk9KcfK1dysEsOFwkcmn/+3HTS355MUwR9EKV3DTeI6t02I1yzYfXXgSBaR
         1Fai+UXs82d2hY91PcVJHtaZ5DkPkaFzIQL1ToAuZiGtOcB3nWkHXax07Xoe6d+Bgkad
         krVwyd7ktnIb/GZ6Whi+4ChaGUKYqk6Y+pB/PjFqkbJJjl8hIuaqw9iz4/jglGCQ7CJm
         mxzw==
X-Forwarded-Encrypted: i=1; AJvYcCUBwkEOF55C3gqjoASgyjkNFOZ54+6G2yvC9Ah4TEeUznq5ry6Uqub2mOqdIfcbuF5yIFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6WhtPF7tQT12lpiM4IMfDV1LXxiEia2r45mtGwtL2C/1UTGyB
	yCYoRVDaEikFFsTXpQ/TjOWwPYVqksrsHEZ1qdyVWbEbG2TReQJyXKS9a3A28VD8IwY=
X-Gm-Gg: ATEYQzzF0JMjo88WermudhMyraAcSE+7+8J/3ruVvXk7QMkAcQZ/vmyE1uo+IRzbcY6
	TV3NlELQWA57yPU5VYNDq7SqUryM346M+IViSGQxgkbIBdbCm/MG7i5amfrmrYNfBiv7BHTjtkj
	WRF8pSMVxb0Qsgh789vFL64Jetg8z28JZvoOwnt/CVnbM9yCjKtFye5aDwIzUApfI3WN99SJqxd
	C8mV/4Ny7fZxeI7R5sIphgnknN6R9tzRLmLcUrzkot7gsEA0YiknDBYyR//0FwPG234RD0E8euf
	H6eRhiJNzugpQbNgFPtGheYN5EiXDBEf5HXY4lTKZBO7UqssWnJ27NUHGerL7vxLZWP1d5arcHn
	gOfgR0Hu6pi2l+aDoip/mrEr2n0eYgVFnUNrgf7cPibJ5NcqCJ66je5R64teqqyFeCNYAnO/79E
	iL5sHJHQ==
X-Received: by 2002:a05:6820:2910:b0:67b:b337:d426 with SMTP id 006d021491bc7-67bb337dca0mr3993811eaf.61.1773108398883;
        Mon, 09 Mar 2026 19:06:38 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac1:76c0:540::22e:5f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67babf360b8sm4341204eaf.2.2026.03.09.19.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 19:06:37 -0700 (PDT)
Date: Mon, 9 Mar 2026 21:06:34 -0500
From: Chris Arges <carges@cloudflare.com>
To: Joe Damato <joe@dama.to>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/5] bnxt_en: Add XDP RSS hash metadata
 support
Message-ID: <aa98qgA1AapbUCiW@20HS2G4>
References: <20260306230600.1628196-1-carges@cloudflare.com>
 <aa9rGglS62WGgSMk@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa9rGglS62WGgSMk@devvm20253.cco0.facebook.com>

On 2026-03-09 17:51:38, Joe Damato wrote:
> On Fri, Mar 06, 2026 at 05:00:15PM -0600, Chris J Arges wrote:
> > This series adds XDP RSS hash metadata extraction support for the bnxt_en
> > driver and includes selftests to validate the functionality. I was able
> > to test this on a BCM57414 NIC.
> > 
> > Note: I don't have hardware to test v3 completions at the moment.
> > 
> > Patches 1-3 implement the driver support:
> >   - Patch 1 adds bnxt_xdp_buff to wrap xdp_buff with
> >     pointers to the hardware RX completion descriptors and the
> >     completion type. This is similar to other driver implementations.
> >   - Patch 2 adds the xmo_rx_hash callback for CMP_TYPE_RX_L2_CMP completions.
> >   - Patch 3 adds handling for CMP_TYPE_RX_L2_V3_CMP completions
> > 
> > Patches 4-5 add selftest coverage:
> >   - Patch 4 refactors common BPF map helper functions out of the
> >     existing xdp.py selftest into a shared net/lib/py/bpf.py module.
> >   - Patch 5 adds an XDP metadata selftest that loads an XDP program
> >     calling bpf_xdp_metadata_rx_hash. The test skips on devices without
> >     xdp-rx-metadata-features.
> > 
> > v2: https://lore.kernel.org/netdev/20260303024510.644962-1-carges@cloudflare.com/
> >   - bnxt xdp: actually fixed RCT issues
> >   - bnxt xdp: Added patch 3 to handle CMP_TYPE_RX_L2_V3_CMP completions.
> > 
> > v1: https://lore.kernel.org/netdev/cover.1772211065.git.carges@cloudflare.com/
> >   - selftests: moved tests into net/hw
> >   - selftests: fix pylinter errors
> >   - selftests: add check for no error count
> >   - bnxt_xdp: followed RCT for variable declaration
> >   - rebased on net-next
> 
> I think I commented this on the v2 [1], but it would be super helpful to put
> the summary of changes in each patch itself to make it easier for reviewers.
> 
> I think you dropped my Reviewed-by's, so I'm not sure which patches changed
> and which didn't :(
> 
> [1]: https://lore.kernel.org/netdev/aacsQvvOoL29Rvyw@devvm20253.cco0.facebook.com/

Thanks for the reviews and feedback, I'm learning. So when re-submitting, I'll
be sure to keep your reviewed by if nothing has changed. In addition I'll make
sure I put the changelog in each patch rather than just the cover letter.

--chris
