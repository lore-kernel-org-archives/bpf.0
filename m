Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FE2466B4B
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472689; cv=none; b=locFRasIZ2T3wZVQBtqEg2pcrFyItqxZ2BZPDg6kWSDerbDhg9jEU6DW7uXfNFfOAXPX+ZZoZJ17tR4dDWw1NxDbJLtKEmCRalVF9bqF27IcBHZPXOBhRmEWco2oVhyvRvLaIUUIH1sxx9lRvSbANqz3HfbIN+btYQfkq4os3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472689; c=relaxed/simple;
	bh=EsYSirkksSn6rulULilTXBqiYzl0gtkEyeqGrogkQcE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dhoKxr86j6NQ/ceE5nmrYcYWGXvo2N7TDF+W8plKiSSITlP2eoOFHM9c7m/In3ElCJ9aK4baolRAiqNN+yEaBDaxRkLXjhVsa40Gu4FQMeEOfm5YmRMJ9LlhLUooK9dT4ON/HCMxBBaOuoA2kGH9gd1J1I2H6NcJXForMyeFBj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qnh3/X0N; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qnh3/X0N"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1c73645a1so414678a12.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 14:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788472685; x=1789077485; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EsYSirkksSn6rulULilTXBqiYzl0gtkEyeqGrogkQcE=;
        b=Qnh3/X0Ngf4A5RCU5AqreMpXK/n+t/WhduinIjXIJ/b1QRfCsO/N6iVwOdXOfGH+nR
         YtTPvqLeQl458kEhyEQl8o2fClTyFr1ioPXSM0HPdCagF6SZH1TIMh7fakp8sBlOdgn/
         Kb6RVDLJWncLsgvs/iS/f2rP6bgtaE9fRb6X4mxDQRqsmPZ31KMADwb4iNxRUaz76N3X
         KcsKO+ERC7gVDAHBH+ann7FYziIjPNAW6zNDLhyUDoek447Xoq/bFIjUlq9ThVXqatJt
         PWHzei7+HnWg7Qv+HTS51pyDUmgOBupDmlyXXV11+KCH+cICKNibEXc9dX/RXp55H96P
         ofEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472685; x=1789077485;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EsYSirkksSn6rulULilTXBqiYzl0gtkEyeqGrogkQcE=;
        b=IUNDaUT3eD4KX9mYc1I8Q7rNJPl/+a8wjIc/rJK25qsLJMCZhALt5tz6eQhITe/vMf
         d0ctGxAdlkzv8F1SUoJFxdBlgYOtVbw7yDws9vaf08ieqZbQRBVhQ4FRYmJ4/80XroUI
         Y1wMIn7alVHbUn88bmWQfWC2EG18AL08gyIl7g+AqKzRv8Cc6+9gNLN0+rOabFioeZbi
         WmYGCNP6ZQ+1T5IMA8ls39c44Md+JjY+x8riZE26DVYKBYqBTlRMI07HMw6kNUUCJs7L
         7BiafSSpXhQIOLqJ2d+UaSpZdrDcrl0Nz0c+VbyD+bSlX1SUzcFYtjWS34rSKViFd5A6
         wMiw==
X-Forwarded-Encrypted: i=1; AKwUvBwv6OFyctT1Bk2GF5xz1/3ZIJmlUTXkbz73CtRWWtvLyd9pX58GhE9PvOmSTmpUHdTIDik=@vger.kernel.org
X-Gm-Message-State: AFuF++nDGYCddmecF/brV2HQg1I1Cd84RLdOmbg137lQqyXkSh+JZNaE
	HECmAJIGhJ1QvqIMY7AAXgVwRKBLD/d10nme3AkHKsSWofcmAXlvf4zN
X-Gm-Gg: AYBFou2GgdzxNGsS2nYRaWD5ytpnFL8cqYR7wtrBf75H9VggsqGgUX4Cn8Tk62mXvtF
	NJ/DULJRULEyE8nYJ1JWdCV0gYtzlxR+gG8zGck0LNSskNpY4VAFf18lee8s3QQHFB4bsoMcDO3
	5tcEmWR/IsK+18HwC18zGX3C6IxCQy5n1OUzGg5WVkJcQlxW8Xk0Uq207V1bi4dVrLbQ3P1Pnu/
	Q9rV/oeXU1OkJxxTe0isFbhZPQSP1SYaBMlf+r15Z/w9T2Saj35cWF2eVZxBLVfALzj3T9e4+xH
	qnBPistk0BR7LOHuayVPld7q8Ro+HD64mGeB5t48KEBXkHV3mehCpqUxC7piS8vrpPhha7MPxGK
	HmlcaGgVmNZB304uxX0rMl2B0JR2/6oIvm7VtmW93wvhfOBX5zN07/rWkWpx5tg+ArCTpyo4zzJ
	xBHVezrJa9z+D7dMBKof6Z1hdgQLmSgQYp3BVeCAwd2c+q+b9zBff5dTYip8wS7df8xnJ+ajsmw
	WARGq83MNYwrB7PZyRWGRs5FGDO0KzyiD8SAN6/6/rjsg==
X-Received: by 2002:a17:90b:578c:b0:398:e6b6:acc2 with SMTP id 98e67ed59e1d1-39b261e7649mr2503285a91.12.1788472684826;
        Thu, 03 Sep 2026 14:58:04 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fe3c:fb36:dc7c:5b5? ([2620:10d:c090:500::6:dba3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435ec2bsm1785522c88.3.2026.09.03.14.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:58:04 -0700 (PDT)
Message-ID: <aa58bed78ecad82b396abffbf512f66891c2e2d2.camel@gmail.com>
Subject: Re: [PATCH bpf v1 7/8] bpf: Reject legacy packet loads from
 callbacks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>,  Nicholas
 Carlini	 <npc@anthropic.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 03 Sep 2026 14:58:02 -0700
In-Reply-To: <20260903214758.2727663-8-memxor@gmail.com>
References: <20260903214758.2727663-1-memxor@gmail.com>
	 <20260903214758.2727663-8-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-03 at 23:47 +0200, Kumar Kartikeya Dwivedi wrote:

...

> Global functions are verified independently with a fresh frame zero, so
> an active-frame check cannot identify a global function called from a
> callback. Also check the complete subprogram call graph during stack-dept=
h
> validation and reject a function containing a legacy load when any caller
> is a callback. This covers global and static descendants without making
> has_ld_abs transitive, preserving its per-function BTF return-type check.
> Ordinary uses outside callbacks remain supported.

I agree on a first part, but why is this part necessary?
Return value from a global is modeled as an unknown scalar anyway,
hence ld_{ind,abs} short-circuiting it to return 0 should be fine.
Forgoing globals cuts this patch in half.

...
