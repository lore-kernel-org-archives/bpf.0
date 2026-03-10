Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B335F3A1A21;
	Tue, 10 Mar 2026 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773110230; cv=none; b=RgzMeOVdFwGtYI59xxvmuUALvCe1EYIYSk0o6RKqCDBy5dr5eEfSecwRlCtzbR58jBrPeLmtbTBf9PwR8o8B5Lib8GwDFFUO/Ih0aewz+xuLyuHAZwfzMvIoe06cl3aGG+4xqdTb++9RRa0SS0W7eTvxQfXlH9rz7vETN7MmTBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773110230; c=relaxed/simple;
	bh=IrJ4wC93jVioPcjBWSzIL2cGYWi2Pww1hWEygg9xtsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsmSDjSOEGhPQ0hihnNcu/75Exloj85xRahf4UFuIUknYaXPHcV/fkh3fXkSj+u2jhdaXw6s/2stctUsLomchkYCRM5R0YIxADHaZ3g6aejZMoOn1OohYkw8Bj72JUOUBV1h6yFGGgFIYiDjDhLQ3pmujxCA+dN9Xap8IhtOO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzxyLgd1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzxyLgd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13548C19423;
	Tue, 10 Mar 2026 02:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773110230;
	bh=IrJ4wC93jVioPcjBWSzIL2cGYWi2Pww1hWEygg9xtsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OzxyLgd1PcJQCK1A33JypF5fmK8DgTq21xxNk6xFpUI1wPfpZkDaqMNF3+dmXGXDu
	 XavWCzo+6XqTVICI4IfzlEosGzqHlAuWL40ZLc4rYnCbsWTqCZrF6qIekSE9/bECs6
	 0KP0+kcCVsWn5dZWhiyCF4YMcXBDiFQ8sBEcPIxN3E4bg8AKTRzMLr1RzZZGEog7dJ
	 WcYBQRldv0vWLsUuSxyjCt0HGrH4InKxo3TJ3si2HcYj3yB/JfJkI+35kg2LvrYwlG
	 HWK0Go+AoIDjxtbarySuKvmcKQaceja8trp/yXV0M6FxJJj1jwO9nd5E3K2olzPQ8Y
	 byZ5M3ERUXhpQ==
Date: Mon, 9 Mar 2026 19:37:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, joe@dama.to,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 kernel-team@cloudflare.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/5] bnxt_en: Add XDP RSS hash metadata
 support
Message-ID: <20260309193709.2f1f865e@kernel.org>
In-Reply-To: <20260306230600.1628196-1-carges@cloudflare.com>
References: <20260306230600.1628196-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Mar 2026 17:00:15 -0600 Chris J Arges wrote:
> This series adds XDP RSS hash metadata extraction support for the bnxt_en
> driver and includes selftests to validate the functionality. I was able
> to test this on a BCM57414 NIC.

Looks like we hit a conflict, again, you'll have to respin.
-- 
pw-bot: cr
