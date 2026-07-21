Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B62436A354
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595956; cv=none; b=DqKnEKE6KLjXHJp2GdKQ++U/mmtSqKh2qoyLesJVuNlNtel+2cnTb7lnQj+fk4wkzhE81Nr3cZq39WfuNrueocftzZg2yhenSyQx5a4Ke9eAKvdQvsvT7AKuq5VV7WXNm0tpJtykb/o1AXIQIt7baieujKxZZYRrioV8tPl9/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595956; c=relaxed/simple;
	bh=kO2e5pHRGoCQKs0DRn04ZjECVQsjanVgfUyI1swbPng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soEHoSauJdZpkA8F7SCWVRu6179Qm2tTcKma2rp25+TjlvztNZZzqfkJ4030FQFDcjT/TQReeph6Sp4losO0e8iIWFnN7O9H29p9eg2B0yaBXV3LpBOcbVZvxE2bYc7vQBOpvfFdlGYoec/dD4APcd1oNho2FKbSsAhdAKxx804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY1o0DT2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY1o0DT2"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cad4170e8eso149658045ad.3
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 18:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784595954; x=1785200754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kO2e5pHRGoCQKs0DRn04ZjECVQsjanVgfUyI1swbPng=;
        b=WY1o0DT23xCyEAPgumdOfVwE5i3gLmjPUQ9SK52XOq45SnXfXJM0TsOTrLKE7ruUR4
         QBm5HeCXPHDzxfhxjvQUuboRl1W75S20yQ/nEpXtQOyh+iPgvLzANXq931a1eGgY5w8z
         8mU2EeEc8rtJfHp1UQeIVjC8qfg1nWmcwh9j2N1IGGx5BBT8GwKF9n+S9dnpNtGFKKau
         Vtsw0hLShQawlvwA7Nv7uib/cAob+FVTMDD/CMWKjOseDKIwFIlVYvujNpvsXzOUdEry
         P81/JMGGi5t9TSGtBS1XziOoezAaUqS6K3riG3zPO+zPacbUgdf4ZpHkSrNZAcShsMN1
         5D+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784595954; x=1785200754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kO2e5pHRGoCQKs0DRn04ZjECVQsjanVgfUyI1swbPng=;
        b=kt+PJpEiq+Ou4beOk1ODiVWrTCl83H7ZxVKXhW5rycxAe6TbEf9AlD3qQmLcZXmkXr
         Cmdg7vvc88krQo0iwMbEdhEoQNVwUyqDApv5YfbUnKDqkibFAgJfY20kC9jgT90i+U8v
         MKnLGQqL7VttAXtlA62HJ/x+2f7mqJJz5lq2Ffp5ODwRl8KHOrK0/OogE1umvwvbDB81
         B9NPuNhVg7TK4wcBvGZkGh42SRu66WWxZZzjnZr1NvWrDppwcKFNUaBcUARKYRCp/4DL
         24+ozs1Ji6HNAeL/5bbCiq9RUV7ged/C6+ZatJB3E9EaO3HbInyITP96jcmwT/hu/0rF
         6fIQ==
X-Forwarded-Encrypted: i=1; AHgh+RoX5AaZ06JgISaNZQGIxPCY5oHExUNK+Ro4iSq0WZNj7tcppPBobXMG4qSYPvtJUkOCOzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV8MYwN6CkNzHUrXk2dfPwVV/3DgVC3jVyxdBKl+9z6AbNvRRu
	NxwE5tL76xfDHM+lH066bamxIHpoPfbGXIUWJyb3bzngpzcm96yAKFW1
X-Gm-Gg: AR+sD12Wskm85nSPCHkCWqEkqOK20lOugNjWMdOlqDrtwL4vLj80lkmfomHqIFd8vxr
	iCKMa8qifws0YyS1D5xT22qjxKNFiGPJHSxpXyR/TRdEem0bDhwkWM1h7eA9mqYqmnisD4hBLR2
	1/CVKtQIaQc1p7A2GKoLGrLw9IJSv7LaHlJdv0KuSgaLO0UCnPvGpmx4epHBFQjfvmDqjq6K9Ny
	wqbxl2Ky4x6kdPdYNyjE/GlFwUWGyUDM3XYj6Tf/8NpzSl5VQ4a8UWCe5WPFk+hV4t+sVeklFPY
	zt0uvK2jfWXuf3Bk+P5aTocICa//arQrFifvRoilL+JDITYAVFxZI2LOJ0IsMnsD4AGsF14JnVJ
	8wgsp8vGiwMXhB6W8vwxP1aUpTyVghIANBlUNeUTnLrJze/SnIPdkFYdENbYDF81qbPpnE62AUo
	kmP9ECyaMIj4IhWOZOnwfaGHpSS1bmYHVn42II3b4RN1gtZjwc5ENEuu2X527NvENWRA==
X-Received: by 2002:a17:902:cec4:b0:2cc:6329:b7ba with SMTP id d9443c01a7336-2cf34857697mr167487935ad.16.1784595954192;
        Mon, 20 Jul 2026 18:05:54 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344b16d4sm65025075ad.20.2026.07.20.18.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 18:05:53 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v6] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
Date: Tue, 21 Jul 2026 10:04:49 +0900
Message-ID: <20260721010448.707363-3-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CABFUUZFsippcjQ7JYqtAJnMa73J9cGaa_tAbr0iqvv_pp-y6Mw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sun,

> Sanghyun, I saw that you planned to look into this after the current
> patch is sorted out. If you are already working on it, I would be happy
> to share the PoC and my observations.

Thanks for looking into this.

I am working on a patch for this race and expect to post it soon.

Could you send me your PoC and debug diff off-list so I can test the
patch with your exact reproducer? I will post v1 as a new BPF thread
and Cc you there. If you have time, I would also appreciate it if you
could test v1 with your setup and reply to that thread with the result.
