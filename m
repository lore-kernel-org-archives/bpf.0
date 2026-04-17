Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A8821CC59
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776450098; cv=none; b=JKQChNI92DfSaGz8gQBfonP3iU+kacDbnvpv5tF7IMDIXxKqEL3cJYDAw3ZeFXdYa8MIJSBhJz3Cd079aQ8QxFwFUO872wJEKv9lmM21WNVJEiUKi7YsqKFcLXFcaykbwnnvIG+AzMH+NgMVD5zgAntuY1k83lpUtr39WA2WJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776450098; c=relaxed/simple;
	bh=Fh6VB4BgekLbEVMgMmxT5KbHKEYqK6+Z1MLV3+zQseM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AhI9pDPzVp5pXcEuyMSpiHIEjR6Y+SGAC9283XsJcsSqSZQuWNaJMIE0EuNYInr0jx3+VfXMU1Gyzr6SqxipQWAgUQWTZPBWW+n6UosaTe8qxbebp3k2rdzVYKzbutm0mIckKzJazIRfvpQ4RS47Nzgk1Vq3eNO8gCbp1xCbOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCwrs0f/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCwrs0f/"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so1200185a91.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 11:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776450096; x=1777054896; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fh6VB4BgekLbEVMgMmxT5KbHKEYqK6+Z1MLV3+zQseM=;
        b=XCwrs0f/oRlEY8Uw+5jnLSkJsBRYYuaYA4AaF3/yNyMd6aCTcNrZi27ozJK0ZQk1er
         tK1bOw64NlQBglorBGe5Fs5dUp+N6wV+N8ctXCFsX8vSc2zOyyL97CWFJlGpMi4l2GQH
         9jdjsYYkgEeSjNjuhKktyPHHaHI4tfZgfUetIPDLsA6pOlIE+UpEaaKu1ujTrh9lkmSX
         C9l99Cj5n4CPAC1vZtY56wwzZzKrP0h0kKdsvyzf2AnkDOZBg69tx2oa8b5ireZCZ0vw
         bH8YUkc0iIOrNn3VCiG4SuATl05VUCe+i+Q1p3DsCwocfgPhWv7VkDbPP5Ki+yEvbzWq
         zHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776450096; x=1777054896;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fh6VB4BgekLbEVMgMmxT5KbHKEYqK6+Z1MLV3+zQseM=;
        b=MBoJSU7ps3vDbboXYBf0PJkJFeJSj4A5hbj/uNH/AnQ8fzVTs+Eo7IJc1bwE5b0JJo
         vPl7UB2RadnCimh95shi42APZzP+O5d5/2lEuhsBFB8vmqbbMLIH9w2EWhAPgQuupb35
         RXYv3q562aQ4s9EuVVDcRZqfbEPchdnCYQIGGrAQieWmu85s4pm5bmb2k/O9HPRP3QHz
         7Ng8DEA8wCd+5PxQUlDic5igRZNcF9LHinU69LtC/0BMlMyubtE6Lf6Tbd0sLioeHDrz
         Td9ZYU4t/dXFv3ttvTeMW43Ix+yvjI4/VAU9ieAP0yEfuW2xoFL3BmEf281uG+NWogWj
         oMPA==
X-Forwarded-Encrypted: i=1; AFNElJ/cDWO2VpY/7tv+X9UfTQab7gRbNnyEwyhvuGFWJOgHWBrUiwwyeOvHMpIa7Qhx7gyDgjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYoSe6HAr68M0FDf58k6/+z6cScM7scvOoZKdY7RN95VrDZC5s
	Nd1FnW8ZxBSZijB/cY0XNkYi74xt12mtZc9RzwCPs8yLKRERnGM+bn5k
X-Gm-Gg: AeBDietd/6KQ8Y24XQ0d27X/FaXkIsKUXoHyKHJlzPkLo1US896WRwFXWbkWnt13P0r
	iqmOsz1mgct32S4GWqZnnetloZaV9twKuQGet0F739tM0pOvVlZAAIAN3bH9XDSYlQLNrbumzdT
	yOKdakODP4EYg0xRhorJIsPwCeHAKR+g0cdG1lDfaeILDfK22/HdOLB/+G0mQER8VenTFXOBJ2a
	LC9xYC+/GxFRo0kuQ9S7AAt8xx5g5GVS2Knam73H0PVlXl6rwVh2elu9PueDYWAxml/Ndr/lEFo
	ItwBcG6n96g4JVU81HQS8jNRpdDE3UAI4UHtLjnDbZuyzy/BVMzZcTuG73AjPzwj5IkiCVHXeHw
	NVa3ddPN5nLKey/VtNj70ZfcIkBfgZUNqs4ilEYHlRGj7lR7S/aAjFkSpUWpdkc0tq+SQhxzn3G
	xQwI5Wd7pjQ4Q5f4g+XjIMIERR5TTToJuDYpfG6dJ5aTL+NTaFuCTR40rxMqWDfDO+8x3eLPWhU
	+Ucxp0JTFDZi3TXoD2tZJc5Ji1ocIHkiK+ayFwbkLr4bky2mZOTN9pB
X-Received: by 2002:a17:90b:1fc4:b0:359:8de8:1229 with SMTP id 98e67ed59e1d1-36140490bf8mr4543953a91.21.1776450095777;
        Fri, 17 Apr 2026 11:21:35 -0700 (PDT)
Received: from localhost ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fbd970fsm1069796a91.14.2026.04.17.11.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 11:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 11:21:33 -0700
Message-Id: <DHVN02XJ88CO.2RKJLH02JAHI@gmail.com>
Cc: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "bpf"
 <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Eduard" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH bpf-next v7 0/9] Introduce arena library and runtime
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0
References: <20260412174546.18684-1-emil@etsalapatis.com>
 <CAP01T754f+qzWDG=9PyDmOXuL1mn9R9UBAtUor-RdzDGMGZx7Q@mail.gmail.com>
 <DHVIDBPOK7I3.2837ZLDGJOBY@etsalapatis.com>
 <CAP01T75tGi6svN=2oPpw0m+-UcHk2gnOw989fB7GFh6J19ru4g@mail.gmail.com>
 <DHVKPB8FLV9R.7ACP5WZ7Q751@etsalapatis.com>
 <CAADnVQLtxN_+H0KKFdukO48c9zsR9m4RzpEQGhj0RHMUFvu9AA@mail.gmail.com>
 <DHVMLVAMJT7X.GMOA3L4111QN@etsalapatis.com>
In-Reply-To: <DHVMLVAMJT7X.GMOA3L4111QN@etsalapatis.com>

On Fri Apr 17, 2026 at 11:03 AM PDT, Emil Tsalapatis wrote:
>>> libarena is different in that it's BPF code we distribute as source.
>>> Plus, the test runner is an example of how to set up the arena state.
>>> It's very little code and automatically identifies the selftests withou=
t
>>> having to explicitly enumerate them, so it's not extra maintenance burd=
en.
>>> For followup patches it's been 0 LOC to either the libarena selftest or=
 the
>>> test_progs test.
>>
>> I think what Kumar is saying is that we have only one runner in CI:
>> test_progs, so all libarena tests need to be covered by test_progs.
>
> In that case I misunderstood. I agree that everything should be tested
> by test_progs. There's currently the ASAN version of libarena missing,
> but we can add it and turn it off if the compiler doesn't support it.
>
> There is the secondary question: Do we want to have a standalone
> libarena runner in addition to the one in test_progs in the codebase?
> Imo we do, for the reasons above.

I think it's fine to have standalone libarena runner as well,
but it may bit rot, since CI won't be running it.
