Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014509;
	b=mUgTe3zmS/4toBuKaOgrNXqmqX3abCUpXJVK0GPhzTLPr2fJKdmRT0IhNh5aBEkJmkP6
	 pboL8CVGz0JRV5cHW9RJ7cW8hx5+dAAe+F6SAaZr+2Rn2b7ShYWST9lG9pg545mKDQB4b
	 3PuYk1++MSRs5+tPH9oM5mPmBOdYE3vyN5FBeEk6olitujggaVLhqbO/XqI23PL275csh
	 mWbD0Ta3XMer7bwjjDXx6jvh1St/nfbWl+50EJXXYMqA7gUcd+eRw6+pmnc0VlyKerCJ1
	 VCAURWJT45uYI3noRLCekEmTf4rkAPZOJcQmcqVryGFJRMvr68EI0MfSNnkj/D5YFXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014509;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=GK5STU+MzzMbRDE228gZW24i7ufyj4DGDobudL8Cxs8=;
	b=f0gQF/0ZGxb1cflsyWZs7Ij7FFV5SqsuKY7mW6m73DNZ6DHWQzJy3CssXeJZsBQ3d75X
	 aJolhUuC3xi3/JpTCChsRQkyUtoBNjT7tUinQNKdkGHpZ+Tw07cT5K6zBLmxXDyPvMHvv
	 q7nB2WFks72dkJV/4HF4W2Kv8Pw9jILeAxOZAJd/1SXwxFz1X2w7N5egb2Gsi2robmpGW
	 TZivIQelO8nAYYI9n2GgIYBMbTunQzS0RLyosqIl3QyVlZrfW3y9iGJ83MBELl7ua8VcX
	 fNfXECU/0zmzQMNy1x49kd7iPYEDsZ+6kiZx2JrErlA7ZR3SwIUxxkVN8JmEtUySqdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=mlBbK8Tt;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=wSFleYje;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B96E60A2607;
	Wed, 18 Nov 2026 15:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B96E60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=mlBbK8Tt;
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=wSFleYje
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6AIF7X6s012187;
	Wed, 18 Nov 2026 16:07:38 +0100
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 2488212291C;
	Wed, 18 Nov 2026 16:07:30 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1795014450; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=GK5STU+MzzMbRDE228gZW24i7ufyj4DGDobudL8Cxs8=;
	b=mlBbK8TtJ7THAMv7BLLklC1V+IPlZBTtr991QDJIBnsJGxZmWbKZXnoF5PlrM6fdQE6k4f
	z4v4s9G7n/MTTXCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1795014450; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=GK5STU+MzzMbRDE228gZW24i7ufyj4DGDobudL8Cxs8=;
	b=wSFleYjej/Ht89lE7abdQCaKSeFt6SbgWuRVY03ervgp6YtAjcucRhxIntTYmpq98G+6wo
	+9xfU9MgVZxPatLdmOIa8MQioIgv/SDQfnZWwux1bJopIb7p6cDVh8zJ/6fDCYo4rNEShN
	z5OQjfiHLhha8gQMJkfICzv7Kq98e6quXqhl2He47wMJUOwnsc/D3vqDY2Z5GEQNhT3yZy
	FM1si4R1G6imOVbGSe4zkZp2s4Tol2/oPAggi91kbRlMHxlltpXFSUN0ut1pIpsb1vFqr3
	FzR5aMgSr01e1lE41X9LKG980doYPx1peJAo8j9Vft6m3H9ws8SCLqpjC6hh1Q==
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        David Lebrun <david.lebrun@uclouvain.be>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>,
        David Lebrun <dlebrun@google.com>, Hangbin Liu <hangbin.liu@linux.dev>,
        Justin Iurman <justin.iurman@gmail.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Andrea Mayer <andrea@common-net.org>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net v2 0/6] seg6: fix skb checksum updates with CHECKSUM_COMPLETE
Date: Wed, 18 Nov 2026 16:02:45 +0100
Message-Id: <20261118150251.65-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

This series fixes the skb->csum updates with CHECKSUM_COMPLETE when the
SRv6 code processes a received packet. In several places skb->csum is not
updated correctly:
 - ipv6_srh_rcv() updates skb->csum with the wrong sign for the new
   Segments Left and destination address, and not at all for the Hop Limit
   decrement.
 - advance_nextseg() and seg6_next_csid_advance_arg() in seg6_local do
   not update skb->csum.
 - The End.BPF program and seg6_bpf_has_valid_srh() can change the
   packet without updating skb->csum.
 - In L2ENCAP and L2ENCAP_RED mode, the MAC header put back in front of
   the frame is not added to skb->csum.

When the packet is then delivered on the same node, the effect depends on
who computed skb->csum. With skb->csum computed in software, for example by
conntrack, UDP can drop the packet as a checksum error. With skb->csum
computed by the device, TCP can log a "hw csum failure", as if the device
had computed a wrong skb->csum. In the L2ENCAP case skb->csum can be read
on local delivery, for example by a raw socket with IPV6_CHECKSUM.

The series is organized as follows:
 - Patch 1/6 fixes the update_csum_diff4() and update_csum_diff16()
   helpers.
 - Patch 2/6 updates skb->csum for the Hop Limit decrement in
   ipv6_srh_rcv().
   It depends on patch 1/6.
 - Patch 3/6 updates skb->csum when SRv6 behaviors advance to the next SID.
   It depends on patch 1/6.
 - Patch 4/6 discards CHECKSUM_COMPLETE after the End.BPF program.
 - Patch 5/6 accounts for the MAC header in skb->csum on L2 encapsulation.
 - Patch 6/6 adds a selftest that uses a tc ct action to compute skb->csum.
   It covers the paths of patches 1/6 to 4/6, and a control datagram
   checks that the test detects a wrong skb->csum.

Tested with the srv6_*.sh selftests, including the new one, and with the
lwt_seg6local BPF selftest. The series was also tested with a ConnectX-6 Lx
NIC (mlx5) that provides CHECKSUM_COMPLETE. Without the series, TCP over
the SRv6 paths of patches 1/6 to 4/6 can log "hw csum failure". The same
happens for a raw socket with IPV6_CHECKSUM, on a packet delivered locally
after L2ENCAP. With this series, none of this happens.

v2:
 1/6, 2/6 and 3/6:
  - no change, with the Reviewed-by of Hangbin Liu (Thanks Hangbin).
 4/6:
  - discard CHECKSUM_COMPLETE after the seg6_bpf_has_valid_srh() check
    (suggested by Hangbin Liu);
  - update the comment, since seg6_bpf_has_valid_srh() now runs before
    it;
  - add the srv6 selftests to the testing statement of the commit
    message.
 5/6:
  - no change.
 6/6:
  - call log_test_expected() directly, instead of a local log_test()
    wrapper (suggested by Hangbin Liu);
  - use require_command() of lib.sh instead of a local helper (suggested
    by Hangbin Liu).
v1: https://lore.kernel.org/netdev/20261031225033.64-1-andrea.mayer@uniroma2.it/

Thanks,
Andrea

Andrea Mayer (6):
  seg6: fix skb checksum update helpers
  seg6: update skb checksum when ipv6_srh_rcv() decrements the Hop Limit
  seg6: update skb checksum when SRv6 behaviors advance to the next SID
  seg6: discard CHECKSUM_COMPLETE after the End.BPF program
  seg6: account for the MAC header in skb checksum on L2 encapsulation
  selftests: seg6: add test for skb checksum with CHECKSUM_COMPLETE

 include/net/seg6.h                            |   4 +-
 net/ipv6/exthdrs.c                            |   8 +
 net/ipv6/seg6_iptunnel.c                      |   2 +-
 net/ipv6/seg6_local.c                         |  24 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/srv6_csum_complete.bpf.c    |  65 ++
 .../selftests/net/srv6_csum_complete_test.sh  | 627 ++++++++++++++++++
 7 files changed, 727 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/net/srv6_csum_complete.bpf.c
 create mode 100755 tools/testing/selftests/net/srv6_csum_complete_test.sh

-- 
2.43.0

