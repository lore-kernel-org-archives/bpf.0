Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E272322F767;
	Sat, 17 Oct 2026 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247867; cv=none; b=ppewwoBygBKPJHCPhbGfzs6rRA/7xKUH5DdTEWq3Qog5s5BNXLs7kdeE1dNmzE8JK1MD5RohIHC6VjpEY+vpyH60sUEHO1F6A7Yej10c+sX9kvZZlpliJMF7n0rhkPsUUmwCRV91Hr/IEiSbs0k1WnZh2PT1qQq9mKl0B4BCDio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247867; c=relaxed/simple;
	bh=Sq5ydYFuOAqw9J022xyqOiYQ4YmZ4G5mJxksxPfIZX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dsuyTQh3R/frbcS29bFGzwQ9aCFVnwbOIPbEYLohKDZGZhe7MOuUnx4cfTFCwEYozodVY8aIXdnmMelAsXl43RQclZtRqIZ5Vu/y1WOGqLSbItmf+ODCSd0R1dJPdQRYkbhH90ecly5DucHslXbEVHj97nbXw4l49cC6DVbXyHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0WpGdub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0WpGdub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2FF1F000C4;
	Sat, 17 Oct 2026 14:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792247866;
	bh=Sq5ydYFuOAqw9J022xyqOiYQ4YmZ4G5mJxksxPfIZX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=b0WpGdubMto36P5hm50AKUAlDZsoAI5Rv9ee/jp1NqjtleBZ9xSw6g305wHWqXEIp
	 qIwXrvrWyrPx5ZwQo4ky4EeWEBtqx+ucu9KAxXD/l2Jy1Mp/5B+7nJOAtypItoP2mY
	 A/v5rd4AZ2EqXgYqyYpX2BvqQ9agkRZbxEZfzlcoTFl2QePHudB8pxN4MbzIttCTiU
	 FdSsy/DFF4m0HtxQ1gLpFjH4wqArMon1qRqkvKETxqyD9AsIBbsUjycdFmcj/iqaOp
	 FsB/j/NttYiz8L4Ppzi4C8j36AYrn02ZkcXfqEyrjRZASahA6TbrCyHS7rkThGMCgq
	 2t//OUmbx+10g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Clement Lecigne <clecigne@google.com>, aleksander.lobakin@intel.com,
 edumazet@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, sdf@fomichev.me,
 horms@kernel.org, john.fastabend@gmail.com, ast@kernel.org,
 daniel@iogearbox.net
Subject: Re: [PATCH v3] xsk: fix memory corruptions in net/core/xdp.c
In-Reply-To: <atOBnjNbppL02n8/@boxer>
References: <20260629072300.1664622-1-clecigne@google.com>
 <87qzhp51vc.fsf@all.your.base.are.belong.to.us> <atIfJAKqp3dZdY4M@boxer>
 <87cxt94d1t.fsf@all.your.base.are.belong.to.us> <atOBnjNbppL02n8/@boxer>
Date: Sat, 17 Oct 2026 16:37:43 +0200
Message-ID: <871p9o4clk.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

>> Or am I missing another check?
>
> I missed your trick with xdp.frags on prog side. Get this fixed then!
> :D I

...so many bugs... ;)

> had a thought like 'who cares if we overwrite struct not used in linear
> traffic' but as Clement said somewhere destructor_arg overwrite would make
> a mess.
>
> Side note is ice currently still only allows 3k buffers for linear XDP
> progs but it currently works with page_pool not with magic page split
> mechanism, so the limit should be lifted.
>
> I might take this as an AR but anyone reading this in future feel free to
> pick it up.
>
> Bjorn, let us see if Clement responses in some nearby future, otherwise
> please go forward and submit a standalone fix out of your series.

SG!

Bj=C3=B6rn
