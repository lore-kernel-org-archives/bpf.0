Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793531431;
	b=wfJU1wkB8EtVLltDqwcDE1T/Xe+WC+EkbaqIx1hTsGCBGDteSwYYDpbCepw8ybcvXH1O
	 87J1SR7V+h/LwzjwW6Afiufd3pJYjdHVfVXX6cwxM3C8ggw5EpMvjWg7n3Xhdc0zYzzSy
	 nsVf5wLdB0ajljEOmDHO7MNNiysH1usiUKbZlU6bI7cOjn5A8TVkqd5Aze0CCj/MTBUoZ
	 uUC+7D75C7OzZGJr9mkyTD5ZvJBXtvUvmU0SAEbLu66jjjN5/TTRJx9KIkUjrw1R7FX7k
	 RPdzsmaB/Avbnl6l+Q7Pmx2NZvm84PHUG3Eqa+foZv59NQPasx0SA7/mGHinRnjrn2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793531431;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=4wfpv+QTFOtinTEPJMT8d2lisDokEK4BkxqjtCTUaKw=;
	b=5rTUW+xU2Ks/8d2BEDL4FFr83D1WmfX8GBjUgmVv3NZqppOjsziQ7losYMbhnai8IsR9
	 vTXDnysXl5Puaej4ib1b15WIAnAKDXAfEP+IUdY94dkj+8b0bqnTiazOuWzkNb31Z/YNC
	 RS6T1LVLd9wKRuJZdccOaaZFpAJB3YSAdWJRflUYDLT7LN1xOrtPyXg7rlnzqin1FzG0s
	 JVrbhML9nrTM3fkvQ4a6U12hAEIpOSAbq+X+TrQLxKtYeW50GcXoU3lgWLDj2ugE0xjur
	 0WuYzrpuNdE1h9i5w5bsISAqpqAQQrTvOhvp40WBmJriqGqe4ushi7ZwAvGaiyDLq4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=EKEgsdW1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YfeVPFHS;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F97D606A329
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 11:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F97D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=EKEgsdW1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YfeVPFHS
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1EF78140022F
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 06:10:30 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sun, 01 Nov 2026 06:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793531426;
	 x=1793617826; bh=4wfpv+QTFOtinTEPJMT8d2lisDokEK4BkxqjtCTUaKw=; b=
	EKEgsdW1SfyxgrDSqbPy62abe6+yBX+vL8a+2UTU1LI0NXk3+oTaS6avYxMslK0q
	hD3tRCq6YVfuB8k/7VCiSZEh8QwckekW94EGnruDIdvufsRWFDTepijIPuNrCzLV
	DVnQ3CMYpZuLAbHq5wf7HijEUnm1YbWV8SMIaVs+liNJT6U9WSi1i3G3Q5auBNIt
	e6w7QQDPuAyjHO83x7ztImfj0rBttm8KYodZ99NyC3Upd9h9hX8qzrQ+tebUqMir
	IMWjfaCAgAw3EN6uLyXuUVcTQE/+husMVqkdtUxz2+idrsk31Tr9MyMm8XFuVEWA
	d8lktoXhCdH1z8uqytMqHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793531426; x=
	1793617826; bh=4wfpv+QTFOtinTEPJMT8d2lisDokEK4BkxqjtCTUaKw=; b=Y
	feVPFHSXQ2Wa9yVx3P2SOgI7aWm+6qiGZoLObH40GRMXWrDCH/OP1fbDCqKQB8tM
	m5J6WHkhcOxWe2Grnv4SlUrdMekD9yY2ArzwI43YkiBpDpijgF42Lj3fb5kACDpj
	EaB94J+9Go38aF7zdzRbe+Gn+A1tKT1JBm5GvNBtjdVBeNkyRJJf+0e0wCE7x4em
	NWw/2RM8uztmwbHdJyVb6lSrddIPxSNDE4a99N7/hmOj81l2NVlEW+TOfZ/QM4zg
	JYRb+qER1rBvnOHHcypuE8Iufg5u21jWYORbdtvU6hVoYt+YorUQPt9vNHLOkG4P
	ipkEdAvx775JkdeMQOsoQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793531426; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+; rt=PGJwZkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CWAw7lYWrjp6XuPikXilEnNBhPaj7dDZJU51xXgJoEMizUm
	NYsOwBjMTCcMr9wtzJy/3P+Q/Rsl8glWFiXEKVilkKS97Il6J2/cXYFbNrYFEbpa
	nau3wYm2M3iqUKxB9N8LS7/kjt1o7Wu3QIn0ADjSFHcPSZHcJDpXX/XKO480AsU9
	TkTOm75aaReapvRdfBeYFSzEorRDcUw0YAaEHRryM8F/bu+IsbqHl7mnSqnu7pjk
	CNdLQlYd4pN/Ob3mzyat2I8zJNvtQ5kFBDm4aM1s2p0jg+uhO4WRV/mmKE0B0QRf
	Xrl4z8+JYjeLPO1eliWQxqnnKYGwYPaCudfOCbg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:FDA21DrBgrzqdaomdKVLZobssXJHwAfVxzSxQkSif5Y=:baVa2LtZmCenyZV/2WeRHNZ/OkEdZPERVqPYiPWE0pE=;
X-ME-Sender: <xms:Hx7narBXHcHcMiYGvSnv_DkH6BCsOwWvL-_K9ae1w0mN7mwySCRrQg>
    <xme:Hx7nasVJFejhn9XWQe2GeXmKbNk_wJH_bLzPzYji1RQPfqYMPpu9sx_7iKmpEB0uA
    HqK_nnOHZUNcCdwhnaGpLK4TBD7m2eeANcUJIGVf8SS8r5qKLLYLdo>
X-ME-Proxy-Cause: dmFkZTFysQRqxqvi0Wb9oWm4wruPAg1gWPeP99tcZEkNI3yxqU343EAQO2QcxMdNR8VWCi
    l6cZlJq2fU2vqsUmRqQmQqGu5Z5VFEOwmSomr6ENeL9mWh7UpbltslPJNnqEhkTmMvkXHo
    L4f4QMBZrIBi9bh0/DZ43DXc8eLec4y/7XkmT64KS3mY+3B/K4KBHcqKup+Bog3XZNARY4
    z/WkR56BmAlS35cY7G094YUf2tjFYccIb40rkzexho6b506uXU3NHCMJdvxV/m0KmPx2YT
    AW2ilBV6xD2RNKbgsUSEdIqOLvyVHuywb/hJ0+rptlsF7vHaqWv+g9ftHmTtcvmMGf0os8
    95oMGI5e3yW006P3n7JB5yMeQtWYhYHfUC6N6D78xwZKqWON129r5yp28eoY1Vd5KM9hQh
    T4PK8RjYQx+Oiacd7QceLJzWAqc65MLUu1Da90d5b4M+RcbFVhzLS8Npra/UzOzImA53Lr
    /kXqJWS7m2TOOjyzDOwB+/j2E4NqCLxGHszuz14N+gW/JcpjqzOiZUEqZsrv2sH+isWgAz
    e95+BKpxp1SJgdZvaDDtIbL0tlVSBYZbkN9EpcOoPK/Rp7svBFzv1tS7ckaHD+7bVvkrN+
    0DLxmvvVA4lQ+VPwns3W5ApBLAJkDOshDhlRJH+1VRecGtZ91j3c28m0b6Ew
X-ME-Proxy: <xmx:IB7nai-FL20ZyyPTM4c5Ty0swO0GPno4UDXOdsfQTK1txrjdz1Po5w>
    <xmx:IB7nanqkxMXV1851nhVBB3GfPGTdSsi3tBB10ytauak_45qcrl48Mg>
    <xmx:IB7nasTTd84biTLVWzJYJsjNndvQ5xzN2AR6lY19q8xLft5bZ5DwTw>
    <xmx:IB7naqP4mNORn8_XLi8QuJQVOJKda2ao13bmwWB5ENn5HWNoVqV6xw>
    <xmx:Ih7nagQrHVSJIoEpQ8YSiNcHvwobPTBrJlAH3bBifFFW3JuwThm5Tb-X>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E53DE32A009C; Sun,  1 Nov 2026 06:10:22 -0500 (EST)
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
Date: Sun, 01 Nov 2026 12:09:47 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vineet Gupta" <vgupta@kernel.org>, "Sasha Levin" <sashal@kernel.org>,
 linux-snps-arc@lists.infradead.org
Cc: "Andrii Nakryiko" <andrii@kernel.org>,
 "Ilya Leoshkevich" <iii@linux.ibm.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>
Message-Id: <8b4688ca-db5c-4122-b616-8e3964e403f8@app.fastmail.com>
In-Reply-To: <09db4d22-2836-4656-8c6a-a7e5377710fb@kernel.org>
References: <20261015154044.4058618-1-sashal@kernel.org>
 <09db4d22-2836-4656-8c6a-a7e5377710fb@kernel.org>
Subject: Re: [PATCH] ARC: Strip libgcc debug information when generating BTF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Nov 1, 2026, at 02:04, Vineet Gupta wrote:
> On 10/15/26 08:40, Sasha Levin wrote:

>> diff --git a/arch/arc/lib/Makefile b/arch/arc/lib/Makefile
>> index 30158ae69fd4a..2807ee24f27e6 100644
>> --- a/arch/arc/lib/Makefile
>> +++ b/arch/arc/lib/Makefile
>> @@ -13,3 +13,11 @@ lib-$(CONFIG_ISA_ARCV2)		+=memcpy-archs-unaligned.o
>>   else
>>   lib-$(CONFIG_ISA_ARCV2)		+=memcpy-archs.o
>>   endif
>> +
>> +# libgcc can contain complex floating-point debug types unsupported by BTF.
>> +# Strip only the debug information from a local copy of the selected archive.
>> +always-$(CONFIG_DEBUG_INFO_BTF) += libgcc.a
>> +OBJCOPYFLAGS_libgcc.a := --strip-debug
>> +
>> +$(obj)/libgcc.a: $(LIBGCC) FORCE
>> +	$(call if_changed,objcopy)
>
> I'm working on getting rid of libgcc linking for ARC.
> This requires adding some GENERIC_LIB_* routines, but as part of that 
> series I'll propose a revert of this and then the dropping the first link.
> Don't intend to revert this per se, but revert just makes it cleaner.

Have you seen Simon's series?

https://lore.kernel.org/all/20261030-nios2-remove-usage-of-libgcc-v1-3-4e341c66082e@siemens-energy.com/

I hope there is some overlap with what you need for arc in the
lib/*.c functions. I can take both through the asm-generic tree
to reduce the dependencies if that helps.

     Arnd
