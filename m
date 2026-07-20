Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6A039B95D;
	Mon, 20 Jul 2026 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551477; cv=none; b=jn76X+JK4Gf3w5KzNghxoXL6ZRJ6f5sB0sBY6adJgfu5/m+P/iU7UGhEC3/AiA0nUygGAOD6jB4nUJ4y6IgH14ofUMiwPeSyD+Tsfh7NklMfls+uFN5pkmZnvpdj49ePDZvJt7KAdkBRxaA/bPXkp3cA2bS7vnxBdT++0bN+wa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551477; c=relaxed/simple;
	bh=ibLI5GCbmoHayIAXgyvD2UuaJ3sG5yZOvfCaluOJHB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOjJ77tG2JG7b7HN5LGAIX1vc0qVL7VgjMptBmic72NwJcNFZGNBZAF1fRgkqXddN2y8TUtD1AQzQTNBcv+GtApjqtLDE/2InM55yvCJAHxS19JYIGeyDNj01wXbSGYxxY86nwpbRBPo1+VJyX+5J3xJW/FE5EnV1VHg1gHD1K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaTO0Vzo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaTO0Vzo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAA81F00A3A;
	Mon, 20 Jul 2026 12:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784551476;
	bh=ibLI5GCbmoHayIAXgyvD2UuaJ3sG5yZOvfCaluOJHB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FaTO0VzoVVaCj6T7Exvaykmw2/wN1lL/MFxft5eaxhT+CwhyhkzoYzHQQO0LFU4Ya
	 fzbXl+Zaj77zwdHPgCCGGNcioNs3jkrwPSnXZ5l/w9X1/f2kV2J2dGD4vsNV0M6n3a
	 meE4dfjCv0g5Yi+JEWZwMn3PtsRw2H/wr5jrK/IMKErl+uegNWlTgoZwFYAVlFhjqf
	 rZdNGnf88Hsm1yejLrwhO4fA9MW6fLFOOHR2oym5F6BG4AP0v7aN3DejTbsqQNUt6J
	 1RhGp9Buv136rT6K9pSm6uTzdnx4r5FqcGLj8aYxWhK4wC2ltxi1qXRkn8tokh6h1N
	 +0Q+eO96j69zw==
Date: Mon, 20 Jul 2026 14:44:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH 01/21] exec: do not act on a stale execfd request without
 an executable
Message-ID: <20260720-stecken-deportation-bespielbar-dd98d9b27ffd@brauner>
References: <20260720-work-bpf-binfmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org>
 <20260720-work-bpf-binfmt_misc-ptinterp-v1-1-ddb76c9a508e@kernel.org>
 <20260720100022.9212B1F00A3A@smtp.kernel.org>
 <20260720-fanblock-authentisch-typisch-6c69318d3ac5@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720-fanblock-authentisch-typisch-6c69318d3ac5@brauner>

> This is the same finding I had basically. It means we need to clear this
> where the flags are set. That needs to be backported to a lot of older
> kernels so we need it right at the beginning of everything that is in
> vfs-7.3.binfmt... I'll send that as a standalone fix in a bit.

This is now a separate fix on vfs.fixes. So this patch will just be
dropped from the series.
