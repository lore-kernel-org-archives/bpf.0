Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4401E98EF
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788279; cv=none; b=KByJsbTxyYTnsTZzcKDvvXAzHovD3eIdogXDiUHAxw2WvnegqHd71WcF83Ew6wowVaqUbViyRjNLayZXKHD9mvXSvMSb7Rjs49cDmtzxN5TwL7e2khTxK2cMR2a6U2lbw2+1qTYdvgIBrlCm8YXoF2xiCSln5K3Ro0W1mWcTXz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788279; c=relaxed/simple;
	bh=EH6fJnsVjP1lunT5GAvup5PW4qTtjM4DvtSv02qoLG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o89IvHN1RO+iHwD80J8m3+kjjMl2rxIFQxW84OXZURy+bN3Oy8+vU23ilBRuqxFi4WyspTdzjE1WOmkuHDNDi1SZip9i9LV53Se+54I03oa/9BpbftjEauFcLrfAlLiwuSBjTrk4S62+ZkKyvdBIgAPchxMznqIajYj3oWGc7UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RL5SOaFx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RL5SOaFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA81C4CEF7;
	Fri, 30 Jan 2026 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769788279;
	bh=EH6fJnsVjP1lunT5GAvup5PW4qTtjM4DvtSv02qoLG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RL5SOaFxzhoPcofS8LPx5lv15qa0+ZAF0qvbm/ycaPP+ilWpuZAulikUmJFl/sO6i
	 nWipIoYkkky/T+CuUArTBTF1+Q++ligAAp0MON2f3LqvDxZc4J9PVZReJUoyqraw9n
	 /Y6m/0k4+5Bsn4tJ6jOAZaVnO0zeEbQQ0bGea3Hs6wBW/NbX2Wx0GyuuGPVhXqhdyF
	 KqSyBCp0zoDNNERWGcK+5liw1+qiiZQpJQw6rNAEpwsrAmeIfFlaKBkACp+68N9cNC
	 Ulidk1D/fG2vrnxWfhtf0pZhhQ4nOos7wVWVwQQ60o4hTjPPQ2qxWwFXrYxz3CgxVW
	 uQBih4ZFJ6CaQ==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id B0AD5F40068;
	Fri, 30 Jan 2026 10:51:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 30 Jan 2026 10:51:17 -0500
X-ME-Sender: <xms:ddN8afWOmgypplGVZCRabVCqJq0LB-sRvwo-bZT8h-ZNTZz87Bw79Q>
    <xme:ddN8aZI5yayO0z8AIb3kjwKChGsKUJwknWFEoHR4eKXMSHfioPC5FhbzY8HHafF3K
    OJc-GGOnCZSvsOD1UfwBBegnb7eUTuGk5UrgP8BZImgXzRl0d2GpnE>
X-ME-Received: <xmr:ddN8aapFiVBwT6zv1eXKMK0Hd48TNm8_VcbvGAWrS5lCTl5hfxtejCaY2mYHUSnyOCdwWncuzMwtF3uZbjmDQD6N2XhS7_zp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    dtieegleekgeeggffhffeikeegfffgffeileekjeevgfejfeejtddtteffledugeenucff
    ohhmrghinhepmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehrohhsthgvughtsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtohepmhgrthhhihgv
    uhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhmpdhrtghpthhtoheprghkph
    hmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehprghulhhm
    tghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ddN8aQw3wG7jLLfBVM5wYtNAni8t-gDoyUlSOYZdiPw9iP1p7xPHog>
    <xmx:ddN8aetF9ckKTZNNUNNSuiF-ThqeIYLtYaMqqwADrzlMV9An6fyUZA>
    <xmx:ddN8aZ1lTuv5H-3us_G5bCgW-zgqdLlFpZ__FP1ko23K9bIp-isvSA>
    <xmx:ddN8aWBzWO90tzQpdwJagUDFV_bHycvjmz_520_xQJ1DD3kLKH9Ikw>
    <xmx:ddN8aXD_PmISclLktDYXLb7OPcc39PzAdqo5KkszjpaEYzxQWxPLmiOL>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 10:51:17 -0500 (EST)
Date: Fri, 30 Jan 2026 07:51:16 -0800
From: Boqun Feng <boqun@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [for-next][PATCH 3/4] srcu: Fix warning to permit SRCU-fast
 readers in NMI handlers
Message-ID: <aXzTdOTyxuH-51_t@tardis.local>
References: <20260130154607.755725833@kernel.org>
 <20260130154639.883617005@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130154639.883617005@kernel.org>

On Fri, Jan 30, 2026 at 10:46:10AM -0500, Steven Rostedt wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> SRCU-fast is designed to be used in NMI handlers, even going so far
> as to use atomic operations for architectures supporting NMIs but not
> providing NMI-safe per-CPU atomic operations.  However, the WARN_ON_ONCE()
> in __srcu_check_read_flavor() complains if SRCU-fast is used in an NMI
> handler.  This commit therefore modifies that WARN_ON_ONCE() to avoid
> such complaints.
> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: Steven Rostedt <rostedt@goodmis.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: bpf@vger.kernel.org
> Link: https://patch.msgid.link/8232efe8-a7a3-446c-af0b-19f9b523b4f7@paulmck-laptop
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thank you, Steven! I will drop this in the RCU PR since you already plan
to carry it via tracing.

Regards,
Boqun

> ---
>  kernel/rcu/srcutree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index ea3f128de06f..c4a0a93e8da4 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -789,7 +789,8 @@ void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
>  	struct srcu_data *sdp;
>  
>  	/* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flavor values. */
> -	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());
> +	WARN_ON_ONCE(read_flavor != SRCU_READ_FLAVOR_NMI &&
> +		     read_flavor != SRCU_READ_FLAVOR_FAST && in_nmi());
>  	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
>  
>  	sdp = raw_cpu_ptr(ssp->sda);
> -- 
> 2.51.0
> 
> 
