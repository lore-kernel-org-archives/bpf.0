Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599461;
	b=0+3xwWXSUbTXAQfWHd+K2ALM3o6s2mrfZMbGIc3sWDhVQhbtIWbCUzKA7+7IVMUPBf8a
	 lWFkBoJT69BuUngdAeW8TtVAsHxewlzM4GFtlBzz4Ke847hdAxafRRR0Vpmr+hjPCx4hP
	 xk7VWb7zVadw2ZQOEHbuKJmvoHpwPR89nlc+hUHEqofmqGKbRoWQQ8OICQm2F0+uubEyB
	 wyqt3HW8ilDUizJfvwUf3lWUI2GCp/4GY/ArZFUb8pz6pAuKpmquCtZlgVAPp67RKvWej
	 q0GqKQd/U0st+8vhWVYRhT2gks+zli7X9nsN6NuUbFu6WTOkALgPKUvhrgEQNeRzhIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599461;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1RViC7k9xKhgymEU03e/S7bNs6re40TdTRhXbj9cDgQ=;
	b=ETsv9RWpg2tNEQdBI5X9i1KaSur6fIQChtTyik3E/0SazZimj5ioiHyJMaeuw5Qim5tt
	 b9isJO7LVB58P4H8TSgRyqDdf4NykkpBzB66VwCkHzpxxsdShzCUsXTx/RzIQ3nyQ1v0Z
	 aVMsZAzxJs4O9KhNMTCdpp+BzaxQspoWHo2fGOnUmjMTMXSDX4JrfWGqn6LrycMc2Eo9l
	 DwFaLAX9FMe8BoK3ChQVWDbIUVmO9gYh2hJKM1fzji839rdyDdZzrHyLmES+2fOwGKTQa
	 ymG4QDj7ZOG82yY3q6jqq3N0BqjwuHndrW4dLrkfUgzK45tqxyudv2qfwKX1Sl8/m1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=leDAC8+b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3034C606A32D;
	Fri, 13 Nov 2026 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=leDAC8+b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADD01F000C4;
	Fri, 13 Nov 2026 19:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599461;
	bh=1RViC7k9xKhgymEU03e/S7bNs6re40TdTRhXbj9cDgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=leDAC8+bQloJn/mEZ9sZ1efIwIAqUVa3id0mx/Y2OlOs9fVnjj4oKZ29696nzFK7x
	 1t3oPt5lQr76cPiw4ip5HYWAvsgSXaTDaTQcGcc7/SbdwTnhLZlwHfXEDeMIeo4oex
	 UCIi9I6eKG9DHyTLmaaFcBNaxalsgJUx2BfwooQyGyHqdUaxpvsCEp+G/+P+XwmAfb
	 W00+IFZOB6APS+IUJf/aTxiV3RBzfSKM3UASuw7sW7HSSX8x/N9iQP3xUFSd2PQvAj
	 LE6BlN9cwi8CQv6dsiTR4u8t/swVJSgNoIbEj1j/rw2FNvHrjGkS7ogepXaeMr5pOU
	 mbuO9/v3iQu+w==
Date: Fri, 13 Nov 2026 09:50:59 -1000
Message-ID: <2a1f54ec70384b99add9987a462b2052@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH sched_ext v2 1/2] sched_ext: make DSQ iterator stay drained after NULL
In-Reply-To: <20261113024505.922854-1-k.chen@smail.nju.edu.cn>
References: <20261110125113.2935742-1-k.chen@smail.nju.edu.cn> <20261113024505.922854-1-k.chen@smail.nju.edu.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Kang.

v1 is already applied to sched_ext/for-7.4-fixes.

The selftest doesn't catch the bug reliably. Every ops.dequeue() invocation
overwrites next_after_drain and the test reads it once at the end. If the
last invocation saw an empty DSQ, the restarted walk returns NULL too and
the test passes on a kernel without the fix. Here, it passed about half of
the runs on an idle VM without the fix.

Also, I don't think the selftest is all that useful.

Thanks.

--
tejun
