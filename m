Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793487146;
	b=W2Ey7U4gmly4DXiI/8X4bYyaGj3FshVh+rG2DYAlqMiFHHsxwQmArYEiqlprPltA/NXa
	 bFKUt62Q82AZDkA3Iz7GralfkTPr7rpHBMFQHqXd4cfzOOgE3Vujt//Jdkp/sQOqbjP3G
	 Sx+9vyTKi0Xdpr2FtfIbuUgFcgW2LceOk9htduHQefpMtjEw4uCE6WZPceL7Khpac+eTZ
	 QH7eryFmBCarfEf9qnGq5TlYd+hsmU659X1XleQWwHjJX00fgUcrZ8Ii46wOt8Yyla5wB
	 0GzHHfYPQp+caWcEj9BmaQiXWY6YB8rzq9IOJdmB229NfakWw0fk3RDrckKugpA/nPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793487146;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=Ox8aB2IkDQqiaAD02S4mH3h/jqF0+iwrxAxwbI8wRx4=;
	b=AMFMFfs2HZhlzSy5C0WLw+47A7byrJ0gK0znriCCncZcrxABoEGJdEpZH/PLwT5U74A3
	 sfWyX3wVD80v2A7+c8tuiNQ+GCP32eYl/bNKBCmGYjS/ehzaHK6zaFjpr3sy9JT10WBal
	 okGm0Pvpxeb3679sh7OwPU0zjE2TT/8ZXNwQEoy9KHoRtiGfSfLgttdQYaRIxR0GQPTvu
	 kNC2IZ+R7q3N/wzQuMTjkraSV5qsEkUDOwLlwKkz1kEK/4b7R+x5HCkvFFeB9Yw89dZJs
	 I6lVpW9Ai2t3wU4J/6z0i3Tim+lYNgVkek2HTNpKTnLauOgn9VKe6kPS1S/Xt9Gi3dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=temperror header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=LiZTmqH6;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=NhhF2tVT;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A22F606A31C;
	Sat, 31 Oct 2026 22:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A22F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=LiZTmqH6;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=NhhF2tVT
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69VMpGpM021941;
	Sat, 31 Oct 2026 23:51:21 +0100
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 9A135120535;
	Sat, 31 Oct 2026 23:51:11 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1793487071; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=Ox8aB2IkDQqiaAD02S4mH3h/jqF0+iwrxAxwbI8wRx4=;
	b=LiZTmqH6MzOn2Ho0Ne/okXzI8pJ+7Ie/fNo89+XE0xZJclZeFYTwcKGX+GSgbQwrU0CZaQ
	Z8vwKgYSFtHlhxBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1793487071; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=Ox8aB2IkDQqiaAD02S4mH3h/jqF0+iwrxAxwbI8wRx4=;
	b=NhhF2tVT7+967piM/2oHEEBSmkuYvqlm/C9nJg81LCQfHU394Kje93N2TSK2P7az0b4S/Y
	2KeUdXk/F6LCZce/F9ITQS38QbcfLEoZvauQANuoJqluat0wCuqYH3aNLG78UMB2zPqI8Y
	YFx7DOFh7T+1Z4FblfqMCByEqKQuBhkUF6Wv2H36uq3w69DGkoS6ZAs9j596LRyEjmoaaX
	VHgiRrdOMOnG5FdbNUE9UEkcSTsW/ZYEAvbEqLM2dRTm5PyH2NBEPBeMm8Tb1fGrco+n5M
	ViR6YHo6syUyPHXGPvSvHlcStAdGi3VELAboj3wdee1ztikGF22Au1cu1kRIfg==
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
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Andrea Mayer <andrea@common-net.org>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net 0/6] seg6: fix skb checksum updates with CHECKSUM_COMPLETE
Date: Sat, 31 Oct 2026 23:50:27 +0100
Message-Id: <20261031225033.64-1-andrea.mayer@uniroma2.it>
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
 .../selftests/net/srv6_csum_complete_test.sh  | 642 ++++++++++++++++++
 7 files changed, 742 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/net/srv6_csum_complete.bpf.c
 create mode 100755 tools/testing/selftests/net/srv6_csum_complete_test.sh

-- 
2.43.0

