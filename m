Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8F3ACA41
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026737; cv=none; b=H0pFp+OHE4+UAUjXZI/174I3kaoj3bWXleVeqepP4od/ach5jhXyoz3xRkcxp5ca5AVSJhzjM9u0ck0x0TNOxMQR+/H2b8UsUojM49943i2Kk5cVjzQLDiLEGzmA7Z5DPR6Ew9uRqWEzZDAbLlrIN2vMdlkC27Q3e5owPQw3x7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026737; c=relaxed/simple;
	bh=/qPloI02lgy1nAg779509SLqUwvVyORR2vbuu1BDry0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=kQwBaBXERgRgwiUa/WYpOpVnVxFxdm5aexMl0AmcYUjkSqLU+6ucF2/RKa+Vu3ALVTwkJYSZ07hkzkRwt5sS0hB54bsKRS48Ta85OZO2Xoz6bcmcP2cctuVyXqbXS1e1tRDJT9yHVXuz9fuPeD+R6Am2XKX3S1bgPeH/v4iTelY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0xLV0/0; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0xLV0/0"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so3014838a91.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790026736; x=1790631536; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fOy8/RNRzY1tOz6cQBgcO5pZGBDfnV1e2ekt+qahNxY=;
        b=O0xLV0/06hB5aERdOnFSKt/IrfaYLXCtd1sM5I+68/UtsnNxXNOTWWs2gh98Hp0IoI
         k5azI6WUE1HfrHi5MYPCaRFwtVCr8ns00qfDb1gnWXbNVrG1eZpkuAg6u+KuaeCjZDF1
         g30gft2UksIMulaYTkzlsqoV0pZJk4e8rRqpQIYULbwZD0mnwqxDpSX5br1T4dqrBpfA
         3NDkf/6P/IluFhVzz+8TlfMknWhZN0C4dW/4VF8YMzw2g1SW/lrLUP3bj21epAhQZApp
         E5ULKfyMrGuATsrsPX0LNgV1i3JGgjPUiUxlafvBrbH/0lUcK4bEMxtxFAdfjciag4h+
         aWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026736; x=1790631536;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fOy8/RNRzY1tOz6cQBgcO5pZGBDfnV1e2ekt+qahNxY=;
        b=In71CbgouAiFexSOheSaogtFHGCZydOsEXtt5h7GyDx++PaGSNrn0mPDe8YdqJgSIB
         DXRqrEtN4NfWBDNnJpC2cm1HL0hzW0SyZ5Tuc1Kc4vXGYwUJ97pFyWFgt10jF4pd5rj3
         m3nJw/wETlnIIgEE6rYgnXgStKVDuIhFZiWYAUi5gkORequkNOlJXHejaeE3UcPBe4Y3
         VlXJrb2AQjdjclNY7EFhBAHpAp3mHpRF+2qIXNrRFQSz2oIwGadFjOoCioFDVt7GDmmL
         iCTQ2xvNL6q0c7ryzSVRPtJm7MRaze2FHnniy7f/V3IB8SejF2HoSblV3gpGtZVJItcN
         qgEQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8iq2O7pYcc/Di691fEs4ANXIPMB/yfiEpV7fViZLrUrVe5eB9hScBO0LbQD7p8L6EEz0=@vger.kernel.org
X-Gm-Message-State: AFuF++kMymvCqcCYjHV8cS9gGXV44qu6QWSFo9cvYEt4h6kEx+ucul/m
	cLmFtcHT6eIBD4mT3oHO1MRVYdeyxw1tnTAB/UcU8BPWym4+Bs2PbkDg
X-Gm-Gg: AYBFou1aMvHY83sVLtCfYycpXRm/QUCSAMSYvvENP4GPDBbzOLq7EUkWz684J5s5lUv
	MhW7qKy6NoAuM3gWhuM6VaE9dsX5DTxIZ7FXD/+mu8aWOCdKN6CG82jNTy6D2pGjobbtRLZMhxt
	EtY4YnX3AkSV+Y5zWIAzRiX8UH2lxdMbqMPPQ40oWWkGZNxkhTG6I9T8uIT25AinXztW5iwmLqK
	hJn+DOay9oXtRh1UOah+3pYMqVTKnfBsGqIMzDaBraPzMPBen6rzZhF9yHsi3OpwfUAO/1ZkLgJ
	BKg7tuSeq078wsNof5uIAg0eI3xsi397of/xGGYeUvFhfgZDNiJeTzS3Q0OiLUZMFU2C7DkITUe
	ARMb+bQtKYYNhTCStuSnJ2q/Czu3PUDbFVOGckPlFedQSdeeE1Wtx+VTyRFo6kvsNkXOjaSnvJB
	XgVAB0lYd4LxUfDfZhBx/5G9vSUUoIViyF58ecWMjRmt32ytun8vlaKF3ji74rywcITMp96XnP7
	ZsqIeWB9S7szFS/VWQNEvPOCUluqp6N71jF3A56T/X8M0NePCkCDxNId0kD6y5VqOuBZK1o/1sb
	Chg=
X-Received: by 2002:a17:90b:540e:b0:39e:6c69:34cc with SMTP id 98e67ed59e1d1-3a06af71be5mr288446a91.48.1790026735973;
        Mon, 21 Sep 2026 14:38:55 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a066d9e41csm1169904a91.0.2026.09.21.14.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 14:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 21:38:55 +0000
Message-Id: <DLLBIPSD0DIQ.2TN5XN34VFQQX@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kernel-team@meta.com>, <eddyz87@gmail.com>, <memxor@gmail.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>, "Anton Protopopov"
 <a.s.protopopov@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Speed up htab lookups for u32/u64 keys
X-Mailer: aerc 0.17.0
References: <20260921-hashtab_fast_hashfn-v2-1-79aa962ec56b@meta.com>
In-Reply-To: <20260921-hashtab_fast_hashfn-v2-1-79aa962ec56b@meta.com>

On Mon Sep 21, 2026 at 9:28 PM UTC, Mykyta Yatsenko wrote:
>   Change:
>                          key size (bytes)
>                       1        4        8       10
>     small         -2.79% +156.15%  +63.11%   -0.94%
>     medium        -0.79%  +87.17%  +49.83%   -1.28%
>     large         -6.84%  +50.32%  +29.58%   -0.12%

now we're talking :)

Will apply after CI finishes.

