Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D653314D7;
	Tue, 10 Feb 2026 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757639; cv=none; b=OZpBx+d2UcY+QKpDXW0vp29ENoxgWa6dVSVrWyV+JMUCdK7EhpP4sLtvkb2+psZmWYpINDYP1zRivuCVOcXhlRNgF8S6FaRpejmwmNwZnTvBBfgdZQ8q8To4sWo0jzS2xD6KmnJHj5OWEPPvK5YVIRKNby+fpHxxcbL+zcK4m+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757639; c=relaxed/simple;
	bh=ydS9yAFrAmUIMu8jskYYeyDaaknZK0/DweflNy2scOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bZbQAh0gu+8v8PyCTEj3JRA59XANqJcniKyGneic877+Zw/ySN/fD48gXsSD5vXVzZBv1DK6gXubLhKAJbpCe1w5uiO1+/Cgws+HJ7mglKH+Q103avKk6aNcKP1dBYTAU+zLdayQE3VIbbRGnzF1yH/AweaAuD75OP0HB0DOWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyF7e4Vo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyF7e4Vo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13A9C116C6;
	Tue, 10 Feb 2026 21:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770757639;
	bh=ydS9yAFrAmUIMu8jskYYeyDaaknZK0/DweflNy2scOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LyF7e4VoeCocyD3Vbvq6qOdyDlozU2ixwVjoZAxENS06BAIZQDedOydD0w/gSIBSZ
	 osUCwKX6PhwW56VKK0xYFFADnnKZT+smqwFdhNM5Ut9LHuzgd4QdFreD3o5NvlmfIX
	 NH3YU2McEzSVuJ1JoDCP+bd6oaPiVfqio+4dHebyJsa29TEFlTH3NqksmPPihrUG9o
	 kKQeTHjkwOsnsmGo12Ccplq56OFeUXNPsxVbkTTRiQg3rJtauN97aqkgYM+2PVK0cC
	 psq9TKt0upYvogmUC4uKQkD8SsgefUJ+Efd5t0DCYj8C3zSiaYb8wlgrwOZL8h5rSy
	 yYjgQFKdeeOhA==
From: Thomas Gleixner <tglx@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com,
 shakeel.butt@linux.dev, Andrii Nakryiko <andrii@kernel.org>, Ruikai Peng
 <ruikai@pwno.io>, syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes-stable] procfs: fix possible double mmput()
 in do_procmap_query()
In-Reply-To: <20260210192738.3041609-1-andrii@kernel.org>
References: <20260210192738.3041609-1-andrii@kernel.org>
Date: Tue, 10 Feb 2026 22:07:15 +0100
Message-ID: <87fr789ukc.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 10 2026 at 11:27, Andrii Nakryiko wrote:
> When user provides incorrectly sized buffer for build ID for PROCMAP_QUERY we
> return with -ENAMETOOLONG error. After recent changes this condition happens
> later, after we unlocked mmap_lock/per-VMA lock and did mmput(), so original
> goto out is now wrong and will double-mmput() mm_struct. Fix by jumping
> further to clean up only vm_file and name_buf.
>
> Fixes: b5cbacd7f86f ("procfs: avoid fetching build ID while holding VMA lock")
> Reported-by: Ruikai Peng <ruikai@pwno.io>
> Reported-by: Thomas Gleixner <tglx@kernel.org>
> Reported-by: syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
> Signed-off-by: Andrii Nakryiko <andrii@kernel.fs>

Tested-by: Thomas Gleixner <tglx@kernel.org>

I did not test this one, but the identical fix I did myself :)
