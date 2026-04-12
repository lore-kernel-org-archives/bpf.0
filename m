Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478353624CC
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776018858; cv=none; b=If3nG2OWOfrdP8syDtanVJzH31D+c486TTiBIr281aCk86XD40PDJ9MS9mf0SthWREVIJwqJ8+8C/cSjOTXJMBzWhexM9O3mA3BirSy9YcaWMcZlzU49AgrxTNz+/bFbq1UrEhrsr1MpP3qJa2hNCBE31Sutc+HuGNSHo4uXR3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776018858; c=relaxed/simple;
	bh=1AAjN6Ot92FN+SDDO4FqRWSDZeDAexmiU/+PppVwah4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=IBgtTcQHd7ZT4FSMYElY01kq8B+8t5fLiyC0CsIB9YciiHvO2itLpNa6uKUbJvGLWfII5eCgW6gLVcZJjwuai20hy6vtKGOqud4zYRHOlgrx/LYyj6KOnTysc/HsbZ0Xt5jGi6nHzeLMwSzyOO1SEcq72qOcq+9/zX3K6CoRsiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=QV71ENoN; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="QV71ENoN"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2ab46931cf1so20657515ad.0
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 11:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776018857; x=1776623657; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlpsixpOF2bwjh+BWmuKc2S5Q7JC2uJWyortHExZM/o=;
        b=QV71ENoNvqpRZrsUF8SNxhRHb1s1ur+Y916ZqFpcgtbF+dGj8Gvx3zPNtF/cn/1nv+
         b9Jx2q7w3QDChYmz5EBpAu+lrLR6nxtj++/2oanFw+BPmgGuQ2QwtTApS5WNtXPHNpFa
         ASv8x0cQXko+iAS22R5CeK7Hz9lhOXD7bh6KHRcqEw3yuR3j/ubGk8pR1KCQKRMEEPY6
         q+IZYMB8imI54fkUu9wFdWDItTtyGgXqGqwrqix2VLCm6HTj7vwjq+TZDO2Tw1k9ieF3
         TkfL2r7uObpMliQ8restCI9nAPZk7Oc9xtaoV3ubMefWv5mY00237Ryw3/d874D3tb3Z
         RWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776018857; x=1776623657;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LlpsixpOF2bwjh+BWmuKc2S5Q7JC2uJWyortHExZM/o=;
        b=hJqMERbl9jLbV4M1PclRxFjyMpkJ++nWPFlPTol2tshFwbuszrkw16OUpS3ytgukLL
         k59iPaq6M7Bw9jyoN0AXEbNEw241u4o5wTseG1DShQ2C+d7BFpG4vwVQTL+LqGtGbAW0
         rFYJ5DNlrJeUsJ41o6g9QX71gfJ5ziWZR7h8tMM2jua78rF5C8fQaN8wkopxtI7fxiEy
         WfF8nvWU+1tyvMd43Ybqq+t6BNEWf63/aVnOt7sTKLQD6/J49tniuE0wrY4+6KOzn6Uo
         4AT+yDHGqRc2asQ3lGHbG038DRN7mqlOveorm14lzhqI+ECY2G8eVuW1/4DY3OyVwlBT
         OAFw==
X-Forwarded-Encrypted: i=1; AFNElJ8ZwbFSUyWu26VdTzq+o83zy+ys6oIjVuf8QSYk32pj93lTwJOVJ+X2MUOvy5z+HHWJirw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7/J/n8ZJZMQsUkLUhB+pRnpsJHvk0Rqc6UGUs/53bEl0yI2bU
	xWoHaV87rFdFcNzzGWez/4JFPjnfP14U0766umzP2grSVgsvS1OQ8i8mRz/DlUkWoVgguriV+vO
	CcOSq+zr8tQ==
X-Gm-Gg: AeBDiev+MCTRPmkAup1+4RwDnTyRxUveUbtKE+GEJAsDsWtZjT7fd00uPqMFHxbjbeX
	esNSWr3lO8O0U1pXaIXhFPD6BtAlVHPDyJuUAeDCsNmbbryfDt/+MMFokWJyea5fX4tVC6H+Z1z
	Wz8lpHcRcoikJI2/11fepR8iVN2P2bYf4eysFAIzOUKYKkbAtYOxxDFV+gD8sQOiCxMv1fJg8ml
	pK3nvoJ7dGS9ar1I6tKriWpEkSAdshMpkNYKaN/OAmpRv3GWei/7bb3+LRRrnLneBnjZn/MHLoZ
	IvZEuD//9tJVERO7YasOdqDmEddkSQNibEm9cwQvpCVH4pqaSxJduqM6hn61llYPHLZAYm0mBx8
	AlHYdUQhvfK+QZCUln4g+BDps50mkLb+rdZL/al10bKOnfrd71l5RR2JthhSi2/cRFFot6513fM
	0j3o8anBA=
X-Received: by 2002:a17:902:f64c:b0:2b2:5168:2f82 with SMTP id d9443c01a7336-2b2c7384dddmr126319685ad.24.1776018856526;
        Sun, 12 Apr 2026 11:34:16 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f48cfdsm93930355ad.82.2026.04.12.11.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 11:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Apr 2026 14:34:15 -0400
Message-Id: <DHRE52J8R79R.3IK2L5DG23AUG@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <song@kernel.org>,
 <martin.lau@kernel.org>, <yonghong.song@linux.dev>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v7 6/9] selftests/bpf: Add arena ASAN runtime
 to libarena
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260412174546.18684-7-emil@etsalapatis.com>
 <c06f36b021360e0d00ab3b8c9ba1916001937e8fcdfe1d721c11c5574bcf7830@mail.kernel.org>
In-Reply-To: <c06f36b021360e0d00ab3b8c9ba1916001937e8fcdfe1d721c11c5574bcf7830@mail.kernel.org>

On Sun Apr 12, 2026 at 2:28 PM EDT, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/asan.bpf.c
>> new file mode 100644
>> index 000000000000..fff12ff50f26
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
>
> [ ... ]
>
>> +SEC("syscall")
>> +__weak __noasan int asan_init(struct asan_init_args *args)
>> +{
>> +	u64 globals_pages =3D args->arena_globals_pages;
>> +	u64 all_pages =3D args->arena_all_pages;
>> +	u64 shadow_map, shadow_pgoff;
>> +	u64 shadow_pages;
>> +
>> +	if (asan_inited)
>> +		return 0;
>> +
>> +	/*
>> +	 * Round up the shadow map size to the nearest page.
>> +	 */
>> +	shadow_pages =3D all_pages >> ASAN_SHADOW_SHIFT;
>> +	if ((all_pages & ((1 << ASAN_SHADOW_SHIFT) - 1)))
>> +		shadow_pages +=3D 1;
>> +
>> +	/*
>> +	 * Make sure the numbers provided by userspace are sane.
>> +	 */
>
> Alexei Starovoitov flagged this comment as unhelpful in v4 review.
> The validation checks below with their error messages are
> self-documenting. Was the intent to remove this comment or
> replace it with something more descriptive?
>
> https://lore.kernel.org/bpf/CAADnVQLHFZE3AFzP3gtZKvcaX+3hbp3pCw3JLqEtpdoQ=
+OUf7g@mail.gmail.com/

Missed this during the comment removal pass, holding off on updating
for now as this is relatively minor.

>
>> +	if (all_pages > (1ULL << 32) / __PAGE_SIZE) {
>> +		arena_stderr("error: arena size %lx too large", all_pages);
>> +		return -EINVAL;
>> +	}
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
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/243130=
21445

