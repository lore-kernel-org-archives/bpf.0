Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D875CDF1
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 20:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779820; cv=none; b=Fr6c8WVnHxXOvdTGrA2swRdVAN528bgavAyO6WfMaC7rw0BBbqF4bF804Dfi8zFNyLgxSEMcKdI5W1AXwlttLUCFXtvfxFubj4kcm3gDD/xmhwSmgkQrbOp0j6m+vN3iJyxQ8ffaS5IWERvLBp/b8/y5QA2RPtwjZZz+yFQNuVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779820; c=relaxed/simple;
	bh=l7iRbWOapqJIgTTLs0cMbEWXxOh8y44iHzOGBy/vIY0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XjEvvsBcA51HTy0HMc4znz4MuwBfhrk379uWy3UHRcLjRFM+U63ZDQPX1BucZyj/ieFhlw6YUGbJOeror8QEhCxE9wD5T6DTgvZuw8CStXSVPL4HYr6QgXNL88jXVKyeGf+cGvYuOoi/+3h/aSydwqkm26RJ996C0BnmApCzIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LmleBf/B; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LmleBf/B"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-67bad873c3eso3884040eaf.3
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 13:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773779818; x=1774384618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW0CbBVgs6GdN5GrP/J143ogxV5NC8azmgNbhuQG6XM=;
        b=LmleBf/BpT3n7k45oD2QvrBZXhQl5BtVmj6BomSw/3eBW4zdbMWd41i8pLTnLh9ZQ/
         QsxboWMoHDD1xs/CYMZaoarNu3NTtIrYVvjGoLyqnclaCiWRPXXYozIt6Pgwh1G6Uxsg
         wi5rM1+pySlHsF70Pmuo16bzlo/8BEj1chivLsl8PlV00sbNAz2jTeTwJBWJH0ONL3uR
         thtjHyhFSqxVjxLlN6Hf/fszj0FMNTI27B7PuLV5x+jO65StS6lOZM1VzHGD+xjNuxMW
         w6N2PxB44CfREyMl6688BVJnUi8BCuIz4UM8+4O3Egv/MyPQDiqjFHk5+xTQJ4AAa+1L
         G4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773779818; x=1774384618;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JW0CbBVgs6GdN5GrP/J143ogxV5NC8azmgNbhuQG6XM=;
        b=gMi4BgsfIJryIxWqRifagMzYxhl+GaQvsldoCWCeg2+jvRyxlyTRqvhstbtBXWJQAx
         igWc9dlmDlgRnEkasXnoc3iTK5Py+slicgx1YVYEb/XN57rdzLkH8v5PYOSCPt/hqtgB
         +NxlVD65uodSxr8fQH84D/YU8+2a3Mb/k9cWfZGbfDWzmhKFWSEmITZnRv+yaswMl6RG
         joAlpkTLqReOqI1UsZoDFHu7v4ZEdGlO/pbgyxVcbcZTHGTxw2EnA52pU7bnSnOj+J8C
         WkKM/AKwvdwFF4yKFzzZNwkUIwx77otrqo8e6erQm3O0g1PQXz1OulSTri+TYlOa8+T5
         vSvg==
X-Gm-Message-State: AOJu0Yxsv9FzpJHIZOW20z8arLJMhByFp8eIHzTjqhXUXuEo10mYFLGI
	fH++Qnzm0en65Ejgi4cya/82Lep98jKfdlFICvAhqyS33LeADBkyBWxbFe06M0J5amY=
X-Gm-Gg: ATEYQzwCY53lzR9qqscA2/ZwDPYlmKp/QOJ09h31XCGPjWWhXpPzajYpxlSlrNQG7Yp
	ygiCx4VNthYlhL6v3oJQXMhBZDv2qRhEQoMHVQoPBcrYAZDjprCKWsDCAylYBPQ3aXZzk/fVfZW
	S3N3vHThiz9oLkLLMZaZ6pOHPBw4rSJtPjS1nMA+AHJFUAXwKrPKlG1r4c0r2xKA/nUWDl0a9vq
	apHlWlJmBqCX5ltLF72wi4JmGvVb9W+vTLYzcsWnrCtoRw2jDNVLfcEZU+FoXBD4EnT8bGm0Ix1
	qK2c15srvH7aZ4PHTYrb/RqGZ9uGU+A9g+EO+moBxmP2dH5I1wffbhIjJuqAgb+g4zghDiBltCk
	KNQ13+94EdDlclZayLBpLljbRru1VWtPmdVdhxKpD7yoAPpKQjGiGW+czHxIK9QhLmlhUvcJmQa
	S1IN7vhpw71DGRD53nA9uvaIHqWXsEkbCtI7E+gdlIXbXf37aggzjU1ktU53XkZ5MlFIOgjZ9lr
	tM=
X-Received: by 2002:a05:6820:4c0c:b0:67b:bf52:9990 with SMTP id 006d021491bc7-67c0db27e83mr503817eaf.58.1773779818436;
        Tue, 17 Mar 2026 13:36:58 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c0d7e5b46sm461664eaf.2.2026.03.17.13.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 13:36:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
In-Reply-To: <cover.1772109579.git.asml.silence@gmail.com>
References: <cover.1772109579.git.asml.silence@gmail.com>
Subject: Re: [PATCH v10 0/4] BPF controlled io_uring
Message-Id: <177377981764.1008333.17403039550067431801.b4-ty@kernel.dk>
Date: Tue, 17 Mar 2026 14:36:57 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 26 Feb 2026 12:48:37 +0000, Pavel Begunkov wrote:
> Introduces a way to override the standard io_uring_enter syscall
> execution with an extendible event loop, which can be controlled
> by BPF via new io_uring struct_ops or from within the kernel.
> 
> There are multiple use cases I want to cover with this:
> 
> - Syscall avoidance. Instead of returning to the userspace for
>   CQE processing, a part of the logic can be moved into BPF to
>   avoid excessive number of syscalls.
> 
> [...]

Applied, thanks!

[1/4] io_uring: introduce callback driven main loop
      commit: 033af2b3eb19c5ed96825572105bca3611635ada
[2/4] io_uring/bpf-ops: implement loop_step with BPF struct_ops
      commit: d0e437b76bd3c979ddaa6205f5e9ad3e0f95faef
[3/4] io_uring/bpf-ops: add kfunc helpers
      commit: 890819248a8616558fe12e6c06c918ee1c3a2bc6
[4/4] io_uring/bpf-ops: implement bpf ops registration
      commit: 98f37634b12b17ad5c56db8fb63cf9d7dc55d74c

Best regards,
-- 
Jens Axboe



