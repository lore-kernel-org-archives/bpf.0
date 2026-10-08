Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4937DAA9;
	Thu,  8 Oct 2026 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791495016; cv=none; b=VsgYswVTD+ZVvs7RkqlT1SC43OUEzO0hhxFc43cplxCh24C43u7E7VbR/+BIoyID+fMEYfVyAKk9i+3ltv+t/lgdEo73ZfM3afFA4TUEMeUWBFQ7wEEF4O1gt+94TG5F9nCCHshogl59hRsiLFOwHh0synDz4zDoZoJTMJUVxY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791495016; c=relaxed/simple;
	bh=hGcZVrOJuaGbahltchAp6080iRAh0iXWMWo3WMPCTWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdM4soebalcb9wSjWQygBSKMee3kdv1UszRg+9sV9d4h33Y/HtVBMDf+lziQYqyrLQ2AAGPbL55eR6t655ov61rQmb8V8J81kiqyNvFRQPhpzUU2zS/flJ+dy+Tz0yHIiWUYwqwUoaLIQ2Yj7CaKtWjay4Ll1CtwbIGL4bGmm2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwstiDpa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwstiDpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C531F000FF;
	Thu,  8 Oct 2026 21:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791495015;
	bh=WQmTsfpeMQbZkT0tmyNhyT866EXm/mO+VFYcZUCvlEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lwstiDpakfMz1CgjmvNXlBgt9y9Cg4j40BUjUf6MBCtUB/jLY9l1hONjnwxAEoHL6
	 RsUAl2Rt/qi+8JBUrqGVKTmWQCBuyBX4YGarrMASLK4zwLx0HjdFfvYkZp8zf64oR9
	 pQdsWF8RMT8yXG/i5KXLEEY1pq+pV6oyWFRPANU60AodzZVMTmWRHYViLixDpqzhZr
	 1vq1kW0M5vCcf5TOW7yLzRNM9iRxYmgvfudP5nTBs/PCA9zmZiAP2gero0W9yj/xKw
	 WFMjKLVSE+hi8rvTRkHMc011k6Hv27n1u4wffT/BQcrq5E4VblDjIvb47+uZkwHJcn
	 pZ8DBQP6z0zrQ==
Date: Thu, 8 Oct 2026 14:30:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, bjorn@kernel.org
Subject: Re: [PATCH v2 net-next 00/14] selftests: net: migrate AF_XDP test
 suite over to net
Message-ID: <20261008143013.55b0f462@kernel.org>
In-Reply-To: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Oct 2026 13:48:55 +0200 Maciej Fijalkowski wrote:
> Heads-up for ice: to reserve a queue, xsk.py updates only the RSS
> indirection table over ethtool netlink. On ice this also turns on
> symmetric Toeplitz hashing, and restoring the table afterwards fails.
> The fix, "ice: keep the RSS hash function on indirection-only updates",
> goes to iwl-net separately [0]. Without it, the first case that takes a
> queue out of RSS fails in its cleanup, and the table stays modified.

Good news it that it applied, bad news is that the non-HW test_xsk.sh
crashes the host:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/857863/166-test-xsk-sh/stderr
