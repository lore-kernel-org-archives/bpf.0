Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B6421CC44
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 23:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769557273; cv=none; b=nhhSZT9ZChZ93cocJDAwW7ENGdGlTn181Agvp1jpOzf9JEE5VKJoo6JNJ7DnKBKWMa2za5JL2whF+rkRgLDrpg3LH1ENIZxoYJYJg8pjNrw84AdLIE6vir+ltnEgxPhvPDe0X/haO1OJn70gB1ckagsvuwp453HgwbUtq1y3iy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769557273; c=relaxed/simple;
	bh=S/hd0ZVqJ5fFLanFj4NeEbHlzgdQc8L3/bdB5D20wZs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=O1AhoQULdL0d9bKfZDD3/I+EUSzppvb2n4hDFwLALNA4ZdKDum48klvdiDieN/V6tyRLn0BN/1x4ffn8NR2Wd43c9cCrPPjLqdi0mhbWgpQMq0i5ZhuCtpoVWxrEJj14ACXM+Cs3cWLduv/4UGk5QJ68zXLoaJWKEznxP7oF65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=EtF4IN7q; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="EtF4IN7q"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88a2fe9e200so62199986d6.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 15:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769557270; x=1770162070; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TvMeHacoUQlGIVwuEEJNjoJSg984dXoTcAnn4mER90=;
        b=EtF4IN7qb+zYN2uKY8oRStShnt6UlgC0c6IPqcZQcRYdK4pV7wH7yyv0Ac+K+4st6S
         aw8g/cmflw+4owh/NvRolNk4NnnsIteZhVFR7ICGjWSHmk3aRzqkPthLLUzut3YSkzte
         kedYdEJ46ahm7IFLFcgtdN5RQ/sAhbZ/jbU6p3ineC/uAR5FqfHwuWu6B4CvEg048tlx
         Fg4nwgO3xIIi9yMTQiiLPTfOtiH9Mizrhl4KmHQgCyyNAiG2DP4inAlC/ewq5KQ9r4sC
         Sx+sWb4r+YtSxWpYV/EAECzC6rGQwQBAr7f333iexLwvgCu/L2K/eSOkqgGUJYZgI1up
         +ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769557270; x=1770162070;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/TvMeHacoUQlGIVwuEEJNjoJSg984dXoTcAnn4mER90=;
        b=j9Z3GV6DtMUPc0IIrKaud7A6pWcNAuu110CfQKISTfl0VoDtLIjCRCtGcjswVhMDjJ
         xCRAFJXuznHDH1ZqQ8J+Y6oBrysewjjWZMY8i/D07omQpmEjNW+0Kw0mTC1R4RPyyJ5K
         bNkU8ZfMjRnosZ3VvosUmRNsHVxfdkjUOGg3RHw/NbjxT9nXo8AGjUazTFVUh6zdebXQ
         8zH26yyW2fbDXoImEY/igIO9c8bxNzShUQ5G9azUbjN0ngIJiN1hHbbu8XmSpQ6XSAIe
         e61NFJSzT3vlxhqdwiUbAV0zOGHZR1kMoJUig6nKp2f/wbNVnYAM34TCI3E5cj3S3sBL
         8H6g==
X-Forwarded-Encrypted: i=1; AJvYcCU3SqqCIcdVHk6jByHnlUb29F4PIdRhpodI0BJ4ggN/2NFz41KCECxb6+62HLqjMDLbUEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5NPQ+Szjvp30WVfZRkqStcTubTvVuGE1zs2sBj0ULou1v+0k
	D3Z3tHDPmOB7FFQLUpcuhu+wRpZ8AaD/qEQ4rJJsZBU6NlnuF7OGGfpe4Zan1X0Lpdc=
X-Gm-Gg: AZuq6aIOU2y6LyyIUXPJMKD+UAANk1/Nu4OGqqSxGABuqbbTIZNWEZmgpQGFsQe8DMi
	dmxlG29ZZ/1Z7z0TnIbvZ7jCdY/QidZ+QbvHBO/6PrmrEZuAtwLsU4bml1B1P/yjJjnmNTbMY2i
	+p3Hrseuv0k1jPHuz84uoxyAiZMZv+hCacyindglFA1i00nBIjHjI04lJbkT9yY8TWbZoecPEdX
	uuHkF24Ek6rWkTjBx8e6oe9/o1dPlI1cN+N5/EY3haR+ZUiMcBcC0tuMCALzCkNRTgWFlA/rmyV
	3vqmsy/jXYrKuUOHCkDnyw/GUwiGM3WEKE8IRIpqMNEAtSwxjdmayd0or8u5Gx/xbx7FekvWO2F
	5v5m8nmzVk0pU+OxlFBKvIPcRyzQ+kWlpM4V7LghwSb7sw+SgLFo9BLg9Rw1e/KmnY95cZ/5dj8
	Y7lR2BgK+RGEYVwTo1sWL0ZA==
X-Received: by 2002:a05:6214:765:b0:894:71b0:6afd with SMTP id 6a1803df08f44-894cc93f7f8mr51886666d6.59.1769557270589;
        Tue, 27 Jan 2026 15:41:10 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3741252sm6354286d6.33.2026.01.27.15.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 15:41:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 18:41:08 -0500
Message-Id: <DFZRP6TI6K6B.12EQ0UD7QO4N3@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <etsal@meta.com>, <ihor.solodrai@linux.dev>,
 <martin.lau@kernel.org>, <memxor@gmail.com>, <puranjay@kernel.org>,
 <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v2 04/13] selftests: bpf: Make WRITE_ONCE macro in
 bpf_atomic.h conditional
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260127181610.86376-1-emil@etsalapatis.com>
 <20260127181610.86376-5-emil@etsalapatis.com>
 <92fcc97e-1313-424e-b67d-d86effda3481@gmail.com>
In-Reply-To: <92fcc97e-1313-424e-b67d-d86effda3481@gmail.com>

On Tue Jan 27, 2026 at 2:26 PM EST, Mykyta Yatsenko wrote:
> On 1/27/26 18:16, Emil Tsalapatis wrote:
>> From: Emil Tsalapatis <etsal@meta.com>
>>
>> The WRITE_ONCE macro is identically defined both in bpf_atomic.h
>> and in bpf_arena_common.h. The bpf_arena_common.h definition is
>> guarded with an ifndef to allow for inclusion after bpf_atomic.h,
>> but the opposite does not hold. Add an extra guard to avoid requiring
>> a specific order for the headers.
>>
>> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
>> ---
>>   tools/testing/selftests/bpf/bpf_atomic.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/se=
lftests/bpf/bpf_atomic.h
>> index c550e5711967..d89a22d63c1c 100644
>> --- a/tools/testing/selftests/bpf/bpf_atomic.h
>> +++ b/tools/testing/selftests/bpf/bpf_atomic.h
>> @@ -42,7 +42,9 @@ extern bool CONFIG_X86_64 __kconfig __weak;
>>  =20
>>   #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
>>  =20
>> +#ifndef WRITE_ONCE
>>   #define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) =3D (val))
>> +#endif
> I wonder if we can avoid duplicating this macros, for example by
> including bpf_atomic.h in the bpf_arena_common.h.

I kept both definitions because the headers correspond to unrelated
features (atomics and arenas). Including bpf_atomic.h in
bpf_arena_common.h would work, and we'd need to update just a single
test that includes bpf_atomic.h directly (lpm_trie_bench). However,
any program that wanted to include atomics would also have to include
arena-related definitions. If that sounds reasonable I'll update the
diff on the next version.

>>  =20
>>   #define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), old, new=
)
>>  =20

