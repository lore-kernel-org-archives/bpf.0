Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26363EDAD5
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989561; cv=none; b=KMfY9lw917DhMWGZMr3mLT5JRv9eBdAnWfdu3f8ddDD1/J8tR0xek4eMTe5pslVVfQ2rbf8LkUo/uUCtmGh4r8gUh63wP3WMZDv8Y+P5fhxxkTkCJEHx+yn2n85jWFLTkmF1GBi/hYKaqx5OQaNAEjn0jYCnS3q695LFnjVmybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989561; c=relaxed/simple;
	bh=7rT3np+eTVic+AGR8HfNTj3tMq5UqYOzy5X3Ylc6UOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ePp//F5aa8aEh4nv3IblPz4AY/WAYwMnZsccp7kYBSnync3bUQ9Ktygoa3BP8Li9k9ZvKOG7p7GfQJatJQoBVrpDbtD6udv/0WG7qei6mJS2MfifCfbKiLEadjLa7QPtuFCmk9GCfUQvImks64xgMnYQgGXK20fBDTdWzsQt4gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DsoWddnP; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DsoWddnP"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c127813835aso217250166b.2
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2026 03:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782989558; x=1783594358; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rT3np+eTVic+AGR8HfNTj3tMq5UqYOzy5X3Ylc6UOc=;
        b=DsoWddnPLORJX50bGQIzSvkSCZs4ChUh7edzQZAYeXJf/uV5TQJAoepEYm0CegibaC
         tKmmdUvYq9o++MnE2mW8dekLZytuN30Pijfczi63OasWLgrgV6yXrH0Ne4wAFgvn5gJe
         GnPNireYmU0O65qDZJGso0gmGVHcwJ5bg1tRIKkSDUf9J3Y2/GaaRqKJp53TovX286h2
         jI0yICsxqVcNUh8N6cTn7BzGi9Xd4b508G4iiVSlcO4YIqaaHPd8G/mIi15F5SuadqDt
         pYlpVlzy3Yf7GaWW1+mgY43lxhbhAgQ52nkxao1hxigN4OKy0f3oss9AXcggJlc/4/ac
         1lgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989558; x=1783594358;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7rT3np+eTVic+AGR8HfNTj3tMq5UqYOzy5X3Ylc6UOc=;
        b=Pa/DGdD3Ac9cCkQE+RCbhJdNAJAFaeWJnHFd0UP/oByh20nKqONYTqqXFef+2A3xpJ
         SOSuyZ7qONHH4eDISlIV8zL6+RhxNKsr9p12LuqVPMI3jQUizMgoNaIbK5JCNQkT5DN/
         tXDMO47mXH4AsRr0ExGkbV6f0U774iPXADXNIyWwecQ5LspemqlmRPxjSdo5DyCcn1XQ
         y9FxiOZVYrssG2EQgjqBnWprzpGvnM35g7TQBP2bsd+vBGokJOo0sqOUkgoeFrx673xh
         aHhsjwC/pgIdDRDfYsgxxH6h2/FZHZiGtsCDCdPE/w5uFlZyCavoiEvFOg/ex0WVXA1g
         eeBA==
X-Forwarded-Encrypted: i=1; AHgh+RqP4tYm3P8A2a3pxnujvaWvfWk3dl/WTI6oqGqdG60IPynKTdEGsWkBbDxwr8+jFLSk/cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUk4ZYqsbfxBdP4IfswZYcO6fihc22Xb4YHl7MnhpqED6sAit/
	XRWyiifIrVV1+WahWLbh5Pg758K/4p+KxS/no4tF7SnnkaRI/tEkm/xMyS9RS5GVpkM=
X-Gm-Gg: AfdE7cl/PsOwZyfEYPDuCI0QPTWPXe92dryltDkC6tB9EkioRg5zADKUv/QfsaetyqV
	thvY5hl/pkMAX1ZVWwk9rB8Jim+bocoeHm9q/klljApNt6Zx03mtF0Yg/lPwBuF+JZX6KhkvVGX
	yj4X4LdGuWZ/r7OypdLIw+r+iDvDeoknZbkgvI4hUw3JdiVdNrWWzXWIOcbxc95VpsmGDoPZjic
	+hAMl1pHml3eES8sKCiwFrgSoZlCRSxhkdw3I/xPjz2g/Iqtc00yWjXsDxZhEA3rwbFEYdciivi
	yBYFV+4DSuYV9nslzZ+f7t06vTCu2bGQUOCUArKH8YrCuWYmkRe5N6Uo3LtS5aYbdysVhcrLiSM
	H2lkRAS3fVENsFt/mclfLYZRM+lV1XXh8klvuG8t9RiDTreJzckYPRHWwdqMQPWEPox+aoY64yX
	T7qDY6mH1rtp1dPIM=
X-Received: by 2002:a17:906:ba84:b0:c12:a417:30ad with SMTP id a640c23a62f3a-c12a9d386d1mr240239066b.7.1782989558379;
        Thu, 02 Jul 2026 03:52:38 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62f5c52sm110937966b.58.2026.07.02.03.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 03:52:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  Shuah Khan
 <shuah@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Jiayuan
 Chen <jiayuan.chen@linux.dev>,  Eric Dumazet <edumazet@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  Willem de Bruijn <willemb@google.com>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Simon Horman
 <horms@kernel.org>,  Cong Wang <cong.wang@bytedance.com>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH bpf v3 3/4] selftests/bpf: Adapt sockmap update error
 handling
In-Reply-To: <20260702-sockmap-lookup-udp-leak-v3-3-ff8de8782468@rbox.co>
	(Michal Luczaj's message of "Thu, 02 Jul 2026 01:28:21 +0200")
References: <20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co>
	<20260702-sockmap-lookup-udp-leak-v3-3-ff8de8782468@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 02 Jul 2026 12:52:37 +0200
Message-ID: <8733y13bpm.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 02, 2026 at 01:28 AM +02, Michal Luczaj wrote:
> Update sockmap_listen to accommodate the recent change in sockmap that
> rejects unbound UDP sockets.
>
> TCP: Reject unbound and bound (unless established or listening).
> UDP: Accept only bound sockets.
>
> While at it, migrate to ASSERT_* and enforce reverse xmas tree.
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
