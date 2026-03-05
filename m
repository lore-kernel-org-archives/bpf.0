Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC89820A5F3;
	Thu,  5 Mar 2026 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671008; cv=none; b=TgNZtyqupiwvWsOc3fEjeHMTTl6XoyKK6QYWttPu4VeNvTpOTZQYR1Ds/5Nq+YCyZRD1DwHpSbyknc4kd0UBgICsNs6zq4iN/S5+ovAF1plwbnKgGy7EsYp46dAMtIcmOYoOSzb1W9bEWf6ck65feJjkXTVEtfPiMZM7ehRgimE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671008; c=relaxed/simple;
	bh=YKalpB8/rUvFs9g/hYXsIJ5wpix29Oe5LQMz8wFRhjs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hsLQ/YMZR3C5BO4UHkp+qc6ZrYouie6qCf/AGxg17EOtPEnmnwl3R/S3Hx/lakTT9RnqWYgmeIi9akmMWXwKo/+v2k1NWnNplafMxxgAAcEOBwWdyp+Pqtd3ioNBrvp3kKjyT630C5pQGd5Z2PmClJVQjwwxaPcAbgNntGf7NzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcLjbQFE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcLjbQFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67704C2BC86;
	Thu,  5 Mar 2026 00:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772671008;
	bh=YKalpB8/rUvFs9g/hYXsIJ5wpix29Oe5LQMz8wFRhjs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dcLjbQFEywZdqEcvLQK213BmmFnLr9VtKG+q2SYTZbiA4hQjRnHnprt0Y3Tx3If92
	 45dSUXZJOCgs4pn+TpR88k8E7x38KZ0Zh8gjDPQo5Cp0UXBaooCTVvwh3x9UiA9POh
	 xLnqlQXAhWo0M8IVQHD4Y0jKu9kcVdBD+2pp+MNxkgDXLYxi9+CcE+mt1krh9xArZR
	 w1sx2mutIFaw27i4woHJ3+ixxWNRCNKqiCP5oDu8hXhfkXPtbx5tDMGuxPnjoGfF6U
	 BzARV7IilnyN3x/pK5Ibt44OOILey2jF319L4aGYo4KnmmGomWvt8FwE+txiy1SpF7
	 x5xlCakDvJyNg==
From: Nathan Chancellor <nathan@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
In-Reply-To: <20260226-kbuild-resolve_btfids-v1-1-2bf38b93dfe7@linutronix.de>
References: <20260226-kbuild-resolve_btfids-v1-1-2bf38b93dfe7@linutronix.de>
Subject: Re: [PATCH] kbuild: install-extmod-build: Package resolve_btfids
 if necessary
Message-Id: <177267100716.1730256.8133428757987285416.b4-ty@kernel.org>
Date: Wed, 04 Mar 2026 17:36:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev

On Thu, 26 Feb 2026 08:41:48 +0100, Thomas Weißschuh wrote:
> When CONFIG_DEBUG_INFO_BTF_MODULES is enabled and vmlinux is available,
> Makefilefile.modfinal and gen-btf.sh will try to use resolve_btfids
> on the module .ko. install-extmod-build currently does not package
> resolve_btfids, so that step fails.
> 
> Also package resolve_btfids if it may get used.
> 
> [...]

Applied to

  https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git kbuild-fixes

Thanks!

[1/1] kbuild: install-extmod-build: Package resolve_btfids if necessary
      https://git.kernel.org/kbuild/c/459cb3c054c23

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped or
reverted. Patches applied to an "unstable" branch are accepted pending
wider testing in -next and any post-commit review; they will generally
be moved to the main branch in a week if no issues are found.

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

