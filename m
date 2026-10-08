Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609E22253B0;
	Thu,  8 Oct 2026 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791417631; cv=none; b=dR8lxlH9fSivz/tvFisGY6KvPe1j0jMN3RpvylGLFnRo9+hAvbQHnFhXC3n/hmzcUTlmJc1W6XKHOgVmryRoN2L+paLj8cxD/h+lQ+Bg5ZfHgX7eS7hbsR6USRv8OWC7znPmlXE8w7peRW5V/7APIQHHbxTgNbg2FzbGYbXopU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791417631; c=relaxed/simple;
	bh=YRwerDxd3kQSJgTe5HjOwiGE5oyvlx6BcwgSNjGbF3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foCWLKJfT5OSWYA1OSNyl6X8njyCj15R0ahjxdF6Ng58ySxkMGBmZ1kyofy7hXGUhOOGnVNrUNKnC7H0VPrsLD+krncT7UVkDk/onrDT5PIz5E5nC6KKTtAsSGuLd9/cDnTmL5xZi0n2kNdImbr3Dyf4yvSwcGk5EZSxCsfISZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B58zzxLw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B58zzxLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5F51F000FF;
	Thu,  8 Oct 2026 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791417630;
	bh=XcuH3LG1dKuUFLwzOh6jw6CMGpNhpT6Di+aA26s77nc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B58zzxLwrcvpS26HRCUNgu2N09L7f/YnuSSCQ0QXkAtNBS+K9V6lrjj5lvGQIAicA
	 LRAP7+0x5EYs+DcbtTO8HQRx1tGhpE/nbnBT4K4UPGqaA1u+UCDzQJCa+FB8UWYKaC
	 uF+tJIqLLaYEe3ELk4mUK3uhvDt5cdRFuXXF8cmE+hbbGOyvcnrp3mnaKji/9qQliM
	 X+o6HZ6UfSz9fZQWDl/il1utihaqACh/rInvRtqOW9NS9kQ8pcKBQWdasjjK51VI90
	 xiMMATml5GZCAjkVxEuaNAMuFsxDXda80J5+vQ+ybwjhVnoRLH4+u1IObgJ9OA9YUQ
	 ZXJ7bLVrMg97w==
Date: Wed, 7 Oct 2026 17:00:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Irlanki Sandeep <irlanki.s@samsung.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, edumazet@google.com,
 davem@davemloft.net, pabeni@redhat.com, ncardwell@google.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, corbet@lwn.net,
 linux-kernel@vger.kernel.org, lorenzo@google.com, maze@google.com,
 sporeba@google.com, motomuman@google.com, madhan.raj@samsung.com,
 srihari.k@samsung.com, g.pokhra@samsung.com, r.kumawat@samsung.com,
 raj.kumars@samsung.com, ts413.lee@samsung.com, ramyashree.s@samsung.com,
 daeil2.hwang@samsung.com
Subject: Re: [PATCH net-next v6] tcp: add BPF kfuncs to set per-socket ECN
 mode and AccECN option
Message-ID: <20261007170028.318acb6b@kernel.org>
In-Reply-To: <20261001132759.1076145-1-irlanki.s@samsung.com>
References: <CGME20261001132701epcas5p2da9b0fa7ca3bcef1ff84a62f255bc573@epcas5p2.samsung.com>
	<20261001132759.1076145-1-irlanki.s@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Oct 2026 18:57:59 +0530 Irlanki Sandeep wrote:
> Suggested-by: Jakub Kicinski <kuba@kernel.org>

This needs an ACK from TCP maintainers. If you respin please make sure
to drop this tag, this tag is for cases where someone suggested sending
the patch as a whole. Not for changes requested during normal course of
review.

There was a false positive from sparse regarding the use of kfunc,
I kicked off the AI review manually, please check the results here
in an hour or so:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001132759.1076145-1-irlanki.s@samsung.com
