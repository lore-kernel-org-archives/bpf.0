Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE1E48C40C
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910442; cv=none; b=frpP9FmN5oLr4vxiOA2flw7gUfMZpJ6En48WlxjUPrYJ9t/WgJ75AT8K10oiXvzTd1bMJ8+8BFDdoVb2kRxlyIZAfDDXuLUKPBK4yI6tV+LoD0Nv96li6MPNzkjMSa5i0LrE5rzKePC+1YNChrREqv9j16KVYqtVjz49ozybOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910442; c=relaxed/simple;
	bh=UVcIJEDrhQOpQllq1xdBwFGzkHGmGcdKHw53VXcovmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eki7uI9/dHcu+/1yD0W1+7JOQi/EoXxs9t86FQNhoga1T0nl+AO1r2A7Nd8Pev0g7g95jHmw94Kilb+g57JaaFUK1THmGGqjB7dJ7IY6reHqZmDBjm7r0sIdDeZHeddg2D0Fgy+rhFvAaABpw5bUooTMBDeA4xDOceaGLcwDnrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bijhkoge; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bijhkoge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE311F00A3A;
	Wed,  1 Jul 2026 12:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782910441;
	bh=smH2b04Fhc5GhlqM5H0HGEGDC6z6cvwZC0yoKvlnGAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bijhkogeXpT47XDuZl5dWf7dERzhnyrffouEPhcJJRbLKBPkO9mPzZ9MV7npEzTAt
	 +MbM0W6pAAHSa8D1AT9L83y0ltX+/Z7iYSKNfsPtrtiPQB+VOwVLDXiQlGeoSK0OxQ
	 KJsR93iTxyZXC8hvhNaJMzfWhjJLowSk3U7yymYxx6KxcgL/fJmMPsG5eI7spTwvCl
	 QSrUPijNf6HPMrwtx6jf1gStB1gpPQ1yaSV/1AJDlW9UPEtrLNmHooiCcTzRri8soQ
	 G+DBg87gBwHp42bbDavSwAFrVeQAsGJjvrBleiDhL7LsIwWHhwjCxJsi3R6UR9nzUe
	 T38Rx3pQ/UHTw==
Message-ID: <77ea35c8-2a06-41f0-b808-9743dbd3ea51@kernel.org>
Date: Wed, 1 Jul 2026 13:53:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Strip all -Wformat* flags from
 bootstrap libbpf build
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Cc: kernel-team@meta.com
References: <20260630205418.3483969-1-andrii@kernel.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260630205418.3483969-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-06-30 13:54 UTC-0700 ~ Andrii Nakryiko <andrii@kernel.org>
> Commit 9080b97689db ("bpftool: Pass host flags to bootstrap libbpf")
> started building the bootstrap libbpf with HOST_CFLAGS, stripping the
> warning options that are unsuitable for that build by filtering out
> -W -Wall -Wextra -Wformat -Wformat-signedness.
> 
> HOST_CFLAGS inherits EXTRA_WARNINGS, which includes -Wformat-security
> and -Wformat-y2k. The filter drops -Wall and -Wformat (the latter being
> what actually enables -Wformat), but leaves those two -Wformat-* children
> in LIBBPF_BOOTSTRAP_CFLAGS. Building the bootstrap libbpf with it then
> warns:
> 
>   cc1: warning: '-Wformat-y2k' ignored without '-Wformat'
>   cc1: warning: '-Wformat-security' ignored without '-Wformat'
> 
> The warning is easy to miss in an in-tree build: tools/lib/bpf/Makefile
> re-adds -Wall via "override CFLAGS += -Wall", which re-enables -Wformat
> for the libbpf objects, so only libbpf's feature-detection probe (which
> uses the passed CFLAGS verbatim) leaks the two warnings. The standalone
> libbpf Makefile (github.com/libbpf/libbpf, used by the bpftool mirror)
> instead uses "CFLAGS ?= ... -Wall", which the passed-in CFLAGS overrides,
> so -Wall is never re-added and every bootstrap object warns.
> 
> Use a -Wformat% wildcard in the filter-out so the orphaned children are
> removed together with the parent.
> 
> Fixes: 9080b97689db ("bpftool: Pass host flags to bootstrap libbpf")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>


Looks good, thank you.

Acked-by: Quentin Monnet <qmo@kernel.org>
