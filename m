Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14D2773FF;
	Tue, 24 Mar 2026 05:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774329951; cv=none; b=HS8j7H3Q65bXX2LMshCYXkHK/sL5h6fcyKwor9Rb2gW8ZvwSFeFoef9NZi6n7FjTqnkvuRMEIzGrjlyXQUXV9eCmpbJnITqqjt+Hyfch45nER3SyJidiradns9f+w+TYP4YfLSisowew6XMcnjAV6+3lNP0UhSi2QPnyGnOB1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774329951; c=relaxed/simple;
	bh=0j3HKtsXo8GLms+hLy5ugh2rfTY0BMgp3LEBkAG87AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ax41X8Qz0Dv5yCBYpdFLnAU7I+LoAgL48I5PZkk7NL4gndewR1gOgT8APsFDVjKjTmEq73awALeG+GUUkMRiEJr1MVho+m0xa2NDuVWUdy6UUknM6UvKcpaWZZP+pGisfeNyPUZiXzdE0+TVpowDog991++675DB26xwOtflMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfl90RPM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfl90RPM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CDCC19424;
	Tue, 24 Mar 2026 05:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774329950;
	bh=0j3HKtsXo8GLms+hLy5ugh2rfTY0BMgp3LEBkAG87AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dfl90RPMym0tTKiM0ChbfWNVtuEiH1Mzd4VbOQ96KwAe1a6BthtmAGAMUuUhlzVJJ
	 bKHtbj1XHcQLzX/MjTR9ac7TfndUKzE1Qd2KTXjgB4N5+hn1J5sEw2N5khQkvYsvf4
	 u9maPke3lvVXkGHV1VYGn9SKY+L9omvyknt/dMd/LLhBYpjth/54scW40BBugTkOoA
	 sJnf0C5hShPN/xTdJVm4wCxMTVa2YRqqFf+TjN/T13NySMiqX+4JZAMGjC0b/ZKk9K
	 TfhkkbJsS9TrEsbpv1UCkhmZ9lP15FupzQ3He+emmUrIhaTjTh0o5iGoEIwlbPBlwS
	 NKJ1nPxSkzMIQ==
Date: Mon, 23 Mar 2026 22:25:50 -0700
From: Kees Cook <kees@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] libbpf: Replace strncpy() with strnlen()+memcpy() in
 skel_map_create()
Message-ID: <202603232224.C1555BF@keescook>
References: <20260324040535.work.851-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324040535.work.851-kees@kernel.org>

On Mon, Mar 23, 2026 at 09:05:39PM -0700, Kees Cook wrote:
> While the original strncpy() would have copied a full 16 bytes from an
> overlong name (producing an unterminated field that the syscall rejects),
> but this wasn't a reachable state. This replacement will instead always
> truncate to 15 bytes and keeps the NUL terminator, which should have no
> behavioral changes with the present code and avoids potential issues
> with future over-long string literals.

Hm, I got a failure report, but it *seems* unrelated? But nothing else
fails that way recently, so I will try a v2 with the "unterminated at 16
bytes" behavior restored and see if it passes...

test_progs_no_alu32-x86_64-llvm-21:
https://github.com/kernel-patches/bpf/actions/runs/23472955268/job/68300440546


-- 
Kees Cook
