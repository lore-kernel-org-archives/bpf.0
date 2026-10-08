Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317103CCA12
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488324; cv=none; b=Xord89l/KZwd+U7LgnQ4kPuinu7CewymztPYz5bqwHigaiCzJiBlzrv+rxoCaoMASM67o24WEjNHjFHkeOrhqVB05+/MUFg9er/aYVQIUxHLvrnmBCAgZfLFRZ+YTBfxPhfES8KX8Y8sxIDCfj8s7qTgvJYlWbzkH78N5IOBxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488324; c=relaxed/simple;
	bh=j1grMDLazOGsQeGC11PEDwjtUEgbyvSfnro38wh9lEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ng24I72QiFwvdgjPunOqUcWZnWiopO7dLm/147zM3H9O1SfK9vg5h5D52EWxwwPd3vhSTv8dHFSQpXKpoiqUN6OPPxFhlJWhqBERHYY2F81Nb0G0fhLq5wbzgw6c9Tg3orZsQWXmLanyROBYabJ28TFf060x+BV1Rx9cIFut2pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Epv6cwtv; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Epv6cwtv"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4949f037131so1882938fac.3
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1791488322; x=1792093122; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HgO34ewM3/AAqmWbIKVWDsugBSjlGHMPJJo84ws/m1E=;
        b=Epv6cwtvuKNZfe1t+dmZb4FsRMC0HKIrMpi1QQ6e7k05eNp1jN3HZUNAjRwhItuqRQ
         zu1CM1oobsahYIY8XC7nUSgI2RIH7KhB1Z02r0WgZsZFA5FPaYA4bxXWDZfLzk3z2Rmp
         n6UUT+mPb2W/h0Vwd2fekIYAnHdPupoQ376q7hcCnT3I1crxIo/FPtfG0/3Msw2q1oSb
         s5S8zenfQOBOM2pz2/ZGxv6EC1VSTlvQF05FE5G3HqYGA4mP8ke9pg55vhE5iEyXJUj2
         e/A8GlDyhBMKv36fVpMwmoDAwb8IT/kMvbjmxzGUKWAzeBDpOp0veKlPfhsSqaswIuxv
         D/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488322; x=1792093122;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HgO34ewM3/AAqmWbIKVWDsugBSjlGHMPJJo84ws/m1E=;
        b=xS6zZpqvZnSSIdUgv87HXlLHVKGkib1Z1Hm50MOM8DWV19GgJskQspXWeDolNvtH6L
         BDAIrOhnx4L+kxgP0AhaxkrsDyX9WSP0VVZ3oqzk8xRrIMZTCZ52zwL6SD+Fn0YjU0qe
         /T0jNmoDiz/O4PRX9ejHmvYAtlFj3pS0SUzvv64+hkOc1SzvGhPLgWbvHXSSRX1Q9Db8
         klyiFEmnkwqnCes4SipygzgqLrcpqZ+5azzxGBmsv8RDOM/mPrkQCGN7sm/FtKd02DPv
         hQXHtdMWrOPNHjpQ8IRL9l8xlYlrf7PXAnkuW9mK7NxP+O5oKBwjvPwyc7q+HDryJgU+
         nhoA==
X-Forwarded-Encrypted: i=1; AKwUvBzp9yjRcXIchaSrJfXHcU60vVyHtk03X6U613Su+46lqN21qAueAlGDIu0QcLGrdLL1tHI=@vger.kernel.org
X-Gm-Message-State: AFuF++lFP6Q6jTpTtLNtkFME8pzUr4nqkZhlSOITKLmwIfwRaG4bC9it
	vKf4lRr1Fj88uvp15RkkpSkJ92w0W3j+PY9kK3YgAWd4SyZCnqc8Qw3y4mW/l0b8VoA=
X-Gm-Gg: AYBFou3GNjW7noW7R0/QNXsb2y4dSIGSSzTZES22uMKo54D064i/mqt1TJ99yY/qd+3
	myA2VmPYEMmkKdbxkYdFX2vQzOF1ZJz8nfSQaanjeKbOwkYXO+pYfoduUahENZlrBlor0WOUVHx
	q0rwTcm4wgM+jwAr6KAbtRvpw2wsOaIMh+eYNkTWjcw0Hfb0qaTXreoRjqVzbkepaK9JAdNcBhF
	cKYBPxgQFwFm2eh3i6BYg4Ok86cvdD4NygnBBUE5aD1G+/TT1JWekXAa1+lDK5co6Sy2tu28HXP
	Is08YwGH4OSBlps8ZZ0dNWdvx06BfzcCfS3O08s42nBwi92FgTDCclKrkR6O0W7/GZragqD5Yiz
	X3w+nsSLpkjFtIQ9tHHzYFddO/xlI6FHIuVQJf0N3m1DSALTYme4QxYcA7YQHMCLrm35D9aaCVW
	jW47uj1CvanhkadeBXsIqnakCU1rLoc7l7MOF2vFXu5eqRV4AAewfBdzVFE4bo8pJXeG+jfAE6Q
	cKPiuc2FGCDMi94Cw==
X-Received: by 2002:a05:6870:b918:b0:47b:cd37:f931 with SMTP id 586e51a60fabf-4a2a41cdf21mr354311fac.13.1791488321794;
        Thu, 08 Oct 2026 12:38:41 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a43ca6d4sm428113fac.2.2026.10.08.12.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:38:41 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
 linux-nfs@vger.kernel.org, Daire Byrne <daire@dneg.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH RFC v2 8/9] tools/net/sunrpc: add svc-classify, a prefix
 classifier and its loader
Date: Thu, 08 Oct 2026 15:38:39 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <4AA1E943-B80C-4110-A8AF-97ED4697D2BE@hammerspace.com>
In-Reply-To: <ff8194ac4128f0c972545ca19fc696aa064e68c9.camel@kernel.org>
References: <cover.1791402701.git.bcodding@hammerspace.com>
 <158d8194fc5ce6d1fb8fdd1196f53de7d3651d36.1791402701.git.bcodding@hammerspace.com>
 <ff8194ac4128f0c972545ca19fc696aa064e68c9.camel@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 8 Oct 2026, at 14:36, Jeff Layton wrote:
> The userland programs in the kernel are often not packaged, so it seems
> to me that svc-classify would be better integrated into nfs-utils. That
> would allow you to more easily bundle it with the systemd service file.
>
> It might even make sense to integrate this functionality into nfsdctl,
> but I guess the classifier affects all rpc_serv objects as well (e.g.
> NLM), so it may be best to keep it as its own thing.

Technically we don't need this classifer, we could just expect that if you
want to use this feature you must write your own.  I added it to make things
easier for potential testers - but it is limited.  For example, it doesn't
classify on anything other than src address.

Ben
