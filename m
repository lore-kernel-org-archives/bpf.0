Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CA53A8734;
	Thu, 26 Mar 2026 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549338; cv=none; b=iBA1A3rfL71rrCyrnknOvJ/DWZHmMn1uFDP1Y9k3yv4TFObxWAZAu+f5O2cMQOQ8tiPcRnASEhslEBECx0yWi0Q6SX4FoRjuiL0zNulGV0U/10wcuTBI4HUdgZiL5Q2iNq6GnExqqElMsbGQnabJa0i3phsLn/TUXkaHJ5gdXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549338; c=relaxed/simple;
	bh=eDLTktwG3tJ3RPOaCLvF0EmBzLa6K8jjBQZtsyA2G6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JJ6/I2O5/dzPdWgFEprOrfhJfwAJl0xzCHV0GrSqLEoaDcd5/gWjw6C8DdDtDHgXHX50XIS/nS8W7KjPYXDQjCPClcIOrDJDoIrNmmkXn/iAmbQ6rVzcnrA6tDLdxTDpnaLW+pjap+P3sHugPVU+idNWBPgyQSQe1GR0sBpks9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OT9O0i8v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OT9O0i8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC72C116C6;
	Thu, 26 Mar 2026 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774549338;
	bh=eDLTktwG3tJ3RPOaCLvF0EmBzLa6K8jjBQZtsyA2G6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OT9O0i8vNhu3Qd7Qh/YOHGszOonaxPRBfWWnJV2rhRqNeXR7uvVj7gXHLEblgIiL5
	 339mMjA2rooqvEXBOdW5bD3rQVN0yWWIgXoM57+ca/zNVzuw84KgpwAWOvS2HySZV8
	 5B6Q5LCW0BlNTqajFPaqdVYGI3BMIMzVIC1mAXiD8lhXLaSSxX0VixRkwq7eBfP8l8
	 tcaSJlg0XSI1Lz2Bt7a8i55aNmPBnbgzLO7cbYIxAgMq2f8IV+M+TzlMHDpW7EdGYl
	 3O8Nk6T1S4ZQIlbfWswTOIVjRo/ytgbPedkyLKz+LbqY0dyhQAuie+Z+1+6Dw1dRtr
	 7OtlXhUx6i4RA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v4 net 00/11] xsk: tailroom reservation and MTU validation
In-Reply-To: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
References: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
Date: Thu, 26 Mar 2026 19:22:15 +0100
Message-ID: <877bqycuy0.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> v3->v4:
> - allow exact 128 bytes of space when user defined headroom is deducted
>   from total frame size
> - provide a routine for reading procfs entries within xskxceiver
>   * use it to fetch cache line size and calculate skb_shared_info size
>     on our own

All those POWER and s390 folks will love it! ;-)

> - clean up gve and igc xsk pool enablement routines
> - include mtu vs frame size * max zc segments validation in
>   xp_assign_dev()


For the series:
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
