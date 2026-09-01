Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C49F224B05;
	Tue,  1 Sep 2026 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292799; cv=none; b=QYoQg57s6YA++1K9XXh5T6MfoCFtzWtIE0jDrQdPy/BELLfKHlU+OEHJWKcu/1pzurOjodveYzOg6MRfAWkxHkJUP01DKnYtmTX5P+N5Qyg1X6OgVZK7gtZ7E8hSDneQYFmvSpMSmB8/FnlnXtNrRUNm16FJmyO63lM40BZoWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292799; c=relaxed/simple;
	bh=ebepbB9G4qAeFx1DsXm06NPoF3vBhPwUoQg5inM6KME=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ijF0F64t4xN7dqBjsaW/qVDvx+L5THfeZMwmZGclJfXSqjnWwSjzzWs7z2BclrvK1RaN70Xp3dV7csvLZWY4XJrr4jQfojUj4qWQmRkfTC1HDLNFsRZZEVoHmx4FmB8vNL1yPFuQoFdgNo3vfg4yQnGIo0GrBweGP2kIg6nOXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gt9nIEfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt9nIEfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0532B1F000E9;
	Tue,  1 Sep 2026 19:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788292798;
	bh=ebepbB9G4qAeFx1DsXm06NPoF3vBhPwUoQg5inM6KME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gt9nIEfM+3bTaBDa7zuuOOR4rBEjShoMQ5wtewKKwCzvC/F0r/m8wbiboKwlO83UB
	 zjgekqWOO18RA4xvsXjQ2DAWno/VpDFWHyoGQZU3CgNxXM9/RLcUKJsyVdt+n4rDa1
	 4GcXq6jCTxEGyK/iRfM+1lvXZVL8MiLjLxVAQnxzHh2f79UGr8oWzeJXBhPZXRwk4s
	 ZD4Y8BZD9G63Q1j8e0WKnhHwvGX0EJlOEbpk0w8iI+a7J515sJBa2sDtRBxkFcyWuU
	 rX32/8RuA8JeoDalBpmET5BoowodWQgEwZqe3op+NsSE/CP1D0GT9wJCaFnj8K0McL
	 sXiMYMyMCCVrQ==
Date: Tue, 01 Sep 2026 09:59:57 -1000
Message-ID: <0cbe2f233f77f013361d4593a88bac38@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: arighi@nvidia.com, void@manifault.com, changwoo@igalia.com,
 michalblk@google.com, liwanwu@kylinos.cn, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2 1/2] sched_ext: document the rolling-cursor requirement
 for dsq_vtime
In-Reply-To: <20260901140343.764080-2-cui.tao@linux.dev>
References: <20260901140343.764080-1-cui.tao@linux.dev>
 <20260901140343.764080-2-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello,

On Tue, Sep 01, 2026 at 10:03:42PM +0800, Tao Cui wrote:
...
> + * should stay within half the u64 range (2^63) of each other so that
> + * time_before64() ordering remains well-defined.

Two values exactly 2^63 apart are before each other in both directions, so
"less than 2^63 apart". Also, please fold this into the paragraph above.

Thanks.

--
tejun
