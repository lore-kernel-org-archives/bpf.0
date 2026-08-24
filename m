Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C287A4A21
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598051; cv=pass; b=nN7ukixuOGvS/VEj88mnVGu4NtG/GOM++WDUM4Xul0Oopc3vWuJfJ21HtPKthfJ5ClEoQkUKqLjuzpcZDTR+uGvKN5r2lf7u5w6p+u/A1qMTIJpvtT7lN0gXklGoO7+g9UISlPs0aD9zFJVOXwlnedS43aNTSfUqnRAFyev+7Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598051; c=relaxed/simple;
	bh=BRZPDspEtIyER3A6FuSt6b8MpX3dRuVdqdSh7SiQKIg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FOn5Wu0QAkDsQLwv+cqu56ghAL1FMiVaVJ0ocTWqEIHLYfHENAufN4SBxc8a3wvpCeWQVFOR6Vb3BQ8m5OnwTPsn9NJTH1MIlx5VbhcvC7Sr85q8VjjClXGbr/7OWNi2TK2EQmvM6MLw9Jvv78s+tgjfX20MV77XsVbKIJDCqEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rKJict6Q; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKJict6Q"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f6609c657so1620781f8f.2
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 12:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787598048; cv=none;
        d=google.com; s=arc-20260327;
        b=l7Ad1kLMKjdxyymKuamqIDxYBiKC+89QrRsT3NO1sUqUlKgMY/5jdQEiXDvmBZ5/U6
         l2IdVjzG7xvbmeLzh90FXlE3EHXHRrEyqsWF9Ahfx4M1WGs9ppsYjAHxDUt6H4gwqf9H
         gFhImUJ/2lVOXYg+NDXCXiXVqgGJ4tNeHZXZxZVl0gBE187wrOxxhf/glry3om9Dkw7P
         HIPhr9xK0p2+UEiA/H/hHrIpSm/kAQG8vcFR4Bb8/idcLj4WBTTZolmEzKoyq7gjxuPq
         av5sE66ErSTsYVvrkIUMztTeggkJLvli5KLd0X4xPaVNyB/S7WjotIX9gP8kUZrntkhC
         YNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=BRZPDspEtIyER3A6FuSt6b8MpX3dRuVdqdSh7SiQKIg=;
        fh=Fb4EtPoaskFNfDPSdNG3wA/Q/hQ9b6abCOvimYtsSxE=;
        b=O2hAuQdBf3v12Drv0ZTBCdI85qJ6IO7h+5WTc8H70vnhELIUdKIZ6/EmhiTByZPnWI
         QdXHH02lh+7LgSY+gjX2yId3AReENVNl0SxeSXJLUizHbBAWUOggedObFY1T4kHrVsNR
         jc+fIIF/K4vbdztGpyktTqGZmdmG/3NFt4xkRytmy/UeFJh2XLPb8+vORLT1uq80pM3a
         On3UxUwdIizPiPrjnQc/8jW3dDMwlrKOhK4c+NpxB1s7Z5o4O0zsSiMChxDw9TcMZOcy
         dd6tW8+IKNGNiejsXd7PBWaWaYMjSma0Chtp7incCjNXRk7gSrz52AbTwuOZajqnsGxA
         ysOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787598048; x=1788202848; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BRZPDspEtIyER3A6FuSt6b8MpX3dRuVdqdSh7SiQKIg=;
        b=rKJict6QvTHwaCWgS8M+Ae6mjxXrTCNaNrXRJZBbaZ2xxuUgIR0LWsTPAqO+t2wGSG
         gUAnJiBpIL22jXCfrSrFXSFa8EkwIUxoKCIDwYZ4KpnmBn/NxDAMD/kkvDxo4hkXJ2Lg
         IQ81c1iFmNTkUraCsaByqsnCz57FHsx6/btHctzCChuwZmRQvGVI0L3KPYbVTmdhGpnY
         Opo08hnpJRASu7f1dAvuiLjCB7dtunH8laT7U8rJqsxg9hCvBZvoLjLqi69xx5XJLjHX
         dBTja2OmvXt4h2UI7BSfiffP51cwlHwnBo+LDZnfzRhdlcjccD5Ep1dbf/kd4m1H2Dip
         mqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787598048; x=1788202848;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BRZPDspEtIyER3A6FuSt6b8MpX3dRuVdqdSh7SiQKIg=;
        b=njLXeU5djwf/C4fYZJweZnQWxNIAPU0tQIWKEZRM2wMagb/XJfmuNcXEzqqKFDXk7M
         0vXHavSFxdu8VCAsb1PIrv8p0y2quM8eSikC4ptyS62TRS2EPgF656eycQeGEDh4M1+J
         BVDqyGcp+9fIubnuFGqewCpmEZUUVXS7CxZsn7L0S04jDlP7Z5DPy9sWhcRJnqk6++rU
         VhaV4Cf2Vsn2eBZt1P/RpIf5aG04EqoM4qreix8Fr7xVNrk7JHl2mYCXao9LeTAX2n/Z
         JNqKH2e9Mh4oYaaGI0UZ3H9McQuRNnQNjQf2enE40B3YkZPL3FQeDMxgeZoYHKYpEvwW
         fOOA==
X-Gm-Message-State: AFuF++kTDPfXg4vLr7LksKBR16Z3C7eHL/IwVouQy4BYJn2HmjLoP940
	592vv4Jjtm7EdclfnrQ2JRSW7Xrb8oF/GdF15Vhgbn6J7lfKPvlznGsUqwNWI0kPvJ93rJszc8K
	LDIkUqAJj0mHo67+MQ4mdtszfffq+3eE=
X-Gm-Gg: AR+sD12QIzOwOTBa3gavxWVCm+6RLjSFrdicb1qCghG/9mbPQ0s8puLgvpBRA6fg4NB
	DAjqsV7nTH/7cVxg0/fzzZzxOB+OqzofVB9+ONmfDAJoQSBLETXktA9DMJDbuj/ySX3DXPwTjYU
	+Phl3LpxKGqQvJXlWMYk/5s09f9CgFygY8HRzexD1Fxm4yXLZq7jNjRVKYo6SgOsngBeKe7mIRV
	nZCEUShMn6vZ1FQmYAA9G/Mk2eYIFWU9Ai9YOsirM9JFYhwGtjJzgjiXn1ZDge8kPpJRod7kPdi
	yWLLaiMGe8WGGIbEaH14nsiPpwjXhFUOpxqE9mIb6HS0mVs05cGUcL1lQuEHg7CuVer5Z1Visxy
	k3A==
X-Received: by 2002:a05:6000:240c:b0:47f:cb30:8591 with SMTP id
 ffacd0b85a97d-482d9efe383mr1144759f8f.6.1787598047884; Mon, 24 Aug 2026
 12:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?7ZWY7YOc6rWs?= <hataegu0826@gmail.com>
Date: Tue, 25 Aug 2026 04:00:34 +0900
X-Gm-Features: AcwNN1XEUmrU5UXLwhrJrZf-M8LpZH4N9FOCA-K6llWPaRMvlJpfMLvXcIQMs4o
Message-ID: <CAPa51zmwhbD2Xc1kFJY8HmpG-DY3OsK=G=h2Yn5ismeGCxo==g@mail.gmail.com>
Subject: [STABLE REQUEST] bpf: backport de36adca6346 to 7.1.y
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"

Hello,

Please consider backporting the following upstream commit to Linux 7.1.y:

de36adca634634c205a9eb8b56a28175ab7abf5f
("bpf: reject overlarge global subprog argument sizes")

The issue was introduced by:

2cb27158adb3 ("bpf: poison dead stack slots")

which is present in Linux 7.1.

The fix rejects BTF-derived global subprogram argument sizes larger
than S32_MAX. Without the check, the caller-side PTR_TO_STACK
validation can interpret an overlarge size differently from the
callee-side PTR_TO_MEM state, potentially allowing the verifier to
validate accesses outside the actual stack object.

The upstream commit includes a selftest and applies cleanly to the
current linux-7.1.y tree. The fix is present in Linux 7.2 but is not
present in Linux 7.1.10 or the current 7.1 stable queue.

Upstream commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=de36adca634634c205a9eb8b56a28175ab7abf5f

Target stable series:

7.1.y

Thank you,
Taegu Ha
