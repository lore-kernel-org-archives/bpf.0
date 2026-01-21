Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A4A36B075;
	Wed, 21 Jan 2026 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028907; cv=none; b=eMe2i/fHlz0lCu4zYdxKYFj+B78kuDOFvSUnJ0TtJbyfP3B2A9hqLnxtpjRgXAPh6AEsB/ExWeAuXiiHgTP4kgf7W9SUVQyaOLcY4+2l+no8eUa54eZYqjFnpvX4teJP5nBn9X4xxxVME0iDKxfnMOPi0TfS3eKD0flmUVVTwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028907; c=relaxed/simple;
	bh=mWeAXjT4mZ/Z7Yb64wIZ/8ZKkI4f+zkG1CMJFicjIFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oms0kSDJ4gOlN+WoOidd4ozkAGXgg5/exqlUCzjYOasPPMyHqq2FR4uHjMIaguyN8pP9Y25XoUHZZ0NEhbWQJGKhKy6IurVHjgaGX7rD2LiuUWq2CvYjg2Kc1fja9OAXhjIte5rn6+nOsm6BF6uSjw+oam4ZsLUrj6lSOv8kQ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GG96BvBJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GG96BvBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF59C4CEF1;
	Wed, 21 Jan 2026 20:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769028907;
	bh=mWeAXjT4mZ/Z7Yb64wIZ/8ZKkI4f+zkG1CMJFicjIFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GG96BvBJLxJ5TgskJXlOAT/eI/TSTmv3H3q6Wa5vyzvumL7eUDPUeIWk/MpFZSfWD
	 6kCqE0Lr3iwZV3f+fXtSSrK5+05yyAbYz5t3Qrv21PDO6tUCZ9w53jmkgylmdBqxgz
	 sr5ThzwKp8IG59sHeqYDhOZa4kBwdHw/nm/vlJLdIxTZAd0+kCw+F4vIyDNLN+ZEko
	 yAGBFG416ZV8/Gm4QjkSV7qDIROJpT+A9t3vE/8rblRwREE72e0TDTmwalUDlSc16C
	 SbbF8ZNzC/fnyKQdcrotB0GAhyrOsikztaBmIOEoJXi45YN+SuuzdfDsBOiPP291nM
	 eXG9YKkHUIReg==
Date: Wed, 21 Jan 2026 12:55:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v10 net-next 00/15] AccECN protocol case handling series
Message-ID: <20260121125504.32ea788c@kernel.org>
In-Reply-To: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 15:32:00 +0100 chia-yu.chang@nokia-bell-labs.com
wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Plesae find the v10 AccECN case handling patch series, which covers
> several excpetional case handling of Accurate ECN spec (RFC9768),
> adds new identifiers to be used by CC modules, adds ecn_delta into
> rate_sample, and keeps the ACE counter for computation, etc.

Looks like we went in the wrong directions, multiple tests are failing
now:

https://netdev.bots.linux.dev/contest.html?branch=net-next-2026-01-21--18-00&executor=vmksft-packetdrill&pw-n=0&pass=0
-- 
pw-bot: cr
