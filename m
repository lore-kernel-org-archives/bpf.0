Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C4F3C2D;
	Sat, 27 Jun 2026 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782524939; cv=none; b=Z3CZ2wHiDDaHqWVRoaliDceuxVccgNv118xRcfRulYh0hu0n3T9ZUgW2VuOxvz3pFOtEqry31dQGZHvTV4VyTTXerQH88atR83euqwOHUJXtjyggF3wKEU98F4wpr4kvpySFfXLMxSNOnfvK2sp+OdbsTHF2oOu+R+WvWboeTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782524939; c=relaxed/simple;
	bh=tY+lEB1fVZf6CWjOO86JALvtnSr8NyG046MrlCmuTqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQJKYLHPE2TPTnjunSw13T1IghqCl3E6G3WMNX0nG1/QWZoHU5t77H6atLTeUoewfYv/LNQxZ2CspNY6Qf08pe5l9KpWckvf0gwIqRnCXA0N1CwBPa4SYiOSuP/VakTbNGts8FL8h6t0Ho26dPxsy12DbXfYrsxIXxPcQiR2A1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaS4COb9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaS4COb9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0D11F000E9;
	Sat, 27 Jun 2026 01:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782524937;
	bh=qGuvAgmfPhtioQ+ccOiVR0g2fE1Chcr4teyYLHHEAjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OaS4COb9c2t10ErVf8Tloketd8CgUu2/Y3/SqXTbI3O0dTQVjM6lE6i1+nARWiduR
	 iadyrQumdNWzqc+o+TibehYZbLftw3+wB17uPWCfAc74OTk7kPbyrnXUzomw782r1z
	 V7E+ICyFOpInt2rBUfMqgsMOzToS3sUdQBcDQCZgja1Gts8j8/dplhRGJuphWAqeeb
	 d5yNfstggVSQeRnRyQsOmfZRon057ciZdvMMETHWyzkumpa6onSqWB1UOLqSxLSjVe
	 LJ8tUrb0peIBnIRRG6ZhV3HJiIXC+PvjmVr4Z4urZ+dYTPUwzaDG7pANGFL3I1yCjp
	 IXE0v3inrWBtg==
Date: Fri, 26 Jun 2026 18:48:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hrushiraj Gandhi <hrushirajg23@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] netdevsim: fix use-after-free in nsim_create and
 __nsim_dev_port_del
Message-ID: <20260626184856.4b7f5228@kernel.org>
In-Reply-To: <20260623144447.255326-1-hrushirajg23@gmail.com>
References: <20260623144447.255326-1-hrushirajg23@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 20:14:47 +0530 Hrushiraj Gandhi wrote:
> Fix both paths by calling debugfs_remove_recursive() on the port's
> ddir before every free_netdev() call. The subsequent
> nsim_dev_port_debugfs_exit() calls become harmless no-ops since ddir is
> set to NULL.

Looks like the wrong fix. All features clean up after themselves with
the exception of ethtool. Save the ethtool ddir and remove just that
one. This will align with how the other features behave.
-- 
pw-bot: cr
