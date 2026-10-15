Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F1E4AA006;
	Thu, 15 Oct 2026 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053003; cv=none; b=Xkyx+NA9Nl3X4FPPK5SNxCKPvFDLPunbd+d113ibd6EADwMqGH4y95PstVVnV11TqrcGM+ZoJdUuaJV/ZTd5p0DfpqQiNOcLRoGQJidyxKEGmxBMNvnAv2Mval3j+8zLYTeQY+GEoTm6N0KY1RnkD/lptUc2XnSuPLBDFeF6I6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053003; c=relaxed/simple;
	bh=KFQXbnehSxqrTKugEsHo7UUF/sXarjKnHunqrbLUrwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m7B+AF8rTIWJZeig7rmQUYffe0Sh4aNVDshp/bI1qZ20/diJTeEajHpiws76fZZohxgBDs74Xr1liGID9T60ckEm6hl7ZeqWcW15GmA1m4f5B5piovJH/xdabkSGTpz+yq3s1M5+IlNrrfD0kGQOSkvE935rGpZUank93a683Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDan+OQI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDan+OQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EF11F000C4;
	Thu, 15 Oct 2026 08:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792053001;
	bh=eeqvoBOKwK/7a1JNaspqU4Zt1ncsfScoIEU7WZEdUbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bDan+OQI5O2od04H6YBmJuiAzToqxebZFQ8+Ai7vYcy2QVFa1Ag6SoTT8fccrjnGo
	 zQJf5Kadij2TwgdjjY9PjyINVrS3GkySnFMfpZJ47jpyBhF3J4p2ay/338JOu+1VaL
	 tqEDe+7XOtdq8ln0Xamm91fYQtqyjm8+DdEThQToMJ4sVz+bhXHH+SgOcxE9u+IjuC
	 dbe3lBC6RwInBFlhPJOqzw8Ku20DMlseGFDiZVBPFiBYn9A0mSmHf1aRpzxCI9fbd+
	 0OhmImsoq3iW37KFh/LuBKwPbMdED5rL0NN1OCLKA2gOtnekE7tCZeCK+Xjb6pVKMn
	 CiPVpmEgjsjoA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v3 net-next 08/15] selftests: xsk: split xskxceiver
 main() into setup, run and cleanup
In-Reply-To: <20261014184539.774708-9-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-9-maciej.fijalkowski@intel.com>
Date: Thu, 15 Oct 2026 10:29:57 +0200
Message-ID: <87bj8v74e2.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Prepare xskxceiver for running a single endpoint per process by
> untangling main():
>
> - bind_iface() sets up one interface from its -i argument, so that
>   interfaces can get their roles after parsing; -l needs none
> - detect_mode_caps() and detect_ifobj_caps() record DRV, zero-copy and
>   HW ring support as XSK_CAP flags, which mode_supported() checks
> - run_pkt_test() returns the result, which main() counts instead of
>   test->fail, as not every failing path sets it
> - cleanup_iface() restores rings, detaches and unloads one interface
>   and copes with partially initialized objects, as does
>   pkt_stream_delete(NULL), so main() has a single exit path
>
> As the rings of both interfaces now get restored at exit,
> hw_ring_size_reset() skips rings that are already at their defaults,
> as the SIOCETHTOOL path passes such no-op requests on to the driver.
> When the request fails, it keeps the sizes the NIC still has, so that
> a later reset tries again.
>
> Call ksft_print_header(), which also switches stdout to line buffering,
> right after parsing the command line: xskxceiver never called it, so a
> launcher reading through a pipe only saw the output at exit. -l prints
> no TAP header and exits with 0 instead of KSFT_XPASS, as listing the
> tests is not a test result.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
