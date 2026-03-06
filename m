Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827738E13A
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799089; cv=none; b=QBtPfUMug49+NstIIxRV7WZ1b1JGYjHoxEpjN+eWrlp3GYHE2CDq+VwK60fE2E+inqA0s/yzdE1lz58qUgVG8YmH6EHwvZogaMRFdtmjOEMZyO+5KO7oBClf628ApHjilAxcJISwioJEWsm5N9khQ63evr3bGgydcbb4Q8sdKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799089; c=relaxed/simple;
	bh=7H2AvTqAd7H8QnR4PrOuXAEIsyLIGRg9AQOZdQt4mOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnqeZocRURHRlbR9ubGN6VytfGkxgxs8a3PbuHyMQibpRxWEd7sOuZ/Knc9GuHcEIGjHvJam9+oFG1bFZAyDS7gM0Czo8eIfLPYsYcOMuY8IYV2RI6eFP/b43HdPbFqDnyGtPLt10DZ6PCCSAfYeobZbcrSXRjrLol8fKeHPkxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRicpND1; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRicpND1"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c73967cf77aso569396a12.3
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 04:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772799087; x=1773403887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1+VYCqFSNiByaSaiXPiM6cBehayAyLVjnULInN33Ug=;
        b=XRicpND1kEvLeLzvCQh/AfDxQ7JA0Vy5qGGO8bXde5e0rpU/1Dcn9f3xbvWH8D/gP0
         usbXqEga+/Yzd7rDzZZ31W9BZI29glWH8Stx2QAP2H714Zzni9P2SR2UX5/FNcXUJDOW
         44BYbNTJ+D8vWYLNRiDu5v9/p638VSTPAI730raShx7EO9N4DMNX1IWCf+Tk6Q9C8qbM
         nmpzXhw/Wr3rR1p6ad//oDwCkmASxnAxLxTn8zjjiBOn2Ue7fqCAGQ6k77ekSKDE/edA
         H64e4DeBLhm3u7DEnmU5ZfzbNaySKDx4RzJqIgt2xg4avX7UkWW2LCHutgj5WfMHMZuG
         zSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772799087; x=1773403887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1+VYCqFSNiByaSaiXPiM6cBehayAyLVjnULInN33Ug=;
        b=BGG9flLNqJe0tblQVl/Xek2fgVIUJ4D2gAu8Xl4nk9jBY4FWlPtX3l2Y7rmYiIE4rs
         MwPQwJDQHGqmLRivT3b2pRLAjVndZOZEiur2FL5ghijsxar5qasr3D5AqjJQ5tqzb70C
         aQfdufItfx//nJWCgwizQXEyB0ljEYFdOFM5gdPJWq6CJSYp2igG4WqQrY4Bb/dS9oPf
         xOr0LNDnlwkacGDPmbWYlpXam+9Vat7PQWAKNmbkOOjWJtspMn2UB1zZZ551niMnY7x7
         2y52ASfwe26jCqF2IEtH7V9TS+fw3YcHvGVio75G7B0bpjRA4TI7zJHMqBD/0BKWw8AN
         LVWA==
X-Forwarded-Encrypted: i=1; AJvYcCVdwFF2twQFuJZLgrjkjud05F4RBa/noinXCbleVV5Gas6MuoUlk+tRDPl9uYTpi+rBMEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdInysmD6y61qg3Iw5oeWk17UtHl1lMxSYpeFs3xb0DBFGtuPq
	N2ByMnAE41VercQ//eLeCye/qL2oT6ZaY6QxaXAPqvtkI+WjjHP7IekX
X-Gm-Gg: ATEYQzxoocfQ5Uo+yOiZpINRALk2TVYv0fodNx7r7gQzBwmf0AbWuEv6JDndNc2aoAj
	eKCM76ajkStq04Kwp8e6zl/X5qVerXKDGT2e+7mHAR0S8CcdieARRB4HeKhrRx4yRWHqJyM0QDU
	N3e5uof9lh+Jzbjv+op4ZC7VsUGAapqJly3j2uzbuR0vy4r/uNHkFlOaVoBejGZxilQM5ly9ozK
	eBH3f8lstprsMuOuijNIeT64qkkqfA4/CGKT98wsWPVoNozSEzIblKopFaECsJapa8GEZHDx+vP
	YMda+2nUhHP/qP2S1GJDCF1vOC0nKW9njePMSA0932L1SFP34fTdvvjPGefRPWV8BZjthNiV2z0
	N8ec0SaoA637cEm6QmiH9LPZsM7Jowd47LfWSxFsUKEQkbdgqnAeA6W4uBaw7u+D0XKwx6mK7ew
	M6dRFnELfM6t9emjuDFU4xD1b1KP53tcKFMi6Al+whfRanMIGMw4tz3dP8AHPw9qiIGzuX
X-Received: by 2002:a17:902:f789:b0:2ae:4996:430b with SMTP id d9443c01a7336-2ae824e9d94mr20798785ad.26.1772799086911;
        Fri, 06 Mar 2026 04:11:26 -0800 (PST)
Received: from computer ([2405:201:d015:d26b:3cf6:c501:92b2:25a5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e7c58asm19807735ad.25.2026.03.06.04.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:11:26 -0800 (PST)
Date: Fri, 6 Mar 2026 17:41:12 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: andrii@kernel.org, eddyz87@gmail.com, toke@redhat.com
Cc: ast@kernel.org, daniel@iogearbox.net, song@kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix const qualifier warning in
 fexit_bpf2bpf.c
Message-ID: <aarEYMXNzVhvNNMs@computer>
References: <20260305222132.470700-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305222132.470700-1-varunrmallya@gmail.com>

Looks like the CI failed on this:
> CI has tested the following submission:
> Status:     FAILURE
> Name:       [bpf-next] selftests/bpf: Fix const qualifier warning in fexit_bpf2bpf.c
> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=1062212&state=*
> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/22741682920
> 
> Failed jobs:
> test_progs_parallel-x86_64-gcc-15: https://github.com/kernel-patches/bpf/actions/runs/22741682920/job/65957069283
> 
>

The CI Failure seems to be unrelated, though:

```
With the provided path, there will be 109 files uploaded

Artifact name is valid!
Root directory input is valid!
Error: The path for one of the files in artifact is not valid:
/packets-135-10-net_timestamping__INET4:_bpf_timestamping-net_timestamping_ns.log.
Contains the following character:  Colon :

Invalid characters include:  Double quote ", Colon :, Less than <, Greater than >,
Vertical bar |, Asterisk *, Question mark ?, Carriage return \r, Line feed \n

The following characters are not allowed in files that are uploaded due to
limitations with certain file systems such as NTFS. To maintain file system
agnostic behavior, these characters are intentionally not allowed to prevent
potential problems with downloads on different file systems.
```
The selftests did pass.

