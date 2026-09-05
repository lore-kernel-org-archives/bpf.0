Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381FC34F27F
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613875; cv=none; b=t/mFUlfOzdFIwMkgvimtMy0KiRtqrGRZuHRddr5/zA7H5K4SvJ+WGcSkHBNIV+48TlCMPwIDdxaD4A6gsxVWlDi42TWlj5fSlOL1ZczAl0IvuWGHow6h4SekZ/P7xvWehNfIKLyRsYqYTWAKfVs8SFiugfY8psbPqcXzovg3Gjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613875; c=relaxed/simple;
	bh=vLMEvFXATtb+qL7qAJFQ7jf+Bqc2hC7mwyFeDTc3h3g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WbAS+65FxpggACMXkC8cpomaG2JihccaQL1Hwse54fdx04t35I46vWsrEFEl4Mgckz8gGIWoAdAvZKOmi4H03cScI5qBNSpY1ictFIOpGJl81F+RF0PWwiFxFaXNrsu7CA4gwz2TL1Aakk+8wQb74eQrAr6g1q+kWhnQ1MzqRGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dancol.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=dancol.org header.i=@dancol.org header.b=iy+7qsu0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dancol.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dancol.org header.i=@dancol.org header.b="iy+7qsu0"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1557189a91.2
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 06:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788613872; x=1789218672;
        h=content-type:mime-version:message-id:date:user-agent:subject:to
         :from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vLMEvFXATtb+qL7qAJFQ7jf+Bqc2hC7mwyFeDTc3h3g=;
        b=GV8cs4k/QkL1v7Zk9LH9rPeIq749G4X8B0d/5IGFpYUXuTBoXZD/vi+p+GabMhXimJ
         u11Jm+dzCDJKrClPWKTdgYFoW2o7Ruk+wVBX/xT/vsJhChZ3/VT4xKc5YfEMWxuvRpwG
         JzXx6kRd97QhvRaATlsLGMWZkvmWYszhgWyOWzLsKkqqXtsAc8M0NB0GwAjkU+Be4gA2
         WupVMG0XQoeV6HheS+RoDX5fBJiCQBKm6f+nEk2Oqe0JENo7qddf7DKom9iBGA6sTGuB
         qGoYGX8JYG/gubPsozq9AjQm4oWjJQcJ6gzaIJrniUhggGR3bPAaivheu2wVo6G3Boa8
         w5hg==
X-Forwarded-Encrypted: i=1; AKwUvBykh20L6QK37oPkTl4sOgT1jeJez1PeYiMpV1nFkO57k/6UH+LAa6Byp+SxGJQIPYHGYUQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nJTex9lSSDMsmu5zRQpz6J4lC0vBNnLyUsAiNczOzpfwMTkRKK
	iEMJMhWRj2DNpBvYZisP4Pg10hwWLEit/Jr57t5qy1wR6tbKZlpMZhX4
X-Gm-Gg: AYBFou2jYULjzsHiiwe9NFChbKAO9np9cZOLry3xTLmtUM4+5zM3ph3hGEdPpEHvhjc
	ABnkON2CHK3cKjUgOwxmmOi3eHBawnW/mMl16EihCxyDk4tMd3dFA8uOD3dCnEpaH2d1YTkXWC+
	0+C9tEjh5+NAQJW7DGV34ihutma9QnXqJO2VuWvsFAQddFg6RT3kGi4xhgzvmjOBpsIMmQQdi08
	kzTO04n2OFC5QdXFS+do0uKEZ/hYjEXfjxvcITATdSSPrXWOUOxfLT4Iw9eH5u3CWBgI8qitKwT
	h2Es4WDHnw3ITc2w/cYwmyjcYKooZQ2lzoiKW3lW8K25UdreCXNEm66Ryq+3wlwelpoanL/XdTN
	cMbR14pCkfIAjYO/nBGolxFXPWiH3V1PnStNwMHwPnRuEMWImeNIHKcsEzlYtnOUnyhIo4m+PO4
	sGDwsIxsKxR01IV4++CvCwrSdXpzEF/vM1Ix5ka9B1dXf9Z1nU1IqRh7zB7MqZvYuybW4JBCMQe
	yUUy2OLuWG40qA3JAj0O/+gIsGH0JAKk+pp5gU5wGx8eHgGwQHMXEy5kqZ9Uaqq11WOFHLCw6kb
	GQ==
X-Received: by 2002:a17:90b:5243:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-39b2614df1emr20264646a91.5.1788613872410;
        Sat, 05 Sep 2026 06:11:12 -0700 (PDT)
Received: from dancol.org (dancol.org. [2600:3c01:e000:3d8::1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534d25sm14339020eec.5.2026.09.05.06.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dancol.org;
	s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:To:From;
	bh=vLMEvFXATtb+qL7qAJFQ7jf+Bqc2hC7mwyFeDTc3h3g=; b=iy+7qsu0qjxq6SCPeFcJJEO2MG
	qo4kABksfNV4jLUmfPfT27iGZHz/KqWNInqSd6TUfBctQyXbF+vKJ1gxP0/D2WJWpMFUH7qDTKI40
	bmlOI64c3agHpMHuecbw98BAJaMPBbnQMU/Wml0r4Kw0skbY9Dq1LNqBlOsvrJVUPFCA+9P7LLCKW
	zmYoi4Ymj8RJ5l2HNn97eoFkpY/lSuM1TQkigvRkbgqVRgmADeDZ9Hnq0xzom1/UavJBECPBl9qFu
	oxZ98FtifArtR4V0iNjrGBfSjlBjdWgstpSc3AmGfDwyTRs9zHHzCVqwCV3nMVty0h4PC26+0Bv0/
	3/oDjfwQ==;
Received: from [188.54.63.22] (port=43451 helo=localhost)
	by dancol.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <dancol@dancol.org>)
	id 1x2qAn-00000000XxG-3tgb;
	Sat, 05 Sep 2026 09:11:11 -0400
From: Daniel Colascione <dancol@dancol.org>
To: adrii@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, mhiramt@kernel.org, akinobu.mita@gmail.com
Subject: Fault injection for bpf_ringbuf_reserve?
User-Agent: mu4e 1.14.1; emacs 31.0.50
Date: Sat, 05 Sep 2026 16:11:07 +0300
Message-ID: <87ik4jj11w.fsf@dancol.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Might it be possible to bless bpf_ringbuf_reserve with
ALLOW_ERROR_INJECTION so it's easier to test eBPF code that reacts to
ring buffer entry reservation failure? Am I missing some other way to do
this other than janky artificial ring-buffer filling?
