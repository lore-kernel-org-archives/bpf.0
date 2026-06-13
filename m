Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A7714E2F2;
	Sat, 13 Jun 2026 04:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781324048; cv=none; b=cJbSM1d+GIT2V3rietVrNGlWXUobBzwCQ90XY+LAoG+wY6/UBcPaTQUlfr9h4oMYcnjMjYSKza+HQjVYT80HVagqLMpG3AT1hwrw5tvMglmELrslbcgP0K9ItsvzqerxkHn+F9jrrCjli+FGE00twVhgzsyRZbgHimCmt0NznUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781324048; c=relaxed/simple;
	bh=YbDlaYrGKm4vxXwBsBm4BgX0M+Xn0fHQwIH17HJWvBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s41seW0EEaq4+lpdv+X0gIVH7GkDDyiea6jFHljR7FaNpx8kKACcnluD5XzeU5wH9XZ0bvMOkBxNeF0LVA/WDlpf8y6oO/RVU3hn5hLYQbwX846iDRXCF6l29DdIh7MA0FbNEanVIcc1H8sDnWcSrF4Q+zKs4ohHJa3XKQ2wLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKodA11x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKodA11x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E011F000E9;
	Sat, 13 Jun 2026 04:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781324047;
	bh=FozXoj6i8FW+xsn4ZV+flM/Ebmh2Cw7jEiqYYBgcgY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PKodA11x82HLRIcgUIz7tWg89CuMQhtRZSFXz2MEKfB7YinotvYyMffQ053lzYReI
	 XHqFHua2jzIvpYe7aWK9ebQ54OWqEXqcxtk35EfWIDHDIX2bNccM/FTQUWPcamB50u
	 TQN3ZoORDs7yhQNTvzYu/x0RDO3LogNYxmnn0E9iwzBx4Lcu2G2gfvKHENjT/4nXI2
	 FrI3vTROAqj2umGMJ1vO9CPv4Pmo4JtkJZg5jvjr++saQcgPGrg2urEU2sY8g2ao0L
	 DqaDRL2QgW7gKwPSJTTZtuR0ah4vu/lCEJiYdtAD9n+kdCY6eNe/dpJHl6QmMeGLnM
	 XByW5a2KqRL/Q==
Date: Fri, 12 Jun 2026 21:14:07 -0700
From: Kees Cook <kees@kernel.org>
To: Jamie Hill-Daniel <clubby789@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Subject: Re: [PATCH RESEND 0/2] seccomp: Allow using `SECCOMP_MODE_STRICT`
 with `SECCOMP_MODE_FILTER`
Message-ID: <202606122110.28245E2D@keescook>
References: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk>

On Tue, May 26, 2026 at 04:32:14PM +0100, Jamie Hill-Daniel wrote:
> This patch adjusts the logic used by seccomp to allow applying both
> `SECCOMP_MODE_FILTER` and `SECCOMP_MODE_STRICT` to the same process.

Honestly, SECCOMP_MODE_STRICT is kinda deprecated. Nothing new should be
using it.

> Currently, once seccomp has been initialized, a process may not
> transition to a different mode (only add additional filters).
> This means that in container environments such as Docker, which by
> default runs with `SECCOMP_MODE_FILTER`, processes may not enable
> `SECCOMP_MODE_STRICT`. This is an obstacle to using applications
> requiring `SECCOMP_MODE_STRICT` in these environments, and requires
> disabling these security measures.

What applications do you have that need SECCOMP_MODE_STRICT and why
can't they be modified to use FILTER?

> When subsequently running secure computing checks, we run the strict
> checks followed by any installed filters.
> 
> Link: https://github.com/moby/moby/issues/42082

This doesn't show any particular application, just a demo program.

I'd *really* prefer to only add complexity to seccomp if it is
absolutely needed.

-Kees

-- 
Kees Cook
