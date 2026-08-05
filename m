Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4049647279F
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937951; cv=none; b=Z5wdXUN3HdNGLkfsQ5SC5sUb7FnHJ9L36OsOvkH3SRaS7Va359Y4KD+ENrfdYdmjbKsIWvdcuW+Df0Q5n+AOSRJLWoFGQQcwH8IxdebkWoBTAU3e+Z6YKILuWl8i06ZUmpt+kfcf+xw9+dqjmtcGINBwg7yjiurUgUKmJu/zu4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937951; c=relaxed/simple;
	bh=XHk6Ttlf3Cenmtx2/Sxl+qub7u69P3r7NTE/N1QZlR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HrSxeZklG9rxDU7wJev5jSSSgTPtqaZGmxagBHP4JoVMYnnVDpAU/X/xh8rRbJV+bsLYf07s3Gc8hZmDygAp64kUjExx9adA6xV2KRN4AJlspK7i9KBINyvMucWcOCBYNo4jpMmDXujdnP5iBu9m7H37CeEwuLa8zCUyaheYggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N4ABZtf/; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N4ABZtf/"
Message-ID: <2dd05325-9e13-4494-b2f5-5ccffc1d3005@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785937936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7zCFnZ19lfLuiyQPj5cL0DwiHc2BsO0Vf/zdyzgGkQ=;
	b=N4ABZtf/tPb1HOATGOUxxLJg1NUU+QqC85v3yMX7erZB3iyYt4ieyuHkaiLKW+qTcixdkO
	5lpSBWOAwSfWLxLUhGxdSugCNe860Ve4GqIcrlf7ZOU9rnOqLhZY6FkF/0/Ra2J1d6Kl+p
	ens9oyAXItFcLQj0HUc9Zbn2TnqVH4Q=
Date: Wed, 5 Aug 2026 21:51:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 0/2] bpf, sockmap: handle spurious tcp_msg_wait_data()
 wakeup
To: Nnamdi Onyeyiri <nnamdio@gmail.com>, bpf@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 jakub@cloudflare.com, jiayuan.chen@linux.dev, john.fastabend@gmail.com,
 kuba@kernel.org, kuniyu@google.com, ncardwell@google.com,
 netdev@vger.kernel.org, pabeni@redhat.com, sashiko-reviews@lists.linux.dev,
 linux-kernel@vger.kernel.org, emil@etsalapatis.com
References: <20260721223807.75101-1-nnamdio@gmail.com>
 <anLyIzAs9JBhZnhe@localhost.localdomain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <anLyIzAs9JBhZnhe@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/5/26 4:22 PM, Nnamdi Onyeyiri wrote:
> On Tue, Jul 21, 2026 at 11:38:05PM +0100, Nnamdi Onyeyiri wrote:
>> Spurious wakeups in tcp_msg_wait_data() aren't being handled by
>> tcp_bpf_recvmsg() and tcp_bpf_recvmsg_parser(), leading to unexpected
>> EAGAIN errors returned by recvfrom()/recv().  Adding handling for the
>> wakeup and a selftest.
>>
>> This issue was first discovered in an application that adds sockets to
>> a sockmap as a way to view the received data.  No redirects or any
>> other operations are performed.
>>
>> Sashiko has noted a few other pre-existing issues in the same area
>> (https://patch.msgid.link/20260714205118.17DB11F000E9@smtp.kernel.org)
>> that can lead to EAGAIN in tcp_bpf_recvmsg() and
>> tcp_bpf_recvmsg_parser().  A local run of Sashiko also identified a
>> potential issue in tcp_bpf_recvmsg() handling zero-data FIN packets when
>> the MSG_PEEK flag is set.  To prevent this patchset from growing too
>> large, I intend to submit follow up patches to address these once this
>> one has been accepted.
>>
>> Changes in v7:
>> - In tcp_bpf_recvmsg check for data in the TCP_CLOSE, !timeo and
>>    signal_pending branches.
>> - Refactored changes to tcp_bpf_recvmsg to reduce duplication.
>> - Increase the number of iterations in the selftests.
>> - Documented selftests numeric constants.
>> - Link to v6: https://patch.msgid.link/20260720171535.67867-1-nnamdio@gmail.com
>>
>> Changes in v6:
>> - Closing the file descriptor in the selftest worker thread.
>> - Ensuring the selftest loop breaks early for an error in the worker
>>    thread.
>> - Added comments to selftest regarding focus on EAGAIN error.
>> - Updated selftest commit message to imperative mood.
>> - Link to v5: https://patch.msgid.link/20260717155348.54975-1-nnamdio@gmail.com
>>
>> Changes in v5:
>> - Move selftest from net into bpf/prog_tests/sockmap_basic.c
>> - Link to v4: https://patch.msgid.link/20260715213538.37229-1-nnamdio@gmail.com
>>
>> Changes in v4:
>> - Fix potential data loss in tcp_bpf_recvmsg() when a FIN or RST has
>>    been received.
>> - Check the return code of pthread_create() in the selftest.
>> - Fix race caused by using EXPECT macros in a thread in selftest.
>> - Link to v3: https://patch.msgid.link/20260714203927.32289-1-nnamdio@gmail.com
>>
>> Changes in v3:
>> - Added the sockmap_recvfrom selftest.
>> - Link to v2: https://patch.msgid.link/alFRK66z45eDNZA7@localhost.localdomain
>>
>> Changes in v2:
>> - In tcp_bpf_recvmsg, handle signals and the socket closing in the loop.
>> - Fix spurious wakeups when SO_RCVTIMEO has been set on the socket.
>> - Link to v1: https://patch.msgid.link/ak_rR-Skd8Mvn4mH@localhost.localdomain
>>
>> Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
>> ---
>> Nnamdi Onyeyiri (2):
>>    bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
>>    selftests/bpf: add sockmap recvfrom EAGAIN selftest
>>
>>   net/ipv4/tcp_bpf.c                            |  72 ++++++++--
>>   .../selftests/bpf/prog_tests/sockmap_basic.c  | 136 ++++++++++++++++++
>>   2 files changed, 199 insertions(+), 9 deletions(-)
>>
>> -- 
>> 2.52.0
>>
> Hi all, just wondering if you need anything more from me on this?


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


targeting bpf-next without Fixes tags seems fine given the scope

