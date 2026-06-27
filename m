Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B72F84F;
	Sat, 27 Jun 2026 01:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782522584; cv=none; b=qQF+k5pqfe9xM76R0rGuCohuZUTJq70cveRHwq9p9e7q4t82P3kfKN0snLyxmpUgOLoPFRZ8jzPLg9LcVELnknmLFtGlWBorFt3vAzQEDot6hy6xjo5K0L1ZpW1Iw+rf30MGma9O8Bwr3vSh3bxDaZYvKviy7bq0O/GSgWxKyJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782522584; c=relaxed/simple;
	bh=cGWoWNfJrGJ0ITUtYPgpR0iy+uM43rkz2fY6kafwZiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3wzzpw55GjdumCSO3GB8vOLYQIC5T244UlD0bZmAyUdgf+StAVXBfPRzF8FyTZC7hCLmawwvziCzy0n1L3Caq1PljL0Nda/S9O03V0rkz8BxpgKYAtsUc5BnoqGdk44H2IcJpoI0HKceyQPaxo3XqXBMDWTzdnMs9gXP9PcGHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hY5nuNwZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hY5nuNwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885C41F000E9;
	Sat, 27 Jun 2026 01:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782522583;
	bh=18ZyS1+GL1I0U9VQ5nRoZRnBU5LsQ3VgtvNPyetNtyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hY5nuNwZfbkNRSCm/bBgq4qtg+87aqMqT8n5uwRBjrheG63kewr92kbNuOAVluyVJ
	 6Bg1/xnobim9+QZ0dwW0+DusmP6cgbRtb7R4rmFnvLxExiSSLK322/79ORqCkyQChF
	 Opn5GiT9VcJnzpbxA1vCaa/8XNjDOecFa7dH9i6hzcOWUTAUIjJpTB2newPBY6AXIn
	 cVMK1YEY//EKsp+H9k3rZqyk433jcTEnA/+Q52UL7Hbjv71WFxDPmyRRDUmST/zXPY
	 KZKE78ixolnYs0xSdTwBkdpectVC7169EUVZJSjR/YTj1FVrnoB5zT0qexQ8+JYHXo
	 NZ8Ei0lHBN7UA==
Date: Fri, 26 Jun 2026 18:09:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: kraxel@redhat.com, vivek.kasireddy@intel.com, Shuah Khan
 <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] selftests: Open /dev/udmabuf O_RDONLY
Message-ID: <20260626180941.45158025@kernel.org>
In-Reply-To: <20260625181557.1086105-1-tjmercier@google.com>
References: <20260625181557.1086105-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 11:15:55 -0700 T.J. Mercier wrote:
> Write permissions on the /dev/udmabuf device file are not required to
> issue ioctls and allocate udmabufs. Applications should be opening this
> file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [1]
> 
> Remove the write access mode from the drivers/dma-buf/udmabuf.c and
> drivers/net/hw/ncdevmem.c selftests.

You need to explain "why", too. Why change it if it clearly
worked for everyone running this test until now.
-- 
pw-bot: cr
