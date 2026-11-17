Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930726;
	b=to4srATPJk2jkVFpvDvJT8spJAW+CK26a81i1wzOpWRwIom4VKP+h1JmDSu/RiVlVnWL
	 RaQoAeqoHQSniZog1cOcR3XAJ9JXXnk8VVLTWgbXKRqDKOwcCoflV20/ZrkvyHhf2bqP8
	 h0Nvv+GdY+k0GOS0gkQQeiBULlspAxM9itwBx0nfRjVJrjPjonPydlzIgCrpZubD89QQ0
	 iI2H8BdhXvHyiZeQFWBC+idvKnEEU00TEyRpuJUG/RNNZtanjSx4JEgNDKEOOl92K2RaJ
	 Mm7L40P6rXgv7TQgg4sTQjdCeTeBZuEnnYh5+kzc9L9tZg+Q0r/jLOuG/maerxRtObw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930726;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=d7zSyNw6qz1m1x7CMIoGYOav8WM1/EyZq/PX2PCxZm8=;
	b=IgN+Htva7SgF4OXlkGvsWnvRZOlAIgTQ3NisnVmP8cNYmKbUUsTi0SsSxd4eBGQ58Oug
	 HNcn6hct61lybYlFxzWi8MFVaFPJRIOYFmM2D5kBwBGlm3cuksfZmFiAorIAeS63lmjWS
	 397VSHTMUDsqWjgWvVG57mjBaocXpuKCORC5/m87LTO3T1lwxvav8Z7HT1pIfq0bOFkHJ
	 Vke0EvPiq4R/EER7ys0dA39L7ufbrmsN6NJsW4PffIYvYe2kNxUUH6HQ4C8+zAmpENjcY
	 CqESMhE8CgsNONtJXBOGiaMTyK1rGZvh0+cnTXKEskp2jz7NjGRVzA08fZs1WAyGAfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OF3R7XS2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZupGZDs4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D33606A32A
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 15:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68D33606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OF3R7XS2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZupGZDs4
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQRIJ923737
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 15:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=d7zSyNw6qz1m1x7CMIoGYO
	av8WM1/EyZq/PX2PCxZm8=; b=OF3R7XS2UREI0oox314bHvrnPsSIkDr3bYdZ9D
	u78uE3IygWn9V+LjEhSZlC1ZQGDl2xt+QPF/b2jsO86p9IcZ7H+hPfHRBES/zvSm
	1aD1nurnfPUBGOBM9cZLefjAzqntSskvFsLrcnY6rnjw/fB+/eofg2cr1lz8EH6t
	GSJpMnlnQ9nIVQlOCQNbHHFPd3nInsN0a4OpV8KzGSjqWf5/sJdTFZZ/pY94WwM5
	FUUxbnh/ZesueNsr0cppHw6phJ9UsXuLI9GF1Lgrq1NZYKQduW4hfCNp7TUIygrj
	/gfROIOd4gCFcufw+SmZuVBVL2IyOg8za107u4prwew1Vg4w==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0qms0qx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 15:52:05 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-99062be02ddso805825241.3
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 07:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794930724; x=1795535524; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d7zSyNw6qz1m1x7CMIoGYOav8WM1/EyZq/PX2PCxZm8=;
        b=ZupGZDs4+1po9ZR0MwGvLYz2NmNY4OJocydg892eSBGHBu8U/j7VqvVIH92iYq6cfD
         NSGh6Nyi1jvDtltZoKLUfKKU1REi5nlCmAOzF4bXIRRgecOyB0jpM2VioXBrpd13U8Ox
         r1mkBZxn6j/0bNiv0qefKEoefpQy/WjbbewDrlTFoqnImU0B6rJHc3dYVCfNbdYh3Zcw
         i0D73Aqz78vfj+HFMUldCYX/pjwHNrkh9o+cINXoRC1hv0R0W7jsux4j4vvntTIM+T7/
         O6DlSzHo3CuVpYYshL/VJCR4Yd2Ih6jDVT081ATNwjEwB7+H3lkJta51tQjMSO+Jr42B
         NROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794930724; x=1795535524;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=d7zSyNw6qz1m1x7CMIoGYOav8WM1/EyZq/PX2PCxZm8=;
        b=v8LB5PiGMGeKzZakb8KfKL8buRyjz3I2DuyKjRT5qUU7FmWYe44QQs6w/4ObxlSjVB
         ptP1IYlj4AIBPr6LcwnuQebN5LQiZoHtP5l5MTaeR9esyKAGJ34rbWEJz9wYxMPjTrxU
         wxI2ofxhBTtGh5DHhy7eha06u4WeFVWgawVEOrCcDNyfLhuQJKxVaylYnc78C7Tae0Xw
         G+ymZYGq/ZMjhyGXTjMdxUVqRGBOIljva+PTQ77DusVyihNtq2zVRMO+k9YtIJ20vKWU
         zm7JCFjDn27soNYKW15CYC2a6+jGafF87Mvff0DElEe6T64XIyCr50RDJ0XaBfdgCeMy
         mA+Q==
X-Forwarded-Encrypted: i=1; AL+hErHPSuG07oHJRpLhNINga823mo74EE8ENvpSrKA0DFqj9T/f79ghkugCA354zLw+EoQq7DY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/u2yKFmETWxH/vAVMLCtvz69mmGFdYK7Bkhli3xgJ9f5lXYKO
	xJBdG2qA8tQGCIJDmo3m+iTwpU/qXYA+4RiY0E8gToW8QBkrfNaZr4zjviicRni08R7tu18meAY
	Uvbl1PdAmB9rYxpYkQM+53fkorT5VL5XjEMx9ObJGI7jsQcDQztUWtfg=
X-Gm-Gg: AYBFou3VTfMmfnjAhd/ERoiuL2eojsvSUjhXVIEQTtCT2/PEz+0KL5LPODWz0rJfs2V
	5DHm9uaOBCENKKuLomjxSGi+J2mzvlAUtjr78RHhoK7I5JYuuTPl4k61dmoXO2P4hdg0cqeEdkN
	ukh9P0mGoVv4FY0j2qBTOBKDlAWpDMagRUPaltK6dnRHVs8ClHCLFWliu4fiGeBcs88xtSjELcP
	MrvjpmJ5DxYLKl3FEl5jM5pOIATvOCEKfgnL9ifeazN0k9/7J0ZlA9DgnvRBlnVDL1T6ZXluZmx
	icg3NuNp74+pgf+ddJxdN2EiwPlMYd2kbLNChQNQhIpjd4ouyjmAJE3cocZTmavjohPSbJHAn+z
	OjTIHYG0XsYPSrw1EwE7aoVThqP6ZRif8VpxlH+35p0l7y5C1NxZozvAhssUE378=
X-Received: by 2002:a05:6102:6f07:b0:7d2:7827:c01 with SMTP id ada2fe7eead31-7d64d82be4emr3297220137.28.1794930724344;
        Tue, 17 Nov 2026 07:52:04 -0800 (PST)
X-Received: by 2002:a05:6102:6f07:b0:7d2:7827:c01 with SMTP id ada2fe7eead31-7d64d82be4emr3297198137.28.1794930723711;
        Tue, 17 Nov 2026 07:52:03 -0800 (PST)
Received: from localhost ([188.152.73.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7840b05bsm111211405e9.7.2026.11.17.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 07:52:02 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 16:51:53 +0100
Subject: [PATCH net] net: stmmac: fix num tx queues in
 stmmac_xdp_get_tx_queue()
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
Message-Id: <20261117-stmmac-fix-xdp_get_tx_queue-v1-1-4cd74ee7a76c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrB1wrFjwKkVCML92FkabRAmId
 29w+cHjXRQRFJGG6qKAU6NuvkDqiqav9QtYXTG1TduLyJtjWlc78ayZs9vNgmRSNr8DB7iBsy9
 xtu9kpnLYA0r33D/kkWi87z+oQ4kHcgAAAA==
X-Change-ID: 20261117-stmmac-fix-xdp_get_tx_queue-0eda31da641f
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfX03ziVYIa2P8C
 hmFlC5QFsBykotXQJmLRmIHL1PfiBpZaIVjkCSi6Lm/erE1A0DpdMhI3Js4hOZPRarUIV3JD6ii
 lhRQGREY7/66XELEzVQAKP1zwBA85WE=
X-Proofpoint-ORIG-GUID: 1lEH9aBUGMucwL_Qa7U8enMFfNjiNUKc
X-Proofpoint-GUID: 1lEH9aBUGMucwL_Qa7U8enMFfNjiNUKc
X-Authority-Analysis: v=2.4 cv=BIEmP1QG c=1 sm=1 tr=0 ts=6afc7825 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=EjEmtv2rKBG8bDbUgTQA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfX067oNjHAzaYt
 Sx1AUAJSrnPDVRmKVTaestsSjehsxjC6r9Eehp6rrqrsDwMqZC1hHauAvzlO2CCCU23CCxrqyRX
 9hr/K2Olnv8c4XHwL3Ig57Es1DXuscd2iY4s5gafpRfHw89LuZLFPIy9d7Q8KgDzB59mQidB+qO
 io9QKgLQaxSileT/oCNKZZxoTUlQibYdNrfi8wGtPzDa/kIGQKLKaBtr+82LmBHbFyPHGn+KqiY
 5WYqhwNyGaQTnPVnK1AyiHlLX8mYOW85tFEnUOAmUCsDjyketBTKM5mkm+f2OexRSfrw6DoaULI
 IXiMFSbDFaazUsrpShwxbZYouHKlflMxJKm0TbCYbBwQt9bdWfA18dimj4gqRfmVhA+Gi/WetBm
 iABn8e3HUqUqeIfGxsXs8vbaXHUtiJS/MB4HbJ4CkvpDc3b4bFjwaHkO7+iT7JQFukycwpeBlNJ
 6xNjS2gYc9h9KpS7iLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170063

The TX queue returned by stmmac_xdp_get_tx_queue() is passed to
netdev_get_tx_queue(), so it must be lower than dev->real_num_tx_queues.
Since mqprio offload can reduce real_num_tx_queues below
plat->tx_queues_to_use, wrapping the CPU index by plat->tx_queues_to_use
can select a TX queue that is not part of the real queue set when the
offload is active.

Use priv->xmit_qdisc.num_tx_queues instead, which is the value
stmmac_hw_setup() installs as real_num_tx_queues and is guaranteed to
never exceed plat->tx_queues_to_use.

Fixes: 195e4f409a40 ("net: stmmac: support fp parameter of tc-mqprio")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 25894771e9e9..cf87afd27343 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5408,13 +5408,14 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 static int stmmac_xdp_get_tx_queue(struct stmmac_priv *priv,
 				   int cpu)
 {
+	unsigned int num_tx_queues = priv->xmit_qdisc.num_tx_queues;
 	int index = cpu;
 
 	if (unlikely(index < 0))
 		index = 0;
 
-	while (index >= priv->plat->tx_queues_to_use)
-		index -= priv->plat->tx_queues_to_use;
+	while (index >= num_tx_queues)
+		index -= num_tx_queues;
 
 	return index;
 }

---
base-commit: 5e9b2ad9b8384cd3c417cd5e2c3bc7eee4a72791
change-id: 20261117-stmmac-fix-xdp_get_tx_queue-0eda31da641f

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

