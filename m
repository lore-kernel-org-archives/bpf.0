Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75214E3230
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473315; cv=none; b=lVxJC83mdNC9wCoPnRTWxsA3oClsW8agkEycERXdXc0c24Kzk5IRBR4E9Cxxu95zN+2ZZNG/tzATgTw+IlK3uTbHavHuGpCezJ1DlelFG9t3WwX1l7L7IHQXd6NwAyNFNnExXe+b8b2AIjPMb5/QNS51vvZB1MPV2LevbYQy99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473315; c=relaxed/simple;
	bh=xPIkTrWXwRX0CL0W0fiuITjlLJD76IEIwGpDkmWc6Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDr1eduSnlZ3Va1Gl6uY/CjscFLdFUBiS4XXW5FpN48CT+ITiJ9GsNoBs7RhOE+BRiII8JozrjQ0bGVrBSjYkOtEcSZT4TNmQrVJWkTz9ys6qlb3/ubi91klmDh4gSL2U/I4w8gwAGGmXxhNb+NM7y3FFpp2H0JCilIwNLyIleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=FvJ8yhmN; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="FvJ8yhmN"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-821b5c73292so2729392a34.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1791473309; x=1792078109; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JOmVZUV8dWCecF0YjRXtl3pU/8WRFPW/xw293xIwNYM=;
        b=FvJ8yhmNscRIVTTGBcMxq4Ao90blQdAMv+RKihE2eERsYTgnuPHGDERwTL13F31Lzq
         BwLwyEUQ2/iNG9fudW9a5l2YeRAvtitMsxu2/RXcPUOfwg3SVC67XlceGH/qEJAR3b7a
         QNPteWXKm6f8EGnzc6NDO6IfL9f8w3qBgvQOonNpV/owN5gTSAERBVIJEf+0L8wsBvIq
         tL4hAMdb11a6fAxfQdyhgk3d8UH2S9P9MQbk/khMBjiHIS7jxE7qxcL+EiIbmKEAfM6y
         y8jETrx9LZevF+oRqmwfYB1vuPytgS8L/13n5g8fBJeyJfrKOXKnSWBe4uxSYRj9m8Gh
         jkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473309; x=1792078109;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JOmVZUV8dWCecF0YjRXtl3pU/8WRFPW/xw293xIwNYM=;
        b=yFnQVwflxWZ/QSoRa0N1YBrctrBydhu2Cua7GXxugI1Lmv9dA6yUYoynS8E906z8S1
         MbEdZsSaCE0YQAgzdd/zl7zjQJ29URaCv0FbaUSqH36BV4P4cRO005H1EAFuJDuMn8KA
         tvOzbNttn3kHT/Y82CVVSVpI5m61U7hM1rLi3JR6ls8hQY7xzuSdxr6Kb5PqfDmd1eMN
         Hot8F8NXqQ0Z5nyb1hHUdaGgk3XktUY1Gff4KvQdLTd3CLKScjB8we+XqE/OcHsNeztU
         Ln/aSzsQfz/eW5PbGgAYrX1J53wYkA0NlA8mFQ2UMJun2CM0A2CVvVEmiQ8yukquLMVv
         q09g==
X-Forwarded-Encrypted: i=1; AKwUvBwCI2FOOzkGHgQoDCuBUm80BPstfdwFx1jN/5H02GTxIXkvaclgDOCScTQCLI1dWskdHbg=@vger.kernel.org
X-Gm-Message-State: AFuF++m8jBgOOTvEe0CL53ohLuE70u9IiVE9QhkvtUTCQIpu7gxd9cM0
	1Gz9L55XcJnulgFvZH5FvEutUjEZLArIyexcvQEEeVwkFknX0EndUDQ8x8bd047undo=
X-Gm-Gg: AYBFou2uIod5DICK0lhhLjC2W610ILTJ+8So9cysshfZax/InmMKPZraGu/TWFMHXXp
	q5dj2B/c8PxmeU/WXRVozcDba8Vcs06VUuzrFVpUIJojZjbnak9AXTEhw2eJukdXDKWlbBD1enD
	zLkFDQbRtpAa7gu6ooyqQ0aVTWyPwbogQCHZoGYmO1jCO7bjzjk3l1GKtgu/Q0/iRVCCmFka2ba
	5PWUqBJNayMPYiMpT4RY2yJ/dBR8lkqde1xDDcgiMi09Qq7M9C1kf/QobdzmJv/mMwdz+sgqjXf
	J23MZBYC7NSA8WDMU0y9B5i5TAhcIrj4PZ3zGaBfOZQM6tSlF7v7YgLwlygYCfg1rf6i0ebtAiQ
	dQEIHrrlimQDqxOsXs2kT6ZoVQBO1a1tSJMLxwv2jROo7aouHnC88Xx1IIuITvC06LOrde9dtri
	CxjPx+wLAdZBxP2RNMfZFAxE7k2ytuHjslP980DwQkmyizdrNHA7hosRP0aqU0bT9awKz11DY01
	UBNM5ByhQIQpBraMw==
X-Received: by 2002:a05:6830:6d24:b0:822:b35a:a2d3 with SMTP id 46e09a7af769-82acfbb2f63mr6766567a34.9.1791473309431;
        Thu, 08 Oct 2026 08:28:29 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82ad9eeb5eesm5901841a34.2.2026.10.08.08.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:28:28 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 linux-nfs@vger.kernel.org, Daire Byrne <daire@dneg.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH RFC v2 0/9] SUNRPC: dispatch ready transports round-robin
 across clients, classes from BPF
Date: Thu, 08 Oct 2026 11:28:26 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <D87A521D-E15E-4E87-A467-C73DED8ADD05@hammerspace.com>
In-Reply-To: <5f226738-0062-4e78-af4c-c68c1433e1b2@app.fastmail.com>
References: <cover.1791402701.git.bcodding@hammerspace.com>
 <5f226738-0062-4e78-af4c-c68c1433e1b2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 8 Oct 2026, at 11:19, Chuck Lever wrote:

> On Wed, Oct 7, 2026, at 3:59 PM, Benjamin Coddington wrote:
>> This is v2 of [3], with the change I floated in that thread: the kernel
>> no longer decides which transports belong together.  By default nothing
>> changes.  An administrator who wants peers grouped loads a small BPF
>> program that returns a class for each accepted connection, and the pool
>> takes turns across classes.
>
> As a quick response to this posting: I'd like to hear opinions from others
> on this approach rather than just fetching it straight into nfsd-testing.
>
> Having patches to mull over is great. Thanks Ben!

No problem, thanks for all the feedback and discussion so far.  One point of
trouble on the bpf-list side is their CI bot can't apply these patches
because there are conflicts from the nfsd-testing base.  It might be that
the bpf folks won't even bother to review if their CI can't build it..

If this goes further, I'll rebase a next version onto something the bpf-list
tooling can handle, then back to nfsd-testing if it looks like its mergeable.

Ben
