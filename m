Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55597481A3
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482633; cv=none; b=cdb0M9GolYPA9LvgtLckx1UeXnPaTP0+kkxUkcAJN0Dj42886rAAcO+4Zzwd53YCrLVfXuS2hvtNDa6abeyVz5YW+HVb4uTXSX7+J/ynqGOK8Cqx1EDPJitdiXKam0bVl/Leq+MAzijI17N8K2Y0yuETPIGT3IM9UBSFeQ8iRrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482633; c=relaxed/simple;
	bh=5wYfRis+uxqD/4rXCOR+gjA4Xkbk0+OyB/OeMh80980=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EY75bPKVBz8TZTji8ljklQ49DQPoLkgvUC9ANSUr1ryKlA01ckgxSTgJvHb3MnqJZn50favVo9Aj5mbRM8FoJgoMhqNP+brgNYIhiNpKjDsGII2CAXvAHgGgkSkjz9AyCmsCFp7y73NpX2IQRNwgltf4xTdPaqze5zw3JIozt3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FKmzmrOS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FKmzmrOS"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44f2d894b7so731482066b.1
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 12:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711482628; x=1712087428; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gC5gC2IbYpO1cPdVUfhpEQh5vTF4QHyyUHiwLcr3BHw=;
        b=FKmzmrOSP8fVVqxEpCyvQa/iyCcS2sItq6WPJLgp5JpQzW6KdrDldfpvHniE46pOgl
         0piXyNKdlKzm8RKgTHf5fvI5nWMmPUUwLtjlmw7ekdpeHLSDPRGPFFFkuBC/pr1RMLMm
         699D+4Fgz9Wmf1dQJZ7mvMgAI0uYDhhDBHCWcyix572al2RYkLcJV17ISE0Pbd4fD9BQ
         cV2E+UdBUUapOQCaMEn5c51ppqo+jxVQPvFEje2ZLGsao3zI/i9d4EMeDDKgsD9eH8kR
         P9VCR1TTfiwg8BOAnZOtc52UvgkJLar13LYR/CCJp2gbJKQ0HxoZYhyYzzuha7EtrPvO
         LI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711482628; x=1712087428;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gC5gC2IbYpO1cPdVUfhpEQh5vTF4QHyyUHiwLcr3BHw=;
        b=krJw/4S1VsgedDQf8YfowapEIDiDM2NTesV+E6HEvmxvFoBg66ivwA8c82YqwnORU6
         MFrklvX8QgkURIUQhKrHZUDrWoehSIl4s8WRAx14t9vKZRMmOsbHmAG1DbYCH38dQy9p
         6FJE/Buo+rbJJf8Xq0n4ANRvBEykKQHHtaq75xeMwO5648fxVc5McMj32+3D82WivORN
         X6tzc5fE0ERWIJr0OCYXNwp5adoRM8GbCWazoXmWQNTnmU3+F/KtlrQfkQqCdduaClzH
         vgDL2HoOqh/s5vB00bPLn/JXAK5F701gS5cRDKKxYe+jjP4eEajXKxXgSV7hNhMz9Ygh
         HaMQ==
X-Gm-Message-State: AOJu0YxlR2BYaDHwH3TQivmlJ+0YkpIHKPX+HA+deKPDEHHpdMthAjyr
	bG475XQQBZ/6mUftuxGKD6tzp9cqq3QWVQIK89f2p7xPwcJVzraFTRVUUO2FooDIAB2SSOOt1ld
	jnQ==
X-Google-Smtp-Source: AGHT+IHRuA5OWtw0nR0sPgdY1FYtWxwyDOmTMoxz587MZO2NWyum1ynBRblWLfiuWPS9mdtQ8QlHQg==
X-Received: by 2002:a17:906:30d9:b0:a47:36b1:8992 with SMTP id b25-20020a17090630d900b00a4736b18992mr2670648ejb.10.1711482628045;
        Tue, 26 Mar 2024 12:50:28 -0700 (PDT)
Received: from google.com (118.240.90.34.bc.googleusercontent.com. [34.90.240.118])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709060e8200b00a46cddf1efbsm4578528ejf.29.2024.03.26.12.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:50:27 -0700 (PDT)
Date: Tue, 26 Mar 2024 19:50:19 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@kernel.org,
	revest@chromium.org, jackmanb@chromium.org, daniel@iogearbox.net
Subject: [PATCH bpf] bpf: update BPF LSM designated reviewer list
Message-ID: <ZgMhWF_egdYF8t4D@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Adding myself in place of both Brendan and Florent as both have since
moved on from working on the BPF LSM and will no longer be devoting
their time to maintaining the BPF LSM.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 272dba71f6d9..9372dcff0f35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3941,8 +3941,7 @@ F:	kernel/bpf/ringbuf.c
 
 BPF [SECURITY & LSM] (Security Audit and Enforcement using BPF)
 M:	KP Singh <kpsingh@kernel.org>
-R:	Florent Revest <revest@chromium.org>
-R:	Brendan Jackman <jackmanb@chromium.org>
+R:	Matt Bobrowski <mattbobrowski@google.com>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	Documentation/bpf/prog_lsm.rst
-- 
2.39.2

/M
