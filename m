Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D579D2E54D3;
	Tue, 14 Apr 2026 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196946; cv=none; b=mlCWt1jYUSFSJY6NCHl7Gci9bHZM0BQy8wTIBZkLcIweOpaSHzgDdkQZFAGkrX+LidKBJYiRBQ+oTdSAs8q0EE8UMPXRa8gP6IDC4pZe0oYs8TG/eRqX97pn8rOX0gMFwJPhj6aQQKgeZFXRFefJkiy5+tE9+etdJAOrFhG8alA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196946; c=relaxed/simple;
	bh=EN+PtLnaKD8HEY73xxSJCPjkEkd7hKDTdNognbNaPVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNLFOEQhSyvwQQmDak9J6aSlKVf28GJHPRLNgKARveov4M8l1wekyeN4ZjC1CSNMPEiUYOD+OkTTgjqQTVsUxuSNuOokAfkQxuaOft4dtPCQSIh+EhHkbTgfufy1iYxLMgY9Ztf+qVObcksnq2lgN0ZEgr7eY4DtAkUYAOnbnU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HCmdSF+u; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HCmdSF+u"
Date: Tue, 14 Apr 2026 13:02:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776196941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVulSorLZqSOev8jY1Kt7v0qUZeYnyrZOKpTRmYQuLA=;
	b=HCmdSF+uzymU8UJ9oUOJhxska8uNEoFMpwiTwEnIABuUQIHer6f7hd5Dr01gHj8GhfnnFc
	ZHL4CWaqA57+fyBcjM4ymYvWYHE0vbw1RgZfc96XAtqks5WiwKM7VjTjAY57AatIUs5T4d
	SSD28ptrpR1A1AxwsvJYyMleuuAN0n8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] selftests/bpf: verify syncookie
 statistics in tcp_custom_syncookie
Message-ID: <2026414195145.Ur8-.martin.lau@linux.dev>
References: <20260411013211.225834-1-jiayuan.chen@linux.dev>
 <20260411013211.225834-2-jiayuan.chen@linux.dev>
 <CAAVpQUCCZVogDUUTfr3k-JxV52kpVvdYzqFC68-J3n6_ugd4Uw@mail.gmail.com>
 <6b22a595-cd65-42ec-b332-c835273bc174@redhat.com>
 <04cafd50-7af5-4835-b0df-67393d9f5a51@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04cafd50-7af5-4835-b0df-67393d9f5a51@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 14, 2026 at 11:17:39AM +0200, Paolo Abeni wrote:
> On 4/14/26 11:08 AM, Paolo Abeni wrote:
> > On 4/14/26 7:50 AM, Kuniyuki Iwashima wrote:
> >> On Fri, Apr 10, 2026 at 6:32 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> >>>
> >>> Add read_tcpext_snmp() helper to network_helpers which reads a
> >>> TcpExt SNMP counter via nstat, and use it in the tcp_custom_syncookie
> >>> test to verify that LINUX_MIB_SYNCOOKIESRECV is incremented and
> >>> LINUX_MIB_SYNCOOKIESFAILED stays unchanged across a successful
> >>> BPF custom syncookie validation.
> >>>
> >>> The delta is captured between start_server() and accept(), which
> >>> covers the full SYN/ACK/cookie-check path for one connection.
> >>>
> >>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >>> ---
> >>>  tools/testing/selftests/bpf/network_helpers.c | 22 +++++++++++++++++++
> >>>  tools/testing/selftests/bpf/network_helpers.h |  1 +
> >>>  .../bpf/prog_tests/tcp_custom_syncookie.c     | 20 +++++++++++++++++
> >>
> >> As you touch bpf selftest helper files, please rebase on bpf-next
> >> to avoid possible conflicts and tag bpf-next in the Subject.
> > 
> > To hopefully  minimize the conflicts handling I'm going to apply patch
> > 1/2 to net-next. Please resubmit patch 2/2 to bpf-next after the
> > relevant net core reach there.
> 
> Uhmm... the original feature went through the bpf tree, so I guess both
> patches could/should via bpf-next. Hopefully conflict into the tcp code
> should be minimal.

I think it is best to land both patches together. It seems the 7.1 pull-request
is out. We can take it to bpf-next/net after the merge window and then follow
by a pull-request for the net-next tree as usual.
