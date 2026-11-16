Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855151;
	b=uhcZ0LhCTyYs1sIvZyKouUbVsveRWefwQE5kQX0lC0+DXaGsDRjWsZ1ijiOqkDaMsHx8
	 g9a2A86ApGN6ELaDG+A8DzlEhsCOiarS7MIZ7RLEvH48nj65ZPHbdPGU6jaU1+YMPz509
	 bcgL63Yh5mWc2sr90JhFBEI2jK6T1NKqZzHmZe/zGLLW3BM4BEGEkhWPSmzRlG+iUMkyb
	 MpFZ8eC+GnLLfPbrr9Oh/u37CB5Z5s+ptIonFP5fIHQzNtT6MHVgSlI4BfvXv+N2Aoqx0
	 Ol5gCEYhkkKSpE0akmPe1ydFSZL/qojNnE90syOvWQMxCBwXWJwof075qVRTGoLNjvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=vkfkDzRzhP/lJQHb5qA933FrYUOsdOG3Q72hhxn9rwI=;
	b=VtTDbUc1JSLK1tvOo4+utS5yD7QbSfAq24fS2AC709z1R0UCtdRJfyL9gsMpb7/W+TA/
	 z5EMRQolaSLeKNeytXj13EXHVtSNUGab6kJOKNeRrHIFMfrNpXDSY+2qQeV+3PWXTamzC
	 ytGiW3oPWxUgnp8Qk8aAgOS6rdwr9sevJ6JYYnpwkCqGbGRaTldZ732OLpmbJaZZK4S8n
	 51lOfVtqL0hKTER8XEtC5soo7YO8ALGT8NBnglr+NCiQGCRtfMfdqPu3g8/BhKE341d+c
	 XN+jdSEdHxcuBpll2c5+RXhsSgGUbZaTzVageZEFR+e5KouWeX/wvQmZ2HyyBKle1wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=QxeQQqeb;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4BB606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 18:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E4BB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=QxeQQqeb
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso1653467f8f.2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 10:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794855149; x=1795459949; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vkfkDzRzhP/lJQHb5qA933FrYUOsdOG3Q72hhxn9rwI=;
        b=QxeQQqebeJTGfj2tTnJZQKbCi1ZPDLG9fA3t2JiMbDA1JUhtGxgetQFoXlGRJ3jDKX
         BQokDR4RZFnxbjOFvoHiwsYXl7mBMUB+Sb78npVaRWD7iHbRuEhe7anB47GKi/tr67jy
         cFEcdN5nP1+bKix0Z6qEd6MZwstXq6TJlc/y7BmbQY1vyG/5z8H0hiiPGnsF1juP/7+I
         Bs3a8NTeaNMPUnlZXnx4dCznUw/bTOHTaigAFDfED4/c3u0IHwbmQNJrzs+BiAdrmiQ2
         OPQbGqRLW5uV8RMRS8B8anaCoIvdiFyjnyipEVXZEE+zw7A3EYPUqn5isjlHltPMB/bI
         S84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794855149; x=1795459949;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vkfkDzRzhP/lJQHb5qA933FrYUOsdOG3Q72hhxn9rwI=;
        b=2vg8/vdOg69xcbJ7awJJfaO/Nhy6nOZS8VDhnFopSUpMGRZnDa3yPMhSGI1If+MMNm
         J0pcKScZz/xKYQs3R1+V7J5X2TH72boWLt7Bc8cUP3DT/IEtajm9ExsKL+XwUiIsCwU+
         EGEYSI4zrZm++XAuk2F3SI0xVv3+IjclDrPW2KtGmAFnU1NAmYNfuFoBr0DhWT2ZdIb0
         EnSUJBcpTVc+5DaGIOLPpIHV5P3jrXJsOG//INnDZGqYtbEPpWKxH75mm2VADbpO6zrK
         xU764OVHr7rKB1A8tKP5gXNb0OkGjdyrUWCMfl4SmMcGD+c7q81OTQZBR4tDqWqt6QXi
         C7tQ==
X-Gm-Message-State: APuU4Z9W2YfzyR9nNMJk2DOeMORi5ilDdy/Fqr2PyQMm5UbvbRKHEsG1
	bQgyAVOE/3wFIlKuegaoB1sg1BMCDbxysP9jj69OHc1U24kTQWP+0OVHMqFYqVi2070=
X-Gm-Gg: AZFdTZf05PjBkAJXlLaKGTpcT3+qDjI0lfTgj1EwyKOTJn0fEZVlg0Mdotrzcd0Mt2q
	S+i9fN7HMXUM/2Uoc52LsRrKwRA164XecH5h4+SCm/gbTRcTPgg1Wdu9wQFm0FUJHFfxJbDfz1J
	neAJYU3c1J6sLVZZ7DykarUZ5xMMr+o7WOkJrJHFmPs8nwOSY6G6KT4IckMDIXhUdg2copvQ++V
	/6wu+XYazhomHFAuxJEeDOc4fHQlsnkJt9cMKwJp+R7XqOJsOJhYinaU515XAxt38kgWwR7jhGT
	h5IjFOHX0Dielc/fgb+z3nptBgjv0woCywuQ+Ix60EZoQrBx377DKom/zBQ+z2ofFjbLACJMScL
	4j8yj8n4rBehEewHHp1lFFmjyFsYtukr6AMY1R/yAU2zB2u1fvlnJpl/tNP+wg8IwD1h++GS2wR
	vUjvao3GkLr6IYxH8yDnOENORrWqRJuHNp5ki7+GhTv0Q4PMgLPEXKFn7VS0FiNImVeG/MewM91
	+Uj6ovgJp87dfmRiyvGk/DcvNe56SH5fCpzzXAm2DKolZRF/MkcIrez88/AFaAQTE7FvlHlJHhX
	XNp78obAbz+H1ZsaeBRBuUbUPWQc4IcXGGIuBheZ
X-Received: by 2002:a05:6000:4697:b0:492:c53e:2ea8 with SMTP id ffacd0b85a97d-49c7458620emr18353879f8f.49.1794855149071;
        Mon, 16 Nov 2026 10:52:29 -0800 (PST)
Received: from cloudflare.com ([2a09:bac6:314f:191::28:17b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c69406640sm23398371f8f.12.2026.11.16.10.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:52:28 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Ahmad Wicaksono <supersonix03@gmail.com>
Cc: bpf@vger.kernel.org,  rhkrqnwk98@gmail.com,  ast@kernel.org,
  daniel@iogearbox.net,  andrii@kernel.org,  eddyz87@gmail.com,
  memxor@gmail.com,  martin.lau@linux.dev,  song@kernel.org,
  yonghong.song@linux.dev,  jolsa@kernel.org,  john.fastabend@gmail.com,
  corbet@lwn.net,  linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] Documentation/bpf: Fix stale selftests
 file references
In-Reply-To: <20261114170117.196552-3-supersonix03@gmail.com> (Ahmad
	Wicaksono's message of "Sun, 15 Nov 2026 00:01:17 +0700")
References: <20261114170117.196552-1-supersonix03@gmail.com>
	<20261114170117.196552-3-supersonix03@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 16 Nov 2026 19:52:27 +0100
Message-ID: <878q2sr4lw.fsf@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 15, 2026 at 12:01 AM +07, Ahmad Wicaksono wrote:
> Two selftests paths in the BPF docs no longer exist:
>
> map_lpm_trie.rst points at tools/testing/selftests/bpf/test_lpm_map.c,
> which was moved by commit 3e18f5f1e5a1 ("selftests/bpf: Move
> test_lpm_map.c to map_tests") and now lives at
> tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c.
>
> btf.rst points at tools/testing/selftests/bpf/test_xdp_noinline.c, which
> is now tools/testing/selftests/bpf/progs/test_xdp_noinline.c.
>
> Update both so readers can find the code.
>
> Signed-off-by: Ahmad Wicaksono <supersonix03@gmail.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
