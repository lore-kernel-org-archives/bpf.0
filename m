Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF605372065
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 06:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825415; cv=none; b=PM8vLge4Akj7SmM7zpOrHItdOpmepidpuidNY9VoJUGEJmquGpbQ1EaFC+ttEgnQ1wpSuNb7L7alAHbsWAxzuiMvjL+J0Qgryb7mauflIEfO0INBDxbEvPZM6Z/0ii7pJV88+snok6PJwvnTNwbNuytCqEcH2q49ApC2Cfv3jPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825415; c=relaxed/simple;
	bh=Le4EkgZXkUCjQFMZiyXy6WPfmagQYr2fVX8Fbr6f0zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tC+CcByOg9TmSlCbjDT9rknT1DEhot6YyLrmEiIswjHCxX/AiCZzhnw0s1q86Tocfu6BIxsN2dcbn7WD37CLA4BoYTvWJzEsBJS2Bvg/73qHkU63BXgSWwmx1SKWeunYvrs03a9faB1CRbJDfu2pEP/1KsJo6cP5UQ0aCp5s/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ig4MhTSF; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ig4MhTSF"
Message-ID: <e0a24b78-9800-4927-b611-ccbad1e906fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778825401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=flk6h+cFS6o6O1B3E/Z8G7ApoA5PnzaH6XK/FCQAxrk=;
	b=Ig4MhTSFwtQsysUozZedT14hsZ1E60X1AwiKkJgPX36Oc/+rMel8aNmJAWqvqLr8q7N7/b
	A4erWpMvKnU5CWmcvBcJur2h8qEGAjX6dHAsfcYiEYyxlPQ3n1UMb/M45FR0WtudDWDHeP
	82lwouRhqrRGlo24DyQ9CpaV7ZjtmLU=
Date: Fri, 15 May 2026 14:09:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: skmsg: pin the delayed-work psock in
 sk_psock_backlog
To: Zhang Cen <rollkingzzc@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 2045gemini@gmail.com
References: <20260515050437.104716-1-rollkingzzc@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260515050437.104716-1-rollkingzzc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/15/26 1:04 PM, Zhang Cen wrote:
> sk_psock_backlog() recovers the psock it operates on from the delayed
> work item, but it takes its lifetime reference with
> sk_psock_get(psock->sk).
> That reloads sk->sk_user_data and can therefore return a replacement
> psock after the old psock was detached and a new one was attached to
> the same socket.
>
> In that case the worker locks and drains the old psock, but the
> reference it acquired belongs to the replacement psock. The exit path
> then puts the detached old psock, which can underflow its refcount
> after the last unlink while the replacement psock keeps the leaked
> reference.
>
> Take the reference on the delayed-work psock directly with
> refcount_inc_not_zero(). If that fails, the old psock is already being
> dropped, so skip the detached backlog instead of processing or putting
> it. This keeps the worker's get/put pair on the same psock whose
> work_state, ingress queue and state bits it manipulates.
>
> The buggy scenario involves two paths, with each column showing the
> order within that path:
>
> path A label: detach and reattach path   path B label: old backlog worker
> 1. The last unlink drops the old         1. Delayed work resumes from the
>     psock into sk_psock_drop().              old psock embedded in work.
> 2. sk_psock_drop() clears               2. The worker still sees
>     sk->sk_user_data before the old         SK_PSOCK_TX_ENABLED on that
>     TX state is cleared.                    old psock.
> 3. A new attach publishes a             3. sk_psock_get(psock->sk)
>     replacement psock on the same           reloads sk->sk_user_data and
>     socket.                                 refs the replacement psock.
> 4. The old psock is still queued for    4. The worker locks, drains and
>     delayed backlog work.                   finally puts the detached old
>                                             psock.
>
> Sanitizer validation reported:
> Non-fatal target warning: refcount_t underflow/use-after-free warning from refcount_warn_saturate triggered by sk_psock_backlog putting the detached old psock after last_old_ref_before_put reached 0.

Where is the 'last_old_ref_before_put' symbol from? I can't find it 
anywhere in the tree.

If you are using LLMs to dig into races like this, please also have them 
produce a reproducer, e.g. patch mdelay() into

the relevant windows to widen them, then trigger it from userspace.


