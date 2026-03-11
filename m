Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B83CEBA1
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225113; cv=none; b=kvamw1WZ7xKz4t1j0gon9dEv9iU3TFxJ1F6LZDzGrzG8MQc3KhPlP+anddw3VqKinqg2INOBsNEae7/Ka6iAETH4nMk9Fb4bsOZ3OSf1A0le73GZB0obcasfzP3PdN4UYOe6uEVrbGhusTf/IiiytTKo2RwvbMRH8rVMDCnWR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225113; c=relaxed/simple;
	bh=ySocSFrHgMZCuNx6RNYRgifMhoOZAZxfxZHX3fAUf9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5vZgbQVJobiPNpxb+kgT3YC9aEGKXKG7my5Kjkem1SZjm+pR1A78QDr3yVzWWa+9GBdfVCQp3OOB1jMZQhSINPMWH8W0q5KKxUAj/xW3Ik6Azf4RooOZqlyqy1KKq0hxvbUl6fe7VMIcCIM8/anvtt3NoV1yXHZ/DNKJQG7TXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9pfRRDL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6ACSZYh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9pfRRDL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6ACSZYh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773225111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4k7qkLfO0zvJghANa0uRNiBLEsBgn/V1IaIH7gW/As4=;
	b=R9pfRRDL+GXuY/i0Aq2nj8TGw/v+ksWfGrfJLEnrhgFZ9nUd8Z1Du+0HCVODSn6oK3vY2E
	UxOFJZTu8E7VUN3Zq+BY9d7qWTCQdwonBGeJxXY6maB3UyNYeWBNSYMOw4YxYH8JW8X1Tn
	VhpCaqcVJOOacwbwodfp0cfdWQ4ewPE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-KsB-cIP_PR-E8_w3imK3mw-1; Wed, 11 Mar 2026 06:31:50 -0400
X-MC-Unique: KsB-cIP_PR-E8_w3imK3mw-1
X-Mimecast-MFC-AGG-ID: KsB-cIP_PR-E8_w3imK3mw_1773225109
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439c5cce2deso8136422f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 03:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773225109; x=1773829909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4k7qkLfO0zvJghANa0uRNiBLEsBgn/V1IaIH7gW/As4=;
        b=I6ACSZYhijlQt83rsY8WVilK2oi/j4Uv/J1pO8QF802O/K34XNFamo+HrCtjeNA6ml
         U05bXH9I/p31SK+bbqfE5zKy2JtHREVs9jGvrdzfX+SmGSdzE1lqwn+mP4JitEZq4EJH
         LGdbmQFSQSXQLypaTln5Fgm08GCnz0PndIusxU9FXNzQIW7U2xLfoOcZnVU+Wd74hTLC
         5ibFw14KuDy+V9UkYlVv9WN8Lj+UKnBJg7V44lvXZo8d5LO3vZJT6Ttv8XtOdJpzyK80
         odOIlJf8EcnH2I10X7i8gcYsq5EIp7v+JDbHkB3Cyq5JsvnR9nTCHA8mZOMtnUjPUgTs
         /xEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773225109; x=1773829909;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4k7qkLfO0zvJghANa0uRNiBLEsBgn/V1IaIH7gW/As4=;
        b=gldGe0VqZ2c0zP4biHACNOCVsBLbRaeGgtPjqHNj3wAGvWNxELBYGeizO7IwB/zW+f
         pzxrnOlI/TYCA7R/632NJDKLfA4KLCxWHKukmJdNRlhlPLbv90/I50MhmeYiid3Jgjfa
         dzU5t3ixbVlOlq+bDgW/k9v5pXC/UuYAatLUQaqvV+itNb2ZtW1onlMFDAMAwt1JI9fl
         Z8WzgcBAvejE6AxW6UELeS9zRbejmQoYEXLw7htsioj7f6QXP66qTP26IVqG3fjKxVbn
         RSfm2o0jkYgy/vbYmoVtOwtezOIWPIHKMti35kthhxHJ2q3qFzXeLwbs1LbeglwOY33P
         ugJw==
X-Forwarded-Encrypted: i=1; AJvYcCWxqAf7NyNI/HoHKaBAH6dSR65zWHEvzfD/cskWo19jrieNPquv7t1dOzm/ED4v51p6jfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx15HQVRKUFUw7tGEG5pgQoJrpEFfgPHuVqhBrPUyjAW9CM9EdG
	2dBT7slEmxryjl2iwsFhzAfza+6eZBQ3BlCFyd658NVyScqUcT1pUsg5bEJdArmsHhV92xgh99w
	OjWaVJBw0Za8BYArvMuIvoZtJkTId+e3O94YBKN2HWwCyJZxc9xDX
X-Gm-Gg: ATEYQzys7AxaQ53A5IXswqX2cdIPHJYThw32w4z7MQRQ8ScKVT2pOgLjJoqhthj5PZU
	cbFC7HC0C0TP3Q5zXnGsMXg4m5mNYYXzeldCAhyjxYXKGdWx/s0XnvJmdiTHd7iFyIkgf9m1p/C
	5iuOHmO2zhBQNtsu+IaO1TN3j1zE4yExRj7MBazhes3okoZZGAia7bhuOnIuYc+L+Ks/IIagd82
	eOrTq4MhjVYlEbeRcEYyCnnEFc8q0aWn8cSiqqC0el7M2p1nr4yLXDd/OYvwpzbGbB31iZ1nudY
	ax3KtoL4KC3XyIqVesqR4zLRyYTByFYqvNj1np8+R3+Cq0PJI9QTAiKa8yKx69wYI56tx/Db835
	kmtntkQpFMQaaA9Hu3bUbHrZaSDTQM/PMEGCPq1AVJngmp4MAaRybZhoV
X-Received: by 2002:a5d:5d01:0:b0:439:b114:60c0 with SMTP id ffacd0b85a97d-439f8206d54mr4051663f8f.35.1773225109207;
        Wed, 11 Mar 2026 03:31:49 -0700 (PDT)
X-Received: by 2002:a5d:5d01:0:b0:439:b114:60c0 with SMTP id ffacd0b85a97d-439f8206d54mr4051611f8f.35.1773225108761;
        Wed, 11 Mar 2026 03:31:48 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f818d5eesm6695370f8f.1.2026.03.11.03.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 03:31:48 -0700 (PDT)
Message-ID: <25faef0f-7943-4c0b-97e4-4a3a45895e25@redhat.com>
Date: Wed, 11 Mar 2026 11:31:47 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/bpf: Skip bpffs debug iter checks when
 unavailable in test_bpffs
To: sun jian <sun.jian.kdev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
References: <20260310102145.857810-1-sun.jian.kdev@gmail.com>
 <20260310102145.857810-2-sun.jian.kdev@gmail.com>
 <f0d1eb34-2d6a-487a-b486-3dc64c25df6c@redhat.com>
 <CABFUUZFQfoVRJ6HJqadHhWNj4FVOk=snuSmuEepMD6jZfyrpJQ@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CABFUUZFQfoVRJ6HJqadHhWNj4FVOk=snuSmuEepMD6jZfyrpJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/11/26 08:55, sun jian wrote:
> On Tue, Mar 10, 2026 at 8:32 PM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> I don't think this is a good approach as it will mask genuine bugs that
>> would cause the files to be missing/inaccessible with one of the above
>> error codes.
>>
> Hi Viktor，
> 
> I don't think this change masks bugs in a silent way. It prints an explicit
> INFO line when maps.debug/progs.debug are unavailable due to
> EPERM/EACCES/ENOENT, and it still fails on other errors or unexpected
> iterator output.

Yeah but automatic CI doesn't care about INFO lines. It cares about
pass/fail status and in this case, the test could falsely appear as
passing, even though there's a bug in bpffs code causing the files not
to exist or have wrong permissions.

>> If you really need to execute the rest of the test cases in the file,
>> how about you split the test into subtests and then just add the failing
>> subtest to your DENYLIST?
> 
> Proper subtests  would require reworking the current fork-based flow to
> report SKIP/FAIL to the harness, which would be a larger refactor than
> intended here.

I don't think it would be such a big refactoring. You can still use
fork(), you just need to have separate `run` functions for different
subtests. True, the init/teardown phase would be somewhat duplicated but
I wouldn't see that as a big issue (and you can still factor it out).

> My goal is to keep this as a minimal change while still achieving the main
> purpose of this test: exercising the core bpffs operations (pinning and
> renameat2 semantics), which are independent of the debug iterator files,
> and clearly reporting when the iterator checks couldn't be performed.

That's exactly what subtests are for, at least in my view. You want to
check independent operations, you create a separate subtest for each.
That way, you can filter out some subtests if they don't pass in your
environment.

