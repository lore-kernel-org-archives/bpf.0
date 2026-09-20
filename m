Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743FE3E40E5
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890938; cv=none; b=f5WQavdbZx3wNS02Z8omwpyaUq5jOJvHcTIZCl3DwQUOe2XaR+Mdcjip8qWDxeqt3rRstuUfdTVRCKbyFWFDW4BXON/JPaha6h24cznNwSOdLMgFlLpC4weSyW6cMVpnfRaPI38E9OwYtXNq6jROqOZruFOukIIACzM+PFxpt3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890938; c=relaxed/simple;
	bh=b0bDuD1LZgSRiC1UmemKX/tGg2f6GIdP8dzxzMBCLvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LQo777N/UgKZ2wuuBQGiTjvXhVoW9bRFBZ4H5jw9OToHNnit5DaAfgr/NQ0Jvp9V/LJWAzobkOH9HX7maCek6WIPyzEpZK1stGi1z5kYVdmKnn53OE9ETmfwhzgLTc1RgbTj9KejsxXQByyn3g/LoCpOnao9yfHtBRJaF+5GPKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IATISA/u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LjTXRlSY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IATISA/u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LjTXRlSY"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68K55MaE2096953
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 07:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pfx6bFZMERQUrEBTxPu8VU
	3eqd+xw8Jj7J3BM1EDBcQ=; b=IATISA/uzXCNai6GH7dAEwXGGjFGpgMHOk9YGG
	weTZJckRXeF9ErvS6FJiHsj9u1fQEJxYB9VFD/Rt3RRrNWkNwsfFWCghByE2d5g0
	XgiMxzTxKrUtzAoTqI7hiERPSvtEPTl+91r1JDeZSformC9bqP9pdkDMOFezGULX
	idCJEQMM++szYvkKW1p0lUmO4ty8/LyHPzNKxmYfSjUQsTClVtdy6wsj4UOB/R/N
	4pRgTJ1S/6dF626xc4OyqSEai8DPp33+iKZql85UfzE7t8IYRxQtinLhPoejx86M
	8BLZqrQOFcQtZvCLx7xS+fqwvXRYshKbNAcgZpjSyrbnR2BQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshyxtkpn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 07:55:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939f925ba4eso213217185a.3
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 00:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789890935; x=1790495735; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pfx6bFZMERQUrEBTxPu8VU3eqd+xw8Jj7J3BM1EDBcQ=;
        b=LjTXRlSYNNrPvzNHWTRqAx8LhlRcZYFQsvzCcFU3TipUXnWL/hzeNpuY+B8ScNoCB3
         nxi5KWndgHNC3B4yqFDLFFn2IvnO2BdNVrTTa7U+S/am3lQLcX4UJ0c7R6U6kvKTImMR
         Xj+C1jPh4NZrq6uS0fUHP6m0eDSwzn2a+xdkSTcgMcmWsUDnUpQ97vrpp/SDDYoNl7g8
         VtNCx5YogKuE9SuxX/XX0gfYS070blwdgIdZUG97bo/ayHjrA0bXHXNeaLWXzk/nGTSr
         QpZuptI+qY9HJN9uEGJ/3IzgLLaWbDpUd90KZfr6XKwq6RQQANV2BVm6WnrGMOW9OUrK
         1zJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789890935; x=1790495735;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pfx6bFZMERQUrEBTxPu8VU3eqd+xw8Jj7J3BM1EDBcQ=;
        b=HamK73wGsXVmGFhvdwS7uwfoTDPkfJOC+YLLJxEbctpkPvysGaut5tUHaWr+B1jNeB
         1kr2uQCvDAL29i5PM0zLWq7BPo1L67yttBLSWZccR9GyzDs5KH53rFk29Yh72sNIzJtA
         aolMl014ZiRQk7nxlMWgDNu9TTDyjf70QBAgZyITkG3lnFipvHfRmyclAOMlZEkhsuUm
         YV4YKHGBCEWTuIcDwFdGzA/9hiFd63+U0REBhDqNcln+/7P1AoZOh02akWcsbpm3T4AK
         soUbUlbb2F6Q9yMBXsXz+J87kfr+Ei0TEm6S8sZ0M24696J0iVKFCygOa6EeLc7bOrgj
         NMMg==
X-Forwarded-Encrypted: i=1; AKwUvBwBce9E0LfWEkjqpcfjA98Wn1vm0q7a6MpHF87vL75OwPZZP3DqQD9vnFI6CuUdC7VcBxM=@vger.kernel.org
X-Gm-Message-State: AFuF++mb8fPvp7XIWI+xNr+MamS8kPvJilFeL9PcZoDqxE4IZe7sd/2f
	5b64YMnExjwLf8A7POMTNgD6upqcGkah1leZU0qHhIp46bsXO7VR2uI48vBykQDasooRDKrbgvW
	vrYc4sugKGeaLkKIMIcXP7xrm55WwlPfqyqRgNqysHbTFTtLd+uwHpyA=
X-Gm-Gg: AYBFou2KW7LivnxCC1Mtf7CaEJLa4998wNvE4ss6e/UU6ORFrlqNKNx/Z+M/ysEvk5G
	S7rRRezyzp3zG4g+jSp6d2bGzc8b3SzDqFfzgT9BXuzKmztJ28pO0fTUzmrUC6D6XH3beL9RCVK
	STKsF773GWwknxTAzMdutXxCsDuC0VTz0iXIRXS62eARmRV75tPHK0HjLMQFPsfxaMA7a/Bo2mo
	7tPDO1QJ+Z/ugYSyTFbfXU8AlBf3lx56GUKSAVXoNoN6uLwfJdFCaR9XNVI23W2hMmRcYNcBhrQ
	KVV+rbkB4KG7AtxLlqlXdO+600ULLZ7JjaecaRiGBxKHbuQXwMG95k8LIsSksoFcgsmIZemXjEK
	E3bOsSDLoBwiPNA==
X-Received: by 2002:a05:620a:4148:b0:93b:d7a1:ba1a with SMTP id af79cd13be357-93bf57851c9mr458278885a.69.1789890935613;
        Sun, 20 Sep 2026 00:55:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4148:b0:93b:d7a1:ba1a with SMTP id af79cd13be357-93bf57851c9mr458277085a.69.1789890935172;
        Sun, 20 Sep 2026 00:55:35 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd090f0csm178070855e9.15.2026.09.20.00.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:55:34 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sun, 20 Sep 2026 09:55:09 +0200
Subject: [PATCH net] net: mvneta: clear XDP pfmemalloc flag between frames
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-mvneta-xdp-clear-frag-fix-v1-1-d7efadecf959@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqEMAwAvyI5G7CCXepXxEOs0Q1olVSkIP59w
 x5nYOaBzCqcoa8eUL4ly5EMXF1B/FJaGWU2hrZpfRNcwP1OfBGW+cS4MSkuSisuUvBD0QfHznd
 hAutPZdP/9wAWwfi+P/0hThlwAAAA
X-Change-ID: 20260919-mvneta-xdp-clear-frag-fix-7ac691e1659b
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Toke Hoiland-Jorgensen <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=PaRqFShd c=1 sm=1 tr=0 ts=6aaf9178 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=GC6wR5CVy_D9Ox6dz04A:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDExMyBTYWx0ZWRfXxULMqIJC8ZFL
 +B3pPcleUIc5ZBrnlNvWj8EgyjWOYu5gsFcw4HaxKKAghs+WeX0gEGlHpLYL6ZIJHOFx1TrMdC/
 HbDhRoVHuPv/BLCPDGiJA2Z4Jzj1X30=
X-Proofpoint-GUID: 3qXgwxlEcDNSJBQy-ZHNP4xPLgx7z_CO
X-Proofpoint-ORIG-GUID: 3qXgwxlEcDNSJBQy-ZHNP4xPLgx7z_CO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDExMyBTYWx0ZWRfX5J8GAus2+8MR
 PLRK1WeUQV3VOX42Kp2EL2x3fOMzTP41BzcfdUn+7H2zROPQGTz4zvbLqvgHCNT2fuxU6GX2ZWM
 oyUV4fVSJ2Oqi4SR39SNT5+5YkXivipG89j1bFkFkMTxsgg0xB+nkg8bQxPLxGRDKYPLOR7yaRu
 vT3tAFy21IsPIVEbM48ONsYYZYI+7VwvPNCfokM8y+pDATuRSjLzWbYHRTjhFBNM+oFKEAgYfu5
 wW0JFml2sj/WZlt29JFVaB0riyff5i5Y8XgtRnf5bB5HmIh7XxSK2GeVc/P3pTiLYjEwwfucTe1
 XAcnw2hqxB5weIbutnv8UwTzRnLb7p06iDnHArMV0xpjW19pUHHTxJIbZAPFsZ4gJfqstIjgPbp
 Ztm8HboUdpDOAAxQvoWMXVtFp+rJ43lBtEEkeluw7cnT0P9beFP+yTbkX9jRfJliNTc96a6w+qv
 3fXaNZYsaO5KE1eM1TQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200113

In mvneta_swbm_add_rx_fragment() the XDP pfmemalloc flag is set on the
xdp_buff if the page under pressure is a pfmemalloc one. The xdp_buff is
reused for the next packet and the flag is never cleared, so a pfmemalloc
fragment in one packet wrongly marks the skb of a subsequent packet as
pfmemalloc. Clear the flag in mvneta_swbm_rx_frame(), which is invoked for
each new frame.

Fixes: ed7a58cb40bd ("net: marvell: rely on xdp_update_skb_shared_info utility routine")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 543e566425c1..32416999f3d6 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2341,6 +2341,7 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
 	/* Prefetch header */
 	prefetch(data);
 	xdp_buff_clear_frags_flag(xdp);
+	xdp_buff_clear_frag_pfmemalloc(xdp);
 	xdp_prepare_buff(xdp, data, pp->rx_offset_correction + MVNETA_MH_SIZE,
 			 data_len, true);
 }

---
base-commit: e3bfd25626b44b6fa61a13c17178922171d519ce
change-id: 20260919-mvneta-xdp-clear-frag-fix-7ac691e1659b

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

