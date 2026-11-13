Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596191;
	b=sy75HHXkt6YpO/KK2C7l0XU5jT5C72QC6wD9hmuTMSsQTd5pYB4mkbJf5vWIkudpLxbS
	 lC35P61jYgyVvgkYf2IRmO3dyeU/GsTqSiWkuPnJswg1jDWnPKPcMvfCPIJ74n8NnaOxD
	 D9zkVbpzSce61qjFWv/NFTBwH81yeqZc2cw6uGJdbZKRuAJ/884zuwrhdExBhukfsrCgH
	 aC/D9ofoXJcZavOMRF2o4Fn0Q7SeaVoVvRHmQpj+WegrnvcO71Dt050Xu2zz+AOTLdjpm
	 S62LBNMhxgjCluIDYHysu0l7EumaFUsu8GxwBTmMvk3Q4XzKdayRGthil1utgodXfAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596191;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=yFdwvbHw5wYwNA79EZEdKg0l9rgBhDjGSJLzlZC1veE=;
	b=DbaI19DLDGyi8iVoeihaOE65IrclVH5lWzHgWsC54sRui7AarNUEv17Nby5Mcw6kWiL6
	 et5Wkw85PgsExAxKwjTABfmHrX9aaGNH/pU9yhYLy78WU2DcqrPJocHmyp5kR8ZI2s31z
	 S5Z3yU9Io38+Xtm0vL2ayF1xlmd0y2bqamRv3gFquvtX7kpKCT8p412/v+R6C77XjUhzy
	 KCK7XKlWgmu/MNnZ0Ifty1yQ6RMFwwdl0CX3ubfvcp5piK2RAaLdH+JawHCvZSL1dC0UQ
	 urCwEDTcFvrC3ZXjb2yqNfq2Rs3nbRrnI6ON/iaMA0XCENx2DSA+m2fRO7DtnMXJ4YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=CaHmSqNy;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D839D607107E;
	Fri, 13 Nov 2026 18:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D839D607107E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=CaHmSqNy
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFShxG2379543;
	Fri, 13 Nov 2026 10:56:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=yFdwvbHw5
	wYwNA79EZEdKg0l9rgBhDjGSJLzlZC1veE=; b=CaHmSqNyykNxVCuA9oD1ttcJM
	4jjuIode84a3DiYMTugXGn8pb71z0IGCJ6DG+TXy62IZRizVk8gqhD34Lixld7Tv
	chstJluCpFShFh4Dau+WBUfde9X1FVPPrLm2pQ8xs2lalGewkHfuu9098tKQnqZ/
	N5/qWTPifSC/jwBpwmE7NeC0JtYRnGWbbK5Dx7zvYr1GgzwjG3u1FC7tJBjsNn5k
	Zz2/PiRmurA4SsCg8j4W/fyS8LSd4MnD9IgD33ouXowxcN8VNeOGCs3AgJoHXNh0
	6Nc4b/JoyZ1CFih9nSKhm+wX/xD62/E9xjmowfoY3LEuyEafyZNgG6Ori9h1w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwnm16etv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 10:56:00 -0800 (PST)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 13 Nov
 2026 18:55:58 +0000
From: Todd Freed <toddfreed@meta.com>
To: <netdev@vger.kernel.org>, <toddfreed@meta.com>
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
        "Stanislav
 Fomichev" <sdf@fomichev.me>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "Boris
 Pismenny" <borisp@nvidia.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/3] net: don't redirect decrypted skbs to ingress, psp time-wait validator
Date: Fri, 13 Nov 2026 10:55:50 -0800
Message-ID: <20261113185553.171059-1-toddfreed@meta.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX67Tj9ZMupP62
 guwflFJZNfZRkhKx9IbcoC7tqYYv+9E2KGaO3JZaf/GRrPyOJiA42xBDfDXdqvI3suYjIyk6a4W
 Jr10Dw3gICm3do1uZsMy9IXiD/0uT+w=
X-Proofpoint-ORIG-GUID: HbG8eXA8DjEGd4N3GkGaDT0kj9CyOF0u
X-Authority-Analysis: v=2.4 cv=acv0Dhot c=1 sm=1 tr=0 ts=6af75d40 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=rxrEgwTP5pyjjZjSKO4A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX79xatqR/Wbes
 KDC0MzYBl6BjuBdaLhPKCSfyOSQVWtD2FFTr7i/AWWtKyF/anSwp/zorOO9P85n5D9aLYZRVNF3
 qLYfUQkygCaXtdNt+lKDt1SUn/WEYbibpzUCIn4wphxfVBHc2kedJepeDyqS6IlGmtxOz2aoaxN
 iIgBWIp7ltmOvK5SAtZmolTPw58DM1FuT/ldHgvC2H384GTOY0ViDLSh9zbQDJo7/mVr0GF6hdf
 RMHV/06gLt0jOL/q0F8RNZ/lXJ0afz5aaHoPHZk5SXF22GO+LRAZWfrC849l5IqegxcJWVlnuSL
 FZxsfT40cv03VI0DbebHK5bAUm8E/WcWfjpImCwQKnB6Jcr9Dd0QgXLcamBErrHE4PEEPYd5zxJ
 tL6GZW20P5YtflopkpGuqkkiKI2TGRs4qs2dkcnAdJ81e6br1CfGUX0/ck6k4Zr14OF7J38/17L
 3yyRSNh721uKLWH5gjg==
X-Proofpoint-GUID: HbG8eXA8DjEGd4N3GkGaDT0kj9CyOF0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01

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

Todd Freed (3):
  net/sched: act_mirred: don't send decrypted skbs from egress to
    ingress
  bpf: don't redirect decrypted skbs from egress to ingress
  psp: only give time-wait sockets of PSP connections a validator

 net/core/filter.c      | 10 ++++++++++
 net/psp/psp_sock.c     |  7 +++++--
 net/sched/act_mirred.c |  6 ++++++
 3 files changed, 21 insertions(+), 2 deletions(-)


base-commit: ead6fa9a0ab194f02a2f36d634b193e9c5f9a1c6
-- 
2.53.1-Meta
