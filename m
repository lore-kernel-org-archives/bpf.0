Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541FD231A23
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776403483; cv=none; b=NedkaRQPv0WqkSTMORt1KIieoFhJZZqQOaBnHYLeI63l67bn0fgBpEBygwhGMUYAtea7BcDGe814QRgq6jBX5Zfs4rabhLOCSJB6cZzOHt8tF82g9AVlqZuyV/9wgSl8acTz0OnBzBxZBLSaSBJfx+M/clwQs9FgEV7ktfBNUxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776403483; c=relaxed/simple;
	bh=5EJp2v7eoq/OmNFG76/Vd6FXylhLy6f+lxdJK7eMXkE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YhLT9ExI6nFEI6ngfO041PPcBaDFlASi6freTrkTVAFuy7mpABIL+dZSNcLfzVGcwB3ud/FT2DF7XnTf4egtRtW0iHLdFST+d+KstbwszdzqVV+vPaZ8WRhCtpPrNQO20Zp4cT7hRvtDYu+HRlyzEEWk9QVeRvGnj1ov8KvqJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4d/CBS7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4d/CBS7"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad9516a653so1166495ad.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 22:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776403482; x=1777008282; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=50CRbBCCEwNtPrPirdjoziGnTjbzjpksarenXIu4nx4=;
        b=E4d/CBS73XE3zFGW9cHQZegKtdxLG6YWI+u4+YapXxPn2l5C7JvQKeDR55CCpWQA0X
         axmldgciJPewhiZr3OJFHUavGDE8a1l2tcBwv1Ne6dGAPSJGDmXuc4hStrbsxoeGAvE7
         RaH/KlXnrDATnEbuI2N37k5ZFideWovXEJIKQmCZAU5ph9FRcyNVVWbeNDsaOJ+OeJpp
         LsUojtlc3VQqVFBwVCTNkhgtbl21BMp14lBVy2ChTr/YLTdT0Vnvv5bE0j+lvrGG0DkZ
         as460QQxt69Yh2RaTBD1mFpsSYQGIdGTUziOEuPVRMF+JmTZZeGD3KCTVaXtnpLpXJ2b
         19qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776403482; x=1777008282;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50CRbBCCEwNtPrPirdjoziGnTjbzjpksarenXIu4nx4=;
        b=LE4raC9E/ot43vMw0mDRyIQMzoS/Cgj8lICh3OuEl5HuG0RgvttJR1xXSeAEP9ZQmk
         0vFkL3Sk34qtn63Mq3SFxSD5L7pokrTR8VnMwFuN7HA8jRk7XOzp+5k5SAiazJlGyUNN
         cq6PJOYgM5kOrki6pT9XajMmrLibFmiTsQDqTvocu1xDQaeB/McOybrNQ+4fSUZuDNwf
         X2xbV/0eyIws0SjcLsz95YuW3qAJ6e4aYshJYhW9QWMQbVRGEGXHsJ+CFKae+p73HtVt
         dfJTRF01zMUD1OZjX2Iqb7tIAofbt2VcuaJGTjMVhEUXLorMd6qp08PxPEB4jAt5NjDt
         4Ktg==
X-Gm-Message-State: AOJu0YxZ8xHDSMzn209tF155rnHfnKEk4gUN2pJ9ZRfYbI7wg3bw2MTU
	yIEOPS9Jx1kq/ELWjfkbTAg1bIv6QFg+eear9/H0LaAdDakn+OBU2/2K
X-Gm-Gg: AeBDieuYNiT3gCipGtMnzpTwBE/wGncKgCLZ7SdkUH+Y4NYaz5Vdu0khWiZrPKeYSnw
	gDhzjoLbAHLg7wTqH4hrptQXlTKdv/3wTXhPctEzyH57IYJq4woDX6AWLTqxswkWKzV/lFio69N
	j3OglkCMFNxzEgScYt6/x05vOABY2Tt3an2TegYP1Nx9Kpph4A7Q6lZWcdW47cbYcFruHTTXVOW
	rPameJ1r/EvtP3X7Xtj+UP2qCQjaByoGTsBCb8vdPp1joD29nWedXG5aBFtN5jXGBKoHNFpKd3B
	yZDfzYMSn6a4g2BpOlytrT94zt1HE1gnjS/vL3JhiD3gY9/vGe9XBmWMfbA76epXkBkatNSEkZt
	vi64nKS6ixCMsUubLObgdNcw1eoLzv4MRhstlGIIYcA6QeV43fTzqCTLCxptxdvoDoMg53Msl0K
	GZUHqt+2Ymd2A5biXGsQyeLDzJarTgEB+uqwfL7kHxQNNAdyd3TUIwDOQDmeQI6w==
X-Received: by 2002:a17:902:ebc3:b0:2b0:60db:7927 with SMTP id d9443c01a7336-2b5f9f3ad43mr13788475ad.28.1776403480840;
        Thu, 16 Apr 2026 22:24:40 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cddfsm8266405ad.49.2026.04.16.22.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 22:24:40 -0700 (PDT)
Message-ID: <8c3071d259e04aa6d0c20c7bb4e5bd31fc5335e5.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/verifier: Use intersection checks when
 simulating to detect dead branches
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Paul
 Chaignon	 <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Thu, 16 Apr 2026 22:24:37 -0700
In-Reply-To: <f79d58337ec3628a52d41a09e2c35e598ab656f4.camel@gmail.com>
References: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
		 <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
		 <2ec3db2d2960d9c13577d630306f16873ebb53e5.camel@gmail.com>
		 <CAM=Ch05O+m3gAAz=EW=ZPrhnTMrrMJ51ryMkwROnfkBMVVxnaw@mail.gmail.com>
	 <f79d58337ec3628a52d41a09e2c35e598ab656f4.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-16 at 16:33 -0700, Eduard Zingerman wrote:

[...]

> Could you please comment about the witness idea?
> Suppose reg_bounds_sync() is modified to preserve the properties I
> described above, would it be sufficient to check two candidates:
> tmin and tnum_step(tmin) to identify a register in an invalid state?

Actually, the witness search procedure is probably more involved than that.
Something along the following lines (ignoring 32-bit ranges for now):

- case a. s64 range does not cross the sign boundary:
  - w :=3D min(umin_value, (u64)smin_value)
  - w :=3D w if w in tnum else tnum_step(tnum, w)
- case b. s64 range crosses the sign boundary:
  - if u64 range intersects with lower half of s64 range [0, (u64)smax_valu=
e]:
    - w :=3D umin_value
    - w :=3D w if w in tnum else tnum_step(tnum, w)
  - otherwise:
    - w :=3D min((u64)smin_value, umax_value)
    - w :=3D w if w in tnum else tnum_step(tnum, w)

And then check again if w still belongs to each range
(it belongs to tnum by construction).

'w' refinement for 32-bit ranges needs more thought.
It would probably be similar to 32-bit -> 64-bit from lower bound
refinement described in [1] or [2].

Wdyt?

[1] https://lore.kernel.org/bpf/20260410124035.297632-1-koike@igalia.com/
[2] https://lore.kernel.org/bpf/b2a0346a5b0818008503b721c62621918d84ad0a.17=
76344897.git.paul.chaignon@gmail.com/

It is much simpler with cnums [3] because sync of non-intersecting
ranges produces an empty range, and one would only need to apply the
tnum range logic from your patch-set. I really need to wrap-up that RFC.

[3] https://github.com/eddyz87/bpf/tree/cnums-everywhere
