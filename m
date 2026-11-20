Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197059;
	b=4f42ew1pYl7rDaSWoJxwkXt+F5J0aLSA9OYupzPG1GGx/g1osIwMxtxAd8s22a1wtqEG
	 9d1dMj9uahwpxbzvT+UG7BPz+6cZZ/wIQoJwUXX4RnLQ6tYHcPiVDM473/nUM0NhjSWWf
	 gwqRmvkP5PQ1FN7qYra47tv3dYGjjoYhcgnxTICJttLrtKBhCCa6rOydPn/Mr6KbWt4OH
	 l0se+gWuGxw7+5CmTAcmG0IPTXQ4QpoeT/9Ax/rkczvG8GED6ImKK9sxyv+1YojePtzKf
	 NwrCtQWbAhkzG5u7OietHgMPpzHJhV7WD474kkzAWKZlsCkJSI6GQ099eIGqIRPyf7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=GfvJ2B/FDo3K0b8K7u2mjXLnyWvWgtIHqPTZMgUtdVI=;
	b=kRB4rHm6bo30fYAbbkwbedhf5Bor0ysUK3vXuhjtytXIo6FZlACd2snCPcrA+fOza4Jq
	 wXTUQL8DTmngd2tRV0ejXItzGo7z+DHYcuoy2+5/mme146IlKTQLA5j/wTYaJt/W1Xmsk
	 pDgnzxVbU0WLQkSqejjZMDJs+Cn5/NcgEPCVP0c6BzR+xojXVuRpsti4aLd0uZT2xK14S
	 ASJ2U9SauVD8UicvVv9PHXyIlfM6T4H+dhIK+LixqBMDsWS95LQKip9955h5Xvm3k6e6W
	 74CaISyIQ+aW4BWdCEt9JYn61L6d8W5LYFjrBgRVbdbiM1/SvHA3BNVz8zMXMvX7gyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ixaT24Hs;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706BE606A339
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 17:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 706BE606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ixaT24Hs
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a070781f63so670202b3a.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 09:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795197059; x=1795801859; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GfvJ2B/FDo3K0b8K7u2mjXLnyWvWgtIHqPTZMgUtdVI=;
        b=ixaT24Hs6yHwaVJliV1mg6xqeYY8wyu108jnz1qeixkR8kmmFZhaNV5UMv7kM2gY69
         Kp7KAyxBZKspCjl38NENYPADpEoXP5HgypEk9L55CQx2Xe5xMWoGNHhXJXm07rvlHruB
         tOKn42kqv/gMi0gBtuyj0DvQFcT/6S21CUfuvSF8waUl6O5sWylFfA8M4OcZSK30ESml
         9eS7qMgHGkqTgHig11EuHcy0NAuAzooBlEir6N3sXq/WlqBjME1hnzgOcKWbDcd1QtCS
         CTiZVVoK+uBQiCp3Hv6PviXkAvgOc6xMsWy1K7dDirJNhnb6bdD7Gg+pTq/sR390iN2A
         Iovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795197059; x=1795801859;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GfvJ2B/FDo3K0b8K7u2mjXLnyWvWgtIHqPTZMgUtdVI=;
        b=MWK3UYb24ZDtmuGycuRJnj8zBfzqYvD+45pupqV6PxDAr0OfjEyxCS4RkW2jYUlj4P
         FIXJvBddWBoMR/oObwEEHjvBM4V40LCvTqcSWqbfT8sfjuz3JB+ZrgNb7Zy+Bkt+BCK2
         D2aXie0cLqHfHbd4WkVjUHjsOGkamsukd9V7YWB+71WDMMgtG76WjOFjxBoo3vA5lKU5
         neDlzkFp6w/aQ7X0UROwbQM2pmy5n9+/QvFtXmuJLDW3G0K+El2fHUVF+xSOtZHRxFb8
         bYtAWVPSbhjvQBC1gAQbgmp1LS7ucu2eY1CJCfKG+YKlIO+mmWxkh7HigtksFJfkyz3d
         f/7g==
X-Forwarded-Encrypted: i=1; AL+hErEWo2J6Vzur4O0DSWGvbmXlLBCVBsyFFIbuheRfc1bdqpNqWTHaHtyD9AaTLUWv+52h8B4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yRzwJ0XWC31/E84nFmAfX4DYUJazQaMmYSSIXrs9mEej9d7pW
	XbZCgd7JVUgXvRYcWsfUuolRliw+DCCsIFJGZqEOr87tjXD3rArtjbm9
X-Gm-Gg: AYBFou3eFiocAk+FebDmjH70usMgHumI+uTabnN54icddkgPb4xyAaNi35Q7n+9onLO
	mBPUAalexXy91/m5bkLTZ8d3qFjKp+c3Nh51VXiC7RAa0Nd7y5z28onqHOp/fMVr/Brocrj8OUv
	YkAjQpVjjYEOUd4XPi9a9ysX+VxwFWcRxuNiinadYvbQ/GhdOZGPkL5eBWHrLV9SQvlU1Fplf7o
	QvX9v6LJySafn3OAEn2Anvnebtr5jxFA6d65tyxVb0wNMc/1dzF2dBJMaeL2BXOpBWzI62DuK8S
	NihjTcO3AdhXsUhgCjMGK+oRhIASfCzJCpwSm4Gx/xwEQ1WMbyAdFxtu7R68eudoXSMq7OKi+p9
	fVUGFDAXmsNz6/PCzosK/JVuEp/agScS2QguROQ66j1yY9Vx4BrZDEvwnt5r8iXrhUY+vOqJPny
	3g9rhba2ClRZ2UwC8tk61TmCXApskWZg8MeUmKALB9a7zti1DM6gd1HHu3Yn/G+HO8+5ITzta5q
	h3NU/jVYCzCYN69BI/NFHm2PU9oxA5A/f8wdA/Oh6UOc0OMoUY6moPjJjADvNMaWCvfUtZoKISj
	5HiWRdPdfbhHyWPAbYleG5eoL5puXc5Z3ORUoqSTKyJZbmuHWVlquhH+b6SfT+ERADB7tqZeERm
	caR88J9Nbe+kDcnobwNhRlRvRChifZGYwCw==
X-Received: by 2002:a05:6a00:1410:b0:8a0:2914:5d27 with SMTP id d2e1a72fcca58-8c87ce34a3emr3491379b3a.44.1795197058496;
        Fri, 20 Nov 2026 09:50:58 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873b2434asm1800461b3a.45.2026.11.20.09.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 09:50:58 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 17:50:57 +0000
Message-Id: <DN088V6WVRTV.10FAMA2ILO7R9@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 04/49] bpf: Delete scalar evolution
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <ad82954b5dbf7e28fcfcb7a41802667e9efdf117cf4fcc8b09be22a20fac94d1@mail.kernel.org>
References: <20261120074430.2704488-5-alexei.starovoitov@gmail.com> <ad82954b5dbf7e28fcfcb7a41802667e9efdf117cf4fcc8b09be22a20fac94d1@mail.kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 20, 2026 at 12:25 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
> Should the bpf_add_cost() call in find_latch() move to that commit, or
> should the cost definitions come before this one?  As it stands this commit
> adds a second file that does not build, so the series cannot be bisected
> until ecbd98bcc45a.

No. It's already explained in the cover letter.
The kernel does not build after patches 3 .. 36.
Each line of code changes in one patch only. Patch 4 adds find_latch()
in its final form. Patch 5 adds bpf_add_cost().

> Do these selftests need to be updated or reworked in this commit?  None of
> the commits up to a50a112fb866 touches them.

No. Patch 44 does that. bpf-ci had patches 1 .. 20 only.
The test still checks the edge 6 -> 7. If it counts as an exit of the
loop at 3, the log has "first exit to 7" there, and the test expects 10.

> Won't test_progs -t verifier_scev fail on these?  verifier_scev is not in
> ci/vmtest/configs/DENYLIST*, and no commit through a50a112fb866 touches the
> file.  Should verifier_scev.c and its RUN() entry be removed or rewritten
> in this commit, given that it deletes the feature they test?

No. Patch 44 renames it to verifier_trip_count.c and drops the scev lines.
The progs stay. They test the trip count of patches 30 and 31.

> Should bpf_mark_reg_known_scalar() and scalar_union() be deleted together
> with their prototypes, or should the commit message be reworded?

No. precision.c in patch 24 calls both. join.c in patch 25,
equation_join.c in patch 27 and equation.c in patch 30 call scalar_union().
