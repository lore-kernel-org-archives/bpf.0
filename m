Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D3923EAAD;
	Fri,  1 May 2026 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777600708; cv=none; b=YnJ5LqjpsIyNnN7fkzKuQeTcRP15sqiUobYQBi8RwKyWNCTneQk3MVhy/Gb3E9kq15Rndiy6qL3vVaUAth6flZcvhSGLMN/cMreqBj0UL27/FWoCt9YM4qEJC1P3Y6zAXzMtbsGYgqGuEz7GZDx7MEbV5tg58t+FjPIDmNuIIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777600708; c=relaxed/simple;
	bh=0xrzsWh+MkLbSwH2F+LegqQMbz+JA8KbWNCHW0CG5Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOgnvek0/kcDer1zJiDC9Js/ydVp/ci2wPo6sKNVxVPWOVa/sYm6XusPzb3oUQ6ui+WxuKmP/V69EO4aYM3UYeqE5gtHGBby208QT18NDYkO+ZMEbCfe+ZPOXywJinH6h5gPbsuQ9P6XUzypIlldN8IXNQCQqlDZT55G7rNaKrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxTDWUpT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxTDWUpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6A5C2BCB3;
	Fri,  1 May 2026 01:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777600707;
	bh=0xrzsWh+MkLbSwH2F+LegqQMbz+JA8KbWNCHW0CG5Kk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HxTDWUpTmbt/c878FjZHqa9aRds3ISc08kRJYijWS1k7yZok9EzhhrrublOx8taI5
	 RHWHQYeboeuYOU170XIoQkDaeyRUC81wpJ2FzR8NP3AEl8awvz537EBLn8bGQDzT8V
	 pyPsR6P3FeG7CaaPVfB5fw3fqoiWD13OUDep7ArG2IliU/UCE/OB7SWDVQoInjT9Jg
	 CyYFm3Bwj/vGMOd2L/ZEP7g59J3NLrCT2+faOVos7NZpDaJdCyo9ZM0lI+0qoifHD0
	 xfwhRnoNq5Z76o57KFeFmPR7gFylsCugAW9PmN9flmH3+1+ajXfGD4GbytNLugZUDZ
	 lf6VRMXJmOYGw==
Date: Thu, 30 Apr 2026 18:58:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: hawk@kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, linux-kselftest@vger.kernel.org, Chris Arges
 <carges@cloudflare.com>, Mike Freemon <mfreemon@cloudflare.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>, Jonas
 =?UTF-8?B?S8O2cHBlbGVy?= <j.koeppeler@tu-berlin.de>, Breno Leitao
 <leitao@debian.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/5] veth: add Byte Queue Limits (BQL)
 support
Message-ID: <20260430185825.43b2d0aa@kernel.org>
In-Reply-To: <20260429172036.1028526-1-hawk@kernel.org>
References: <20260429172036.1028526-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 19:20:27 +0200 hawk@kernel.org wrote:
> This series adds BQL (Byte Queue Limits) to the veth driver, reducing
> latency by dynamically limiting in-flight packets in the ptr_ring and
> moving buffering into the qdisc where AQM algorithms can act on it.

Does not apply (am I remembering right that it's not the first time
this series doesn't apply?)
-- 
pw-bot: cr
