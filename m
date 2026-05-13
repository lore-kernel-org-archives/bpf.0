Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EBE3B7B99
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697392; cv=none; b=MVnpN5SyjwMqtqs1jW588u3xsNdSN9J4BER2AE4s2+TGvRkTMzSI/5mONgq0GtozIFcZvqE1w5yUkBq+VitpwSb+cwrpKp3I5tshj0nteg/ofcdcyk4dd7l4I6X75lHwhZGxVzKMq9fcVEofkp9/lIoCvpKbjLL0ZZf8dp+BOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697392; c=relaxed/simple;
	bh=NXfuPJC4WSBHlTygHezAndhnrlRtJXLP/Fq/2xUcvRE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=gkT7cOfLnylVKKC0GtaqDKNMgTLOodDV4nsdji/J+/+WYHmVG9AGR8465r+CBrJQFJB5id0cib++Kha0Q2hNCpqfziHnsV1w+wIDlj8wWt27cPkwrGkoTfSUgk35i4niYwKhel2V7zdee25v9GsjmYZFrKfwAMF1LB3UTXxL+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DSYTfoqs; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DSYTfoqs"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d67a483d3eso790525585a.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778697390; x=1779302190; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOF9niRN6Jvg5hWvhCYadN/BxIKdMgGJZ26cseYyxbc=;
        b=DSYTfoqsiT7AF84hz15ZZiMdeYslCXcIBpkQAP+JPkf4C24XRXdixXbZXftKA1Zv2q
         IRyUf9E0xyDQI92VjhlwvOFE2Kq09cxCGzagVQ7TnKtSLPnJUgsGvGx4SQdVLhJLynTO
         fTveQOWMV2ICb9h/0dBqMqENiXFDWWZvJcH8s2ZOU1+mObl82vfalhoUrPfcoIsogv+E
         KoBYnqOsuhVNJm+bU8H8bH1kpoR4SArDWlkil7yrH/v6lpfHpCjm/nOdEk6JqtxKt34V
         4JzlqsDTFJGYMjvwuWpwTtv10wZVaO1aoS876YgYCyyzNwbC+ouNmliGhzo0jO+RQ5/l
         xrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697390; x=1779302190;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOF9niRN6Jvg5hWvhCYadN/BxIKdMgGJZ26cseYyxbc=;
        b=Jv6I5/ndrnE4SnidHlC8fF4GmZGkqWTV6L72Q1u6uGBDsajEazS/Stw7NiqUSxm+JD
         QB91ZVB/KNaOS65EJxv8GdBmHWHfJ3dYowMYuFe11c+WVn8+kZRkN84Ht5TrpR/wRR2o
         FbLMtl59yoKrhGX3EQJPb8YmYyElVeFWYHLYH6+zCeAOB5J4Kk7CaIgbpxefMUd18SW+
         +k0lhdV/BSLopABK2UmR2lB1Q44QSBLo0JIB1yRBlu9oGdOmAVstYqjtiP/+OixxxFeb
         vcQfQBtcGEv8r57xBpdZzanL91QN1Ft3Haiqus86d+QjssugLkMERPV7QDzaIOxzPKuH
         PlGA==
X-Forwarded-Encrypted: i=1; AFNElJ9FuqubjBbX0CsL4TCMHbMBUmodHE+r6j5ALgBO5u4SUtZyAXsTgWfFu4XQy7wWAzMk7X0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1jm0bGOYAlpqpdfgL4hnevrnPtedIGMZ1FOMJw42ejZ+UgoAe
	boi7F6ud86XiR0DtMzJepeb2AuaYWsnWyl5ZfUyu1JNmJ99RXLBl6mjYOgqKh/xcvw==
X-Gm-Gg: Acq92OER2ynpSGoXLThnsieMIJAhiJPbf0pgwCyxfFToTNsl3SoHz5vCpW6SGPtorCV
	stqJuDrXvHAFeLuhQE5WcGRn2/IjS6Bu7rErRaKoSYHB/QmBcZ3fxxtpw+9LYZhN98jRadiiAkf
	sOuNWqnl9Z6D9LH5yaX4aPcRrMHa777ia7L3qs3Rg1s0zRyLhvfxRDhED7UIyUufG3D/bg4R2yw
	c/oFAg3GvTZRMeka+G8arM/QfQ12VqtAOp/Nzfbb9H+kFggRBQHOl/XFLUqqadPIeXVhotrF9x2
	4RVAqukPrJbxFjbN9vpI5eLyox9D358kST4wIR3PDCIMsjf/Z+EDD2DfGywp8jhIuv2C8h0bLHj
	aS2H8jka2VNvPH9BAGml505KOMKMCd7yF2WeGGeYqiA8Ow0t33nFog4gbUNgSocc+rKjWYNa+Ox
	RCfAAKjFMxAaQz2AW2u/shrL2gMKj5QZ4+WJS1ugcy973bsRGAkiZ4IW+Fusn5Iw5JBrjR
X-Received: by 2002:a05:620a:2682:b0:8e8:bedd:14b7 with SMTP id af79cd13be357-90f89668be9mr690867785a.22.1778697389597;
        Wed, 13 May 2026 11:36:29 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bab32bd0sm34033485a.14.2026.05.13.11.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:27 -0700 (PDT)
Date: Wed, 13 May 2026 14:36:26 -0400
Message-ID: <c759ac7dd982a61d78078371780bdfac@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260512_1604/pstg-lib:20260513_1343/pstg-pwork:20260512_1604
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>, "Jonathan Corbet" <corbet@lwn.net>, "" , "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, "Andrew Morton" <akpm@linux-foundation.org>, James.Bottomley@HansenPartnership.com, dhowells@redhat.com, "Fan Wu" <wufan@kernel.org>, "Ryan Foster" <foster.ryan.r@gmail.com>, "Randy Dunlap" <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH v7 10/10] ipe: Add BPF program load policy enforcement via  Hornet integration
References: <20260507191416.2984054-11-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260507191416.2984054-11-bboscaccy@linux.microsoft.com>

On May  7, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> Add support for the bpf_prog_load_post_integrity LSM hook, enabling IPE
> to make policy decisions about BPF program loading based on integrity
> verdicts provided by the Hornet LSM.
> 
> New policy operation:
>   op=BPF_PROG_LOAD - Matches BPF program load events
> 
> New policy properties:
>   bpf_signature=NONE      - No Verdict
>   bpf_signature=OK        - Program signature and map hashes verified
>   bpf_signature=UNSIGNED  - No signature provided
>   bpf_signature=PARTIALSIG - Signature OK but no map hash data
>   bpf_signature=UNKNOWNKEY - The keyring requested by the user is invalid
>   bpf_signature=UNEXPECTED - An unexpected hash value was encountered
>   bpf_signature=FAULT 	   - System error during verification
>   bpf_signature=BADSIG    - Signature or map hash verification failed
>   bpf_keyring=BUILTIN     - Program was signed using a builtin keyring
>   bpf_keyring=SECONDARY   - Program was signed using the secondary keyring
>   bpf_keyring=PLATFORM    - Program was signed using the platform keyring
>   bpf_kernel=TRUE         - Program originated from kernelspace
>   bpf_kernel=FALSE        - Program originated from userspace
> 
> These properties map directly to the lsm_integrity_verdict enum values
> provided by the Hornet LSM through security_bpf_prog_load_post_integrity.
> 
> The feature is gated on CONFIG_IPE_PROP_BPF_SIGNATURE which depends on
> CONFIG_SECURITY_HORNET.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> Acked-by: Fan Wu <wufan@kernel.org>
> ---
>  Documentation/admin-guide/LSM/ipe.rst | 162 +++++++++++++++++++++++++-
>  Documentation/security/ipe.rst        |  68 +++++++++++
>  security/ipe/Kconfig                  |  15 +++
>  security/ipe/audit.c                  |  15 +++
>  security/ipe/eval.c                   |  93 ++++++++++++++-
>  security/ipe/eval.h                   |  11 ++
>  security/ipe/hooks.c                  |  63 ++++++++++
>  security/ipe/hooks.h                  |  15 +++
>  security/ipe/ipe.c                    |  14 +++
>  security/ipe/ipe.h                    |   3 +
>  security/ipe/policy.h                 |  14 +++
>  security/ipe/policy_parser.c          |  27 +++++
>  12 files changed, 498 insertions(+), 2 deletions(-)

Merged into lsm/dev, thanks.

--
paul-moore.com
