Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B427FB35;
	Fri, 20 Mar 2026 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996028; cv=none; b=mX/1UWkBY9chfFyENN8YKYy7C7dNQWTRtsKsPHTnfYojAPI5QhU6KyfoUoGABUow/20F9UPGvwQtccpIUZsBlhWgKePkL00S/56N/Mvsl/+n6ja/AZU+RNXQntRlEH4qXAPpPj3RSLTdGPJScxlssEOJKu32Q3IV6MQKy5p7yR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996028; c=relaxed/simple;
	bh=j4MjyNeBAQm3UCbDBVfDDLHOd5s4/rdmHfs2/FpS8jc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pjg7P4X/urOU62Rh9bDC/MMNJ04HiO1lslE15fkXe9PRIyAoYyf8dISj8tmTbGy48awNdm1rDsxbTy41TchTZ/+o40WDnib+2VhqFQvBs5FNhG/U5J0r4bzG6u3jHagjkZLiGb6zMuy0A1YiQJPrEy7mNyzwjh6X8Db2ftNLN9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JM8vtQjz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JM8vtQjz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74B3C2BCB0;
	Fri, 20 Mar 2026 08:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773996028;
	bh=j4MjyNeBAQm3UCbDBVfDDLHOd5s4/rdmHfs2/FpS8jc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JM8vtQjzO2lFrbPsJCJlN9D58mPE9h28RDKgZARVEHqtZPBYp2xdeCe+AG3xczdd9
	 GF2iFdm5Qnc/1/na8ZE0KXv660MBo7nwUvvM7I87GgJJPK1X2XPmuNQs9L6C96LAVT
	 +taLJy/FGpRG02/CpP4tzZBa2A2BpIaz+A4BlYZa9Wc/pQyY8XyExA5dNWqYKvcjgJ
	 hiapMsAMHa/VPSzI1psX0mVhKZJXuohcvwomn68aSilutZEAIWDYfmILVsatClsRN2
	 eTFmsV0Ux3nktmAcHGl8NXg+wfhXDbGthE0fN5FqPRi3bn+Bidg6226qA+aLFui9eu
	 3/RkPmgjXD+Ww==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v2 net 6/8] selftests: bpf: fix pkt grow tests
In-Reply-To: <20260319175538.479139-7-maciej.fijalkowski@intel.com>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-7-maciej.fijalkowski@intel.com>
Date: Fri, 20 Mar 2026 09:40:24 +0100
Message-ID: <87ms02opvr.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Skip tail adjust tests in xskxceiver for SKB mode as it is not very
> friendly for it. multi-buffer case does not work as xdp_rxq_info that is
> registered for generic XDP does not report ::frag_size. The non-mbuf
> path copies packet via skb_pp_cow_data() which only accounts for
> headroom, leaving us with no tailroom and causing underlying XDP prog to
> drop packets therefore.
>
> For multi-buffer test on other modes, change the amount of bytes we use
> for growth, assume worst-case scenario and take care of headroom and
> tailroom.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
