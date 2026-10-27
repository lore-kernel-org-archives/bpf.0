Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119176;
	b=AARaWuN4h9ZJqHy48DE55FVJ84NypcJWcz1DBFji4Dni6gzGk6AYddf0Z4KOcAzL3aYD
	 6oq/t8V4SurRDL5Cb0aHK888N1ECcp5a315eO5Gbk+rOaNJ4nFm1rPs9Sl+WHIY9FfLlC
	 ItDg6q7pmJXEYXBJxE0wSCJofwyI/iXv/XIo4EHP51C6zeU5R61sMBsQtL9+dVVct5goO
	 vtdubta6k3eLwPLk4uWEJc+/Cil+i6iPKPSeNgO9g5FDrbLdba4yG8mYrf9a5ZUJGEYgi
	 2m44w1sPyms5Y4J+JEYj+6NSPy7mypoPY6RZhQdGIqpnrdE0uHJot7cIhgP3oFEugTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FlQacIGrkdN6EctnfohVokyLeWtXLlDdDgCp7WsFXoM=;
	b=5Qi0AwtxrdoFFUWj6YT7ySuou8VlMp97V3CKUqH0LTs/yPTiA1Kdxf9+xcHrnCznWeGw
	 cgEfY9AdidCMqoEuG80KM0nNpNKtiRWqz4u9p4+H7NUEHGj87bzzNDk1HHccjaYVpyZrV
	 9oIoxdY+OS1CtI2wqAVWLI4D1kCmG2kcxa0iK5fN6RfvmgL8jvNU5kS2MRJRKfncjXiZp
	 YFqYcUHor+q7LXzpeE0tsFRj0xlKxFt39//zT650UG8F5q5uxrXNs1+yYiNLFIAPz4LOD
	 /aYuykvaUBgoTZWKiOb/WVcGwRK6Vv7hUbzJ5H4Gk9OrgpYedq4X/iBYViHcwNxY/Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EsqsuO7K;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810B6606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 810B6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EsqsuO7K
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdab938dc83so67479a12.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119176; x=1793723976; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FlQacIGrkdN6EctnfohVokyLeWtXLlDdDgCp7WsFXoM=;
        b=EsqsuO7KpeD1hN3XNy6HweTJC7IGyCw3PGTWqulGjYZuAJRXNZ0aOcWOPN2IgSFjEr
         fV6RLvQZLql+9M/EWegK57P1cFvLGkawWZKxrXfj13nPee7zZMqqp+Zja4kbLJJQGph1
         c9UTHNlxNwsm4QHd2tMjCVqGzsgMVlOJ1PULAiC9BDb6YXNWcSigY9medKM/dreD1Xoa
         Qss2OBsgaLJ0fAYzMDSns0RzosRQOcpQr23tylx7ybxzRoRyRTpN3NNW6zNSBudpTUuV
         Z4RLIiWICkKho1VkyefLGQeeSRLHJ+sxnnuUfgzrUSex9jIQANtFMkSP8cDzF3dqXCY9
         jYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119176; x=1793723976;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FlQacIGrkdN6EctnfohVokyLeWtXLlDdDgCp7WsFXoM=;
        b=Upsgm0ma5pVUIZqp4oNLlB2sDROaSqpGBaTAAa5ZFqf5joDAW5rq86qRZ9MeoYhuug
         EMddE03qzkFjmZRwN2imhqLAV20xF2wZRkh98fxtLv5dSNxJRxteIGZOgI7i3E5XxVsU
         029sJimeDkXEC5m2dshhRDCyQGTa2cu+qlPK1b1kNlirCP6dtlnRhfBzVyz6Z/j5t4z1
         pXZ8ovch6yreUZnKOkXtF6X2nLPg3qG8ydKTTuRNQi8BA97cdAYoR0NDU7DZAFzTlI60
         DakDGD1wlB8OeWFMRZInQrSVL4Upwj0jnYGrJY4p7Pkm4UzYjDDjIN6C/J5HdF8gchzt
         xnJA==
X-Gm-Message-State: AFq9FYLvUzqYbD+gjI6mjBX5wcGm9f6CKEZY1t7GqR793FOBfSHGeH+A
	jqIh1GfIf3z4zs7YckkS0Ef9Thh8A0OkyVY7hCKe8vzVi3HeGLTAKFmv6Awfkw==
X-Gm-Gg: AYBFou1FzlUmAITlw+LZACtjy+JOsGy4Urn31RlVQlHNZe1tiuf6fNjAkKYxqdufPBr
	mdIGdtkeGOc1s7bAHzz5wfH0vNYkYNXe2wmF8mroaFCNnjIPlDqREuSNT3MCrTysf3T+VvLdpOm
	+TGRmiWuK2xGKUlbSlXbXiK2CpC2OW/nOnsJcwYHpOzxwdNumhZBQlqTotqh7JTxGb6j6wyuxa0
	f/YvgSF9Q25yNhjUpL+X5TQq8/ASqnKVpn3P1SfR/Nibh9Wn00V922GO0ZTZCLHIK4RX958YFgT
	FFe4pA9i7Nx+OeMGyhyCwzJyNu0K4nWgRo9zhnYVIWqlQSNQ0QtfMeDj6Z1is0tGp+tHlVfer9H
	JbC0F5C70jQW4I2joyUvgukFAvS5nRqbH+5qvf4C7cB+PQ4Jr7udJKMnZVzvaHbqDM4blJneRRb
	LowC0GmoxuajpP5WVURbAx+0mPPqO61V6KEpdEnRZH3MFXE/+iOLnJVjdlYLADrCT6SabFN2nnx
	j1okoAXfb1e1queRBgcDzg/2T3cl9u5WPbXlvbeZ7gbcuIm8VPvpEbN11r+idoI19A2kpFQF9T+
	KPeYV3uh+csnKifKRYMMz9HPhl1QKKq7Ssy4kS/qfehgO9Y+oonm3SWC+6kv
X-Received: by 2002:a17:90b:2745:b0:3ab:b39f:41cd with SMTP id 98e67ed59e1d1-3adeafaeb42mr8456140a91.60.1793119175691;
        Tue, 27 Oct 2026 09:39:35 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9ea8asm12504955ad.66.2026.10.27.09.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 09:39:35 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 16:39:34 +0000
Message-Id: <DMFRP4XET7DK.219K64N6DJR8M@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>
Subject: Re: [PATCH bpf 07/81] bpf: One time slice of may_goto for a run of
 a prog
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
In-Reply-To: <CAP01T76T5qLDHd8jMx69_+hcj2vCZt+W6+UsGGqdaRJ0BpwTHA@mail.gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com> <20261026025943.404450-8-alexei.starovoitov@gmail.com> <CAP01T76T5qLDHd8jMx69_+hcj2vCZt+W6+UsGGqdaRJ0BpwTHA@mail.gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Mon, Oct 26, 2026 at 10:35 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>> Limitations:
>>  - A second run of the same prog on the same cpu, in an interrupt or after
>>    preemption, starts the time slice again. The timestamp in the frame
>>    continues to limit each frame to 250 ms.
>>  - The JIT must support a stack walk and per-cpu insns. x86-64 with ORC,
>>    arm64 and powerpc64 do. Nothing changes on riscv, loongarch and s390.
>>  - Nothing changes for extension progs. They cannot find the start of a
>>    run.

[...]

> Why not copy the state from the caller's frame into the callee iff it
> uses may_goto? At least it will work correctly without various holes
> listed here in the limitations.

Because of callbacks. The caller of cb is C code. There is no bpf frame to
copy from.

Direct calls are hard too. Would need some hidden arg to be passed,
so that callee knows where to copy from.

We've been sitting on this issue for long time. I felt we have to
close this hole now and improve later if we can think of a better way.
