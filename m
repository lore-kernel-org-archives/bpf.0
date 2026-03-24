Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C13C5DA2
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390410; cv=pass; b=ATfo1ULzC+sszlw2wX/hqR4Iy+sRFy8962//b31lxs9naub53vrahMrAr62E67M7a9TSTvSzxruYHxviVrdLqWRMkfg2UsUP0JDHocbyqSrhvqJk7pcOdwZHy/WRNxY1LD8z+ldUzj0WlhgIdMwLk8HbSCBuOVnxurImZdiY3Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390410; c=relaxed/simple;
	bh=RGqEPUJvcZKNdEgaWitJDvhyX+Xq/l6aSd15sQ1w4+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdRGAVKYquutN7EA7x6RI/I7We4KisAADb2+8WmHh7KBnCOu7XI2CTcQZYG/8hszkmiys/70PXV2ftMpsMq0x7YYxMmPo/9EcS9VvD62l6aDIrU4wOLVdBb9leqnNVWq8g/EHp9LoTF76D0W4WfkrfhjDiqoXcw3hC6bBFgK00A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvTfCSiD; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvTfCSiD"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso48881165e9.3
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774390408; cv=none;
        d=google.com; s=arc-20240605;
        b=XzFrQ6sRKCHZugB/XesmcNBnZCqKBz7UlaDvrHPVVdLDX+TLVA4DgNdq7YbEdBe37K
         x9W5TOL448ypivWSRFVAemqTpdYXyYbKTyja8S8CM3iR5SZ6/ebhVv4DItwnsEP12Rqe
         Er68p3uDBWraCAGsGSBNpw3tydiqGUzoShi4LX/fhc09HbL4l/zLjXlyhS/i6eZz4UMF
         OqMlSfbXGYkj1LqVP06o/fAtQuq89yfymDI8h56GYDaKtBWqVjc7FfmpYClNkTU6v5W4
         6+C1kSuMRsqkc73zOoVT3o5YV8wlvvIbbqYPb8GI6TkcIpSM4CeqBCZITv7T9RfTpeQx
         UGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RGqEPUJvcZKNdEgaWitJDvhyX+Xq/l6aSd15sQ1w4+4=;
        fh=9Eucqq5vQ5myrTLYAMkb1pusjK6Ea69iu5P+Jvr7ylE=;
        b=gI7WZV/Tpwz97qX9XnafRfC8/NuQJzxGJBbNpTyqkp6PxpLs58Fft2EmD+8Xk3gS7c
         EKGmMLSFnxGZo4twTrLUJJx5T92Ii0KmaWfgtbLcM5oQxSEHTEVhVvgI0xf2BVZIoZ+5
         ny7YpKPnFsvaaemshfAkMSlCn+3fCP/rVoWfc0kD/DtL6F+cV/T45UvAVg5wsyiJf6kv
         SajhDarJmOuGpPv8+WI2A5Q8Jlydb90L6vPYjXJQP7fugIsG6Cg68Y5G6Ut6sc4GO/rR
         OaQhyaeb+5MKVXnOZyXyNW8R67kpuK1Vh9jB1473dLz1ntz0HAAwM3oNiN/A5wiTM3Uy
         o8tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774390408; x=1774995208; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RGqEPUJvcZKNdEgaWitJDvhyX+Xq/l6aSd15sQ1w4+4=;
        b=hvTfCSiDLDUYni7mc6EnriNQyBtgr8vy4vUBaCRG22ipd0N3Ivn91csLfi5E5ispXw
         4L42IsHfZEHrIM7ruhixep9birtnn1p0diXc9YlI07NE5sZHBbj9QVdC3gFY6Pz3NkoF
         HLmC5qK2HBAxsvLdrF5WBASDTMVBj1ZqO8FP1QvSIGr9i+KMM5P2AZnvBzUrVzxZtHAR
         cF9X0iOXQ7K6EUGA+PobG0yn0OxdbLsCxcVbvYcGYWeMLCuV3fQX6TyrGXkZ5DI+7QaL
         13ZIMizQvVIQ0FCpP4fbuZFLwnYxtUhvMvdu787As9ujJSptCVOz8JAfDv0k3LeRZTzo
         p65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774390408; x=1774995208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGqEPUJvcZKNdEgaWitJDvhyX+Xq/l6aSd15sQ1w4+4=;
        b=GAk4Fczt7ljh5QTRUyxVcrbGwFw+t6K0H37DIwP2hdlxtgvVKaqCkAII7S0f77/Nry
         CzwYnDYUGVEypUJWrM8rVyIq8vO28atiRC0pNAGcyksPYniN+LnHp3gRmhrxO4vfcIV0
         WW9US51ZnrCe975W90Da6lV49klMyaCHwJXnhnigOFu9cBzaujYDXsNX0rsilWOhxfJZ
         rZQvUzrdkcudVvbhd22K/e4S4121l4LieIATa53MERiodIF/CcXruBd1KNteHOot+Zbl
         VbLpixllXso0d/A41FXyPZSsbQRBkGjrOTPHBjcNBAMaSPByfwCuFnZWk8P9UARxkuFg
         ZO9Q==
X-Gm-Message-State: AOJu0YzitrnvY+JpR6XIQR/syU0Pj5hTCsrn8auDUfcqwcWxoOUAXjb0
	6lRYNi9sx2VmamTp50iecKUeGc7QLXWgrVTwDjTeCf5TLw73xRDKl6gncPAb+SVN5cAiY8odEWi
	1/Midy6uvg88C63m+YrrGiUFmoMDj+8E=
X-Gm-Gg: ATEYQzxJJbF5rY1poZtWReRXihCE9/H5sxwK3VPS8+xepA6XtNg8VwOQEDist5J1WR6
	c1QPnaXndpbqZKsWjw74Yirw+6Xd2CCwQQLRPhNDtubd1GMjz5mhJy3uSBQV3OW9ZCZ9Q2c4VGL
	6Oc8JCqBWqdvsH3FmwLGQM1zvbonO9wemvpeeMEmvP03vBqxvnSSILzrsNEBKgW9MxMQvdQl1DV
	WrMI5GoSIc0pDZOOHirlt9VydGCt8nnz/FoQQXlk2Yo5T+EAU1kOLvHceVRG3J0iP9jnY/zmEfx
	55tTn9xRGdX48qInZ9XGutJZ+KJkrve6/lChS3son+SL2zApggblHuVXJ02g1TuM4qWieKYo
X-Received: by 2002:a05:600c:5395:b0:480:2521:4d92 with SMTP id
 5b1f17b1804b1-48716056890mr18881675e9.24.1774390407659; Tue, 24 Mar 2026
 15:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324215938.81733-1-alexei.starovoitov@gmail.com> <20260324215938.81733-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20260324215938.81733-2-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Mar 2026 23:12:51 +0100
X-Gm-Features: AQROBzDX_39MmGmD4AUBw2Aj1zGWt81XG6IURUGTlv-Yis7Xp1-ahc_CoKJSus0
Message-ID: <CAP01T76AjfLsHULTM-1suLNvWe2A-CQCebKyLqTGHY2hou8P4A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Test variable length stack write
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2026 at 22:59, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add a test to make sure that variable length stack writes
> scrubs STACK_SPILL into STACK_MISC.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
