Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439754;
	b=QETGE634/PflSbreThgdMTH1WcNOrjmphjcnnRTliJm2EWrjOKdjZd2VqG4eHke6XhiZ
	 0SP5qadHD1foEdovzt0FT+/ivL+qZEjZCRlEFM76dfDDB+Y6+Ld/MJqCapY6FReVfgIPm
	 /YsTT7UWxT9KzreAvCPmBf/GyCurKF7GOSPea69xdH0jQo8bHjh6Kav16a0jXDT1R3tOB
	 pRN2m8ZFtqsqA287EG0DuioB9nSAEkOBvWAXbRSdUeLB3p5qrQcJEtBCuScnzl2m4AdQF
	 g60SSM0nzZzKsyjwfvCZOkuCb0MITL6hN+zdZaiWTcLmSyY/sGqwie1Sukc/sTKkajQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RLB0kdHt66s3t+IPpIovcCtAwBJ8pIpA8QeJXXPpv0E=;
	b=yr1ZXNa3B5d8pseSfbySxVkTSCFALZvuhYPoxlseuerAGo0DsFq3Bx726L4TwF4/C+AG
	 6ZEY29jtVn7rvJN5E0sehz7ECbornVwD/+7U46Y8AadlJ/ireMxk0q42OlnaXeKe7vUWY
	 9g0PQo2kIn6sfQM2w1RWXMNqmhePDTNVz90REqnovFxJ7kf02MvWfY1R6nzimdbDMHWMz
	 mu/5QUrzN44TFIxMJg2GaiFGbayC6E8zLoZCcxcfKwXvFCrphis2rbTn8NIm1Stz3Wv+Z
	 7iFimHLNOTegVO5URWo/BaV+pbC9eYigJiaREM5lkEjvberiNO2WmB/u3sBLUwTZSWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWgLEKxR;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F9606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 09:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 080F9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWgLEKxR
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35b2c599f43so1111657eec.0
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 02:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793439753; x=1794044553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLB0kdHt66s3t+IPpIovcCtAwBJ8pIpA8QeJXXPpv0E=;
        b=VWgLEKxRcfS/9ljvof9oZChkCGzRlROs//Et3cMkFIm/CL80NTVURSo3AWRyZekSuR
         D3yY3CoxtuzzGJA1U2ViHKXlkLmHTv4SeI64mNZZfkoueIDd103ePYKLV89IHTdXJvn+
         0LAs8aMhALUyyvcp/YZkwtMm8X1nGSVFnPSYmQK5v8aYskVlOIj0tuOVgaUAodzL4UPz
         NUA8j3UAj1LfgrgBj2MJygQcHAWW6a0VpkM1wNqKjm7iY4rMvODMi1MwuS0vqOrKNazX
         63P8YBW5C/FAfpytwd9eI0cPMHg6irpyJ1Jpdj35CS+xDza99M+gWz3Q2SfXM06vqJYY
         or7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793439753; x=1794044553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RLB0kdHt66s3t+IPpIovcCtAwBJ8pIpA8QeJXXPpv0E=;
        b=SK9YRtvPYNBJbhkWlyaJoxCwH9VVR9QqxsGulPQtFIyQxVXyGyPVfq1zly08VNDzL9
         1nf4LYCXkDucSkxnmnilbJj7RXCZ6y6dCs69cmG9QX4COJ8n4J9eQs5i4GALmJENONsA
         Ax8KRQbkiAyZ4wDdSaPlECibUD+h0eBE5nDjZ6MVPPre4DY/em8xVFbx8mq3YZ9cga21
         B6WX3ED8IlYTt1i2E1Debymh7tBeY1gn3Y+ixMisQLM2VEhQsUvBZ1ST9Zgs6o7oAcs+
         MkPBbAZtVegpQyn1q8K0+3j5sxiTwt+/ttZh0wDCV3KR6JBlOpTV853jxqRb6g/G+TKh
         cMnw==
X-Forwarded-Encrypted: i=1; AKwUvBydZZy5D3eE7sjP+VJq2gl5431ajU5caBOo+YVwoWsKpJaSpCUim9737PRqZ2MvpUaJYZU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ02LsghWDDSVtlBQoMMnnXEBEsSCsd5YQnam4JNa9jJUIjiese
	zES5bdqZ7+NHyy6kObi+2iLB6TXFaSMqgLtCDN+Tm4Jb1ksx6cz1XQwr
X-Gm-Gg: AYBFou1gAqHkuJaij+CwSZxfwFTVlyjD6iSTrBTMpW4T+kKZ4GHH7XYJG3OLDyzLpxi
	fbqeHtXha2Jy/BtHF42x/CpQVudo3bzWy0ZmIU6K2ZOMSDNHBZYpLDaOvA+VzznXf+GwUah9vPk
	O1our6v8dz+C27+FWGuouLp+qzJUrx5Cqk523o8xmICVZ4phX/syMf2b/lOWDrewGKAPVdLTFHW
	cC8jbDG6MevETZ+uT/mOHkAzUV7vdzZelQD+ADPAKgrGIkEBx942D97hhVfdDHJgtXhsKw+lEVg
	fZxbKe6Qs4Z3dxBuhLt5/UEDhYRjEC43yg+7jDdppf4XSFiL783TjZAywX+UdrUT2cH5IKnnaAO
	PycJWTn40hbqwO73FPmEGRsduYL64RtybmhX6X9SqLIRd2E1SmagB6XmTRlR01UrlXCmGTcizE8
	cQ6aPPdTw5yKPv9psmSdf1dbprVA3G/iHY5HDM+AK2yf2U21BPvIy1etyW5BB8riUNUXlnUqIVt
	S2h1vbYc6x0wwjSHYhLPROEdygRXTzJCDOGuBNCL4JxzcxGGB/+EKEadWAYqdnG1B6hwmMCT/II
	YKeqxdMd3urzWTFgYv2UyHMjRqSnlmkleuw3P31y3Snv6do3hrMKCm1N+pjhDoG59XffHdSAMXb
	A2DjAdz8/vjUoMitOYqYtn5eS49zRgzmfBjiKt7Za
X-Received: by 2002:a05:693c:6092:b0:361:7ab9:479d with SMTP id 5a478bee46e88-36a423ee70bmr8382142eec.27.1793439753023;
        Sat, 31 Oct 2026 02:42:33 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1dfsm15758617eec.7.2026.10.31.02.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 02:42:32 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: alexei.starovoitov@gmail.com
Cc: HyeongJun An <sammiee5311@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	bpf@vger.kernel.org,
	Christian Simon <simon@swine.de>,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	tj@kernel.org,
	yonghong.song@linux.dev,
	stable@vger.kernel.org,
	andrii.nakryiko@gmail.com
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable programs
Date: Sat, 31 Oct 2026 18:42:12 +0900
Message-ID: <20261031094212.2303487-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DMIRF0WAH6DP.1Q88Y58797IJ4@gmail.com>
References: <20260822225444.2774461-2-simon@swine.de> <CAADnVQ+MCsQxn5KTp-y7pZu9DrV0Lhy9=+T4yofCfZEZGZcWdg@mail.gmail.com> <apC6-9YqBpOjFLGr@krava> <20261030012258.3005240-1-sammiee5311@gmail.com> <auUhrnOOUWY3Mb9y@krava> <20261031011900.1355507-1-sammiee5311@gmail.com> <DMIRF0WAH6DP.1Q88Y58797IJ4@gmail.com>
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

Sorry, and thank you for the correction. You're right that this was
already nacked on the list, and I should have found it first. I'll
be more careful to check lore before sending next time. Sorry for
the noise.

Thanks,
HyeongJun
