Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A3463B89;
	Thu,  3 Sep 2026 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426304; cv=none; b=YqaviNnjzl2+z6FDRMK57vwz0SzXzpzgpOvxL8uSaGQf7ej7KfRzelHm7+5DLuCuEHSU6FZR67dlybl7YgINyHx/oF6HM2uy6LGui0/OrJaS9CpbNougoByi2P8gd8hGkIaa4d6WWKWL0vUAKhzfI54OVuccaY3gFg0G0Bf4Jzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426304; c=relaxed/simple;
	bh=fWQvRYxgTzuOtnHTkDwfIg/07uyS1ZBZGMP31jXrfws=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WXH9RwdQ9KNJbxXx2RMCDsphtyI3LRTExXDhFcLlcPVHuWYO3GFzNLZwSCa8/hxOlo99nuGpegeQlrShKAA2gf4IAnBjv+HwDZmgBC7tM66zoYbas+y/aTi+Lgj5CGNWFWSel3sPk+KdMwWTEsuogvvTBoxVIMZlzx70H1VKhUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8vR3FBw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8vR3FBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369071F00A3A;
	Thu,  3 Sep 2026 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788426302;
	bh=zBZTsZJC18XQLL/ga2PnQld3VK5RyoYP1s/Ppon7T68=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=d8vR3FBwZlRnradDdsibi1rodNA6XoyZM6klpKIDCKmEcSGgEcxpIvyRtl/Lxgj47
	 9NW40KQKxINn2+PDgH4opySK94aCKbijBqiG40UrbOQ6xDmtb4wF008MjstlWaciLL
	 0wJcmeZHMOAdjcx5UUieewGIH2Kl3JfMGlIPEc26HmKB3eBuESjSYUXuFqQPzZVUWo
	 CUR6d+Lnf5rbUIgfGRygJN5wNKOofHhQL8Bsw+x2O/9iOkqvMtmiiq/Cz4t1fkLYHQ
	 kSsJQM9D3uKzAvmjzvZpETDqN6fVJ/QGcO+n44PokZWGhHzFeA3pgqhZAZp1Y/qlHw
	 XLhV8znpRy/wg==
Content-Type: multipart/mixed; boundary="===============6298812003795156340=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6b4e8b65241b0bddc6fb1179d339abf36082a529f409eda4cd0932147ec35779@mail.kernel.org>
In-Reply-To: <20260903082616.5096-1-liujing@cmss.chinamobile.com>
References: <20260903082616.5096-1-liujing@cmss.chinamobile.com>
Subject: Re: [PATCH] tools libbpf: Fix signed shift UB in btf_type_info()
From: bot+bpf-ci@kernel.org
To: liujing@cmss.chinamobile.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: eddyz87@gmail.com,memxor@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,liujing@cmss.chinamobile.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 09:05:02 +0000 (UTC)

--===============6298812003795156340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> In btf_type_info(), the expression `kflag << 31` performs a signed
> integer shift. When kflag is 1, this sets the sign bit of a 32-bit
> signed integer, which is undefined behavior in C.
>
> Fix it by casting kflag to unsigned int before the shift.
>
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>

This looks like a bug fix for undefined behavior that was introduced in
an earlier commit. Should this include a Fixes: tag?

The signed shift undefined behavior in btf_type_info() appears to have
been introduced by commit aea28a602fa1 ("libbpf: Mark BPF subprogs with
hidden visibility as static for BPF verifier"). Would it be appropriate
to add:

  Fixes: aea28a602fa1 ("libbpf: Mark BPF subprogs with hidden visibility as static for BPF verifier")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33734678501
--===============6298812003795156340==--
