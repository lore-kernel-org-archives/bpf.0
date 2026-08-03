Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774B35C69F
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750301; cv=none; b=OGZCSM84kldH7wdOdb2JfSnmQ3nwhbQi/Yxq47NHxftf+Dz1+i3RyowpIRyfYFnSHONUrgpLLggO0RBVmzlsuccc73goTswVMuKL8itKgJR0CaVfWPNMgexryuG3OYl4M8Jnmmxu3R7KLYwl4M1oALOlLPzrJLoc4q4eGJOz8i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750301; c=relaxed/simple;
	bh=MKQ1bcx9ZD2AQlgywAp0pOBhw+lOZ2APmx9MRvtiUjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLugmRxedqbHcKPjlQo72LyuZiGO2m/va3fuNaK87eyzKakF57Kwo2FzScDuouPXEdAeF8Bkj/a1lilHurYl+x974IfYKUcFbnAMvTRGRiJC6e2gm+ZjOOCZwZPDkwSmNN6sEzkQZhliDjP2HvwV3NSr7PdhemoGmms0jlIyQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZq75ZPC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZq75ZPC"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso2681087b3a.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785750299; x=1786355099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MKQ1bcx9ZD2AQlgywAp0pOBhw+lOZ2APmx9MRvtiUjU=;
        b=HZq75ZPCDF8o8qqAA7UwTt4v0eTEAq6zx6/OGEHrVr0vn7uI1CoPRIGwk7yzmpmAnU
         vxBX+mlNV+6qLUTAu83MHpaJhuUC6LR/+2Z7cmG6IDwkJYnAx07xrpnzlq9ZwjcOUH7J
         5TmlEkZnW1ct5VqRgCC6rTDcggAoyo6kXnYdgBaDpQmOItRLA46W/CfHvGJyTY1o9aH2
         2VxOH5/SxEfwYXX/1/ofdGNT2u3dIN+5ZdS32X2jl04332H68Pn9aGGdlLMbzdwftBxG
         jRTNeHHvQd/K/zAX8ZZ/Oowrx94Uy0h8Ij88KQWC9O+jvvMyZaDJhkyHNZ+V+hxADIeu
         0x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750299; x=1786355099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MKQ1bcx9ZD2AQlgywAp0pOBhw+lOZ2APmx9MRvtiUjU=;
        b=FV5pXbDm3yJZgD8ech+YbhG2/xHUGJjgQKkZver0nDVCsv4Eyw6I36aZCpZ5jO7Xlj
         P9ix6n9j9sDbIZFEr+L+5Bu3Id6uy4v0ba10ApLgOM4f29QQ9pvQZt4XaLKw4u4CpTCm
         Ntv/UqlfMCgr64ErSL6ULuyxo+putIAmkMX8mn8N6wnb9VEfHM+TKr2E/FtMtwGv1eAu
         h6uTa5XtFpO5ugB1XxvCvilbZANzMzQXWHPxXc+iApRN7mWNcB6BpZyf8PheH+BeDob6
         id3mYGXM+Rv9mRzejwELN+oVr6W2c/VflSVr44TemXavZoKgt8AWBCYoGqNP21SDLYjG
         PP7g==
X-Forwarded-Encrypted: i=1; AHgh+RobqiOJw/XsB4SF2UD67mH7nT3WCccEHC9FIwd2BjUsjifGA/RguXawJBKS0VOgIADhJ4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz18Nkr2dJrswo8itG3MOq35pmhy3z6owqSXrB+I7aIPlCw10RR
	eNbUVJKuuIurXRP+YTlOsAAGRCluomlDt40cKNP+kereAxUQA8uiVlIy
X-Gm-Gg: AR+sD10/dvLcQ3vNCjsSLGeNpLGU6jzpVYxzm58oiXz5ZEBrLZAkwe4CBG7Lrn2t6db
	4La0BtHaRCCgetzJRb5OC/h/HqY6VVAzAf8ousjn4KAvkFuxXAPE2AOlBt1Td2/cRCyS7ISEEb1
	wvDFC9P7I1iwNjZJYc83y/UXQVlm+s6+zPc9Hk6dD5Kb7DKEg6IsK4PWA4M7qd3Jx9wfObXQrCR
	JN5hqq4pHP2zzgfKg2Nl7NhKh4eoITbDJSdzHAOXg0Aw3ulpJocz8LigJmhU504aiwFQ4rUWH/I
	z4/+4vIUpEzF9Jm1upTuTG+G67A3HPBTWlclVfQGJZwXjrxGxNYW8pv01mTiXaXcui1B+FUx4UZ
	HU3EgeeMBpSUR+CI+iSl+IGcFbUtnYGnTAEfi3J2u9e1OppzNpQhxUrZQVh8si73qom2LX8aMYJ
	7x7mMFqwwDLGV0uxZnjlVbo0lRNiJmJe3BvHH7POUb1XoAigAuxY9F/rpydK3y02t1cUV1tdADh
	xUgzqgKxpOFEdR3s/jDnL0/5RaCmZ8nFppBg0zB7oenQxtpaEc3
X-Received: by 2002:a05:6a00:22d1:b0:848:7bbd:2851 with SMTP id d2e1a72fcca58-84ed74bdcf0mr9830488b3a.29.1785750298661;
        Mon, 03 Aug 2026 02:44:58 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29f312sm3380567b3a.33.2026.08.03.02.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:44:58 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sun Jian <sun.jian.kdev@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com,
	sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Fix mmap_lock leak in irq_work path
Date: Mon,  3 Aug 2026 18:44:34 +0900
Message-ID: <20260803094434.2763945-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAEf4BzZ3TN4b0OFOV62YG=W3pAKD4x2eK=_mrmBCci7=fNQE0g@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> maybe we should make bpf_mmap_unlock_get_irq_work() return `struct
> mmap_unlock_irq_work *` which would be ERR_PTR(), and return
> ERR_PTR(-EBUSY) if (active || irq_work_is_busy) (see below)? I'd
> probably call it bpf_mmap_unlock_guard_get(), though. And then we will
> have bpf_mmap_unlock_guard_put() (instead of
> bpf_mmap_unlock_put_irq_work) with the same logic.

Yes, I think this would make the code a bit more straightforward.

> we drop active to zero here, but irq_work_is_busy() can still return
> true, I think we do need to check both

Yes, BUSY can still be set after active is cleared. However, since the work can
be queued again while the callback is still running, I thought active alone was
enough. I also tested it in a widened window, and didn't see a lock leak.

But I may be missing something. Could requeueing the work here cause a problem,
or is this mainly to keep the original -EBUSY behavior?
