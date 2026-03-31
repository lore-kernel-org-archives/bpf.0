Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC013D75D5
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944971; cv=none; b=aZUhp68P2SDX9RoH2eNc9c7T+wkZK1YQ0vC9e8xD/XwF/9aXfVzN2O4lHAb0819wEdy4EYK+6LPPS53RY2sgb6hd6b1Ken8O1r2iVJZe/M59UPk8EMqSdOe/lKRDLwzcEE75ZpioHRwQY+hCegiVyEkZYKo2M2oyw/I27x49Vdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944971; c=relaxed/simple;
	bh=243IyXz8TWG5GobrxuJutHfWyzsR+tk3U+UjyKo6Rco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fx501vi2XruJS1xsyGunhGUhuJAxhsSvH4ZhUIUFVJIxBxdddQaxkwVFMR24OgJU8Q0TI+XRXVl/khqLNkrE17iT2hPfAUBBYhX5z8TAss4CXZxqQtstVxBed6P/I5zyP98UP+TXt1ZdIHowv7QJVbs9PrK++k//R1ZGH8xlZ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CThM0j2z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CThM0j2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7EBC2BCB0;
	Tue, 31 Mar 2026 08:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774944971;
	bh=243IyXz8TWG5GobrxuJutHfWyzsR+tk3U+UjyKo6Rco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CThM0j2zOmIcrsq+JmZUgTznS/7Po7NHHWGqWrqWvpboYZnSDr5DNGOjYwouVHT/b
	 1BKj9rbtAOP5l4A/4SwLJBdogcr0yov8rGYQe8x5zspRaRhQylrg3H96FaNd6Y652k
	 TVQ+3bQCJtvXLNinFxrWJlskuQJYs1NRTM7VDA/wrfSPDM7YE5gmnZLBko0T32jMfr
	 YtXggZDiolqrgxqnwxp0U4TS/8yOjaap2Eqg58nmL4sEo+Qx7u2Z4h6SRXInB9XtDf
	 Ap4AN09W+zKG0m9R59IpOeqTQd7BxBnkNEc1Sx2dRgHO5w0qby8OLwGAtR3qppKO9A
	 hwDtX2MJHGd4w==
Date: Tue, 31 Mar 2026 10:16:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Fix block device hooks names
Message-ID: <20260331-blaumeise-bestmarke-370fe4de231e@brauner>
References: <20260330210344.3073712-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330210344.3073712-1-jolsa@kernel.org>

On Mon, Mar 30, 2026 at 11:03:44PM +0200, Jiri Olsa wrote:
> Use proper names for block device hooks names.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Fixes: 46df585fcff7 ("bpf: classify block device hooks appropriately")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/bpf/acrVKUy_EPiFFmV9@krava/T/#m7c7906a1ff4029e29185aec3266dbf5c8996dbf7
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Thank you!

Reviewed-by: Christian Brauner <brauner@kernel.org>
