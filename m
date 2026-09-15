Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C78A4749DA
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 23:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513262; cv=none; b=GmxvtV5Xof34u/xnGxdfZo0GHq518JOSYvadjuCX/AJQVs/6M+NduChsQP2SpTXhXL5GwbzQscPJw3g1I3qjQWzGCvy2dojPFwUpfv8cvYkE3jDwS7RtYk0duuk9PHdYQD85T1QoeNaghSXn3JQAo1GaMVssIkeZQCD8PutiqDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513262; c=relaxed/simple;
	bh=ITz7hBythv5OWTbmQ9c4e1mzRPysX2+YTMbCrseTj6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmTN2+/oGjRdY5U8wskv87tbVoeVL2XSpDbL0RPsKvKbMxdmzWwd/HXfGfX+o9kdWaS/XsA0jHNIHwcPaeFOAi3Sv7kz32uIMPEcJJohXBaVOjdJFF4JhqGkogtTo9oZ5WlV1PdDyrAoazwHu/MsbkTsmjCrrrIMWjIAIi20vbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NOC0CNts; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NOC0CNts"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f1744fso431759e87.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 16:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789513258; x=1790118058; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=NOC0CNtsOABk2eJuHaA0MscMjgvzk0F735u/yhNRWluB0GguJ94qgRNe+jdO64XKIO
         i9XimfoNzDvAsyYfqQRWfesjt4iY8cjdWBWAphlIf5gibQLomBXNdgoeKjO0yxF5s9Uh
         0EiVUPHAwWGpanUfS3UZqXJZidOy3/UkOgLj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789513258; x=1790118058;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=anxYXwQVpHx4tcSmOfkKhJZDoIlyVHtRQ1d5K/MmLbpq7qqBfi3cr6kb+VhLBbpyND
         62C1H152iOGr7jGs+rOfEMg0DW+dmloHT1Vr0kaoVyeO60yT8Nmhl44d36KNKk2zNk3Z
         Cpy12VZVhYUsZHPcklg5rJs1BfY61ru96PQr1aB1ROpNxpyPwHakxaiUeIozFk+Zkkr8
         bK0XNspXcvY4mgUxcJsZ11sLoLBtUupen6mo6PwcwBsh9jzqhTysZU4lys6EYB7yFz/P
         sOmEX1yj7Y+jqsRCVIT15Rw6ak1NgjS2RMz1IkyOBA4g7UVJg5qrUYNCprTTBt5aqelQ
         k8Hw==
X-Forwarded-Encrypted: i=1; AKwUvBwA8J5czl7vZRWvtfLF1qJwhGXslYH+P6BoxwOzuonmzDdq6yo3b/nzuhzRE+yxKGFUARc=@vger.kernel.org
X-Gm-Message-State: AFuF++nUcnPXLCWOJ3si0t+AVZvuNMxkJhLDHdK7BTOv2qR5xL90MTLk
	meLvM2OsIAxQsWze+VRCcFl+3l82F8LF4nb0Pm7vDlMGrGU92sfctI0tPcwNFtBrLtYfDE54wHu
	JH1VgJyQV2A==
X-Gm-Gg: AYBFou1XCM2epL3H2Ptzk2zGgAMrYrvkNbDCiHX7IN8WEA+4yOoK6J4VZHFT9H8giDi
	sp3V0ByGYjWy71nwwaFN8ONpmYxJdYe6TYVxvwtE8LmBqPZMaMRKFt0MNIpDQn0R3yZV35ktgyk
	ggJvPLM6/y8OqiArX7Rz86EBx6EDS0C+Kpi/k3XGxNsVO7ToAp2XngFeFJyQuFL2kG44NcAe7RW
	03Znj1EBDG4P9lnyjuGU+i1wYjFH5JNzNUjrNseomAsauATL4x4mUnmFCf/e8jhsDkUII48vAoy
	akoe7+xG3bhmKpVntF6K2GElnN037cOZM8fLa2Ruk65l+uEpz6n1zCjET48QyoOhm3tIj3902H0
	XJr+uuRDDfisfVqceYxdjNTsUUydHSwgnq8Uie+/JgPNbTEjMGbx/iSqwmRhJTt67m2jJdbANTt
	oDjX7tC5ARNSqhbxK/e9eeIsxB1Z8GsfpbDHvNgt8mgCNw6Ja09nnPukTvGfR8LNMLwSgXjpsyi
	udi0H4/VP+MrE000A4BWSfAttcBTvTDqYeyLPK6qS8uhJ3v
X-Received: by 2002:a05:6512:130b:b0:5b5:e5a1:9ff5 with SMTP id 2adb3069b0e04-5b8b662146fmr45865e87.25.1789513257786;
        Tue, 15 Sep 2026 16:00:57 -0700 (PDT)
Received: from mail-lr2-f13.google.com (mail-lr2-f13.google.com. [74.125.230.77])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57c3b97sm296451e87.29.2026.09.15.16.00.57
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 16:00:57 -0700 (PDT)
Received: by mail-lr2-f13.google.com with SMTP id 38308e7fff4ca-3a5a04b88e9so3091641fa.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 16:00:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwFBb0tVJul4+40Ml5SUKqn6inGdI1UguMAfkvOEe9t5XWhur6Qz6tpffhtfy9IEubECyA=@vger.kernel.org
X-Received: by 2002:a05:6402:5d1:b0:6a9:a6c0:e5ef with SMTP id
 4fb4d7f45d1cf-6aa2244ef06mr218172a12.37.1789512913950; Tue, 15 Sep 2026
 15:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com> <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
In-Reply-To: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 15:54:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
X-Gm-Features: AcwNN1Wx2MaYDtFtmeOlL6MnzYY7doY_FEPpziKatTBWbLOeKsjmritQ5JuAL3M
Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: rob.clark@oss.qualcomm.com
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 15:21, Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>
> With fd's it is more than just about error rollback.. exposing an fd
> to userspace mid-way thru an ioctl is an easy security bug to write..

That isn't very common code. It's something that is done by a few
strange cases, and yes, those cases should just do it right.

But "those few cases should do it right" does not mean "make a whole
new subsystem for this thing that makes a simple "open" actually be
slower and stranger".

             Linus
