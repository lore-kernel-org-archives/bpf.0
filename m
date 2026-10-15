Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794B94BD375;
	Thu, 15 Oct 2026 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052418; cv=none; b=UmGIuH2JrTztCkGkJrcrgCaVFdWEjZqU0hVaO7FDQTZtH/WZOxbCiqMCz++Tysv0ZPWYJpwP76/qVppa2RnAkIxSqhA42In4kHl5AiYeRD6GDzNCm2KgOmB88vfv9DE/s8PnViYAsz8EDdEROIYSmVeAwRhgn7iqDGY9cLcbdmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052418; c=relaxed/simple;
	bh=p8s9HnAbqCE8+qwi6pNXk73AOUH6yg6uQcLSh9aPfwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lSm5YvGZah+cWtmZQdSVgLnX10hOatmpcuidqJQzlzL5iYDt4rrO2drVfzbnB4wt5EUri0yDG/j9IRvO0n6nAvvZ1abcaiscqmR3Hj/Okknrfs6M72JTKLPRK5hdYktXglN2WAZl2mCrWXg6/YNe+R5EUWYyWEGKNSn0HSPQ+tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvjJQBw7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvjJQBw7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C551F000C4;
	Thu, 15 Oct 2026 08:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792052417;
	bh=p8s9HnAbqCE8+qwi6pNXk73AOUH6yg6uQcLSh9aPfwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dvjJQBw7heBeJMH3vlSnZ7E8/UIgg0q9NrWs/21WCbC2U6dt0fGK+u0zxAGMM2BeD
	 SxjpWISDccE7aDRts2szxBBVCkafP8FkZsMnoxXWMS2Kq5bePWwpU4EOb1KSzLsBkL
	 MGfoM/fvIcN0zUTFWI83aO9PI3mBgSATY4kgqet+wOXEU59Xlk6joRRvUW1MWJ0prZ
	 jlPJuM6/IiFpVbTLpJklOErcRcwA3Uv7oI5fjln9ptOSdmzPeaTs9o3oXOZmjLm4GS
	 WU1DAxgrzwOrYXw2ddErENwdEbog8nGncXogwq0z2wC4OQSqv3jj6jGFphlRbmCx2G
	 DQmil8zQs/2+w==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v3 net-next 05/15] selftests: net: add a generic rule
 for BPF skeletons
In-Reply-To: <20261014184539.774708-6-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-6-maciej.fijalkowski@intel.com>
Date: Thu, 15 Oct 2026 10:20:13 +0200
Message-ID: <87pkxb74ua.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> net/bpf.mk builds the BPF programs of the networking selftests, but a
> test that loads its program through a bpftool-generated skeleton has to
> bring its own rule for the header. Add a pattern rule that generates
> $(OUTPUT)/<name>.skel.h from $(OUTPUT)/<name>.bpf.o with $(BPFTOOL),
> which defaults to the bpftool in PATH. A failing bpftool leaves no
> partial header behind for a later build to take as up to date.
>
> xskxceiver, which moves to net/lib in the next patch, is the first user.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

This could potentially be squashed into the next patch.

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
