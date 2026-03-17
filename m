Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5644C81;
	Tue, 17 Mar 2026 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773706322; cv=none; b=ibgn1sjksTPFPNKHl8Hs81s12eybEzlv7UL3rz4TNX1QnBcbtIpxWvqci1exqwZ3suFIpqJQ5yyokFYlASAPMWkfls+f1afcUODXWLZO2/tFgyDMT5faFsyuzwBEWVAUxVAqQms7AFVQyZOhwLcQLvVwZ5CSykhyzvctRP1try4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773706322; c=relaxed/simple;
	bh=DJ9RjG5UhddWGguy/GOk4PvceX8EgZeJFZoa6ynxLe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NS3vi6ttiBa6RHbTlnaYmqy0yEwsr2ctT4cDn4PDXP2d4c7kXjWWkHo+T8jxr9wZVGjSMpyvStK8RJVBCkGuW9Z/GQ1QJGKZlkL2jI5sGxrSwHoqnlvwhtH+toPWli9HDpAgm6ovCwLv2QnuCX66B85PmnCfMxU9zrhK1YcUtgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZrcneah; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZrcneah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712B0C19421;
	Tue, 17 Mar 2026 00:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773706321;
	bh=DJ9RjG5UhddWGguy/GOk4PvceX8EgZeJFZoa6ynxLe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sZrcneahdGijQ7SSQyDiAMbnA/d7mXX3m2OO7JyXAQFnz4mB1gYH4tMY0aSibeo4J
	 1XdPnd1W0ASu1icr/wD45LP90NBwuO62kf0Z95n6iBc3dj7KlJFhSGlyU10Ow8JRMa
	 g7imzi/ONduuMRwZjDyiDGnEZoFhhnpMAUPLC0DHwyyQO8+CCPKkBu9MnqzjR5T2vd
	 AcfFUedixC9IEtnk5KMpsRiWPNxy/vfkpmtjBh7lax9EZ9mDDGJgDAo5/J/Unlljrj
	 4IjxJ7Vwm92zzPU3GIwsZuN9Ym+VCJADQY0HLbS2zl+KDg59sJ7xHfDPOgHG9rI4Ee
	 31pjYXF4S+hWg==
Date: Mon, 16 Mar 2026 17:12:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net
Subject: Re: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC
 multi-buffer Rx processing
Message-ID: <20260316171200.4b8a96a0@kernel.org>
In-Reply-To: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 15:05:57 +0100 Maciej Fijalkowski wrote:
> Commit f620af11c27b ("xsk: avoid double checking against rx queue being
> full") addressed a case in copy mode, when working with multi-buffer
> xdp_buff, where we were peeking onto XSK Rx queue twice, to find out if
> there is a space to produce descriptors.
> 
> Adjust ZC path to follow the same principle.

Acked-by: Jakub Kicinski <kuba@kernel.org>
