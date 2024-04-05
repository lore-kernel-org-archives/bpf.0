Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B540D16F27D
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330676; cv=none; b=RDV+C9t2rWGiwvInCpnOp1wQiEARQYqXzFe0wPwRY+WTixV2OkzqHHtRRwHECh1AALqzbyn80vG0G4a8geaUx0wj3uMIjV6uTiaKtbs6oHqvhs4Vw7t3NU0PVT9O1rOYybhXmTFiy7x5ihZmLelWetJnnxw9W9LEIHHFdXI3RM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330676; c=relaxed/simple;
	bh=Qv0tpTAH9Dwh00742Jp+GcPutxMAOukyL3P105T5+kg=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=L2tOYAyjOBuxoKy7XilBDGkOc5s7g2SrYVOsaEbqbYTfW0+CKpz9R90N544RpZhmn5GOSKbxoTMcYMWUDuce37eCASCyzcAgGtx7K/u7Qyz0MEjGCiajbv2qLnu11rWm8BTEKagFVJv2zVotKg6686sWxGobGemIJRDWptYJ/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=NQGaB5Py; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=nzf5rF2O reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lk/VLcVG reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="NQGaB5Py";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="nzf5rF2O";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lk/VLcVG"
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 905A3C151556
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 08:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712330668; bh=Qv0tpTAH9Dwh00742Jp+GcPutxMAOukyL3P105T5+kg=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NQGaB5Py7N0AO3cyng/TPIEIJPcBaZsXvlHJrpKlb1Wwo6oR7Jr5fXGMJP8Gcva7x
	 Bh+IibUNSDnCtgy9E1unOZk1HoWFLDwGxqmINB48Enkkv+umeYg93q25ZPwQXk/j8Y
	 SxltKC2R5uN92XxasJgiKqP5DpK0msWyoj03vKBc=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 59B58C14F68C;
 Fri,  5 Apr 2024 08:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1712330668; bh=Qv0tpTAH9Dwh00742Jp+GcPutxMAOukyL3P105T5+kg=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=nzf5rF2O9Gqi/K8O0SPzhEngGyP784p6yrcl/ET4os0LU42Ym1tMJQSqrij8+JmxL
 jktd/qobIbDE4ehh/ZRQjVWiGwll1jVNcZFxb+UdU2J4heCxIIBFJuoJ2Pta4El/Qn
 +PYze4RpOx8/TyvCRraLVmf3hCcsBeaQBdLVti7I=
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 78737C14F68C;
 Fri,  5 Apr 2024 08:24:26 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.846
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OJT2nM-eGEkZ; Fri,  5 Apr 2024 08:24:22 -0700 (PDT)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 5DA0BC14F60D;
 Fri,  5 Apr 2024 08:24:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e2b137d666so15835315ad.2; 
 Fri, 05 Apr 2024 08:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1712330661; x=1712935461; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=So1yScepRGrYGT1sv1t1CF2/3aNevmIFUqPN8jLqXzI=;
 b=lk/VLcVGb2dFEg3oehmZnkFeqI26hSLW57XLKpBNUqZIRn7OgXBxI36HtdfloM3Gsj
 FnTX37J763hWoKnCkRtdgtBuMR+qQjv6+F2ruxwFAO6OImlLap3UtyB8AhKiyRjoxpGg
 Ibx8s1zMZtNkXkfvShdnP1qDFOzbqiBVUdFgk7UBfPnkSO7AO+v0Xtsy3vB6lrWRee2S
 Z/DJe8uLTmpJmEIFn82XHuJ4nwOlukjm0o7f7sRde8Tq6mz+Aaw3Ldr4monzAb6ZEHft
 s5QUKApr6Ti8PQwvORqDPhc+kGhLVD9Hs01jDswTn/zJ2pRuvyg2tcx0pCSGpLnPmE0U
 fGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712330661; x=1712935461;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=So1yScepRGrYGT1sv1t1CF2/3aNevmIFUqPN8jLqXzI=;
 b=wjq84yRaGaKXaOFxf6mY50nFQBpY6gltAiSKyj/Sky9xFVJonla3YkQWMuTzRdAXh5
 lAAesjma1eGnwUIhlrqSmIW946W7blUaPzgJ6dAnvp1hAt5mRpDWB/jz6PllFAcoBYed
 yyqu1K05hPNS1KfR5Q9QcHogiuarAhPQ42Bpb7uO8n4KZI8l5DL1rkTMOSKocMb6srQK
 wbFnKOXW3aKsG1n7FUuf5KvmHIAtbBq2epkowj9E/NhsMI1YT1LIiqb5gjJ23KTH2qCa
 kRMoEbHeYensUvr5/NacRx4cAuXvJ3ct0/RXzASPTqHl6ccRhF9Q0PFLT+LM8rCe3qaS
 5r7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMR7ZFtyt4GqfU+5zvOjFz8GPtFvqmJ4L3WJyC0MITCA3J7QX1VF79cTW4zGpL5Cazo8Xtmp6utYwBcZlwBMTGBKIW
X-Gm-Message-State: AOJu0YzIzb3o/ZeaUKX6M1lbm6wCrwDUrR8kv40BLhAyD+om1tXkQ80/
 SLTtaY4vf6AcugAe2B4cARC0cUcSi9Slo4XuhmcytFwSIQdZ72gdG45aDSJV39E=
X-Google-Smtp-Source: AGHT+IGZH6fMy49tw+nglcF79fu781lzMcmKMNpwXyds8Wvf7woixjVn3FBJTOzF5hzUmYDwLORMQw==
X-Received: by 2002:a17:903:2b05:b0:1e3:cd8c:d370 with SMTP id
 mc5-20020a1709032b0500b001e3cd8cd370mr862662plb.44.1712330661248; 
 Fri, 05 Apr 2024 08:24:21 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 l10-20020a170903244a00b001e29833ada6sm1693963pls.140.2024.04.05.08.24.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2024 08:24:20 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>
Cc: <bpf@vger.kernel.org>,
	<bpf-chairs@ietf.org>
References: <20240307180133.GB63192@maniforge>
In-Reply-To: <20240307180133.GB63192@maniforge>
Date: Fri, 5 Apr 2024 08:24:19 -0700
Message-ID: <086301da876d$54c3e400$fe4bac00$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH0KFPL299CfAf4NyBLkjq0DHfuLLEmhYWQ
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/5i48Qv4Ylg1Y1FuFN9JDJ526nrQ>
Subject: Re: [Bpf] BPF WG ISA Document: Last Call
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org
Message-ID: <20240405152419.-26Er0f5jD3ZKzq27KeTdH9B0ISiXyOwLZNrQzYjUts@z>

David Vernet <void@manifault.com> wrote: 
> We've made great progress since IETF 118, and we're thrilled to announce
that
> the Instruction Set Architecture (ISA) document is now in working group
last
> call. Please review the document at [0], and share any remaining feedback
that
> you believe needs to be addressed before we send the document to the ADs.
[...]
> Because we're so close to IETF 119, the document will remain in last call
for at
> least two weeks following the conclusion of the conference.

FYI to all, per IETF 119 minutes the WGLC closes today.

I just did another read-through and found some more editorial nits which I
plan to send a patch for, but wanted to get this email out before WGLC ends.

Section 1.1: "_s16_ is a types whose..." 
s/types/type/

Section 1.4: "tools as such compilers that..."
s/as such/such as/

Section 2.1: the src_reg field correctly says "the source register number
(0-10),
except where otherwise specified", but dst_reg and offset are missing the
"except where otherwise specified" phrases on their definitions, since some
new instructions (SDIV, SMOD, MOVSX) reuse offset for other purposes, and
the thread around future callx would use dst_reg for another purpose so
having
similar caveats on all three fields seems warranted.

Section 3.1: most places in the doc use "8-bit", "16-bit", "32-bit", and
"64-bit"
as adjectives.  A couple places in this section are missing the hyphen so
are inconsistent.

Section 3.2: most places in the doc put field names in single quotes like
'imm'
when referencing them in normal text.  A few places in this section, and one
in
section 3.1, are missing the single quotes so are inconsistent.

Section 4.2: "Where size is one of:"
s/size/'<size>'/
for consistency with Section 4.1.

Section 5.1: "a IANA sub-registry"
s/a/an/

Section 5.1.2: "to supercede the existing conformance group"
s/supercede/supersede/

Dave







-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf
