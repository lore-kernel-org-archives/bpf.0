Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E48F188CC9;
	Wed, 11 Mar 2026 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190740; cv=none; b=sIzFfmw1asu3iiVgqaGhnM8yya+vF/iaoC131fHq3cDehl1Qy69oIwYT4HG0KTW2nONpyYxyir4HZo0YxAnOWSix7HtSN2Hyv0v0tT/a/kfIH7vPnAiQzVGS0yDNJk7hMkHtbmzyjggIzkfLp/s6M4P2q+SxktqDbOpYkPd/l+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190740; c=relaxed/simple;
	bh=Biv6lAtnMW7SLNONV7jtLNZyXdSOyQVdv7rBF3xubrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEEAJ+KIYUZbnv3irCx9mDnBiFeo6mkTlKvDjWiay1q8ikNrZSWjpYA9HP9HYz96irc4X1RPnp4Tqne6WbtZeGuqekSS6Sq7cCZVj4zMwPZ7fDLYSwSEKh3CqQmToCOuxDMMZIVaL4wA57V8SDLNGIo8RrI+MDJ80pEamLSGZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1zLkH/x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1zLkH/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C85C19423;
	Wed, 11 Mar 2026 00:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773190740;
	bh=Biv6lAtnMW7SLNONV7jtLNZyXdSOyQVdv7rBF3xubrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M1zLkH/xLMOaz+bFw+dOKJqzGa/jWMd3Nwbwf2tfhebEh/8IVzc0FU4EDkR9KiqZB
	 5dfPwV81KTABGHh3MBNaYfT1XVnAGvsx4u+Qq+pZNrDD4XLXam4XuxETkoVfoVw6Fg
	 BqorkDdAx18/OIRNrOqXcedU8ebzKrpzLl3ktxk8wGjHlHlygnOcOOOgozd/GXl4qk
	 m85vX+/2teD7MFMiGlvjMIuQ4HqvkniHetswasRulOxkaCF1SvM9x8kXUyyxfwHB+e
	 v5x0sGwOvdqgjdMY+ubsBFXJ1B1H7BkXrQFNCpUD7ejBX8Fal3224WxSI8ET8FjUdA
	 OJl6+otLq/NyQ==
Date: Tue, 10 Mar 2026 17:58:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: "Ricardo B. =?UTF-8?B?TWFybGnDqHJl?=" <rbm@suse.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, David Ahern <dsahern@kernel.org>, Jay Vosburgh
 <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu
 <liuhangbin@gmail.com>, Fernando Fernandez Mancera <fmancera@suse.de>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 0/4] {net,bpf}: nd_tbl fixes for when
 ipv6.disable=1
Message-ID: <20260310175858.70ed0391@kernel.org>
In-Reply-To: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
References: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 07 Mar 2026 17:50:52 -0300 Ricardo B. Marli=C3=A8re wrote:
>       bpf: bpf_out_neigh_v4: Fix nd_tbl NULL dereference when IPv6 is dis=
abled
>       bpf: bpf_out_neigh_v6: Fix nd_tbl NULL dereference when IPv6 is dis=
abled

Hi Daniel, are you okay with these for net?
