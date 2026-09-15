Received: from mail-ej2-f21.google.com (mail-ej2-f21.google.com [74.125.228.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04813C141A
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.149
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502298; cv=pass; b=Qq2UgEPDQp013LYL4xs0znTEC3sER7BTWsdRGhpXfNRUR6J22/WCyApzkdscG9Q01tue8gfERY7noO0t38EpBketXGxIYEZBC/M2IxsCCP8NYEtRaK8AiEgf4fL2D8OwWHp+/eQZyreZKnV7NGcqVTPI+5KFPB64defFY5zG6I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502298; c=relaxed/simple;
	bh=FAzpqMwwi6sl1VtdlXZIoUcU/qbo27j0XppRaT5WpEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qn9zFNhajN2rhHIeCx7zW4GITSTMvycuMklUcNNUKETrJLNd9W+Tm42c6+z9Jk3btR9ERmisdvgz6y/n65eLfzjvSutvpgXXGHL+nwIgJZ81TqTHO4z+KJzWwhMSadfOvRX3Gr9sVbP9+ziQrDj583H+iDHOk/oLoMRArVwiEQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HikUK9bw; arc=pass smtp.client-ip=74.125.228.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HikUK9bw"
Received: by mail-ej2-f21.google.com with SMTP id a640c23a62f3a-c254fa663c2so28409966b.3
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 12:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789502295; cv=none;
        d=google.com; s=arc-20260327;
        b=sdvaBdXGStOL1cgVWwnuUzryK5vAtJtrPFsXba8t6b9H0jShpe9nSSpVHr8BeCmDIp
         njbbA3zT+cE2yI+hR+Nh+HEYi1uWTDsKQnHyl/gYZvbDIKnxMMScJ5GOSq4+VJoMb6hZ
         7bqnxjv7FxKJNw+1zjbRzjrsPCCPxY6ZHej9xb2COHQfZ7BdEQK43x1xtCyS+UUN1egt
         I0DarO8sNCJ0wBRg+xvsVRQjd/gwQOjY5aXW5uwN1li6SXNHeh3hn6UIjTv9qwSVvwKV
         kbWVaNMwN0rII1cUa22hM9Y0AFzO0HfY+4mizP3vbejH7Cx7CksP3+xihIOFGh0bXrvZ
         KkFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VgDjIW7K6yfw9H2uuq39mJuCV9xfXKip2q8+G3ZS+/Q=;
        fh=B+XcVQm/ZcvzeXhPblIgrjVFC8YoBNNUfIYcoZbym18=;
        b=sAz3JcW6NBEQhFK7Jqe3ptovir2tk3wHn87BTUsoTfMUrcO+MmBrGPyxa/MrGyr8Yt
         10WiRmb3yZsNiOXeaiXd0yA645tjEaqQrJgDj4qDpH/8+Z8xmnvLCaCJvZDEGet/XYtu
         jVCWEYxZ0U5T+qQFdx/oBP2AdITF+Lb/IVfAFVMXldQdrCFu2VUwZV7cndi4I9MpLr80
         JWzXWv/uNPVaCu2L4CcOUzJ8t58AdoOTFD5ld8ceeVa7FXvu8QbAYSSBjJ9iVWOSF+GJ
         26hmKJ5SpyRtG+fM/Hv9EIrN9t7HQ7xke4jdZH2sDcGmEwoURZOHOfxoWeMm6YFpVbcQ
         rUKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789502295; x=1790107095; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VgDjIW7K6yfw9H2uuq39mJuCV9xfXKip2q8+G3ZS+/Q=;
        b=HikUK9bwFipO7qeORpqKUhq/UGbHnkvXJ9iKuc4JiGJ+MAze5OqHKubqBOaOuAvWnG
         gIpuqCaI9uwqxYXbgyDaQkHfKfUJuxLR+GJ8o0XeR4CVZGKBei5RhA5f3ZP9ywuAdYDd
         X28ATabr4ia4s1N47mnDqdJ719BBiKAizUbeLbEE40tEJ9aqziVn1uX7v9n4WZ0KidEl
         980zf0r0d6ECTUtNI6LAO9UnhTlK8lf/xpT6YabKgke3QAg7JVyltx2aQ5kfeqyRURkP
         EPBA1Z5eKGYOsyTk7feJSg5tMu0EX5ZY8GLCmjTVGrE0LksHcJayLBh1+j6PQM+hEVjM
         2xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789502295; x=1790107095;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VgDjIW7K6yfw9H2uuq39mJuCV9xfXKip2q8+G3ZS+/Q=;
        b=tdxby6r8zq6KU/kasOKH31IHK2xcqpkUOnvCQdOj4JlSulVy+FnhTBclNKxyj6FNy+
         4oievzv7fDHSQFGPmFcl7XAyUfRvoO0HyTEAY9M7CfR2ZTUohpaERJJMe6/mZ6FsqBIK
         dxw88QIxaC4G/+abMQSR3fdLlWJF26uqCxsrjpTcqkFIx76FFNHmjHERcpSVO3aG7GG/
         ROJ1ezBXv/q//Qif96v40etDZourLujz/OvoFszeL8Zadih+jJO3tH/jreUAIz/ymn6h
         fYnSR/SqGy8ZZKTbaVfTneONOJLIRvg7H3kDfR1Qshcz8y5sGWMn71MUHxUdmL9mQvJc
         DxyA==
X-Forwarded-Encrypted: i=1; AKwUvBw2mZGBNukvhjA7kSVdvgZvHtRK/vyCYFLsJUn8063aRKR/wVZpmHveA4u+12KZNyPVf0Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lj1c9c/YxPK8g3d5v2ZcYvcaQElLCtPU57TZxf+V6VQNoZqsSp
	JAOruz09aKzj+F9YE+Mhyx4aEyOgKT4NH104KGYaxtj8F3zxzsJBiMdRETBcTG1Y0U7+rEHnqXx
	JDbo2Q48/SjQrX1DG2UVDkuMDzqsRhdc=
X-Gm-Gg: AYBFou3DnVqQg/pBEKXiEDlJ7V2gLhqivtk31ZmZ/G4q9zTKHGaMMWmC7E0R43AOxPR
	XDiOywCGXXYRrNmN+6IsmCitmerqKMzFUbtrBDAxfDeXThfBgy/ZZvT35RgF48TMf0syPxXZBAG
	P0vBOkhAHrGJZPHM1kJCu5Z51B2RJxRDFgOaXYEJ5c7HopeqzqNlkoayu/Ge/qhJgALSZKsbCFL
	86K4uWNdnrVUBvr2SpT/DW+MdGXrAc8wBPopUKoDGjKNj4XQbb2cJNs6xJYmd+XfjZHBYk3W5cJ
	4fFJgCR+eyWjxqlZ1dhLoDQTn3K/dR5wBPWMDvVBsllcqeYISRoVTg==
X-Received: by 2002:a17:907:a089:b0:c25:c7a9:7b8a with SMTP id
 a640c23a62f3a-c29b86b80b0mr897677666b.12.1789502294655; Tue, 15 Sep 2026
 12:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915022905.1535566-3-main.kalliope@gmail.com> <491fb0b335c0814e914b3d041b8cee9fda122c37567bd20e456fd3758fb51568@mail.kernel.org>
In-Reply-To: <491fb0b335c0814e914b3d041b8cee9fda122c37567bd20e456fd3758fb51568@mail.kernel.org>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Tue, 15 Sep 2026 15:58:03 -0400
X-Gm-Features: AcwNN1X8inw4eXVBgVo2LOS-mWKdLjd8l2uN2YGRgK2WHAH0Wh8vRRWq_n5o6G4
Message-ID: <CAJZwKkj62Oq+rdXWboGYTucw0mDYqFB=M1MhcjaGumyLTyYLgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf, parisc: Add support for BPF_SDIV and
 BPF_SMOD in the parisc32 JIT
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	bpf@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, visitorckw@gmail.com, martin.lau@kernel.org, 
	mason@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 15, 2026, bot+bpf-ci@kernel.org wrote:
> This looks like a bug fix for the parisc32 JIT's handling of signed
> division and modulo operations. Should this include a Fixes: tag?
>
>   Fixes: 847b98421362 ("adding ci files")

847b98421362 only adds CI files, not parisc JIT changes.

I submitted this as missing instruction support to bpf-next without Fixes,
following the RV32/i386 guidance [1,2], as explained on parisc v1 [3].
The current unsigned results for signed operations are still incorrect.

> This isn't a bug, but would it be worth naming the sibling commit (or
> saying "the previous patch") instead of "patch 1" here, so the reference
> still makes sense once the series is applied?

Agreed. Please replace "helpers added in patch 1 (64-bit)" with
"signed 64-bit helpers" when applying. The preceding text already names
hppa_sdiv64() and hppa_sdiv64_rem().

BPF maintainers: please consider both patches for stable after mainline
inclusion, patch 2 needs patch 1's helpers. Per the BPF guide, I'm requesting
this here rather than adding a Cc: stable trailer.

Thank you,
Nicholas

[1] https://lore.kernel.org/bpf/fa8a040f-64c4-484f-9538-fb0ec287639f@huawei.com/
[2] https://lore.kernel.org/bpf/alWEj2hDtxz8RW-l@google.com/
[3] https://lore.kernel.org/bpf/CAJZwKkgG2Ct3KipN4cRgg4v=QQwj9LhA8pveqQvT_gQ_GpzJ3w@mail.gmail.com/
