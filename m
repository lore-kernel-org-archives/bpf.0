Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABFE30C35C
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780098794; cv=none; b=bBNuyqFi/HkKd5A8s9sXPeFE3KoQ1xZPz0yr63vOjsh07JpePE+aO2Sf04inMKVSWh63bncMwKE7E4KnQfiy63l3oWoBeQCUBRtT+QHmDQM1LCnmwHo6A88hRO/nK8xit90JJXQP6KnF24zf+oOSGoeU+amRU0nwWKo3uaW1Kek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780098794; c=relaxed/simple;
	bh=xhOgInewFbFW8Iy0jkSMH87jBpG4sa39mT3hb3tAZlQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=l/QfitJgTg6idG+7BcDZ3d+D26c+VlmJU94bqoDKfLrF35ki+W3BAzCsI9NoOzA3vV7obENiaRsIYQPv45hC/p6uvoWKsPR1Mj00U90X2C/bwPscHE9oiFMkRLj5THhRikNSeQMDJ/ZZzcHrLefEXeG3kPG27y1IoF5ES5Ot+e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=F9AEqpBN; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="F9AEqpBN"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-137bd9ed2b1so2193389c88.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 16:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780098792; x=1780703592; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oONRW2w5Th3AjO1FNstVzZ1PzKlD6C/i+053WanN9gc=;
        b=F9AEqpBNcDS9n+seIyi2GVMqXWE6+h4cXb98g2NR8dzxQi0JGbJDcKrtqXyrdesRDM
         C5FzjoZYPn9JR6Gbw3+pu0v9jA1gacuzRoAtu/WgKmrJBqMgDygvp7M3Qd2fyK0f9ena
         Sn81+4uGVunw6b5MFXNGRU9Rxzt0MdNQFfjTAieJvDAAYz5buO7mNUq54VtOVHptIRaA
         DQeD1gSyb9iEeuQh97HFatTa6NjFwQYeT3iZuX5YqD4zxbOaMxSME0tpJuIdl8J4022B
         QdkixhrD/vC3uPyxi8qvzna82//8cyXLlbhT8laATv1YMYL+b38RTxrVMu4zO5PmF67G
         Ao+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780098792; x=1780703592;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oONRW2w5Th3AjO1FNstVzZ1PzKlD6C/i+053WanN9gc=;
        b=knT2QzVLaDUeOuer2h5sy+OBAX1UfpNhBwQ7djywNFtFpJbzbGkbMCQR5ghaKMT4yM
         yylWoPXS4IorJ4PQh0/c0p0FwkQ92t+d4yvE/5wtqGI8KxnS8fC5Pv9NflCNNW0NEcjt
         AGYWCPSfVzf2HP9WFRQDeOocdY3AXt7z0RKK9ePfe9sC8Z0XNBmc9T/z+sFR1WeTf5Zg
         aA+1KC/C6wUcxRvtd0kCwXTLfPEMcmLyZFjE+RhL+gz6tD/ncY5Pk3NerMyuUe/7jDiy
         vTE44w4SdB0AQK9feHQfwIwtZJ6UuxnzUnNTpmaCu9sqWXNUhZQahnQtuVvLXWfI7Vpl
         N33w==
X-Forwarded-Encrypted: i=1; AFNElJ+W8DpiACf/NANWWkTWAML6YAt0WpMqVXwsF4ncXOQfAbQSAJ9/6c4clskVzcKuUtkUrV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/shBCI/xAvrvqeAREhYyJJEqtjXc6U+f9ug2cee20Sj0ZR13
	VTlesvffA8FAZ8ROielsgECAvd5iMgFh8ODxT8LDqBOdTRsnYQIPLDEZDrDzu8DtGjk=
X-Gm-Gg: Acq92OFyuVAfgVrBnux0EICVwRRVblzmhMOONEq1CKKfEPPZEQhh7aVWh+HaAgYECn4
	PGrc7BbtO74X1s3xIzex7rAcVDUJXRX8HnRvxteoTeXflFk9z3tpC1Eh6rkmamAK1ukseEfVc5P
	1P6WfvwAJcBL+CMqwgi3tO9Wej+gEuZBseusRT/mH/BCyyYAywAPIU1pyzbrPNYZ0p0GV7gQSSZ
	b0/o69aY3d+7R1tNWiBCJB+NB3vXAtYn4Vwjdr1VfguyRtrrnlRvq3p7GmPs5Ikya/5LY/cXHDd
	CMMB22kZWKTWZNshhrOWJowseLT3O8cAGMHmuyFPY9o/Dl7zy2RZEgtnc6T/qkirQ4VdUcpugju
	jS+/sC5JSEma7xBHl7ayebevdHmNBeROrW5+uuXfvaDc1qFuAvH/Q0XVDFjFTWfXYTdA3kIdAj5
	7jxk8MGVMYw3r2zlU=
X-Received: by 2002:a05:7300:72cc:b0:304:9b48:53d0 with SMTP id 5a478bee46e88-304fa4c81ebmr1118502eec.12.1780098791956;
        Fri, 29 May 2026 16:53:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::f4fc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a114dsm2657437eec.24.2026.05.29.16.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 16:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 19:53:08 -0400
Message-Id: <DIVKCTZ3SFXS.X30XCLLTRMQS@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, <bpf@vger.kernel.org>, <ast@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
 <kernel-team@fb.com>, <yonghong.song@linux.dev>, <zhuyifei@google.com>
Subject: Re: [PATCH bpf 0/2] bpf: fork state when comparing sign crossing
 ranges with zero
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260529-cnum-split-at-zero-v1-0-986c03752226@gmail.com>
 <14c9e9e95a07b6de94a142394c69b81d6587998b.camel@gmail.com>
 <5c8e69ea-df49-4604-8431-56e1b478402c@linux.dev>
In-Reply-To: <5c8e69ea-df49-4604-8431-56e1b478402c@linux.dev>

On Fri May 29, 2026 at 7:02 PM EDT, Ihor Solodrai wrote:
> On 5/29/26 3:44 PM, Eduard Zingerman wrote:
>> On Fri, 2026-05-29 at 01:13 -0700, Eduard Zingerman wrote:
>>> YiFei Zhu reported [1] the verifier regression after switch to cnum
>>> based scalars representation. When the following sequence of
>>> instructions is processed:
>>>
>>>     1: ... rX setup with [negative, positive] bounds ...
>>>     2: if rX =3D=3D 0 goto ...
>>>     3: if rX > C  goto ...
>>>     4: ... code relying on rX being in range [1, C] ...
>>>
>>> The cnum-based implementation only infers that rX range is [0, C]
>>> at instruction (4). The pre-cnum signed/unsigned ranges based
>>> representation could always deduct from 'rX !=3D 0' that
>>> umin bound is 1.
>>>
>>> This patch introduces a workaround forking the verifier state when a
>>> register with sign-crossing range is compared to zero.
>>>
>>> [1] https://lore.kernel.org/bpf/96c4a1aa4333d10b882a9b5093d2d982f9f106e=
3.camel@gmail.com/T/
>>>
>>> ---
>>> Eduard Zingerman (2):
>>>       bpf: fork state when comparing sign crossing ranges with zero
>>>       selftests/bpf: test fork on zero comparison with wrapping ranges
>>>
>>>  kernel/bpf/verifier.c                              | 71 ++++++++++++++=
++++++++
>>>  .../testing/selftests/bpf/progs/verifier_bounds.c  | 68 ++++++++++++++=
+++++++
>>>  2 files changed, 139 insertions(+)
>>> ---
>>> base-commit: e42e53ae23b7d41df22ccd7788192bf578f24da2
>>> change-id: 20260529-cnum-split-at-zero-3c03db9234d3
>>=20
>> I don't know why CI misses it:
>>=20
>> https://github.com/kernel-patches/bpf/pull/12235
>>=20
>> But I see two libarena tests failures with this series locally:
>>=20
>> File                 Program                    Verdict  Duration (us)  =
 Insns  States  Program size  Jited size
>> -------------------  -------------------------  -------  -------------  =
------  ------  ------------  ----------
>> ...
>> libarena_asan.bpf.o  asan_test_buddy_oob        failure         879905  =
209739    4158          3931           0
>> ...
>> libarena_asan.bpf.o  test_buddy_alloc_multiple  failure         269851  =
110341    2774          3897           0
>> ...
>> -------------------  -------------------------  -------  -------------  =
------  ------  ------------  ----------
>>=20
>> Investigating.
>
> Hi everyone,
>
> Apparently libarena_asan tests are currently skipped on BPF CI,
> because they require clang 22 [1], which is not yet enabled there.
>
> I'll work on adding clang 22 to CI, but in the meanwhile please make
> sure to test libarena locally with clang 22 if your changes are relevant.
>
> [1] https://lore.kernel.org/bpf/20260426190338.4615-6-emil@etsalapatis.co=
m/

We actually need Clang HEAD since that's the release with address
space-specific support, is it possible to add it to the CI instead of
22? Alternatively we would have to wait for the Clang 23 RC in July.

>
> cc: Emil

