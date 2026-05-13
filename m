Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A631F9BD
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778634237; cv=pass; b=OnG0/mVSD12FlGTvjaq0BvU2mAOq/fkZocUNyas3D1x4Y0TJ2UcMRLxZa5B4zCMcEJr1xZxMev2baNC+IA93g47kFceYoTXMukeByNzB7uHbMRtyn9wXCMbIJZI5x1G1r94qH+DQ/z7huhpv845gCu2ffvUoWudOyn81eEYZuoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778634237; c=relaxed/simple;
	bh=PtE1h/lcqYbzIpMbXPzdR0UXSxoXNzSeQjYHuR946Ik=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hH/Ic/9gBDi9QD1SyqMQ9XA8cbNOmCWNiLbAsuI+C2mkxWrlaVBtD388Mpt1A2OWkTon63jxX9GT7I47Ncec7huA1hR2OMQ9fEmOjXKlCKIKa6gBnkYQVr0F+dcNjczYIDojJm09PY4wKYNehz/Uaar5UZ07ELQhtJu2bhkFAh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDffuj7j; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDffuj7j"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c736261ee8dso2865032a12.1
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 18:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778634233; cv=none;
        d=google.com; s=arc-20240605;
        b=UaBSwNjS/KmcsTEe7Ug5Tjy88x6paoiC1dJfBQb3jD5x4WcpwG2eN5tnoaEHqC5P8i
         WtPTWM4qNB0KfgFDkCLIXLbZl1/fdZ6xL4KHEz+hCfMBQoEv+h2Zi1hlo8jgqAhdn1WX
         6rjQT4XoDMLbPcWRG5HR5cb54L+R4AVaty4ah+GCLH+DpUuJLPfIw1wYLzehCRK7Ag9S
         f/rN97eeRpJyNPoHwEE4PUsr05IXJQbZ4urLGzr9TWUKS5NtlhG50BafUrixjj6IuT0n
         Rspt4RUnagjVxMrpdNpy/ndM1nW9JJAIEOp45V/K0Q7M9n0qwiW1GvR9lWPdKqMR2CxY
         Oubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=10yjKSUBHjYWC0KEN0bTJOHyCvaJRC8cFve1JVzww64=;
        fh=NPVFJnkplS0XBaxDJfGZcLOa8RPQHO8kfhXKRMGAFb4=;
        b=AGlN01JZ4SyA/9xOPIZEgE1FdlxqOl4zROUKwmWGdFmD8gc+uD32jQSKNTYK1O79El
         E74WKt/Nii8kGgGW2PRlalLx6vg6N4CFe/5VchcxYwQUgT/eJsFOri+W9Lq4CuLfKB+t
         X/vwYi0Chd6qGEFvVduZFew1tl7+wwdkq9wlZWBphApczFxK53wTobXID3hIVU7XPWJW
         SLzxNPImCiR75/VbVk2TMjRcX/QLxIRRl0Uf4zLiYOGc5vhxSufW5pByDVRQwxch7ipJ
         /OuiaE5rg8Fslzt5X0TxcDxfCCP1cPtWv0IHC1XstVBWRuP7M2eEYKnetbzLlJfUL0f9
         smwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778634233; x=1779239033; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=10yjKSUBHjYWC0KEN0bTJOHyCvaJRC8cFve1JVzww64=;
        b=TDffuj7jO8v/caRy8bPRgpHF8IM5v/jatotyzvrYnNljlgdrH9N5EGGdvRU0VNsk1v
         YAKxSoFZ9YFNdHnZdSpjfDYyld3Jutc2m8FvUuqNGcV4VrRcqV10a1fSSZkwJO2y9bRr
         9n9/7CywMgz38s+xNs2dnxzuSK9ctryALCv9AA/3n2mGrVnExt5VCVHW/6pf7poozjqU
         RqLXkFhjW4BaUD4bTCOBMGYKoCaLe/sEQQNnB0bExqPc2onhR8mbPbTOIo5tCy6VVuXi
         2Fimts9kaVsvPjo76lyulXdHLDL4Y9zyYaN8A1HBS9BvFyoqL7sEM0JP0474pnZ/OyUL
         hclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778634233; x=1779239033;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10yjKSUBHjYWC0KEN0bTJOHyCvaJRC8cFve1JVzww64=;
        b=KHZ1kRTlKnR3lOXZI2l54GjvSvbdFPb2jM6y2zLzjRigN3sqjqejMkyrfwFh3qH1VN
         m6fv0AZ13cJjGUCNveuHbP7ggnmCS+klFixva+9d7Cq1AvmqJuVFeoOyxlpvAzs4hnPA
         9oKTjTOwVm/Ux7gyIP4Heo0BwFk1HwXAJEWjrTwb4E2enk3xoBrQHmmhlorhCsn5teda
         j2LisLdwJEXv40qoGpcR1AHGh0qvL4xKddI7HC+e6SCQ+Gvr9c2xZo1WSUZuTaqWlkNN
         EfTZMZSPSJqJ/3ZRk+nnEPlzio9h/wYkb2m52naHkyRvLNypDOtgm0sMHy1NVf41haUY
         D1/g==
X-Gm-Message-State: AOJu0YwHThshezIYcg0vKXMDD9mbTWBZvTQpRNF0DK27ntcaKsdUdmfp
	sn77yhS09c8NzHIaKZUwpCkWfIl+8/eONoF4NjU28n1kBRAqT8cDkCQ6ypaq86d+6hhwzW045DS
	4bXkwd/Vaq3CKMiQh0mr8zG+N8Px2YRFp8Q==
X-Gm-Gg: Acq92OGLT6pRA8QBMx91Njnyt0mqe/N7Lc3LChvf0CnK3t686Bn6S1ZrHotPGvQFyhf
	PHBtEo064wzcLyZxLRoQLhc+7ciD/lnGcemNClOjv7sjWHZncq1ACgdnnsOppx/rLz+jlnqXG5v
	tkU1xM8Qbo8qlg7W3M3m7o/pdpDLWbfjT83NpXp76cMrwPfStdBZ6QzupnAVFEVqAZh6VeYjmMO
	cagncucrUEu+UGJ2XvZMx4hCoXfpSCky/aVZyaANscjvAeZ0L3NtSNJD4nx+QAvi/kT8I4BzlNF
	+KggXXZM
X-Received: by 2002:a05:6a21:6d8a:b0:39f:24a5:3063 with SMTP id
 adf61e73a8af0-3aface17b94mr597521637.1.1778634233388; Tue, 12 May 2026
 18:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Josh Marshall <joshua.r.marshall.1991@gmail.com>
Date: Tue, 12 May 2026 21:03:42 -0400
X-Gm-Features: AVHnY4I19GnUBu9W4uQtMGFbq91k8QxK5VY9c7pknTI8mwVD0EwMGGuMBTAm2zk
Message-ID: <CAFkJGRdNnKoV4kLaq83nQoz_jOSSPW=TTHioCKAXyyo5KPQBTQ@mail.gmail.com>
Subject: Performance characteristics of BPF_MAP_TYPE_QUEUE
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello all,

I'm looking at BPF options for userspace communication of events.
Specifically, I'm trying to do something which monitors IPC related
synchronization points which use kernel IPC primitives like file
access.  I doubt that there is anything I could do in the end to make
this low volume, and so I tried to check the various options for
performance characteristics.  However, when I started looking, there
seems to be little analysis or comparison.  I'm new, so I'm almost
certainly just not looking in the right places, but I'd really
appreciate some direction or information about BPF-userspace
communication options so I don't develop using the wrong thing.
