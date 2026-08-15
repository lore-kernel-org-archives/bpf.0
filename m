Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B770360EDC;
	Sat, 15 Aug 2026 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786785038; cv=none; b=SfMp4LbSp0tyR52Xx8Bjk86AklhwNEuIsZjLjm5dzqgwvTGcbBvr1q6F5l75ycD7V0i4/RSdo8SOczNg92P9RmkPnFqwBeR/Pz079TXnanvLqj8HJ/+TIaAzd5WQF9JEs1cX1EjYJvojhyr+h3pJBjhONOLeBsW8AQK1ndSAAFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786785038; c=relaxed/simple;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=DfTsI+Qouw0HELqeDjekaJukKyChjOSJG44tOCDK6BwzIRcFFzjVjdx8QTubWdu9vebRWIVBLVAdwEPptvu2A8vZHi2JYf+49CVGJvkq3LCGvRSpa6hU1nhhH0UPQkZY7LNOeM6xSD3LLwL2y2SR69BbK7di8xmLMMUpdTxv6sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLe+P0GW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLe+P0GW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E191E1F000E9;
	Sat, 15 Aug 2026 09:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786785036;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fLe+P0GWokrm5R9ovqnB6LYnzbPjs5w9tv3q65XPFszt1F84VodPK6dpnQ3JulKDT
	 Zj2cQDhQF/C1GcbPLsZIpJ95gefXsqjQtwYy6uCrgWhewaSQlrJ/lgdW7pB/qQEnmk
	 /Wa+p4mwZiirQZ8slPaNgeTQg1YYgA7RfJpNEVXbWS0ar61l3NE80mZVqJzzi5tbEl
	 IEZHV6P0A4Nlr/sLitUaeZ+7AGjiMBp9xqLGnq+CwtTQ9BoqDW8GrewJVWyRQ28F0l
	 mjLEzFwnE7MSS6ao4uNOFyvn0mkJff7nstZbIfmIRt2ry6s4wtVex3XAF7wrEXIq3b
	 OhWNP733ay60g==
Date: Fri, 14 Aug 2026 23:10:35 -1000
Message-ID: <6d993d65a1588a60e321a5e9e34f3501@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: cuitao@kylinos.cn, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] sched_ext/scx_flatcg: Fix cvtime true-up on slice expiry
In-Reply-To: <20260815045905.3431991-1-cui.tao@linux.dev>
References: <20260815045905.3431991-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Applied to sched_ext/for-7.3.

Thanks.

--
tejun
