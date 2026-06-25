Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406233D1A8E
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383166; cv=none; b=W4LV6Caote0Lk+mIHT9lfwvmg1BxKD+UpGwpgcyIpPEVxQHGH9agj/j2BEdVKNhWxgy6+GKrl8NMqQd8a4WPUe8ClQbKuDxjq+E4hBd72/DGaSatjTcexx3SlMHPGA8/v/0ejV7NtuK/SjCXgUNg5xcZzIjeuYQRztB4avbuDyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383166; c=relaxed/simple;
	bh=gZJhMFqy4I6ezP2HT/LIbAUJXB+rj/D6Yp9nHhyBcCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/+pdoSx5gmcVbO1EaLYJb/XRjK03DuvR6BDbBnYRHQ2K+kaHmhU48bEGHrx+JvU3Vji1TmElkA1ex7Ks1gqJiXDH9MAWv3etOaqD+vvPZvcS1BnR8Ig0Z2zx96JY6RX2btTfwUg2f97/irDyzpUG0yT2PxSlRIo1+Iy+a3KjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IW8JAUfY; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW8JAUfY"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c9254669d0cso742165a12.3
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 03:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782383163; x=1782987963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZJhMFqy4I6ezP2HT/LIbAUJXB+rj/D6Yp9nHhyBcCs=;
        b=IW8JAUfYHQ1Jm/9ZhE4pUtV7FFsyDLsN4l7rsB3yzK6i6NIhFMPfCxyVWspNP35PVg
         lML1KBjNsR3kXwmCroVvKdOMowgnfNCP2DIA5sAJ4Auu9HObwueQhk5O+o9YawzoqQVI
         Kw0yR299uONl/SXckJuNCEYwXwBX4KNRQ6Mtkn/gaQHhCrIGI6ROY0rB0Iklxz3yrNhk
         V6DlPB9Uz0HO2015zICGCQsiy2I89j0AFVcuB7nxB/HNF+EU8vnp/W8ersAEZsKS5uRB
         2YWHVMpjragD5XYJa7SzpemMKOTdEujQN6/J5qvj+OcyfnMliP0dLhG1tp+rx0YfFPQz
         TWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782383163; x=1782987963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gZJhMFqy4I6ezP2HT/LIbAUJXB+rj/D6Yp9nHhyBcCs=;
        b=YQSkaeAL5Em8fOv6tQJ66VpmxKFXJAbMvGxWt/tgGLjnByiNddLB9gxe8zemc09IbX
         K3XDsQNdoiYqlsE8o32qx3KP0+gopOIJxKCIULwcBw1FvcnRE0c2fZwHw5wb9/1YUMKi
         vFcAMCfsT7RHUdg/E/243DcW2MoxNTtWbZLwJuBcalW3kooXQW3fxX9UDmaw5bMAE6iL
         CwRzlE112U1DAWXNANYJlnul9zVawopi5EEDeLCCmuv5wSRVoNkpt7B2hVhr4u1RCACR
         MgQ2n3SSS/ue9O62h7lmnxcoK8BS15Wj5VarCPwS7975JFbl4P5S1TvvHNTuO++UO42F
         I3Qw==
X-Forwarded-Encrypted: i=1; AFNElJ+kmHZa9wgbFSSlM0+i8Zp0zhZFyAfxjeaBJRiv59jMG5XdIGuWsFX7pKRUzcrx0r46YOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGERJRUGJD5vaMU97Nx3ShxNS/AAYj02yrbJ7S89QPzcHjXoVA
	Sdyc0TZRNlR66S1uLyxwaSyg9oRVbMTTIdtTOyfwZh+qroM8EJ2JeHDN
X-Gm-Gg: AfdE7cm/3NXhDZWJf7oiN5FoiubbLMugHqwo7Whnot3zfqy2rrNHlworTISNIf/qFUF
	IADNYECX3VSg++hIwcdWCpBtOYSYAmWhGvkw9+vYb/A5bUJfmrDUW6lm+EsHi7K6Zz5rOBKR2Uw
	Gzrr5x7vfry9CnaAt/9hv/Dl9Dhonc3JkXyIx0PrBL52yEVcO4IVZLBIxI6f+mwR5To6Xw+s7Fb
	Ma2ljFYoQQGwzz3IY5f0bqVrXCeMdes95Hibym58nRB7RN2xO1igTQIiiROnsKpzTMIWrnN/wJZ
	OUXgeA0LgJxLwcLMvi2OKulHfeDEnQ4wVgpDJ4XUEdPWUt8I2WF5YfHjYqysLDM92FPYi0Z3usy
	PD7fUsX0JV2yuDCPBGdQP90m1sDjHjX5UM7J5OIY2RJ6Hw36MRV3aTmkYz9o4lY2bWN+z5exxxy
	OyrQ==
X-Received: by 2002:a05:6a21:482:b0:3a0:adc5:52c1 with SMTP id adf61e73a8af0-3bd4ac9d9c0mr2281062637.11.1782383163370;
        Thu, 25 Jun 2026 03:26:03 -0700 (PDT)
Received: from laptop ([59.6.68.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92b9cc8496sm1394077a12.8.2026.06.25.03.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 03:26:02 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Preserve scalar zero spills for var-offset stack reads
Date: Thu, 25 Jun 2026 19:25:59 +0900
Message-ID: <20260625102559.231045-1-random6.xyz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAADnVQKTMkHwnZb-VjCErqmoe4O4=aT1vjMU8XcZiWpNG-LhVQ@mail.gmail.com>
References: <20260613-bpf-stack-var-off-zero-v1-v2-0-a324af0f00ea@gmail.com> <20260613-bpf-stack-var-off-zero-v1-v2-1-a324af0f00ea@gmail.com> <CAADnVQKTMkHwnZb-VjCErqmoe4O4=aT1vjMU8XcZiWpNG-LhVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Yes, good point.

I kept the eager precision marking limited to var-off reads because that was
the original reproducer, but fixed-offset reads have the same mixed case as
well. Pure scalar-zero spill reads are already handled, but a fixed read
spanning both STACK_ZERO and scalar const-zero STACK_SPILL bytes, e.g.
0000ssss, still falls back to unknown.

I removed the flag in v3, made the zero-spill handling common to both paths,
kept the existing pure register-fill behavior intact, and added a fixed-offset
selftest for the mixed case.

Thanks,
Woojin
