Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FE63AEF5F
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674085; cv=none; b=q7xf1AN14cVbci1BU67Iw01viN9mrlSSVPPVzvYIgojy8sooj+PV9i3WZbOdEfUUD4Gg8d5gx1gwfy/qSjD2tFP9Ebn1CrDP+mGKVjkvPqtVwSAXVT/YePlyUtkz57NJhFbTXcuqcGkRppujCIiOifWJBgmqQs3yLPGdm8XSHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674085; c=relaxed/simple;
	bh=gOaQf4EGrfhdLSblSYsJNJz6b7mr125ZrbWEbOUEmjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqawdDmsainmepUY1yakYCBCWDJNB1rXP8OjflMiSp0lZ7TrXDdyMLaLWNWTTi+USfbk4otJOtdQDyywwz0u2m+xNQR6GycZZ3SATU+6pXhLbdi8psAudV3q0k5dSqT2WcOhpNAVY952NBfZzpHShF2PC6FFDy6AxyxON6wLa2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRZEdCP3; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRZEdCP3"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82a67ce6969so73006b3a.1
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 11:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775674083; x=1776278883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A01CdZuB33Wj5+SKXeS+zYt/ped83rGhK3336weaV3I=;
        b=SRZEdCP34hP9QtPtN8vVV8i5Ucq7NA89BmTP95WqMn54y3cxreHz6cSpewKGTmzyKp
         t6OAO2hHs7vldCllhrQtVBp/feK7QzW7z7posdML5rwCkJ8Ph8ryc0HLyAwNFp+BPwUz
         oQkrTFdbawLonU8r+7alzCQqQ9bZ1HuFnR0PzMm/dD05UZ9/AeF2yJem9SptmCub0Nxj
         5owzRFNKalglVahBkKbI3HfGXa6Rv7riB32wkr5Mt3ICpQvDXaCsoNV6NA+TQOA+2+ql
         ylgiB9+B2iPUIR2Wy6iOJreXB5Md8zSfQk6tpMvdndsicpT4av8yPerndILtYXB/OGpR
         wO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775674083; x=1776278883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A01CdZuB33Wj5+SKXeS+zYt/ped83rGhK3336weaV3I=;
        b=geiO/TEVd0T0Vf6qDeA3HCw7rtitd/jn9pOHlahCAaX00yiZn0h3yoAOkPzlFKiICu
         Ro9yjhPzUhvCEXakSkaDAx12xYFqchRBCI4XId07lL4Dtcl3/X1WOq2GR45tYfNdiJsC
         19NpMuPGv8CbkrZGoP2G83Rrc0pXw0QaQ9b3JcONilKb4kAFRARqjm1pLCue4RL4NWac
         DW0swtslZpq6cdktuxqB9tzmrP98yaBU8qr2hsh6F2mvUHpu/qxEuJWCpyT1LMFWJgog
         J5it0D7jizvRDCpZDRxqZKj8zu8GlLbM22sh0qMaoafKDSXHslbyqTnLCeVpkotvn5UJ
         AU3w==
X-Gm-Message-State: AOJu0YzgNb2BEAwp3ytcjYWnaUW8FRjVzSeGE0zzZiHhOOHBN+pXTuP0
	9ZsCqgnZv6adi0SnWjq+7cP7WPETlclrHt06pLFJHJjnTs7iiE4Dgg+vyQC9YTVSPE8=
X-Gm-Gg: AeBDieu0bcmVxb2o8okTXYcnLB2L0qCZKCtV7//riaesLaJF0bfKraU66gVBCOAvKds
	Wi2iewkOCzn5eTeRhPQNkHNskWjdJ43NqwzjH2Vvy9iAFjgl5zu7c2kbW/ZrOHe4Y6VsLgNjD6m
	wsTYrYVqfSCJcrRid8dpRh96v3otSN3EzK1Gd8KYdH/atm/2UTUL7+jx4mmFSnePbKeyaVbLK1t
	oqgBRrS53jvtrVlWqITc2PYDRUwb3lfmLocrGuL575vWzFOew2hPUbm318XXLbOgEvx+wNfnzVo
	7AUBEW4sdW01ug5eqIbPz5T9O8HklTQDc4K8tcGpqJmAlrywjHl17w57Pbp5LpdAn/o6bHZV9Qx
	641zTeWPfFL/9kR9Y/o+pE0II2jEK+QyXpfPybWTgwHdsr2docw/XAibtMqRn4d6q3qA32Wtzpr
	YWU9khb8WigEfSk95QO5gvOGHqZWZsNVk9aiY6XRe3y1deLXrM99aI
X-Received: by 2002:a05:6a00:3306:b0:82c:2555:b9b2 with SMTP id d2e1a72fcca58-82d0da4fe1amr20587352b3a.10.1775674083319;
        Wed, 08 Apr 2026 11:48:03 -0700 (PDT)
Received: from computer ([2a09:bac5:40b2:1a96::2a6:4e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b5fb22sm27435747b3a.26.2026.04.08.11.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:48:03 -0700 (PDT)
Date: Thu, 9 Apr 2026 00:17:54 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: bpf@vger.kernel.org, leon.hwang@linux.dev, memxor@gmail.com,
	jolsa@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, yonghong.song@linux.dev,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add test to ensure
 kprobe_multi is not sleepable
Message-ID: <adai2mXaRGpf1Kvb@computer>
References: <20260408183549.92990-1-varunrmallya@gmail.com>
 <20260408183549.92990-3-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408183549.92990-3-varunrmallya@gmail.com>

On Thu, Apr 09, 2026 at 12:05:49AM +0530, Varun R Mallya wrote:
> @@ -676,5 +750,7 @@ void test_kprobe_multi_test(void)
>  		test_unique_match();
>  	if (test__start_subtest("attach_write_ctx"))
>  		test_attach_write_ctx();
> +	if (test__start_subtest("attach_multi_sleepable"))
> +		test_attach_multi_sleepable();
>  	RUN_TESTS(kprobe_multi_verifier);
Please ignore this patch. I will send a v5 in a few minutes. I forgot to
remove the selftest from the previous location after moving it into
attach_api_fails.
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.53.0
> 
