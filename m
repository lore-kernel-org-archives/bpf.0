Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77BB347FF8
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447039; cv=none; b=mUu7t21kyEQuVH+ncDZMuKPCA0u9Bwf0xv/9ZNIzoLXAbQ8YXUP5bw6M8FjcktjgmeoV6AvtYL3BH06lfyaJ061xaibUH8Vzo1vW87S+99F/BHw1WiJWSyhpNmwM2XldePtI1DbpulZS9mZ214zF/+D3sYW0sxLpuJb75Qc8JOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447039; c=relaxed/simple;
	bh=GQIB8nrY86Lhzi0MUqNtqkclCgvWW/F6ruLh3K0eT0Y=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:Mime-Version:
	 References:In-Reply-To; b=aN1SSoyVAzS3kFvCsqqg9N7XHXcadxwqvJGHsdfF1rFnODWgDY253I5H/eOReuOgR9jFQ85WurCCqrkFVRhbGzHB9n9WNkFDSwXbDlD/uAFfg5pEyAG+z9V4aWCm98I/jV0dSXBb3xcfHzMbJk5vCyfv6AzgTkDxcVUeZnmSvRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaZBBqrH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaZBBqrH"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee07570deso36607815e9.1
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 09:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769447035; x=1770051835; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version
         :subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQIB8nrY86Lhzi0MUqNtqkclCgvWW/F6ruLh3K0eT0Y=;
        b=JaZBBqrHQxc6qQSMb5KdaiE+S5dH5pSnWY7v/DtmjK3/NTxMwe9HdYqT+XzX3+CdJg
         rpkWm9lc78cLD50vvfleefeRiwEM5GrrQTMKGWz2S98yVu6zmnPeHjNJN28BR0b706Cg
         hZ+Y3ljAFHHLyKmmkThG7Hv+0eavThaeKiBXIowpm0gIZ7NhWGYxAM7d2vSAPLf3Y1Og
         69V8lX7b0eOrF+aRSMw18nFKRfn2eZICS4OG2/NvqEPvMuos9gz2C28MOHWiJh40M3zd
         LFCeI1ODcdJfpc3HkQhDFn2CpYTNF6nxL9s4G/zuZxwyMalMDg+TkTvS10ovBu96nmCS
         iZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769447035; x=1770051835;
        h=in-reply-to:references:content-transfer-encoding:mime-version
         :subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQIB8nrY86Lhzi0MUqNtqkclCgvWW/F6ruLh3K0eT0Y=;
        b=QBZq55bcFENQPRMLKnFNlAzZfVZwJORQsLzHtK4ysS8aA4QWtRwJ8ShY6RDf4WD7fp
         ut7LlOeAJvhy/trCf5iAnvKAxHv33KMZCM23GEw/UydZUy9oB9Iv1OqV5Dv35DuF/tX+
         XCH+rvRnY9/zi3n6f8De/JMqVl0DfY0SXRUt3uQtbUTeh/hZrEK82sbsllwllVX4yICL
         loejC+570UKKWATAvDBxeBGLpoIRNlyVytQrClN3lCu0hhwOuKNvPiXXU3y/pS+geoCQ
         Vu7uu8SGEeQkGUaHl2JkN0Jdv4egkEVcCRgP25sLSPX5eGPrv30ju4/MEYKD0YqbQSZI
         4k9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfzqbR0Tv/dxuBjBV8VI5GjtNjROlqBATvhBPir52BbRhpxZfdqY8Y8gKYCAZr0Xj5EZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgOnfqshlLit5klchQAdeltIUP69MVUjQWKNZ541FXIT4RV871
	0fBNVQVdByKk1On0kXY9aFqISmUm1nD2o4HkXtWJJEUIlh369zbaDtF7
X-Gm-Gg: AZuq6aIMdpoyQxM720WataOkmsmsguLsfAIR5d7IEsDh18Cul0wHALwQtzxbRv46lZJ
	y77PfClRKo6fcxqATsirFClsz+3GZ7oYGrpH78S9ipkVri9kSjYpNOPZ7Chp9rPRPV7xbnIDnoK
	gBcJuWZeoMa23o2hYuGuLeEMt/bnGPXftHLVD60724ZM5PIzSJbgUYRjoD8FfMrjyuGQR7phU9a
	nv7OQxA1RA1n94RANmRwd0+SGJ9AiRDaci40qdSeW82e7DTQMsXu4WeMr/sMsQHhKQpOeLYkSoX
	a5KG1vvB6uT5mUKOnlqruepNUCNOX6MnVPQLzJ9mOC+pTdzcji9eDB/XVNHaNDN7BnyZK77C/P3
	fQdL754C2i01kvxxueSGIedSwHK7fL1Iav5cWgZ6WMEpdCu6f0oVKWCmwgqMshg1GhwieLR+t6C
	bEpTWUOZsHqSICK5O7Cjal
X-Received: by 2002:a05:600c:8b55:b0:47a:814c:ee95 with SMTP id 5b1f17b1804b1-4805ce3f9bdmr81206435e9.12.1769447034663;
        Mon, 26 Jan 2026 09:03:54 -0800 (PST)
Received: from localhost ([2a01:cb16:3013:f686:9880:33dc:3c70:30df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bf7c58sm1615445e9.8.2026.01.26.09.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 09:03:54 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 18:03:50 +0100
Message-Id: <DFYOMG792VK3.2QF7I24T5GQQN@gmail.com>
From: "Guillaume GONNET" <ggonnet.linux@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <john.fastabend@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>
Subject: Re: [PATCH] bpf: fix TCX/netkit detach permissions when prog FD
 isn't given
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-8-g985ce7a92be4-dirty
References: <20260124214328.185113-1-ggonnet.linux@gmail.com>
 <4cc162d4-9d19-4406-a93c-d6dcdf65f55f@iogearbox.net>
In-Reply-To: <4cc162d4-9d19-4406-a93c-d6dcdf65f55f@iogearbox.net>

On Mon Jan 26, 2026 at 2:24 PM CET, Daniel Borkmann wrote:
> $subj should be [PATCH bpf] and as the AI review flagged, Fixes tag would
> make sense so that this also gets backported into stable.

> Looks reasonable to me. I looked at the other types as well, and as far a=
s I
> can see for all the others you need to have a valid program fd in order t=
o
> do anything in terms of modifications. Similar to BPF_LINK_{CREATE,UPDATE=
}
> and BPF_PROG_ATTACH. This assumes you either had a BPF token or CAP_NET_A=
DMIN
> at the time of the program creation or the correct permissions in BPF fs
> via BPF_OBJ_GET. Anyway, I would change this slightly into the below give=
n
> the above makes assumptions that the detach is always about networking
> programs and it might not be in future.

Ok, I will remake the patch integrating your suggestions. I also did
look at the other program types and maybe there is also an issue with
CGROUP program types, when BPF_F_ALLOW_MULTI flag isn't set. But you need
a CGROUP FD and according to comments, it may be intentional to maintain
backward compatibility. But I'm not sure as the commit af6eea574 with that
CGROUP code is older than the one chaning BPF ACL (c8644cd0e).

Concerning Fixes tag, I will add one but refering to the right commit
that introduced this detach code (e420bed02507), not the one that I
mentioned in my first patch. I will also use the AI commit message, which
is much simpler.
