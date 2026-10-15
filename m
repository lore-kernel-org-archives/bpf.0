Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1A34BE45E;
	Thu, 15 Oct 2026 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052883; cv=none; b=ouGyyrOU+dpIU1CwhoCvbojlSXVZ8YT81+F626l/lpysP4Pvbk9Qk3tKcdlNhgAe8nqESOY+oBb73TBai7oefnIwvJWi0DZoFp+NGxPMjBK1DzOtXXh7SMGETHHHjRj2+Btgy2LYHptFlVQBF+qiL++bzms5zVPagjpnbgRJCv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052883; c=relaxed/simple;
	bh=pA5pdyFX1UxzMIQQlheJlHsNFDoU6iH8bBoP4vYaWkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SYGQjsRed27VT5nHPbPPx83OwzImRfXoqtyShkAWogqPWhJyDJqerpvPDdNcHMx+Sz9YlG4tPDiRJglafWNqVKN5UANMSpiU4UTPOAPeD72eqcR0e9e15KCimzdlW/YUM+ttWo9BRtV+CyOm6vDOM7u3lzDr9esq7iZMvzbK3rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz92MHxZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz92MHxZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154961F000C4;
	Thu, 15 Oct 2026 08:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792052880;
	bh=PszMguYC+OPtDzMvLLBU4BgcfG4LyvpkBov/KvdqA54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Vz92MHxZIsaqsU1Ts0o5Bi9ri0gOhxUkeK4wJKJTEI6uIu2C8Kb3SM7TNXByK2Y4W
	 uhiuFDiOqI43XjczT6qzePvZAQMabpcKsxrbifx+MGvsiZPJ+LSDpiq3IEGkdUjTcq
	 6pb/X3y/sOoc8Z/HD3zA1yFO5UU/nJTAN5IeXE1MURTf85Z6qZL+fFjcihZDdvXDI7
	 pO2c94YX1IuvfepCKNfap5YKis1xC0UyxFkX7k1Y092EqoJuZV3hp7BvEFLRKFH5KM
	 eNs6YH2JvmI5qkk7s2EyD4iu8lYtgBqmGDNprcXaqG2/JIgbQOJYl7/UB9MRI5beYU
	 beKt7p+t6rqgw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v3 net-next 07/15] selftests: xsk: collect interface
 capabilities in struct xsk_caps
In-Reply-To: <20261014184539.774708-8-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-8-maciej.fijalkowski@intel.com>
Date: Thu, 15 Oct 2026 10:27:57 +0200
Message-ID: <87fqy774he.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> A later patch runs the TX and RX endpoints of a case as separate
> processes, possibly on different hosts, each binding only its own
> interface. The shared test code still looks at the capabilities of both
> ifobjects, e.g. to check both for multi-buffer support or to size the
> RX batch from the TX ring limit. As the endpoints do not exchange
> capabilities, a process will represent the other side by a shadow
> ifobject that mirrors the local ones.
>
> Prepare for that by replacing the per-interface support booleans and
> limits in struct ifobject with one struct xsk_caps, so that mirroring
> takes a single struct assignment and a capability added later cannot
> be left out of the copy. The maximum TX ring size, which comes from the
> ethtool ring parameters that a shadow does not mirror, is copied there
> too. ifobj_has_cap() and ifobj_set_cap() test and set the flags, and
> xsk_get_cap() reads a limit from the TX ifobject, the only one that has
> all of them set, as the open-coded reads did.
>
> The unaligned UMEM check now looks at the RX ifobject only: the flag
> comes from a huge page probe that does not depend on the interface, and
> test_spec_set_unaligned() switches both UMEMs together.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  .../testing/selftests/net/lib/xsk/test_xsk.c  | 84 +++++++++++--------
>  .../testing/selftests/net/lib/xsk/test_xsk.h  | 34 ++++++--
>  .../selftests/net/lib/xsk/xskxceiver.c        | 13 +--
>  3 files changed, 81 insertions(+), 50 deletions(-)

[...]

> diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.h b/tools/testi=
ng/selftests/net/lib/xsk/test_xsk.h
> index 0717d855e4df..1d17e214db91 100644
> --- a/tools/testing/selftests/net/lib/xsk/test_xsk.h
> +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
> @@ -144,11 +155,20 @@ struct ifobject {
>  	bool use_fill_ring;
>  	bool release_rx;
>  	bool use_metadata;
> -	bool unaligned_supp;
> -	bool multi_buff_supp;
> -	bool multi_buff_zc_supp;
> -	bool hw_ring_size_supp;
>  };
> +
> +static inline bool ifobj_has_cap(const struct ifobject *ifobj, u32 cap)
> +{
> +	return ifobj && (ifobj->caps.flags & cap);
> +}
> +
> +static inline void ifobj_set_cap(struct ifobject *ifobj, u32 cap)
> +{
> +	ifobj->caps.flags |=3D cap;
> +}
> +
> +#define xsk_get_cap(test, cap) ((test)->ifobj_tx->caps.cap)

nit, and iff respin: I'd leave the whole inlining out. Keep it simple.
Also, please functions instead of macros.

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
