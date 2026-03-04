Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9DD36BCEA
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611229; cv=none; b=Ym46K9hGYIqeu8j/LSmolmt8HW0J2/xmm4UPncFJinFmuu7PGlqFzxP+hqjOxRYiraC8ubRrOWlL14Bloyl7sZis51rA79YvcJ/pnC6Ay69NAL1ND2zsQ71MjcS+8QSZzozu2zY/VaJF12HGYYR0UYvnb3Pwa4IJr5BtE05E0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611229; c=relaxed/simple;
	bh=kMUUQDzznqRvF1LLeIcupGnl7rhKPcy9b0LRaImOvMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnygynWi9ssOsDA5RIFVZG+rJjo7tO3ky7tLSASRs73UEuwFIDb1KkPXSN4VJLrXuriZzxkiVJqPJ5trS45ZaCTKWUQP9dGv/BVOtk+eNZ8mcvW9y9qLnXV/q63NxCi9FsbJsIvQAjZ+ODEaz0AxXsM/TblkiPik8xxNKarlon4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBimobs1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IIqw3yVr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBimobs1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIqw3yVr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772611227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ze7UOcsS/0AQxjqOP6QoDrpCM4RWmrrojsTRiFn/AcA=;
	b=fBimobs1UE0Fw5Bd1dlHHAFUK0PKIgo4XGRn4I9eNRBbzfKnH+SLnmquQYm1ApdSPb6/l2
	jAC1mi7v16K7XFooc9clVHq0RubOzsTjbeY5s6A3lEDEO50lKVN3pu4X0ZuBbhJLXVgLqr
	UQcKCk4+z17JKggPNVKuB0IX/ypkDoI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-xS2Cab4MNLuFkKkukgMKrQ-1; Wed, 04 Mar 2026 03:00:25 -0500
X-MC-Unique: xS2Cab4MNLuFkKkukgMKrQ-1
X-Mimecast-MFC-AGG-ID: xS2Cab4MNLuFkKkukgMKrQ_1772611225
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48379489438so62165825e9.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 00:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772611224; x=1773216024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ze7UOcsS/0AQxjqOP6QoDrpCM4RWmrrojsTRiFn/AcA=;
        b=IIqw3yVrFWp94iv+h62GZUGTrq8V2TONxJFPx0+H3o4jcjB2OhJNMYZtwzRSvoveRW
         R1v8tV1OfhPs/G7MBtGyfqQoG98PAuGKWRW3mRe83pm9YeFV+Qn8lOVzr5hFMTYW+0rQ
         xwLr8UGSFa5HekldT875Sh1SbRnbbt93YtGYco2mdh5I44fW/BNNJlGWGJaHBGJOOAUp
         sC9dV0Mr1emGraOlgo5uhEI4L6K0am92B3fOL3g1cJV3boYkNwegNbtVsAOJtvcTtbco
         f45RwK/x5a4BjrN8ZDm8dh6SX4EAkBf08kOWLwQSJAp/uzm9ObRv1UMfU0tlUAIUG3uQ
         uNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611224; x=1773216024;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ze7UOcsS/0AQxjqOP6QoDrpCM4RWmrrojsTRiFn/AcA=;
        b=cermuWYxWzSInCQP0B18eFZmu5+4adpXT8D7aWgDlMcP168+kMMcKp8cPCsNy5fLEl
         yTVnkZg8n3KCV1ft+Gd/Er5DCWbW4xBDr44dwwg/PyVbWc1PyYpp8iqogCruNQNUs3Nu
         jzFNLI6mgvQPPE5ww304kzGwsYQ+6aE8wKyWoK1Ppgw8DjpKgod5nlNH9V2uLkIt3JXA
         S/ViARxoXV3rMu6ZuNrg0OKJUsF2NcI6hNOgBEM7+tNhpOqxUP0iojzXNeOM7SxmlMB+
         dARnrOMDjl07ApVzUThP9jK/b2ny83SVn2k9HvQh5BfMybZHn83mQUSh85tVWcXk4SQq
         JbaA==
X-Gm-Message-State: AOJu0YxqUkMjdK6hzQwquWTl7T1Uid5KGcJoBn1U+tXYxjdR8NP9GmEu
	S1p6ORMubfmlLgnf6wsuWygTwQwozA/UiRBpw+0mK1NamOdBbvea03zXL+xPF5wp4jVZrhCg16f
	fINn4qryeFfrGdyJyUFFL/vcIh617muSN4HwjeTHnIij1skHM+mDf
X-Gm-Gg: ATEYQzzHkmh4tLf3/2q8nB+hZwJfSckYsHcTAc6vPYRrMKMa+o6z8cldjDWG/1/tQgA
	8Go+FSwY2BEom0k26Sathyy2vZK1DoH1kezOfz9yB7rtXftwER6Pp7/98gGt4dMirhUZToWd7fu
	wmx1ARBJ5BmF1kC4fQndhoUIg8p4RzpB5viQ5830MN4zmLQJrdRMIDM3aY8UXNmYXY4DJdoAZxB
	9JGJrczzbxvvWWjNIOLGPRExTluF9+XGaE7HHGhV1gFifvxUBIZUni2pGf2QtQUuOd3t5IrreuC
	C5H7vlFSnEeEbeGXfTch0quBHJPc3+uR5T468TAjf7ixfU1yCtd50jIb01UEJnk2HKDlrbGAmDl
	JKUPLJBubtyZ5GZHV54zKyuH7srFspNmKjgiAbywOhRsGNNoUQWE4LSufrg==
X-Received: by 2002:a05:600c:530e:b0:483:887:59b0 with SMTP id 5b1f17b1804b1-485198be61fmr16301735e9.35.1772611224049;
        Wed, 04 Mar 2026 00:00:24 -0800 (PST)
X-Received: by 2002:a05:600c:530e:b0:483:887:59b0 with SMTP id 5b1f17b1804b1-485198be61fmr16301005e9.35.1772611223270;
        Wed, 04 Mar 2026 00:00:23 -0800 (PST)
Received: from ?IPV6:2001:67c:1220:8b4:be:aaf2:74d9:219f? ([2001:67c:1220:8b4:be:aaf2:74d9:219f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a8aa589sm6024015e9.5.2026.03.04.00.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 00:00:22 -0800 (PST)
Message-ID: <c37a5cca-67d4-4eff-82cd-665913d61888@redhat.com>
Date: Wed, 4 Mar 2026 09:00:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Split module_attach into subtests
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Shubham Sharma <slopixelz@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20260225120904.1529112-1-vmalik@redhat.com>
 <CAADnVQKSVu-dTqqENSdznsoo6cva006P8qAJkx4RTp8JyEXVig@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQKSVu-dTqqENSdznsoo6cva006P8qAJkx4RTp8JyEXVig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/3/26 18:26, Alexei Starovoitov wrote:
> On Wed, Feb 25, 2026 at 4:09 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> The test verifies attachment to various hooks in a kernel module,
>> however, everything is flattened into a single test. This makes it
>> impossible to run or skip test cases selectively.
>>
>> Isolate each BPF program into a separate subtest. This is done by
>> disabling auto-loading of programs and loading and testing each program
>> separately.
>>
>> At the same time, modernize the test to use ASSERT* instead of CHECK and
>> replace `return` by `goto cleanup` where necessary.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>  .../selftests/bpf/prog_tests/module_attach.c  | 171 +++++++++++++-----
>>  .../selftests/bpf/progs/test_module_attach.c  |  63 +++----
>>  2 files changed, 148 insertions(+), 86 deletions(-)
> 
> Applied.
> Could you also take a look at why the test takes so much time?
> time ./test_progs -t module_attach
> #220/1   module_attach/handle_raw_tp:OK
> ...
> #220     module_attach:OK
> Summary: 1/14 PASSED, 0 SKIPPED, 0 FAILED
> 
> real 0m5.072s
> user 0m0.275s
> sys 0m0.199s
> 
> It's not caused by your changes, but would be good to understand and fix.

Yeah, I noticed, too. I'll have a look.

