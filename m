Received: from mta0.migadu.com (out-100.mta0.migadu.com [91.218.175.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB725DB0D
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786560420; cv=none; b=ED966PH6SdnzOc3N47OFly5TIf25qYIt5x5obBg6N/BXUNre0PZBPUp/CQvyIInDN1bUC713GrCmlEr0LC29dhIVLdhOnQy0SxzQh5GK7xEWnddgZcJJ83hVoX7/3l9u+UTuaAdomusPT/kRydWiijGuSk95sdNu28VXkqeePDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786560420; c=relaxed/simple;
	bh=P15uc+v2QH+iKpzpb5A5Mh7dmRI8QIJxQCb9OSawzdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ipi7s5FzFhbFiCoiPiREG2l/cMSjDiCv8SSfswAmTol/dqYXD/azATw6YX6p4MbbZd2uau0R/w6mfW1FmnyIcSguKNccnFaqFSwahA+MqdISDYx2azWnoTlWTynDDfwJJgduWWrtep9C0u2EfcZrHBbsikMcnJpx9vowrpnniQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qGXtY5V0; arc=none smtp.client-ip=91.218.175.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qGXtY5V0"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=P15uc+v2QH+iKpzpb5A5Mh7dmRI8QIJxQCb9OSawzdk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786560416; v=1; x=1787165216;
 b=qGXtY5V03+kL2GO/xvRC8kZXN1mr+bb49dXYbjXCK7lDXgvl5afZsAVggc+nba6BBsMql2lo
 ZZSUi85wk9UwqDoCTPURy+FtYU1ACx3LjHIHBrMCVPKRAmXtCy93iMSMf62tYqTnYUaoqhDQSYH
 9dwAhWYjUPauO5LOcoRMaUGs=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:125c:1:c4d4:5d0:c3b3:cab6] (2620:10d:c090:500::5:f7a3)
	by smtp.migadu.com with ESMTPS id 20a21b4d86a645e6;
	Wed, 12 Aug 2026 18:46:38 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <d92da576-4930-4b10-b8bd-ea1158ec08bc@linux.dev>
Date: Wed, 12 Aug 2026 11:46:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 1/2] selftests/bpf: keep polling connection that is
 still in progress
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260811-tc_tunnel_flaky-v3-0-876f4e0bc603@bootlin.com>
 <20260811-tc_tunnel_flaky-v3-1-876f4e0bc603@bootlin.com>
 <75ec8417-4be5-4e7a-86c9-70a83b793580@linux.dev>
 <DKM96LSV880C.1QEALTH06N0GI@bootlin.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DKM96LSV880C.1QEALTH06N0GI@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/11/26 9:25 AM, Alexis Lothoré wrote:
> On Tue Aug 11, 2026 at 5:05 PM CEST, Jiayuan Chen wrote:
>>
>> On 8/11/26 10:26 PM, Alexis Lothoré (eBPF Foundation) wrote:
>>> Some tests, like tc_tunnel or tc_edt, sporadically fail in CI with the
>>> following logs:
>>>
>>>    (network_helpers.c:309: errno: Operation now in progress) \
>>>      Failed to connect to server
>>>    send_and_test_data:FAIL:connect to server unexpected error: -115
>>>
>>> This is due to SO_RCVTIMEO and SO_SNDTIMEO being set on the client
>>> socket (see settimeo() in client_socket()), allowing connect() to return
>>> an error and to set errno to EINPROGRESS instead of blocking until
>>> connection result is known. Increasing the timeout value for those tests
>>> is likely not a good solution (and it has already been done by commit
>>> 2790db208b44 ("selftests/bpf: Improve tc_tunnel test reliability")):
>>> they involve subtests that expect the connection to fail, and so
>>> increasing the timeout value would increase overall test execution
>>> duration again (not only the connection, but any socket operation).
>>>
>>> Another solution, as documented in man 2 connect, is to poll the socket
>>> for POLLOUT once connect has returned EINPROGRESS, and to get the actual
>>> connection result through getsockopt: this allows to keep the overall
>>> timeout values low for the general traffic, while letting a chance to
>>> the connection to succeed even if CI runners are loaded.
>>>
>>> When connect() returns EINPROGRESS, poll the socket for POLLOUT and
>>> check the connection result via getsockopt(SO_ERROR). This new handling
>>> conforms to the configured timeout: the polling loop will only run for
>>> the amount of time still available, accounting for the time used by the
>>> initial connect() call.
>>
>>
>> So IIUC this patch doesn't actually fix the flakiness: connect() on a 
>> blocking socket only
>> returns EINPROGRESS after SO_SNDTIMEO is fully consumed, so remaining_ms 
>> is always ~0 and the
>> overall time budget is still 1s, same as before. Am I missing something?
> 
> Hmmm, I have been assuming that this EINPROGRESS could be returned
> _before_ the configured timeout depletion, but I may have been mistaken,
> it indeed happens only  the socket is O_NONBLOCK, which is not the case
> here. So indeed, it does not fix anything for the blocking case, as the
> budget is already depleted when getting EINPROGRESS...
> 
> I added this budget mechanism to follow up on Ihor's suggestion, so I
> either got it wrong, or it can not work.

Hi Alexis,

Looks like my suggestion was bad, sorry. Jiayuan is right. I didn't
realize what -EINPROGRESS actually means here.

See __inet_stream_connect() in net/ipv4/af_inet.c:697

	err = -EINPROGRESS;
	...
	timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
	...
	if (!timeo || !inet_wait_for_connect(sk, timeo, writebias))
		goto out;

-EINPROGRESS is a default that reaches userspace only when the wait
expires. Every other exit sets a different error code. So on a
blocking socket -EINPROGRESS does not mean "connection started", it
means "waited the whole budget, gave up in SYN_SENT". On a nonblocking
socket it means the opposite, and man 2 connect seems to only document
the nonblocking case.

> An intermediate solution could
> be to exceptionally raise the budget by 1s when getting EINPROGRESS.

I believe you're right that the flakiness can be addressed with bigger
timeout, which is why v2 fixed it for you. But +1s may not be enough.

IIUC the way the helpers are written cause -EINPROGRESS instead of
-ETIMEDOUT. If SO_SNDTIMEO is not set before connect(), the kernel
reports plain ETIMEDOUT, but it is set in settimeo().

I vibe-coded a userspace repro: loopback listener with a full accept
queue drained at t=1500ms, so the handshake completes at ~2040ms.
Caller asks for timeout_ms=1000, like tc_tunnel:

  mainline (blocking)                     budget 1000   FAIL at 1016ms
  v3 (blocking + leftover poll)           budget 1000   FAIL at 1015ms # my suggestion
  O_NONBLOCK + poll(timeout_ms)           budget 1000   FAIL at 1001ms # Jiayuan's suggestion
  O_NONBLOCK + poll(3500)                 budget 3500   OK   at 2031ms
  blocking, SO_SNDTIMEO raised to 3500    budget 3500   OK   at 2040ms
  v2 (blocking 1000 + fixed 3000 grace)   budget 4046   OK   at 2067ms

Everything that gave the handshake more than ~2040ms passed. Blocking
vs nonblocking makes no difference, poll() vs no poll() makes no
difference. We just need to increase the budget for connect().

I don't think swtiching to O_NONBLOCK makes sense. Apparently, it was
nonblocking in the past, see 99126abec5e5 ("bpf: selftests: A few
improvements to network_helpers.c")

So I think we can introduce a separate connect() budget, similar to
your v2. And then use opts->timeout_ms for everything after. Something
like this:

	#define CONNECT_TIMEOUT_MS	5000

	static int connect_timeout_ms(const struct network_helper_opts *opts)
	{
		/* don't shorten what the caller asked for: tc_redirect
		 * and xdp_synproxy pass 10000
		 */
		return MAX(opts->timeout_ms, CONNECT_TIMEOUT_MS);
	}

and in connect_to_addr():

	fd = client_socket(addr->ss_family, type, opts);
	if (fd < 0) {
		log_err("Failed to create client socket");
		return -1;
	}

	/* SO_SNDTIMEO is a ceiling, not a sleep: a wider handshake
	 * budget costs nothing on connections that succeed.
	 */
	if (settimeo(fd, connect_timeout_ms(opts)))
		goto close;

	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
		log_err("Failed to connect to server");
		goto close;
	}

	if (settimeo(fd, opts->timeout_ms))	/* data I/O budget */
		goto close;

	return fd;

close:
	save_errno_close(fd);
	return -1;

This is simpler than poll() and retry loops.


An entirely different alternative that Eduard brought up in an
off-list discussion, is to drop all the timeout machinery from
network_helpers.c altogether, and rely solely on the test_progs
watchdog to kill the subtest processes: d9d4d127e813 ("selftests/bpf:
watchdog timer for test_progs")

I am not convinced it's a good idea, because I don't know what will
happen with all the tc_* tests if there is no connection timeouts. If
you're interested, you could try it and see.


> That potentially brings back part of the issues he has been mentioning
> with selftests duration possibly increasing by a non negligeable amount,
> but maybe 1s is a better compromise, compared to my initial 3s proposal
> ?
> 

