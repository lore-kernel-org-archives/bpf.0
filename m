Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C8377AB2;
	Thu, 24 Sep 2026 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266978; cv=none; b=MNpKC7BjXdeQyHFExObVykognyjuGKR5xSLHwE/DhREXgTbqiIcFdtpYkEQNFlr/1PyOyXmc8t4GiPpn5gpVsfgXhA89SMdXXhaEUHxEzDhRPZbe99C5mKXqWDU9CXRUPyGo/Z2gCy/ykjrF78yGhP0wsaJqvIFXGy94eeo6NO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266978; c=relaxed/simple;
	bh=d/8J//64Ahfs4qRYaUjicRRjt8KMelyM0PY3/HnQsRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXYEVQsFZEvOrg4Fq6ZAPXp5yevkz9fb1eyzAR+vTXGpbDxsPZERuPryR2kquNHY7vtsijatGk0mh3bFYIYPZpJaXkAO6O+axERtqrhJQWvYlFriLTym6YKKqkBH2zGlihufWtZKgbGyGBs2PuUcFP4ZL5DVSswXcYROrWKV0DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izENHiTS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izENHiTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59BA1F000FF;
	Thu, 24 Sep 2026 16:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790266977;
	bh=d/8J//64Ahfs4qRYaUjicRRjt8KMelyM0PY3/HnQsRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=izENHiTSPEWQdo8vLS2HlcNA7OK3zi+RaIgTayzodVvQrotB6VyUeYIUFp/AhYxYH
	 01E8Y1Udcs+oODcfgf2tm6n+m2jBG+82j93MFlud7xdSUh3HiWPhLM+MrA8lnEPbHh
	 SdVvqUzkBhtHNm3TDRW9Ioxpjn2z45LhvHH+MATIDAlxas1Ayb4Rt+Dry2lbUrfmfb
	 njDfSoVQdcZGpGZLe1D2TK+QAJaTYcPO48SUtgsUHXts42iS59mc9o0sFqf00YYfnF
	 cr/DV1VjkbdoIAnW3hA8vSE/ZtxQkFOff7DJkZI0mKn/JgRREVIae1mJun6IN5NT2w
	 cqLybLr6nM3HA==
Date: Thu, 24 Sep 2026 09:22:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: <netdev-bot+sashiko@kernel.org>, <alexanderduyck@fb.com>,
 <kernel-team@meta.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
 <sdf@fomichev.me>, <dimitri.daskalakis1@gmail.com>,
 <mohsin.bashr@gmail.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 2/8] eth: mpnic: add register init for the
 device
Message-ID: <20260924092256.28fd0712@kernel.org>
In-Reply-To: <DLNOJJD5HT78.FEHRVJW7476B@gmail.com>
References: <20260922-linux-mpnic-v1-2-236844f53072@gmail.com>
	<179021553292.2160803.15849497453510759239@kernel.org>
	<DLNOJJD5HT78.FEHRVJW7476B@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 12:16:33 -0400 Daniel Zahka wrote:
> I don't believe this is necessary. It doesn't seem that common in
> pci based network drivers. In our case, the bar size is static. It will
> always be 64MiB for this pci device id.

Yes, we trust PCIe devices to not be malicious and/or mangled.
I need to update the prompts :S
