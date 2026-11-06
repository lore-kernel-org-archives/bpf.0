Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.149.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965293;
	b=EAh6JlbGvqq+vFDevEr0kbsZ+H8ZG8u6uDa041AArnhQjRRg+ozk+4oWM+py9ez0q+tT
	 ZXubcQEV4xykmp//UmM4I0cdsNVO99RwsHrbKCMKzzXqufd1bgllWzuNm6ZLJrfqvkpdk
	 dtAj97gujyL6Ego9Nryt7WgcdADipR7iH0F0DxO8Rij7O4dHa+VryDttD2Fns1I23fqEy
	 b5rKEPVb7EOdgQkfI9SQHACEwxhHfIgGNQKjrxWD5D+zV/5NiWoRX4X2CGGn8WsVqHkzu
	 N4PZkSNlvIr75QhA+mwx0DX5Nx0ViG+NrNWwL+8Dxmq2PBSkaEN+hXa24nGQw4/WCSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965293;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6JqcFZw2DreE50hImFuQgRUSPI0sEWGLexA8Fi5Q35c=;
	b=2OVnDvYBK1oCsi7FWCS/LPbSai348eYE53HekSmJzjOsByxkQm0DN4r59+a7rvTFXgwv
	 9LgOqEqdnlqoWnK2L9oWI2zsn9VFMqbe2IXj0AnGz1FQe18CfomB3oOTlXhLqJnMXWl86
	 NMSTy93Bk/A9Eygg9KMsIn7D6/PSwv5EssMGVTbasPaKgfAujjut+gsY/q59FmUU3Effc
	 hogsqW8MCH7thhdlRMiGY5UMogg36g6ubNM8Pfx8XrEjE32HvSkOT4k+hbc35FFtMQPJT
	 rtyw0PyyWDT5CJ/VliDAleKLsoorTqfYcRAqTro6Nz52cAvHA585EFZWBIr70cOjfHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=akamai.com;
	spf=pass smtp.mailfrom=akamai.com;
	dkim=pass header.d=akamai.com header.i=@akamai.com header.a=rsa-sha256 header.s=apr2026.eng header.b="Xqd2BA/8";
	arc=none smtp.remote-ip=67.231.149.131
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2E1606A329;
	Fri,  6 Nov 2026 11:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B2E1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=akamai.com header.i=@akamai.com header.a=rsa-sha256 header.s=apr2026.eng header.b=Xqd2BA/8
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 6A63ZOSF982660;
	Fri, 6 Nov 2026 11:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=apr2026.eng; bh=6JqcFZw2DreE50hImFuQ
	gRUSPI0sEWGLexA8Fi5Q35c=; b=Xqd2BA/89bmWdvaTFptK1org502yaTinBIFH
	+DlbrKdyTmKIzLMncP+O466NCzaiWt7dQLaPUWtE4DbFJBAOZ0nToGSVjCw5tAsA
	1fhbbStLM+delM/W6KkcRHaa39r/Y7GbBPMICZpE69F9iBG82KeYoJ3Sp5ZJ7vJR
	Sqy6xKJoN4oMnvMqb6a5klTsZKStrP1xB5H651cnYviH+RKzXmwYO0stsDSpp5MR
	ZDe1cpR9GtoMHt8RIwV7eLAXuj4yY2BgtfbZlu3y4uUwcAZBYigfF73rs0QBtEFF
	7fRNkDNpla/ygOIdME65GgVp43lMdodrW87hicn4AK5nrFqE7A==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4hrey5ty49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:41:10 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 6A6BZeaD006231;
	Fri, 6 Nov 2026 06:41:09 -0500
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4hs3una43f-1;
	Fri, 06 Nov 2026 06:41:09 -0500 (EST)
Received: from [127.0.1.1] (muc-lhv4ep.munich.corp.akamai.com [172.29.0.215])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 71C0A83;
	Fri,  6 Nov 2026 11:41:07 +0000 (UTC)
From: Max Boone <mboone@akamai.com>
Date: Fri, 06 Nov 2026 12:40:55 +0100
Subject: [PATCH net-next] net: lwtunnel: use GFP_KERNEL in build_state
 paths
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-build-state-use-gfp-kernel-v1-1-18084382f878@akamai.com>
X-B4-Tracking: v=1; b=H4sIAMa87WoC/x3MQQqDMBAF0KvIrDuQWCy1VyldGPNjh8pUMlEE8
 e4NXb7NO8iQBUaP5qCMTUy+WuEvDY3vQSewxGpqXXvz3nUcVpkjWxkKeDXwlBb+ICtmHq9df4+
 +dyEFqsGSkWT/509SFFbshV7n+QOOl99udgAAAA==
X-Change-ID: 20261105-build-state-use-gfp-kernel-c3598d190bfb
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
        Justin Iurman <justin.iurman@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Donald Sharp <sharpd@nvidia.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Max Boone <mboone@akamai.com>,
        Debabrata Banerjee <dbanerje@akamai.com>,
        Nick Hudson <nhudson@akamai.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793965267; l=4428;
 i=mboone@akamai.com; s=20260317; h=from:subject:message-id;
 bh=LJP5KneWils/U/2yCjDE5joxzXA50czLgi/CoNddHkU=;
 b=CzpEqdWibOlncF0n9BKTV1FMFsXu0NAAzWIED5xUqpNW7e/ctavs6AzOQ6jVXqpX9Hku0CCW7
 eiphS3gHuMVBtFARadIfrNHQUZNdI7qbKpnISqBkwt3dBQ3T2pYDHMe
X-Developer-Key: i=mboone@akamai.com; a=ed25519;
 pk=jWdC/h5H2KWQCiC2kpr/puMVX0mJmP9W5sM8YTGBXA4=
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11957
 signatures=596817
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2611040000
 definitions=main-2611060046
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0NiBTYWx0ZWRfX+2gdTpzq+Q6S
 DTawaMSb50DCinsIn5mCc1pP648mrWw/Ujfi9/fBzndWZIGFUnV+3u4wiTlJP0kPiENuk8wHATE
 M4lUGSgPf3uNcWwG0B1KLIehFA8jL3I=
X-Proofpoint-GUID: TCIrFhySC1P4xMTTBKrOhaESz6hGIorH
X-Authority-Analysis: v=2.4 cv=e5KT2qp/ c=1 sm=1 tr=0 ts=6aedbcd6 cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ifg-1AOnLHOf1gn6spyb:22 a=d4nn1RXdvEacMIURMw2s:22 a=X7Ea-ya5AAAA:8
 a=Yl7yAlAd151cMgl_QPEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0NiBTYWx0ZWRfX1DitL39BG4vN
 yxCy9pOCDp2qfu+IeAGEjkwFbUGWA0nBvX81AbcAmIEOBC6OmomeumYMkvSsH4HFn11ZCe6YbVp
 CEEPZvpGY3Gxk0nAxtQgvgu7enV8GoLGIv72Z9OlSS5e7MHb1ywvoo+ZlAWmhB3VBDQxOhNsVcc
 DODRe4ITwlap4Hvf/IkwX8iOLNBgBZgBJunzsCiC6YDiEoG4OY0GS86AnrEdoJrS0FmIhL7LpAh
 AHCWDlvtRl/8VpDHVhZbR1UfgzOE92r1P2nbf3XU4Jy4HXEqWWKpk7ahW+faQvN0vnsI/Yob7o1
 +uaQ8SbCDdnhM8GtveoeFFX3uhAMIBX5tL+bKZD5LvL2wxyz+yQaw2rlBQJ0dU6XQO8k1dayldF
 GhoCsyImTGf9HMUCRZiZiRwq6WAkTYybhPb0+iHNxcBIt360qXbcvXs8On0ry7WySPMEY5MbNUM
 QDPlsuublZIYEcCUTVg==
X-Proofpoint-ORIG-GUID: TCIrFhySC1P4xMTTBKrOhaESz6hGIorH
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11957
 signatures=596817
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060046

Since 3d25eabbbf67 ("ip_tunnel: Add dst_cache support in lwtunnel_state
of ip tunnel"), build_state runs outside RCU and all its callers can
sleep, but paths still use GFP_ATOMIC.

For dst caches, that limits allocation to populated percpu pages. A
large burst of SRv6 nexthops outruns the refill worker and will fail
with -ENOMEM despite there being free memory:

  percpu: allocation failed, size=40 align=8 atomic=1, atomic alloc
failed, no space left

Batching 20000 RTM_NEWNEXTHOP under QEMU gave 10-109 failures per run
before, none after.

This commit converts the allocations reached through ops->build_state()
and are called after the rcu_read_unlock():

  - ila_build_state(), ioam6_build_state(), rpl_build_state(),
    seg6_build_state(): build_state ops
  - bpf_parse_prog(): only called from bpf_build_state()
  - lwtunnel_state_alloc(): only called from build_state ops (also
    affects mpls, ip/ip6 tunnel, xfrmi and seg6_local)

Signed-off-by: Max Boone <mboone@akamai.com>
Reviewed-by: Debabrata Banerjee <dbanerje@akamai.com>
Reviewed-by: Nick Hudson <nhudson@akamai.com>
---
 net/core/lwt_bpf.c        | 2 +-
 net/core/lwtunnel.c       | 2 +-
 net/ipv6/ila/ila_lwt.c    | 2 +-
 net/ipv6/ioam6_iptunnel.c | 2 +-
 net/ipv6/rpl_iptunnel.c   | 2 +-
 net/ipv6/seg6_iptunnel.c  | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index da49364ec63d..6d1059ff0c49 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -359,7 +359,7 @@ static int bpf_parse_prog(struct nlattr *attr, struct bpf_lwt_prog *prog,
 	if (!tb[LWT_BPF_PROG_FD] || !tb[LWT_BPF_PROG_NAME])
 		return -EINVAL;
 
-	prog->name = nla_memdup(tb[LWT_BPF_PROG_NAME], GFP_ATOMIC);
+	prog->name = nla_memdup(tb[LWT_BPF_PROG_NAME], GFP_KERNEL);
 	if (!prog->name)
 		return -ENOMEM;
 
diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index 8223c44f10c8..f2f4d1ace0e9 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -70,7 +70,7 @@ struct lwtunnel_state *lwtunnel_state_alloc(int encap_len)
 {
 	struct lwtunnel_state *lws;
 
-	lws = kzalloc(sizeof(*lws) + encap_len, GFP_ATOMIC);
+	lws = kzalloc(sizeof(*lws) + encap_len, GFP_KERNEL);
 
 	return lws;
 }
diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
index 7bb9edc5c28c..01fd78a232e7 100644
--- a/net/ipv6/ila/ila_lwt.c
+++ b/net/ipv6/ila/ila_lwt.c
@@ -228,7 +228,7 @@ static int ila_build_state(struct net *net, struct nlattr *nla,
 		return -ENOMEM;
 
 	ilwt = ila_lwt_lwtunnel(newts);
-	ret = dst_cache_init(&ilwt->dst_cache, GFP_ATOMIC);
+	ret = dst_cache_init(&ilwt->dst_cache, GFP_KERNEL);
 	if (ret) {
 		kfree(newts);
 		return ret;
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index cfb2c41634a0..3093446ad89a 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -166,7 +166,7 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
 		return -ENOMEM;
 
 	ilwt = ioam6_lwt_state(lwt);
-	err = dst_cache_init(&ilwt->cache, GFP_ATOMIC);
+	err = dst_cache_init(&ilwt->cache, GFP_KERNEL);
 	if (err)
 		goto free_lwt;
 
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 4e10adcd70e8..838ede10a79d 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -102,7 +102,7 @@ static int rpl_build_state(struct net *net, struct nlattr *nla,
 
 	rlwt = rpl_lwt_lwtunnel(newts);
 
-	err = dst_cache_init(&rlwt->cache, GFP_ATOMIC);
+	err = dst_cache_init(&rlwt->cache, GFP_KERNEL);
 	if (err) {
 		kfree(newts);
 		return err;
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 0d39a38a5dd2..7c64680e4632 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -833,11 +833,11 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 
 	slwt = seg6_lwt_lwtunnel(newts);
 
-	err = dst_cache_init(&slwt->cache_input, GFP_ATOMIC);
+	err = dst_cache_init(&slwt->cache_input, GFP_KERNEL);
 	if (err)
 		goto err_free_newts;
 
-	err = dst_cache_init(&slwt->cache_output, GFP_ATOMIC);
+	err = dst_cache_init(&slwt->cache_output, GFP_KERNEL);
 	if (err)
 		goto err_destroy_input;
 

---
base-commit: 0822d2fe38262e8b55c5ea55c970022bca8dd2a9
change-id: 20261105-build-state-use-gfp-kernel-c3598d190bfb

Best regards,
-- 
Max Boone <mboone@akamai.com>

