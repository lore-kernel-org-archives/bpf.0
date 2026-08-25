Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2886341
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787626840; cv=pass; b=NAsqDt/LJ81yGrrVtPiDOiD+ZJlL6Q+kr01mLoELGccwrBfWBM91VWZcu7wTQDxOCL5aOLgHd5MISkeAUBzcTrZmrwRoHwPY270xIIDmEJM9H/t56nAlCl7MG5cVv/i0dkfpAA1wpKCh3e5LKRsGHqTZbgpB+dqPY0Ouq1Bp3O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787626840; c=relaxed/simple;
	bh=nhMkF/QWneMML0jVXBtRpMi/87xYOZBsFTKpWsBsOrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1vF8xpgnq7mCN9V+f6JIG6PmPtlN7SBZISKYL50j8TSJd6uYFQbAcDX7+GKr7s9VZJNyMzBUGP/xN5fJMICEXLQv4+pWJ1T/R9KNnOqbhpn076JEPDw2jjAiFuD9qjnMQ3qRzn10Lkfc6aLSA2RuGyr3y7IO49pT0Nr/FZZkow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kU8+Mecs; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU8+Mecs"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f703a9d05so2025362f8f.0
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 20:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787626837; cv=none;
        d=google.com; s=arc-20260327;
        b=IT2MpQhAYUxUR8W0RvIg54NYct5hDx3Ydzr4TG9pAW5hAIT1O7fogrL8sEJicc6Lw2
         InNNyBE4VMAYT658PLPrmM7x7xIByF1xDpx6oRdxYiiyuCh+uiAUWct8dpdc1OgEVYFK
         r/W3lc92dDct0ncgE3xikxeWgAuAP2Xiv62dyCfBu1BGS2rMei37DBB0Vs8gujHEQQC+
         1+GkAPnc7JS8LeMOao5YFnmgt7FRauI9wyzdmbXUUIodkSwWAEt5bXfguI5kd1de8K/5
         oe0qfHCXGlkLOlSCMzongSFOtbHFh6f/4nlMfr41/QZjba9pX4zgFGSGxZUbfGzW/I1y
         Y/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhMkF/QWneMML0jVXBtRpMi/87xYOZBsFTKpWsBsOrE=;
        fh=8JAocgBXpbtneUkNsN13naVHxeUStr9X0rb1Jjjh3oM=;
        b=iVViE7I3Yn0E/GinIZ4modQomHdxAzVBpKpe4H8Ka8CtSRNORoYkaL5Q4jSFydUfC5
         FIb5DzZTFyAuAlIQMhUMz4xyJ9mJzE+DB2V/W/Eh3ZVGk6nzFAZFakJxbhRY2Y78PMn8
         V7fovOm3N86MmrrUZrtTdsfX7ZufYhshE5TNPvehtuP/yMH5BxUYZgMWy33PR3shIJW1
         SsRsdd/sGAl/EWEkr73n+jK9RmgqzEyaUU/Z76hbNaMOpH2KqzUBB5wHIKBRmJazFJMp
         DDIwtC/h4+Bl/lObKkpWnUuxhzE9MfdgSYMxpnTDTMuk5/+DGWVA7DF8uTrfD2dmuxu7
         RNNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787626837; x=1788231637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nhMkF/QWneMML0jVXBtRpMi/87xYOZBsFTKpWsBsOrE=;
        b=kU8+MecsgMVyGPz2bjR8P0FvKR0VH2/VXoiSmOf97qw5AwjfjrI0jAZ8H40c8G1jiH
         sOBBqAyaUfrqhqKnO6C9gGAS37HnYtABCbhWy6Whox5ys92C156UbMSCTA9xJ6eRlqAp
         67txzrXi/T+Om6D4Jh0dDxZY8O3KD1Tuq0qD1xkfamAWNQqqpwMvBv64OVaRGDC4cY7I
         JEHkSHll67qQtEyGKS2FwCo5ANtpALiTTkBtJBboUi6KiNx4wW4GCbWM4/IFJ32L0HYg
         UCdUCz2svR6S677uVvBqCYFFrZCz7gwuVux33Aww8eeDz5/XTSqNc1btqmUgdnsITag3
         54GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787626837; x=1788231637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nhMkF/QWneMML0jVXBtRpMi/87xYOZBsFTKpWsBsOrE=;
        b=Lt8yiuaaBDLhsPmiJXOnqDD6i8/9R6npwh4wfL8/BI8nK2Yrgjrkc05hDCufsnqHaH
         vX7SnUasv2WrivybBwRykyFQ9C4S65HHoE8L82KujlGfzf9QaA3iQQIeMBxKXcr62fXi
         CSOmOinyMbGSP0RpIRX+eHYofXMCr/KdhG1r1Apdx9GGaGE0U8maRn8vc2piM7sIk3rs
         loaS893Zv8IAcJUJlOFvF7emgW6h1bx9MYmt6zQQZ34bHe8Vms67JQWZ/b1Ici0UdybQ
         eRMJ9DOfqclR/cza3OfsezAiLe7vsrB4u/3uFNvuL0bsvUYheSkeADSX5qKZBfDh0eGA
         0Wyw==
X-Forwarded-Encrypted: i=1; AHgh+RpUqgwdAeILHG906hIw6Vcra4GxQml28KtUHQprhpLnsnyDJJU/lzqVBjVzXDmrqd6cdO8=@vger.kernel.org
X-Gm-Message-State: AFuF++mUSOZNdVnTeVnP6T/to5ncR/qOuudZp60ooR40Tmt0n9zAkQPF
	i27oi/nuqjtVTIJybHV4e3d28sXJAH6Kke6Sbc6amtVtW3CGyq4G1YDjCa1w66YvguDdaMqKgF1
	O8H7XKZqWB/njFzorX+iFvBaNYSYQCTU=
X-Gm-Gg: AR+sD11yx5/eclYGZVKk96KTV3g5jkqNaGgOL5nii9yy2tq3nLLBU9zaMa1++J2JH0Q
	QIcUPm47GhKSNQbB1SUrp3CmecrlvMy7TqSMzDvMWigp3B6W3AtNT8IKEYYeufDvYVUjz0ECY9Q
	YAf/Qa9d8y8gfrCzzSkjwDP6lEbO8usJxMyTR91/wYy5VM/NKNDw8jha2AHk5dKbr+tTl6VDefR
	JkIqWt5qNuPVPWedEMBe22GOR8yiIQE1HyCq8EJSBFiM9/c97aWAzrG8F8VAbZI8jN8Wf8fwaGo
	XKzXL0U1J+s/rlK/5PuFBarzb6T7MI5bbE6SDsoQvcJd7PBSZSiyGpIeF4wlunAfw+Byl09dl/p
	uCDu2bg/Uw4MwEyYWiusIUPjJ+dPMw1MZydUy
X-Received: by 2002:a5d:5e85:0:b0:47f:5369:bba with SMTP id
 ffacd0b85a97d-482d9f61289mr2952793f8f.15.1787626836920; Mon, 24 Aug 2026
 20:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824103502.3154292-1-falakreyaz@gmail.com> <0285c6bf-43d9-4664-b4a4-38f6fd2dc500@gmail.com>
In-Reply-To: <0285c6bf-43d9-4664-b4a4-38f6fd2dc500@gmail.com>
From: Muhammad Falak Reyaz <falakreyaz@gmail.com>
Date: Tue, 25 Aug 2026 08:30:23 +0530
X-Gm-Features: AcwNN1U6elyCCt5E4KUxzbgDz-OHmACKn9PurWhx5aMx4gTQpdhtTF6YXVWs-R0
Message-ID: <CAOmbKqmiaRNqjdcOCk7bKfLYx0CO0igz3ED1pm1tV0qpLBLZ6Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: Cancel special fields on rhashtab value recycle
 instead of freeing
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 9:21=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:

> I suggest we review those patches, instead of creating new.
>

Sure, Thanks Mykyta.

Humbly,
-mfrw
