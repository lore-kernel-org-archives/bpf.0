Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A72989B0
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122272; cv=none; b=oqhX+VQ1hxIJhw67wQ4Zo3cy0Inuvpv82VV5Y1yhObPjmTcV6XoCdtPHeH00Y/1JCqvJZRLGDE0xey/kG5CwGGmXoTzisaieHHFOD/G6so4KPxs0QVqxVzbQ3Vc9TCMP49//+XAT1Y6U2oeOcI6odralbRAvk5WGZ2YqIdD64xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122272; c=relaxed/simple;
	bh=r7yevapaTVOLPi2EMY3yRB3VyEnuiVOGm6nqUqP7j4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgLkTX9GQppSk1Xrb4wS8xwaefM9i0iKDz3c+SCIEj6Vlou4B0f8UIDH1rZD7krEE+Hym+0BWNMzuiTqdKAaBrRd9AO8XcF2WXvhLcql5WbdR7TVudDQfT3NLSofxeC8YdvmV8VHvjsalchrZGkv2KpPAgY6NkZ6xMOQAza27Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyCEVY3K; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=csKbZ+iS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyCEVY3K";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="csKbZ+iS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784122260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enHATtN5iwfaTojb3cX860YgJN62BkbBuCc1G6D8rKA=;
	b=WyCEVY3Ky9Ijfz66CkDlKH9+8duvV1KotBs0TP62O1A9UdaQtthe3ZcUweG9LR6VZuVM/u
	GRnJ3ao2RCjLdlMalCff2paEtezFsNQVw3VgMhOgo4orkdJ9K3s+D3nbI+kBZ4esnuiNoJ
	FUe8k/f72U5v0j6b5WfL9SzJ1A2hfsQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-J3hA3cYOO7eP1-QJ8clSqQ-1; Wed, 15 Jul 2026 09:30:58 -0400
X-MC-Unique: J3hA3cYOO7eP1-QJ8clSqQ-1
X-Mimecast-MFC-AGG-ID: J3hA3cYOO7eP1-QJ8clSqQ_1784122257
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493b54823bdso4528505e9.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784122257; x=1784727057; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=enHATtN5iwfaTojb3cX860YgJN62BkbBuCc1G6D8rKA=;
        b=csKbZ+iS0sqSIrU76V/rgED/qwZzEpeeinRT/Wj3CIiHt7qS2bUQyiQO1JeClNk5hO
         EAugLzzgaFJi67YRAcOvB4m5qizuxek48+CoBaU2iXNfzqXfG6yof5l3LlE5GSUTK6MX
         F9AP7Do/sJIpRwGA7U7yHHiw8cVwOn/yNOyNquOY0SZiw0+5dCHehLwcDbAcem0zFiZp
         GgdtQFeYQjff9q6qZbfuO3QKADf4ASlZSjOvNc9eoyndEcPTx6hcqA2kAKtKiVpAW9bv
         aPLtGB0YSzMvkzog2X1P4W/InMrdLxJCX9EnDUujd0E5XF9OnLP+W6c54LSTF7CYSoZd
         04xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122257; x=1784727057;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=enHATtN5iwfaTojb3cX860YgJN62BkbBuCc1G6D8rKA=;
        b=WzkJrzGBSlh4oeGBlGlnZM+/s7pYu12o8HYqI+tKm5dFHZJebZuHWlxHmPFkuA2JQa
         e4auOY1tZxvnfci0d+3VkaQnPMA7Y09jC3krHdBEKE6i7eCaBOeYmiRNuQy0tv2m8Jwi
         KOdC1pWmHs5MKAYcmf0vMG5RiQSnlTOE09pKEubN1zZUVLXPr9MNTn0rIiG5MqMpr6no
         QKmVPoQLUR7frHXtQ8fDqJQwbozAGIGGL5xIncONv6IhkNgVHS833T/WRHt/4gJsNH3n
         BSmrMzUxfeWMXVvpaSDJlp+xaAfQtW4Co1CtBzYC99V2rrB7jZuGJ/QknldsJx+GWLUv
         IOjg==
X-Gm-Message-State: AOJu0Yw336SAyL7knyrwdI1Gim891AZ4Af3l5qlDXoOXl+xDdadS80Xd
	wsJYO+kMh/FVaHeqkV1+lwCJ8jyTonIK3EYqZOrNZKZvl0M5gun+XveonPutPSUPycuuLWarjXz
	A1uNgxdYvxLYqpyGEa3S290l2766A7uERQUbQW7N4sqsiSa0M/uh5
X-Gm-Gg: AfdE7ckNKrwj+H1gSz60iNFrCtNwJum/9sbSZ4Y9x2pRD2Y5ww/lg1avFwTEsa3zCZ7
	qvlH4pqkZyiggFF5dsDX5JDxZ++rjCm3/M0OsnzwT3bRNdDGL1SMo+r05YUafeHoVlkgpOVd9CU
	YIaI/vTBo5+fkKo++4asG8shnyK/g5MH8qP7sJuNW29DlT2KbHDmMxhpBpvg3Vrhh5PqUsSjs9e
	mVuSuo/1uQ4kyI1EDYvvR7CRIUmnC0hsP7UQ+B9rt8qV/wu/RysC04fjereK3ScS2nyDnHfeXVj
	COY4OfhXDQdRhBDUCQSQvtzWes0XlGHu9g9UwDm78TiyqfCXowiWzs5JOF0M5fnHzF9dVwdj+Yn
	dCUiWkdwHb2VwuZzciVqKj4DCqbbapkWYtQ9PnoArvJEWhg==
X-Received: by 2002:a05:600c:1d8c:b0:494:1f7:8057 with SMTP id 5b1f17b1804b1-49401f780a8mr115132825e9.1.1784122257063;
        Wed, 15 Jul 2026 06:30:57 -0700 (PDT)
X-Received: by 2002:a05:600c:1d8c:b0:494:1f7:8057 with SMTP id 5b1f17b1804b1-49401f780a8mr115132405e9.1.1784122256659;
        Wed, 15 Jul 2026 06:30:56 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953df0fc6esm44194195e9.9.2026.07.15.06.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 06:30:56 -0700 (PDT)
Message-ID: <c49fbf3d-c1de-4eb3-a6b4-22c7bc84d655@redhat.com>
Date: Wed, 15 Jul 2026 15:30:54 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: Fix compilation with
 RELEASE=1
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
References: <cover.1784112948.git.vmalik@redhat.com>
 <CAP01T74To6X_XPeM5L9wN52QuL8oSuoDA3jk3jhR_Y1bLXH2Lw@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAP01T74To6X_XPeM5L9wN52QuL8oSuoDA3jk3jhR_Y1bLXH2Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/26 14:10, Kumar Kartikeya Dwivedi wrote:
> On Wed, 15 Jul 2026 at 13:22, Viktor Malik <vmalik@redhat.com> wrote:
>>
>> When compiling BPF selftests with RELEASE=1 (which most notably adds
>> -O2), GCC reports several warnings. These are by default treated as
>> errors and abort the compilation.
>>
>> This series fixes all of the issues such that selftests can be compiled
>> with RELEASE=1.
>>
> 
> Are these changes sufficient to fix all issues? I see more when I
> compile with GCC 15 and RELEASE=1.

Strange, I tried compiling with both GCC 15 and 16 and these four
patches got rid of all the issues. Can you send the specific issues that
you see?

> Also, is there no way to make ASSERT_OK_PTR work when we're testing
> for non-NULL-ness? Having to change it to explicit != NULL is kinda
> sad.

ASSERT_OK_PTR uses libbpf_get_error(), which returns -errno when the
passed pointer is NULL. This is correct for checking pointers returned
from libbpf because libbpf always sets errno when it returns NULL as an
erroneous value of a pointer. However, that is not the case for other
library functions, such as malloc(), so calling libbpf_get_error() on
their result may actually return 0, if the function returned NULL and
never set errno. 

So, I'd say that in the current state, results of non-libbpf
ptr-returning functions should be checked with ASSERT_NEQ.
Alternatively, we can update ASSERT_OK_PTR to explicitly fail with a
default error code when NULL is passed, for example:

diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 2cf950afcd85..bf94b0947790 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -390,7 +390,7 @@ void hexdump(const char *prefix, const void *buf, size_t len);
 #define ASSERT_OK_PTR(ptr, name) ({                                    \
        static int duration = 0;                                        \
        const void *___res = (ptr);                                     \
-       int ___err = libbpf_get_error(___res);                          \
+       int ___err = ___res ? libbpf_get_error(___res) : -EINVAL;       \
        bool ___ok = ___err == 0;                                       \
        CHECK(!___ok, (name), "unexpected error: %d\n", ___err);        \
        ___ok;                                                          \

However, that would make us lose the error codes passed via errno from
libbpf.

Viktor

