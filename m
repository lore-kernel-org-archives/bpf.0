Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006A139FCCC
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201947; cv=none; b=W9NI9OukzJc2ZylK5Ggqvmj7TBc/ADMEL0CGn6dwZsbtHPX9l67TK3T99RmwzYEl8SFfGuFWQby3sQV8NDb/I6vRulM7MOrMvKzIzu8BrZZiomQ3GakMIeEtY6OlsbE27YmlajolmBuiwGPWNxbB5z/3Nt1ep3IDkblyYAF+Qpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201947; c=relaxed/simple;
	bh=XH8TnUbnT3+BboXmTdrDuUHD/GmPsQAJ8uz34lJaAeU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TnqCJbjrP8tiWhAcYIwOemsW0cIVN3v5lailodrsw+gjyp4VsekaArCe3CvMPQnu+xgVOhDD8QFU6nHWeVs9MPmhiLnaSsSeZFDLQ629Y18jZiDRDY1Rayomap10lH5oHMYfKLsam6BiQrp3FjpcXN+upVmZxoXS9ZZM53vpAeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYEBAiAM; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYEBAiAM"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33e456e7869so227168eec.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790201945; x=1790806745; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=N+E/ewHSjCRVy1duSzYX+ovpgjaE/jJhn6efKCT5Zrw=;
        b=CYEBAiAMMuK+cLEhkbpLRuxRkxyzNpGrbWeqr2dFAy6EudQ9DuTlH7m80cAw7ygjF8
         L3II0QhB+/9Yp2Xb5bNtcBfVHZ96xV8ECTws+hLC/80SzMTndmDm/cxHbJFHNspgebgS
         wmnVURXWbopPt4/qQsALW6jkulk/BXfJlrx7UbwQeg8quTtM/K0Lf86YhdlQtNLqhM70
         HwlpJmEgD8QhiwIcorgwC89HsuJmGi59kd5zujDViFE0GMvKRbiIsVcqFAtfnCasT0Dm
         jr+vRg4P+jrTShM81Js5Fw4RLp0cqqO31cNSzF9rw8kxung7ADYTWOp6alvd07co0K4x
         WZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201945; x=1790806745;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N+E/ewHSjCRVy1duSzYX+ovpgjaE/jJhn6efKCT5Zrw=;
        b=0TelVkoIHDN73AD+9A+0IgcOWR5sZhVyDcNbGCkxbvMuU+apBkPMcoNY0IiiwFarwN
         3Wuz5DO3V4EBpXLh1DGw8GmxZSDLKmuVAa1bgie+AuQ/ffsvyaYK6pxhyVZJ5ILSJZMo
         9MOvi/HXYqD0GywOru2SlA+eLt3DdKhBLm1jC7vfh6yii5ijsdZSizHbV9RipOk8f6Ka
         ofqN+GrBbA6sOeWN+aCzG977m6uJcP43yt3gVrWLLEDuqcb2iW0CzIisw2lXcRLVF0lZ
         HfcE+ZlcNXZya9UikqWotn5dufcXWrMJbs5NZ6vEz1QoV1abKodv9J4ujUK6isAMyXfv
         KF6g==
X-Forwarded-Encrypted: i=1; AKwUvBxzF4Fw8T4LIcRWr+ceD8TLc+kkClTDOzPKxxy1WHPQhax+cUHgty81XpZb2rKrjGQ/slE=@vger.kernel.org
X-Gm-Message-State: AFuF++lruMER70qAeTn60A03cX124djDiyaEtnBqqcwZ1uYDyX32H7yu
	gAtVqm9wChkpsVTdoHMEYuM1nIzm8ktthxpn9JTb41QaJ+QlJEgfwjwYctq2zn35
X-Gm-Gg: AYBFou0/Rc71Qxu5aRSyd0/YsFWXOaZDl0RgyfyS5yMlxweJRgV0tpBbhTT6U7P/+Nr
	RAOz54VIWIxv/x9HnQ3F7gPXDpRfZbSbfR+Yqgh17yKVVYyvptRSUHkLpZp4lMVwepCTf//G34W
	ZE7FI8Vpukdq0JgVzygdpw6TkiWymu8uWt9WLs62nZlPlmivA6WG2lpVGUxYRF/uyr2GAly2XDD
	ooDlF0GxLfnQRlpN9JZAldy9B8YOty+jKy605Gwz0hH1RCyvVfQd0iaktOvI35nsrkvm4HfDVuW
	bU5ehobeU8TZcErzGExHh/1uZhQh728fOWfUdKD8DxDdGQWQonzlv0Pc7uUgzyyZBg1WTdhkBM8
	o27Zvd25PMJbMFQc5VtTA9oGj4PWDaDK8M7vKDpfX7sMpYGLRKG59lc9wWlriEG4tpjibcMxOmK
	4AfHxIkenKpYcwPqXKIBLtKvsEKEWvSIxq6v7ehnXy9x4QPZMt/Aqp1mviCVHZDjNPVLHBfXVQJ
	2H8GyvXK/raCSnXQ9lrrdiVkuDYo9W18xnvq4A8dq8kpLxPi0MEpNvlkw==
X-Received: by 2002:a05:7300:ec97:b0:33c:1e4c:151d with SMTP id 5a478bee46e88-34003faa083mr316669eec.7.1790201944808;
        Wed, 23 Sep 2026 15:19:04 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:179a:a128:9d0d:40be? ([2620:10d:c090:500::5:48f8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7d003sm7887062eec.9.2026.09.23.15.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:19:04 -0700 (PDT)
Message-ID: <9d794d45da75370d010dd0234cbba5dea61c19ba.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 07/21] bpf: Explore the landing pads no call
 site reaches
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 23 Sep 2026 15:19:03 -0700
In-Reply-To: <DLN0K7231LF2.1UNIBGA546C90@gmail.com>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
	 <20260923045922.2417689-1-yonghong.song@linux.dev>
	 <df24934c5ecbd70bc35b528b8e58ae668ce02051.camel@gmail.com>
	 <DLN0K7231LF2.1UNIBGA546C90@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-23 at 21:28 +0000, Alexei Starovoitov wrote:

...

> imo the following is cleaner:
> - do not repurpose bpf_throw() for this new thing.
>   Introduce new kfunc that will do the unwind, let's name it bpf_unwind()=
 ?
> - replace all 'call bpf_unwind_resume' with NOP by the verifier (or may w=
ith bpf_exit. tbd)
>   Technically rustc or llvm can do that too, but it's cleaner to do in th=
e verifier.
> - In bpf_unwind() walk all exception tables and replace return addresses
>   in corresponding frames to landing_pad_ip-s.
> - just return from bpf_unwind().
>   restoring callee saved registers will happen automatically by correspon=
ding
>   frames and there is no need to search exception tables at each step.
>   That's what typical eh unwinder does, but it's doing it due to C++ logi=
c
>   that is more complex that Rust. For Rust unwinds we don't need all that=
.
>   The above algorithm will do.

+1, makes sense.
After return address rewrite the unwind would have to jump to it's epilogue=
, right?
Why not reusing bpf_throw() though, is it because of the exception cb mecha=
nics?
