Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61916485CE8;
	Thu, 20 Aug 2026 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261362; cv=none; b=jEP/gNgkOCQghNXG62XK3YtYkDLTXtFQLl4axmAspFK9cVZiovC+88hj0H02wXvbBnMbUW46euYwMsNWBN0mppmouTTTeLOrdha8o/ByUYj2yprn6pWNp7C6SMu5VmR0PhrZGUi/F8aER7DbUtZHO5wEVwLecblewahgtyHwTig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261362; c=relaxed/simple;
	bh=YkBcHx1R7H5QnrJnudubQf0nceV5RuuKGHg/ST4Bcdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/1BXypxifq9/rqXfau/JA3+ZthGAsaugFHGm/CIZi7dkH/3EOKoNG+lTzgKt8YlCC/ja8AeCQkHfAES3cAy7P3Bu8NOxrbYUGkUQuY2ck2w3tV8vq3QMpw9vq9bOePxKMuh0g5Wi2LPo0UVfDGQkwwBozpZU4Uldseeu8Qd64Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSsYwcyr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSsYwcyr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCC61F000E9;
	Thu, 20 Aug 2026 21:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787261361;
	bh=abb8MFPBEjDs9XST2lyHiyxYIcMedXShj6AB9kPMtgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CSsYwcyrS310kZRScwjY2A/kY2FanGaDVGBcGViELe+8oCRt9xoqeCfXj6H64DOIy
	 BEKubnD9jxmgHi7mU21fy/eUYX9UeljJMgwB6YGQTsIOPnKen8vkniL8eEGj0J7bHY
	 4pup6r0uIUs44XYzovp6cE9YrJM8NUox6gcdTicNpwi5V+hL51gHgngrsjQbuXNKPF
	 66x/Ypdy493MX5Yid4BT0SGp7Q6KnMIYxEsW82NUJEtjyfk4NNvb9zT/CYvS0RsUpZ
	 UhT2l9zUwqulTyzi04DRHEU0cQzi/xdgBk5rgm5qSmnpzD6iNrsL6x151PBm3qHJVc
	 QdDIjXAnkCCMQ==
Date: Thu, 20 Aug 2026 14:29:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <stfomichev@gmail.com>,
 <kernelxing@tencent.com>, <davem@davemloft.net>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>, <andrii@kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v3 0/4] selftests/xsk: improve shared-UMEM
 coverage
Message-ID: <20260820142920.6c96ec67@kernel.org>
In-Reply-To: <aoc+/OW8Gy4ZOx+w@boxer>
References: <20260819024443.781764-1-tushar.vyavahare@intel.com>
	<a602a1f6-e279-4c7c-86df-1bd0ef244fd0@redhat.com>
	<20260820104419.050cbc44@kernel.org>
	<aoc+/OW8Gy4ZOx+w@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 19:53:00 +0200 Maciej Fijalkowski wrote:
> On Thu, Aug 20, 2026 at 10:44:19AM -0700, Jakub Kicinski wrote:
> > On Thu, 20 Aug 2026 11:35:53 +0200 Paolo Abeni wrote:  
> > > ## Form letter - net-next-closed  
> > 
> > these are bpf patches. Tushar, tools/testing/selftests/bpf is BPF  
> 
> But AF_XDP is now net target since some time. Should we move the test
> suite out of bpf directory then?

True.. but until the move happens it feels a little awkward
taking pure ksft/bpf patches via net-next?
