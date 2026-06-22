Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E5439C62F;
	Mon, 22 Jun 2026 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782130316; cv=none; b=WAX/BUQkViUOHo199kB4ScAMQuuieZsIbMQDJ7z3Tgr2ClmP9d1UkYYVmkhvZb4Kc8UeCmuvfIDNgc79hKMEveNxJSsiz3JlA05+v2M0Ztf+fcwD7RvX4+xaXztFX/jFSEcdR5Mi5vTzsJZWp0KsEg2Y+IAoQK8uIbwaExmPPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782130316; c=relaxed/simple;
	bh=uI9WSwGdTMzaYZwGXdMkLBdsUPtjO9nKT9rYVMurqdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3GhdzFruweR4FJNDwVMHVKYr97oX80Ml0uPAyT7XOebkMdvZhrrYUiROA3Ius1m4s9G8OdIggUSQ1owfV6A0woxco8pT2m5fScp5CWaqlHuOtka8EBz3kJkKC4h2+zv5A2oZcyCA/dvc3EPdPThcoynbIto6tgiLBoqplV8PdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R+vfs/AP; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R+vfs/AP"
Message-ID: <fcd16335-4494-428b-87e7-854107a429ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782130302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uI9WSwGdTMzaYZwGXdMkLBdsUPtjO9nKT9rYVMurqdE=;
	b=R+vfs/APkw56WxPlHUP9pOnikZM/+VP385Li7WJH+0GsIXnOEaH6WMWDDmTXCqMXr5tZiC
	ad18cj1BZWPwe0flcezNw+u+Rs3KqzRUXvN37Hhuhc3UvYM8dvOj7jQPaLUfP8jGUhDoEr
	B7gULN7GyoAF3toQbAALxhEOzjLh7MM=
Date: Mon, 22 Jun 2026 20:11:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net/smc: fix out-of-bounds read when sk_user_data
 holds a sk_psock
To: Sechang Lim <rhkrqnwk98@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 Simon Horman <horms@kernel.org>, Ursula Braun <ubraun@linux.ibm.com>,
 Karsten Graul <kgraul@linux.ibm.com>, Guvenc Gulce <guvenc@linux.ibm.com>,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260619150342.3626224-1-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260619150342.3626224-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/19/26 11:03 PM, Sechang Lim wrote:
> SMC stores its smc_sock in the clcsock's sk_user_data tagged
> SK_USER_DATA_NOCOPY and reads it back with smc_clcsock_user_data(), which
> only strips that flag. sockmap stores a sk_psock in the same field tagged
> SK_USER_DATA_NOCOPY | SK_USER_DATA_PSOCK. Nothing keeps both off one
> socket, and SMC then casts the sk_psock to an smc_sock.

How about SK_USER_DATA_BPF


