Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794421450;
	b=p1BucU3RehrAhyrNV4KlSSsCSXvckRdph+8nN5Vcnh/l3DHy2FnFRaBRhdthILnaHkkw
	 2BgiPofhI2+lQp0vD4cw7KV5hQvojLw94eMXWLxzhj6h05C65+m+QBxjf2HyHSoOerabH
	 Mdgcrg9cSkRyulhF8sRn9cEmESqQjbT8CHaLVFFYh6oCKRBbqFz70/QRsCPC0pAZVqvqb
	 iMBs6JzOKSkZXRfaPTTBLEzVgXPR/Nv6OlbYY0c8XTyWLeTkb+3xQm79ml7PBYdUQ5WfX
	 CCYwj+l56KB/j9hubwKXT78T8JzEiNj6gGSkNFQOU9lwlrCjIS0Y3yDq1jKkVr9BWhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421450;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=aMG9NSIoryJ6ZmHzBOTcIKDBni97i5hfecL1FAmnbM4=;
	b=4l24Fwb9/MlAZ3D2Rza01GJvU/JlD8KD9b/ygveQMLRG0RC6e7bROJ5qCLOw8zK3luzk
	 L9cP1PXBFULmneGA+/tUUSjfRw43+4Ycfwryg1+9TOm2X5C3SB02uCa/YcYhFHwjRWBId
	 NPyhlE/166PecQvIjOsZDxmQOpALOJBmdCARafiidWIf1s9wLimqErlqM+EKSmqjONJEz
	 wbA0qfHXlxcoy1n2TV7vSorHdrQkKv6mh55jToUbZHtxcNQqfWL1AEf/5aZCV+CM26dfv
	 w7U4ISy+mghc6gLkDR1Po1umTrf3UPbf5HmwHDmh2BRklg2MNVOZfQ0Qz35YprIGNsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=isns6Mqh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE3606A33F
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 18:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9BE3606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=isns6Mqh
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABHsv224159987
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 10:24:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=aMG9NSIoryJ
	6ZmHzBOTcIKDBni97i5hfecL1FAmnbM4=; b=isns6MqhLK2gICBmvsfmHDefPrM
	fcse+kjR+dgFtXbRypDtqotW1Yl02H8zLF60ugJCdMKKjv2bgp3/FfDVbtAj0qPL
	nMdiMIQxDW/X1fu1xFPQrqO7h+9kKGnsak6+fIA8XRHkd2ZnZxPL61j+PZEgibEy
	nBb5hifSwAd17cHCObGIGWr6WQCyzXxmQufY6UHIk7KcX4LXVPfTsiACYBolCFv2
	uZsIapcgbM6aipiYch9uLbCT+xrDb7WMyVR20uj/cvl1DYR6dMROu6AKFq/+SWeu
	7vwmmqM2W1TLALIA4l+/gOuarfulif/2FeT4KQUkwmvzHlyXdH6HmkOe6Mg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hvbxcegve-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 10:24:08 -0800 (PST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b0a13ae043so4038782a91.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 10:24:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794421448; cv=none;
        d=google.com; s=arc-20260327;
        b=S1uxVWQ0LVDpBOkx0qDVluOGGTjcNWxQQiTUg+aT7MbciRCZFmLCW4xP30YqE3mwYh
         zXjmy5CLCa9OOo366ZimPGyoeF2WBsJtssHX/nz6/u34MCDhRXwScl5hkUvC5QhAGmoL
         ZjveNzC7HKu1Jq4SlM/9z50Dec8tZbqYOqG8Qw44vf7D1Ex5nwhzHH2v7DSk420I71fW
         z+DPXVAa6+HLUq2q68OqBMU10tFPdIsMJxjOnMoPt5VYKbqbEs/B1wZZk0p6HEYIx+UC
         xJIvYmPdFWhwKrkYkSPhrFdg7rD1waoqnj05bdk7Axrw+ifv39O3hTP0mcdrfFI4UtvR
         dWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=aMG9NSIoryJ6ZmHzBOTcIKDBni97i5hfecL1FAmnbM4=;
        fh=Hhsw0kFgmWomfELrRLSKdKBJlZ0yTl/7XqSj598HBKU=;
        b=EF71n12DPTFkEJQEKx5BwoZt7usUzEUwK/yGgrbDI8w5dsfO0cwkrpE9ZS4Jl03QO3
         5Vi4N6qnJOVV493An9pNgP+kcbcEZHCB8aN+dVtdtnqMc5FDqNuuQVQkXymGT53N+unh
         k6jqoIjqZQwNZF9zq8LwWO2ZwyZvR1b//g7LXKi3EnxMu+VqHXTQPNo41l1i/1ms1Yx1
         s8G+4sMFdWJyLPc7f3o6R6NmXdlvTU7EVQI3Kl/FFPwX+jVLY6azvp0F2BsUwPIAKjJb
         FM0/PGzPjWHwS7daWiw3IiohovOWfByLWsaJmojRLoULRpfup+tIJHCi7dZN/Gjdyj40
         e/WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794421448; x=1795026248;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aMG9NSIoryJ6ZmHzBOTcIKDBni97i5hfecL1FAmnbM4=;
        b=vizSI3dKM9eR6vQ0xhXVIn02wI/2GYJeC5o0ssOb9N1ZT//TJlpSJeyzksT350Uife
         7Xdb5bF8pWmrPGQDYWAkKzgN3i7j4FTyDVyj9BCoGoocJ5Cj84+4pHaGv9euyqYIGPgV
         20YBQmppcHSvKALe2k8xC8VFrHgPVIRqZDFMIjat/tpve1yWD616BamO1wNnnzPcsIMw
         aG8sg0kOxdg7CJb8POmLB1P5Aa5sr6uMqL7M3cj3qgf8y8rQkSBHpoiygjVcSN535Vrp
         Sh62lBZ/1cI0eUwQQ17mzPulK/+776AZZ0GVcLPyv13rd3hk8yao+5gxxYlo8kjhe5y7
         qgMg==
X-Forwarded-Encrypted: i=1; AL+hErFn+zV38czbcY8uWfmG3SaOd6RzPN/VPNC2zfbRqoIlFyjnu9EX0AofCOmcy+0lY2YkRes=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ftvsgD8iWEPEPNfZwacj2xQPCz7kQ7vMz4/8LTVOH0HQxibiC
	GH1RNxwn2QOoiFcX18+HHDaYmV7zn3Qwle3EGuiCTCDnFVlaGcLyaEzjMQgwpEDUHZtq0e0kTvu
	+R8kE18NhULabAx3/3NpN3Ppe560+V6OceKpLxhsJ5D/nvW1Ncrf9UsKogaGaiohNItDMgbEqrV
	COMp+k0wk8D4VFgv+3dXsOldAkH7U=
X-Gm-Gg: AYBFou3R2yYjoN7592ksBeqAejcKl5ohoMMV/Nk0K/exgNPn/1ipk4ZxIiuu6W1vFox
	04kSvxgEHr+gViMnWTYFPdxNZ6TqMuI2iTwarcj9yIj53Rb39+QUJtTv6JL7USCrtCGYFQK975G
	fh44UTfXbV4AY/z8+x/ZsO0qCurloCV6wcw5fKnOxQXlivE9PZKaC3/jalnLc3BqwmVF52VdjGq
	gw8ZJcxngGPxK42y9RQrbuL5Qy5k3+W
X-Received: by 2002:a17:90b:2f83:b0:3ab:884b:65a8 with SMTP id 98e67ed59e1d1-3b182eda7efmr3257442a91.26.1794421447581;
        Wed, 11 Nov 2026 10:24:07 -0800 (PST)
X-Received: by 2002:a17:90b:2f83:b0:3ab:884b:65a8 with SMTP id
 98e67ed59e1d1-3b182eda7efmr3257421a91.26.1794421447127; Wed, 11 Nov 2026
 10:24:07 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-1-toddfreed@meta.com> <20261111005533.6436-5-toddfreed@meta.com>
 <DMSJB8MZZCXK.MCEBRZQDAM5Q@gmail.com>
In-Reply-To: <DMSJB8MZZCXK.MCEBRZQDAM5Q@gmail.com>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Wed, 11 Nov 2026 10:23:56 -0800
X-Gm-Features: AclHuK8_olqmA7fXTYgEAj2-H4kgkwQj_X0uL-xyG8nZrZvhci79BGaB7ila0uo
Message-ID: <CADh2yMx8MPjcH7Bpj72rNNd_tT=6uSC5Ow9JyGjTMjFgs499Pw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 04/15] psp: add support for socket-less psp associations
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Donald Hunter <donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        John Fastabend <john.fastabend@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
        Wei Wang <weiwan@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MyBTYWx0ZWRfX5ErFMr5BSaqg
 ZGRmokaN7o74VY8IfoilSerwaHFQueF3OjPCuFZ4EJOzs7uf1m6Og9IRVZYwICMwosFjg0iQOLZ
 20TWLHu/ARl0aSJfVFn0VMQmNWETo8yH+Lhtbvihfq185i4iv1idP7EMOWebp94kmjH/r4GQwnv
 VAROsxwrkS+rKWG9aaw9Lg6W07hXYoyjP+UxVjNYz7OdrX1hEuzDzuLnrgRxBDmE81JKq/FgLgD
 Aoh7nrmD6MTiEZMLanES0wn3A8co72NpWMTy1WsOjns19yCkVh79/Fff/93iF4Pl1gaLPaVY7PG
 EIFYdsZX8rrhwCVvCOdFvpeeRSuwKJR73qoX1Vkb/kQDZcCy1Gp4+PIO16F0PRolUXjKdCo4rF2
 vyTzZkgGIA8Hs1cKmad7nX/mBASndvShp1OwKLsqJDfLFQhxYoKJtkL9ot7mHSqqj2DQCbw2a35
 OPbkVJxMIu2E+AW7iyg==
X-Proofpoint-ORIG-GUID: urJ6YrK36NpFOIhq-rpsmBC7G7nPXoC4
X-Proofpoint-GUID: urJ6YrK36NpFOIhq-rpsmBC7G7nPXoC4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MyBTYWx0ZWRfX84u9Ap0jyiyd
 GjeS6K65oEjkIMyHcrOmprM6i3ItvEwpebZuOGcrxYxly/aAiWu1knfz3/6c2pOpMwwOE8gg3OA
 dNysk7AfqKsPahvaeUlXvnzoB5IJisk=
X-Authority-Analysis: v=2.4 cv=ZdKIpcVA c=1 sm=1 tr=0 ts=6af4b2c8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=-xR6GoDS8vL2zpuMsZwA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_03,2025-10-01_01

> I'm not sure the kernel actually needs any bookkeeping at all for these
> generic rx spi allocations. You could probably just pass the spi, dev
> id, key, and probably rotation count (as a device key generation of
> sorts) to the user without creating a kernel object. For socket
> psp_assocs, the rx state is consulted on the datapath before queueing to
> the socket. For tx state in all psp_assocs, there is the possibility
> that an SADB handle needs to be cleaned up. Neither of those apply here
> or in the rest of the series as I understand it.
>
> I figure the tc ingress rule can just take the spi and dev id by value
> rather than needing a reference to an object that we create here.

That is how it works in this series. The tc psp decap rule (ingress) does not
make reference to an rx assoc ; instead, it should have flower matches on
psp_spi, psp_ver, and psp_dev. That effectively ties it to packets from just
one rx assoc.

So why keep track of rx assoc objects at all? Two considerations.

1/ don't accept packets that correspond to a stale association. That is, even
if the device decrypted the packet, it should be dropped if the device key
which minted the assoc's SPI is two rotations behind. For psp socket offload
that is enforced in __psp_sk_rx_policy_check() with the pas->generation
check.

The spec permits SPIs to be reused immediately after two rotations. So the
device could decrypt a packet with a SPI that is more than two rotations old
in that case, or if a previous packet is being replayed, for example.

2/ hardware offload. the solution to #1 should be able to be fully offloaded
to the device. psp tunnel mode will be hw offload only, and is implemented
in the eswitch with connect-x.

We could add a psp_gen flower match to replicate the pas->generation
check, but the device has no access to the pas and can't offload that.

Keeping track of the rx assoc means that the kernel can take action on the
"this assoc is now stale" event. Possibly by enumerating the tc rules and
either deleting them, or marking them stale for userspace to reap.

-Todd
