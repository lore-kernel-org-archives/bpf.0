Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A244AEC5
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176932; cv=none; b=O4Fa9cY2uUyQmzr9xgyWQaUi5W3A+NSN+gdKAJDx4cE2iVrV/yg1LpR/zeJPDmlbE1/CDuiHgMlEZYSo8vcxDALnLtcB8nN7hUANv/fT4HjKeSmpfbaUpBpykdPnw+3+z5JVQFEkVR1Mqq/9kDkFXNDeXFJeoxyeSxb4E+3VPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176932; c=relaxed/simple;
	bh=MFB1NXASOT7/Q36B+MS26c3a/OjHk5U8gre+lgzgXE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHfQFWkDnrzPQ42giNwT5Zg6lRYPloQul4zkwqXuH/3i5vYfL3k/RP73KkacZoVl/b/U1Bmhxz2n0ppE9MHEJodAPYlza/P9+lpSKZedYEYSWpwlhvjlVkvUPcothRWIid+Vq9kH3JBNre7eQF00hJGoshGUVaqJ86o0VA4LEn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=C3g62IND; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="C3g62IND"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4132e548343so4548565e9.1
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1710176929; x=1710781729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Fjyy0RSim8Nqg/20R7z2/C0DzCQisJdbBrQhqnQx3s=;
        b=C3g62IND6F3/bAaRmwrqKH6ElGI6ChqvQWaPORLebZfEAC3hGXJKmW4PYsrahad9Br
         LlpgSAauq/pU+l8sowI/fM6dwzIlHTNbGst4KyATcz8sW4jP6Spba9Rzsp0hsWmlTIlj
         42Q9YpyYxfg0swv7/xYZ3rVyqK7hR2bM4/zQlh+RVttRpkJ1DTWFhKo/oJbnffwc/I3Z
         BpiTPOhINlcALtE4kofk+rYRiWlMc/+XwDt+EpfxZ4PzxLxb+6j+AYihF9gbaB1DEm3w
         nMqnGMC0/FEox1JO9wV6Qe3e/3ya+sf8GafNVETXLu1emN/sHQ0OBaCVLZPZGu53dmJy
         K4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710176929; x=1710781729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Fjyy0RSim8Nqg/20R7z2/C0DzCQisJdbBrQhqnQx3s=;
        b=rCZD+n2ciWIx60ydfc+T7Nh0kkgm+Oe3ILnyesOTHBRAQ0k1Otg6fPN05lcDSC549n
         B9UYJzLT8zeejsP0qIqXXN+sX5GbbyyLuqnPRYSZoag9l9haFs4IptRxoq1bc8ctfKaT
         hyD+5mJoq1x3U8G3BFP53gNYi2Uz45tA0dWfCPkeWzOXNccad1vq76AMgMGmHuCO0rdL
         kbAYd0FNu5FosWIvPoxx4yrTWX4Fl0gAEfQaCxtMRpJAlEd7+z3aNrjmAATJO4G977OH
         w1PTh1qEx0JWTa5gUDGty/+dRebqr6cGrroioZIduqE2BKSijcxpD2WwElCGXenjMifd
         OsiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuHKZ+zQod6EaNc7k5XDtDp4ZsDHDqNMetD7/Fwl3nPjKz7triurb49bSVF3JAS+sjaogojF7Oe7n0DJ7x5Dlqx6nV
X-Gm-Message-State: AOJu0Yw9caLxwgXSgrHEkLxpu02F2YGaoX/fqBZuJdny2qanvYH1giGg
	EER0h3lkWyoTJjdjRFTmmBMRrymEfppko4FVFrOm2evdiokp0PbyB89wz6MtWOY=
X-Google-Smtp-Source: AGHT+IH7RGKZkMSy2pdJ5Zl0JMvYJ86KseiEILVI33QDTXGxglRNDbihbglD4B3KNIGKu7T5LMHujQ==
X-Received: by 2002:a05:600c:3554:b0:413:271a:1e5e with SMTP id i20-20020a05600c355400b00413271a1e5emr3320696wmq.38.1710176929093;
        Mon, 11 Mar 2024 10:08:49 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:5231:db44:25b0:339e? ([2a02:8011:e80c:0:5231:db44:25b0:339e])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b004132f9cf053sm1310682wmq.33.2024.03.11.10.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 10:08:48 -0700 (PDT)
Message-ID: <b3b5690e-c8d4-4f47-8175-bc1567139391@isovalent.com>
Date: Mon, 11 Mar 2024 17:08:47 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 09/14] bpftool: Recognize arena map type
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, torvalds@linux-foundation.org,
 brho@google.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
 urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
 <20240308010812.89848-10-alexei.starovoitov@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240308010812.89848-10-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-03-08 01:08 UTC+0000 ~ Alexei Starovoitov
<alexei.starovoitov@gmail.com>
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Teach bpftool to recognize arena map type.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Quentin Monnet <quentin@isovalent.com>

