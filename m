Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365715;
	b=5OSsRxM1skDgDarjrDqLWetItD5SIF2f+4a+c9NvioLdANlJec+7iE+8PMblhCEDSHcl
	 9wUk7VhqmdcClip5blfXLmbPoIuGhzGQg+4sKJMyQRZq2gp9bpiAVWntIvBV1ThlJcp7E
	 JGfbibbaWSS2XIydPpK88KMzBACkGzpholmpoaDEeJGLNuVU9E9qr8u9R9pHRvRgSX5/8
	 +Mv4fA4ymw5keSnkodCVsAVXjuW/jQlczk9CivCBn7Wa4/J33eaV9rMZGnHizmmvJeggX
	 BQ3c1geCHw6/ur7xWisIzQamyzxXjF/OCjFUM/+4mSdt/nXTlUheQsGb4FSkK10zgsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nZOCDzk4C5KN1JtOyDvdr0FxSEI/UMG9a/p3BL1dBmI=;
	b=1I3H2Qf/oMGawWZoPeexVkHr2cdY8cBHEK96tkZ/Xq8t91pYp0bl3C3BEJc9eIqxzWpg
	 AvkGCRoO5WQ9zAQizcs2YZ37BG+qE75B/Vc343vhtcm3WvR7HjI5IXpCtkZ+Dh1IDRXV8
	 PD1NL10giingTP6LlksfJn4H0zP6VBOGctgwsvJ0H1Yy5i/ZGqB+nJBAb154pnSMsogE7
	 lL07h6DOddQGil7TTY9aY09bhnsqyLB9ge2VR++YP7bWi548qV9cCiJzPQTsrfQTVCCvK
	 enBjFg71SpbOysizozvUFSIuX/jLkt3qtFZ6KRfkp2LwGvy5ZmuER34jk5Tz2AZ5Ugw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hdaNc+FZ;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFD5606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 13:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BFD5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hdaNc+FZ
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48b042c0728so180888f8f.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 06:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793365714; x=1793970514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nZOCDzk4C5KN1JtOyDvdr0FxSEI/UMG9a/p3BL1dBmI=;
        b=hdaNc+FZc3Z2lu0KMkp6btt/TAaeH11y8ZuyFPFG1ygG/tPTA8dNBNCz5+fuutc2xb
         si0SZ8WiRAvkIjlNDmsMXS0PsCGuULhLDd5jI+9fuYNzmzc5AUpmjNUAhW1X7CaV9tTw
         J/czn/cA6mrneJzxKsqutzbkrwPDYYagbYNIO8cMkShf19S/kT7uZ0nMY9B66O9XCkNp
         /sJEOfP0rnhZXiJjwVqTTs0D7ZgZ9HyX46NjctOuJQZ7Jv8XOBLKfQp4whBjiGNmlDeb
         3AbzrElB5gbKrAySbHvVkjjuGV4rjhByDN4UoXVs1aSCSwJO/lBlPsrJdufoN75ZbXFp
         /jMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793365714; x=1793970514;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nZOCDzk4C5KN1JtOyDvdr0FxSEI/UMG9a/p3BL1dBmI=;
        b=Ltx3bj/srdRUMBoHOFvZtzaUfkraWm8H7vPg1U+Em/3PhvgezXyo7CmtQzcd/DsQCz
         DeDM7aIZ8OsYt30aE9zMkDZiuh7bIg9L8BYVPZh6HrinfzZcLD/TZBLtF/us0TmvEZOK
         9UYsNC/c3JAoMMbAVTYoSQv9et9RFG7f/tWaFQ3byIk/BGdlgUoIx7QbNkkwwpHLpNvF
         saIVPnqRzkojCAfFXNRBRv+DCE/lUhGUzMT6ZCL/gSpUPuN3huiOOeVDL13J5KcQlv6i
         YRB/FwWjnfFaDe8jZRI35cXQpMMnBCR1nm/Qpm7f81C/1EtWJSezNjeJRBoXvnstoGNv
         Y1FQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFvDW0HGx1HTEQao9jYwV7I35FBarZPQqxqykateqtEZce2ku7vdSVl8wSTNk5vuOus1o=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+ooKUZlwwTuls0CEiKiWoOR9YI0myGISUYBm/Xw9zwohWsUX6
	AIa74+AdJR398XroWLbvvu9heKf6m17SUF2H55mG6OV18sd0Z9MZWzeS
X-Gm-Gg: AYBFou3p4l+Mj7PwJeoYWqDqBRkkwK6hL6we8GK2pGbCwfuB3ejWjtJ3wygtP//6p1y
	YCMzTlzYqgVUdfms3vjZ/xbnY06P0aBJY+WX98fz0J2GrkCSc8X/RsM1nX1RN9EqWjvbdyVKmEz
	lBXCM3+aRwBVyBQ2gRhzpmf29H6OHdZjQo4OZabkYLYi1V+QJ4xaNjhoMhjQDcpZKc6u6GEuLBv
	YZD35mnTSWbXlrAmfe5iu6PNAo74si2fLSAYGMEbY7n1xFpFi8NlRqlrPEZdif01804U5kvLZAn
	cvARHY2Esq7A3v6UOydWvHfBSTI+KWePJ0PQ8jHAHB0ZhTylrICVfMSg6s1TIdVp5Eo6OCqdZ/b
	ZW0uVPJP8SFJyOglDkryRnHfF//AT6+ZS7DezGfwaRxRu/ySllSqEbd+zanFOfc9+i+hbbdVQdT
	sli+mIYmZynsfQt9Xyook6pncAbKImlSJ51K4HQaxeDiatPlULPG4unzox9c4EpoU6LERN6Yq7r
	+3agZ3ZMP/CNTR/vBKGyiRaTTSQnH+Qb07O5vevUf7CnQMn49m8QbvKtwBKFAK/TmGn7tPI5egt
	Fg==
X-Received: by 2002:a05:6000:2204:b0:48d:ffe8:ace6 with SMTP id ffacd0b85a97d-48e6e3004fcmr5231472f8f.42.1793365713640;
        Fri, 30 Oct 2026 06:08:33 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71baa1b3sm3053979f8f.56.2026.10.30.06.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:08:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 30 Oct 2026 14:08:30 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
	linux-mm@kvack.org, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, ljs@kernel.org, john.fastabend@gmail.com,
	nierro92@gmail.com, martin.lau@kernel.org, yonghong.song@linux.dev,
	mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 8/8] selftests/bpf: Test user memory kfunc errors
Message-ID: <auSWzm7W1SiQN0Ul@krava>
References: <20261029212551.56964-9-jolsa@kernel.org>
 <d023b011d67ae13695a93c94ae0197e96fb5d42bbc3a4a63b42fcd0c1852a605@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d023b011d67ae13695a93c94ae0197e96fb5d42bbc3a4a63b42fcd0c1852a605@mail.kernel.org>

On Thu, Oct 29, 2026 at 09:59:33PM +0000, bot+bpf-ci@kernel.org wrote:
> > selftests/bpf: Test user memory kfunc errors
> 
> TL;DR: Commit message only: it claims tests for partial copy faults and
> read-only mappings that were added by the previous patch, and omits the new
> RUN_TESTS(user_mem) verifier-failure tests.
> 
> > selftests/bpf: Test user memory kfunc errors
> >
> > Test invalid copy arguments, zero-length mapping operations, partial copy
> > faults, and copying to read-only mappings. Verify that a failed unmap
> > leaves the mapping intact, and that non-sleepable programs and programs
> > without CAP_SYS_ADMIN cannot call bpf_user_mmap.
> >
> > Assisted-by: Codex:GPT-6
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> The changelog says this commit tests "partial copy faults, and copying to
> read-only mappings".  Is that accurate for this patch?
> 
> test_partial_copy_fault() and test_copy_to_readonly_mapping() were added by
> the previous commit 8f0bac0f80cd ("selftests/bpf: Test bpf_copy_to_user
> kfunc"), whose changelog already describes them, and this diff does not touch
> them.
> 
> What this diff adds is test_zero_length_mapping(), test_failed_unmap(),
> test_invalid_copy(), the three verifier-failure programs
> (user_mem_nonsleepable, user_mem_kprobe and user_mem_no_sysadmin), and the
> RUN_TESTS(user_mem) call that runs them.
> 
> The changelog also does not mention RUN_TESTS(user_mem), which turns the
> existing user_mem_test program into a privileged load-only subtest.
> 
> Could the changelog be reworded to describe what this patch adds?

yep, will fix

jirka
