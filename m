Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011780;
	b=a9v4w2A+YGJyd6WoWGD9+8ISgyaxnVPFOgcEvqGuOtQaGhxpOrec6dZYkK8htImTA4dN
	 cDzGMYThJfjEn4DHahXkPnkxRzzGVOw6AVTRYj4UaU9lRGDIYlO/cKNTeuSWIr9I3iwXN
	 oaezhdlG5EfCt9vw0T3vDoSiiBZ9l/UQLVFwamq7EY8fe+eENaewxehYwB1sz/uTSgbpX
	 Nqh3S2zXcPCXFdZkH1D8vMhX7EYZhi9FCtKGOzWII60ORJdQmL89C3rHeFaatkb4VmDiV
	 wfSu7Z5Q1heRWob+fH5dMb1AIjFnFj2HCL28YBbiTeecyEzQh8I8FUC6NU9EqQl5T9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011780;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=n2gAcLKPEPtariY942tQYn79FVktTDVNyRXUcZb8X68=;
	b=1gUfFz4NAsHenoaCyWqD06ShU6EyIofwNer9QVeuX1efRC17TYfADoEGMZ1Ibv7l402Z
	 RsapU7sUq2/AoUplRwFxS2HFzWg5YBGL/wjdFLNWpgPMM0XAq1pKuFjVNUPed2gYczqxY
	 axoKLibHOAY4ogN3XoOvZDrmBMlrAFabyN9oNfWUQhuoylZy9kpUvtsXg2pWT+UsrIMcF
	 txn07RJhzeVndouOgMX4bX60q8yoSGnLHJrsO7SrjEMrzwMbmo0Xxv0JZuqt2ZJ0rbYfC
	 vFtfm5O2so6w2OLjdKt7k1U9EnUULJV1Ouz4+jxHQm9B/aE2dtQEDiM+qhfk8+uYbpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Fh7rdCPt;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0E606A31D;
	Mon, 26 Oct 2026 10:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C0E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Fh7rdCPt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n2gAcLKPEPtariY942tQYn79FVktTDVNyRXUcZb8X68=; b=Fh7rdCPtU3hd+QC3aQHZkW8FTb
	af1unfhyMy9WCodbyNYt3MHOSpUwz+0vpRbw7g+zSCiAgxY8D73mb3hy61rUUNkbMsWve74lIWK0z
	4Jp8iSOCB6JVLWU0XXs2y41RWlfgtJTwoXadEjvcKRF5ZXvuU/58LBtOzABUMkSPkgAGoYQZrQ4ae
	yfSbVdYAqt2/xnkSTFu5n9NYfgYi5h6aLWVlxv30okYkYoglT8d3f8OOnbufuKzcuDbSxyoTBu9yX
	fTJeecigyVIZHuavr3AwF0T8+iEjQEK3BMaiIzOUxK0T1xCutHC3wHk0eMK/q22trKI9AOWD9SYSl
	l2n7Awxg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xLIGa-000coU-0G;
	Mon, 26 Oct 2026 10:49:24 +0000
Date: Mon, 26 Oct 2026 03:49:17 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Shuah Khan <shuah@kernel.org>, Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	david.laight.linux@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 0/7] ipv4,ipv6: convert the getsockopt
 switches to sockopt_t
Message-ID: <at8v8Orx3je4KD2i@gmail.com>
References: <20261015-sockopt_expand_out_v2-v3-0-7d05ef2df448@debian.org>
 <20261019081907.GA2725184@shredder>
 <7ceef2dc-717c-44f5-9974-1ed8f0440fa3@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ceef2dc-717c-44f5-9974-1ed8f0440fa3@redhat.com>
X-Debian-User: leitao

On Tue, Oct 20, 2026 at 04:05:39PM +0200, Paolo Abeni wrote:
> On 10/19/26 10:19, Ido Schimmel wrote:
> > On Thu, Oct 15, 2026 at 03:05:29AM -0700, Breno Leitao wrote:
> > > This series continues the migration to sockopt_t, as described in [1].
> > > do_ip_getsockopt() and do_ipv6_getsockopt() still take a sockptr_t pair,
> > > and everything they forward to now takes a sockopt_t, so convert them
> > > both.
> > 
> > Acked-by: Ido Schimmel <idosch@nvidia.com>
> > 
> > Given the user visible changes, the fact that the merge window is now
> > open and that this isn't the last part of the conversion, my preference
> > would be for this to be re-posted after the merge window.
> 
> I agree on the above, also clashiko noted that patch 7 lacks an additional
> 
> CONFIG_IP_MULTICAST=y

Ack! I will add CONFIG_IP_MULTICAST to patch 7 and submit once the merge
window is closed and net-next is re-opened.

Thanks,
--breno
