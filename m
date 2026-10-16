Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4794E1415
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168450; cv=none; b=Y2Hh22zjpAbgRMhPlpWvQujuWhKY8zQMHEuADMkV5m1D8HttpPrmTVtc/szllTAd56Z+9vCczEScTD+a3tjfcy2DMLowycEwYJNizJKYYVt67nMCbNacnyzWotCRERLhjdQEJ3arncWEzlb7+p1jVOhYxLYdLeD6eVYO26Zgfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168450; c=relaxed/simple;
	bh=nOYvu6sUAMNGasl2desTfiQYcS1wd4gPpOcjjyugCJg=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=UOh3DVKI1h757Sng3BOvvD5Jpm1EesNP2c8mbThJKXgFJd3CCl9PgOMD522lNhBhtdH/TwoLCNB3pqoJoiFa3ZOs3FMlaeq3LWzRlpN90Ve5xfDtW67kHpzegEhhW5yAXxRSP88/kYbDFAO1xZ2/eRIbkj5hPLoiJbP2cYcsxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObJy9Dbt; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObJy9Dbt"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd5d2dafeccso95398a12.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792168449; x=1792773249; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uRYsvWoYHm17R+F6qBsBObj2WWs/UPl5Kp38F1Vvxuw=;
        b=ObJy9DbtrWSRj/JfHtNIq0qPwNLMGBiwiEuJBWYjnd0tXPK7j3f78BPFsnPitdv7Ti
         wg5ZyDzzOaYXVRDMzDwVeRVvMc18pj3BozznPVe6S8dF9AUpV+A1owSy/Fmnm1RLL2qd
         qM15PVreYeDgetSsiJOAw0qV5JNSkBn5+PSMZOozUdT3ZhnsPIwD+QklzEwZK/Ws8tmg
         UC9q/XNA74FDbMaYtmCGCg4yLxiouCzOag5gh724S1j1rYIwbnivNUsja0vupX/UKmJv
         D50QE6hR9dbJGMfhzbc/tTMmwJ8wz8/VVV+VDXDWyFcRQALVUZP9wZsixUbnbxKaa0TE
         Hb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792168449; x=1792773249;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uRYsvWoYHm17R+F6qBsBObj2WWs/UPl5Kp38F1Vvxuw=;
        b=1wfdedTb9wfSJc5WhiZYFWlQDB2M8kfBty6wDCSNJaK+bD9WXaz/9L13ukQsJZshHK
         /kAZ+SLaPsYAoQqHh9GUzLsaFdy9iOGQXhSB+yigfyjolVDXcEd586iA7Zz9exu+cIBR
         A0toepPQ1dMLN4e62AIfrXqG+u1qHAk1dBIS6XQindOXiLrxuWDnyMptj9oSWZ3CMxyo
         yF49rM82VLnzTDVhvwjiCBTrZNK15Z2xGfLFc+Z4nSXbszKzeK6znQ3o7f5/vAJ30fpX
         0yzVtBOsjXjIFxrs93egzgK4g+EeTrETiJnN+qpmAcJefKxkR4lzAKDxBx03yErHFSXm
         GFIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwN/dSHieHAgcKJlSuTULvn74VMGtZt9P73Wv1w1eSff0X6fLYzSOjeMejxBT6gmm9zzgM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLV8zHRa+aCWPyXo19WciVffD7AeDlaL/4VKyWU2xrVc0BoisH0
	l3Op4v7xeXsnsjAhbPwfzNUE5l+pWSFm6kGrXM/Pf5LOfwoVzRHCAY77
X-Gm-Gg: AYBFou07H2nr/hufNLssDOgXeDBUGrz+iML4CZNS6rNoEdCEDif6uJeV+oIYzSQMae2
	57zXcfMOf4RDpZxTvx4BE/hKjmhsJ8H7wQW8bUQvlmHkLBQr05uSdS5czfwrkWaE830cBMozOCb
	qgFVve2YPSkxiuO5X+szz8hXvCWzFHfX7FlHhcyZL6KyKfK+LnRTUI6hOfA7iDo+T5CpvYg5prS
	fLXAmHrX4bo9yzSJFWg3ZMU/lbmBgF4zdd2JI8pWqG3oeRGLIgJ6HV//eYLXKlOgbvQw4EYZunc
	jAYeOtjAkCsskeRhtkIXwiG2Z9ZQMqU8pYwca5wVcezl/DBKeOPsDDOqW0xs7FCt7eCVL0bdIx9
	ZwHK81lRLmkvrdJDZeRG3VUSfxh3T3HX8tv7NKSUUw1xgA9DS/9e/mLUN1ZE07b3LOM62Rw4xlG
	UO2r4sRlrgWNA3wy2RcDBaQXsSZiazFKBjCIb314TkWWCM30RpiOhz3zL+2shlqhYBdnKOa9oXM
	CoK14z7YA0gF7DwD4Cs/9K02fshhjFBcdnIn8/Q38kV5cdRoXOsrWfLR9gAkBytRpkzmB9wt+EY
	Oos=
X-Received: by 2002:a17:903:2f87:b0:2e9:4f21:91ef with SMTP id d9443c01a7336-2e9a69e99f3mr4533585ad.36.1792168448771;
        Fri, 16 Oct 2026 09:34:08 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e86925csm12775815ad.52.2026.10.16.09.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 09:34:08 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 16:34:07 +0000
Message-Id: <DM6EOZ20E9ON.3KR4R7QU4SOJR@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v3 00/11] bpf: Follow up by-value struct and
 __int128 argument support
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <dfa562d4-23fb-46ff-bbf9-5a56d2e51860@linux.dev>
References: <20261013170910.2126673-1-yonghong.song@linux.dev> <DM5X4L58MG5M.2AK0D6DRZ5ERF@gmail.com> <a420e9de-4546-4be8-9fc0-d9e9c9fa6fb3@linux.dev> <DM6DYYV4XVKO.G5S77C0FGIYG@gmail.com> <dfa562d4-23fb-46ff-bbf9-5a56d2e51860@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 09:22 AM Yonghong Song <yonghong.song@linux.dev> wrote:
> This one can exercise for s390x, x86_64 and arm64. Do you think it is worthwhile?

ohh. makes sense then.
Patch 4 fixes s390 too. Without it s390 trampoline sees arg_size 16
for v, does mvc 16 bytes from 0(%r3) and restores r2-r4 only.
callee_odd() will be the only test for that and CI runs s390x.
Then LO/HI has a user in tracing_struct_int128_tracer.c. Keep it there
and drop it from tracing_struct_int128.c.

> Two other bpf functions, which has stack arguments, need rejection with
>    ... && !defined(__TARGET_ARCH_s390)

Same #if as in progs/stack_arg.c ?

If it turns out to be more than that it can be a follow up too.
