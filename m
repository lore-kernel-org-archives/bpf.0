Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE962F0C7E
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354888; cv=none; b=TDdosuBbPefxC4/aO9A4l0GOaIDl6Z28PyMvUy06d/pl07B0+VoyZDdEhJIiBka8FivzKIpqEhcYeLSuqC2h7v2047mU13Ch2gQP195BYciD23WriVi6jaoxS2zHEnBNE57f6sfg41NOtQQ9jVa5FTkI1sq/DJcmYuayxp0HKCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354888; c=relaxed/simple;
	bh=Jwrpy88SKGLqMngPY+TS3fs1cIjaSMYnFiFylEJdSYI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mkrNYe/yEcCJkcd4tPYGYNe2yHmlaAHqwFCFsA9/I2jMopieOM8yTIuR6Ts/BGs70A6W0HZcNfYFj5B5oTsAc8b3dG2xeIUh3TjCsBA85nPB878OjGZ3esL8R3rbhXNuyeHhU9OCeU3Mx8DGHbQGoaTKGYprylGZ7b6nrNpOF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZF0z7v1w; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF0z7v1w"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35e576110adso583905a91.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 08:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776354886; x=1776959686; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1TGz5NmzlY6NRIhY4qnoNR57rDUO9xP9f7CcoBaN3Y=;
        b=ZF0z7v1wWcj5sQuxVyXBUP8NYnPDkfVbDUxV8lthWM7ZXijgZIy6XQ4y4ArdPS5cRz
         TegRFakK9OtQWyx9gjxC+DpvbrC4LN1Ppwor//WCC2vsynVPFnTN4zGxCfUMO2nb6PtC
         t2xSCdaYc0CopH7BpOXQKgL0OQ47PClmWq1CZQPPoaWBejuiqOdJWNwgi9K2n/f9Fkf9
         aOMy0PxDP5YHCr0so6NtTzbT5RjeaC2qWpZUmxRr5efaKMovzI+ZdQw7CkAA/sKVfqFQ
         0PhdE/ujn9nAlWhlysXedLngOn+LrNF5QXxtVq3d537RZkW293UAvy/LyMinUYK4uc7r
         vgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776354886; x=1776959686;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1TGz5NmzlY6NRIhY4qnoNR57rDUO9xP9f7CcoBaN3Y=;
        b=tHVhxx/ww/ELgsssFEMZb92b8c+DYYJNIklu0U0JVlsd8rDZFeIKvLaBjNiNpEZfTT
         NzqBnFOGn2hlalGYv0pbUrv/eJ0cwAGx1d++/ZTxonEIlv/pDV46LoJzo6IF53cD4aTP
         P/vaqx8u+Eetb+2BvxepT3X2Ib+XhLUDYeFsSAyeDD5nYMTiwE/vadF8dhG2/a8iInAI
         V+yhb2IKwSPktBUZZvTFmMzYCfLjnKH4Lg5xLySsm9cAl9MJ/+hb3/JGMeZt4OEuAClX
         hHyFC4DZyMeh3Gf2+NXB4uVKHo10UWJP5+FA0joFFuEyxqw7oS0+Tt8UC5fKQxlY7Zwc
         8gew==
X-Forwarded-Encrypted: i=1; AFNElJ8zq+2uuEYmAjJpHrUzl8/cOou09EO6PLhmm2VYUMbU/wmS418N1q7ggK4JbvCN+LxIR9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj7KRiQx9AfA9iECb5yhkYN4UMpsL35eQnlOO5c/goVfNcdjNY
	f6g38oXK+86/NFuTLQZH3EydFPVR1n56vdYwvB95HeZwU8saR87DAgdW
X-Gm-Gg: AeBDiesBcEtNT0ha28BP72Yh8KIu5hWsQrUqPkqrssSWld5VBloZN0cef+rPHoNNS2I
	5/kIejvA5sUJSckXoYyndSJdZXAvbom+5v+0ZgYK84SSuvPUGnrwnw8ILwrHBTBeZpC2c/W7DWJ
	7v6/GdKpBWaMxIHQNefS3sYGJ+IYbD7D9244w+p9Bn8J9cdJ6p3Rzm+/Fv/F2xlxNtD1+d01DA+
	HgkccOe9u6cEwWb1d1xw9/T5y6bAsh16bOt8WfLYLF40JgbtM0aTbSgW9Gj2XrjdzCSwMECGXB4
	kMRPSZG/njdCxe2Hj1tUlftJIuJ+SCi3HL6xl554tHQdXK6vtGp/Jc6idBtQDwUMbrD189T9Ub4
	wzav6CXye4+9GtqVAgvKT54Yniih1QznshlIUTC3JtPrFq9mO4/6AuC4Xh95YBsUu+t51ahgjj8
	S3MJFuDl75ooZDoCvJDTfpN0JArVXfS7vcRuNjp4dTRHd/W5dAvAOEvH83tl7or2gpEu3+Xgv1b
	2KwqqLdhXeHktvL5VU7sZybuVEK4esdHAC70u877Yl+7XusXYMxt2LZ
X-Received: by 2002:a17:90b:190:b0:35c:1d65:7867 with SMTP id 98e67ed59e1d1-3612f34b866mr2829343a91.15.1776354886251;
        Thu, 16 Apr 2026 08:54:46 -0700 (PDT)
Received: from localhost ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613d9643a8sm30173a91.0.2026.04.16.08.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 08:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 08:54:44 -0700
Message-Id: <DHUP94GVGZLS.WJ5WXWJND110@gmail.com>
Cc: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <qmo@kernel.org>, <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 1/8] bpf: Extend BTF UAPI vlen, kinds to use
 unused bits
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260416143904.1220662-1-alan.maguire@oracle.com>
 <20260416143904.1220662-2-alan.maguire@oracle.com>
In-Reply-To: <20260416143904.1220662-2-alan.maguire@oracle.com>

On Thu Apr 16, 2026 at 7:38 AM PDT, Alan Maguire wrote:
> (not used) kind.  Provide backwards-compatible macros just in
> case.

...

> +/*
> + * Macros needed for backwards compatibility; enum above ensures values
> + * make it into BTF.
> + */
> +#define BTF_MAX_TYPE		BTF_MAX_TYPE
> +#define BTF_MAX_NAME_OFFSET	BTF_MAX_NAME_OFFSET
> +#define BTF_MAX_VLEN		BTF_MAX_VLEN

let's not. Ignore bots.
