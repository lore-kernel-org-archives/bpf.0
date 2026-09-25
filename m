Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A35A3EB110
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370082; cv=none; b=aEx/2vxDSI5BIPurVaCaDIsMvDNgFHdDdrCpI1YfOAevh/q82NiVdSk1oz1ibYVgpxIN72frkkk7jn5ZrAkcQV7YCwhMnbPla0b+j8OX+sgCr32O7QcrM15Tm4CMBAdNVO0+H10RIcCBW0I+g3dM+U9hL2kTNWRB0rvqGZFC3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370082; c=relaxed/simple;
	bh=Aa1eo8XGdTefn/BZATyCzOjjt0cSCTgpy+m7Hrfkl74=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=LWJIJ46sUPpkdJQNvGtejx/19dt1H9rGHYmriSoP1tzx2l3yPQRH2dLx2tQW9n6MbT+y3QBsrUhJVA4LeGsvtG5blEK3KVvDJbEwj1Z64D43QKWRw4rmahJ4Ivtfd/+PlYuogorlZc2SBCoO6fbhlLCWHker6Qw3KlQ7Bidoieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KweESVsc; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KweESVsc"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc7979d1deaso244545a12.1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370081; x=1790974881; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Aa1eo8XGdTefn/BZATyCzOjjt0cSCTgpy+m7Hrfkl74=;
        b=KweESVsck8OtkEn/yUzOruwH9tuR2fGt1aUkoP4TlQ0aizugw3npNfwPz+IE4Y4lmZ
         0omkMFjbZrioRYy1mYtsxuB+xPJg5OiS7DA42IYm6Sh/klZAW812YAgYBZuxGMC9Ecuj
         Q7BTf0MSqV7YEk4pQdwAIWWio+0YT0KNrfErv8yl1gJWDJEDJFk4tg5HMPKzR3ucXaL8
         7rdIyjHUxFAz58zkq6Fvs2neMF6sYgoaTDq3mIP+cclwevfZFUp8NRaGuVIruagfeikm
         bu0naUxwwDbzCxKWIZSmjBxeHOkK9YBqm9Ila2Mf2Mcy+Q3jvqOi9m8NOggg1+Jl2KZ9
         xj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370081; x=1790974881;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aa1eo8XGdTefn/BZATyCzOjjt0cSCTgpy+m7Hrfkl74=;
        b=yJfDkDMZngzRKOMUSIEhN2sSQ1y6rG6V+OIOhnbIUA8aykL85ZiV0m33h9IMWderAb
         cld1UPApcweU0emxksx5ak1MImGnH2j5u2/O00jyQqnyyO+/p6j07vc6a6CGKq1In8Hh
         53uRgTBC7752d2vuSQxXW+z8LfvszkZlIGKto7FpygYGCQlMjx2KwNAxBu/gI7R0iASa
         Kou2BgDrpj6SIAwQqGE4LCpIDc+bUQfNo/u8CXpBvkhusgG98uDJsVcL0NaYKfDajNz9
         wg8DfVh7W/2HtLK6HYRbfpiltR8oE044OdQ7LOyTajBUnM3NQXNt9G6m/daRm3kmokwL
         5mlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzu3Nm35e9qYH1Gy4EDt1bN+ALZ14UN0AZQnLryhS5AWTMQ5jDoDs1iqXEC317nQQIvcnE=@vger.kernel.org
X-Gm-Message-State: AFuF++l+DdwCWtHeGf+QMztAlh7iq1bwHRMvVVGskHACDYE/ciImS5O4
	96Ndope7Y7M6BKGGt3Pb/jiiLzgMsIJNXqfidYoeV6DsgYYFgqQWqupZ
X-Gm-Gg: AYBFou1yJjgySPp91SgAyC1IMXGJa5nnox2BcEqrd5mFAdhIBTa2u6tQ4n7c1Okk9Vo
	wzIgUTIc1/Nl63H5emgtZ1n3ZR+hjJGf++XVv1JMeywG20RhzGh6KFnLY19xm3588SeTNXi2yB9
	gL30bxmAWbJNPJSa8OMg++ginj2nbXnMWUaNGopHJrmwSwb7qxvDecpiiHX04C8CcUUdSZG7VGd
	EwCu2//xTY9ZwWp0xWgzeSRIhMkC++25gWRLDvKj1eboaUTA+q9JE6gAtrtWPwBZChctQMPPjsU
	s3KN3KAy9goZaKIwbQxuYCyS9Bx+jsbyaD872vSMjEL93Kp8vRmIz39cTCk4faArvHt226oEpsn
	cfzhA6lYVVlktmBhmtmJuBbxHA7ggSgKVuJ2ISx/fgm7vbWNX5MiDEkdbKYToe+vIIIn0keqjBz
	AKWZ1jQzB9uHSCIs7CejhlL19O8XKi4RzXuH3gYCXJAgNJRs126pEsUNBkK/yTz08bzY5rvUcAe
	1PaY7h/PxncMUQFAYclTra/KpgRRI9cU4g54C3e3jk+77/eaFT+CAMxYXKdkHyel5g68sTINQ+r
	otI=
X-Received: by 2002:a05:6a20:9194:b0:3c3:a31b:3949 with SMTP id adf61e73a8af0-3de0e6754b3mr6600649637.11.1790370080711;
        Fri, 25 Sep 2026 14:01:20 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc796641d12sm926266a12.27.2026.09.25.14.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 14:01:20 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 21:01:19 +0000
Message-Id: <DLOP8435UV3A.3UMMJS0YE7SHX@gmail.com>
Cc: <eddyz87@gmail.com>, <john.fastabend@gmail.com>, <memxor@gmail.com>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 05/16] bpf: Cache the jump table of a
 subprogram during CFG discovery
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>
In-Reply-To: <20260925175244.1136329-6-daniel@iogearbox.net>
References: <20260925175244.1136329-1-daniel@iogearbox.net> <20260925175244.1136329-6-daniel@iogearbox.net>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 25, 2026 at 07:52 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> Subprograms removed as dead code free their table in
> adjust_subprog_starts_after_remove(), which also clears the slots that
> the compaction of subprog_info vacates, as they still hold copies of the
> moved entries and with them their table pointers.

can we free the tables right after bpf_compute_live_registers() ?
bpf_insn_successors() is the only reader and nothing calls it
after that point.
can be a follow up...

