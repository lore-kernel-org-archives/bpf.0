Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A783B961E;
	Mon, 27 Apr 2026 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296374; cv=none; b=A7rVRQ8dQccUI27pVx4W/0BfZmlI7PcDJqYZ8f6d4J3ds1yDMDjNl9eBUAA0L9y7czXqDsdbFEiQEhrLMUzVK+g1qN4aFPuud/OHlTdcgCIGJMKbouwLCLprFLk6Pv16r53Q5Wig6khMmMHDJwWX7XgLSztUZGePyuBtR7Q7BhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296374; c=relaxed/simple;
	bh=BDkj7YVQFAxjnxnHDRny4xojTgohXtJAYQ0d9twVMMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKAVt5H8zWEUzttq/G/V0w4qhQJe3g6keIZf1YWCYznLLNW2S+/zt3lfrr+n2uyrhIdW2MLaa5VfhEaMmLhRKe7LAFk2vMYCmE9M9UxcFv6EIkZCgYRWcOkJnoAIqsfp7NWybyhzB+RtphHW2Zda45NNSkrQjrClzGHtmi8mkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nt7rqbCa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nt7rqbCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFF5C19425;
	Mon, 27 Apr 2026 13:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777296373;
	bh=BDkj7YVQFAxjnxnHDRny4xojTgohXtJAYQ0d9twVMMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nt7rqbCa543sSR7MZQrstQeoTj9Okopjt49rNPG5QZvzjmY92/FVflkpGFT0C9odc
	 sqmF8er7GOWbYpPXDU37Mkmn6YxgwGmZNfljmcHKk9mLDw5+A5eIllwsBWvl6lLQiR
	 y/ynbsk1BexGUrSbfQMglqxSQY7aspV+OSe2zvyZQ82JEMD9bR0tCGZOP2bgRtMqpr
	 P4tlTLguMZGaAcQYL/dFZLprJ8PVQPGa1MWQ4SHSnPLadqJgxhpMMJHKdnzi46tGf6
	 LCYWsTPv89j4uA4ieuEVyVDo8pm5TGilSW00wICgLQPXhcCi28HxswG2/uQh7dMfxe
	 goT38IN/8y5kQ==
From: Thierry Reding <thierry.reding@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: linux-next: build failure after merge of the bfp-next tree
Date: Mon, 27 Apr 2026 15:26:02 +0200
Message-ID: <20260427132604.3754048-2-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260427132604.3754048-1-thierry.reding@kernel.org>
References: <20260427132604.3754048-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

After merging the bfp-next tree, today's linux-next build (x86_64
allmodconfig ) failed like this:

    ERROR: modpost: "cnum64_umin" [drivers/net/ethernet/netronome/nfp/nfp.ko] undefined!
    ERROR: modpost: "cnum64_umax" [drivers/net/ethernet/netronome/nfp/nfp.ko] undefined!

Caused by commit

    b93f7180f0bc ("bpf: use accessor functions for bpf_reg_state min/max fields")

It looks like the issue here is that these new accessor functions are not
exported symbols and therefore can't be used by a driver that is built as
a module.

I've used the previous tree for today's linux-next.

Thanks,
Thierry
