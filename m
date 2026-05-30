Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD7F30DECC
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 02:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780107177; cv=none; b=SZBSO3fPd56SGn8Ur/+6YMtNn77rlODptKlHVqp3ZRP3hGrOqmVoCha/PPsPxW8DcqgpPrZnk5rZeLSBhisOUHDQDjjcKQ2tJSCoOIC7PWSE9+x5aCOZdnUfT52xJDXPxDnxngtfZ3+fy/lFh5+CQDT6ea6Xg6erVMjlfV+uTq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780107177; c=relaxed/simple;
	bh=RjDGwebIrRwxlezZV8tA5Mt3jQZhhLInwTh+Dm2uPk4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID; b=pKies/L2puAI59VKGRdbA5xJ7iqYWJ+/p3kIuA1di0HgWPMr3fVp7h0Az+tMZnZALO7paDliDLhyalw9MOxuaTAIo1cVy2xj4CNvjLX9aEtnwVOd4nR6aNArc7kIG6Gc4f7Pc2V2/0Lqz9Lcv5VHUrZAasUcCj4/yOALakTc1S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2QL4aNK; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2QL4aNK"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a88de2b52eso17130351e87.2
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 19:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780107175; x=1780711975; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:subject:cc:to:from
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjDGwebIrRwxlezZV8tA5Mt3jQZhhLInwTh+Dm2uPk4=;
        b=I2QL4aNKebEWwugeopU96P+YxnuSrCBS3rRYstGxOXM0Lip9GRu0I0aEMhbUZApPo6
         +r0Lm9Sq0DxBC7ksqHB2bHUM6IM4HE2NAM+0EDDRf8qfwtphIIouiB+/iWl6xn3IW7+E
         +CC78CAVOdSVJuuxwJvEU7UMauAnAASXdnUgQ0L04xdsb8tZz66EpZvMOae5F5zr/YF6
         GpEnctmTjtCEle5LGf9/8rWet0L3Rm72YvN6ze1Hf01o196XYclRXihQr4Cs2cuSg9G0
         hSj0hJHBHzm9jeNefqQ/39BFkvRO7nPeaFG13+cRcqsdoaHQzmZ8PhcP50FITqM8yeO+
         i/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780107175; x=1780711975;
        h=message-id:date:references:in-reply-to:subject:cc:to:from
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RjDGwebIrRwxlezZV8tA5Mt3jQZhhLInwTh+Dm2uPk4=;
        b=p4evlRrAvplz51sGNnXie2BEJV4eRTvRhzFVCcu/p4Gi4jsFToiZc2DWC0aSDHlyxL
         mAQetSdUqw4CwL5msYcnhcyUHCYbbBOiHYsUfQ+4juDhp/pt6qrzf496M4+M/kgs2De4
         upG+DATtTp3n7adFN8MeS9z/Hp/EVSaFROhx3ClpeKC+/d2qj7BHYRK4P/pwyr/Xi4QD
         x+d/Qoyx20KSdbmTEZIrfVB4fQr2RJjgUbguah2JUjWpKQpT78W0yqnzJE+GvGGQyDRf
         12Mn4nL2X8uEFLDT+QM019rc0AmjvR0A2deXwBITCp01+I+nAIWmwuR7HmaALpQ/Y+L4
         M23g==
X-Forwarded-Encrypted: i=1; AFNElJ+u9XU/jKlmp5wZFgZVJekRU52zWaUyOpm2Ii163aB3pSddMx3RBMwycsKfU8UyuvOXs8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjsVAjA/lq22Lu6HWC1FVI5Kch6mBn8HapZkYcwViny2NOrIfF
	zmj/Te9ayTS7EftAs2iLwq1kMTEioijcpwF/TLHAtVGvSdYHIPuS+yl5
X-Gm-Gg: Acq92OFrGHGDd8UsU49AIUHujE+mTtVC1atTSbBVOwZ1uuUdxJfHdObaNq8CLOcQKqJ
	PEF4DQ/nBSFg+ezYWxs3YLr1jLV0HvXhfUbVHwDleyWeuhzuTrRTJFe2SQX/BQSv0d2ZfKUofHX
	HEt5O3pv/05nZ/P6d9sDO1YvHf/2R2qawtdZNwO1ucyVDHyv5hmsP/q0kh3QgeJSlK3cSNM/sXs
	h1nTOmot779EqVzJKE/1Dtw6ULadHNPV9ISx9v98Dd9oyOQwdIfDHzjJXbL0XARXgUPfPYx85iy
	t5tYYg7WMnkRmWGrxak+RFRh+MMH357pYF9rdXuq4qJPki6p/nNq5bfXayc6QprO+n5EETWHlNw
	tjlpBdaKnN6NsJk1EFujMcPOr0+Th0js5y3Jd9xoRaGpmn/yzc3RHvN+EXbx2mQKsjmdjFACFK2
	U4FM0wLC9mY9dl/chsceQnV78N4lyUD15h4oU73L21PgGMukBdzhlfkcUPoA+i4cgChGia
X-Received: by 2002:a05:6512:3193:b0:5a8:923a:5369 with SMTP id 2adb3069b0e04-5aa607adf7emr589233e87.16.1780107174519;
        Fri, 29 May 2026 19:12:54 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:4f9:c014:1ab4::1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b596664sm669639e87.39.2026.05.29.19.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 19:12:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Seunghyeon Lee <hyeon3125@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [PATCH RFC] bpf: add DAG fast-path in verifier to skip redundant state pruning
In-Reply-To: <DIVM9YXYJV5N.2TEM951JWKD95@gmail.com>
References: <DIVM9YXYJV5N.2TEM951JWKD95@gmail.com>
Date: Sat, 30 May 2026 02:12:52 +0000
Message-ID: <178010717294.19003.10323978025488327836@gmail.com>

QWxleGVpLAoKQWdyZWVkIOKAlCBEQUctb25seSBpcyB0aGUgbmFycm93IGNhc2UuIFRoZSBnZW5l
cmFsIGNhc2UgaXMgdGhlIHJpZ2h0IGRpcmVjdGlvbi4KCk9uIG1lcmdlX3ZlcmlmaWVyX3N0YXRl
KCk6CkkndmUgYmVlbiBsb29raW5nIGF0IHRoaXMgZnJvbSB0d28gYW5nbGVzOgoKVHJhbnNmZXIt
ZnVuY3Rpb24gYXBwcm9hY2ggKHlvdXIgZGlyZWN0aW9uKTogbWVyZ2VfdmVyaWZpZXJfc3RhdGUo
KSBhcwp0aGUgam9pbiBvcGVyYXRvciBpbiBhIGRhdGFmbG93IGxhdHRpY2UuIFRoZSBrZXkgcXVl
c3Rpb246IHdoYXQncyB0aGUKbWluaW1hbCBzdGF0ZSByZXByZXNlbnRhdGlvbiB0aGF0IHByZXNl
cnZlcyBzYWZldHkgd2l0aG91dCBmdWxsIHN0YXRlCmVudW1lcmF0aW9uPwoKUHJvb2YtY2Fycnlp
bmcgYXBwcm9hY2ggKGxvbmdlci10ZXJtKTogSWYgYSBjb21waWxlciBjYW4gcHJvdmUgcHJvcGVy
dGllcwphYm91dCB0aGUgdHJhbnNmZXIgZnVuY3Rpb24gYmVmb3JlIGxvYWRpbmcsIHRoZSB2ZXJp
ZmllciBvbmx5IG5lZWRzIHRvCmNoZWNrIHRoZSBwcm9vZiwgbm90IHNpbXVsYXRlIHRoZSBsYXR0
aWNlLiBUaGlzIGlzIGVzc2VudGlhbGx5IFBDQwooTmVjdWxhIDE5OTcpIGFwcGxpZWQgdG8gQlBG
LgoKVGhlc2UgdHdvIGNvbnZlcmdlIGF0IG1lcmdlX3ZlcmlmaWVyX3N0YXRlKCk6IHRoZSBqb2lu
IG9wZXJhdG9yIGRlZmluZXMKdGhlIGFic3RyYWN0IGRvbWFpbi4gSWYgdGhlIGRvbWFpbiBpcyBm
aW5pdGUgYW5kIHRoZSB0cmFuc2ZlciBmdW5jdGlvbnMKYXJlIG1vbm90b25lLCB5b3UgZ2V0IHRl
cm1pbmF0aW9uIGZvciBmcmVlIOKAlCBwcm9vZiBiZWNvbWVzIGEgYnlwcm9kdWN0LgoKTG9va2lu
ZyBmb3J3YXJkIHRvIHNlZWluZyB5b3VyIHByb3RvdHlwZS4gV2hhdCByZXByZXNlbnRhdGlvbiBh
cmUgeW91CnVzaW5nIGZvciB0aGUgYWJzdHJhY3Qgc3RhdGU/CgotIFNldW5naHllb24=
