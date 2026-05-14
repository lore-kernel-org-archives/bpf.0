Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE473955D9
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778802788; cv=none; b=cZC5ZVu0cRSqBuce2zPUBqgSZhxDTlOAv1FuncRMV85HikSWlzm5Dbbrkv2ye+4dYuBfn/G6iSXV62YwOg8C/ZrvSXYu6WXQhDluMvl4dO3u7fdrug3Me8AcGU8EbrrRHAWj8q1zaYrgop00SBp3dOETQACDH1HZHP/fxAmvA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778802788; c=relaxed/simple;
	bh=UvdRbC8jUBDV33lfrnNvsXrTdT6g1E4fM0k0weB8Ggw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Kf75gAqNlkaGhFuQLTnCwG2r+ELhIWi8z5JeIH4wpZUPDBl1c83aLewmzNTn5CzzFm6F9qSdzNY4wgmz1BrSkU6wNNDidbJvlHdtO3K4L96tUgFoBerGyHY7n5BvemuhH0WgZy1QiyoahK4yChYofd4MmKrFAqEeMb7xDbyS3h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7YaY7So; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7YaY7So"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-651b4d09141so865863d50.1
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 16:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778802786; x=1779407586; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iuD10elVxgTA0PqZVUaJi+8ipszlnLhUY/UUHkr0RA=;
        b=H7YaY7SoC5P1iJZwddq4ksoQU3GBLvG3O8TK8HgJ34/C/01NFQ20+GixHQAw/SoEE+
         qddcqcOl271PocYtZXdGhpy4WK3I/bwkjJ5TSCyRLUBlcbIFBZXXTfmACAeY/jcHH4Tz
         z8yBQAu5mz37WzcPLVQMGxRJE+wOdj8L1fQ2qXwBXiWMjPG3YjqJtHVXfzINDRiqwxeG
         LRy5NBsxtMljQCQTELamFSN2he1d9+V+kMOJaFw2qAYSBm6HizhzGsx6bDzhZ7NGDUKU
         ExhYrOPk7crV0BCyDheJ+G4iyI2LXb9lzlpKDNC/RR0lHIH7fAE7Xf/YYgA8N51u0Jaq
         JfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778802786; x=1779407586;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+iuD10elVxgTA0PqZVUaJi+8ipszlnLhUY/UUHkr0RA=;
        b=O1i0dNLLtHrEXNkWTYVrVxmwK8vEinvWPk/WcMNgl+8JcvpzR7Kx6y/JTuLlUdMDNC
         GrW3Qd/lYCpcVnXLqU/cu+oN5IYqEYT7LG41RPokwAXuBfmLZIiD5oPOxfW85TwtWIkb
         v3OeiMl1+B8v6JNB/mIziIvUyPi93JuRGzQ6Hn5lmR13RVvFnwkd6/ofyZI8T/IzpcAv
         KCKOsRblcQTp73+jAZWACV/+FRbjcYdU0vEddfMv4KLmatWpFnkTkdkSpFTUayi4VrKk
         yx+0hm8o2dk8DpK/Rb67sSJElW3botwlHd+/iwjKZZuy5aUzhE+vV1sZ4S2qxgu06kwh
         EK+g==
X-Forwarded-Encrypted: i=1; AFNElJ976p64qy5r0gxtXSDnN+G96IGGt2jAIo+Nxwctrxobz9eFDKfLCQVHqTziAlrTYRG+8iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4TyZTCY4yYHTwqkSGl1Y/xstz8QehhvAwbRDMxqNmGLE38F+
	bOBfXD5sC+QXPj1UuoPBtRDskNvETzNF55/DmRsxhAIG9trK6ie/AL6M
X-Gm-Gg: Acq92OG1ge5bgf9bkYGRtquN27QNjgc1KSkF5WQorOHHnfU/4rS1ou8lH7t/UWagY03
	hgVv/cxEtTRTIxpW1hN6O1XzPvfS/cRucLHDOEPlUkLMEmmURNkj68QLG1S5vXl9c5BQH8r98kn
	glZFKIuzfCCgmjZ6eJe1R+kX6CQgGO/tCh9RIpgorhdat7y0nvi0ZMkJhNAesnU21CKJ+HQjXaj
	0y0pNoTjt9qF1qPNA6+rLJ0m7cCKawQe6NUrOkftohQdBIT4jdlwV2WAd5L0qlzGBqEZBxjIn4N
	90xqEcVYXPXTWVj5eDZOHUnPjCYB5XZPxyZeW0U//At5CSQ5V+/R3caKi9QIA7dLk3NHLkhuBGv
	2bNpOE9lHOCRFTYAok1XlV2R8g51PJAjOjmlLHL2Mk3pgFAtplugIN0vLVixsLeFD+ZBM0wGU6L
	7WPtySqCrTPdG+rMdnJKvBFQjaZeqPc8pgYQHNi2MzP9hE2Psic3Ik/HSUubVSP2FKyUygaCDLC
	Q4IP//X8vEYLDHTpw==
X-Received: by 2002:a53:b451:0:b0:64e:e898:10ff with SMTP id 956f58d0204a3-65e0b29c53dmr4017421d50.40.1778802786371;
        Thu, 14 May 2026 16:53:06 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:16::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d89b124sm1792834d50.6.2026.05.14.16.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 16:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 May 2026 16:53:05 -0700
Message-Id: <DIISYMB87J47.2N64UTCAGDXFA@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kernel-team@fb.com>, <martin.lau@kernel.org>, <sashiko-bot@kernel.org>,
 <eddyz87@gmail.com>, <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] bpf: Validate outgoing stack args when
 btf_prepare_func_args fails
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <yonghong.song@linux.dev>,
 <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260514184827.1619863-1-yonghong.song@linux.dev>
 <b3a04daccb7920ec037fa1e814c82d13b626bf24ceed7e03cf54624f9bf477de@mail.kernel.org>
In-Reply-To: <b3a04daccb7920ec037fa1e814c82d13b626bf24ceed7e03cf54624f9bf477de@mail.kernel.org>

On Thu May 14, 2026 at 12:37 PM PDT, bot+bpf-ci wrote:
>> commit 284cf62e75bd5632d61c528e48fe3f738870b269
>> Author:     Yonghong Song <yonghong.song@linux.dev>
>>
>>     bpf: Validate outgoing stack args when btf_prepare_func_args fails
>>
>>     btf_prepare_func_args() sets sub->arg_cnt before validating arg type=
s.
>>     If validation fails (e.g. unsupported pointer type in a static subpr=
og),
>>     check_outgoing_stack_args() is skipped because btf_check_func_arg_ma=
tch()
>>     returns early. For static subprogs, check_func_call() ignores non-EF=
AULT
>>     errors and proceeds with the call.
>>
>>     This causes the callee to read stack arg slots that the caller never
>>     stored or not initialized, potentially dereferencing NULL caller->st=
ack_arg_regs
>>     or getting no-initialized value.
>>
>>     To fix the issue, when btf_prepare_func_args() fails and the subprog=
 expects
>>     stack args, call check_outgoing_stack_args() to verify the caller in=
itialized
>>     the slots. Return -EFAULT on failure so the error is not ignored.
>>
>>     Reported-by: Sashiko <sashiko-bot@kernel.org>
>>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>
> This looks like a bug fix for stack argument handling. Should this includ=
e:
>
>   Fixes: 3ab5bd317ee2 ("bpf: Set sub->arg_cnt earlier in btf_prepare_func=
_args()")

fixes tag is necessary indeed, but please drop 'Reported-by: Sashiko'.
If we start doing such things every patch will have it.

