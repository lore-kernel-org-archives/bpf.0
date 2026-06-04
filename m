Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4833C4B8A
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602918; cv=none; b=Vp5Qmpe01DOmMyhwkvy+hoQKqjO+gDUKAvTNvVg6CzIt+BcN9K48sQUWcgJ1vzVhhedUwTl/vKOLwY8Hv3JzxJykbN9herMdSaO2Fb3Ev6gtHbqZxJp7iJNuIFZS+YTSxXpS4MId2S6lJqyXX0Iq0v3IYG8I8LuXlz4NNONCyr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602918; c=relaxed/simple;
	bh=WjbGDdDqN5AG7eA0ajoVxG8Mg8759NEiePhlYHNjXoQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=B9ZLNuub/dRkZnGkFj1iNC/4X+zjkkfGt8H9dVVKSUHB0yWfXmjmg1cDliXBba99sdMkbooBrgDftBoROlolHs/eyfuAWljsnQmF3ELCBeR4aRKc82HSZYeZ0sTj+SURD0aNliEyF0V8c8SJUqedwJFw8uy1zB9sUvz8M+JJQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErHZcXra; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErHZcXra"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so1493879f8f.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 12:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780602915; x=1781207715; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjbGDdDqN5AG7eA0ajoVxG8Mg8759NEiePhlYHNjXoQ=;
        b=ErHZcXraiF4Df3St5bLxmBKg0eCGtKUam6aqgCw2ke4KYxWTuchZpgIxvuMmoRpOa5
         NXVPWn87+SU3hdvtuA85C+IhD8qdyxJlUeEEgCTC96FtKAHh7lqsgRXc97K66zxvJIco
         T2NB+CDht4T2g248yVD8GYyCtJ+LdDTF79z/wu2I6qFKZq5AqHMSzmCMrvdUc+ovzgke
         fwRC5fxdF43+nt3+myPHLX39INRcvY5do7kTPV+2xgniTSMo+DU9Jcsvu5m46m4mxOKl
         XRKd5TpHvzCFnKftLxYaVArbTs59yh/YLD6iIX+2zce9hKUTyrCB+/o2ndjysxue4eZ1
         if4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602915; x=1781207715;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WjbGDdDqN5AG7eA0ajoVxG8Mg8759NEiePhlYHNjXoQ=;
        b=BVglRDgJqnTsRdfxcfRmJq9j5GUpG1rqWAdMMiasRt+o1wcfP/x0XS6JI9H/xWpP51
         YBNEqXqJEDBu1HsYAFSg18Vt4n23JlHR1hB4HjS4SI9DCtRR1YdHV5ybK0fQ7YGSBFmH
         cdTQDmZfAUgwT4JBEL9uSE/84jALJXgPx5hY+eeMrxfys6/33LF1Ox9HxnLTNBBb5ZGw
         8Bv/bAGgSw65Pj9N6nc6iYg+6ZfL9iZ6PPGUav+aw1JEcqr1rDWWiWRkqs9PpocKrrNk
         BdtvxYi6eG520SUwc2sXEQotfLgBoQponLBqfgvgvhK5q8GsaFX2Kyh1kmZv70ZNOaZQ
         dYZg==
X-Forwarded-Encrypted: i=1; AFNElJ+dJtq1rz/O5baWvLJjqrjzTz98omRMUs23Vs/ACjBzFQ1KptB2DVBn8GKx8rPciSWVfbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08m9z9Chqo4nauFBkdxYKn0ck7wJxeFRnWZ5rXWrVc9PNoLJI
	nFDl/JL3BF3P/E+X35y5wBHH2zrwnXu+uI3lRKhEaeVlQgzD/OwqbXSm
X-Gm-Gg: Acq92OHIw5Jm9OKrDhCMfs8AWuxUX8u2ZDSQcTAeSwfszyF1UXcnbDqrJoYvpEkC/P2
	8wVjR/AOykPL7NCi/WcYptNDjgagg8vvooD0Xs6cXXW7EID1SUafYtNotsjH2DT6+dfUolXeAZY
	XXE1BIkVD7uACrUma/fSs5J/IsRIqTdJ8Vqsik0pfxep8mBbNEpSA4PzfSgrpbfin1Xfkb7KQHV
	GLzlzmXuDwvkEDy+FPbaibX7fUrdZsLhj1waxp3T1+hEWjuOlV6FaLa7u5/ANmWjLuPLkFd9WvF
	H6GfcvS0yH/uW8jXyCnXHhpRRoaCFChBeLUyr+rCMGwz+n8O8OiqB3D8hgUr3p4gx0ZLoT1L5Q5
	symFDsN7E8QYqrNRBcLneh/WLEa5gAybQtGMlXwM9O055OxBSo/sIMBfm+Bp0tHxuM2qYw+pSxj
	Kvxa/WK358ErfpJ3B/v5Je9ULpgCwBNboYW3J5krrLXozuSyiKvuVwNldNKnR6I5nblnwCtnwdg
	OBmkF5oispinKuzOeDMXvQjSQG7uTMu0N+/2fp9CHThAs+QPHro9aRALLTqiy2TTu9XEmcRZDpr
	NldbQNlZRh4=
X-Received: by 2002:a05:6000:703:b0:460:133f:2a4e with SMTP id ffacd0b85a97d-46027317db6mr8354716f8f.13.1780602915413;
        Thu, 04 Jun 2026 12:55:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35133csm19010788f8f.25.2026.06.04.12.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 21:55:14 +0200
Message-Id: <DJ0J1YFMQFHV.28WTKWIIUZSX3@gmail.com>
Subject: Re: [PATCH bpf-next] MAINTAINERS: BPF: Add self as reviewer and run
 parse_maintainers.pl
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260604184252.9917-1-emil@etsalapatis.com>
In-Reply-To: <20260604184252.9917-1-emil@etsalapatis.com>

On Thu Jun 4, 2026 at 8:42 PM CEST, Emil Tsalapatis wrote:
> Add myself as a reviewer for the BPF subsystem. While at it, run
> ./scripts/parse_maintainers.pl --order and reorder the BPF-related
> entries in the file accordingly.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
