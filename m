Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE264218A3;
	Tue, 20 Jan 2026 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935235; cv=none; b=dZB30WXJh+6Wpvnngx9Y165Q0qLiD43Kd1peug8Nfy/2FeR9pY0ZbsBsddGq/TzDGKRQePLaHV8uUA31mAhPPTkCjO2aSpjxe4P7GIvxM9Um79X9BEFlMcSzpfO3qcPOQ4iRyixulk4ABWeMOkTY+dFegGg40DhMulQefIkffak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935235; c=relaxed/simple;
	bh=/wQzm2XYcRO1SK1rQYfV8CL2Qb5EIXOxQEZj/ZpIjW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUWK0XZQSLk4nsOXsW4yDPPAPgHEhA3KIdHIJJZCHp2ksR3hTaYQuYNEnlpzWIvhyVkayEa3K5wpGcDf/hpOz9Cr4ey9pgtvaM5y8kd61Mn4HtZ4y5r4iZ1b9ud3oshW/Iio7HyBMbbbi42qAmPOcCv3Iv9wnEF95ryTgbiuSlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKbzjEVV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKbzjEVV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D346C16AAE;
	Tue, 20 Jan 2026 18:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768935234;
	bh=/wQzm2XYcRO1SK1rQYfV8CL2Qb5EIXOxQEZj/ZpIjW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qKbzjEVVruuvO0RUZvYgurzcRBkDUOWjIq4Msz1MktbzTgS4t0cFSewshRH1/qpJR
	 1X8+gn2oe/uvYbqLy1MgXpBweHdi4XKYBe5DohqudgZeqUc/N6lhudQeI43Vc7Vegn
	 3DBSuYOq/P701m0kNloLuYkZPbC/aW9KFdwIpw9om9IY9+xVsxdeBz/gN333VUQtnS
	 s24JGTwpsSn/N5klqJ03o6tkotgu3ODeSSJL2wEKQkGuvyYpKhNseUO+Gl5Pigi+zY
	 vP174zU1Y34V/99KzBOc0HF3nY0WA6Pjgav/71eCFyXa2unCxBm8X/zoTicMPL7elo
	 59uCy6UuN2v6Q==
Date: Tue, 20 Jan 2026 10:53:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v9 net-next 15/15] selftests/net: packetdrill: add TCP
 Accurate ECN cases
Message-ID: <20260120105352.423ea3cd@kernel.org>
In-Reply-To: <20260119185852.11168-16-chia-yu.chang@nokia-bell-labs.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
	<20260119185852.11168-16-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 19:58:52 +0100 chia-yu.chang@nokia-bell-labs.com
wrote:
> Linux Accurate ECN test sets using ACE counters and AccECN options to
> cover several scenarios: Connection teardown, different ACK conditions,
> counter wrapping, SACK space grabbing, fallback schemes, negotiation
> retransmission/reorder/loss, AccECN option drop/loss, different
> handshake reflectors, data with marking, and different sysctl values.

Thank you for closing the packetdrill side, and big thanks to Neal 
for prioritizing getting it reviewed and merged!

I updated the packetdrill build in netdev CI and looks like one of
the cases is flaking a little. Since it looks like you'll have to
respin, please try to fix:

# 1..2
# tcp_accecn_client_accecn_options_lost.pkt:32: error handling packet: timing error: expected outbound packet in relative time range +0.020000~+0.500000 sec but happened at +0.015816 sec
# script packet:  0.181936 .5 1:1013(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
# actual packet:  0.177752 .EA 1:1013(1012) ack 1 win 1050 <ECN e1b 1 ceb 0 e0b 1,nop>
# not ok 1 ipv4
# tcp_accecn_client_accecn_options_lost.pkt:32: error handling packet: timing error: expected outbound packet in relative time range +0.020000~+0.500000 sec but happened at +0.015800 sec
# script packet:  0.181952 .5 1:1013(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
# actual packet:  0.177752 .EA 1:1013(1012) ack 1 win 1050 <ECN e1b 1 ceb 0 e0b 1,nop>
# not ok 2 ipv6
# # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0

https://netdev-ctrl.bots.linux.dev/logs/vmksft/packetdrill/results/482201/115-tcp-accecn-client-accecn-options-lost-pkt/stdout
