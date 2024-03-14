Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B316E61D
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414525; cv=none; b=mzVBnJxgzdjTewsKrVFLWJPNjajmEGa2Lc6oHkslMO5W2oTQt/HN0yFgIk3r/yEgskUXtFil7D8Q+DSTrmTVBY9fmI6Clk9tSVF8innpJRmw1Flw/Pfkj9tQMSd1/cZWZ8mTBQJRGrSlDGerAgFaGDNCS1HwHWjcaYFywKSl+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414525; c=relaxed/simple;
	bh=uLVK/hchT4VApamksqhB1haIPhlDhuB/t7QMkIKiSqs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HQ72iUQnn2+7VqqXuEf+8SNbUvDbflgexgNVhceydw5Qdqi9l9D46ja5Rs7M90roVJdi0/do2FwjdJK6nQIONCTW4Wwgp7xCB4XAZf8/DwuZndc6zXjlNtoP5Kj3biJNssg0hxXQSlu0I/7Y4AWGzK96nnl1UxabLAOpFhAiQMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emKq61OT; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emKq61OT"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d41d1bedc9so9714761fa.3
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 04:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710414521; x=1711019321; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZDPij5D9ivKVWkxGgdZdTa4jZR/fIBqfwjde2EYHYw4=;
        b=emKq61OTtqk9Z6ZXshxNUOAsMl/3/Tk3dp3RBnJ9X7oFCq3DuK185o2F09UPB7OUne
         I1uLr2rNnMkTXl7JTTxLQyVMbTCvHJbKPY4P0lfiu/jabacX4RpHLoBKhOzB6XDApYDt
         9S21NwAL6BQa3mYWwqmlDLBUYL0J65HIfHfGQrrzcmFRGIdxKiwxF7duEBEECU2AFmJL
         Xje8+BOJKuEiE8RCcTkRt6Cjgfny4H3JfgqtgpxoX2qUAPraue6rTADCEu1awhD12gyz
         add+kDUztAd1vyLV+KIRNT1fyOvVuJs+KxCqnjNCx0nxT/3Z7Gbi6sCXSGuY9JFtrUVF
         e+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710414521; x=1711019321;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDPij5D9ivKVWkxGgdZdTa4jZR/fIBqfwjde2EYHYw4=;
        b=oL2RdmZWFiwtq4rxPRUnz9xqXyEiGJ06XvHCOIOl2an534WpoLKOdhXGMVDrIM5D5Q
         KS4JAajdYzKv1UPYu13E7K7dyct2VfYg9bf0Rt+1gCJ7p3BNs0qOaIrhPgZsWf4KaXhW
         Ji2pj02KQi9SZlD2/K+r37QU79AZKJj36PcPgQyWm6SpRgmVOvJcfurY2A0l4Q3OvSkb
         K6yJ5kt4gci8tscEnvK1hz2w8ed07QMoirMcAXnYgqTPRstS5wy3kiNButXBZZtaqLXh
         c8UtTgzKnSw4hfhKZU9ax6jPjlLcv2c8fVDPIR+p9Ie1NAWAzEzWst0uj93yFnNJRDhQ
         AWVw==
X-Forwarded-Encrypted: i=1; AJvYcCWYiDBS9mHDQwP6vbC20zen8tzCSJPaPVQbpfpZ/oYx7e3d441ptEkzbVOT0m9JH/aGaPrZj24K5FOegBV+as02VD+8
X-Gm-Message-State: AOJu0YyTzLRXa14WCjJ5Gt0pgivVr1YIx3kBASa6oRS2wO4U9SYm6oi6
	y45PVrcUpxLljJkeBgomhP5z7XH9XYDAfuw88QvZt3dcyCmQ47QT
X-Google-Smtp-Source: AGHT+IF0BwNCefNt2x9PWhtLz5MUyAVPhaWQcrf+OKTo2KiI5mVrfIdfLos9Czlm1iq/cAz2w64nfg==
X-Received: by 2002:a2e:be9c:0:b0:2d3:a7da:b17b with SMTP id a28-20020a2ebe9c000000b002d3a7dab17bmr1173791ljr.4.1710414521225;
        Thu, 14 Mar 2024 04:08:41 -0700 (PDT)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l2-20020a2eb682000000b002d29faf0466sm88651ljo.104.2024.03.14.04.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 04:08:40 -0700 (PDT)
Message-ID: <94ee37372c90c28980246ab803dffb3d2b63be35.camel@gmail.com>
Subject: Re: [RFC PATCH v1 00/14] Exceptions - Resource Cleanup
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>,  Tejun Heo
 <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
 Rishabh Iyer <rishabh.iyer@epfl.ch>, Sanidhya Kashyap
 <sanidhya.kashyap@epfl.ch>
Date: Thu, 14 Mar 2024 13:08:39 +0200
In-Reply-To: <20240201042109.1150490-1-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Kumar,

Sorry for delayed response. Theoretical possibility that frame merge
might fail because of some e.g. clang version changes bugs me,
so I thought a bit on what alternatives are there.
For the sake of discussion, what do you think about runtime-based
approach:
- for each throwing sub-program reserve a stack region where
  references to currently acquired resources (and their types)
  would be stored;
- upon a call to something that acquires resource push pointer/type
  pair to this region;
- upon a call to something that releases resource delete pointer/type
  pair from this region;
- when bpf_throw() is executed, walk this region for each active frame
  and execute corresponding destructors.
- (alternatively, reserve one region for all frames).

Technically, this could be implemented as follows:
- during main verification pass:
  - when verifier processes a call to something that acquires resource,
    mark call instruction and resource type in insn_aux_data data;
  - same for processing of a call to something that releases resource;
  - keep track of a maximal number of simultaneously acquired resources;
- after main verification pass:
  - bump stack size for each subprogram by amount, necessary to hold
    the acquired resource table and assume that this table is at the
    end of the subprogram stack;
  - after each acquire call, insert a kfunc call that would add
    resource reference to the table;
  - after each release call, insert a kfunc call that would remove
    resource reference from the table.

On a surface it appears that this approach has a few advantages:
- seems simpler than frame descriptors tracking and merging
  (but only implementation would tell if this is so);
- should be resilient to program compilation changes;
- abort is possible at any program point, which might be interesting for:
  - cancelable BPF programs (where abort might be needed in the middle
    of the e.g. loop);
  - arenas, where it might be desirable to stop the program after e.g.
    faulting arena access.

The obvious disadvantage is incurred runtime cost.
On the other hand, it might be not that big.

What do you think?

Thanks,
Eduard
