Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605451;
	b=Byect/4UdJH5M3DjqPcGwydFdhrSufXYeJzRZ6ivuoE8K9HwE+WVxciUNSerZkMcMa4u
	 fXzi8jfKZ6KVf1m6OyaRksc4UaShx3i2gH6gAec8yvbkMMppkkIrmLcitaBS/AVsj94Nf
	 XroJr4FaPYcGmcc4x7zUept3GtvGprOH5gdW5AU6VtPPvDDj8x0xH0YrCDxn8OyvQxcBR
	 /F0/b6g2QQLUGJ7h+VRlMI+j+sbZba5VChp0L2Yl4vIBYFTC8efuPZHOu5IrJRp3obq04
	 puspYzxkFlrJsXP4pyTmYMfd1m648Eb0xALypPN9pmJ1EmeJe03oQ13z9o3Ivzti7bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605451;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=QSq2zUSBAe25DJ1CQ4JwTljk83h0fiOl1nj+uTNbBIU=;
	b=n7UtLILAAMJYaCJBwFjrfYDlcmAXQz24oRsig+63jz5Agc/TWU5+O3pARPI/Hfa/L2Wt
	 uxzcLgWiatiUFEYpjkmqNfM0ReUul3YmFZfGxxHBtfKiuRGlH/R2erRwzLIkKrC0LyqKu
	 PBYNazijQbRmrS5ZrDkQXnyrSaerN+eIibwHG1MsQ7jJ4k4KPIjaYXL8zbUs6ve0x3iJj
	 WiL0kyz1Ii+ZJM7CwpHwutSIpL+njTFeyuT8vVUkp5R//aOmN7dKd8pufPEq1wWIULxqs
	 r3b7LKFdEV/kDpsqG5X4Bx6ufzdhUprE8ttMf097LKWCk24UyGwT8X6a5YIb2QNCYCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=SzB4Apdm;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VyzJzC0A;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C88606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60C88606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=SzB4Apdm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VyzJzC0A
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 575331400104
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 02:44:10 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 02 Nov 2026 02:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793605447;
	 x=1793691847; bh=QSq2zUSBAe25DJ1CQ4JwTljk83h0fiOl1nj+uTNbBIU=; b=
	SzB4ApdmBMVQWllNlx9JKhvvHVXEfhUIw4KlgUtBRmIKcrdt19Oytd7Lgje4sWQK
	5YjRcT2SQ8zucciWXF2L6iIa2dHbqyAM66EJIJMUgl2bhssJOdQrlRm/T9ltYJV5
	SeOfs4wvCYkziIVd54uI5ayOkGKXYQaFp709329E4tk4jn9IPQ/cHLWEwOL+VTnZ
	jflBwfpd+x+Uos3R7CBhWMs6K7zjP8DNGlSdIVHT8uDkNwVt0XfSUXN5i2U45WFL
	VnmjGKI8uBjfsmKzJQLx7aO7h26mOLTQeMshGwXyQ0LyhN2Hkjfq9pTnuDJjlxqn
	qM8rDf17DMba0kKUZ3VvoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793605447; x=
	1793691847; bh=QSq2zUSBAe25DJ1CQ4JwTljk83h0fiOl1nj+uTNbBIU=; b=V
	yzJzC0ANGJAQWvVPZuFLG7q4yX9lXW9Y86jz1idVjys8mOeu9HueTrX6TBmVLE+/
	IK6DOK5kKsHwCaMtAJmVoCXLH+HfaA6E0pqFtlh1nV2azY1x/gXuGu6R+f7Wdufc
	Ci5kxbFK+8DhepcQtRkmTkiU1WwK+UDFEHUHIY15sDnMp1423JFS1pErYDpm2q8p
	oGv1fIW5dlx0LTIPTkMe2hv6uFvo1I0phJU70ZW39PoMcqFG1CGf9dB6FdCIMseE
	/BSsrLBNoV+pS4QQgq1YcGjFNU7dqAlyfVqM+9p3tXJGT9ovehwYhwLFxrZKPNtR
	S9QoxNYtL7eGD6yfw2TJg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793605447; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+; rt=PGJwZkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:TM+k/7wnajWrdL+ucZVGgbne0H0qTQlH2h7G4KYhtSOUDtN
	JQFEYZMCJdkWhHWQNFpk7IpxXE7oBRSV1OYuodC+VQ2mzDLCs2tjilwnmqWGIamY
	uUEP/zlzo94jtPp2jWS9a9voz27FzwO5AlLDScCyE4XrMN0MjycyWMA8SMqK1h4j
	AjkZwd9lFdEAQQUy3Zh1A7XEnZfRHUHxdrJGWJhF0mB7MOid1utBYX8cM336rw3G
	gxT/3+szb3jdcZ+zB9MVynN+xMMaK5sIfqKg5X8WgpMfdSiy+JmLhxKqnUuU7qzJ
	Xc8fkksSKbhFhZv6NBCHjSMMC9O2Dny8Hxbvi+Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:dmIzeiTs0DqkuSLEQEyoJjgXQ2WYfZ01bAint03Xmyc=:KShiaSrgYzK8/huxNXaRRR1g1oaXj+tTHFTN16oa/3I=;
X-ME-Sender: <xms:Qz_oanXCJ5Dgyw3csXJ4DbVTbK8Shcbvx-dKy8epw8BEyZKl255ZYA>
    <xme:Qz_oaqa9Da_mpeofh-eBg75Cq_j58cklgkL_ajkjU-v0nuzHOtkj6pg5AQrZlYmY_
    57gWnk4fjx_yPaDpZK4Cs-WCmYMu1aDAC_1omkXN9-sfFDLEpY3umwX2Q>
X-ME-Proxy-Cause: dmFkZTGw+bxoxxv+lsou7CmeY8askFOJekejYVyepG+81y0oeesf9IrEYZrlDsfhG67gpE
    WHPduLzP+U0hlC86mM7gKaTBPVorPs2iVVudMrCvWmvesYIeASPs5IdIU0WuU2gUddCPHx
    i9I8ujWWJDG2uKnPlfS9OORUKmYmcgze2KbmvZnYqyPLuo6h+igC3LbdRPnzYDujPYswPI
    c4c2+jYXSerz7J/ihlGrET0zFvc9HC9/ZFTXP462Uu0AkeRm0V5BilbHJKPKXONd3OZ7KL
    wuI0t4RHXFd9Lslj+aPa0/cr9Ii8pFeHtPhP3kYfgBbw/rdWYi2hdX5CToNP2pLzd8vGU6
    j9gO+AjdIAGdgaAwfbl4vzSMqzSv1lyUSIKlYEpwbUVi9aUTfN2bv+WQcswKo0Unr9Jcxi
    oqzQ4ZVX5EW1M+1+r/nMNeytcgqUyrvkNWrhr0mXiRv2EqPB7UVW6bdYke8+z/RfuK9/WK
    bV+gwkfmEyi/EtYbom9IKu8uFxJFNS1tW+BRQhaNDIeiCVA4ff7FMA+dJ+/kJEjoCI+Kly
    FVBPNq+QaVwwGZSxtDmZnzAuJcrycdasfmsWZxFwTFnlCVSl3WdFzychaH/O1LqIDFPNoo
    HOvdaWKKihvFijWfi7rjnHCKktnCUQuLHteHI3B1TDu/Zb/VW0mxhJVTKkQg
X-ME-Proxy: <xmx:RT_oalz-Q1MXHhdP1D9ovAsxbkcRNxVO49fKqF56rkDTvQUDSQzPpg>
    <xmx:RT_oaqOq1twtDte-bn5R58Sovc0Wm8pFETDnvfeoquJHLkuUpJwp3g>
    <xmx:RT_oajlJeQ5gCil-C1spln89-vStWrDgtNw3KJaW7FskRwnX06gjyA>
    <xmx:RT_oanQZmyFcn6qGzf-6xBFCNzw7kaj6BFOMiluIpuYJw7Vbn6Rd1Q>
    <xmx:Rz_oam0e3KHNlaRmNwIVU5UZs8N5Nt37fwZg1S_34A_J04rxQhMmmPGH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id AB4A332A0093; Mon,  2 Nov 2026 02:44:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: Ap4PcZ20AeuN
Date: Mon, 02 Nov 2026 08:43:43 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vineet Gupta" <vgupta@kernel.org>, "Sasha Levin" <sashal@kernel.org>,
 linux-snps-arc@lists.infradead.org
Cc: "Andrii Nakryiko" <andrii@kernel.org>,
 "Ilya Leoshkevich" <iii@linux.ibm.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>
Message-Id: <9502ed84-cb6c-448c-95bd-03c0bfab4e03@app.fastmail.com>
In-Reply-To: <adeb8dc8-1cc9-4297-8d34-3f4b0e2f4e8e@kernel.org>
References: <20261015154044.4058618-1-sashal@kernel.org>
 <09db4d22-2836-4656-8c6a-a7e5377710fb@kernel.org>
 <8b4688ca-db5c-4122-b616-8e3964e403f8@app.fastmail.com>
 <7de128f0-4f17-4a33-9a7a-14d5bbf62e64@kernel.org>
 <ca697a3c-fee0-40a9-98e6-12e24febb3b7@app.fastmail.com>
 <adeb8dc8-1cc9-4297-8d34-3f4b0e2f4e8e@kernel.org>
Subject: Re: [PATCH] ARC: Strip libgcc debug information when generating BTF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 2, 2026, at 03:46, Vineet Gupta wrote:
> On 11/1/26 11:45, Arnd Bergmann wrote:

>> If you need this to fix the regression, I think it's fine to merge
>> the shared lib/*.c files for for 7.4 along with whatever you need on
>> top. I suspect though based on Sasha's patch, the only thing we
>> actually need is to stop exporting the floating point functions
>> so the types don't leak into btf. If you can verify that this
>> is the case, I would do the full conversion for both nios2
>> and arc in 7.5.
>
> Yeah Sasha's fix works w/o eliding the FP routines (there's an unrelated 
> issue which I send a fix for [1])
>
> As of 7.4-rc1, I have 2 ARC only changes to
> 1. Switch to existing in-tree GENERIC_LIB*
> 2. Dropping FP symbols
>
> I can post them now. Once Simon's changes land, lefover ARC conversion 
> and and removal of libgcc can all go together via your tree if that's OK 
> with you.

Sounds good to me,

    Arnd
