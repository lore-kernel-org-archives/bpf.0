Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE506430CDE
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441922; cv=none; b=aApMpCtZWeiy0iahisjVwIhKX8GjBL7J904tMALBeas6gpV8+Hlqli3VKBF8xq9kiTcy0QFp6klJwKV8gGWRz6Z2vJ07CLw37kuycZlIGPmHimeJeP8ZgPrwB8AYAa20XIZzN16ub3CPFgYQBieAxLt7Pc/193t7Bk0ExVjBTns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441922; c=relaxed/simple;
	bh=gGzx3dFnivTgZ/tqWbN8NHW7o1lF8IcUldK8xxPVITk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s3Jcw39WDfkdi1gjHMD9+WcxRKHx9/K1tHYzs9YLI8uyXsEnXEa/jCphf7VEDSRSckiA5CbvyaxrRgTJtAHo4gEqBxnnZw9Q05y/tztbO3dUXSTMG7u6bJsn34BErspwehRojJ5i89CQZxOGZdeAWzI8Ju8fy1vxYG6AAbw9wXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nf2XwBig; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf2XwBig"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c998fd549a8so3033272a12.2
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783441920; x=1784046720; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gGzx3dFnivTgZ/tqWbN8NHW7o1lF8IcUldK8xxPVITk=;
        b=Nf2XwBighvz+M+jVqvufA156SYtvgtyTrExtGpKU+TnVjWFtQIo0b5SEK1Z1+1Z0FJ
         E4+Gqc7lZLrytewfHW9ldEcUdIwQQ1ONtcfbjI/LVNEh23VO51lquzwchaED51RblsTS
         Z551My8+l0t2sVKOBoidJ4P8SP0gzAuXzeLTzPizcz5oEJROYxHqPh6HU89tlaBBLkLk
         yyvv71W+/5oTe3vdZGUV+YmOL1EAto9R1E3rNOtDbr1Ts4iCppMusscVz67Hrafp+yMa
         em95TR173iL9RIZ3wvgnjoeESI7Vlc9Rimy7uS7Izly50a1FU5EkVHXqlJ+F9fOyxP2J
         aV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783441920; x=1784046720;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gGzx3dFnivTgZ/tqWbN8NHW7o1lF8IcUldK8xxPVITk=;
        b=QAFW12uT0pDPFrlD0tzeFuAn7BRtWdpLft7l14xEaiI/g+0/Mjvg62pWl1jxMFp1Ud
         CCnFaVR0atXGKb+oPraiZaDpHOQvpqp9OJTyn9AgsPm5DuR0GwpyNo8J4CGWlzO4XJ6P
         yXxLBqxET0AJH5uaNq1yWuIm6y/ZaNAhEpANwvmq6eGM+nHRCa7SI+pevY9IYlYfMnCB
         9AtP470Ye0clXkFNtu1DgZV87HCEQpEUM722uvcNILAUECn3fNUhmkbIydyXuFftbE33
         OYHonP87nKd9yPbk983W0A+dvJwR3WpZpRxheAEhZjq1/k58MihBMqW0APfW2fOW+1Hb
         Q6CQ==
X-Gm-Message-State: AOJu0YwXrCbyjMbr5qRRF8pLbTc3rs7ds3mxQXkqdNeWCTgNjnas3cCW
	g6IqzXkaYLYwNYOO1hBcsmNDzZfYaNQKoDw0SQdje/s+2FrR2V8HeZ6F
X-Gm-Gg: AfdE7cm5VTTXETR/ueCz65P5xT7axjr5vRzDygQJSt1UfpyKQSBrGbV0BZIUmXhWrzo
	BKjofT4xXEG/WQ7HcBn08aOyck5xpqyB7SZMfNBkbDpku30sLZGcKt6pmBHRBl/fUPs2GZ+qfES
	0nzFuumWQusq/mw3Lbph60RcFMPhKUyc1cPbrudxZTKq8obi+exfhW4DCTbv5hKqibhIpL3td/Q
	gZV6SSUt9jxJjkGczMvms4jQYH8+tA1UIT89nnatxMeLVpD2VdIKWfNPiqqNkp0GDuYMMk+Y8gE
	OM2MJrnUXGJjJDdEd+tDqGWxeYonoJ6be2VHWWtS9en7Bs5q0+fL0F7DCoJAH3h71qkY8ZbYlgH
	nYyRH86qOPHItn6gS9nw64dHjpqgBS6/kh5JNW6OzQjb6AC0EHUcsCV04YxC5rtJRs9bii3vPKJ
	clPbhnz5P9/8rV5AzkjQVo26lIf4MAeAUdRiTTvQEfltaY2W0WvWJzc7Qlfu7HK19i41zaGw==
X-Received: by 2002:a05:6a20:5491:b0:398:7df5:2dae with SMTP id adf61e73a8af0-3c08ed14361mr7575416637.9.1783441920227;
        Tue, 07 Jul 2026 09:32:00 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84b0:ae0a:5cbe:26bf? ([2620:10d:c090:500::1:76b9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm2489902eec.20.2026.07.07.09.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:31:59 -0700 (PDT)
Message-ID: <7bc3b23e96b502f9f5aa7012ce1b671b6d29e996.camel@gmail.com>
Subject: Re: [PATCH bpf-next v8 2/2] bpf: Reject programs with inlined
 helpers if JIT is not available
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, Tiezhu Yang <yangtiezhu@loongson.cn>,
  Alexei Starovoitov	 <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko	 <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>,  Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, KaFai Wan <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev, Puranjay Mohan
	 <puranjay@kernel.org>, =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Date: Tue, 07 Jul 2026 09:31:57 -0700
In-Reply-To: <7b8e9361-2fc9-4302-b055-3657b19d2272@linux.dev>
References: <20260706040006.10331-1-yangtiezhu@loongson.cn>
	 <20260706040006.10331-3-yangtiezhu@loongson.cn>
	 <abd697d839043d80e0230d2b9ab30b214dfa34d7.camel@gmail.com>
	 <e86ba5c0-41c2-4492-a316-7693c7d8d3fd@linux.dev>
	 <1c1738784ae321ed5c9dfa0aca6d0f483592713f.camel@gmail.com>
	 <7b8e9361-2fc9-4302-b055-3657b19d2272@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-07 at 21:42 +0800, Leon Hwang wrote:
> On 2026/7/7 17:27, Eduard Zingerman wrote:

[...]

> > Meaning that you'd prefer the bpf_get_smp_processor_id() and co to
> > work correctly w/o JIT, do I understand you correctly?
> >=20
> Hmm, no. According to Alexei's comment [1], we should reject the helper
> by the way of this patch.
>=20
> [1] https://lore.kernel.org/bpf/DJN001X0S57Y.18CKUS4NDDQT1@gmail.com/

Ok, good, the sooner the better. Thank you.
