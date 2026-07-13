Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931E357CF9;
	Mon, 13 Jul 2026 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971516; cv=none; b=lmVvJX4P/5PCkO0Ed6xAjlTZVXK39i80OK/K/hTPY2zRSqndugJSdArxjMRlorgvljabsYQ1ifR1saatgPT/jbmxfN3U/unVVnDm7XM5BMhnccnsoww1dGgXFH730VUydx93V6utFn5bH74/CwzaUsmLFSXj9EiBOqjm3t18I6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971516; c=relaxed/simple;
	bh=TW/Ghz3MkYqBM5nmK0JncmUWtZRI38ips3UfRrK/ZbQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=BsnWh9UoulArheJAOEsVPLFArXIRYECqg0OlTkNRcYgVlWQbhzaQhnBzcewWeV5BotBAMnLCz1Xo3QZub3TRRNC2wCJumNjgx9kx0oA6YM8x26/qUvVeA49cX1CZrMn91ORSvUKT7z2gy142+d9P965EHKVFteDKkDySZC91wFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oufg/pLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oufg/pLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B93C1F000E9;
	Mon, 13 Jul 2026 19:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783971515;
	bh=TW/Ghz3MkYqBM5nmK0JncmUWtZRI38ips3UfRrK/ZbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oufg/pLm9ChRJRtTNY1mlsyJSuXSW7KT9LOrUqKu1uwwFXY8S87KoJKOL3z0wnyq0
	 IpCSRdAuDPWYUc1mzVZWQwcvpDU8DFkUwUM8VAVdubLNviKrzYud0iRI7WzfJNnn88
	 Wa9alcNuZoNc5hHu2QiwbEXCvl10t3uF2QuRFMNSCa8KBJ++HhmVKYCBdAlwtCjHIH
	 NwfYtNjtOEIgTdZiH8VDTLT7MzLorBhwtjU1sBYadHeTn3pjxfzxgQFiUXoTJqLgjm
	 4ZLn6wyfKa3mbtsDITWOPbzLP/jt5fzZYxSDYxmaP5osMqyU6AlalC6Oi2PbTTN7Xd
	 2jpubcH73x98Q==
Date: Mon, 13 Jul 2026 09:38:34 -1000
Message-ID: <1652a2179b3462c5c8454eef5f863b71@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, emil@etsalapatis.com, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, bpf@vger.kernel.org, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET SLOP RFC 2/6] selftests/bpf: Add kfunc __arena argument tests
In-Reply-To: <20260713031657.7ECAB1F000E9@smtp.kernel.org>
References: <20260713024414.3759854-1-tj@kernel.org> <20260713024414.3759854-3-tj@kernel.org> <20260713031657.7ECAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On a pointer to offset 0 being translated as NULL:

offset 0 == NULL is the existing arena representation, not something this
introduces: cast_user already collapses any arena pointer with zero low
32 bits to NULL (the x86 JIT emits test/cmove). So no offset-0 pointer
distinct from NULL exists across the boundary, and the fixup is
consistent with that.

v2: no code change; the flagged comment is reflowed.

Thanks.
