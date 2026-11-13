Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587877;
	b=RqV8sj98pQkqo4VTdl8c3CABpoW700zWwWgmASe0AKvaq+QkPKq4uO7GvuH2yWOZiDP1
	 8+7SgDecQdS57q9yhpCxAADet7WcSpWcRmBNvRj6R2ES1gWKgL/QG0jWnZ908KSPIEtg8
	 m5EW576J8J/i1pstyM40qfzKjM0g4rKU2eKTnGo0wE+xFcDcpXCCGjLspTdKoiCPsbsJG
	 /TA8ZhJRhXfcvoIGyxYzxvZE7Svpc9C8HylDf7ryUQBDWPrl04yu2T7daWPY5UFAhk7By
	 tvGwGwHoy3Nq1YcR1V/f2IhqXo1Ll8IU5vA2Bs9BwU76Uw+gtc48xFgM0Ig/GLqNp/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Subject:From:To:Cc:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ISpPSUAAVB57yvObS45XtouNXxZkwivjH+50rzW699Q=;
	b=CY8UUSXjbY96zZkwdli7EyoqW+iXNtnvkTPujQfgmWx9CXVaIxEQ4JqkJdHWWxaKBGdT
	 atcTyxVfi6ACJMwZMKPWJ/f0TjO79niUphpKVqTkWSyw/K9sf1oZrxo+SN6pSEN3Xayng
	 3cxDMvCNQwGa6osoDg2WAbvARd/Q5d+cHOKA0GNZrZiewOhBoBIDXemyZyrb6fEO4GZYP
	 TBAdd5/QN/wsswWV7+H8nWo1dE9KmhJ8ZcwQEAW39MM3OQgh9EU2NfLcXStsosopIzobl
	 b6Sa3G9PyxYLeeSHMqFfrRlAn2VnUAKkt6oIuKO5p6HnJR0M8AUa/T8TzZQ1TXhctiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eNRriuJI;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7161606A323
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 16:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7161606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eNRriuJI
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e95bd1c14cso23302955ad.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 08:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794587876; x=1795192676; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ISpPSUAAVB57yvObS45XtouNXxZkwivjH+50rzW699Q=;
        b=eNRriuJIS4J2DzhFxMutVX1m41oRnR+k2y3NTpO4vgR9jzEP+pOec3z8dAMDa834C9
         3zldngQQm7CNcuDp27xy9RsCUdq7I9oWNnFb+bdYalDvkCK1DjVyXOIeTRRUcq4anXCn
         Al/WW8sKyx2tFn2lDSHAMa//Ewf6E8oK/b0hHhF6YpyN9IRPPY3IDnh2s4R3oIS8GKR7
         igvGnr1LEDqhKEdVV5GMHWiA6gaMK1fcw5QcIxV5OQ6egvtc5Z8piizcy7C9PjCA4Uqv
         7h2u6hJB7tOMaad26tFapVSaB1XqZIds/hm30bvLZF9SHV8uFA9fHQpdeK9NTLZV12sy
         hvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587876; x=1795192676;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ISpPSUAAVB57yvObS45XtouNXxZkwivjH+50rzW699Q=;
        b=dV7c7P7d4e1x2HTgpwfMhsEGlSivyN+DqToGcaMBjkD9+iGHz5vG2jUUxeLDIm6FdA
         Ad4DBbGoXmMT4VWDXCUmChhlR5zmvLL+zzilWOhYAAd3FToEDM2jeS7vKaw1wesoKGVt
         mxEdbkdtllLq5juxnC+OsVVIWNBi9Xe/9JLHPJt5flYJai6yF9ADE37SiYQWpdHFwHgJ
         432BB7kyq+90dIYeKvSt4qLMsYNh6PyqfbWL1eqtKEbg6aK4RxXZIf4r1f7cZojx4bLJ
         8T1XemRl9cy1evTU0cUJJ3iSN0T7VjaS2VdrX4M7uwBvR6mHqc7dcqhh3O2QRWe1iyOB
         Zupw==
X-Gm-Message-State: APuU4Z/Wvai+fjp4orvJUFZ9tNeH42lXrYaopqLVAHuaRn9jT7ZZZfzy
	3As5YdJ2KT4XDf8P65jMwco9eIP/jNRvHBHzk7NRttE71M923eg1Tpbp736gAg==
X-Gm-Gg: AYBFou36fZP6STbO5gNKqXRQMoTfnJTARbbQZGiUEQZf7H/0/rxvnxAz7LvGSNIAGk3
	zBA990z+vVAWz/sz6eBAWGxJAtGsqJVkzK6jH1U9iejQEdcMCxrlS7m/CcRUjbRoJYWL9M9pp0V
	Gzg3wZ5a5sdpYvW5/C1mLJ5CCRBG8T/eVXHrTFa2XiiM7eRTRBXnJmFvEHrgioh19GXcJO4AAUB
	NOJVcPchN/nVcqNufz/GLSM6ZQPhFcF++mW+vGB5UQURWqobL4yq4i++Oh85TDxOoq+UfF/dG5g
	19e8LEKkFg3DILXAurU8iuIPE9TiFlg0M2SHs+5tqfP4fgO6NW7mm9vghT4DhjhBKEu6SZpuP28
	3aF3wiEJV+xR7jUCnn3i1RYWAXP3zFNQN5DVaQZ9bF+WOV3wWt0pTL7NLIXU9zUwEV40GQngKco
	xxsFN2mNx2jIEk7HbeVT3Ml2BQilabU9uq27dAa8WdCJ0dSBbn88etUGBbBU6Xyu2wDvowZf9zj
	VDxlmN0gWQi19Y/W2YQ68acN+cRSxC1rS9vUwpg/+eXMXo4kJTpCsSUDMVbB+gWRzmV9x5UmT9T
	knKqPixHZq2QGb6pPOChsHar0i7toi2Xdi6/vTaALHyNOvYIg2i9LVdFpGHsAXMDtXSWBNlYz8Z
	IZE+EojCX4wNpo5tnjJwPIWaDxjT6hYQDvQ==
X-Received: by 2002:a17:903:1b2e:b0:2e9:cb4:b345 with SMTP id d9443c01a7336-2ee0ded3336mr34047905ad.55.1794587875819;
        Fri, 13 Nov 2026 08:37:55 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f809867sm13611755ad.41.2026.11.13.08.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 08:37:55 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 16:37:54 +0000
Message-Id: <DMU8B4CMIGA2.1SOSYSZO7ZY6A@gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/13] bpf: fmod_ret for each function that
 returns errors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Anton Protopopov" <a.s.protopopov@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>
In-Reply-To: <avcJ4OWW99bwMlCP@mail.gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com> <avcJ4OWW99bwMlCP@mail.gmail.com>
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

On Fri, Nov 13, 2026 at 05:00 AM Anton Protopopov <a.s.protopopov@gmail.com> wrote:
> We can have a bit more targets via functions returning ERR_PTR(-errno), plus
> maybe stuff like "if (err == -EINVAL) goto out", but maybe it was simpler
> at IR (see 'bpf: Follow PHIs in bpf_scan_ir' in v3). All this is follow-ups.

Thanks a ton for initial idea and quick reviews.
ERR_PTR() shouldn't be difficult.
"mov $-22,%rax" is a constant in the return value
register, so the data flow finds it as is. int_return_size() skips such
functions today. Just relaxing that part will solve it in decompiler,
but then the verifier need to get smarter in check_fmodret_retval().

> One nit I've just remebered: why to tag functions which aren't attachable?
> My old code stripped them out, they only take space and will be rejected
> in any case.

Makes sense. Will drop them in the next version.
It's 537 of the 12633 tags. 

> I've also tested v2 on my x86.

Thanks for testing!
