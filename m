Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322432AEF5
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 00:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783644968; cv=none; b=ORjLZ375I7DblzIijLN7PUBKemfA/Zb62enIxiAH3yWvOZNxV+JZxwGMSKQ1GHKBTSk/LqaSuornorbHoML4uAlUGwGHC1dCSte6aluw0AWd594QvtRE5trawh8prKrTHZmUrlM51si3YbtRs2m4TEFhA9t+0Toq3rPjguWXSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783644968; c=relaxed/simple;
	bh=nk/qZwdIyKZ/8mtBYqhqeS8BfHk7dkZYUktmQWXpI9s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PGfG1DUCP1IlieKchjC+p2ub0j04uBeaFwx0lO7acsfwzBkOJT9J0wRH9D9MuxVOQ5xBRLTDA/rtONy9uPgmPUi4KuOBwwAmnUMMXNzgLwic2vD55vZqild9C5jkAJQwu+mPDC4T9lo5Xc5G+Wln5ACFBoIAX+EOIe0VyV1hSas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o8bu5O/A; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8bu5O/A"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84783bce476so410909b3a.0
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 17:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783644966; x=1784249766; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CrI/ZvFDGZ5YFB2OeBLfurG+8zA4o8C/QO9dVyD00XU=;
        b=o8bu5O/A/PFkqfL9o0a9+TTc0jk4IbethaNE+8VkP8IaRqIJ6LIA70sarrdsA5xwwz
         5pRYJcLfOfn2DOYKA073CePSpHaVn2ytt3kE60NqXTbqjVheGtyRuYrnVnMB1yhMLRKs
         1yjuwt0/lYMVFIX9KmLWTdbltsPy+iMATaAamunScFCvNZ/35XZVI7hjTUzk5EVLeWgN
         badv37EkGLXX7wHY+NRSe3mVGNGCQjSB+s7hfyv05lISPydKN/4gXm/SzZ3hDItfvmum
         5KqaIOUAz1ihVP4BrzF1tU99D1CBzK33XWmDP2THENsG9i/460zsTClr/9tu08/PzpNf
         oaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783644966; x=1784249766;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CrI/ZvFDGZ5YFB2OeBLfurG+8zA4o8C/QO9dVyD00XU=;
        b=s14xnhPkpzG86+ojyXZHjirDVSosNhNvvDdtM0D2nFeXn7+xTe9bkgdWpIXRaThQd5
         Vf2uqhFZQK23mhV2De31rd5tpsPaOAaduthnboEB3lNIXQ+wrdXJIpLNajdehJYwPBcg
         6z6aGzOhnacrrIeAqAjtDDtnka1+KdSRgg4kqvB7/XWTAasP9ugYCtli5yEJrgCU7ah7
         pe4RM0k+JPxOfkD5qFigtDifP7sowExvA51KbUwpaBONXzZ2HjjEz/LQfsJVEFsKDN8l
         AwxqJcquWJU5kjrleW1EGGht5FAI5wyIdPJ/JyGMYLOPTC9ULwu7/tCoTyvYWEp3n6RN
         H/6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp3NZiuwPF+vUGZjmX0j+PSVY6l3+tV/cMCnmJpuswEC6NGJa22F2EKd8R5jFQe6EkrSGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCWZfcpokNGtfv4S3OTIjsCy+eYDRCx+TgQ0B5DUvHj5YR4Od
	XGQtWhJLrA1lcBqKu/sz0v7aM+LD0XPdW4vxGf4UkSgFPEjvJs57h1Co
X-Gm-Gg: AfdE7cltieExB8biLHMiZgZQKAKuEpum/G+T7NBFi7vKfbhZGy0bFwgZqTijsaTj8f6
	T7cv40ypDxIlwDZD6nH70q+b+Srb0I3gQYMn8gUxZxEk4umkkmKnTD3mHzzznacExtX8xIHwW/f
	cAHCffpSC/2pHCiFCZuVjRxdM+13cIv+IFc5SWjtT+D/k6Dgxk8RLBpAADQhL4puLKkwTYsOPJ1
	jxvDjhvRQQtBMEEfSu89c1esCL/YZuWALYsmffQLG6H+ly3HErcuFEy+iaJL+jzkkKyGjA/+1Mi
	62uTf8MYbTrNEZbR2YQwfgrz2oCSsEKhDFZYzVhdcptvxFRCdLXvNMfJf7wg88mPhneOfmrG7hn
	r+KggqhDg+rkTc9chpBx3JeSGJrnLSwxjpMcRjuMNLGNELiir+aCjmrAhekEACewdqhc1Eg6tbD
	rbN8H0JdHWcuLGei7tfvNQNZyv7ApMu2SzqNZFUhVN
X-Received: by 2002:a05:6a00:8f0b:b0:845:d286:1fa2 with SMTP id d2e1a72fcca58-84842feca46mr8373753b3a.49.1783644966425;
        Thu, 09 Jul 2026 17:56:06 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8482b333d4fsm5268402b3a.54.2026.07.09.17.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 17:56:06 -0700 (PDT)
Message-ID: <b364ef0ad5425d97180220af23be238a4c4281d7.camel@gmail.com>
Subject: Re: [PATCH bpf-next 00/12] bpf: Support 16-byte return values in
 the R0:R2 register pair
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Thu, 09 Jul 2026 17:56:03 -0700
In-Reply-To: <20260708200939.2153664-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> On Wed, 2026-07-08 at 13:09 -0700, Yonghong Song wrote:

A design question regarding to how this series handles local
functions:
- It relies on the BTF gate to decide if function returns multiple values.
- It also prohibits local functions from returning pointers as a part
  of an aggregate return.

I think this unnecessarily adds an additional discrepancy between how
the return values are handled. The practical experience shows that
existing differences between local and global functions are already a
constant source of pain and confusion.

I'd also argue that lifting the above limitations for local functions
would make the implementation somewhat simpler.

Therefore, I suggest to:
- forgo the BTF check for local functions;
- always copy r2 from callee to caller at EXIT
- forgo the scalar struct requirement for local function
  return types.

Wdyt?
