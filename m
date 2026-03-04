Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76335B64A
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638867; cv=pass; b=X3Xd2GR9F3K9KmJUtryxQ8tu35ad0xjoR6Fmt5AaJE0hTFLSTOMqp3cpPc1U93Ec90aBkGGLcedx8VoC9XoZiwtneKyoUtYYR0aGhPXNavxgUglruS3ROYwAinGPB2MJ2usHNOJTEb0pI2np9NdM0fPHqHjBUKilOugEjZUHttY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638867; c=relaxed/simple;
	bh=eXXO3JvNT25eAlvx+ZS1k4YSqotW72Hu288sNSHskyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEWt19jC3twP+nhUzd9AOngG2Xs7nbsOdkN6riw8TWISB+179O/nff4YFzrKgL5WzB8RBXK5YSItL6UGLZ3MPHVNxV+qevZJWgeja+Y6XC2dEkP0jBCnqZMdRUyMIeAuJFG/7tNqD1qU3dGM+8619szWrMlmPkMzFN9BU8Qa/L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGeX0ZUw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VX4E+8/I; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGeX0ZUw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VX4E+8/I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772638865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXXO3JvNT25eAlvx+ZS1k4YSqotW72Hu288sNSHskyA=;
	b=AGeX0ZUwKczB7D8YHnlQFT28jg5hHAnZO4nyDEjvlY9rnjD8cKfpgSCRJ+W5uDc7mxX7OK
	jQ3NPVUZGGkAH8yofN1ureX110b9pRAuY4vmV2Py6VgaGIlt/dx5cmQyTNEGO9NtuIsDDy
	mYIiiPfEWOH+EWHyzp2GiU8YhniaxN8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-mZAJ7hJRMLiP3Mv7SIdA8Q-1; Wed, 04 Mar 2026 10:41:03 -0500
X-MC-Unique: mZAJ7hJRMLiP3Mv7SIdA8Q-1
X-Mimecast-MFC-AGG-ID: mZAJ7hJRMLiP3Mv7SIdA8Q_1772638860
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b9399d68111so475397066b.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 07:41:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772638860; cv=none;
        d=google.com; s=arc-20240605;
        b=BDQSBGW30IUU8CNAduolI69Kv2FTUrBuzYKkKOMNEz4KqlxtdzXxGDa1yoLw8QgKUA
         nFrcKZAJAlB2K6so51hz/9Fp4bNTqj6ARW2s536CipTeakbFRBM8LuwuijHOqH2nZJ0M
         AndEHfW6RzGR2KpmrVCOXGBvzIViDSLvtxZODgWj1qzos/IPRn+rfIfHJDljE/q2kULQ
         V/KtlKc0YR5OZBjuRNFWRVBDiJH17QND2YrSAv0wbYh3qUa53P6gEQHXscOQl/gwiQHf
         ITtjVNN4TKa4M7vmvxLMOtaDkOkMNAL/fC7z9jT36CWWnU0FgrS0523W/umAKKecH1go
         1K1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eXXO3JvNT25eAlvx+ZS1k4YSqotW72Hu288sNSHskyA=;
        fh=FUzzwAqgzwuEx4UEdkC484LEpBcWrbczJgcyRdhT9hw=;
        b=TwGTaCDdagXzyVpxoQS+5/AWai5W+dD7fVYtcFBwxbg+8WdHv5Ou7vyorJ9/QC4hX7
         U52Aa3Pb80zqkfKPOqzymJ26qEWAwaImo6PhqR7I9H22yhXMEV5HR62DWfabXLG0Na4U
         0Ic9wzTguUab4+Ylk49Z6JhxQCb5G6ehXrcGGnuLy4C7wBPStF6H7M6m7mhaTWhaMJKX
         uyFlLZsJAku/a1Ou94VkZlutzRzZS9oWZkLT7EkPDnAiQNu/JYDwl+sXnDpsY8ShooHK
         ziIJkW8s0rCugkEaeWS1J2vqwzBVCO6gLs/l56u2+xpaqJfUjHK9+IvwkQaKoV4Yl/vD
         fXEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772638860; x=1773243660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eXXO3JvNT25eAlvx+ZS1k4YSqotW72Hu288sNSHskyA=;
        b=VX4E+8/IOXORodM9ynKQgOH78y+h6ZMld8ho5GvNLmp/ZZgi34ql8u6fnlgQc0Bi9m
         ck17UHSJaQbcq7h104BFcVphbzOcx34C5LqFynbeyoo8uT/mhE97GdV/kYf4/iqwU0Jy
         6dGmbjUrROjWV3vrCFzCJAPjmDHAtmZxwP6BM/yHFtHs5wH7uUxF7YzqRtyreSWAIJQE
         4vnDmY5R0RPdarCtnlc+8a2Jn7isYZxgr+FeX9MALUYBf4zLAr4B91JZ/1R8gTS3InSL
         ZjnLS07WtsCUXCir2sIs/wwgYtVvO0TFM0zA2z2LRHQxAAjpy4OR9NGJiDASPCOUqcrO
         N6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772638860; x=1773243660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXXO3JvNT25eAlvx+ZS1k4YSqotW72Hu288sNSHskyA=;
        b=CBg3PRtH38vCNhkVqK7uT8cud9K3lbTSoZ4Hu8FvXwUOrNAIC6G3fRI031cODPJL0R
         ml5kNPOIj8CLaG8r1pXPo87b40C5vnpw/oHMWAM9Gq0sxfuxnquUuUr+iQbR0IE1x7+5
         mMXii3Wv7W8oiLBmrrzKJMBKRqY6stlH98k6NFM4FKnoteP2WtlYdWkfltWh4e63AD+6
         EwmXAyES47DlhIyaqdyq5IUVDq4GB5WNCp/kZ+Mx2cO6IY6vAboRZv7Ois2zhlpbNynt
         i7uyzF/AlH0IzTBZAA5aYjCCC5XBMNd9vb7aVZ3q2IL4Q8pSKgV0qdY11X36/Z0/Ez7T
         Jv9A==
X-Forwarded-Encrypted: i=1; AJvYcCUfTfhcx5kGq7Og0vWp3pwZx9Q/TWm8ZJRr7ere9/I8h/es8UairwymRbmWvSjZaC/egIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRYcR7Q0NrGkYL/8WojHMjJ9F6zZN+/9LMaW4IdKbbAlnTDuHc
	tcnX1PkjXo/10GkNhcAAVDelJMHaceJqQ2uVuMEYoKepm7esHvmjPjlNYyKURpZnevEMZEm2ZeP
	LAGQ4cPGSkPsYDxb7VR97pqeWcSfaGte+Td0tDkH8XpJeIQcpY7k6dVMwHYX39lvbDx10wXWJ9/
	UJ+dSD4PynkNzQoxXl25mjZfA+yX+E
X-Gm-Gg: ATEYQzy+PLOgOixdbrEue5GFLjXC5XzBuJCTUAECBqxstdMjaRHagL6Yt5kHwLCmicb
	ZiHsyQufOijbZ85kD2sd8CtJ+vbMSrss7YF/EqdVSgrkUhh65JWdKt5AVbLv9z2dfCeUvm0N812
	N6Y8UDIwDc42K8Fyu7KMsAGy4oCg2XppxVTdKhkOCMjECibTelp8eBdG429S5h3Cc7CF+UBDUZB
	iwcc3WbpWRXjlsfJNWs/5WaY1Z6QUav3Y0zaf8=
X-Received: by 2002:a17:907:2d87:b0:b88:5158:d106 with SMTP id a640c23a62f3a-b93f154b56dmr149630066b.52.1772638860353;
        Wed, 04 Mar 2026 07:41:00 -0800 (PST)
X-Received: by 2002:a17:907:2d87:b0:b88:5158:d106 with SMTP id
 a640c23a62f3a-b93f154b56dmr149627166b.52.1772638859819; Wed, 04 Mar 2026
 07:40:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213115234.430232-1-costa.shul@redhat.com>
 <20260213115234.430232-2-costa.shul@redhat.com> <CAP4=nvQ8xFr2mD4z01e656hfE9btiFRu8xrqHiR0zGkDYsiVSQ@mail.gmail.com>
In-Reply-To: <CAP4=nvQ8xFr2mD4z01e656hfE9btiFRu8xrqHiR0zGkDYsiVSQ@mail.gmail.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Wed, 4 Mar 2026 17:40:24 +0200
X-Gm-Features: AaiRm50Tx4kP75HvOGffhYU5EKa7DmQTxYEcq3WXv3ktKFx9Pt5RNfV9InaLVl4
Message-ID: <CADDUTFwD6i=JJCSSndFK=XHG5YrL3gnW95EMQEQmOM9HCs4tDA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] tools/rtla: Consolidate nr_cpus usage across all tools
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Mar 2026 at 16:59, Tomas Glozar <tglozar@redhat.com> wrote:
> This should be updated on top of the unit tests patchset [1] to also
> include and initialize this global variable in tests, right? Without
> that, unit tests fail to compile with undefined reference.
>
> [1] https://lore.kernel.org/linux-trace-kernel/20260119105857.797498-1-costa.shul@redhat.com/

The unit test has not yet been approved. Which patch would you like to
approve the first?

