Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66743EBF32;
	Sun,  1 Feb 2026 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769905469; cv=none; b=SmLsNsxHJsNz+KVGPr2CHgEoDjxR03hfS6gO2X1CPNzGuedgHO2uPX1gj9+hZZYSyJTaEJY661uIElAGtVTLDHJLPyc2HyabF7QZbd+vDYRL/FZCcUiadVFOUKipzS2U7IMJDr8d1GjVhNff0noMNnzU/D0lnTl72sFmguUWsjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769905469; c=relaxed/simple;
	bh=deT1os3gwcyPUwfuAHtNhxe293mF+dXR5IBQuQzUJOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nd2ZzRhyq2nsEsHj9Lx+/e4TPFoFKhFkNmFr2MI1O4L3EH8dLCut1DSSoWZlm3nCtys27NktHVdVYw86h7si8RDc6EycPnvdXk5AQlb11ftfGs6lVf51yOAFoCETQHtJzYctmVZcC63fGxfmHWZj8n6g1cUXJ0qQDy6bEegDLKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMi7VuSo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMi7VuSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA5DC4CEF1;
	Sun,  1 Feb 2026 00:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769905469;
	bh=deT1os3gwcyPUwfuAHtNhxe293mF+dXR5IBQuQzUJOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AMi7VuSoy8R3XEPAN4lpaGh7OHYn4KVSaftIiHAfHc0kLcrH2WyKIWO6Wt8wN9HrA
	 qmcRSVDNRwecMVuXVtLX26iM8VS5G6YHJyZXORy9OKuyJCiIuF72Rw+FICqbXWeJ38
	 q1CHJJOYAo3lNX1lyq2/4fIABr7/eZAuukpQ9sS5fYHZ7hOKzGqd8nlMXHmOlfNLsW
	 Vb6Ux2oeIcnuREsT1+CP+46w2PfZWw9aUVbOZD/fGWs+Slu8v1WhVpJZPWKDGRYM77
	 9nBHGK3RLIggSUtRyYxhH1NeRy+/cjQTUQa96yxrqO4f9vYss33pgiuTuxpYzqmw0k
	 StoHItHm/jYfQ==
Date: Sat, 31 Jan 2026 16:24:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 16/16] selftests/net: Add netkit container
 tests
Message-ID: <20260131162427.741b8085@kernel.org>
In-Reply-To: <20260129222830.439687-17-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
	<20260129222830.439687-17-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 23:28:30 +0100 Daniel Borkmann wrote:
> Add two tests using NetDrvContEnv. One basic test that sets up a netkit
> pair, with one end in a netns. Use LOCAL_PREFIX_V6 and nk_forward BPF
> program to ping from a remote host to the netkit in netns.
> 
> Second is a selftest for netkit queue leasing, using io_uring zero copy
> test binary inside of a netns with netkit. This checks that memory
> providers can be bound against virtual queues in a netkit within a
> netns that are leasing from a physical netdev in the default netns.

We should cover the uAPI and the tricky part of the handling please.

So off the top of my head main bits:
 - the expected attributes on lessor and lessee via Netlink
 - destroying the netkit with MP attached
   - checking the state via YNL,
   - attaching MP from the main dev to make sure we didn't leave
     anything behind
 - destroying phys dev while netkit exists (prolly netdevsim :S)
 - making sure XDP can't be attached on phys dev when MP is installed
   via netkit

... whatever else you found to be tricky in the implementation.
