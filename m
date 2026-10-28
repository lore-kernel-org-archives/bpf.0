Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.139
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793182847;
	b=sId7Ut9U6DiJNeBVwofCGQEIYED0Y4oHq66i3dr8Oe+O9NAVFLwyCnkH538kobJsfT0J
	 0fq6YeEFkwg2E/JjLQpX7gG5pps3EwiifT0wC9oetlav8ClasMuj5HF/D8keSgdkDhOAM
	 GZ2V07ofuN+pAzJkLDakSZkfW7DHmDfwRRK/vcWIAyal26X34puCyL0M9mGFJUUWlXFB9
	 Bp8VCOW9SNUtLI0NQXl5TSeoEPQCawmMxzbJRtz0KRxoCXPigwth7Rk/8HDNuemcoel3L
	 wBHzF3kxVrZmm13dI316mlEEmoJTp+avLMz/AkCln/wljKLwpG5AUWYz0QzWc5JP3FQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=QfNvGJSl7H175k6Q4TWKoHQY5yn/6iltV+8UhXFE7eA=;
	b=RbbvOnSOyG2NX77Ku08ATixmqcsjdXy9BpUVk8Q1ViLUAvmqV90PJXHYZKEFkI9mosz3
	 ZnJ0q6yBgiEbEsI4IKXxST4WfBW88oRmXfigCqsOAHSyaFifr+vawrXZBFJLEMz16zb7p
	 1zlmQixpFyCEbwvD7U0YOTylqmPcKGNRjvYRlSLPWJ37zRYBHeaqolVDG1BKyBYz4L79H
	 MT/f0GxXunRg4Xot7HniT+aiJbG0X7bikxkF/R3xmn0cbdQOJ6uIijFjVUHsKaPDhmj3L
	 aUVNlzCem/PGyr6u5pdH3h665BX0DdWu+S9NkOL/F4dwMZype63pL41WOch+mEnTEgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KjNd6RLY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E284606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 10:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E284606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KjNd6RLY
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a611dcb60dso2084275e9.0
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 03:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793182845; cv=none;
        d=google.com; s=arc-20260327;
        b=JJzPX6ov66zgqXB4U1xrux4RM04joSZSQvxL6KIdn6MgjvCzAKJWwZbAi+RfCp+ET4
         OKsI2SdtzqUcnclNQTCJn+gMNI1PRdsNopPMK81lCSoZsIQUegwCfoCZDju8j2pGwyC4
         EcnJ9Tu36+E1hqq3/ic1G5uYDYWCbIxCzzxqtZzKrLqImVMWOPoE022+IqUaxcUGbWhu
         NnMcUNntsX6bjh8iMXEg0mRn+FAGJwOTE0FYJzVSpEPpol/6IgqqVi5TRCL8ADYwjWXU
         YPwdChTuCIziYSycMa1S03geHCjk6jtB2kguIRnaeknEOtrSgjwVfJmYrWf2K4wLOpL9
         54/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QfNvGJSl7H175k6Q4TWKoHQY5yn/6iltV+8UhXFE7eA=;
        fh=ogoijjMSDoSJdjUdjbR65PhK9VE6buLokffzXV7BSrQ=;
        b=X/1f8POBJ7GbuUgDiewnkYpC361Aj3f96Al+RRgyQRismEiuTqw/leNXrakpt+e/y9
         7UK28q0Opi0teyXwwnuf9IJCWKzG2YijsNOyDh1eRUixLTZIJ1HRugG/acxjMYSwYDQz
         DKNoHbyuwIXcJZ/iBv8yTNOkjAYHlAKuWcECz5CX0fVx01ZIBqyEgmsdNSywv9EabfAG
         7pX2p7OYVBw5/Grk8rk1D4w0NYapnYoVtSX4l001JMLbVQTc/zDKzux8xBkrB/sUDqKS
         m7oGj6PSW5UbOQwhDLe5rtsLC0PjsSD8ZY5JQQ3kXQPUUuO9XS8hWttGwV2FNBQo/sM2
         ZxpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793182845; x=1793787645; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QfNvGJSl7H175k6Q4TWKoHQY5yn/6iltV+8UhXFE7eA=;
        b=KjNd6RLYvmWnGp56bKsMQKQUaQt1/fBQkF7y+Wgu7kSyO7hQX105X+Zz1LZyUvk3Zl
         qdEdi9QletzZb78a2KDJV1lDtEM3Ncr1X7ttVWrHva0gN5C5D186MsSYG7rRJSpOcb3M
         aJP5a1RnZyiRJD/Syjd43rZvmkwhvk3yRYE0frpN7mQtoPup0LqJVJa/LgCkDWbExSH/
         GiMU+YPiare1YeCy6W5ZG5UdTi6J43o6g/w4HwAi30qBMYj2f+hsE6psZ6JCqHJVIEHA
         rckgy6HmijY/o5npx45b+6uazv/Z0/2Hqo/VUc3GtsOYQQIKvsOiO7ZyCvyaGKX7I/sf
         012Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793182845; x=1793787645;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QfNvGJSl7H175k6Q4TWKoHQY5yn/6iltV+8UhXFE7eA=;
        b=j58pSV1uEUI50VCM4wP4uJZrR8nXj+CwmWlE6ME8XYHSiLauvkU7d2f/lYOxgyD9U5
         VYVNjZ8dZszbP1QSIT+WhPmI2Ua7AcfBQnWspa8ok5wT2922tfXmDkDTYTEYlVEv1+gU
         b2tITIFg2/KfkbBFaczp4VCnh63PjuqRW4FeyhX/TQkVhcGAkznuui5QXMAnwM/oftOG
         rYxWMiY9VCmaH2YFrafAJfYTx0A1RpwZbQ5tJV35evyXrEgJ5EFgv3kP6mSSeY//vClX
         MHDVy0jMU/bqvQog8Vkn3LJkq1rrELiPm1mlXCewBIy92PVG99aXlV/IINyNILl1bxWJ
         LonQ==
X-Gm-Message-State: AFq9FYKHaT4z/rwuljmtIcSDpaPteTGOUD+tJSM8oOpGSRMgcaeU8eDt
	wic0z6oztJMrd5H2AOfOsmLX9+xbtLYhTf1BkyXWF5Hz3G6kqo6rLQpHvTl2DpCrPpGA0xccJIx
	U6hkkEyuU5nAJmBoLl2T0UlYBzHrFI7s=
X-Gm-Gg: AYBFou0Y6UePsxc5dv1rM/w6uz6AjttPHCx7r+5mA3N6dPhydeQ2FObVwR3uvfWZdCU
	9m7iBKa5ZhjdpbBijchlQ4YWMKlG3zqbzDXoMeBZJzb/aAHyHkvqThrJBxsLAZt62m1Fv6DEWGC
	QgNk+0cHhojwblvUU97Md5qHi1TiEFegcmcx5wF3Vzp/+KFrqQ3/WedrPIcFo5K66A3KBDezPKl
	VT2VI6jDXygkTkXB9MV7C88+B2Op6wQmFTMxv8geJEYlwspSfCimV/uwPMfgpSMwUOxM2DcX/yV
	sT/EG/1sI4qb12/RgVzTVs9bPZxPoln7VBhIhi+D8DjsOlYgjBClvVd69zSO8pYmGeZEwL465LU
	eW8gRuQPNGdlmxbr1VpSeHYXrQqJE4pCDIiG8lwsO73yrne6IbJnFrt2Jo7q9xMgr3z0noXxR08
	lbi68Nk/UTh+lRaR4OeBeVRz5pzZMV9S/LamtJWH3mQRnii/cQFERQje7b9Q5VhjEAGXU7QMGY9
	rA2d07aDjNMwYZ5
X-Received: by 2002:a05:600c:1d1a:b0:4a1:f688:a5d5 with SMTP id
 5b1f17b1804b1-4a966c41de5mr36257645e9.23.1793182845166; Wed, 28 Oct 2026
 03:20:45 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793147364.git.memxor@gmail.com> <DMG7KVUM9TV8.3QO4MU310J4CU@gmail.com>
In-Reply-To: <DMG7KVUM9TV8.3QO4MU310J4CU@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 Oct 2026 11:20:07 +0100
X-Gm-Features: AclHuK_01HbDqinnbPRNOq8kLdSiwRHyb4ceQdOVa56vWRxFaxtM-QrrkRnk_m8
Message-ID: <CAP01T76uO4ULjNOQ217jXTLWtP5XT0rvB7PZxt8MJcoc==GBEw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 00/11] Unwinding for synchronous callbacks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Oct 2026 at 06:06, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 27, 2026 at 05:44 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > Code that unwinds due to panics or exceptions doesn't often control
> > where they can be invoked, and reusing the same code in callbacks would
> > lead to verifier rejections since unwinding across such synchronous
> > callbacks is not supported.
>
> I feel that you're too attached to bpf_throw concept.
> The code was quite intrusive earlier and it is still today.
> I told my agents that bpf_throw is a dead end. sorry.
> I really think it's not a kernel job to solve it.

Huh? This set is about making unwind_goto / unwind_exit work.
