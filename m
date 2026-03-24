Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893C215F6B
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774393217; cv=none; b=AlQC2R/VKPOTv7sZedviMPT5E2XaiKEmCB+dQ1c6p0YvfUntGQ/CWa68muQAvZh95575owLCYkNkW3OksqvijL16uvSsMhRKiXV/GpkprhkxThPUIKdHVtIrtpO5Q2fUnFW0vXmapO4XXCvzIGUOHz0RSHN6gXqGt1AZ3muGr8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774393217; c=relaxed/simple;
	bh=ZII/JGv2JjScCl9hJl3KdXLIxT4b4XoFTIdkQY9QhHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pW9QX/HLGeS4T72Z/hd54w5c/Yg6tB1F3wVBOWUK2SgzXMqP+aZOcqTgBhADS/Z2HdnjhLaC9IAkzEZJldOcky/eEaxzOG9n49ZMwQSDL6IKbjEPRXLnF1ZkzzpChL6QPUBuIHxrT4SMmdA6UDsOIQ4VzfAq1sxz/paQtptDBls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n+b0hoez; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n+b0hoez"
Message-ID: <9985d6b0-d305-429f-9dac-a9a40085c843@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774393214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yS7mAUT0O+x7+anV6xI5QCP97XBxbKBlhkikiOxivJ0=;
	b=n+b0hoezYv2rwIGMiIByhGtpboWz/dRKPiEoaPZehcvaH555U1zrZ98nmBJMPnVNu7MlJd
	a6K/Js/3MHBsoEbwtKaMuBQP7t8wigeDp6QfXYUeqTsTsx1TlowCI3cyJW5o0SZprSxGoY
	GBcypAGMgsrS6K/AAlJhNoET1eaQuBs=
Date: Tue, 24 Mar 2026 16:00:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: use RCU-safe iteration in
 dev_map_redirect_multi() SKB path
To: David Carlier <devnexen@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 bpf <bpf@vger.kernel.org>
References: <20260320072645.16731-1-devnexen@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260320072645.16731-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/20/26 12:26 AM, David Carlier wrote:
> The DEVMAP_HASH branch in dev_map_redirect_multi() uses
> hlist_for_each_entry_safe() to iterate hash buckets, but this function
> runs under RCU protection (called from xdp_do_generic_redirect_map()
> in softirq context). Concurrent writers (__dev_map_hash_update_elem,
> dev_map_hash_delete_elem) modify the list using RCU primitives
> (hlist_add_head_rcu, hlist_del_rcu).
> 
> hlist_for_each_entry_safe() performs plain pointer dereferences without
> rcu_dereference(), missing the acquire barrier needed to pair with
> writers' rcu_assign_pointer(). On weakly-ordered architectures (ARM64,
> POWER), a reader can observe a partially-constructed node. It also
> defeats CONFIG_PROVE_RCU lockdep validation and KCSAN data-race
> detection.
> 
> Replace with hlist_for_each_entry_rcu() using rcu_read_lock_bh_held()
> as the lockdep condition, consistent with the rcu_dereference_check()
> used in the DEVMAP (non-hash) branch of the same functions. Also fix
> the same incorrect lockdep_is_held(&dtab->index_lock) condition in
> dev_map_enqueue_multi(), where the lock is not held either.

Applied. Thanks.

Take a look at the review here:
https://sashiko.dev/#/patchset/20260320072645.16731-1-devnexen%40gmail.com

The first comment is legit and please followup. The second comment looks 
unrelated.


