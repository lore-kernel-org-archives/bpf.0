Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C7D3D3008
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021292; cv=none; b=LOiNeVQpQqUJxrcbT/pJYmn37Mb1nhyFbRmvWCWxPRJLBiylcMo/GCD5t5g4FN4n6Fvg4qA38FMtzHbLQbsLc0Wez2MrHriNZffSPlK14rqv7j/Frf0xD4Vza42rUkiFEQMKdHCNHxz290kbT8c1Nw5WAin0QdYF0/E6WDYiRJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021292; c=relaxed/simple;
	bh=QNqDTeBv6Xh5mcSKAShwoFRG7JRHC5kiEUU7s/fyUd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FGFPBeJ+T4OHTd3+nGZoAB50EGgE+hHXHzhN4ZBLBkThbKZBjrD+lqGfGfEIbUIxPbjy/5m6Uprz2rpNJroKi6MAcjhabEBoG8g/TBnUBgbPUk9thHPWh3HoaiktAZ825gwrE6NGhdz9MwI3Ptez+TqOnCBvTQlHQrQXlc9jCs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=krm+lEot; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="krm+lEot"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769021286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNqDTeBv6Xh5mcSKAShwoFRG7JRHC5kiEUU7s/fyUd0=;
	b=krm+lEotbbq1OYiNW3JOF1x0E7B8VKVkaMNVf4ygdy+VMKEucHaQHTRMTzf0OSvnELTxmP
	U3w7Hi6r32B4WzygsO/QZ7h2pkLL3MjcquaA+gLsHoJt/vWarKDXUTa16trFRHE/BoizkC
	xt51WBOIQ2AmnqvwW1BVlWwQ8EEIM9c=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,
  Martin KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  ohn Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Jiri
 Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Revert "bpf: drop KF_ACQUIRE flag on BPF
 kfunc bpf_get_root_mem_cgroup()"
In-Reply-To: <20260121090001.240166-1-mattbobrowski@google.com> (Matt
	Bobrowski's message of "Wed, 21 Jan 2026 09:00:01 +0000")
References: <20260121090001.240166-1-mattbobrowski@google.com>
Date: Wed, 21 Jan 2026 10:47:57 -0800
Message-ID: <87o6mm7qg2.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Matt Bobrowski <mattbobrowski@google.com> writes:

> This reverts commit e463b6de9da1 ("bpf: drop KF_ACQUIRE flag on BPF
> kfunc bpf_get_root_mem_cgroup()").
>
> The original commit removed the KF_ACQUIRE flag from
> bpf_get_root_mem_cgroup() under the assumption that it resulted in
> simplified usage. This stemmed from the fact that
> bpf_get_root_mem_cgroup() inherently returns a reference to an object
> which technically isn't reference counted, therefore there is no
> strong requirement to call a matching bpf_put_mem_cgroup() on the
> returned reference.
>
> Although technically correct, as per the arguments in the thread [0],
> dropping the KF_ACQUIRE flag and losing reference tracking semantics
> negatively impacted the usability of bpf_get_root_mem_cgroup() in
> practice.
>
> [0] https://lore.kernel.org/bpf/878qdx6yut.fsf@linux.dev/
>
> Link: https://lore.kernel.org/bpf/CAADnVQ+6d1Lj4dteAv8u62d7kj3Ze5io6bqM0xeQd-UPk9ZgJQ@mail.gmail.com/
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks, Matt!
