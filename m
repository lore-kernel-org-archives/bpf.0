Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D635939060C
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781313720; cv=none; b=pbnQQgcqHeM7y0dM+Ke9r/WSEJ87LsFeVZXpA/n84UZhPi0O1IcsdOTu1CbbPSx65eApU5RNXG/M90SN94JmDVkpzAvMjFMNVf6YhhsWbRT3NPZVeHzmn9ITQjaw3hkT4vYuR4kgoTp3wgqC4nHfLW5zlAWWVO9t+thsoB7L97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781313720; c=relaxed/simple;
	bh=/pIEz2jpslNbjBycE0jlsQhvugj01wy2RwD3g6V3mN0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DZkLNE9rwfVoYYQc/1t3frg3oeJtot2Eu1EAJAO53n0w6ok/AVYmcpFMpLJ89l05szU0gwlRiOy2OVAb0y8FVC35qO8V+n+S3ox5tU8oUz4PCovWNPSGAdI/QSHbvuQbLAu9z+2JsuJY/8ZdjhRD1yj5I+U02i6ak5Yz0TsSkFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpCQQqPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpCQQqPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0ED1F00A3A;
	Sat, 13 Jun 2026 01:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781313710;
	bh=IFsIxiKjBnnejQQuyhDTXSZI6oSAEMoLXXkilnCsbdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hpCQQqPJWE8kumCT4OYfhADO+eK+RAQPWr+04UAeOx1OZic/rmz8LlaeD5qzr1aEZ
	 QrYsm8bi5K/z97xbU7F/4USFRoHjgFtNlgKLfSbPPVls3GPKXjhErxUaxwrarARsab
	 jv+UrjBMY9slMIRGtDXK7S8I3xGYP7UqKN/qwES8FkH2vjgM/DIH0UYaAMR4dxlcNF
	 seqeCYruPpHyCejXFrTtgL9Ib60AL0AeQELRf1cCWMcLzYTh/gC/rvE4kEgJxcb7hV
	 X4gB8ODibFUWDp5QyFqqfWfYUnsQHk6TUU315jBx6+Vf95E2tkM2soFluMfvRxiSDZ
	 ylAYga8xhrz2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next/net 1/5] ethtool: Introduce
 ETHTOOL_MSG_TSINFO_SET for virtual interfaces.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260613010039.1362312-2-kuniyu@google.com>
References: <20260613010039.1362312-2-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 01:21:49 +0000
Message-Id: <20260613012150.1B0ED1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Data race on dev->tsinfo fields between the writer (ethnl_tsinfo_s=
et) and lockless readers (__ethtool_get_ts_info).
- [Low] TSINFO_SET netlink policy improperly allows the ETHTOOL_FLAG_STATS =
flag by copying the GET policy.
--

commit 8f988b32029a0a0b4879e0ac83015bac45af1444
Author: Kuniyuki Iwashima <kuniyu@google.com>

ethtool: Introduce ETHTOOL_MSG_TSINFO_SET for virtual interfaces.

This patch allows configuring hardware timestamping capabilities on virtual
interfaces via ETHTOOL_MSG_TSINFO_SET, as they cannot currently advertise
the capabilities of their underlying devices.

> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 84ec88dee05c5..bb0c02d92a9b5 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -1090,6 +1090,10 @@ int __ethtool_get_ts_info(struct net_device *dev,
>  			err =3D ops->get_ts_info(dev, info);
>  			if (!err && info->phc_index >=3D 0)
>  				info->phc_source =3D HWTSTAMP_SOURCE_NETDEV;
> +		} else if (dev->tsinfo.enabled) {
> +			info->so_timestamping =3D dev->tsinfo.so_timestamping;
> +			info->tx_types =3D dev->tsinfo.tx_types;
> +			info->rx_filters =3D dev->tsinfo.rx_filters;
>  		}
> =20
>  		info->so_timestamping |=3D SOF_TIMESTAMPING_RX_SOFTWARE |
> diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
> index 14bf01e3b55cd..c9078aa4a897e 100644
> --- a/net/ethtool/tsinfo.c
> +++ b/net/ethtool/tsinfo.c
> @@ -38,6 +38,14 @@ const struct nla_policy ethnl_tsinfo_get_policy[ETHTOO=
L_A_TSINFO_MAX + 1] =3D {
>  		NLA_POLICY_NESTED(ethnl_ts_hwtst_prov_policy),
>  };
> =20
> +const struct nla_policy ethnl_tsinfo_set_policy[ETHTOOL_A_TSINFO_MAX + 1=
] =3D {
> +	[ETHTOOL_A_TSINFO_HEADER]		=3D
> +		NLA_POLICY_NESTED(ethnl_header_policy_stats),

[Severity: Low]
Does this unintentionally allow the ETHTOOL_FLAG_STATS flag in SET
operations?

The ethnl_header_policy_stats policy allows users to request
statistics, which is normally only applicable to GET requests. Other SET
operations in the ethtool family appear to use ethnl_header_policy to
enforce strict validation.

> +	[ETHTOOL_A_TSINFO_TIMESTAMPING]		=3D { .type =3D NLA_NESTED },
> +	[ETHTOOL_A_TSINFO_TX_TYPES]		=3D { .type =3D NLA_NESTED },
> +	[ETHTOOL_A_TSINFO_RX_FILTERS]		=3D { .type =3D NLA_NESTED },
> +};

[ ... ]

> +static int ethnl_tsinfo_set(struct ethnl_req_info *req_base,
> +			    struct genl_info *info)
> +{

[ ... ]

> +	if (!ts_info.so_timestamping &&
> +	    !ts_info.tx_types && !ts_info.rx_filters) {
> +		WRITE_ONCE(dev->tsinfo.enabled, false);
> +		memset(&dev->tsinfo, 0, offsetof(typeof(dev->tsinfo), enabled));

[Severity: High]
Is there a data race between lockless readers and this writer?

In __ethtool_get_ts_info(), plain C reads of the dev->tsinfo fields are
performed while holding only the RCU read lock.

If ethnl_tsinfo_set() concurrently updates or clears dev->tsinfo using a
non-atomic memset, could the reader observe torn reads or garbage zeroes,
resulting in incorrect capabilities being reported to the socket layer?

> +		goto out;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613010039.1362=
312-1-kuniyu@google.com?part=3D1
