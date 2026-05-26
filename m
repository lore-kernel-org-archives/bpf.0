Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A888B3DC4A8
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793129; cv=none; b=Dgec/sK4Cjyo4Pb42//UVBfGMcRE/tVM2A6ypOzkFnMz2gKsnliNIT0nzR/etjVdaVmE4sEzghnAuymrbTznP8snsAsxavwHvr5jrozGQ+hjZBWkNi/RskUhLl8FdqXGRuMwLzddkQ7QpvOXB9crkJKJb3DoHNHhevWmlDmne3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793129; c=relaxed/simple;
	bh=3KxoRj4axyqKn/f/0LSdzxfK6uWRHqN2lJV+0OHMu78=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R0c/kQZTqQfO8ia6NIP1e8xSUH8N962UyJot3SUBF+0FJugB9mp/tlxhU311iSff2LknnypcOHMlSDom7eHOgcbxhshW06y2ubNwXfl4zReSWchjUbO1WWlXRuVOqAoMM26KSIVrtdV1+QvdDF51gpXtY/1SNrMFqqFQOa54l3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e7AiuZU7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e7AiuZU7"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd22b2abaa4so1673103866b.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 03:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1779793126; x=1780397926; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3KxoRj4axyqKn/f/0LSdzxfK6uWRHqN2lJV+0OHMu78=;
        b=e7AiuZU74PJMrpshXpb5vD20MuQdnuCKoiE1cMZtHL17YgkOW8jEBWrkPy1YL/uyOR
         DQDkOtpRpnEUxgtlz5P77MoyblFORlF71Jzkc0MEGyxXzLZngOrjhuwtof2G+m0I4QJS
         MYsJHWeQ9Nud5/y1kOuQcFY4dpqFVfa818+oXrWOfkO53Rp4s8FFEOcFi85VVosw27mo
         esG6m/nNqp0PBZCoB55ezeULu4SzGT3klom8VjeIz1ckaPjPCMN8WTe/yADyV8k6kmMr
         La13G9+XP95KYMG0vGl7t0aAOnV9vT4YhuvklbOIA4qGc33HZ5fZYrSFL2u7uKVY9Sgp
         I9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779793126; x=1780397926;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KxoRj4axyqKn/f/0LSdzxfK6uWRHqN2lJV+0OHMu78=;
        b=dwu2e5d01DblOFp0H9p0SiKSl4+LVXOkRNo1dUR9+7O8W9SzRXUAPZaM2wSp8tA0Lk
         dNfeTpcS5EIM8ZdbZXcQPshSKTtq+k9nsqTg2BKp4L1dwR9/yO/A4nmDFRzEyHcsI1nE
         l0jjQ0TGhgmHrmcTf2NuCUkMNdLT967gRe+ygl8QmqaC0wqVmkOsJu2wa90HIH1TlDQc
         +vmFB/jJobbIT86z3u23+PvhFnHkPswn0EDy+8eo8yy8fZ1P/hS5rySzuKp7wwtmVrji
         FTjcvjACLkN/BKPQcx0yVkSURk4O/SUBRVc7YJ6u6AyY85ycyrYptjbjvpcWdWm5KaNM
         AQ1g==
X-Forwarded-Encrypted: i=1; AFNElJ/X698wdNPH87LijV44WPLrCXsfpT+Fhzp32+fIDcm3dL+eHUGCoGT6saN9De+b/jUjKN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvOvVEqwhXcFxdcZdZx3nYgnILr27Nk4CIlHehicJNQtLtPCgM
	hI+EeaGMyuc5Eo2Lu7H4r3b6YHdcy3YjKC088jShRdIjt9rSRLDoPYQYLzoBH5xF5n4=
X-Gm-Gg: Acq92OFEQILWJJ2bLr51ERymcpRB9/a5iXiNOED4ph8IoqUPMBTHv7nDwNrIEgrOvs0
	ALOkULgCmZUPUT29j8wmwLK3rGe6GeTLXka8XPjbYEUzQGhprzQC80FD935eN/u5JWGkYhg5M7x
	6oiEplME4h4L+ibqL7cslzHMWWGm0vP1epUqGwNWwHbjBBvrVyUUZym/RjctfbxgdPAAX7OqmKp
	Wd2q/q/5OFNbIIqD5ssTYQPOnlYrVd808Lz98iVV0Jkp44puZDfH2cYvPuks/mqWydrf8aEFXCy
	NUf9KJ1CmBrWUOs4Lpml4wvM3EKNcVgvKYNk1TXrvcTeHtGXN1Hoodc1F+7nKgSB51WEFqFvcj+
	mO8nzbYBu+qVn6acHLz4lQMKjwLLvUHgPDCgy4W8ZWRmcTcrdVcwkMsBBQxScS3tFf+fyrEoQb0
	BAxAxySGi4kb05E/QyU4BndYMn1Q==
X-Received: by 2002:a17:907:b5a7:b0:bd4:c66e:988a with SMTP id a640c23a62f3a-bdd21a5c072mr767209866b.0.1779793126064;
        Tue, 26 May 2026 03:58:46 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688baf1e984sm4867993a12.14.2026.05.26.03.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:58:45 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  bpf@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 07/12] selftests/bpf: Emit nop,nop10 instructions
 combo for x86_64 arch
In-Reply-To: <20260521124411.31133-8-jolsa@kernel.org> (Jiri Olsa's message of
	"Thu, 21 May 2026 14:44:06 +0200")
References: <20260521124411.31133-1-jolsa@kernel.org>
	<20260521124411.31133-8-jolsa@kernel.org>
Date: Tue, 26 May 2026 12:58:44 +0200
Message-ID: <877boq77yz.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 21, 2026 at 02:44 PM +02, Jiri Olsa wrote:
> Syncing latest usdt.h change [1].
>
> Now that we have nop10 optimization support in kernel, let's emit
> nop,nop10 for usdt probe. We leave it up to the library to use
> desirable nop instruction.
>
> [1] TBD
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
