Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795534672;
	b=RmPOReIHIBn5sH+Qj7JO1IjsVG2IqEUCsJYYU74U33SuM37Jay1sWXxfowwO15Q+xeim
	 5OM+EEkNt1KytBKfcmIU357KX1JNvWlX0r4AfyiC8LNCRDeQ9eOYBP5bCOZUSXW8Cxsp5
	 cfp90pRlAAmBiiwWE/G8EnriEj7EGU1T4iDnZZXok9Tt8MnNDWRgcfQFgSkxziKGQkoyg
	 xZ3NZZ/F9s1X56Pkp1Nb0nVtu5wCvxOkqNibP+0dMrNysiyt0BSB0vb8cN+8SNVIqZOuo
	 F4uhzvUjqjwYxe+ENPsazqGreZJE9diDXuuByl9VO8U+TH7aj3gzHuoTUXMvr4D0Pyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534672;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=S0cSKfeFrk6Di5GyedYC6hao8t19mvAwAOJ2ZBqmHdo=;
	b=N2FJdINPbRGtnLKUaquW9DCl2HZDZJUhzn/Ulb1eiz/4fU8HtGhw8M78bqKoe+QzY8zB
	 YSchRMl3oxPktEz5ng/kYHqM3/f/8cj8sRq20CJ8y+u2WylIQstLTCv/Nxl0cum1ROgC0
	 yUIIl4GU/YG5uns21ST6JHtu2tSzGXk0j2plFLJekJDCnAe6h0CCDWIr4MU6QR22J/6gG
	 KpoVVCh+lFy1CN0Q77ZB/pV96euZkqTW8Ml7uwqYTs0DehwErObHznSZ6Kv8X+86O4N05
	 HqvGjSkJyneZsoAO7le5s91FgwIYy7TfXXT43DH0B/L0XXR9znzndpyXOR7DrC8hAmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=vX4sgAWA;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=UIswaY4s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E80606A32A
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8E80606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=vX4sgAWA;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=UIswaY4s
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOCGrcF2668131
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-type:date:from:message-id:mime-version:subject:to;
	 s=default; bh=S0cSKfeFrk6Di5GyedYC6hao8t19mvAwAOJ2ZBqmHdo=; b=v
	X4sgAWAQ8maM3VOGzLp/SRTK8i68uK6kGsGpGHaPr/U2LMVpViXynxS0TVJ1uCm6
	qkn/dO+8QwN5Hxp7ZSQgUe7XDVlWIccMwSWTU8MNePm2T97XynZxqXQg9iZViBbP
	9MglxkfZg30hHHBlm95l0d3/WHEMO2skXCYkRpXn5mkNg2FU5f3bBFz1dOsjq1GZ
	b8kzdVTi12aPJ/tiCwCjOPdIMnbCeZMWGrOVWNCrFFqhxmLiZ7tiHewddeQgNFS9
	uR1MEcmG7HuovwfQBlzsaRahKhMlpRYdKfi2Vpp2/jbIEhiWxKtZyntoBSjRpYcQ
	RNXkOdiQLRV2A3+yakoUw==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4j4y612gc3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:37:44 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b2fb1f981fso60899427b3.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 07:37:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795534664; cv=none;
        d=google.com; s=arc-20260327;
        b=MLbDlymSNvIeauldp2FDN9rmJ0Q1eCLM5Tu+OFNySMMubyn/HYWDeqEaJc5i2iL7RJ
         wnxLZEARkw7SsHkoTvU+wTPGtg4UlSVxuscHt1oIGh42D8oVN6WaajnTV2JNrsAzefbp
         H1yW0zsdLmTJ7gESqfXI4TDd4abEELkcGkGyxS/rO8TvwAi9VbSO4IGxQVAmADBk6oCS
         j3XIngySpmsbF45SOuLlWgCGroW6CpqDG8+D1STEwSLz63qQV4VwrKet4i75KZWwVAPO
         GDNndyDJZ4QXtx5EANL0EGreobdSFfLLxVDt4W0WBfUdcdo3UWnOfoAwTeMG91dfnIV1
         KExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=S0cSKfeFrk6Di5GyedYC6hao8t19mvAwAOJ2ZBqmHdo=;
        fh=9cn4SVxdCyFkmDYZ5D1XFNcSUD3l2T0kWnC5TuFmpzg=;
        b=qmTKkZhHQNwMxCf7K97aKyp3tn3fSvDXQp04BxBC3uddDAQLk2R7eutg80H89AEujF
         6F1gW+2TxFAZVIm/KlIxNHBVf86RJIYp1F9mSm4Y4xNdU+Ge5/2ifPczdumNgWLbHf3s
         OkXykieMI06E9FwYydNQZWCCfoROnh5YXppw70PvRpUTBfmceGAn0r1OG9WOPYrecJP2
         wBAGIi+238NY1I3jomLuqN1QZWNcwOq2HBwIjDjd+6kzLwTi8jyGmGUgRkC8j1U+RWCE
         Z+3/Aq+lhSTuCvNhO+zujEXkTMwOeGMjlfrhowf3Gcof85BTilQZWQjVBI5cZ9NQeMdG
         Tktg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1795534664; x=1796139464; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S0cSKfeFrk6Di5GyedYC6hao8t19mvAwAOJ2ZBqmHdo=;
        b=UIswaY4sucEyf4NFVJN8vQuLduiUCoeNYjEcGnqbmIsff1BqCUnnDwdt16MAdfuUrO
         As/oyqn1Jb2cXpC6bnOGdql4OTlGIGyyC9/YpEMMMtsBXkXxrvPTkI/LT6Vb/sNncvki
         w3JR0qfdrtQ0y+9xyyt65Bn+MAq0dimFztjwDB65e6/MHIO4asHmD8mmuS3Uj1vP0FAb
         GxpAg7lhrka5+0Yg5mXaaHT95fpmw5T0xnOOpyA+Kd6DsuNAvjA8QN6x4W/9va3z29E3
         mp3PYK5sEuYSFiouKM6dXZE/7TWmXPFbp/+A5iw9HDTNAFRkjXAEVOQvsRcZ4pJ1POhP
         SVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534664; x=1796139464;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S0cSKfeFrk6Di5GyedYC6hao8t19mvAwAOJ2ZBqmHdo=;
        b=CZJ3+fU9u+qyIzJ6JWHVAdC+8q6nQk/S2PPE5Lxorsy8BTb5hgiwp38V5oTE4msIGw
         mqaPii4YujUw1z8aMWnM6A+HHIVmspq8p/xtCYDFnT6KGIjJTtNq5cBxYOZoNKl6A6lB
         IL9t1IEHxHQj63ByhAI/oi8Xu6pFBGSyV626dyUx7nZVZQqcyNLLjWECg2YZ+bjYw3+v
         BFuWj9uynYSMELTvpBS+ww2ZT2mo0U3gJL9LmTYZLgepJ94IFA/m80x8PBt7ANgA+ixb
         SvdS8N/G4nJEVw7X9Pkoaz5FKYgZu3ZBvf2YOlaiHwwuL/Ns0DCbVLzeuG1Dz5+rUW7J
         hIyA==
X-Gm-Message-State: APuU4Z/Z1m92YNisgOUt/bH+K6EBBgSEEsBoI3JbbF4M0UmZznbC0/Lo
	NhkYc4sdwlJ92YDuw3i/DQ8QkD7SJYBhtDiNfKjBv+ZbtoyalQLDAhx+bFXeJyvcTCibnV9WylM
	1OZwnzIpkEeydkQsgI+nANJ5cAzqjs8CGk6dBQKnTKo5F4fVjy6PnuA5AnGX7AgDGbX6UIBYBLw
	pQ/sRu3gCUBmuz7nWAF8FoEcnHWRGjKW5nUxKLr9I=
X-Gm-Gg: AZFdTZdx0vZDxc5splEGTN5o1lFdfi9qy2QznQGptqqQjr8bDpDUocko1GErhSifRxQ
	fKTflDtjwn/TRsd0B50bALN1ebvlNy/6hKsy+nQD5h+c9H7kID/iswtA0vZFXxCWdZZpRTmWFB+
	sFk8caPJSDzXCNCvfoYQwaokIcmldkRL9F717/yj8iwbP+i7ML/CXwvjl3wg==
X-Received: by 2002:a05:690c:6309:b0:8b4:d2fa:9cef with SMTP id 00721157ae682-8b52031c644mr52738027b3.1.1795534663673;
        Tue, 24 Nov 2026 07:37:43 -0800 (PST)
X-Received: by 2002:a05:690c:6309:b0:8b4:d2fa:9cef with SMTP id
 00721157ae682-8b52031c644mr52737827b3.1.1795534662661; Tue, 24 Nov 2026
 07:37:42 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Tue, 24 Nov 2026 10:37:30 -0500
X-Gm-Features: Aa3M54rBdCvGdjTj4wuaEQIZtqmHuBfDWk2SlA6adnqMrdlXcS8Aqn8TXTTG2aE
Message-ID: <CAOu3gNgXcryEHSjSxW7u5Nx-RBj9Bfn+h_YZv5fGvD+0arGvBQ@mail.gmail.com>
Subject: Reviving manual (lazy) BPF map creation discussion
To: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Slava Imameev <slava.imameev@crowdstrike.com>,
        Martin Kelly <martin.kelly@crowdstrike.com>,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2MSBTYWx0ZWRfX/q3uIFqxmM0c
 uXu1JRFvSutKIecMta3wJla4YD4+2loBjPrdkdypLTm2KOd6VADQ+wulJF1q2G2Ps08AwZhCr6O
 0Ok4pH02bLAy9PgmpfTACvdA3wSxGnIGaj2wOMi7z+0P9BiquLL0
X-Proofpoint-ORIG-GUID: PIb5T-UuVN_C921i74Y8sEfFBRVcCOOL
X-Authority-Analysis: v=2.4 cv=fqdJ914f c=1 sm=1 tr=0 ts=6b05af48 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8
 a=XnTfsmRtFRLitxZ6w2cA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-GUID: PIb5T-UuVN_C921i74Y8sEfFBRVcCOOL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2MSBTYWx0ZWRfX+G76luzoAzfj
 eQ3gwvE02DbStUrwKhfUynXiUmfoxVAMa2Vnei0n3Ll+G2SoPiFv2yQTbpAa21Erm3sZScy3Om+
 hGlXHUCT5U3f0eBRCcMJfDowrClQMbcfxRGTl1Lf21A97F64KKea60QlTJW8R1pgKlyrI1D2Qs5
 H15IpPBgl0YsyJfa98mSeuUKstLHTxet/reomqEgFtXfz7ZFKh9ImIQmqLplNeYQHkgkw8eIyhM
 l9E0pmKrOTDeeeLjMiI4Y4089XWt+5OaNZ6RK2bBE33MDVGMDG5+cDOsTG2dWr+A/87wr5yn9CA
 J5KIl2jsZxrjA2qe+VITCGTmJt9G+eEA37qROPvym0WoNh/1vzaZtrJCkROmGIfCym5+EqEs6WI
 2wa5zlNGNLJ6ij1IuEXCEJTJ+SWu1KYPpbhbz5rhWGPIYP+OWzZOKE84prd6j0Oe0zxhfOGu60C
 xDW0HfyFzSkheLd544A==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11976
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240061

Hello.

Now that manual loading of BPF programs has been merged [2], we would
like to revive the discussion about doing the same for BPF maps, and to
ask whether this could also be a topic for LSF/MM/BPF 2027
[3].

Where we left off
-----------------

In January 2025 we posted an RFC [1] that let libbpf load and attach
selected programs after the bpf_object is loaded. The discussion also
touched on applying the same approach to BPF maps, and a number of
objections were raised on both the program and the map side.

The program side was reworked over the following year to address those
objections, into a per-program load strategy (DISABLED/AUTO/MANUAL), a
SEC("!...") declarative form, and a veristat conversion, and was merged
[2]. The map side is what we would like to discuss further.

The problem
-----------

Today bpf_object__prepare() creates every map of the object. A
MANUAL/DISABLED program that is not yet or never loaded on a given system
therefore still has its maps allocated in the kernel. For a large
modular object this is a lot of wasted kernel memory, and in a
memory-constrained environment it can even needlessly prevent the
object from loading.

Real-world use
--------------

We have been working on this internally since the 2025 discussion, and
have been running it in production in our internal libbpf fork. Our
endpoint protection agent ships one large BPF object whose programs
depend on optional features, so the set of programs to load is decided
at run time. Manual program loading already reduced the number of
loaded programs and hence the total load time.

Creating maps lazily, only when a program that uses them is loaded, is
what allowed us to run the agent on customer systems with very tight
memory limits, such as containers, where kernel memory spent on unused
maps was a real cost. For one customer configuration, we see a 12%
reduction in kernel memory used by our agent on that system. We think
the same use case would apply to other memory-constrained environments,
such as embedded systems.

What we are working on now
--------------------------

We are reworking the fork implementation to address some of the points
raised during that original discussion:

  - libbpf never unloads or re-creates a map. Once created, a map lives
    until bpf_object__close(), and the kernel's refcounting does the
    rest.

  - It follows the staged preparation suggested in that discussion:
    parse the ELF and relocate, then create maps, then load programs.
    For a MANUAL map, map creation becomes a deferred step coupled to
    the manual program loading that references it. After the ELF is
    parsed and relocated, nothing is created in the kernel for it, and
    the map is created only when a program that uses it is loaded. For
    AUTO and DISABLED maps the behavior stays unchanged from the
    current one.

  - The choice is per map, a three-state setting (DISABLED, AUTO,
    MANUAL) mirroring the per-program load strategy, with the default
    unchanged: maps are created at load, as today.

We would like to post the libbpf series for more detailed discussion and
to get feedback on the actual code.

LSF/MM/BPF
----------

We would also like to know whether this could be a good topic for the
BPF track at LSF/MM/BPF 2027. Invitation requests are due January 27,
2027 [3]. If it is a good candidate, we will send the formal
[LSF/MM/BPF TOPIC] proposal to lsf-pc, with the topics we would like to
discuss being:

  - A recap of manual program loading and its application in real use
    cases.
  - Our work on lazy map creation, and receiving feedback on it.
  - Whether memory savings of this kind matter to other libbpf users.

Thanks!

[1] https://lore.kernel.org/bpf/20250122215206.59859-1-slava.imameev@crowdstrike.com/
[2] https://lore.kernel.org/bpf/20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com/
[3] https://lore.kernel.org/bpf/20261119-lsfmm-2027-cfp-b7edcf7eee48@brauner/
