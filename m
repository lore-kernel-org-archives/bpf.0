Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F4250AC08;
	Tue, 29 Sep 2026 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684090; cv=none; b=hi8U0kuaEm6dBJC0AlBInlhL2hpWjoJzJQ2DkUiWIp0+RsJ66GWiG56DGv4JVPiOPkiwwH+UWWMn2sO4nUUKHdeoJ9IYyAA0qHX8BU8qeMmW/sTyOg5GnxfUfLjr/chzFSU58SjchOs62IR00rsqQYonEm/WLCrfeEl33YoF4bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684090; c=relaxed/simple;
	bh=N5Nhi5z/usOaVfZykoGEfYu522fzvn1tNbyWE+YN1ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQtOWzq8IMDmzTJ7KCJv/0FDi3BHEasCu44B3bSHbHsVgDwCcqq57Aa4I6ZTsGaUzsUqz8pFzWSH8ZcJpJLgerPYKFEUmVuhD+JegG3Q6sgtpqd7IxJw5CRVRxVUX4OU8vWtjDi9lV0n6wklQ/QaAzuyLnXmO2pQsvykVDcOgwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NU7aZCYc; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NU7aZCYc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7EYxW6eHl+vVXk5DCcuxkBfN5sk69z/6MHf2ovNOkvc=; b=NU7aZCYcyPWAEXAPhrmKW9+jx3
	YF7tXFWAVZWluxZfKd21ec29upiLKL6ev1AyyI1+WgpFaZMhtEw9n6/mIxlnCwo2a3HRBY8VxyCuU
	v9YeFqcjbw3GLFJLsX3pcXDddDVR6ohhv+JPHb1wJuEfwDpEQqZGyJZA0TgZdpXB/MPK9fLR43PpR
	dpfe7tiMT8SQhuWKMtvfsOkOvU54Ma4sCC+BX4vL0Je+xR0Mm0XqnZ5SOvmlKMfmpO9X2tMUWS6yC
	hWMjjiWbQkpG6KHrpLKDTgfTgMq3Et1gXF4RAA2Dn3Dc66zX6dx6YWcnZ1kpFSKP14jjvShSS2E/H
	kD9cI+BA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xBWiy-008OwB-2b;
	Tue, 29 Sep 2026 12:14:21 +0000
Date: Tue, 29 Sep 2026 05:14:13 -0700
From: Breno Leitao <leitao@debian.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 1/6] ipv6: reject a negative optlen in
 do_ipv6_getsockopt()
Message-ID: <arurcoXJjvorXN4w@gmail.com>
References: <20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0@debian.org>
 <20260925-sockopt_expand_out_v2-v1-1-c3ef2e3bb5c0@debian.org>
 <arbE6i8JZrOs-DO9@devvm7509.cco0.facebook.com>
 <20260927075358.129e5f65@pumpkin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927075358.129e5f65@pumpkin>
X-Debian-User: leitao

On Sun, Sep 27, 2026 at 07:53:58AM +0100, David Laight wrote:
> On Fri, 25 Sep 2026 12:02:22 -0700
> Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> 
> > On 09/25, Breno Leitao wrote:
> > > IPv4's do_ip_getsockopt() rejects a negative optlen right after reading
> > > it. do_ipv6_getsockopt() never has, and nothing downstream treats it as
> > > an error either: len is an int, but every consumer compares it unsigned,
> > > so -1 behaves as a huge value and each site clamps to its own reply
> > > size.
> > > 
> > > 	len = min_t(unsigned int, sizeof(int), len);
> > > 
> > > So getsockopt(fd, SOL_IPV6, IPV6_TCLASS, buf, &len) with len set to -1
> > > answers 4 bytes and reports 4, rather than failing.
> > > 
> > > This is a bug ready to bite us in the near future, let's get this fixed.
> > > 
> > > I've found this because testing the rest of the patch was returning
> > > inconsistency when optlen = -1.  
> > 
> > If I can do getsockopt with len=-1 today and get 4 bytes back, isn't
> > that a uapi and we are gonna break someone?
> > 
> 
> Treating negative values as 4 goes way back into the pre-historic annals,
> And I agree that there could be code out there that fails to set a value
> so passes 'dirty stack' and it always works because it never passed 0..3.
> 
> I suspect all the per-protocol code ought to be passed an unsigned 'len'
> (and return back a possibly modified value for the wrapper code to give
> to the user).
> Then you have somewhere:
> 	/* Historic bug compatibility */
> 	ulen = len >= 0 ? len : 4;

Ack, I will respin it and add this approach rather than -EINVAL.

Thanks for the review and suggestions,
--breno

--
pw-bot: cr
