Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D4232E72F;
	Wed, 24 Jun 2026 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326129; cv=none; b=rTC/0pf0i6KesRUpT9VDBBpCpOFvemX2nNM0F5HSr7JhL0pIyDObDGBUOH4hbIeBQ9/AFaIP5uuJJnE1B06sqYHm8cK6xQ5drq7U0zz3xTZtdDpCy0BzqaOnImzQr2VyEF1nYpFXLsVPFH8vqtnm+YHXjlgm+6DcfVElnyPTgVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326129; c=relaxed/simple;
	bh=szrL9rlIGd2VV3QTTropIAV8m0dSeDv2Q//C8M6ZboI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FE06N3hjmWqKIaDsHB9y98gHQqgcGlgUUekFCYsFO/DikKOPI2h8rPeG5/f4PY96jXOiAV/O0m6sR2YMJ8xkDFdmxP1Xvxc4hbSi6N0oiVj1lwhmcg+N0nniCTjhUVAfUKVwi+29JuR5scbDbw/ugSRlJ88U3mma/++76mHKSH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AN8Mrxw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AN8Mrxw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEF51F000E9;
	Wed, 24 Jun 2026 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782326128;
	bh=YAboVfwc1QfQPVwIz2EVr8r9cLQ661xccsxlovsNOHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AN8Mrxw+02JiZzii1M+Z2aPTJsEF+RP8GjT86hmVJVBgr1t6Q6pPOgsJs0XRCoynm
	 p05guQ906oXMDdqlW0DXIz93WDEg1V9GaFPdbr/qNv4KL4EAGXts2sh7pb19FxbL79
	 hrFiQxqj2Y21J5tQZuLRksEeTR6poE83YsiUZcVshY7aZLhfr7QaJrBTlsRhFuzpz4
	 sPH3awmgy30N0SoCDje+jUqL5r4XK4sw2l3UH+rocuMEYitdcFu70NBhVC1zIep1yF
	 L6h1/fqYvfbc6YXeSunhaEecqg+8G7y+jZnxXLO51S/GAPWQyDp6qvLlb25cUH0nYZ
	 WRla4BDfoh1+A==
Date: Wed, 24 Jun 2026 19:35:24 +0100
From: Simon Horman <horms@kernel.org>
To: Hrushiraj Gandhi <hrushirajg23@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] netdevsim: fix use-after-free in nsim_create and
 __nsim_dev_port_del
Message-ID: <20260624183524.GE1131256@horms.kernel.org>
References: <20260623144447.255326-1-hrushirajg23@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623144447.255326-1-hrushirajg23@gmail.com>

On Tue, Jun 23, 2026 at 08:14:47PM +0530, Hrushiraj Gandhi wrote:
> debugfs files created under a port's ddir (ethtool/get_err,
> ethtool/set_err, ring params, bpf_offloaded_id, udp_ports/inject_error,
> etc.) store raw pointers directly into the netdevsim struct, which lives
> in the net_device private data kmalloc slab.
> 
> If these files outlive the netdevsim struct, a concurrent reader can
> trigger a slab-use-after-free by passing debugfs_file_get() (which only
> checks dentry lifetime) and then dereferencing the freed data pointer
> in debugfs_u32_get().
> 
> In __nsim_dev_port_del(), nsim_destroy() is called before
> nsim_dev_port_debugfs_exit(). However, nsim_destroy() calls free_netdev()
> at its end, while nsim_dev_port_debugfs_exit() removes the port's
> debugfs directory. This means the slab is freed before the debugfs
> files are removed.
> 
> The same window exists on nsim_create()'s error path:
> nsim_ethtool_init() creates debugfs files under ddir with pointers into
> ns before nsim_init_netdevsim()/nsim_init_netdevsim_vf() which can fail,
> and the err_free_netdev label calls free_netdev() while those debugfs
> entries are still live.
> 
> Fix both paths by calling debugfs_remove_recursive() on the port's
> ddir before every free_netdev() call. The subsequent
> nsim_dev_port_debugfs_exit() calls become harmless no-ops since ddir is
> set to NULL.
> 
> Reported-by: syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6c25f4750230faf70be9
> Fixes: e05b2d141fef ("netdevsim: move netdev creation/destruction to dev probe")
> Signed-off-by: Hrushiraj Gandhi <hrushirajg23@gmail.com>
> ---
> v2:
> - Also fix the same use-after-free window on the error path of nsim_create() as suggested by Simon Horman.
> - Shorten the code comment in nsim_destroy() to be more concise.

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

