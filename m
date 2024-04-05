Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D5D16F8F0
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330663; cv=none; b=rhhjNTYovq9N2jtTe7qXAO80gRM1q9LPtrtObCF/NmluaisUyNcoUMc1jfYbqyoU3i95vHdVhlJC4GLx5eunWpKOL/IaAZ42EIuRKr4GhyYKHBMdTg/RQUZTPKd4IDWgNj9qdzAamz/PVjWdnx/ffnPwH65dHd5RNFMlM6OB+iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330663; c=relaxed/simple;
	bh=ckgNVSwIVilpF1lJx90Atx27+oFVtKqi4dSbAVvjllI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=simY40iaa7dxO8TmDlRXDRqoHYoxocVoRZualRpNwBW1sWC4xAcnpEpQqY+qiSKIgguzRyykQ8g+/iczMlswAXyCAmbwSJcsM2xhhkqufvhPG8XqG5M8v1BEIKi46WokkGxXDRJWrUMFiAxtzWRsst0wgjgiv0IBc32XS6EVhvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CP4OURmE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CP4OURmE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e2a7b5ef7bso18007325ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1712330661; x=1712935461; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=So1yScepRGrYGT1sv1t1CF2/3aNevmIFUqPN8jLqXzI=;
        b=CP4OURmEPbkj3FY7HukPxtdfYZOWU1fQfOvqak7jlBKke8bBDldjRidMkA4wcqdDMj
         5aXIIzlIfFi88KLjzRjXrZ7b1vD1w7TiKawLYTX8mU+t/NOTIAcPMiS6bd9fU9Ocpcjb
         pCbehfEhyt1qcbTr3Bj6QVnM3ecNCi/RKiZOyKxLUKdPYPgP1ZsWpdSquuL6OtMYDHD5
         XJsQ+Obn/axecFgrWCm8NB5BaZ3I4n4KxSh1dzrtyO3aJDVUOrRg5uMnvcT+cRtb1x2v
         9FfGEqnTIFXrHw1LzB4O5PUi9lFUAnN8jNb82yVB3DiWRKVcOJk1hbAlu9Zmu77TO0bV
         a6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712330661; x=1712935461;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=So1yScepRGrYGT1sv1t1CF2/3aNevmIFUqPN8jLqXzI=;
        b=EskzTrzEsVq7SNPBuzk0wIUneQB6RhUAf8MWLOpWgnb4eWNYYdfqTeNA9YBt3VmAhQ
         wA7gKPDUoJfaU1E9vO100c50RvltgfDBUcF3quwsAMqqGoh/llu2DmrD2tHMuLVDjQyc
         KLKIlxS7jitjNHsZUbf1e5ZnLdX0yFMHLiKuXIdSYXwfFQRUo+0jKPfGGNLlMS1ZqR9J
         gbFzwNzYSRvrIZw244UjNpTmoHu1uI2wec7S7T80wwyybfZWDQqx/xWolFjDkTKeQB6I
         WC1YTwGU33QeYainCbZeqahxeVybmq0gybgZeWOIDEY6ouRUP0XSGVZdoGIMB8uUgCf1
         jQpw==
X-Gm-Message-State: AOJu0YxTi1B1Wbwg5VOjWhAiYvBmourbZo2C3roNZ5Lv7PMX7AK9I8VB
	faq+MQSAQob8ujme3ObRvIKktPzzKaMTlyuoTzx0Am7CPlDMDMw1VPmYGNUix2Y=
X-Google-Smtp-Source: AGHT+IGZH6fMy49tw+nglcF79fu781lzMcmKMNpwXyds8Wvf7woixjVn3FBJTOzF5hzUmYDwLORMQw==
X-Received: by 2002:a17:903:2b05:b0:1e3:cd8c:d370 with SMTP id mc5-20020a1709032b0500b001e3cd8cd370mr862662plb.44.1712330661248;
        Fri, 05 Apr 2024 08:24:21 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b001e29833ada6sm1693963pls.140.2024.04.05.08.24.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 08:24:20 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>
Cc: <bpf@vger.kernel.org>,
	<bpf-chairs@ietf.org>
References: <20240307180133.GB63192@maniforge>
In-Reply-To: <20240307180133.GB63192@maniforge>
Subject: RE: BPF WG ISA Document: Last Call
Date: Fri, 5 Apr 2024 08:24:19 -0700
Message-ID: <086301da876d$54c3e400$fe4bac00$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH0KFPL299CfAf4NyBLkjq0DHfuLLEmhYWQ
Content-Language: en-us

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







