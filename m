Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795227317;
	b=Qk7Ab/woFlRRhNGFFDrBOFkNA4GVDiW7HhWs5zNzhDJRHKkqmGAOPzdboFN5U6ybGnPB
	 k3Z4K5IPI5k/GgFBpCQrlOZBYoZ1/J+vMk8ldoV7i61MCvD9N3S+naYYvNo4bHq3CvLwE
	 t+1hUUIKIomtofF2I3KHjq9/p3ocAegz34RIcLnL+jHUcXF3+prK26ZeQ2yYYiDE/izNH
	 2HVD78Pl15VYiv3QbXwh2i6DM/ypJirrsVT/7XJDMS6uUetTl6paSx4pIFiblNd4ajyTW
	 GENOm8EZv5BxcvVFx6t9woTwd3TJEp0QkCMl+XnA5KKek6YbI2x5nKNw6VvxzRwccfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795227317;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Hr2cRpMlMs9A4wNU0u/wxkplW7fAP5Mqa7xrJOu73RY=;
	b=vqq+O466jaXc/KS11Qba03+KCWfjb9ur5gl1TIIfcakr1TBKWp8V1dlRnhIN/DNHBzNd
	 mi3vitzi6MvWAN81gTV/GVmZDPo3aaL7iVHIFO67M7b7Tycjf/Jt6zZMTnNFYlAvynNc3
	 GXAXbftZdaqb6ApjoaOmv7HSSfuIcX5aQcnTiepk5LV6p5z66Q+t7G3oYx7lgHeV8rJ5h
	 yZAP06PIbGmMLuWa6czcrmALHojbA7/LmahaS4gGl+FvG4s7BKWo1Hgl4KOigU0rdlH8b
	 OSKbcbIEiKEWQ4HwOZjZbKzh9H0vS1cM9S0Vyc1C9OWpUH4jMtLzRvbiXaIksvZEJTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aNpZABkp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E43606A68E;
	Sat, 21 Nov 2026 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aNpZABkp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11E11F000C6;
	Sat, 21 Nov 2026 02:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795227316;
	bh=Hr2cRpMlMs9A4wNU0u/wxkplW7fAP5Mqa7xrJOu73RY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aNpZABkpUB0zHFoomwB0Pp4YMGdYIQYWGABVx8WGmYdP+KOGNI63mwJVY90B3p16B
	 RJvzwIjonIEayYKrfgeSTJ9aEzAXIcP3CIOQikc0BTgz78lTMkGq9I9VBYZZjNUvEr
	 5jIgjpLI9OjZ5t15Rt0NwDxR8jXe1jkJ69SDz9OB/Hiwhhw6TKcKJZWIjgWlKqIAp3
	 m45AzZj4pf/Ss6laRBZ+wGdJs1JghpLtRn4kAkVJXupXj5EpZ4CdWluXwkhcX2pStr
	 857oKapygScePTWEF6Zi0sYkr9QATyWRIdGegcheF/yGNoXqliAmZNcDJQANO/bOmp
	 p+5pjt+71kMrA==
Date: Fri, 20 Nov 2026 18:15:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
 <pabeni@redhat.com>, <edumazet@kernel.org>, <horms@kernel.org>,
 <davem@davemloft.net>, <shuah@kernel.org>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <willemb@google.com>,
 <petrm@nvidia.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: don't warn when bpftool is
 missing
Message-ID: <20261120181515.6b35726f@kernel.org>
In-Reply-To: <DN0ISKVFQRMA.2NQOCMINC8LDX@gmail.com>
References: <20261118165338.1064930-1-maciej.fijalkowski@intel.com>
	<DMYSCT1OYI5F.2HSYP9MZ2BRJU@gmail.com>
	<20261120180307.363312fd@kernel.org>
	<DN0ISKVFQRMA.2NQOCMINC8LDX@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Nov 2026 02:06:53 +0000 Alexei Starovoitov wrote:
> On Sat Nov 21, 2026 at 2:03 AM UTC, Jakub Kicinski wrote:
> > On Thu, 19 Nov 2026 01:11:08 +0000 Alexei Starovoitov wrote:  
> >> On Wed, Nov 18, 2026 at 08:53 AM Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:  
>  [...]  
> >> 
> >> Acked-by: Alexei Starovoitov <ast@kernel.org>
> >> 
> >> Thanks for the quick fix.
> >> 
> >> Jakub,
> >> could you make another stable branch to pull?  
> >
> > Are you sure we need to fix this? Do we care about the bot?
> > We have a similar warning for having latest version of liburing
> > in drivers/net. I think it's useful to let the user know that
> > they are not building all the tests.  
> 
> the bot seems to yell every other day 'regression' in capital letters.
> I suspect people will notice sooner or later.
> If you think it's ok to just ignore it, then let's do that for now.

Alright. I think we should ignored it. I pushed the fix to a tag just
in case we need it and I'm AFK:

git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git tags/bpf-net-xsk-move-fix
