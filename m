Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F790389114
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611680; cv=none; b=Pr99fqRmjOBZksbrUxLpyatFNqAkT3RwX+FUv083qscaSzyQJpio0QcEGcQFY1fanqmlz9vZ7ts0dQGuDnsmmWtxVOlwdzGxPpWC+faeVpFaq4ZLYILju64u1b1DlzCFpP8kSnVDpn/hf65vKZwT4DMuGFH0j9hUDMs4u5Smohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611680; c=relaxed/simple;
	bh=hOeg8/gd726Tdq9mrgEBZ1rywC1S35GTZQRzN2uBWyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pXCgQL2iKLWxMaueKmi0BPdEufPEazMaKdVRJvJ0Sepl9T7w2Bw3VahTjvA3OrJB1P+ncjFuoN1UqVNgbCkQb+e7QOSjIZfl3O11p6vWE/vdwskVa8E/YjsU4fHd2B62nZOYFFvLgpPM7qPfN+mOGAeHrH3x7etGoDNt2Pekjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lL4LO+O3; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL4LO+O3"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so74494705e9.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 00:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772611677; x=1773216477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av4UH9SO0/Ch5JZF+nWNZV5yubzeG2c9IUi69Z0bBu0=;
        b=lL4LO+O3BgKMvK84ER6Dau4ujbdXtRyFovQumkZcfOUUtSmEqxcQ2TxbUKVf2N+YIz
         Zh8DAB1fRCRHpUbypxNE/ul4VNkCAJt7rfaXfaarb2RShYfOVCL+6EdXAcBpv8vrr0pq
         mWXOqGrkUVTG7cIaaCMhaBPu7gn+jgd4bPXluqOJO524ZyB3JbVEGWN95As/S/mAwZ09
         cnksew7Hqr5YpwDozi3P59FfhHp2K1CHGXHkNS+4Pm0FY45PqdjOShjBcUO4d/liilP9
         ckIRAYM0IGA2TfyiB4rpe8x/pMjKEPsxbfYNN2bghfeJOoM8DazpYi+fbU0HrzY6FWPF
         yBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611677; x=1773216477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=av4UH9SO0/Ch5JZF+nWNZV5yubzeG2c9IUi69Z0bBu0=;
        b=q4EMlJapyc1+DqMGGVWP/yfU47q/eVfI8Q7slVvjSlTU8mtNHtFNIl5+H3xBNiIyKp
         Y4gvmMLivkDBJ+GTUPk8q08OwLQzjBgtiHsLegVT1BL5Gz2jUs+sKU5vnjGeg01fFLVS
         qIIJIdVxD/3+kdMmoPBImUPp1E+USQMLZcj/EdUrKX7cpopLBfOrNl0VWPUDzuflIXJu
         YH2ioMkA5nege4DH7UZdPrAWdiCu0c26kU84vh8HgihduysnCRubTnfLbQfG0aYKzObE
         d2TKX47vBQt5PINEl/mhqy7A3Xtdjrnoqb6mtyIMahKxx73jI5HK3P5zCXeFwxUZ3gdQ
         OHMw==
X-Forwarded-Encrypted: i=1; AJvYcCXHRrZLaIzZ25aXKQNGd3EfCeWuStUxTEr3qI3UZO0JPOP/mu7M+XsDMa8f+cCFINFHYC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo2UoY4iUHHqIA1Lgqgn/VADFia80ccJIHJaeOYkdRe/Y/HA/0
	t7W6ItyQ3Ts+rUkpgbFX8kOaVy+H1KU+MbKDXEjpIlarwx1q4qG3Kg1t
X-Gm-Gg: ATEYQzysM3NKhHvBMCQpsS4pQ9cPvdW2/0JMUY1JlUzVLTqJ25APN7ZIAede9byL6bv
	GjUFXyYaPk5WZsrGinhgidgwkRwbPFpgPSihvJvtTh8MmksMXJZ134ZQKLOA3Li5B5WgqJL1RUN
	DE9fcjsO/jPApTkX6qsOGzaNTVkN2dvRjYx71qNp63/Vji1uyJ1GXWh/iwsArcDFjXNXAPi5Qas
	2bkql2ndlOPOs7NQ/uFL35ftMpK7oh+kwPOVISMlvUlyn9bUk46nzXIdwsTyaHH4Z/StP401EYx
	giRVlqosIs4Z/0ZFqJBQHx3g1w6vqeeWwp+ZkT3Y7vDp9FuJ/u47pWoLowROq2skbhg1YleM7Cq
	fjClHdUjT9il8X2nlatP+Dc/LImKoerUoLtI6N3xs3euCr//KcZAayDLnfPTo1LMs5xqJp/keFS
	mlAk3PbXoQ2d2MMNW7OncBOE6oLMMoAqI1+lsIt3QWzmJQBg5A1A==
X-Received: by 2002:a05:600c:1d0e:b0:482:eec4:76d with SMTP id 5b1f17b1804b1-48519888ab3mr17588355e9.17.1772611677114;
        Wed, 04 Mar 2026 00:07:57 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a82c876sm5400915e9.0.2026.03.04.00.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:07:56 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	wangqing7171@gmail.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in bpf_trace_run3 (2)
Date: Wed,  4 Mar 2026 16:07:39 +0800
Message-Id: <20260304080739.198251-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69a7e4df.050a0220.21ae90.0014.GAE@google.com>
References: <69a7e4df.050a0220.21ae90.0014.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 04 Mar 2026 at 15:53, syzbot <syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com> wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com
> Tested-by: syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         0031c068 Merge tag 'cgroup-for-7.0-rc2-fixes' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12afb006580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c5c49ee0942d1cdb
> dashboard link: https://syzkaller.appspot.com/bug?extid=9ea7c90be2b24e189592
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1566e552580000
> 
> Note: testing is done by a robot and is best-effort only.

It's same as [0].
 [0] https://syzkaller.appspot.com/bug?extid=b4c5ad098c821bf8d8bc

I sent the fixed patch [1] to [0].
 [1] https://lore.kernel.org/all/20260304070927.178464-1-wangqing7171@gmail.com/T/

--
Qing
