Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63B37B413;
	Tue, 16 Jun 2026 02:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576227; cv=none; b=PVwmllBjv9fIvXWSxqMt8Hi9Thw61Ej3gAmRfZajEutcnXoziHxtWwJrgnrG46JVK3yOAeCVvNGgaBchvxEluW6yjXX2Oe8XfQVWmXw2mistMd9GzjtHxHSbrgqoBclI1c5aPANj3OwmUds8bpV9m0YWe3vzTfM6yXvfFu4eRp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576227; c=relaxed/simple;
	bh=iYuwh/QjPCaFltZgY1oNyGfCkwfgJLRV5G8y/pey57o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDwyFBXPviVRojsR9lz2pUixS+AkXHmOkoMenmN6JcArVvgoIg1fD02gTj/McWu8yE9fav7qzQO1tephnUuFpleif7+ah3gmC2610VsjDOgVhWOfhxrU12SM8YVwJbAY2j4RhLTYxBI/IJuo3lnFGqNF+lva9AobhhaBS4CREbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OStTHS9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OStTHS9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E4D1F000E9;
	Tue, 16 Jun 2026 02:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781576226;
	bh=xD+Oip3IRpQPzSxenYyTvneudjF43QmGVA6/28MSifo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OStTHS9ceHewKrSU9o18QwJHMw4AaB6qp16uTX1ZTaLPmPIBVJ1pSMw1/lJ3jQeA+
	 G1Vj/m3qrDZP/n3iLx4qkdSkdRQD7RAXYKDxBmdm/4HEpJs6zXA5x6lFVaHtN17NAI
	 hw74FSwUS74Zigh7lKdAGeN2AS+22bqzFTCbWu0athb/SR13nF5ZZT3dcoGyc1vCHL
	 BHjECOGWU8Y7vIwGaDgVr1A4bbBgAtxKo1f8Q6Qn65+vqV6m5HJXYSEBJOYKaMqWjV
	 i75kqeYQMypXa9zyHUjO7tSEBlL7sd/dgKS8PXvUFzFLOPYGDDsrrFm92iX/5Qa371
	 H7KQ1oHer7+Qw==
Date: Mon, 15 Jun 2026 19:17:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com, ncardwell@google.com
Cc: chia-yu.chang@nokia-bell-labs.com, jolsa@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, linux-kselftest@vger.kernel.org,
 memxor@gmail.com, shuah@kernel.org, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 horms@kernel.org, dsahern@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 stephen@networkplumber.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, kuniyu@google.com, ij@kernel.org,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v2 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback for TCP Prague
Message-ID: <20260615191704.31be22da@kernel.org>
In-Reply-To: <20260615185102.5e8de52d@kernel.org>
References: <20260614071756.239686-1-chia-yu.chang@nokia-bell-labs.com>
	<20260615185102.5e8de52d@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 18:51:02 -0700 Jakub Kicinski wrote:
> On Sun, 14 Jun 2026 09:17:56 +0200 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > This patch replaces existing min_tso_segs() with tso_segs() CC callbak
> > for CC algorithm to provides explicit tso segment number of each data
> > burst and overrides tcp_tso_autosize().
> > 
> > No functional change.  
> 
> Eric, Neal, looks good?
> 
> The min rtt thing in tcp_tso_autosize() helps a bit but if the sender
> gets congested for a longer stretch min_rtts on new connections are
> high and we're back to sending small TSO, keeping the sender overloaded.
> Which is to say - I _hope_ this also solves some of Meta's problems :)

Ugh, I didn't see the Sashiko report, it's only CCed to the author and
bpf@, not to netdev :/

The zero-check sounds legit. Let's revisit this after the merge window.
