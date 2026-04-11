Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E0723EAA3
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 01:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775869528; cv=none; b=O56iHP2OWpj5yegtO1WUF9EksDuu2e1GIFZ3jAmcBmveccF+9gvLb9RTwve5zSgGfabOoy5f8ykgcImv6k8goj+iCP+tfe0ju3lgVODHl0oVOgCQSKyMxNr6bNEZGDkq3VSksGhSyx0XC07PiQ4qHpBfyIwvIAMjk3YCOCnN+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775869528; c=relaxed/simple;
	bh=Mj2JSPiQ7qUlq+UnF/pTR82EVW9XrkmLw85SNWcSttw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJ+GVb8zhOEnTlkGCtGwLvzFqzxQEZXVJov7h2RiCno8g2znUKQaEn8jWml0DC2vz/wg49lbo0Pu17SQTT+kwbDHFp6s7U6boY++zhuw6hTsKmSijpAHPP13NaSM+TCzth/UY6Ow9BoYbY/7PQpdAhr8ScOf+v8AlyZnuq7Navo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b9w/h6op; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b9w/h6op"
Message-ID: <ce0aeb2f-55a5-4445-8a5a-e2a0fef75f4a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775869523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzowawuhjssmOibz4u6Ng0JIXaca22FBMTkYloQqV0Q=;
	b=b9w/h6opH4wE5Izkc8DtGE6YAcekG3DmckRpJ+NMiyNbReKg+26PUTCFw34pJAb9OOE4KL
	XOqNjpx33W6m6/2GKQtsyzEFvFDzG4Vzwl08967kSthRU1sT48WGYyApnidLRNE8lNfy1L
	c0H0Mn90FmXAyYgQWT/s2JBjA1ucfD4=
Date: Sat, 11 Apr 2026 09:05:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v1] net: add missing syncookie statistics for BPF
 custom syncookies
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260409124129.361777-1-jiayuan.chen@linux.dev>
 <CAAVpQUCK-d6YwYW+ZAH5OvmYZmAFnmunnoctdZfFFMhqY26aTQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAAVpQUCK-d6YwYW+ZAH5OvmYZmAFnmunnoctdZfFFMhqY26aTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/11/26 6:31 AM, Kuniyuki Iwashima wrote:
>> 1. Replace IS_ENABLED(CONFIG_BPF) with CONFIG_BPF_SYSCALL for
>>     cookie_bpf_ok() and cookie_bpf_check(). CONFIG_BPF is selected by
>>     CONFIG_NET unconditionally, so IS_ENABLED(CONFIG_BPF) is always
>>     true and provides no real guard. CONFIG_BPF_SYSCALL is the correct
>>     config for BPF program functionality.
>>
>> 2. Remove the CONFIG_BPF_SYSCALL guard around struct bpf_tcp_req_attrs.
>>     This struct is referenced by bpf_sk_assign_tcp_reqsk() in
>>     net/core/filter.c which is compiled unconditionally, so wrapping
>>     the definition in a config guard could cause build failures when
>>     CONFIG_BPF_SYSCALL=n.
>>
>> 3. Fix mismatched declaration of cookie_bpf_check() between the
>>     CONFIG_BPF_SYSCALL and stub paths: the real definition takes
>>     'struct net *net' but the declaration in the header did not.
>>     Add the net parameter to the declaration and all call sites.
>>
>> 4. Add missing LINUX_MIB_SYNCOOKIESRECV and LINUX_MIB_SYNCOOKIESFAILED
>>     statistics in cookie_bpf_check(), so that BPF custom syncookie
>>     validation is accounted for in SNMP counters just like the
>>     non-BPF path.
>>
>> Compile-tested with CONFIG_BPF_SYSCALL=y and CONFIG_BPF_SYSCALL
>> not set.
> Can you add SNMP test in tcp_custom_syncookie.c by checking
> the delta before connect_to_fd() and after accept() ?


Thanks for the suggestion. I've added the following to the existing test 
case and it works correctly:

+   recv_before = read_tcpext("SyncookiesRecv");
+   failed_before = read_tcpext("SyncookiesFailed");

    client = connect_to_fd(server, 0);
    if (!ASSERT_NEQ(client, -1, "connect_to_fd"))
          goto close_server;

    child = accept(server, NULL, 0);
    if (!ASSERT_NEQ(child, -1, "accept"))
          goto close_client;

+   recv_after = read_tcpext("SyncookiesRecv");
+   failed_after = read_tcpext("SyncookiesFailed");

+   ASSERT_EQ(recv_after - recv_before, 1, "SyncookiesRecv delta");
+   ASSERT_EQ(failed_after - failed_before, 0, "SyncookiesFailed delta");

Will include it in v2.

