Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943724;
	b=rnYPypuXq5+/LQ1gmVuXiJhEzZp6LgvwsruhxKLG8LYabImctGSavQ7gFuw9WfnZUcVw
	 SQZXEmlBhCPpi6wKOeXWLLr+eDIXBWv3/rOcA23ZgfUWVrcPEo9UBjgy/qD0C+PKWMt/f
	 5Fbi/u0Hojt+UUlhKEmTOO13a4plgvhL880SVPLKrAtRsWW7VLwab7mgrAHASV1BVX6pA
	 l5flexGHtiotGhhU73KIuPszm3dUMzY5zjeaW5kfKC7pAefCvwJ3tvL1ABL0hvUNYGbnz
	 0tYM0gClXDJTbtRKcejeBWaKvCJA9Ywk+GIjf1s31U327mIlK33L4P1kXEsf1Bq0H6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943724;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=77CANBbFHaLzPp1r6ro+6FHhpRKIZdwBWbuPrITQjqU=;
	b=ciYswbO2NU1mvjC8ohbJDZDsd+sWleaIoFoNs4i9Rn0Sg2sHhBQQr6jPpwRM9GnR/9yN
	 HdAWmhng3jN9DsQcjl6IXmvTao0oUWX2s5oAsJ0dDmPN6sOs0DCUASSDkxOjSD+5ejlN6
	 TrT4+M9stB/+hwj4gLpcRi0NN3wlXFuiVRJms6JU0pnAdk/QQPDVP2YdJJF/CZMtYj3Lm
	 srj6sGybzdRJYYAAwvEQo2MQO8aGitQ7xOQG4+wz4jpH8ikn3sNSgOM8OBPB6ALvHFQDv
	 jJRImVBedsJVQaZ2nPwxTtCiK3FMjYu1qZ9VgfXBVD++hVOMuRuugtdmIJMaLQBbeag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Gu7Rx7n7;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BC1606A31C;
	Tue, 17 Nov 2026 19:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9BC1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Gu7Rx7n7
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHJ9Wdu192321;
	Tue, 17 Nov 2026 11:28:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=77CANBbFH
	aLzPp1r6ro+6FHhpRKIZdwBWbuPrITQjqU=; b=Gu7Rx7n71v3EPXJCYipfHfo9x
	brFxRG0Yc5Uup/G1vUOJGE/C3zMPI2yvFyKx8+QIDNUp9zXUXsYY0ezMF8H1SRex
	Do2k9z65Ax7iI/inOl/OfYrGKRxfA+QJB19LPZ7CpnQ9F56HdcTVk+Po4xkD5qGz
	Kqrf79RBgqqiMJrB3Kmb3xmFWVt3SS8/bOTisphdZak6GHQNFhabnuca6/dPt9ym
	MyVnRWYjBblEUwvO4OQz4PDCC3VX5KK7zYHFUywKAlU8aRS4bEBf0hqSCT7G5JaL
	4eC/t/7/wt+WR0Nw09Y2ZTaSUcy+rRkdD4cAwsMlDpU5GIpXhho0Vv65DpV2g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0rduub13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Nov 2026 11:27:58 -0800 (PST)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Tue, 17 Nov
 2026 19:24:20 +0000
From: Todd Freed <toddfreed@meta.com>
To: <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Daniel Zahka
	<daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Wei Wang <weiwan@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko
	<jiri@resnulli.us>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav
 Fomichev <sdf@fomichev.me>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Boris
 Pismenny <borisp@nvidia.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net v2 0/3] net: don't redirect decrypted skbs to ingress, psp time-wait validator
Date: Tue, 17 Nov 2026 11:24:08 -0800
Message-ID: <20261117192411.247117-1-toddfreed@meta.com>
X-Mailer: git-send-email 2.53.1
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
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Ud0f6sL0t6-L0mjLd04S09CvLkDdLy_j
X-Authority-Analysis: v=2.4 cv=Apx7T+9P c=1 sm=1 tr=0 ts=6afcaac0 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=rxrEgwTP5pyjjZjSKO4A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: Ud0f6sL0t6-L0mjLd04S09CvLkDdLy_j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NyBTYWx0ZWRfX2GVKlDr4PtEm
 IkXavycXsxho0TBcMH2gUJ9MLASorZpSo/BVHsKyzZca7D78knOQZ0s4uUhvJK40CwcZ6vYl1xY
 W+O4rj0VYhDkwTr2Jxz9owEoZTVPkzA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NyBTYWx0ZWRfXz0rgizU/EJdm
 UwXTAjUmc5zH0Q1T0lGOco+67ghf7xDWFJkmT20mGQLgKAGtkuCjZ5fo8th4gJT09f069tILZT7
 tWKa7mcX4x67xFK71+5/+myp2cWfOHI8SJUIfvjalMqPprKhEt4KWlXxQtiO0sb+yIQFo34C015
 SIONVUbY5JUfhTISE4CKdmi6+BvqIW2VDgM6Ty3QzT5tv8B3+vHC5S0DhF7xJ3XyPjXJcZpZ1xA
 1WGLsSHbAPOzy2/Ef7RrIepjg3dcboP7zyKlNDQfHZbrXpAor5arg4RKUNAZ/8IPCW12Nm4ZKsj
 z6tEIxU1lgnq8lf/Rv0NXvT+HQQx/HeNeUlnxRmQ2iipUNkEHbGia6aKBL8E120DpEW+6uPk/wS
 S5cyO3nRsACjUZENxVS+ey/Mo/bIe4mg1LUtUIt4V/OKQz0Un5irdo9uq9j7hCkU+TDiYk//HdW
 VfUg055rtt9+Pvjk4Qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01

Three fixes that are relevant for the net-next series, "psp: introduce
socket-less associations". These were previously patches 6-8 of its v1:

  https://lore.kernel.org/netdev/20261111005533.6436-1-toddfreed@meta.com

The first two patches prevent sending decrypted skbs from egress to
ingress, since the meaning of skb->decrypted depends on the direction.
This affects the packets of kTLS and PSP device offload sockets.

The third patch makes psp_twsk_init() give a validator only to the
time-wait sockets of PSP connections with a Tx key, instead of to every
TCP time-wait socket. It has no effect today, but the net-next series
will rely on the presence of the validator to check if the socket has
an encryption offload.

Testing, on two hosts with mlx5 (ConnectX-7), with and without the
patches: an egress rule on a connection's flow sends its packets to the
device's ingress, with mirred (mirror and redirect) or bpf
(bpf_clone_redirect() and bpf_redirect() with BPF_F_INGRESS), for a PSP
device offload socket, a kTLS device offload socket and a plain TCP
socket.

Without the patches, the PSP and kTLS sockets' packets arrive on ingress
in all four cases. With them, none do: mirrored and cloned packets still
go out, encrypted by the device, and redirected ones are dropped. The
plain TCP socket's packets arrive on ingress in all four cases, with and
without the patches. The PSP and plain TCP cases give the same results
on netdevsim.

drivers/net psp.py and hw/tls_hw_offload.py pass, with and without the
patches, as does tc-testing mirred.json on netdevsim (39 pass, 7 skipped
by their dependsOn probes). Each patch builds without warnings (gcc and
clang, allmodconfig, W=1).

v2 was re-tested as above, plus bpf selftests  lwt_redirect, lwt_reroute
and lwt_misc

v2:
- Cc: stable on patches 1 and 2 (Jamal)
- patch 2: also clear tc_at_ingress before running an LWT xmit program.
  Sashiko found this in its review of the same patch in the net-next
  series v1:
  https://lore.kernel.org/netdev/179471270091.2199510.4320994626979041884@kernel.org
- drop commit message references to the net-next series (Daniel)
- rebased on net/main

v1: https://lore.kernel.org/netdev/20261113185553.171059-1-toddfreed@meta.com

Todd Freed (3):
  net/sched: act_mirred: don't send decrypted skbs from egress to
    ingress
  bpf: don't redirect decrypted skbs from egress to ingress
  psp: only give time-wait sockets of PSP connections a validator

 net/core/filter.c      | 10 ++++++++++
 net/core/lwt_bpf.c     |  8 ++++++++
 net/psp/psp_sock.c     |  6 ++++--
 net/sched/act_mirred.c |  6 ++++++
 4 files changed, 28 insertions(+), 2 deletions(-)


base-commit: 5e9b2ad9b8384cd3c417cd5e2c3bc7eee4a72791
-- 
2.53.1-Meta
