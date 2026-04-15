Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21E309EFA
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776219760; cv=none; b=lYUNlTgg2V9eYDSUzppvH/jCZNGv0NYTsvqZb6RncCs2V87k/+5lvdB5iTk2HH4RMx7nxJKtHLLJX293O0L30HJwdeSB5xULhLyOd8NblVhEf+lJqcd/QYCzgrEzzlUi9etln4DpXHVzmGn5HSvBv5wL7vVEeqdPiensrcZJC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776219760; c=relaxed/simple;
	bh=ZnAgyefV7j+HdWbSCjRgUnb9/TLI4F5WnQl6jhsgORs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TakVKLVGvYDdLYO8v5PzyQytG5rSeJlUkCYCbLO8VK3TLzUFsuwPwRqfxUyPHRthlpQYX1zoTBbKnLEa83ZfpcYHutkSUPG+cYJsOM5a/cE7RDOuh06WlTPcjFSs1VDCxrJn1MHKVEvvJmhV7ydePib65D4i+wfSZFJLimJ7GyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EaYSXFOx; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EaYSXFOx"
Message-ID: <a6e657bb-4022-4ec6-b634-0e70285d0d6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776219746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07Gfmo26p9pCjh0thm2aRrhY2n676z8s90wlwpR7FPY=;
	b=EaYSXFOxCL205YA7CSKMd++RZoIHr5LukZc0e4S1OIuc+mO7Xxsp/zJu/Cqh3WirkjH/os
	Gt21pp+e1VJQr32QcI7cLhYIkERIMTRKENQ5NMgbxd+Hb79Ir4BSY1AUnUcTklfivPa5Zl
	aFnpur4yr+VgNMbCQqGpjBAaPyNn75c=
Date: Wed, 15 Apr 2026 10:22:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/2] selftests/bpf: verify syncookie
 statistics in tcp_custom_syncookie
To: Martin KaFai Lau <martin.lau@linux.dev>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Eric Dumazet
 <edumazet@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260411013211.225834-1-jiayuan.chen@linux.dev>
 <20260411013211.225834-2-jiayuan.chen@linux.dev>
 <CAAVpQUCCZVogDUUTfr3k-JxV52kpVvdYzqFC68-J3n6_ugd4Uw@mail.gmail.com>
 <6b22a595-cd65-42ec-b332-c835273bc174@redhat.com>
 <04cafd50-7af5-4835-b0df-67393d9f5a51@redhat.com>
 <2026414195145.Ur8-.martin.lau@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <2026414195145.Ur8-.martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/15/26 4:02 AM, Martin KaFai Lau wrote:
> On Tue, Apr 14, 2026 at 11:17:39AM +0200, Paolo Abeni wrote:
>> On 4/14/26 11:08 AM, Paolo Abeni wrote:
>>> On 4/14/26 7:50 AM, Kuniyuki Iwashima wrote:
>>>> On Fri, Apr 10, 2026 at 6:32 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>>>> Add read_tcpext_snmp() helper to network_helpers which reads a
>>>>> TcpExt SNMP counter via nstat, and use it in the tcp_custom_syncookie
>>>>> test to verify that LINUX_MIB_SYNCOOKIESRECV is incremented and
>>>>> LINUX_MIB_SYNCOOKIESFAILED stays unchanged across a successful
>>>>> BPF custom syncookie validation.
>>>>>
>>>>> The delta is captured between start_server() and accept(), which
>>>>> covers the full SYN/ACK/cookie-check path for one connection.
>>>>>
>>>>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>>>> ---
>>>>>   tools/testing/selftests/bpf/network_helpers.c | 22 +++++++++++++++++++
>>>>>   tools/testing/selftests/bpf/network_helpers.h |  1 +
>>>>>   .../bpf/prog_tests/tcp_custom_syncookie.c     | 20 +++++++++++++++++
>>>> As you touch bpf selftest helper files, please rebase on bpf-next
>>>> to avoid possible conflicts and tag bpf-next in the Subject.
>>> To hopefully  minimize the conflicts handling I'm going to apply patch
>>> 1/2 to net-next. Please resubmit patch 2/2 to bpf-next after the
>>> relevant net core reach there.
>> Uhmm... the original feature went through the bpf tree, so I guess both
>> patches could/should via bpf-next. Hopefully conflict into the tcp code
>> should be minimal.
> I think it is best to land both patches together. It seems the 7.1 pull-request
> is out. We can take it to bpf-next/net after the merge window and then follow
> by a pull-request for the net-next tree as usual.


Thanks, Martin. I will rebase and send it, targeting bpf-next, after the 
merge window ends.

