Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892690;
	b=OWRDm9DiqdXtt3TBKvUPI4PCbnYyT++RY4iEPo1/oP1aeN0dF8g1mLOF+MuS83s3fNLr
	 zR5hFeDuA6vSjaJj5keq5SaAXrO6gGgc5jzwwDYtShDniaynr0dO2TtiDL2CvgFMX61eO
	 K3xPjZD6+ipUJL8tpLBA3qMtbzu+pfkTtU6qzBi8TlTEOiJIdhbpypVaIe4E06FtJSBFm
	 meCL+PQgGyJ8akWvxpivlsrLdSOF8vmqSReYbkCMdhh9El2C8RgMy7TXf5CV+5dopSQU4
	 rCh+o3EutPuVl7PQp4sziK5HkoA79lXxnnZ7bai0XAbXjo/Tc74d5grNxSLAJz6W7vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=13gdahQBL1UEvhQCiEH01xvV1ZJPqsjiQpx8OMA7kwY=;
	b=m4ligS0p1Fxn01sMfNxP5F8FzvYGmVpf5OcGBr0vTGmVBg2ZZlGE9NsogiHMA+wJMjA2
	 RqdsWwUyhhi1rtAslyLxMOSruJ96RSf41lEzxGrlokVCcnltVueKLyRHCBuhe1N1p3Hzh
	 Xk4sh1TC1Vv6bjO/PPfVDcmuf5eF5lgKFiQGwke/Q4KtCvVqxXmZTDww96KHLBKFHc/qa
	 UFYclIcfYwFpM2wPY+8fg1mGXMddOcjTTGurRgk5MWlb1c7UIpN70OUs/dPtoI9YKc05p
	 RDJ506BqGVZVlfr0wybuR8hEH4OrvbHxe+AejHOmJyThwZFgTWiw7WIram1/3Lu3QFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hrf8xgbw;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA3F606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 05:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CA3F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hrf8xgbw
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a070781f63so1565529b3a.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 21:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794892689; x=1795497489; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=13gdahQBL1UEvhQCiEH01xvV1ZJPqsjiQpx8OMA7kwY=;
        b=hrf8xgbwoi8ycBJPAL5xnjFo0HePAQVnJbRZ0YcjceGfpjoWkTFb5xyStGWGILwGyn
         ZaY5+TpO0pirllPcHQBk/CFw6oc9FA3p64FPeujNsFVTcgc93T36LjIqUXUs9/fmkfdG
         hYy0hkDCLnQ3CVSfIJY5QzFI4Gdn7EQjE0U4BDYFdm2Ugf6fGQffTNPlmRO0niJOxo45
         N27zWwom/UW2ih738xjdJyVT2dfNYcQms8UUVqpndA2+VHGeC1DbyLTqUTdxMyWKUBEp
         jQ48ysbrMH5NdA8uRc39Xy7XndG31X66TPtFCuHLFbeXAA2gwsZYSZmL1GnOHFukKda/
         3CYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794892689; x=1795497489;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=13gdahQBL1UEvhQCiEH01xvV1ZJPqsjiQpx8OMA7kwY=;
        b=1SN53+sijcpxD/+Bnkt3e1va+INyP4jcZxJWzldebP5a8VtreBmdstJgUNR5rgDg07
         WOQn9+xbHCex4RAGVZrKO+P5X6zzdFWcZ2hBckuBxcTwh7ldQCZdUelRaYPbNNDBhoDl
         2FRozKo6dffgVCqWpYo2Dz67b0/jxyopwGvRXCz3YL8DHwEK6Ba5JSf0L2T6Zrzw2amf
         Ws473hx4a9Xxs3uhg6GN8lAmmi809gd0XBVfMOt7hBg+zUx5DfheWPSt0+qlLKO4DVaQ
         rV0CW3bKFPDSVUJ7LlwXimykyDa8i7oVMOiQ8mbB3bY7jqda0uKMg899TIlIqhR9p58u
         0zxQ==
X-Forwarded-Encrypted: i=1; AL+hErGn0Ko/r3cMhp/K9Ynb60QrhP4XHIliknNFCTcBmwUyOP3uCRMx/8FQDkQkhxiu+FPVVhs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pFod++NtHvKQkrmdK8KtP80MViPw5UOI14YiBVRbX0orsrhRC
	VddKRaVpFBIHjlvqX9yRSq4f32AJXePmu8FylElEgPS/9PG6R7sdO1sO
X-Gm-Gg: AYBFou2qZ/kdFHCHKaMvRveUKIBLGCZzBw/WDgDbehBPcBdelr4okie4kJqn+iBV8r5
	yATWw4nzaRCm+il4IXaZ0HSuL7B1DdPvyAdNkg9oDx5xdQJ7hChR/Vtq5FN0GmYUR7ZklLFvSEX
	ks46MO5W+E/1yJf0H0amvJ8cdqC0WAATgmv0RhrRmV028nfB6zTMRdzvhnAAlJMLoThjp2X5WT6
	ldIldKgmAzHxeiTWd79ux+pOPH+txxg0srYmGRt0a/nhGGpNLNB7rELg8RqFu5owx8tI3gnUVrj
	1Ad4Y6LnFjojCsGIthFQoWP3gNBRTYEpjXhpislRFa9Dau00XwvzxIlNtRBXhTowGQCFzvEWQ3l
	1SC5YvbSuxJ4g/kyZq6WUa/TarsvOcdCm1xo/xYqmvY+mjL6y9tI/xen9+OaAd8U1D694Ob/3TB
	Qp4HOe6aW7MKhDtdXiDlFgVRZAvbXonmziBrtR/fMGWTt7GENKWOliRbxC6+8zr52M4NlewBS4v
	JlS2fDju4x0f9vVh1SCHCdH9pJWivKrLI8aGkjZhRItdBCfJQAHL7M8DhPvvOJDuQ20OahMAWpk
	FyWwwKDyYJ+gzTT/49nqJFgtHAPVlX0EmVh1/Zhkm/z7BTVUN9j9xbRTHcAqY2MAzSUvukdZEoQ
	dU7rPdoag1atV/Uh8FN62FT1+KmBaY5Yhc0qi485MMaIAE8eks9wxC3w=
X-Received: by 2002:a05:6a21:7748:b0:3fb:91b5:2e2c with SMTP id adf61e73a8af0-3fb91b5332amr4168597637.66.1794892689259;
        Mon, 16 Nov 2026 21:18:09 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a7edbsm4491339b3a.18.2026.11.16.21.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 21:18:08 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 05:18:08 +0000
Message-Id: <DMX8CTRXDMKG.2SGJHE0H48TBK@gmail.com>
Cc: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Tejun Heo" <tj@kernel.org>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 00/20] BPF kthreads and waitqueues
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
In-Reply-To: <CAEf4BzYAS8V=XcULjRvL=v0ffn6T_HOQVAxDkBy4mC+mwaQ_Uw@mail.gmail.com>
References: <cover.1794269506.git.memxor@gmail.com> <DMUHWUF1OF82.3VM2D2YIBY40V@gmail.com> <CAEf4BzYAS8V=XcULjRvL=v0ffn6T_HOQVAxDkBy4mC+mwaQ_Uw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 16, 2026 at 10:31 AM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> What if we allow creating dedicatd "BPF kthreads" that would have
> "exclusive" BPF ringbuf (because it needs to be single consumer) in
> front of it, and for each submitted ringbuf record that kthread would
> run an attached BPF program. Associated BPF link will keep kthread
> alive until destroyed/detached.

Such thing already exists today in the form of cpumap.
xdp prog redirects to it and kthreads handle the traffic.
Such ringbuf+kthread setup won't work as a replacemnt,
since ringbuf cannot pass xdp_frame pointers (yet).
Another analogy is golang channels.
if we can make them generic to pass kptr, then sure, why not.

but pls not a kthread.

vhost moved from kthreads to threads to do proper limits.
commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads").

There are also i/o threads that io_uring is using for similar
accounting reasons.

