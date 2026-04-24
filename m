Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A7E388392
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040865; cv=none; b=h/yPhKNyXO4ATrmWvzEO3DftHt0Jq+Sp+DfaBJElZmM2ImFVXlxPOI+CQASws6F3X8PeoZh711mdFzHarZyYR1aenyY55yYW1VcKUACm+jZbC6Cf4zyjNdTIxSBKkL1X7fjbqk+OCWqqDOsNjhv1I7eHbUAOx/v11Vdaa0FoDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040865; c=relaxed/simple;
	bh=yYfzSuomazcnN824aX8C1ftKuOaWl/43R/j2KUmohUY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=aHIXZp+JYHcTNuYSZgTR209Vvqak4YzAlMmlwipXKZTzEGi+yzkWJVUI5gftI3XbGwcTj9JExbLk0u0PNag6ogYRXFRcSchSw0aD3Gx0MWfgq3CtoiBIkjwIBQU3jDd7bNzsMPjgzPN0jFrGoMcXVO20KKNRvpUgMb8Fk4ekrnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0R4kE0X; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0R4kE0X"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dcdaf06498so2796187a34.2
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 07:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777040863; x=1777645663; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjjH/tLqX6cBtTicu3yUxFefXzN4FEEjhrQgohNngo0=;
        b=m0R4kE0XFGzz+SBN2Pv8Ni4hjYBPg1esDBzFO1zfDr3Bu7XcexhLuQzLODBZ+gR8F8
         xlFcWmxPFqZ82YH0ELMJ97VBb4AR7IMwodbCxGDm6GhmdRHC0+tdYSxkUKLUhLLYznCV
         I1CD5ThB5RAJI/KMDSjMFek2SIBQA0PcaEJXPvwmPrmlBoiOYJF+coeN2MyIMGcQqM9U
         /E/M9Xu+jhCFVZ8mCKoNwerjlykc26TOTRDGjnQz+9IhZ5dkRXPm5qwsHEuJRfWS/QTe
         FgRwKPKETu/eodq6K+XVU63UCo3jI5PzZ70ie3vHI2zFI0/cQcTmCcQxiq15zjc2Oo/6
         Ci8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777040863; x=1777645663;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RjjH/tLqX6cBtTicu3yUxFefXzN4FEEjhrQgohNngo0=;
        b=ZFN2ehMmWYP7ycW2mt49Wyw7FD7x3rWYGChSpL6VAoPQdOjfyMtFRIBD3/TB7PhxvW
         wkt46OfErTPbCM7c/WPUPJtsXBwdfGqCca58GD45dZMD7D4YBLAT3ILMR44tuZpj5GGa
         J8U7SDjMmCPsXxelVuvSRTPWdtCMB4hADaL2FSC3oB0RIj0DATQGHwZoA5cDtj5mQSGr
         O4cztNM1yHwWNIzVMKGI5ryLyiTorcXBGzJH5Gqgr7QLYNF5IhPwGKngygmoveD5vO8h
         A0V6CqDtTl5LjuYjql+LRsa6Ufz9inHI3Te/bwmJeU15KmpjYFVArs2cgsgdmHEodwrG
         Z1Bw==
X-Forwarded-Encrypted: i=1; AFNElJ/mCkiVVg/b75hzGlurMLDD9f27mqOQNkMtnaB6LyUCbQ3PPKWTn6bY2EqMNEZLDWlvuO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdpEtIY8bJkV9tCSl5grNVsDlOVzh6U51VfU5Np0XvQ5tixSUA
	O87G2sl4C6OJam3iB2x/RNVTDpzE2+06BhfxJ8k7jhaRRb2KAIuExO7d
X-Gm-Gg: AeBDiet+fMJTND0AvK/WingnehSE8dR8x8E6G8RQOxC+tQOvrm2ho2jCdsfhMHZ24kV
	a6OSkc/M+bnzhzuyrG2qpD0qTMuxWLoCfN48kO4thZTRqCOJkWgYhDU+jQGbpdqXespA92oKsEm
	tBEv79/C8xqy+u1RyDDX/VS4dLN1Fbof5YZb0WM7b5zp1q2jzzffi5oZ79Z0UOP2ieSHuAZAP3v
	6U/U/Lp9bAuZBOXQu8PGeq7LtS3SwizG1+ER7UD64AQkNzo2W/tbI421Z2FEjfEpeeKVZ1TkVWM
	EjZDAcJnVvp0Vm0GmUw0/2EZAYoEURDbViKJGOcFaGSsfqPeyvS7vPnz47PTkROfYQZH18KbY+z
	XbUgPK6+NwZ5dCIrE3/8acmOa9fON7g/X/rDzVITSXzcF9OYrlZ1hkHFMvbedN7Wi6Imx456etg
	MCG8dq+E3f+ajdd5QekAKHfuwiFlCdV77+OUBjz35hHZNTCkSj9ncg+m6CMysqo74R+jWGQPvaL
	p7tInfaZs4V2qjF5PF1V/MzY/Y+
X-Received: by 2002:a05:6830:8288:b0:7d7:faef:fa0 with SMTP id 46e09a7af769-7dc94d9b166mr20671382a34.3.1777040863239;
        Fri, 24 Apr 2026 07:27:43 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd5408b5asm10067461a34.11.2026.04.24.07.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 07:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 07:27:41 -0700
Message-Id: <DI1GETNIDN91.BJPVEP02OODT@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] bpf: replace min/max fields with struct
 cnum{32,64}
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
 <kernel-team@fb.com>, <yonghong.song@linux.dev>, <shung-hsi.yu@suse.com>,
 <paul.chaignon@gmail.com>, <harishankar.vishwanathan@gmail.com>
X-Mailer: aerc
References: <20260424-cnums-everywhere-rfc-v1-v2-0-57091924c9d7@gmail.com>
In-Reply-To: <20260424-cnums-everywhere-rfc-v1-v2-0-57091924c9d7@gmail.com>

On Fri Apr 24, 2026 at 1:17 AM PDT, Eduard Zingerman wrote:
> This RFC replaces s64, u64, s32, u32 scalar range domains tracked by
> verifier by a pair of circular numbers (cnums): one for 64-bit domain
> and another for 32-bit domain. Each cnum represents a range as a
> single arc on the circular number line, from which signed and unsigned
> bounds are derived on demand. See also wrapped intervals
> representation as in [1].
>
> The use of such representation simplifies arithmetic and conditions
> handling in verifier.c and allows to express 32 <-> 64 bit deductions
> in a more mathematically rigorous way.
>
> [1] https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf
>
> Changelog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> RFCv1 -> v2:
> - Dropped RFC tag.
> - Dropped cnum{32,64}_mul(), too much complexity and no veristat
>   or selftests gains.

Nice. Less complexity the better.
I think it's also strong signal that _div(), _mod() versions are not
needed either.

