Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794433789;
	b=nXBL0we+ZZcWu+gk2Pp65+cgyiLlqNDqD+u20Xfpc5dQQeT525Oqk+1fMBFmDYhD31rJ
	 QHSJz2KRmrk2EnBa7FFQkoR//r7SYWROFgv3NXvf6XVtu4miY+xzHmVf98tRImTARaCtY
	 fsYiUQ/LQNMFc75LHxTbt3tkkW8ecHh3exrIIJFhsHwv4Lxk174jcCceReDq6NeAvwPLV
	 vxXk1ubnN+LxobdTrHOAWpuoJtLQaYwfi6RqBc6ZUiXKgvRL+i6XsHf9hOuV4n8gO4B9e
	 m2w3GAdyaBZJcz5Rn6G+4Z5YQN6b1Jxioatbw/dSyULbuyFsbFX2B3ZioP0lN6HM5wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433789;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=5hjKfboVBJ7OBGDq8Y9w5OdAYwdgZTN1RE/HZ7spSHE=;
	b=sUb84lNNz0SCspATUzLF4ZTNg4EhikylEEP+Y9Q6HM7URBkIA8+LufcM0FjIb4O6f7Je
	 YNDikbemw8JZ8j445WHBwgT/SRl0cW6KQafcyPVKfrf46KvI+DyFY9cJZFTjVxRiNj0gk
	 ZSNYlNuyIUV0k0pFsrtmjVWH0yq4XnMAlheKc1zYJ7rXUgpuGyjfGfu1zlNVQVdDrkrmf
	 n2tJUEThCvO9wykFKlZit4Sn/I7pfU7F9ACwmC8VTFJiohcuzqyFODZJP8L/49rxlFBxG
	 BQXFBSVB5DZabkBHX+f02yL+nFSCF9n0cYxAEk4hApzDiZhevyXnUn3DL1ACd1S7kMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=GeyeUFFi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18EA606A335
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 21:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C18EA606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=GeyeUFFi
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABKjx5i285423
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 13:49:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=5hjKfboVBJ7
	OBGDq8Y9w5OdAYwdgZTN1RE/HZ7spSHE=; b=GeyeUFFiqCEKPkYZuQ6WCtcJ+ir
	veBlhkSCp2XR6ZvVC1Xnkgk73qpCo4mRZiSx00pz0ZaPhEttkWlhUPmxfs40TTQ5
	/X8zBYWeMo5qo2ppLp4+UZMJyHFMoiEX2DHlDDezkJ+ymYQXutBVAG3oQhntG9hM
	ZVeerH9U4yDTyfZo8k5T3RGORiWlI7Sy4seS228sgPILhH6xhQjGBjjWZwg6qsn8
	Vlh4ScYyoi1E4wMGavc4pJXl7aCS2fuFIr3busZsxl7CXn30LOVds332fP4+nkTl
	nDWVNpN6J2Xxb3bHvFuoJ6S2atc4WxsC5TivihwZ04AgSP+XyPVs1XTkmTQ==
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hvagw0rtc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 13:49:47 -0800 (PST)
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-490c1867460so2700663f8f.2
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 13:49:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794433786; cv=none;
        d=google.com; s=arc-20260327;
        b=QN14vqu2k3xV/Axhu5UJDRgVQg1wInlLjqRy8EfSog9EWPgqoBQSZ2lQ9WmiT3d3GX
         X7w8K6SECAKEDd7HuPYxm5T0RLB/U+aws+9g7bbDMpRW21xYG5IaUiOnzYm7Xq83MDZB
         ytsD8fSP0kKFKHRBRX4dyj/CGX/zctQM2uUVusQtzkPIgC3v1VkO0rc/BMJ0UBmiDtWU
         PQ6EXyJTDvv/91ES0nZqIEj534dyobd0tyx+fag+IC3JnuzFhrwiY2wtofwNSwoKl8RQ
         Wroly/C6b6EhDYR6SyAFXV0J9ysyunRvRnQu11gMdQSkxChoZSKSD/MAh7YiSvpdKrl8
         17Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=5hjKfboVBJ7OBGDq8Y9w5OdAYwdgZTN1RE/HZ7spSHE=;
        fh=C4s7NaN+TQYdcK1q5+1ZVCUxAn7MekAD6d6SVbuEWWI=;
        b=XsXxzf3SEI9iyl3VxwMz0VWNdE1YDnNpPJU824vMeKu0DnYb2J2/xS4cJdVYLvYMTY
         z1ynW/D3ki++CXmHC1ocqI0v30DXVBRKZmmOU8/vRxSoUMEjwA5mWWc7+P8GdjPoUPHA
         OLWXmTryQ2VRpKJ5cVjs0mAxQYIfCzbVxlJ6YxxmCFLFJfctdB12l+bXnSPAkM//9+kU
         nj0Sb2Ns21SI9PkiKW2t0qKKxJcjLMihmamnkR4frsrhwBRP6SM5B7W8QBd3WwxjNcpn
         NmofDiLq6TgTOY99Q68jsKD06vihYS1BfLxBVWyNa9+eMbCvQT1tVZzwm0jx90QVmMbT
         4djg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794433786; x=1795038586;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5hjKfboVBJ7OBGDq8Y9w5OdAYwdgZTN1RE/HZ7spSHE=;
        b=RmjHEROXsysfOaWL4xGW17miLYObDZDIT/WRvEDpdC+OWHMdiOU0yLvzExMNUs7crB
         fsoIZxCqk9FC6TA8EJqbDAfjEKctQkQm8LdwMtkcf/7iPs1PBli9Ue04L0yZAezuzSEd
         nCB1UCvNR16ABgyxzzWBjE6Je5aJilKFLtU3/JlO6X8i2Y/PzUUYrcFwJwx84EkZFPfv
         HptWrNH8kv/+xihn/O2zEFpQxaDKwWIA2s6b3KROkVINQbSbkdn6CnMvFys/t2lLpaAZ
         O4oV1hffhTP0HkPQNpdCpvPXPvTDluShgaiGquHIIha2OpKyp7oJpKeN/5KYNk6Vofha
         +ceQ==
X-Forwarded-Encrypted: i=1; AL+hErGzZJHo5fYN50+tv6UuNLpxNBcqe7cI9EgZ3YJS9m/G/sxtUKb3lqDxmwoVll0xI6VNgJY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+InHtU/dHrrRDA/K1haA5WqlnobZVR7LPYbLIpoK1M1n7eEDtE
	p7F0wYIPo4SH4476bPfLl0nwviEn27vT+awaFG5wb9e5sjmy3rrX2MRIK/fCilFzubia3B2IEbt
	gXeQf89CktM7qs1y5FKFgqamocmKUFxdbEb4bAd6s16f6aFQSnbV2gbRSrExdvsAJWvG8SxOlk3
	Q+c7yrvfuIBJ7lsiRLHZKJz+NK5Ns=
X-Gm-Gg: AYBFou0t5ioE7pTPai1B/QbpRZPSxw6n/ZtTyMCQRFimFS/t+3GXYbI6urnGAx9PNcI
	qzeuM3ii/WOHfdMfliw3NXCOAMfmzgW3x05oy4sXOila0iXBlEAiZfdAeWWlTaMdP4PB5NqwtCB
	7aAZsS6as/jvikFT8qLoHUrjNKj4OP2IXZV4RKMkVUzSNGGwTvW+JEpfnhAyqEOyMDRf41M1dmn
	/twgkBKXImwnOm+iYJO7IXkSYuw6Ood
X-Received: by 2002:a05:600c:34c7:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4ba093583eemr60183805e9.9.1794433786503;
        Wed, 11 Nov 2026 13:49:46 -0800 (PST)
X-Received: by 2002:a05:600c:34c7:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4ba093583eemr60183425e9.9.1794433786168; Wed, 11 Nov 2026
 13:49:46 -0800 (PST)
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
 <DMSJB8MZZCXK.MCEBRZQDAM5Q@gmail.com> <CADh2yMx8MPjcH7Bpj72rNNd_tT=6uSC5Ow9JyGjTMjFgs499Pw@mail.gmail.com>
 <DMSM3RNRY412.1GXB07F4KGJYR@gmail.com>
In-Reply-To: <DMSM3RNRY412.1GXB07F4KGJYR@gmail.com>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Wed, 11 Nov 2026 13:49:33 -0800
X-Gm-Features: AclHuK_3wPHrs7nAKCIlAv8DB3IRwLLgS4civoUiRATHWDoZevdks1911kjhq28
Message-ID: <CADh2yMwFu5Gyadm2Y-NHCBtayEvN5H9LUM=Kf-tT69vmjm0DEw@mail.gmail.com>
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
X-Authority-Analysis: v=2.4 cv=a5ClZkSF c=1 sm=1 tr=0 ts=6af4e2fb cx=c_pps
 a=CsXZvLRfiTx/ye2xXAwb9g==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=VU9VbmEmTQsFja8ue1gA:9 a=QEXdDO2ut3YA:10 a=F7q00xkr9EfWfQvbdVXI:22
X-Proofpoint-ORIG-GUID: Ll2SLnFNYFNOG8YXaB9ffMNjl51qc-fo
X-Proofpoint-GUID: Ll2SLnFNYFNOG8YXaB9ffMNjl51qc-fo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA4NiBTYWx0ZWRfXyH97OTpE+iR8
 0EIEAyfzUJ2Z9kKhR95hcoLUu1+1vvcp7eLb6GAP8dnJUWSx63CwsYq4clLxN+KtzyJnV1aCi1G
 8qIOnC6fYaPb9lT9vgKOAutgIMRTGQGWMKWeP2OCVmQY4Scinrp9rr2kxVEdMXDAJpMeiwYIr2P
 84VQVS3UTl9RED6M/lcPCDMGeqWh2OyWODivJ3d3xPEYs9dv9mZQSbTlQasY4sKQpXnoKEbA/wY
 J+TgIp+EpdaFEO1qjKj9uAiAxD6fAnFToysL1lPVlWd2WMi2viH7Rp0xCe6tRlu2WnVaPhvNWAY
 wrZbIFq65nvM3aMa3EcvBNb4aLSx7ufBtX5YaA8hn08+NMrlh6N6C051kgFLQ+hpsBoYb8H8VVt
 cwMx6c1pNOfZ4HNT+RRbDgB9BrYZFIyoUJEl9y6scb/tx1beePH/0kR7ljUpdHW4lRS8zwa1nQ4
 kNNt0XVoL8EH72F4Ykg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA4NiBTYWx0ZWRfXxpc/eKM9yMwE
 bfw5hP/dFqZyMHHhGhXqcBBUphbJC+aQyrpoyghfIoHEHewTVjnr1z9MV/CIngPc9RWb0/Q+LxM
 6K62k/q/i3FJAFGLKX2+OmAkuSebM50=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01

> I think it makes more sense for userspace to just get rid of the rules
> before rotating the keys.

Ok. I will drop the rx assoc objects. The robust userspace protocol will
be some combination of using cookies for state recovery from a rule
dump, and using chains to flush old-generation rules at once.

-Todd
