Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5877F221F2F
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773103901; cv=none; b=X2JcimorkmnMJROfLKHM3l5q6yQjVAsbdlIfX1l3ZJSI4biUlOCidfzcDgynIPETN8ISm0FjWWacR/YAb7GQKYRUQR5wmKKGnHT+LqVN91J31vTUveSDqSVO4PJm0QbGYzlujc4CIZcIysh62nD0cyLP/AZshgOVlWCnz4Pc41E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773103901; c=relaxed/simple;
	bh=3IrG+fOOh+yxFO8pIWyDI1vjfTbn2z7aSBZSdPFLBCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq8ccQDKuFMSTFPncYvJxxObQBCwqwTC+ErSjqIH4WK5aDPtiIIx4PO0aTBGr4bxxNNsMe6+Lr+xiQRHFY0IUOPOmazfrSm4gtL4U8/mBzMn2qo8vYz+Pcw270mI1T0wMNG/Jc9kuDkFSxFuo7NjPRRI2/vR114zHiAwjbcV19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=ZqgSl6XA; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="ZqgSl6XA"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso4489223a12.3
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 17:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773103900; x=1773708700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ui///VuHm/YZR9cjxycdSpMN+uMufMd2buaKUGijN4=;
        b=ZqgSl6XANqvr6d6deOO+7koTRR2/RHAbjqrofPaADGZnSUXxnZcFz/TVEg/9F97fFC
         KCkIqVehwQObkyRqz6VqnvAWd70w8z/LJvbU3aEu8l6fAbh70f2FBzlio9sh5PPo0vP4
         Hk7Uq7hIJ2c9aHfZ0tTVFI6QAXREKjCv3hz2CKDVzqpX0zhcb5/BDeSVUWugTcLetRj5
         lBdIKO5d1wD1etd4XiyuIhR37Hfy7tWEyJfuEc6x2/jb7RmjQkju07qzn2aLL3UzAFqb
         Yfe2T8T1q9yjH85NOIr2cCVxtNCnpKcsaw1MlhtQs2F/aEQxdvLs/egwMiVPxs9h+n6A
         k2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773103900; x=1773708700;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ui///VuHm/YZR9cjxycdSpMN+uMufMd2buaKUGijN4=;
        b=UJLt+2cFeNHiSEy8wW5tRaVaqSPzPYRqttU4sFxQ25CE0hGuqS9XhnOblucDnsMJVs
         /flv9P14cMtNDqlzhcVLpxFIeGSnTdPf4rWG2MF7jBH8Uvr/6fB3nJyxFgW1tvUjugtG
         smImSv2BYYLH+OvscmuD2jX6+jcIc4NmKHEgqes7W+T15oXC6E6nOaKwA5HOOga5z0bF
         FPgq0Qbl15uWll5sHoQ4/xn8QgP6rJg+HOoKOfjWAQVEfoE2cYgMKUlCQBTj1bJp9wzc
         5967ZTMLYn+X7w488+e656QcyTDUSYcI5EWEhtrYlFBDO8Fyp3f/s3TLDc73LtK04zeQ
         f1YA==
X-Forwarded-Encrypted: i=1; AJvYcCUzMRPn/YXKQFlQ85x2cxw1DffaWEEKAJlHtAgZhX15/AD23Am3vytefL4g7fP3BJQix48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGzUugsxdUR5CSkkHJb+aq9Da1bjDfYkVcW09Byuf7BiYaUfT
	GlhJOoOr0nyN1yh0dx9eqPYJv1P3OgmnkLwWIMCPkS+QQdisxy/s24SoJVP8C0tS4ms=
X-Gm-Gg: ATEYQzxFmpLAXpIQkwNcnaIU0r23sKpZC51khj051YE3k2LAOLbKXUWP7TUCrwq+6Be
	MMi++Af7wzAEPIjU/N+/AakooAodo8Z4JiLe6Yu2xJXb3ZVRx0IOIp+KNNelf4LwRzVsCNhaUbt
	NqfEPDjK9HWlTvw2NwgXYj/7z/DF/97jAfr2fbVF4v9YcvIpOHr44bFEX7wtJodZR+nIThuxe1L
	6j9h17rGCEOQFtHpR9brVQ55DyLNbXiZgUEwbNLa4nyiYzKiSrqjxB0aFcvJrltlBtKUfzE1dEK
	iGE6lCPAU4tHnWigRnRe64xWV3VNhaeI6Wpace6D59mIIF04KxEd+TbgHfGAv/NAWMK7zpAfh7F
	62sGtfkVRv8ndWuaXaQl+9tT7Q23378IDzkTzvbj8PZQksGu/Q8w02RbwG0dN7wrc3SfijEvHj7
	ThCG6sIvJmDYWSjw==
X-Received: by 2002:a17:903:3bac:b0:2ae:478f:2ec with SMTP id d9443c01a7336-2ae82434346mr125260175ad.29.1773103899755;
        Mon, 09 Mar 2026 17:51:39 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e585a8sm129807985ad.7.2026.03.09.17.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:51:39 -0700 (PDT)
Date: Mon, 9 Mar 2026 17:51:38 -0700
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/5] bnxt_en: Add XDP RSS hash metadata
 support
Message-ID: <aa9rGglS62WGgSMk@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20260306230600.1628196-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306230600.1628196-1-carges@cloudflare.com>

On Fri, Mar 06, 2026 at 05:00:15PM -0600, Chris J Arges wrote:
> This series adds XDP RSS hash metadata extraction support for the bnxt_en
> driver and includes selftests to validate the functionality. I was able
> to test this on a BCM57414 NIC.
> 
> Note: I don't have hardware to test v3 completions at the moment.
> 
> Patches 1-3 implement the driver support:
>   - Patch 1 adds bnxt_xdp_buff to wrap xdp_buff with
>     pointers to the hardware RX completion descriptors and the
>     completion type. This is similar to other driver implementations.
>   - Patch 2 adds the xmo_rx_hash callback for CMP_TYPE_RX_L2_CMP completions.
>   - Patch 3 adds handling for CMP_TYPE_RX_L2_V3_CMP completions
> 
> Patches 4-5 add selftest coverage:
>   - Patch 4 refactors common BPF map helper functions out of the
>     existing xdp.py selftest into a shared net/lib/py/bpf.py module.
>   - Patch 5 adds an XDP metadata selftest that loads an XDP program
>     calling bpf_xdp_metadata_rx_hash. The test skips on devices without
>     xdp-rx-metadata-features.
> 
> v2: https://lore.kernel.org/netdev/20260303024510.644962-1-carges@cloudflare.com/
>   - bnxt xdp: actually fixed RCT issues
>   - bnxt xdp: Added patch 3 to handle CMP_TYPE_RX_L2_V3_CMP completions.
> 
> v1: https://lore.kernel.org/netdev/cover.1772211065.git.carges@cloudflare.com/
>   - selftests: moved tests into net/hw
>   - selftests: fix pylinter errors
>   - selftests: add check for no error count
>   - bnxt_xdp: followed RCT for variable declaration
>   - rebased on net-next

I think I commented this on the v2 [1], but it would be super helpful to put
the summary of changes in each patch itself to make it easier for reviewers.

I think you dropped my Reviewed-by's, so I'm not sure which patches changed
and which didn't :(

[1]: https://lore.kernel.org/netdev/aacsQvvOoL29Rvyw@devvm20253.cco0.facebook.com/
