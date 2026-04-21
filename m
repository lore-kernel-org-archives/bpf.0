Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08172EA172
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794173; cv=none; b=dz7luH5tXVBB15FaIoxxlk2/42sXg6rM9H6nAu4D/lz7ke/Q9NEd4NhYjLMWO86COeItX1N7jwor72Mei7FOFTW7aUzGLxPigUQGa5CLQOH11JF+y7gvVtYNxZGBKID99VCaleBHcqI7tbn9oJkLsHAg+uFmnWhdC/Ue66EZQJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794173; c=relaxed/simple;
	bh=HBAoCtM96Riiq/vO19M/Upn6drkDccmKmKeTXlp5hSM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fAKM3GAIOJFt/qwNbu5O9PjYSZN2z7GDcZ6PVCju4Fjs+ABGBBt5pDigtOSz+i0Tte2wWWk/WMWG+059gnzhr6W4nLC7HWufQwfrszEh9XNQ/G1fw0z2EWjv67Udc8VU6bDq8bco8HFXTIVs45sESc0Gk29plRbxhM2ueoWCZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=QjmJg6xY; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="QjmJg6xY"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-1279eced0b9so6573294c88.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776794170; x=1777398970; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuqO6+e5gOTg8ZfPbYTUhvyMvAY5Q8bSvrs5t2XX0M0=;
        b=QjmJg6xY7zJgqaxE4ai02Oh3dq384Yz7wTWYH4omqrpc/e/0yh70M9YmPBOnsv1mqJ
         cLEb7LDyM9BMp3GdIp4ceKokJExf61GaRVeFSvGLkDE1IPW/XHIsKIQnn+wXXTkw4aKn
         MixqWjNPa6SWc5jJQZluI9GJF4wXN5edM+COHBTTFMPEfywU9nZ2pEWXMB8FO+mhTnAa
         RImwzFmqssSBIazw0EWGHUg6wqjQi1ogmVgxl1A3+DmblLVAhoN9rP103l+ky7sq/9S+
         rGjEKBVmcs8YF42Swg9VMYTD9OT+sDkmHmdD2sva6auAbqJ7A19tMO9LpfmvMh/3oMEB
         l5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776794170; x=1777398970;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FuqO6+e5gOTg8ZfPbYTUhvyMvAY5Q8bSvrs5t2XX0M0=;
        b=aJxYv8UuSEc+Bz87SMxi4LY1fE7FxnjkkuBAND6ltA6OYIql+P8orXI2xxhbYrriyl
         3Slt7vYV/brmtVm1IYwcgE0xUdD0wi7M8SaK652Jruu+rXfd1lOTA83bLyG58u3kwA86
         mcCu5yfwJfnC++TklHMFdsXYZdQrrbn2nWidIPnDX4ODJncbNdNHvmoDv/+AwVp4X/8R
         bjiijQH5psgnPmM0LI8sogdXK32IwqJQhgPzleMuuJDKYdofpBa6wLEH8ytorsvau0KG
         +5mjvzwC4y3+bXfvU5WG3wpbRXvOnOaBC3CDeBE8MI9gwEgfy1xmZXU5cuFsvBoFUdPa
         YUDg==
X-Forwarded-Encrypted: i=1; AFNElJ/2VeL9AKmMfcArWi4uh4+Vmb0Ci3MHzWjkkVp435P4o+l8MbsDFEI1FNc0+H1X9XaheBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyluPPt0VAey6JIlwMcDVqaPzB+Q0S9qdB8SIkXkNog+sJV+SJm
	cUE2bjuwGEsIs4y72beFO794NFagWB2C3G7khQm9QNbhinxJbNE7TLKTolLWvdP6vFQ=
X-Gm-Gg: AeBDievRIxiVrlH/qXcyMn/obJW3ZSkAJgDIA4VRiH/nDkelo293LqWETm8prI4HT0h
	c1/3buCcQ0s2M0+4zXZXDFl4E3U09SKLp7otj/VkN13q5QHqeQ95xo9Sc8bUcmhtyF+zIPGsk8l
	rWI2wwcOPcokKeZDhTxYQD06hBYBaWU6j51uATxCC5Svj04aiwZV6fbTLyYPARFfkdJVo2Qmk/+
	W1EZX9ce3pYT8oh6olFb8Ax4dkAGVHF6UG2hPq35jven6Hx/ZVkJ69HCef9TwaTwr9hhk2NNlyk
	WdcckPNv26OrnOGpDppYx4+c+GyJ1ocqTtJh8dWoeT/WfkvyYsTRq/eQ/KjkMEEFulLiZZAzffL
	OwnBPG8GfSShm9fD/Al1uTKfSHXEN2aSbesT1ccwR3ip66AtZ7N/0Ssi5/ZJnOiOz6dloM2zx5t
	vxWVzaFfwP8CvBuA==
X-Received: by 2002:a05:7022:6b97:b0:11a:342e:8a98 with SMTP id a92af1059eb24-12c73e2ad32mr9942050c88.0.1776794170244;
        Tue, 21 Apr 2026 10:56:10 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::baf])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c749d29cdsm20780240c88.6.2026.04.21.10.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 10:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 13:56:07 -0400
Message-Id: <DHZ0YSBS1TIV.297HYL1XJF0SL@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <song@kernel.org>,
 <martin.lau@kernel.org>, <yonghong.song@linux.dev>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v8 6/8] selftests/bpf: Add buddy allocator for
 libarena
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260421165037.4736-7-emil@etsalapatis.com>
 <f6f35b4cb34724773df4e2f2d5014f64048931cd6eeb747875a84f3a9d1db4ed@mail.kernel.org>
In-Reply-To: <f6f35b4cb34724773df4e2f2d5014f64048931cd6eeb747875a84f3a9d1db4ed@mail.kernel.org>

On Tue Apr 21, 2026 at 1:52 PM EDT, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/libarena/include/buddy.h b/tool=
s/testing/selftests/bpf/libarena/include/buddy.h
>> new file mode 100644
>> index 000000000000..00e2437128ef
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/include/buddy.h
>> @@ -0,0 +1,92 @@
>
> [ ... ]
>
>> +struct buddy_header {
>> +	u32 prev_index;	/* "Pointer" to the previous available allocation of t=
he same size. */
>> +	u32 next_index; /* Same for the next allocation. */
>> +};
>
> In v4, Alexei Starovoitov asked for a mathematical analysis of the
> memory savings from using indices instead of pointers here:
>
> https://lore.kernel.org/bpf/CAADnVQKnHXg0YnuLvzfXjszMaqugpMNWD5=3DipffWS4=
GVNg6rFQ@mail.gmail.com/
>
> The question was: "BUDDY_CHUNK_ITEMS is used like NULL? The header is
> u32 + u32. Is it really worth saving 8 bytes? Use two proper pointers?
> How many headers are there? ... if everything is a pointer the whole
> algorithm would be so much easier to understand. Is it worth it to keep
> indices vs pointers? Please do the math and explain the savings."
>
> The rationale provided in the discussion focused on ASAN effectiveness
> and memory corruption detection, but didn't include the mathematical
> analysis of memory savings that was explicitly requested. Would it be
> helpful to document the quantitative analysis in the commit message or
> code comments to address the original question?

No, this was resolved during discussion of the earlier version. Using
pointers would mean storing the header at the very beginning of a 16
byte block and as a result defeat ASAN.

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/247360=
48353

